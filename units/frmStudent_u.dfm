object frmStudent: TfrmStudent
  Left = 0
  Top = 0
  Caption = 'Student'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Consolas'
  Font.Style = []
  Position = poDesigned
  TextHeight = 18
  object pnlStats: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 406
    Height = 436
    Align = alLeft
    TabOrder = 0
    object cStats: TChart
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 398
      Height = 237
      Title.Text.Strings = (
        'TChart')
      Align = alTop
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
  end
  object pnlControl: TPanel
    AlignWithMargins = True
    Left = 415
    Top = 3
    Width = 205
    Height = 436
    Align = alLeft
    TabOrder = 1
    object bbnLogout: TBitBtn
      AlignWithMargins = True
      Left = 11
      Top = 384
      Width = 183
      Height = 41
      Cursor = crHandPoint
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      Caption = '&Logout'
      TabOrder = 0
    end
  end
end
