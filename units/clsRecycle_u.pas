unit clsRecycle_u;

interface

uses SysUtils, Generics.Collections, Vcl.Dialogs;

type
  TMaterial = record
    fID: String;
    fWieght: integer;
    fAmount: integer;
  end;

  TRecycler = class
  private
    fMaterials: TDictionary<String, TMaterial>;
    fHistory: TDictionary<String, integer>;
    procedure CalcMaterials;
    procedure CalcHistory;
  public
    constructor Create;
    function GetMaterials: TDictionary<String, TMaterial>;
    function GetHistory: TDictionary<String, integer>;
    function GetByStudent(sID: String): TDictionary<String, TMaterial>;
    function GetByClass(sID: String): TDictionary<String, TMaterial>;
  end;

const
  months: array of String = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL',
    'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];

implementation

{ TRecycler }

uses dmRecycle_u;

// Calculates the amounts recycled for that year by month
procedure TRecycler.CalcHistory;
var
  wToday: word;
begin
  fHistory := TDictionary<String, integer>.Create;
  wToday := CurrentYear;

  with dmRecycle.qryRecycle do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text :=
      'SELECT SUM(Weight) as tot, MONTH(Recycler_Date) as mon FROM Recycle WHERE (Recycler_Date BETWEEN #'
      + wToday.ToString + '/01/01# AND #' + wToday.ToString +
      '/12/31#) GROUP BY MONTH(Recycler_Date)';

    Active := True;

    First;
    while not EOF do
    begin
      fHistory.Add(months[FieldByName('mon').AsInteger - 1],
        FieldByName('tot').AsInteger);
      Next;
    end;

  end;

end;

// Get The total amounts of each material Recycled
procedure TRecycler.CalcMaterials;
var
  objMaterial: TMaterial;
begin

  fMaterials := TDictionary<String, TMaterial>.Create;

  with dmRecycle.qryMaterials do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Materials';
    ExecSQL;
    Active := True;

    while not EOF do
    begin

      objMaterial.fID := FieldByName('ID').AsString;

      with dmRecycle.qryRecycle do
      begin
        Active := False;
        SQL.Clear;

        SQL.Add('SELECT * FROM Recycle WHERE Material_ID = ' +
          QuotedStr(objMaterial.fID));

        Active := True;

        objMaterial.fAmount := RecordCount;
        objMaterial.fWieght := 0;

        while not EOF do
        begin
          objMaterial.fWieght := objMaterial.fWieght + FieldByName('Weight')
            .AsInteger;
          Next;
        end;

      end;

      fMaterials.Add(FieldByName('Material_Name').AsString, objMaterial);

      Next;
    end;

  end;
end;

constructor TRecycler.Create;
begin
  CalcMaterials;
  CalcHistory;
end;

function TRecycler.GetByClass(sID: String): TDictionary<String, TMaterial>;
var
  objMaterial: TMaterial;
  dictMaterials, dictStudentMaterials: TDictionary<String, TMaterial>;
  sKey: String;
begin

  dictMaterials := TDictionary<String, TMaterial>.Create;

  with dmRecycle.qryMaterials do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT Student_ID FROM ClassList WHERE Class_Id =:CLASSID';
    Parameters.ParamByName('CLASSID').Value := sID;

    Active := True;

    First;
    while not EOF do
    begin
      dictStudentMaterials := GetByStudent(FieldByName('Student_ID').AsString);

      for sKey in dictStudentMaterials.Keys do
      begin

        if dictMaterials.ContainsKey(sKey) then
        begin
          objMaterial := dictMaterials.Items[sKey];
          objMaterial.fWieght := objMaterial.fWieght + dictStudentMaterials.Items[sKey].fWieght;
          objMaterial.fAmount := objMaterial.fAmount + dictStudentMaterials.Items[sKey].fAmount;
          dictMaterials.AddOrSetValue(sKey, objMaterial);
        end
        else
        begin
          dictMaterials.Add(sKey, dictStudentMaterials.Items[sKey]);
        end;

      end;

      Next;
    end;

  end;

  Result := dictMaterials;

end;

function TRecycler.GetByStudent(sID: String): TDictionary<String, TMaterial>;
var
  objMaterial: TMaterial;
  Materials: TDictionary<String, TMaterial>;
  key: String;
begin

  Materials := TDictionary<String, TMaterial>.Create;

  for key in fMaterials.Keys do
  begin

    objMaterial.fID := fMaterials[key].fID;

    with dmRecycle.qryRecycle do
    begin
      Active := False;
      SQL.Clear;

      SQL.Add('SELECT * FROM Recycle WHERE (Material_ID = ' +
        QuotedStr(objMaterial.fID) + ') AND (Student_ID = ' +
        QuotedStr(sID) + ')');

      Active := True;

      objMaterial.fAmount := RecordCount;
      objMaterial.fWieght := 0;

      while not EOF do
      begin
        objMaterial.fWieght := objMaterial.fWieght + FieldByName('Weight')
          .AsInteger;
        Next;
      end;

    end;

    Materials.Add(key, objMaterial);
  end;

  Result := Materials;
end;

function TRecycler.GetHistory: TDictionary<String, integer>;
begin
  Result := fHistory;
end;

function TRecycler.GetMaterials: TDictionary<String, TMaterial>;
begin
  Result := fMaterials;
end;

end.
