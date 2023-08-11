unit frmRecycler_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, Generics.Collections, clsRecycle_u;

type
  TfrmRecycle = class(TForm)
    pnlStudent: TPanel;
    lblStudent: TLabel;
    edtSurname: TEdit;
    edtFirstname: TEdit;
    pnlMaterials: TPanel;
    cbxMaterials: TComboBox;
    spnWeight: TSpinEdit;
    bbnRecycle: TBitBtn;
    lblWeight: TLabel;
    lblMaterial: TLabel;
    bbnCancel: TBitBtn;
    lblMaterialHeader: TLabel;
    procedure bbnRecycleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fMaterials: TDictionary<String, TMaterial>;
  public
    { Public declarations }
  end;

var
  frmRecycle: TfrmRecycle;

implementation

{$R *.dfm}

uses frmStart_u, clsUsers_u;

procedure TfrmRecycle.bbnRecycleClick(Sender: TObject);
var
  sFirstname, sSurname, sStudentID, sMaterialID, sMaterial: String;
  iWieght: Integer;
begin
  sFirstname := edtFirstname.Text;
  sSurname := edtSurname.Text;

  // prep inputs
  sFirstname := sFirstname.Trim;
  sSurname := sSurname.Trim;

  if sFirstname.IsEmpty then
  begin
    MessageDlg('Please Enter A Name', TMsgDlgType.mtWarning, [mbOK], 1);
    edtFirstname.SetFocus;
    exit;
  end;

  if sSurname.IsEmpty then
  begin
    MessageDlg('Please Enter A Surname', TMsgDlgType.mtWarning, [mbOK], 1);
    edtSurname.SetFocus;
    exit;
  end;

  try
    sStudentID := FindStudent(sFirstname, sSurname);
  except
    begin
      MessageDlg('Cannot find Student with that name', TMsgDlgType.mtError,
        [mbOK], 1);
      edtFirstname.SetFocus;
      exit;
    end;
  end;

  // Material inputs
  iWieght := spnWeight.Value;

  if iWieght = 0 then
  begin
    MessageDlg('Please enter a value above 0', TMsgDlgType.mtWarning,
      [mbOK], 1);
    spnWeight.SetFocus;
    exit;
  end;

  if cbxMaterials.ItemIndex = -1 then
  begin
    MessageDlg('Please select a Material', TMsgDlgType.mtWarning, [mbOK], 1);
    cbxMaterials.SetFocus;
    exit;
  end;

  sMaterial := cbxMaterials.Items[cbxMaterials.ItemIndex];

  sMaterialID := fMaterials.Items[sMaterial].fID;

  if MessageDlg(format('Confirm that %s %s has Recycled %dg of %s',
    [sFirstname, sSurname, iWieght, sMaterial]), TMsgDlgType.mtConfirmation,
    mbYesNo, 1) = mrYes then
  begin
    if objRecycle.Recycle(sStudentID, sMaterialID, iWieght) then
    begin
      MessageDlg('Succesesfully Recorded', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 1);
      close;
    end
    else
    begin
      if MessageDlg('Fail!', TMsgDlgType.mtError, mbAbortIgnore, 1) = mrRetry then
      begin
        bbnRecycleClick(Sender);
      end;
    end;
  end;

end;

procedure TfrmRecycle.FormShow(Sender: TObject);
var
  sKey: String;
begin
  edtSurname.Clear;
  edtFirstname.Clear;
  fMaterials := objRecycle.GetMaterials;

  cbxMaterials.Items.Clear;

  for sKey in fMaterials.Keys do
  begin
    cbxMaterials.Items.Add(sKey)
  end;

end;

end.
