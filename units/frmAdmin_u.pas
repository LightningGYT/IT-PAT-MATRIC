unit frmAdmin_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons, System.Actions, Vcl.ActnList, Vcl.Samples.Spin,
  Generics.Collections,
  clsRecycle_u, clsUsers_u;

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
    pnlSearchTeacher: TPanel;
    pnlTeacherSummary: TPanel;
    edtTeacherFirstName: TEdit;
    edtTeacherSurname: TEdit;
    bbnTeacherChangePassword: TBitBtn;
    tsAddUser: TTabSheet;
    pnlAddName: TPanel;
    pnlAddOtherInfo: TPanel;
    edtAddFirstname: TEdit;
    edtAddSurname: TEdit;
    rgType: TRadioGroup;
    bbnAdd: TBitBtn;
    bbnRetry: TBitBtn;
    pnlMaterials: TPanel;
    lbMaterials: TListBox;
    bbnDeleteMaterial: TBitBtn;
    bbnAddMaterial: TBitBtn;
    bbnClose: TBitBtn;
    bbnAddClass: TBitBtn;
    spnAddGrade: TSpinEdit;
    procedure CloseExecute(Sender: TObject);
    procedure rgTypeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbnDeleteMaterialClick(Sender: TObject);
    procedure bbnAddMaterialClick(Sender: TObject);
    procedure edtFirstNameChange(Sender: TObject);
    procedure bbnDeleteClick(Sender: TObject);
    procedure edtTeacherFirstNameChange(Sender: TObject);
    procedure bbnAddClassClick(Sender: TObject);
    procedure bbnCloseClick(Sender: TObject);

  private
    // Other vars
    dictMaterials: TDictionary<String, TMaterial>;
    // Dynamic objects
    edtNewStudentTeacherFirst: TEdit;
    edtNewStudentTeacherSur: TEdit;
    bbnNewStudentSearchTeacher: TBitBtn;
    cbxAdmin: TCheckBox;
    cbxHasClass: TCheckBox;
    spnGrade: TSpinEdit;
    lblGrade: TLabel;
    // Dynamic Objects
    procedure NewStudent;
    procedure NewTeacher;
    procedure RemoveDynamics;
    // Other func/procs
    procedure UpMaterials;
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;

implementation

{$R *.dfm}

uses frmStart_u;

procedure TfrmAdmin.bbnAddClassClick(Sender: TObject);
var
  sTeacherID, sFirstName, sSurname: String;
  iGRade: Integer;
begin
  sFirstName := edtTeacherFirstName.Text;
  sSurname := edtTeacherSurname.Text;
  iGRade := spnAddGrade.Value;
  Try
    sTeacherID := FindTeacher(sFirstName, sSurname);
  Except
    MessageDlg('There is no Teacher with that name', TMsgDlgType.mtWarning,
      [mbOK], 1);
    Exit;
  End;

  try
    FindClass(sTeacherID);
  except
    if MessageDlg('Are You sure you want to add a Class',
      TMsgDlgType.mtWarning, mbYesNo, 1) = mrYes then
    begin
      AddClass(sTeacherID, iGRade);
      MessageDlg('Class was Added', TMsgDlgType.mtInformation,
        [mbOK], 1);
    end;
    Exit;
  end;
  MessageDlg('CLASS ALREADY EXISTS', TMsgDlgType.mtWarning, [mbOK], 1);
end;

procedure TfrmAdmin.bbnAddMaterialClick(Sender: TObject);
var
  sMaterial: String;
begin
  sMaterial := InputBox('New Material', 'Name of New Material', '');

  if sMaterial <> '' then
  begin
    if MessageDlg('Are You sure you want to add ' + sMaterial,
      TMsgDlgType.mtWarning, mbYesNo, 1) = mrYes then
    begin
      objRecycle.AddMaterial(sMaterial);
      MessageDlg(sMaterial + ' was Added', TMsgDlgType.mtInformation,
        [mbOK], 1);
    end;

  end;

  UpMaterials;

end;

procedure TfrmAdmin.bbnCloseClick(Sender: TObject);
begin
Close;
end;

procedure TfrmAdmin.bbnDeleteClick(Sender: TObject);
var
  sFirstName, sSurname, sStudentID: String;
begin
  sFirstName := edtFirstName.Text;
  sSurname := edtSurname.Text;

  Try
    sStudentID := FindStudent(sFirstName, sSurname);
  Except
    MessageDlg('There is no Student with that name', TMsgDlgType.mtWarning,
      [mbOK], 1);
    Exit;
  End;

  if MessageDlg('Are You sure you want to delete ' + sFirstName,
    TMsgDlgType.mtWarning, mbYesNo, 1) = mrYes then
  begin
    DeleteStudent(sStudentID);
    MessageDlg(sFirstName + ' was Deleted', TMsgDlgType.mtInformation,
      [mbOK], 1);
  end;

end;

procedure TfrmAdmin.bbnDeleteMaterialClick(Sender: TObject);
var
  objMaterial: TMaterial;
  sMaterial: String;
begin
  sMaterial := lbMaterials.Items[lbMaterials.ItemIndex];
  objMaterial := dictMaterials.Items[sMaterial];

  if MessageDlg('Are You sure you want to delete ' + sMaterial,
    TMsgDlgType.mtWarning, mbYesNo, 1) = mrYes then
  begin
    objRecycle.DeleteMaterial(objMaterial.fID);
    MessageDlg(sMaterial + ' was Deleted', TMsgDlgType.mtInformation,
      [mbOK], 1);
  end;

  UpMaterials;
end;

procedure TfrmAdmin.CloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmAdmin.edtFirstNameChange(Sender: TObject);
var
  sStudentID, sFirstName, sSurname: String;
