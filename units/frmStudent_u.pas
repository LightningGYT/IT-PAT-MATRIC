unit frmStudent_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, VclTee.TeeGDIPlus,
  Vcl.StdCtrls, Vcl.Buttons, VclTee.TeEngine, VclTee.TeeProcs, VclTee.Chart,
  Vcl.ComCtrls, VclTee.Series, clsRecycle_u, dmRecycle_u, Generics.Collections;

type
  TfrmStudent = class(TForm)
    pnlStats: TPanel;
    pnlControl: TPanel;
    cStats: TChart;
    bbnLogout: TBitBtn;
    redRecycleSummary: TRichEdit;
    lblWelcome: TLabel;
    redStudentSumary: TRichEdit;
    sRecycled: TPieSeries;
    procedure bbnLogoutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
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

procedure TfrmStudent.FormShow(Sender: TObject);
var
  Materials: TDictionary<String, TMaterial>;
  key: String;
begin

  // Adding The MAterial counts to the graph
  Materials := objRecycle.GetByStudent('d1cf1ac3-0a46-4b85-8e67-0f727b42faa4');

  with sRecycled do
  begin
    Clear;
    for key in Materials.Keys do
    begin
      Add(Materials.Items[key].fWieght, key);
    end;
  end;

end;

end.
