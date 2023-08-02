unit frmTeacher_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons;

type
  TfrmTeacher = class(TForm)
    pnlFunctions: TPanel;
    pnlStudents: TPanel;
    pnlAdmin: TPanel;
    pnlOther: TPanel;
    pnlTeacher: TPanel;
    pnlControl: TPanel;
    lblWelcome: TLabel;
    redSummary: TRichEdit;
    bbnLogOut: TBitBtn;
    bbnRecycle: TBitBtn;
    lsbStudents: TListBox;
    redStudentSumary: TRichEdit;
    bbnStudentRecycle: TBitBtn;
    pcAdmin: TPageControl;
    tsMaterials: TTabSheet;
    tsUsers: TTabSheet;
    tsRecycle: TTabSheet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTeacher: TfrmTeacher;

implementation

{$R *.dfm}

end.
