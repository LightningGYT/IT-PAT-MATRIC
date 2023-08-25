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
    procedure bbnPassChangeClick(Sender: TObject);
    procedure bbnAddClick(Sender: TObject);
    procedure bbnTeacherChangePasswordClick(Sender: TObject);

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
    procedure AddTeacher;
    procedure AddStudent;
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;

implementation

{$R *.dfm}

uses frmStart_u;

procedure TfrmAdmin.AddStudent;
var
  sFirstname, sSurname, sUsername, sID, sTeacherFirst, sTeacherSur, sTeacherID,
    sClassID: String;
  dictStudent: TDictionary<String, String>;
begin
  // Student's Details
  sFirstname := edtAddFirstname.Text;
  sFirstname := sFirstname.Trim;
  sSurname := edtAddSurname.Text;
  sSurname := sSurname.Trim;

  // Teacher's Details
  sTeacherFirst := edtNewStudentTeacherFirst.Text;
  sTeacherFirst := sTeacherFirst.Trim;
  sTeacherSur := edtNewStudentTeacherSur.Text;
  sTeacherSur := sTeacherSur.Trim;

  if (sFirstname = '') OR (sSurname = '') OR (sTeacherFirst = '') OR
    (sTeacherSur = '') then
  begin
    MessageDlg('Please enter all details', TMsgDlgType.mtWarning, [mbOK], 1);
    exit;
  end;

  try
    sTeacherID := clsUsers_u.FindTeacher(sTeacherFirst, sTeacherSur);
  except
    on E: ENoTeacher do
    begin
      MessageDlg('There is No Teacher with that name', TMsgDlgType.mtError,
        [mbOK], 1);
      exit;
    end;
  end;

  try
    sClassID := clsUsers_u.FindClass(sTeacherID);
  except
    on E: ENoClass do
    begin
      MessageDlg(Format('%s %s does not have a class',
        [sTeacherFirst, sTeacherSur]), mtWarning, [mbOK], 1);
      exit;
    end;
  end;

  dictStudent := clsUsers_u.AddStudent(sFirstname, sSurname);
  sUsername := dictStudent.Items['Username'];
  sID := dictStudent.Items['ID'];

  AddToClass(sID, sClassID);

  MessageDlg(Format('%s %s has been added with the Username: %s',
    [sFirstname, sSurname, sUsername]), TMsgDlgType.mtInformation, [mbOK], 1);

  edtAddFirstname.Clear;
  edtAddSurname.Clear;
  edtNewStudentTeacherFirst.Clear;
  edtNewStudentTeacherSur.Clear;

end;

procedure TfrmAdmin.AddTeacher;
var
  sFirstname, sSurname, sUsername, sID: String;
  bClass, bAdmin: Boolean;
  iGrade: Integer;
  dictTeacher: TDictionary<String, String>;
begin
  sFirstname := edtAddFirstname.Text;
  sFirstname := sFirstname.Trim;
  sSurname := edtAddSurname.Text;
  sSurname := sSurname.Trim;

  if (sFirstname = '') OR (sSurname = '') then
  begin
    MessageDlg('Please Enter all delails', TMsgDlgType.mtWarning, [mbOK], 1);
    exit;
  end;

  bClass := cbxHasClass.Checked;
  bAdmin := cbxAdmin.Checked;

  if bClass then
  begin
    iGrade := spnGrade.Value;

    if (iGrade < 8) OR (iGrade > 12) then
    begin
      MessageDlg('Please select a grade between 8 and 12',
        TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 1);
      exit;
    end;
  end;

  dictTeacher := clsUsers_u.AddTeacher(sFirstname, sSurname, bAdmin);
  sUsername := dictTeacher.Items['Username'];
  sID := dictTeacher.Items['ID'];

  if bClass then
  begin
    AddClass(sID, iGrade);

    MessageDlg
      (Format('%s %s with the username: %s , and their class has been add',
      [sFirstname, sSurname, sUsername]), TMsgDlgType.mtInformation, [mbOK], 1);
  end
  else
  begin
    MessageDlg(Format('%s %s with the username: %s has been add',
      [sFirstname, sSurname, sUsername]), TMsgDlgType.mtInformation, [mbOK], 1);
  end;

  edtAddFirstname.Clear;
  edtAddSurname.Clear;
  cbxAdmin.Checked := False;
  cbxHasClass.Checked := False;

end;

procedure TfrmAdmin.bbnAddClassClick(Sender: TObject);
var
  sTeacherID, sFirstname, sSurname: String;
  iGrade: Integer;
