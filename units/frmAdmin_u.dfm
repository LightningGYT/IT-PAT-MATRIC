object frmAdmin: TfrmAdmin
  Left = 0
  Top = 0
  Caption = 'frmAdmin'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Consolas'
  Font.Style = []
  TextHeight = 18
  object pnlUsers: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 334
    Height = 436
    Align = alLeft
    TabOrder = 0
    object pcUsers: TPageControl
      AlignWithMargins = True
      Left = 11
      Top = 11
      Width = 312
      Height = 414
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      ActivePage = tsStudents
      Align = alClient
      TabOrder = 0
      object tsStudents: TTabSheet
        AlignWithMargins = True
        Caption = 'Students'
        object pnlSearchStudents: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 292
          Height = 190
          Align = alTop
          TabOrder = 0
          object edtFirstName: TEdit
            AlignWithMargins = True
            Left = 11
            Top = 11
            Width = 270
            Height = 26
            Cursor = crIBeam
            Hint = 'Firstname of Student'
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alTop
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            TextHint = 'Firstname'
            ExplicitLeft = 24
            ExplicitTop = 16
            ExplicitWidth = 121
          end
          object edtSurname: TEdit
            AlignWithMargins = True
            Left = 11
            Top = 57
            Width = 270
            Height = 26
            Hint = 'Surname of Student'
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alTop
            TabOrder = 1
            TextHint = 'Surname'
            ExplicitLeft = 16
            ExplicitTop = 72
            ExplicitWidth = 121
          end
          object pnlStudentInfo: TPanel
            AlignWithMargins = True
            Left = 11
            Top = 103
            Width = 270
            Height = 76
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alBottom
            Caption = 'Enter Details'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -15
            Font.Name = 'Consolas'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
        end
        object pnlEditStudent: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 199
          Width = 292
          Height = 173
          Align = alTop
          TabOrder = 1
          object bbnDelete: TBitBtn
            Left = 160
            Top = 120
            Width = 121
            Height = 44
            Cursor = crHandPoint
            Caption = '&Delete'
            TabOrder = 0
          end
          object bbnPassChange: TBitBtn
            Left = 11
            Top = 120
            Width = 114
            Height = 44
            Cursor = crHandPoint
            Caption = '&Password Change'
            TabOrder = 1
            WordWrap = True
          end
        end
      end
      object tsTeacher: TTabSheet
        Caption = 'Teacher'
        ImageIndex = 1
      end
    end
  end
end
