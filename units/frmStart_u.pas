unit frmStart_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Vcl.StdCtrls,
  Vcl.ComCtrls, VclTee.TeEngine, VclTee.Series, VclTee.TeeProcs, VclTee.Chart,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmStart = class(TForm)
    pnlStats: TPanel;
    cStats: TChart;
    Series2: TPieSeries;
    pnlLogin: TPanel;
    redLeaderBoard: TRichEdit;
    bbnClose: TBitBtn;
    bbnLogin: TBitBtn;
    lblWelcom: TLabel;
    Button1: TButton;
    procedure bbnLoginClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStart: TfrmStart;

implementation

{$R *.dfm}

uses frmLogin_u, dmRecycle_u, frmTeacher_u;

procedure TfrmStart.bbnLoginClick(Sender: TObject);
begin
  frmLogin.ShowModal;
end;

procedure TfrmStart.Button1Click(Sender: TObject);
begin
frmTeacher.ShowModal;
end;

end.
