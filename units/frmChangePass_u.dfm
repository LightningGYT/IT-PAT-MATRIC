object frmChangePass: TfrmChangePass
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Change Password'
  ClientHeight = 193
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Consolas'
  Font.Style = []
  TextHeight = 17
  object lblMessage: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 303
    Height = 17
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Alignment = taCenter
    Caption = 'Please change your password'
    ExplicitWidth = 216
  end
  object edtPass1: TEdit
    AlignWithMargins = True
    Left = 8
    Top = 41
    Width = 303
    Height = 25
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Alignment = taCenter
    PasswordChar = '*'
    TabOrder = 0
    TextHint = 'New password'
  end
  object edtPass2: TEdit
    AlignWithMargins = True
    Left = 8
    Top = 82
    Width = 303
    Height = 25
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Alignment = taCenter
    PasswordChar = '*'
    TabOrder = 1
    TextHint = 'Confirm Password'
  end
  object bbnChangePass: TBitBtn
    AlignWithMargins = True
    Left = 8
    Top = 151
    Width = 303
    Height = 34
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alBottom
    Caption = '&Change password'
    TabOrder = 2
    OnClick = bbnChangePassClick
    ExplicitLeft = 13
    ExplicitTop = 146
  end
  object cbxVissPass: TCheckBox
    AlignWithMargins = True
    Left = 10
    Top = 125
    Width = 299
    Height = 17
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    Caption = 'Show Password'
    TabOrder = 3
    OnClick = cbxVissPassClick
  end
end
