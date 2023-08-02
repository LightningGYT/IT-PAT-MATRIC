object frmTeacher: TfrmTeacher
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Teacher'
  ClientHeight = 554
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Consolas'
  Font.Style = []
  PixelsPerInch = 120
  TextHeight = 22
  object pnlFunctions: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 467
    Height = 546
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alLeft
    TabOrder = 0
    object pnlStudents: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 457
      Height = 276
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      TabOrder = 0
      object lsbStudents: TListBox
        Left = 10
        Top = 20
        Width = 221
        Height = 121
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ItemHeight = 22
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
        TabOrder = 0
      end
      object redStudentSumary: TRichEdit
        Left = 10
        Top = 149
        Width = 441
        Height = 111
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabOrder = 1
      end
      object bbnStudentRecycle: TBitBtn
        Left = 239
        Top = 90
        Width = 212
        Height = 51
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Recycle &For Student'
        TabOrder = 2
      end
    end
    object pnlAdmin: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 289
      Width = 457
      Height = 252
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      TabOrder = 1
      object pcAdmin: TPageControl
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 447
        Height = 242
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ActivePage = tsMaterials
        Align = alClient
        TabOrder = 0
        object tsMaterials: TTabSheet
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Materials'
        end
        object tsUsers: TTabSheet
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Users'
          ImageIndex = 1
        end
        object tsRecycle: TTabSheet
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Recycle'
          ImageIndex = 2
        end
      end
    end
  end
  object pnlOther: TPanel
    AlignWithMargins = True
    Left = 479
    Top = 4
    Width = 262
    Height = 546
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alLeft
    TabOrder = 1
    object pnlTeacher: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 252
      Height = 276
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      TabOrder = 0
      object lblWelcome: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 242
        Height = 38
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alTop
        Alignment = taCenter
        Caption = 'Welcome'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -33
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 126
      end
      object redSummary: TRichEdit
        AlignWithMargins = True
        Left = 5
        Top = 51
        Width = 242
        Height = 210
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alTop
        TabOrder = 0
      end
    end
    object pnlControl: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 289
      Width = 252
      Height = 252
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      TabOrder = 1
      object bbnLogOut: TBitBtn
        AlignWithMargins = True
        Left = 5
        Top = 197
        Width = 242
        Height = 50
        Cursor = crHandPoint
        Hint = 'Logout'
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alBottom
        Caption = '&LogOut'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ExplicitTop = 200
      end
      object bbnRecycle: TBitBtn
        AlignWithMargins = True
        Left = 5
        Top = 139
        Width = 242
        Height = 50
        Cursor = crHandPoint
        Hint = 'Add a students Recycling'
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alBottom
        Caption = '&Recycle'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        ExplicitTop = 137
      end
    end
  end
end
