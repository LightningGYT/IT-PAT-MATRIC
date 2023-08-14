unit clsUsers_u;

interface

uses Hash, SysUtils, Generics.Collections, Vcl.Dialogs;

type
  { Records }
  TUser = record
    LoginID: String;
    Username: String;

    ID: String;
    Name: String;
    Surname: String;

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
function Login(sUsername, sPassword: String): TUser;
function PrepPassword(sPassword, sSalt: String): String;
function FindStudent(sStudentID: String): String; overload;
function FindStudent(sFirstname, sSurname: String): String; overload;
function FindTeacher(sTeacherID: String): String; overload;
function FindTeacher(sFirstname, sSurname: String): String; overload;
procedure DeleteStudent(sStudentID: String);
procedure DeleteTeacher(sTeacherID: String);
function FindClass(sTeacherID: String): String;
procedure AddClass(sTeacherID: String; iGrade: integer);
procedure AddStudent(sFirstname, sSurname:String);
procedure AddTeacher(sFirstname, sSurname:String;bAdmin:String);
function AddLogin(sUsername:String):String;

implementation

uses dmRecycle_u, frmLogin_u;

procedure AddClass(sTeacherID: String; iGrade: integer);
var
  sUUid: String;
  uuid: TGUID;
begin

  CreateGUID(uuid);
  sUUid := uuid.ToString;

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
      exit;
    end
    else
    begin
      raise Exception.Create('Class not found');
    end;
  end;
end;

procedure DeleteTeacher(sTeacherID: String);
begin

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

    if RecordCount <> 0 then
    begin
      Result := FieldByName('ID').AsString;
      exit;
    end
    else
    begin
      raise Exception.Create('Teacher not found');
    end;

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
      exit;
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

    Result := FieldByName('Teacher_Name').AsString + ' ' +
      FieldByName('Teacher_Surname').AsString;
  end;
end;

function PrepPassword(sPassword, sSalt: String): String;
var
  sPrep: String;
begin
  sPrep := sSalt + sPassword + sSalt;

  sPrep := THashSHA2.GetHashString(sPrep, THashSHA2.TSHA2Version.SHA512);

  Result := sPrep;
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

      exit;
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
      exit;
    end;

  end;

end;

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
    while not EOF do
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
