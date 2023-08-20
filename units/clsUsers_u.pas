unit clsUsers_u;

interface

uses Hash, SysUtils, Generics.Collections, Vcl.Dialogs, System.JSON;

type
  { EXCEPTIONS }
  ENoClass = class(Exception);
  ENoTeacher = class(Exception);
  ENoStudent = class(Exception);
  EPasswordError = class(Exception);

  { Records }
  TUser = record
    LoginID: String;
    Username: String;

    ID: String;
    Name: String;
    Surname: String;
    changePass: boolean;

    case Teacher: boolean of
      True:
        (Admin: boolean);
  end;

  TStudent = record
    ID: String;
    Name: String;
    Surname: String;
  end;

  { Classes }
  TUserStudent = class
  private
    fUserData: TUser;
    fClassID: String;
    fTeacher: String;
  public
    constructor Create(uUser: TUser);

    function GetGrade: integer;
    function GetID: String;
    function GetName: String;
    function GetSurname: String;
    function GetTeacher: String;

    function toString: String;
  end;

  TClass = class
  private
    fClassID: String;
    fStudents: TDictionary<String, TStudent>;
    fGrade: integer;
    fSize: integer;
  public
    constructor Create(sTeacherID: string);
    function GetGrade: integer;
    function GetSize: integer;
  end;

  TUserTeacher = class
  private
    fUserData: TUser;
    fClass: TClass;
  public
    constructor Create(uUser: TUser);
    function GetClassID: String;
    function GetAdmin: boolean;
    function toString: String;
  end;

  { Other functions }
  // Passwords
procedure changePass(sPass: String; sLoginID: String);
procedure RequestPassChange(sLoginID: String);
function Encrypt(sInput: String): String;
function Decrypt(sInput: String): String;
function PrepPassword(sPassword, sSalt: String): String;
function GenSalt(iLength: integer): String;

// Previous User
procedure SaveLogin(sUsername, sPassword: String);
function CheckPrev: boolean;
procedure LogOut;

// Login
function Login(sUsername, sPassword: String): TUser;
function AddLogin(sUsername: String): String;
function LoginExists(sUsername: String): boolean;

// Student
function FindStudent(sStudentID: String): String; overload;
function FindStudent(sFirstname, sSurname: String): String; overload;
procedure DeleteStudent(sStudentID: String);
function FindStudentLogin(sFirstname, sSurname: String): String;
function AddStudent(sFirstname, sSurname: String): TDictionary<String, String>;
procedure AddToClass(sStudentID, sClassID: String);

// Teacher
function FindTeacher(sTeacherID: String): String; overload;
function FindTeacher(sFirstname, sSurname: String): String; overload;
function FindTeacherLogin(sFirstname, sSurname: String): String;
function AddTeacher(sFirstname, sSurname: String; bAdmin: boolean)
  : TDictionary<String, String>;

// Class
function FindClass(sTeacherID: String): String;
procedure AddClass(sTeacherID: String; iGrade: integer);

implementation

uses dmRecycle_u, frmLogin_u, frmStart_u, frmChangePass_u;

{ Password }
{$REGION$ Password}

function GenSalt(iLength: integer): String;
var
  sSalt: String;
  I: integer;
begin
  Randomize;
  for I := 1 to iLength do
  begin
    sSalt := sSalt + Chr(Random(122 - 97) + 97);
  end;

  Result := sSalt;
end;

procedure RequestPassChange(sLoginID: String);
begin
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text := 'UPDATE Login SET ChangePass =:CHANGEPASS WHERE ID =:LOGINID';
    Parameters.ParamByName('CHANGEPASS').Value := True;
    Parameters.ParamByName('LOGINID').Value := sLoginID;
    ExecSQL;
  end;
end;

procedure changePass(sPass: String; sLoginID: String);
var
  sIn: String;
  sSalt: String;
begin
  sSalt := GenSalt(4);

  sIn := PrepPassword(sPass, sSalt);

  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Add('UPDATE Login SET ');
    SQL.Add('Password=' + QuotedStr(sIn));
    SQL.Add(', Salt=' + QuotedStr(sSalt));
    SQL.Add(', ChangePass=' + False.toString());
    SQL.Add(' WHERE ID = ' + QuotedStr(sLoginID));

    ExecSQL;

  end;

end;

function Encrypt(sInput: String): String;
var
  cChar: char;
  sOut: String;
