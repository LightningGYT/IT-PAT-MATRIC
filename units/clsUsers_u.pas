unit clsUsers_u;

interface

uses Hash, SysUtils;

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

  TStudent = class
  private
    fUserData: TUser;
  public
    constructor Create(uUser: TUser);
    function FindClass: String;
  end;

procedure Login(sUsername, sPassword: String);
function PrepPassword(sPassword, sSalt: String): String;

implementation

uses dmRecycle_u, frmLogin_u;

function PrepPassword(sPassword, sSalt: String): String;
var
  sPrep: String;
begin
  sPrep := sSalt + sPassword + sSalt;

  sPrep := THashSHA2.GetHashString(sPrep);

  Result := sPrep;
end;

procedure Login(sUsername, sPassword: String);
var
  objUser: TUser;
  sPass, sSalt: String;
begin

  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Login WHERE Username =:sUsername';
    Parameters.ParamByName('sUsername').Value := sUsername;

    ExecSQL;
    Active := True;

    with objUser do
    begin
      LoginID := FieldByName('ID').AsString;
      Username := FieldByName('Username').AsString;
    end;

    sPass := FieldByName('Password').AsString;
    sSalt := FieldByName('Salt').AsString;

    // making sure usernames match case sensitivty
    if not(sUsername = objUser.Username) then
    begin
      // Fail
      EXIT;
    end;

    // check if hashed password matches
    if not(sPass = PrepPassword(sPassword, sSalt)) then
    begin
      // Fail
      EXIT;
    end;

    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Teacher WHERE Login_ID =:LoginID';
    Parameters.ParamByName('LoginID').Value := objUser.LoginID;

    ExecSQL;
    Active := True;

    if RecordCount <> 0 then
    begin
      // ToDo...
      EXIT;
    end;

    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Student WHERE Login_ID =:LoginID';
    Parameters.ParamByName('LoginID').Value := objUser.LoginID;

    ExecSQL;
    Active := True;

  end;

end;

{ TStudent }

constructor TStudent.Create(uUser: TUser);
begin

  if uUser.Teacher then
  begin
    raise Exception.Create('Not Student');
  end;

  fUserData := uUser;

end;

function TStudent.FindClass: String;
var
  sClassID: String;
begin

  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM ClassList WHERE Student_ID =:ID';
    Parameters.ParamByName('ID').Value := fUserData.ID;

    ExecSQL;
    Active := True;

    sClassID := FieldByName('Class_Id').AsString;


    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Class WHERE ID =:ID';
    Parameters.ParamByName('ID').Value := sClassID;

    ExecSQL;
    Active := True;



  end;

end;

end.
