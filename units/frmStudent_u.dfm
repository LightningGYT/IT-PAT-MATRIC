object frmStudent: TfrmStudent
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Student'
  ClientHeight = 450
  ClientWidth = 627
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
    Height = 444
    Align = alLeft
    TabOrder = 0
    object cStats: TChart
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 398
      Height = 237
      Title.Text.Strings = (
        'Recycle History')
      View3D = False
      Align = alTop
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Button1: TButton
        Left = 160
        Top = 104
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 0
      end
      object Series1: TLineSeries
        HoverElement = [heCurrent]
        Title = 'RecycleHistory'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object redRecycleSummary: TRichEdit
      AlignWithMargins = True
      Left = 4
      Top = 247
      Width = 398
      Height = 193
      Align = alLeft
      TabOrder = 1
    end
  end
  object pnlControl: TPanel
    AlignWithMargins = True
    Left = 415
    Top = 3
    Width = 205
    Height = 444
    Align = alLeft
    TabOrder = 1
    object lblWelcome: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 197
      Height = 31
      Align = alTop
      Alignment = taCenter
      Caption = 'Welcome'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 98
    end
    object bbnLogout: TBitBtn
      AlignWithMargins = True
      Left = 11
      Top = 392
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
      OnClick = bbnLogoutClick
    end
    object redStudentSumary: TRichEdit
      AlignWithMargins = True
      Left = 4
      Top = 41
      Width = 197
      Height = 200
      Align = alTop
      TabOrder = 1
    end
  end
end
