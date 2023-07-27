object dmRecycle: TdmRecycle
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object conRecycle: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\data\Recycle.mdb;' +
      'Mode=ReadWrite;Persist Security Info=False'
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
end
