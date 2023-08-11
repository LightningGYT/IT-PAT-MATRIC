unit frmStudent_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, VclTee.TeeGDIPlus,
  Vcl.StdCtrls, Vcl.Buttons, VclTee.TeEngine, VclTee.TeeProcs, VclTee.Chart,
  Vcl.ComCtrls, VclTee.Series, clsRecycle_u, dmRecycle_u, Generics.Collections,
  clsUsers_u, Vcl.WinXPickers;

type
  TfrmStudent = class(TForm)
    pnlStats: TPanel;
    pnlControl: TPanel;
    cStats: TChart;
    bbnLogout: TBitBtn;
    lblWelcome: TLabel;
    redStudentSumary: TRichEdit;
    sRecycled: TPieSeries;
    procedure bbnLogoutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    objStudent: TUserStudent;
  public
    procedure SetStudent(Student: TUserStudent);
  end;

var
  frmStudent: TfrmStudent;

implementation

{$R *.dfm}

uses frmStart_u;

procedure TfrmStudent.bbnLogoutClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmStudent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmStart.Show;
end;

procedure TfrmStudent.FormShow(Sender: TObject);
var
  Materials: TDictionary<String, TMaterial>;
  key: String;
begin
  // Adding The MAterial counts to the graph
  Materials := objRecycle.GetByStudent(objStudent.GetID);

  with sRecycled do
  begin
    Clear;
    for key in Materials.Keys do
    begin
      Add(Materials.Items[key].fWieght, key);
    end;
  end;

  // Show Details about Student
  with redStudentSumary.Lines do
  begin
    Clear;
    Add(objStudent.toString)
  end;

end;

procedure TfrmStudent.SetStudent(Student: TUserStudent);
begin
  objStudent := Student;
end;

end.
