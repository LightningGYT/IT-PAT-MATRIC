unit frmLogin_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImage,
  Vcl.VirtualImageList, Skia.Vcl, Vcl.StdCtrls, Vcl.Buttons, StrUtils,
  clsUsers_u;

type
  TfrmLogin = class(TForm)
    pnlInput: TPanel;
    imgUser: TImage;
    bbnCancel: TBitBtn;
    bbnLogin: TBitBtn;
    cbxPassViss: TCheckBox;
    edtPassword: TEdit;
    edtUsername: TEdit;
    procedure bbnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxPassVissClick(Sender: TObject);
  private
    function CheckInputs: boolean;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

const
  ForbiddenChars = '(){}[]|`¬¦!"£$%^&*"<>:;#~_-+=,@ ';

implementation

{$R *.dfm}

uses frmStart_u;
{ TfrmLogin }

procedure TfrmLogin.bbnLoginClick(Sender: TObject);
var
  sUsername, sPassword: String;
  objUser: TUser;
begin

  if not CheckInputs then
  begin
    EXIT;
  end;

  sUsername := edtUsername.Text;
  sPassword := edtPassword.Text;

  try
    objUser := Login(sUsername, sPassword);
  Except
    EXIT;
  end;

  if objUser.Teacher then
  begin
    Close;
    frmStart.LoginTeacher(objUser);
  end
  else
  begin
    Close;
    frmStart.LoginStudent(objUser);
  end;

end;

procedure TfrmLogin.cbxPassVissClick(Sender: TObject);
var
  bShow: boolean;
begin

  bShow := cbxPassViss.Checked;

  if bShow then
  begin
    edtPassword.PasswordChar := #0;
  end
  else
  begin
    edtPassword.PasswordChar := '*';
  end;

end;

function TfrmLogin.CheckInputs: boolean;
var
  sUsername, sPassword: String;
  I: Char;
begin

  sUsername := edtUsername.Text;
  sPassword := edtPassword.Text;

  if (sUsername <> '') OR (sPassword <> '') then
  begin
    Result := True;
  end;

  for I in sUsername do
  begin
    if ContainsText(ForbiddenChars, I) then
    begin
      Result := False;
    end;

  end;

  for I in sPassword do
  begin
    if ContainsText(ForbiddenChars, I) then
    begin
      Result := False;
    end;
  end;

  Result := True;

end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtPassword.Clear;
  edtUsername.Clear;
  edtUsername.SetFocus;
end;

end.