begin
  sOut := '';
  for cChar in sInput do
  begin
    sOut := sOut + Chr(ord(cChar) + 7);
  end;

  Result := sOut;

end;

function Decrypt(sInput: String): String;
var
  cChar: char;
  sOut: String;
begin
  sOut := '';
  sInput := sInput.Replace('"', '');
  for cChar in sInput do
  begin
    sOut := sOut + Chr(ord(cChar) - 7);
  end;
  Result := sOut;

end;

function PrepPassword(sPassword, sSalt: String): String;
var
  sPrep: String;
begin
  sPrep := sSalt + sPassword + sSalt;

  sPrep := THashSHA2.GetHashString(sPrep, THashSHA2.TSHA2Version.SHA512);

  Result := sPrep;
end;

{$ENDREGION$ Password}
{ Previous User }
{$REGION Previous User }

procedure LogOut;
var
  tPrev: TextFile;
begin
  AssignFile(tPrev, './data/prev.json');
  Rewrite(tPrev);
  Write(tPrev, '{"username":"","password":"","loggedIn":false}');
  closeFile(tPrev);
end;

procedure SaveLogin(sUsername, sPassword: String);
var
  objJson: TJSONObject;
  tPrev: TextFile;
begin
  objJson := TJSONObject.Create;

  sPassword := Encrypt(sPassword);
  with objJson do
  begin
    AddPair(TJSONPair.Create(TJSONString.Create('username'),
      TJSONString.Create(sUsername)));
    AddPair(TJSONPair.Create(TJSONString.Create('password'),
      TJSONString.Create(sPassword)));
    AddPair(TJSONPair.Create(TJSONString.Create('loggedIn'),
      TJSONBool.Create(True)));
  end;

  AssignFile(tPrev, './data/prev.json');
  Rewrite(tPrev);
  Write(tPrev, objJson.toString);
  closeFile(tPrev);

end;

function CheckPrev: boolean;
var
  objUser: TUser;
  tPrev: TextFile;
  sLines, sLine: String;
  objJson: TJSONObject;
  bLoggedIn: boolean;
  sPass: string;
begin
  // Get data from prev.json
  AssignFile(tPrev, './data/prev.json');
  try
    Reset(tPrev);
  except
    on E: EFileNotFoundException do
    begin
      Rewrite(tPrev, './data/prev.json');
      closeFile(tPrev);
      Reset(tPrev);
    end;
  end;
  sLines := '';
  while not Eof(tPrev) do
  begin
    Readln(tPrev, sLine);
    sLines := sLines + sLine;
  end;
  closeFile(tPrev);

  // Json stuff
  objJson := nil;
  try
    objJson := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(sLines), 0)
      as TJSONObject;

    bLoggedIn := objJson.GetValue('loggedIn').AsType<boolean>;
    if bLoggedIn then
    begin
      sPass := objJson.GetValue('password').toString;
      sPass := Decrypt(sPass);

      try
        objUser := Login(objJson.GetValue('username').toString.Replace('"',
          ''), sPass);
      Except
        Result := False;
        EXIT;
      end;

    end
  finally

    objJson.Free;
  end;

  if bLoggedIn then
  begin

    if objUser.changePass then
    begin
      frmChangePass.ChangePassword(objUser.LoginID);
    end;

    if objUser.Teacher then
    begin
      frmStart.LoginTeacher(objUser);
    end
    else
    begin
      frmStart.LoginStudent(objUser);
    end;
  end;

  Result := bLoggedIn;

end;

{$ENDREGION Previous User }
{ Class }
{$REGION Class}

procedure AddClass(sTeacherID: String; iGrade: integer);
var
  sUUid: String;
  uuid: TGUID;
begin

  CreateGUID(uuid);
  sUUid := uuid.toString;
  sUUid := sUUid.Replace('{', '');
  sUUid := sUUid.Replace('}', '');

  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text := 'INSERT INTO CLASS VALUES (:ID , :Grade ,:TEACHERID )';
    with Parameters do
    begin
      ParamByName('ID').Value := sUUid;
      ParamByName('Grade').Value := iGrade;
      ParamByName('TEACHERID').Value := sTeacherID;
    end;

    ExecSQL;
  end;

end;

