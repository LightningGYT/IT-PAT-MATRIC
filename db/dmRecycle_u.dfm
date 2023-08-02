object dmRecycle: TdmRecycle
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object conRecycle: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\data\Recycler.mdb' +
      ';Mode=ReadWrite;Persist Security Info=False'
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 104
    Top = 160
  end
  object qryRecycle: TADOQuery
    Connection = conRecycle
    Parameters = <>
    Left = 104
    Top = 240
  end
  object qryMaterials: TADOQuery
    Connection = conRecycle
    Parameters = <>
    Left = 112
    Top = 320
  end
  object qryUsers: TADOQuery
    Connection = conRecycle
    Parameters = <>
    Left = 224
    Top = 240
  end
end