begin
  sFirstName := edtFirstName.Text;
  sSurname := edtSurname.Text;

  Try
    sStudentID := FindStudent(sFirstName, sSurname);
  Except
    pnlStudentInfo.Caption := 'Not Student Found with that name';
    Exit;
  End;

  pnlStudentInfo.Caption := 'Student Found'

end;

procedure TfrmAdmin.edtTeacherFirstNameChange(Sender: TObject);
var
  sTeacherID, sFirstName, sSurname: String;
begin
  sFirstName := edtTeacherFirstName.Text;
  sSurname := edtTeacherSurname.Text;

  Try
    sTeacherID := FindTeacher(sFirstName, sSurname);
  Except
    pnlTeacherSummary.Caption := 'Not Teacher Found with that name';
    Exit;
  End;

  pnlTeacherSummary.Caption := 'Teacher Found'
end;

procedure TfrmAdmin.FormShow(Sender: TObject);
begin
  UpMaterials;
end;

procedure TfrmAdmin.NewStudent;
begin

  // Clear the panel
  RemoveDynamics;

  // The dynamic objects for Adding a student
  edtNewStudentTeacherSur := TEdit.Create(pnlAddOtherInfo.Owner);
  with edtNewStudentTeacherSur do
  begin
    Parent := pnlAddOtherInfo;
    Align := alTop;
    Margins.Top := 10;
    Margins.Left := 10;
    Margins.Right := 10;
    Margins.Bottom := 10;
    AlignWithMargins := True;

    TextHint := 'Teachers Surname';
    Visible := True;
  end;

  edtNewStudentTeacherFirst := TEdit.Create(pnlAddOtherInfo.Owner);
  with edtNewStudentTeacherFirst do
  begin
    Parent := pnlAddOtherInfo;
    Align := alTop;
    Margins.Top := 10;
    Margins.Left := 10;
    Margins.Right := 10;
    Margins.Bottom := 10;
    AlignWithMargins := True;

    TextHint := 'Teachers Firsname';
    Visible := True;

  end;

  bbnNewStudentSearchTeacher := TBitBtn.Create(pnlAddOtherInfo.Owner);
  with bbnNewStudentSearchTeacher do
  begin
    Parent := pnlAddOtherInfo;
    Align := alBottom;
    Margins.Top := 10;
    Margins.Left := 10;
    Margins.Right := 10;
    Margins.Bottom := 10;
    AlignWithMargins := True;

    Caption := 'Search for Teacher';
    Visible := True;

  end;

end;

procedure TfrmAdmin.NewTeacher;
begin
  // Clear the panel
  RemoveDynamics;

  // Add dynamic objects
  cbxAdmin := TCheckBox.Create(pnlAddOtherInfo.Owner);
  with cbxAdmin do
  begin
    Parent := pnlAddOtherInfo;
    Align := alTop;
    with Margins do
    begin
      Top := 10;
      Left := 10;
      Right := 10;
      Bottom := 10;
    end;
    AlignWithMargins := True;
    Checked := False;
    Caption := 'Is Admin';
    Visible := True;
  end;

  cbxHasClass := TCheckBox.Create(pnlAddOtherInfo.Owner);
  with cbxHasClass do
  begin
    Parent := pnlAddOtherInfo;
    Align := alTop;
    with Margins do
    begin
      Top := 10;
      Left := 10;
      Right := 10;
      Bottom := 10;
    end;
    AlignWithMargins := True;
    Checked := False;
    Caption := 'Has A Class';
    Visible := True;
  end;

  spnGrade := TSpinEdit.Create(pnlAddOtherInfo.Owner);
  with spnGrade do
  begin
    Parent := pnlAddOtherInfo;
    Align := alBottom;
    with Margins do
    begin
      Top := 10;
      Left := 10;
      Right := 10;
      Bottom := 10;
    end;
    AlignWithMargins := True;
    MinValue := 0;
    MaxValue := 12;
    Value := 0;
    Visible := True;
    Hint := 'Grade of Class';
    ShowHint := True;
  end;

  lblGrade := TLabel.Create(pnlAddOtherInfo.Owner);
  with lblGrade do
  begin
    Parent := pnlAddOtherInfo;
    Align := alBottom;
    with Margins do
    begin
      Top := 10;
      Left := 10;
      Right := 10;
      Bottom := 10;
    end;
    AlignWithMargins := True;
    Caption := 'Grade: ';
    Visible := True;
  end;

end;

procedure TfrmAdmin.RemoveDynamics;
begin
  // Student dynamics
  try
    edtNewStudentTeacherFirst.Destroy;
  except
    //
  end;
  try
    edtNewStudentTeacherSur.Destroy;
  except
    //
  end;
  try
    bbnNewStudentSearchTeacher.Destroy;
  except
    //
  end;

  // Teacher Dynamics
  try
    cbxAdmin.Destroy;
  except
    //
  end;
  try
    cbxHasClass.Destroy;
  except
    //
  end;
  try
    spnGrade.Destroy;
  except
    //
  end;
  try
    lblGrade.Destroy;
  except
    //
  end;
end;

procedure TfrmAdmin.rgTypeClick(Sender: TObject);
var
  iType: Integer;
begin
  iType := rgType.ItemIndex;

  case iType of
    0:
      NewStudent;
    1:
      NewTeacher;
  end;
end;

procedure TfrmAdmin.UpMaterials;
var
  sKey: String;
begin
  dictMaterials := objRecycle.GetMaterials;

  with lbMaterials.Items do
  begin
    Clear;

    for sKey in dictMaterials.Keys do
    begin
      Add(sKey);
    end;

  end;

end;

end.
