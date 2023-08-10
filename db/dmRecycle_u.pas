unit dmRecycle_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdmRecycle = class(TDataModule)
    conRecycle: TADOConnection;
    qryRecycle: TADOQuery;
    qryMaterials: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmRecycle: TdmRecycle;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmRecycle.DataModuleCreate(Sender: TObject);
begin
  conRecycle.Connected := True;
end;

end.
