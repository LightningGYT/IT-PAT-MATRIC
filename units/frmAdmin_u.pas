unit frmAdmin_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, System.Actions, Vcl.ActnList;

type
  TfrmAdmin = class(TForm)
    pnlUsers: TPanel;
    pcUsers: TPageControl;
    tsStudents: TTabSheet;
    pnlSearchStudents: TPanel;
    edtFirstName: TEdit;
    edtSurname: TEdit;
    pnlStudentInfo: TPanel;
    pnlEditStudent: TPanel;
    bbnDelete: TBitBtn;
    bbnPassChange: TBitBtn;
    tsTeacher: TTabSheet;
    procedure CloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;

implementation

{$R *.dfm}

procedure TfrmAdmin.CloseExecute(Sender: TObject);
begin
Close;
end;

end.