function FindClass(sTeacherID: String): String;
begin
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Class WHERE Teacher_ID =:sTeacherID';
    Parameters.ParamByName('sTeacherID').Value := sTeacherID;

    Active := True;

    if RecordCount <> 0 then
    begin
      Result := FieldByName('ID').AsString;
      EXIT;
    end
    else
    begin
      raise ENoClass.Create('Class not found');
    end;
  end;
end;

{$ENDREGION Class}
{ Teacher }
{$REGION Teacher}

function AddTeacher(sFirstname, sSurname: String; bAdmin: boolean)
  : TDictionary<String, String>;
var
  sUsername, sLoginID, sUUid: String;
  iAtempts: integer;
  uuid: TGUID;
  dictTeacher: TDictionary<String, String>;
  bComplete: boolean;
begin
  // uuid
  CreateGUID(uuid);
  sUUid := uuid.toString;
  sUUid := sUUid.Replace('{', '');
  sUUid := sUUid.Replace('}', '');

  dictTeacher := TDictionary<String, String>.Create;

  iAtempts := 0;
  // Username
  bComplete := False;
  while not bComplete do
  begin
    bComplete := True;
    if iAtempts = 0 then
    begin
      sUsername := sFirstname[1] + sSurname;
    end
    else
    begin
      sUsername := Format('%s%s%.*d', [sFirstname[1], sSurname, 3, iAtempts]);
    end;

    sUsername := sUsername.Replace(' ', '');
    sUsername := sUsername.ToLower;

    if LoginExists(sUsername) then
    begin
      Inc(iAtempts);
      bComplete := False;
    end;
  end;

  sLoginID := AddLogin(sUsername);

  // Add to DB
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text :=
      'INSERT INTO Teacher (ID, Teacher_Name, Teacher_Surname, Login_ID, Admin) VALUES (:ID ,:FIRSTNAME ,:SURNAME ,:LOGINID ,:ADMIN)';
    with Parameters do
    begin
      ParamByName('ID').Value := sUUid;
      ParamByName('FIRSTNAME').Value := sFirstname;
      ParamByName('SURNAME').Value := sSurname;
      ParamByName('LOGINID').Value := sLoginID;
      ParamByName('ADMIN').Value := bAdmin;
    end;
    ExecSQL;
  end;

  dictTeacher.Add('Username', sUsername);
  dictTeacher.Add('ID', sUUid);
  Result := dictTeacher;

end;

function FindTeacherLogin(sFirstname, sSurname: String): String;
begin
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text :=
      'SELECT Login_ID FROM Teacher WHERE Teacher_Name =:FIRSTNAME AND Teacher_Surname =:SURNAME';
    Parameters.ParamByName('FIRSTNAME').Value := sFirstname;
    Parameters.ParamByName('SURNAME').Value := sSurname;

    Active := True;

    if RecordCount = 0 then
    begin
      raise ENoTeacher.Create('Teacher not found');
    end;

    Result := FieldByName('Login_ID').AsString;
  end;
end;

function FindTeacher(sFirstname, sSurname: String): String; overload;
begin
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text :=
      'SELECT ID FROM Teacher WHERE (Teacher_Name =:FIRSTNAME) AND (Teacher_Surname =:SURNAME)';
    Parameters.ParamByName('FIRSTNAME').Value := sFirstname;
    Parameters.ParamByName('SURNAME').Value := sSurname;

    Active := True;

    if RecordCount = 0 then
    begin
      raise ENoTeacher.Create('Teacher not found');
    end;

    Result := FieldByName('ID').AsString;

  end;
end;

function FindTeacher(sTeacherID: String): String;
begin
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text :=
      'SELECT Teacher_Name, Teacher_Surname FROM Student WHERE ID =:TEACHERID';
    Parameters.ParamByName('TEACHERID').Value := sTeacherID;

    Active := True;

    if RecordCount = 0 then
    begin
      raise ENoTeacher.Create('Teacher not found');
    end;

    Result := FieldByName('Teacher_Name').AsString + ' ' +
      FieldByName('Teacher_Surname').AsString;
  end;
end;

{$ENDREGION Teacher}
{ Student }
{$REGION Student}

procedure AddToClass(sStudentID, sClassID: String);
var
  uuid: TGUID;
  sUUid: String;
