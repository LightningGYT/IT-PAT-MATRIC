unit frmStart_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Vcl.StdCtrls,
  Vcl.ComCtrls, VclTee.TeEngine, VclTee.Series, VclTee.TeeProcs, VclTee.Chart,
  Vcl.ExtCtrls, Vcl.Buttons, clsRecycle_u, Generics.Collections, System.Actions,
  Vcl.ActnList;

type
  TfrmStart = class(TForm)
    pnlStats: TPanel;
    cStats: TChart;
    sRecycled: TPieSeries;
    pnlLogin: TPanel;
    redLeaderBoard: TRichEdit;
    bbnClose: TBitBtn;
    bbnLogin: TBitBtn;
    lblWelcom: TLabel;
    DEBUGINGREMOVE: TActionList;
    Student: TAction;
    Teacher: TAction;
    procedure bbnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StudentExecute(Sender: TObject);
    procedure TeacherExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStart: TfrmStart;
  objRecycle: TRecycler;

implementation

{$R *.dfm}

uses frmLogin_u, dmRecycle_u, frmTeacher_u, frmStudent_u;

procedure TfrmStart.StudentExecute(Sender: TObject);
begin
frmStudent.ShowModal;
end;

procedure TfrmStart.TeacherExecute(Sender: TObject);
begin
frmTeacher.ShowModal;
end;

procedure TfrmStart.bbnLoginClick(Sender: TObject);
begin
  frmLogin.ShowModal;
end;

procedure TfrmStart.FormShow(Sender: TObject);
var
  Materials: TDictionary<String, TMaterial>;
  key: String;
begin

  // Adding The MAterial counts to the graph
  objRecycle := TRecycler.Create;
  Materials := objRecycle.GetMaterials;

  with sRecycled do
  begin
    Clear;
    for key in Materials.Keys do
    begin
      Add(Materials.Items[Key].fWieght, key);
    end;
  end;

end;

end.
