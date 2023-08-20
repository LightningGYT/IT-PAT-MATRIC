unit frmChangePass_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, StrUtils;

type
  TfrmChangePass = class(TForm)
    edtPass1: TEdit;
    lblMessage: TLabel;
    edtPass2: TEdit;
    bbnChangePass: TBitBtn;
    cbxVissPass: TCheckBox;
    procedure bbnChangePassClick(Sender: TObject);
    procedure cbxVissPassClick(Sender: TObject);
  private
    fLoginID: String;
  public
    procedure ChangePassword(sLoginID: string);
  end;

var
  frmChangePass: TfrmChangePass;

implementation

{$R *.dfm}

uses clsUsers_u, frmStart_u;
{ TfrmChangePass }

procedure TfrmChangePass.bbnChangePassClick(Sender: TObject);
var
  sPass1, sPass2: String;
begin

  sPass1 := edtPass1.Text;
  sPass2 := edtPass2.Text;

  if ContainsStr(sPass1, ' ') then
  begin
    MessageDlg('No spaces are allowed in passwords', TMsgDlgType.mtError,
      [mbOk], 1);
    exit;
  end;

  if length(sPass1) < 8 then
  begin
    MessageDlg('Passwords need to be longer than 8 characters', mtWarning, [mbOk], 1);
    exit;
  end;

  if not(sPass1 = sPass2) then
  begin
    MessageDlg('Passwords do not match', mtwarning, [mbOk], 1);
    exit;
  end;

  clsUsers_u.changePass(sPass1, fLoginID);

  Close;

end;

procedure TfrmChangePass.cbxVissPassClick(Sender: TObject);
var
  bVissPass: boolean;
begin
  bVissPass := cbxVissPass.Checked;

  if bVissPass then
  begin
    edtPass1.PasswordChar := #0;
    edtPass2.PasswordChar := #0;
  end
  else
  begin
    edtPass1.PasswordChar := '*';
    edtPass2.PasswordChar := '*';
  end;

end;

procedure TfrmChangePass.ChangePassword(sLoginID: string);
begin
fLoginID := sLoginID;
  ShowModal;
end;

end.
