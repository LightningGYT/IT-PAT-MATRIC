object frmRecycle: TfrmRecycle
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Recycler'
  ClientHeight = 467
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Consolas'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 18
  object pnlStudent: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 329
    Height = 166
    Align = alTop
    TabOrder = 0
    object lblStudent: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 321
      Height = 24
      Align = alTop
      Alignment = taCenter
      Caption = 'Enter Student Details'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Consolas'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      ExplicitWidth = 252
    end
    object edtSurname: TEdit
      AlignWithMargins = True
      Left = 11
      Top = 125
      Width = 307
      Height = 30
      Cursor = crIBeam
      Hint = 'Student'#39's Surname'
      Margins.Left = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TextHint = 'Surname'
      ExplicitTop = 148
    end
    object edtFirstname: TEdit
      AlignWithMargins = True
      Left = 11
      Top = 82
      Width = 307
      Height = 30
      Cursor = crIBeam
      Hint = 'Student'#39's Fristname'
      Margins.Left = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TextHint = 'Firstname'
      ExplicitTop = 95
    end
  end
  object pnlMaterials: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 175
    Width = 329
    Height = 289
    Align = alTop
    TabOrder = 1
    ExplicitLeft = -2
    object lblWeight: TLabel
      Left = 11
      Top = 96
      Width = 88
      Height = 18
      Caption = 'Weight (g):'
    end
    object lblMaterial: TLabel
      Left = 11
      Top = 56
      Width = 72
      Height = 18
      Caption = 'Material:'
    end
    object lblMaterialHeader: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 321
      Height = 24
      Align = alTop
      Alignment = taCenter
      Caption = 'Enter Material Detials'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Consolas'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      ExplicitWidth = 264
    end
    object cbxMaterials: TComboBox
      AlignWithMargins = True
      Left = 144
      Top = 56
      Width = 174
      Height = 26
      Cursor = crHandPoint
      Hint = 'Materials'
      AutoCloseUp = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '--Select Material--'
    end
    object spnWeight: TSpinEdit
      Left = 197
      Top = 98
      Width = 121
      Height = 28
      Hint = 'Weight of Material in grams'
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 0
    end
    object bbnRecycle: TBitBtn
      AlignWithMargins = True
      Left = 11
      Top = 178
      Width = 307
      Height = 40
      Cursor = crHandPoint
      Hint = 'Submit Recycling'
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      Caption = '&Recycle'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = bbnRecycleClick
      ExplicitTop = 89
    end
    object bbnCancel: TBitBtn
      AlignWithMargins = True
      Left = 11
      Top = 238
      Width = 307
      Height = 40
      Cursor = crHandPoint
      Hint = 'Cancel Recycling'
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      Caption = '&Cancel'
      Kind = bkCancel
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      ExplicitTop = 151
    end
  end
end
