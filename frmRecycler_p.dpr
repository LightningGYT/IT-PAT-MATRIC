program frmRecycler_p;

uses
  Vcl.Forms,
  frmStart_u in 'units\frmStart_u.pas' {frmStart},
  frmLogin_u in 'units\frmLogin_u.pas' {frmLogin},
  dmRecycle_u in 'db\dmRecycle_u.pas' {dmRecycle: TDataModule},
  clsUsers_u in 'units\clsUsers_u.pas',
  frmStudent_u in 'units\frmStudent_u.pas' {frmStudent},
  frmTeacher_u in 'units\frmTeacher_u.pas' {frmTeacher},
  clsRecycle_u in 'units\clsRecycle_u.pas',
  frmRecycler_u in 'units\frmRecycler_u.pas' {frmRecycle};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmStart, frmStart);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TdmRecycle, dmRecycle);
  Application.CreateForm(TfrmStudent, frmStudent);
  Application.CreateForm(TfrmTeacher, frmTeacher);
  Application.CreateForm(TfrmRecycle, frmRecycle);
  Application.Run;
end.
