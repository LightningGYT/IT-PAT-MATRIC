unit frmTeacher_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.Buttons, VclTee.TeeGDIPlus, VclTee.TeEngine, VclTee.TeeProcs,
  VclTee.Chart,
  clsUsers_u, VclTee.Series, Generics.Collections;

type
  TfrmTeacher = class(TForm)
    pnlFunctions: TPanel;
    pnlStudents: TPanel;
    pnlOther: TPanel;
    pnlTeacher: TPanel;
    pnlControl: TPanel;
    lblWelcome: TLabel;
    redSummary: TRichEdit;
    bbnLogOut: TBitBtn;
    bbnRecycle: TBitBtn;
    cClassRecycle: TChart;
    pnlLeaderBoard: TPanel;
    lblLeaderboard: TLabel;
    redLeaderBoard: TRichEdit;
    sRecycled: TPieSeries;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bbnLogOutClick(Sender: TObject);
  private
    objTeacher: TUserTeacher;
  public
    procedure setTeacher(Teacher: TUserTeacher);
  end;

var
  frmTeacher: TfrmTeacher;

implementation

{$R *.dfm}

uses frmStart_u, clsRecycle_u;

{ TfrmTeacher }

procedure TfrmTeacher.bbnLogOutClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTeacher.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmStart.Show;
end;

procedure TfrmTeacher.FormShow(Sender: TObject);
var
  dictMaterials: TDictionary<string, TMaterial>;
  dictTopStudents: TDictionary<String, Integer>;
  key: String;
begin

  // Displays The Teacher's Info
  with redSummary.Lines do
  begin
    Clear;
    Add(objTeacher.toString());
  end;

  // Add To Chart
  dictMaterials := objRecycle.GetByClass(objTeacher.GetClassID());
  with sRecycled do
  begin
    Clear;
    for key in dictMaterials.Keys do
    begin
      AddPie(dictMaterials.Items[key].fWieght, key);
    end;

  end;

  // Get Top Students
  dictTopStudents := objRecycle.GetTopStudents(objTeacher.GetClassID());

  with redLeaderBoard.Lines do
  begin
    Clear;

    for key in dictTopStudents.Keys do
    begin
      Add(FindStudent(key))
    end;

  end;
end;

procedure TfrmTeacher.setTeacher(Teacher: TUserTeacher);
begin
  objTeacher := Teacher;
end;

end.
