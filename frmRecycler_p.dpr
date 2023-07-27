program frmRecycler_p;

uses
  Vcl.Forms,
  frmStart_u in 'units\frmStart_u.pas' {frmStart},
  frmLogin_u in 'units\frmLogin_u.pas' {frmLogin},
  dmRecycle_u in 'db\dmRecycle_u.pas' {dmRecycle: TDataModule},
  Users_u in 'units\Users_u.pas',
  frmStudent_u in 'units\frmStudent_u.pas' {frmStudent};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmStart, frmStart);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TdmRecycle, dmRecycle);
  Application.CreateForm(TfrmStudent, frmStudent);
  Application.Run;
end.
