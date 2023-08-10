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
    function GetByStudent(sID: String): TDictionary<String, TMaterial>;
  end;

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

    SQL.Text := 'SELECT SUM(Weight) as tot FROM Recycle '

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

    while not Eof do
    begin

      objMaterial.fID := FieldByName('ID').AsString;

      with dmRecycle.qryRecycle do
      begin
        Active := False;
        SQL.Clear;

        SQL.ADd('SELECT * FROM Recycle WHERE Material_ID = ' +
          QuotedStr(objMaterial.fID));

        Active := True;

        objMaterial.fAmount := RecordCount;
        objMaterial.fWieght := 0;

        while not Eof do
        begin
          objMaterial.fWieght := objMaterial.fWieght + FieldByName('Weight')
            .AsInteger;
          Next;
        end;

      end;

      fMaterials.ADd(FieldByName('Material_Name').AsString, objMaterial);

      Next;
    end;

  end;
end;

constructor TRecycler.Create;
begin
  CalcMaterials;
  CalcHistory;
end;

function TRecycler.GetByStudent(sID: String): TDictionary<String, TMaterial>;
var
  objMaterial: TMaterial;
  Materials: TDictionary<String, TMaterial>;
begin

  Materials := TDictionary<String, TMaterial>.Create;

  with dmRecycle.qryMaterials do
  begin
    Active := False;
    SQL.Clear;

    SQL.Text := 'SELECT * FROM Materials';
    ExecSQL;
    Active := True;

    while not Eof do
    begin

      objMaterial.fID := FieldByName('ID').AsString;

      with dmRecycle.qryRecycle do
      begin
        Active := False;
        SQL.Clear;

        SQL.ADd('SELECT * FROM Recycle WHERE (Material_ID = ' +
          QuotedStr(objMaterial.fID) + ') AND (Student_ID = ' +
          QuotedStr(sID) + ')');

        Active := True;

        objMaterial.fAmount := RecordCount;
        objMaterial.fWieght := 0;

        while not Eof do
        begin
          objMaterial.fWieght := objMaterial.fWieght + FieldByName('Weight')
            .AsInteger;
          Next;
        end;

      end;

      Materials.ADd(FieldByName('Material_Name').AsString, objMaterial);

      Next;
    end;

  end;

  Result := Materials;
end;

function TRecycler.GetMaterials: TDictionary<String, TMaterial>;
begin
  Result := fMaterials;
end;

end.