begin
  // UUID
  CreateGUID(uuid);
  sUUid := uuid.toString;
  sUUid := sUUid.Replace('{', '');
  sUUid := sUUid.Replace('}', '');

  // Insert into DB
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text :=
      'INSERT INTO ClassList (ID, Class_Id, Student_ID) VALUES (:ID ,:CLASSID ,:STUDENTID )';
    with Parameters do
    begin
      ParamByName('ID').Value := sUUid;
      ParamByName('CLASSID').Value := sClassID;
      ParamByName('STUDENTID').Value := sStudentID;
    end;

    ExecSQL;
  end;

end;

function AddStudent(sFirstname, sSurname: String): TDictionary<String, String>;
var
  sUsername, sLoginID, sUUid: String;
  iAtempts: integer;
  uuid: TGUID;
  dictOut: TDictionary<String, String>;
  bComplete: boolean;
begin
  // uuid
  CreateGUID(uuid);
  sUUid := uuid.toString;
  sUUid := sUUid.Replace('{', '');
  sUUid := sUUid.Replace('}', '');

  iAtempts := 0;

  dictOut := TDictionary<String, String>.Create;
  bComplete := False;
  while not bComplete do
  begin
    bComplete := True;
    // Username gen
    if iAtempts = 0 then
    begin
      sUsername := sFirstname + '.' + sSurname;
    end
    else
    begin
      sUsername := Format('%s.%s%.*d', [sFirstname, sSurname, 3, iAtempts]);
    end;

    sUsername := sUsername.Replace(' ', '');
    sUsername := sUsername.ToLower;

    if LoginExists(sUsername) then
    begin
      Inc(iAtempts);
      bComplete := False;
    end;
  end;

  sLoginID := AddLogin(sUsername);

  // add to db
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text :=
      'INSERT INTO Student (ID, Student_Name, Student_Surname, Login_ID) VALUES (:ID ,:FIRSTNAME ,:SURNAME ,:LOGINID)';
    with Parameters do
    begin
      ParamByName('ID').Value := sUUid;
      ParamByName('FIRSTNAME').Value := sFirstname;
      ParamByName('SURNAME').Value := sSurname;
      ParamByName('LOGINID').Value := sLoginID;
    end;
    ExecSQL;
  end;

  dictOut.Add('Username', sUsername);
  dictOut.Add('ID', sUUid);

  Result := dictOut;

end;

function FindStudentLogin(sFirstname, sSurname: String): String;
begin
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text :=
      'SELECT Login_ID FROM Student WHERE Student_Name =:FIRSTNAME AND Student_Surname =:SURNAME';
    Parameters.ParamByName('FIRSTNAME').Value := sFirstname;
    Parameters.ParamByName('SURNAME').Value := sSurname;

    Active := True;

    Result := FieldByName('Login_ID').AsString;
  end;
end;

procedure DeleteStudent(sStudentID: String);
var
  sLoginID: String;
begin

  // GET LOGIN ID
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT Login_ID FROM Student WHERE ID =:SID';
    Parameters.ParamByName('sID').Value := sStudentID;

    Active := True;

    sLoginID := FieldByName('Login_ID').AsString;

  end;
  // DELETING
  with dmRecycle.qryRecycle do
  begin
    // Delete student
    Active := False;
    SQL.Clear;

    SQL.Text := 'DELETE FROM Student WHERE (ID =:SID )';
    Parameters.ParamByName('SID').Value := sStudentID;

    ExecSQL;

    // Delete Login Info
    Active := False;
    SQL.Clear;

    SQL.Text := 'DELETE FROM Login WHERE (ID =:SID )';
    Parameters.ParamByName('SID').Value := sLoginID;

    ExecSQL;

    // Delete From ClassList
    Active := False;
    SQL.Clear;

    SQL.Text := 'DELETE FROM ClassList WHERE (Student_ID =:SID )';
    Parameters.ParamByName('SID').Value := sStudentID;

    ExecSQL;

  end;
end;

function FindStudent(sFirstname, sSurname: String): String;
begin
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text :=
      'SELECT ID FROM Student WHERE (Student_Name =:FIRSTNAME) AND (Student_Surname =:SURNAME)';
    Parameters.ParamByName('FIRSTNAME').Value := sFirstname;
    Parameters.ParamByName('SURNAME').Value := sSurname;

    Active := True;

    if RecordCount <> 0 then
    begin
      Result := FieldByName('ID').AsString;
      EXIT;
    end
    else
    begin
      raise Exception.Create('Student not found');
    end;

  end;
end;