begin
  sFirstname := edtTeacherFirstName.Text;
  sSurname := edtTeacherSurname.Text;
  iGrade := spnAddGrade.Value;
  Try
    sTeacherID := FindTeacher(sFirstname, sSurname);
  Except
    MessageDlg('There is no Teacher with that name', TMsgDlgType.mtWarning,
      [mbOK], 1);
    exit;
  End;

  try
    FindClass(sTeacherID);
  except
    if MessageDlg('Are You sure you want to add a Class', TMsgDlgType.mtWarning,
      mbYesNo, 1) = mrYes then
    begin
      AddClass(sTeacherID, iGrade);
      MessageDlg('Class was Added', TMsgDlgType.mtInformation, [mbOK], 1);
    end;
    exit;
  end;
  MessageDlg('CLASS ALREADY EXISTS', TMsgDlgType.mtWarning, [mbOK], 1);
end;

procedure TfrmAdmin.bbnAddClick(Sender: TObject);
var
  iType: Integer;
begin
  iType := rgType.ItemIndex;

  case iType of
    0:
      AddStudent;
    1:
      AddTeacher;
  end;
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
  sFirstname, sSurname, sStudentID: String;
begin
  sFirstname := edtFirstName.Text;
  sSurname := edtSurname.Text;

  Try
    sStudentID := FindStudent(sFirstname, sSurname);
  Except
    MessageDlg('There is no Student with that name', TMsgDlgType.mtWarning,
      [mbOK], 1);
    exit;
  End;

  if MessageDlg('Are You sure you want to delete ' + sFirstname,
    TMsgDlgType.mtWarning, mbYesNo, 1) = mrYes then
  begin
    DeleteStudent(sStudentID);
    MessageDlg(sFirstname + ' was Deleted', TMsgDlgType.mtInformation,
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

procedure TfrmAdmin.bbnPassChangeClick(Sender: TObject);
var
  sFirstname, sSurname, sLoginID: String;
begin
  sFirstname := edtFirstName.Text;
  sSurname := edtSurname.Text;

  sLoginID := FindStudentLogin(sFirstname, sSurname);
  RequestPassChange(sLoginID);
  MessageDlg(sFirstname + ' ' + sSurname +
    ' will be prompted to change their password when they next login',
    TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);

end;

procedure TfrmAdmin.bbnTeacherChangePasswordClick(Sender: TObject);
var
  sFirstname, sSurname, sLoginID: String;
begin
  sFirstname := edtTeacherFirstName.Text;
  sSurname := edtTeacherSurname.Text;

  sLoginID := FindTeacherLogin(sFirstname, sSurname);
  RequestPassChange(sLoginID);
  MessageDlg(sFirstname + ' ' + sSurname +
    ' will be prompted to change their password when they next login',
    TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);

end;

procedure TfrmAdmin.CloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmAdmin.edtFirstNameChange(Sender: TObject);
var
  sStudentID, sFirstname, sSurname: String;
begin
  sFirstname := edtFirstName.Text;
  sSurname := edtSurname.Text;

  Try
    sStudentID := FindStudent(sFirstname, sSurname);
  Except
    pnlStudentInfo.Caption := 'Not Student Found with that name';
    exit;
  End;

  pnlStudentInfo.Caption := 'Student Found'

end;

procedure TfrmAdmin.edtTeacherFirstNameChange(Sender: TObject);
var
  sTeacherID, sFirstname, sSurname: String;
begin
  sFirstname := edtTeacherFirstName.Text;
  sSurname := edtTeacherSurname.Text;

  Try
    sTeacherID := FindTeacher(sFirstname, sSurname);
  Except
    pnlTeacherSummary.Caption := 'Not Teacher Found with that name';
    exit;
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
  // RemoveDynamics;
  cbxAdmin.free;
  cbxHasClass.free;
  spnGrade.free;
  lblGrade.free;
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
    Cursor := crHandPoint;

    Caption := 'Search for Teacher';
    Visible := True;

  end;

end;

procedure TfrmAdmin.NewTeacher;
begin
  // Clear the panel
  // RemoveDynamics;
  edtNewStudentTeacherFirst.free;
  edtNewStudentTeacherSur.free;
  bbnNewStudentSearchTeacher.free;

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
    Cursor := crHandPoint;
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
    Cursor := crHandPoint;
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
  edtNewStudentTeacherFirst.free;
  edtNewStudentTeacherSur.free;
  bbnNewStudentSearchTeacher.free;

  // Teacher Dynamics
  cbxAdmin.free;
  cbxHasClass.free;
  spnGrade.free;
  lblGrade.free;

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
