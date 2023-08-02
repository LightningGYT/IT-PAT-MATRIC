unit frmStudent_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, VclTee.TeeGDIPlus,
  Vcl.StdCtrls, Vcl.Buttons, VclTee.TeEngine, VclTee.TeeProcs, VclTee.Chart,
  Vcl.ComCtrls, VclTee.Series;

type
  TfrmStudent = class(TForm)
    pnlStats: TPanel;
    pnlControl: TPanel;
    cStats: TChart;
    bbnLogout: TBitBtn;
    redRecycleSummary: TRichEdit;
    lblWelcome: TLabel;
    redStudentSumary: TRichEdit;
    Series1: TLineSeries;
    Button1: TButton;
    procedure bbnLogoutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStudent: TfrmStudent;

implementation

{$R *.dfm}

procedure TfrmStudent.bbnLogoutClick(Sender: TObject);
begin
  Close;
end;

end.
