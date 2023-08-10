unit clsUsers_u;

interface

uses Hash, SysUtils, Generics.Collections, Vcl.Dialogs;

type
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

  TTeacher = class
  private
    fUserData: TUser;
  public
    constructor Create(uUser: TUser);
  end;

  TStudent = class
  private
    fUserData: TUser;
    fClassID: String;
    fTeacher: String;
    fRecycleHistory: TDictionary<String, integer>;
  public
    constructor Create(uUser: TUser);

    function GetGrade: integer;
    function GetID: String;
    function GetName: String;
    function GetSurname: String;
    function GetTeacher: String;

    function toString: String;
  end;

function Login(sUsername, sPassword: String): TUser;
function PrepPassword(sPassword, sSalt: String): String;

implementation

uses dmRecycle_u, frmLogin_u;

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
      showMessage('Teacher');
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

{ TStudent }

{$REGION$ TStudent}

constructor TStudent.Create(uUser: TUser);
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
function TStudent.GetGrade: integer;
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

function TStudent.GetID: String;
begin
  Result := fUserData.ID;
end;

function TStudent.GetName: String;
begin
  Result := fUserData.Name;
end;

function TStudent.GetSurname: String;
begin
  Result := fUserData.Surname;
end;

// Gets the Student's Teacher's full Name
function TStudent.GetTeacher: String;
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

function TStudent.toString: String;
begin
  Result := 'Name: ' + GetName() + #13 + 'Surname: ' + GetSurname() + #13 + #13 +
    'Grade: ' + IntToStr(GetGrade()) + #13 + 'Teacher: ' + GetTeacher();
end;

{$ENDREGION$ TStudent}
{ TTeacher }

{$REGION$ TTeacher }

constructor TTeacher.Create(uUser: TUser);
begin
  if not uUser.Teacher then
  begin
    raise Exception.Create('Not Teacher');
  end;

  fUserData := uUser;
end;
{$ENDREGION$ TTeacher }

end.
