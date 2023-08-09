object frmStart: TfrmStart
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Recycler'
  ClientHeight = 447
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Consolas'
  Font.Style = []
  Position = poDesigned
  OnShow = FormShow
  TextHeight = 18
  object pnlStats: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 369
    Height = 441
    Align = alLeft
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    TabOrder = 0
    object cStats: TChart
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 355
      Height = 218
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
      Left = 7
      Top = 231
      Width = 355
      Height = 194
      Cursor = crArrow
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
    Left = 378
    Top = 3
    Width = 231
    Height = 441
    Align = alLeft
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    TabOrder = 1
    object lblWelcom: TLabel
      AlignWithMargins = True
      Left = 14
      Top = 34
      Width = 203
      Height = 32
      Margins.Left = 10
      Margins.Top = 30
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      Alignment = taCenter
      Caption = 'Welcome'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 105
    end
    object bbnClose: TBitBtn
      AlignWithMargins = True
      Left = 14
      Top = 390
      Width = 203
      Height = 37
      Cursor = crHandPoint
      Hint = 'Close the app'
      Margins.Left = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      Kind = bkClose
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object bbnLogin: TBitBtn
      AlignWithMargins = True
      Left = 14
      Top = 340
      Width = 203
      Height = 37
      Cursor = crHandPoint
      Hint = 'Login'
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
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
