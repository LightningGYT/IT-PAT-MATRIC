unit frmStart_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Vcl.StdCtrls,
  Vcl.ComCtrls, VclTee.TeEngine, VclTee.Series, VclTee.TeeProcs, VclTee.Chart,
  Vcl.ExtCtrls, Vcl.Buttons, clsRecycle_u, Generics.Collections, System.Actions,
  Vcl.ActnList, clsUsers_u;

type
  TfrmStart = class(TForm)
    pnlStats: TPanel;
    cStats: TChart;
    sRecycled: TPieSeries;
    pnlLogin: TPanel;
    bbnClose: TBitBtn;
    bbnLogin: TBitBtn;
    lblWelcom: TLabel;
    DEBUGINGREMOVE: TActionList;
    Student: TAction;
    Teacher: TAction;
    cHistory: TChart;
    sHistory: TLineSeries;
    procedure bbnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StudentExecute(Sender: TObject);
    procedure TeacherExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure LoginStudent(uUser: TUser);
    procedure LoginTeacher(uUser: TUser);
  end;

var
  frmStart: TfrmStart;
  objRecycle: TRecycler;

const
  months: array of String = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL',
    'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];

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
  History: TDictionary<String, integer>;
  key: String;
  month: integer;
begin

  // Adding The MAterial counts to the graph
  objRecycle := TRecycler.Create;
  Materials := objRecycle.GetMaterials;

  with sRecycled do
  begin
    Clear;
    for key in Materials.Keys do
    begin
      Add(Materials.Items[key].fWieght, key);
    end;
  end;

  // Adding History onto Graph
  History := objRecycle.GetHistory;

  with sHistory do
  begin
    Clear;
    for month := 0 to 11 do
    begin
      Add(History.Items[months[month]], months[month]);
    end;
  end;

end;

procedure TfrmStart.LoginStudent(uUser: TUser);
var
  objStudent: TUserStudent;
begin

  objStudent := TUserStudent.Create(uUser);
  frmStudent.SetStudent(objStudent);
  Hide;
  frmStudent.Show;

end;

procedure TfrmStart.LoginTeacher(uUser: TUser);
var
  objTeacher: TUserTeacher;
begin

  objTeacher := TUserTeacher.Create(uUser);
  frmTeacher.setTeacher(objTeacher);
  Hide;
  frmTeacher.Show;

end;

end.
