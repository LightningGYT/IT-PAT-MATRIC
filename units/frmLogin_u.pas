unit frmLogin_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImage,
  Vcl.VirtualImageList, Skia.Vcl, Vcl.StdCtrls, Vcl.Buttons, StrUtils;

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
  private
    function CheckInputs: boolean;
    procedure Login(cType: Char);
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
begin

  if not CheckInputs then
  begin
    EXIT;
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
    Result := False;
    EXIT;
  end;


  for I in sUsername do
  begin
    if ContainsText(ForbiddenChars, I) then
    begin
      Result := False;
      EXIT;
    end;

  end;

  for I in sPassword do
  begin
    if ContainsText(ForbiddenChars, I) then
    begin
      Result := False;
      EXIT;
    end;
  end;

  Result := True;

end;

procedure TfrmLogin.Login(cType: Char);
begin

end;

end.
