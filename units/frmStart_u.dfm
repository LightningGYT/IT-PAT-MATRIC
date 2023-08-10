object frmStart: TfrmStart
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Recycler'
  ClientHeight = 560
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Consolas'
  Font.Style = []
  Position = poDesigned
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 22
  object pnlStats: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 461
    Height = 552
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alLeft
    Padding.Left = 4
    Padding.Top = 4
    Padding.Right = 4
    Padding.Bottom = 4
    TabOrder = 0
    object cStats: TChart
      AlignWithMargins = True
      Left = 9
      Top = 9
      Width = 443
      Height = 272
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Title.Text.Strings = (
        'Recycled Items')
      View3D = False
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      Align = alTop
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      PrintMargins = (
        15
        16
        15
        16)
      ColorPaletteIndex = 13
      object sRecycled: TPieSeries
        HoverElement = []
        Marks.Tail.Margin = 2
        Title = 'Recyled Items'
        XValues.Order = loAscending
        YValues.Name = 'Pie'
        YValues.Order = loNone
        Frame.InnerBrush.BackColor = clRed
        Frame.InnerBrush.Gradient.EndColor = clGray
        Frame.InnerBrush.Gradient.MidColor = clWhite
        Frame.InnerBrush.Gradient.StartColor = 4210752
        Frame.InnerBrush.Gradient.Visible = True
        Frame.MiddleBrush.BackColor = clYellow
        Frame.MiddleBrush.Gradient.EndColor = 8553090
        Frame.MiddleBrush.Gradient.MidColor = clWhite
        Frame.MiddleBrush.Gradient.StartColor = clGray
        Frame.MiddleBrush.Gradient.Visible = True
        Frame.OuterBrush.BackColor = clGreen
        Frame.OuterBrush.Gradient.EndColor = 4210752
        Frame.OuterBrush.Gradient.MidColor = clWhite
        Frame.OuterBrush.Gradient.StartColor = clSilver
        Frame.OuterBrush.Gradient.Visible = True
        Frame.Width = 4
        OtherSlice.Legend.Visible = False
        UsePatterns = True
        Data = {0000000000}
        Detail = {0000000000}
      end
    end
    object redLeaderBoard: TRichEdit
      AlignWithMargins = True
      Left = 9
      Top = 289
      Width = 443
      Height = 242
      Cursor = crArrow
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      Alignment = taCenter
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object pnlLogin: TPanel
    AlignWithMargins = True
    Left = 473
    Top = 4
    Width = 288
    Height = 552
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alLeft
    Padding.Left = 4
    Padding.Top = 4
    Padding.Right = 4
    Padding.Bottom = 4
    TabOrder = 1
    object lblWelcom: TLabel
      AlignWithMargins = True
      Left = 18
      Top = 43
      Width = 252
      Height = 40
      Margins.Left = 13
      Margins.Top = 38
      Margins.Right = 13
      Margins.Bottom = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Welcome'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -34
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 133
    end
    object bbnClose: TBitBtn
      AlignWithMargins = True
      Left = 18
      Top = 488
      Width = 252
      Height = 46
      Cursor = crHandPoint
      Hint = 'Close the app'
      Margins.Left = 13
      Margins.Top = 4
      Margins.Right = 13
      Margins.Bottom = 13
      Align = alBottom
      Kind = bkClose
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object bbnLogin: TBitBtn
      AlignWithMargins = True
      Left = 18
      Top = 425
      Width = 252
      Height = 46
      Cursor = crHandPoint
      Hint = 'Login'
      Margins.Left = 13
      Margins.Top = 13
      Margins.Right = 13
      Margins.Bottom = 13
      Align = alBottom
      Caption = '&Login'
      Default = True
      ModalResult = 1
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = bbnLoginClick
    end
  end
  object DEBUGINGREMOVE: TActionList
    Left = 442
    Top = 115
    object Student: TAction
      Caption = 'Student'
      ShortCut = 49235
      OnExecute = StudentExecute
    end
    object Teacher: TAction
      Caption = 'Teacher'
      ShortCut = 49236
      OnExecute = TeacherExecute
    end
  end
end