function FindStudent(sStudentID: String): String;
begin
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text :=
      'SELECT Student_Name, Student_Surname FROM Student WHERE ID =:STUDENTID';
    Parameters.ParamByName('STUDENTID').Value := sStudentID;

    Active := True;

    Result := FieldByName('Student_Name').AsString + ' ' +
      FieldByName('Student_Surname').AsString;
  end;
end;

{$ENDREGION Student}
{ Login }
{$REGION Login}

function LoginExists(sUsername: String): boolean;
begin
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text := 'SELECT * FROM Login WHERE Username =:USERNAME';
    Parameters.ParamByName('USERNAME').Value := sUsername;
    Active := True;

    if RecordCount = 0 then
    begin
      Result := False;
    end
    else
      Result := True;

  end;
end;

function AddLogin(sUsername: String): String;
const
  DEFUALTPASSWORD = 'T4mpP@ssw0rd';
var
  uuid: TGUID;
  sUUid, sSalt, sPassword: String;
begin
  // Creation of uuid
  CreateGUID(uuid);
  sUUid := uuid.toString;
  sUUid := sUUid.Replace('{', '');
  sUUid := sUUid.Replace('}', '');

  // Password
  sSalt := GenSalt(4);
  sPassword := PrepPassword(DEFUALTPASSWORD, sSalt);

  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text :=
      'INSERT INTO Login VALUES (:ID, :USERNAME, :PASSWORD, :SALT, :CHANGEPASS)';
    with Parameters do
    begin
      ParamByName('ID').Value := sUUid;
      ParamByName('USERNAME').Value := sUsername;
      ParamByName('PASSWORD').Value := sPassword;
      ParamByName('SALT').Value := sSalt;
      ParamByName('CHANGEPASS').Value := True;
    end;

    ExecSQL;
  end;

  Result := sUUid;
end;

function Login(sUsername, sPassword: String): TUser;
var
  objUser: TUser;
  sPass, sSalt, sPrep: String;
begin

  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Login WHERE Username =:sUsername';
    Parameters.ParamByName('sUsername').Value := sUsername;

    ExecSQL;
    Active := True;

    objUser.LoginID := dmRecycle.qryRecycle.FieldByName('ID').AsString;
    objUser.Username := dmRecycle.qryRecycle.FieldByName('Username').AsString;
    objUser.changePass := dmRecycle.qryRecycle.FieldByName('ChangePass')
      .AsBoolean;

    sPass := dmRecycle.qryRecycle.FieldByName('Password').AsString;
    sSalt := dmRecycle.qryRecycle.FieldByName('Salt').AsString;

    // making sure usernames match case sensitivty
    if not(sUsername = objUser.Username) then
    begin
      raise Exception.Create('No Users with that USername in DB');
    end;

    // check if hashed password matches
    sPrep := PrepPassword(sPassword, sSalt);

    if not(sPass = sPrep) then
    begin
      raise Exception.Create('password fail');
    end;

    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Teacher WHERE Login_ID =:LoginID';
    Parameters.ParamByName('LoginID').Value := objUser.LoginID;

    ExecSQL;
    Active := True;

    // In Teacher's Table
    if RecordCount <> 0 then
    begin

      with objUser do
      begin
        Teacher := True;
        ID := FieldByName('ID').AsString;
        Name := FieldByName('Teacher_Name').AsString;
        Surname := FieldByName('Teacher_Surname').AsString;
        Admin := FieldByName('Admin').AsBoolean;
      end;

      Result := objUser;

      EXIT;
    end;

    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Student WHERE Login_ID =:LoginID';
    Parameters.ParamByName('LoginID').Value := objUser.LoginID;

    ExecSQL;
    Active := True;

    // In Student's Table
    if RecordCount <> 0 then
    begin
      // Add All Student Info
      with objUser do
      begin
        ID := FieldByName('ID').AsString;
        Name := FieldByName('Student_Name').AsString;
        Surname := FieldByName('Student_Surname').AsString;
      end;

      Result := objUser;
      EXIT;
    end;

  end;

end;

{$ENDREGION Login}
{ TStudent }
{$REGION$ TStudent}

