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
  OnShow = FormShow
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
        'Recycled')
      View3D = False
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      Align = alTop
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object sRecycled: TPieSeries
        HoverElement = []
        Marks.Tail.Margin = 2
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
