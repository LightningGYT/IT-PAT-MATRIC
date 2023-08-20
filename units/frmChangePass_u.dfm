object frmChangePass: TfrmChangePass
  Left = 776
  Top = 415
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
  Position = poDesigned
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
    ExplicitWidth = 299
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
    ExplicitWidth = 299
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
    ImageIndex = 4
    ImageName = 'key'
    Images = frmStart.viIcons
    TabOrder = 2
    OnClick = bbnChangePassClick
    ExplicitTop = 150
    ExplicitWidth = 299
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
    ExplicitWidth = 295
  end
end