constructor TUserStudent.Create(uUser: TUser);
begin

  // Check if the usertype is student and not teacher
  if uUser.Teacher then
  begin
    raise Exception.Create('Not Student');
  end;

  fUserData := uUser;
  with dmRecycle.qryRecycle do
  begin

    // Gets Class ID
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM ClassList WHERE Student_ID =:ID';
    Parameters.ParamByName('ID').Value := fUserData.ID;

    ExecSQL;
    Active := True;

    fClassID := FieldByName('Class_ID').AsString;

    // Gets Teacher ID
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT Teacher_ID FROM Class WHERE ID =:CLASSID';
    Parameters.ParamByName('CLASSID').Value := fClassID;

    ExecSQL;
    Active := True;

    fTeacher := FieldByName('Teacher_ID').AsString;

    // Tallies Recycle History

  end;

end;

// Gets the Student's Grade
function TUserStudent.GetGrade: integer;
var
  iGrade: integer;
begin

  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Class WHERE ID =:ID';
    Parameters.ParamByName('ID').Value := fClassID;

    ExecSQL;
    Active := True;

    iGrade := FieldByName('Grade').AsInteger;

  end;

  Result := iGrade;

end;

function TUserStudent.GetID: String;
begin
  Result := fUserData.ID;
end;

function TUserStudent.GetName: String;
begin
  Result := fUserData.Name;
end;

function TUserStudent.GetSurname: String;
begin
  Result := fUserData.Surname;
end;

// Gets the Student's Teacher's full Name
function TUserStudent.GetTeacher: String;
var
  sTeacher: String;
begin
  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Teacher WHERE ID =:ID';
    Parameters.ParamByName('ID').Value := fTeacher;

    ExecSQL;
    Active := True;

    sTeacher := FieldByName('Teacher_Name').AsString + ' ' +
      FieldByName('Teacher_Surname').AsString;

  end;

  Result := sTeacher;
end;

function TUserStudent.toString: String;
begin
  Result := 'Name: ' + GetName() + #13 + 'Surname: ' + GetSurname() + #13 + #13
    + 'Grade: ' + IntToStr(GetGrade()) + #13 + 'Teacher: ' + GetTeacher();
end;

{$ENDREGION$ TStudent}
{ TUserTeacher }
{$REGION$ TUserTeacher }

constructor TUserTeacher.Create(uUser: TUser);
begin
  // Checks if the user is a teacher
  if not uUser.Teacher then
  begin
    raise Exception.Create('Not Teacher');
  end;

  fUserData := uUser;

  fClass := TClass.Create(fUserData.ID);

end;

function TUserTeacher.GetAdmin: boolean;
begin
  Result := fUserData.Admin;
end;

function TUserTeacher.GetClassID: String;
begin
  Result := fClass.fClassID;
end;

function TUserTeacher.toString: String;
begin
  Result := 'Name: ' + fUserData.Name + ' ' + fUserData.Surname + #13#13 +
    'Class:' + #13#9 + 'Grade: ' + IntToStr(fClass.GetGrade()) + #13#9 + 'Size:'
    + IntToStr(fClass.GetSize());
end;

{$ENDREGION$ TUserTeacher }
{ TClass }
{$REGION$ TClass }

constructor TClass.Create(sTeacherID: string);
var
  objStudent: TStudent;
begin
  // Inits the Dictonary
  fStudents := TDictionary<String, TStudent>.Create;

  with dmRecycle.qryRecycle do
  begin
    // Gets class info
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Class WHERE Teacher_ID =:ID';
    Parameters.ParamByName('ID').Value := sTeacherID;

    Active := True;

    fClassID := FieldByName('ID').AsString;
    fGrade := FieldByName('Grade').AsInteger;

    // Gets Students
    Active := False;
    SQL.Clear;

    SQL.Text :=
      'SELECT C.Class_Id, C.Student_ID, S.ID, S.Student_Name, S.Student_Surname  FROM ClassList as C, Student as S WHERE (Class_Id =:ID) AND (C.Student_ID = S.ID) ORDER BY Student_Name';
    Parameters.ParamByName('ID').Value := fClassID;

    Active := True;

    First;
    while not Eof do
    begin
      objStudent.ID := FieldByName('ID').AsString;
      objStudent.Name := FieldByName('Student_Name').AsString;
      objStudent.Surname := FieldByName('Student_Surname').AsString;

      fStudents.Add(objStudent.ID, objStudent);

      Next;
    end;

    fSize := RecordCount;

  end;

end;

function TClass.GetGrade: integer;
begin
  Result := fGrade;
end;

function TClass.GetSize: integer;
begin
  Result := fSize;
end;

{$ENDREGION$ TCLass }

end.
