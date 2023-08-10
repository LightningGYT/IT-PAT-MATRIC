object dmRecycle: TdmRecycle
  OnCreate = DataModuleCreate
  Height = 600
  Width = 800
  PixelsPerInch = 120
  object conRecycle: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\data\Recycler.mdb' +
      ';Mode=ReadWrite;Persist Security Info=False'
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 130
    Top = 200
  end
  object qryRecycle: TADOQuery
    Connection = conRecycle
    Parameters = <>
    Left = 130
    Top = 300
  end
  object qryMaterials: TADOQuery
    Connection = conRecycle
    Parameters = <>
    Left = 140
    Top = 400
  end
end
