object frmAdmin: TfrmAdmin
  Left = 0
  Top = 0
  Caption = 'frmAdmin'
  ClientHeight = 491
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Consolas'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 18
  object pnlUsers: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 334
    Height = 485
    Align = alLeft
    TabOrder = 0
    ExplicitHeight = 528
    object pcUsers: TPageControl
      AlignWithMargins = True
      Left = 11
      Top = 11
      Width = 312
      Height = 463
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      ActivePage = tsAddUser
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 413
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
            OnChange = edtFirstNameChange
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
            OnChange = edtFirstNameChange
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
          Height = 222
          Align = alTop
          TabOrder = 1
          object bbnDelete: TBitBtn
            Left = 160
            Top = 168
            Width = 121
            Height = 44
            Cursor = crHandPoint
            Caption = '&Delete'
            TabOrder = 0
            OnClick = bbnDeleteClick
          end
          object bbnPassChange: TBitBtn
            Left = 11
            Top = 168
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
        object pnlSearchTeacher: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 298
          Height = 198
          Align = alTop
          TabOrder = 0
          object pnlTeacherSummary: TPanel
            AlignWithMargins = True
            Left = 11
            Top = 112
            Width = 276
            Height = 75
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alBottom
            Caption = 'Enter Deatials'
            TabOrder = 0
          end
          object edtTeacherFirstName: TEdit
            AlignWithMargins = True
            Left = 11
            Top = 11
            Width = 276
            Height = 26
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alTop
            TabOrder = 1
            TextHint = 'Firstname'
            OnChange = edtTeacherFirstNameChange
          end
          object edtTeacherSurname: TEdit
            AlignWithMargins = True
            Left = 11
            Top = 57
            Width = 276
            Height = 26
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alTop
            TabOrder = 2
            TextHint = 'Surname'
            OnChange = edtTeacherFirstNameChange
          end
        end
        object bbnTeacherChangePassword: TBitBtn
          Left = 14
          Top = 368
          Width = 115
          Height = 49
          Caption = '&Password Change'
          TabOrder = 1
          WordWrap = True
        end
        object bbnAddClass: TBitBtn
          Left = 168
          Top = 368
          Width = 121
          Height = 49
          Caption = 'Create Class'
          TabOrder = 2
          OnClick = bbnAddClassClick
        end
        object spnAddGrade: TSpinEdit
          Left = 14
          Top = 320
          Width = 275
          Height = 28
          MaxValue = 12
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
      end
      object tsAddUser: TTabSheet
        Caption = 'New User'
        ImageIndex = 2
        object pnlAddName: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 298
          Height = 190
          Align = alTop
          TabOrder = 0
          object edtAddFirstname: TEdit
            AlignWithMargins = True
            Left = 11
            Top = 11
            Width = 276
            Height = 26
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alTop
            TabOrder = 0
            TextHint = 'Firstname'
          end
          object edtAddSurname: TEdit
            AlignWithMargins = True
            Left = 11
            Top = 57
            Width = 276
            Height = 26
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alTop
            TabOrder = 1
            TextHint = 'Surname'
          end
          object rgType: TRadioGroup
            AlignWithMargins = True
            Left = 11
            Top = 103
            Width = 276
            Height = 74
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alTop
            Caption = 'User Type'
            Items.Strings = (
              'Student'
              'Teacher')
            TabOrder = 2
            OnClick = rgTypeClick
          end
        end
        object pnlAddOtherInfo: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 199
          Width = 298
          Height = 186
          Align = alTop
          TabOrder = 1
        end
        object bbnAdd: TBitBtn
          Left = 176
          Top = 391
          Width = 125
          Height = 35
          Caption = 'Add New User'
          TabOrder = 2
        end
        object bbnRetry: TBitBtn
          Left = 3
          Top = 391
          Width = 118
          Height = 35
          Kind = bkRetry
          NumGlyphs = 2
          TabOrder = 3
        end
      end
    end
  end
  object pnlMaterials: TPanel
    AlignWithMargins = True
    Left = 343
    Top = 3
    Width = 282
    Height = 485
    Align = alRight
    TabOrder = 1
    object lbMaterials: TListBox
      AlignWithMargins = True
      Left = 11
      Top = 11
      Width = 260
      Height = 142
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      ItemHeight = 18
      TabOrder = 0
    end
    object bbnDeleteMaterial: TBitBtn
      Left = 160
      Top = 166
      Width = 111
      Height = 54
      Caption = 'Delete &Material'
      TabOrder = 1
      WordWrap = True
      OnClick = bbnDeleteMaterialClick
    end
    object bbnAddMaterial: TBitBtn
      Left = 11
      Top = 166
      Width = 121
      Height = 54
      Caption = '&Add Material'
      TabOrder = 2
      WordWrap = True
      OnClick = bbnAddMaterialClick
    end
    object bbnClose: TBitBtn
      Left = 172
      Top = 429
      Width = 99
      Height = 35
      Caption = '&Close'
      TabOrder = 3
      OnClick = bbnCloseClick
    end
  end
end
