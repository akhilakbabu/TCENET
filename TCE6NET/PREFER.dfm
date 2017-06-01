object FrmOptions: TFrmOptions
  Left = 199
  Top = 190
  HelpContext = 16
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Preferences'
  ClientHeight = 358
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonPanel: TPanel
    Left = 507
    Top = 0
    Width = 85
    Height = 337
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object Label8: TLabel
      Left = 22
      Top = 208
      Width = 47
      Height = 29
      Alignment = taCenter
      AutoSize = False
      Caption = 'Color Printer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label9: TLabel
      Left = 17
      Top = 142
      Width = 53
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'Formfeed'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object OKBtn: TBitBtn
      Left = 5
      Top = 22
      Width = 75
      Height = 25
      Hint = 'Set preferences'
      Caption = 'O&K'
      Default = True
      TabOrder = 0
      OnClick = OKBtnClick
      Glyph.Data = {
        BE060000424DBE06000000000000360400002800000024000000120000000100
        0800000000008802000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
        0303030303030303030303030303030303030303030303030303030303030303
        03030303030303030303030303030303030303030303FF030303030303030303
        03030303030303040403030303030303030303030303030303F8F8FF03030303
        03030303030303030303040202040303030303030303030303030303F80303F8
        FF030303030303030303030303040202020204030303030303030303030303F8
        03030303F8FF0303030303030303030304020202020202040303030303030303
        0303F8030303030303F8FF030303030303030304020202FA0202020204030303
        0303030303F8FF0303F8FF030303F8FF03030303030303020202FA03FA020202
        040303030303030303F8FF03F803F8FF0303F8FF03030303030303FA02FA0303
        03FA0202020403030303030303F8FFF8030303F8FF0303F8FF03030303030303
        FA0303030303FA0202020403030303030303F80303030303F8FF0303F8FF0303
        0303030303030303030303FA0202020403030303030303030303030303F8FF03
        03F8FF03030303030303030303030303FA020202040303030303030303030303
        0303F8FF0303F8FF03030303030303030303030303FA02020204030303030303
        03030303030303F8FF0303F8FF03030303030303030303030303FA0202020403
        030303030303030303030303F8FF0303F8FF03030303030303030303030303FA
        0202040303030303030303030303030303F8FF03F8FF03030303030303030303
        03030303FA0202030303030303030303030303030303F8FFF803030303030303
        030303030303030303FA0303030303030303030303030303030303F803030303
        0303030303030303030303030303030303030303030303030303030303030303
        0303}
      Margin = 2
      NumGlyphs = 2
      Spacing = -1
      IsControl = True
    end
    object CancelBtn: TBitBtn
      Left = 5
      Top = 52
      Width = 75
      Height = 25
      Hint = 'Exit from dialogue'
      Cancel = True
      Caption = '&Cancel'
      TabOrder = 1
      OnClick = CancelBtnClick
      Glyph.Data = {
        BE060000424DBE06000000000000360400002800000024000000120000000100
        0800000000008802000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
        0303030303030303030303030303030303030303030303030303030303030303
        0303F8F80303030303030303030303030303030303FF03030303030303030303
        0303030303F90101F80303030303F9F80303030303030303F8F8FF0303030303
        03FF03030303030303F9010101F8030303F90101F8030303030303F8FF03F8FF
        030303FFF8F8FF030303030303F901010101F803F901010101F80303030303F8
        FF0303F8FF03FFF80303F8FF030303030303F901010101F80101010101F80303
        030303F8FF030303F8FFF803030303F8FF030303030303F90101010101010101
        F803030303030303F8FF030303F803030303FFF80303030303030303F9010101
        010101F8030303030303030303F8FF030303030303FFF8030303030303030303
        030101010101F80303030303030303030303F8FF0303030303F8030303030303
        0303030303F901010101F8030303030303030303030303F8FF030303F8030303
        0303030303030303F90101010101F8030303030303030303030303F803030303
        F8FF030303030303030303F9010101F8010101F803030303030303030303F803
        03030303F8FF0303030303030303F9010101F803F9010101F803030303030303
        03F8030303F8FF0303F8FF03030303030303F90101F8030303F9010101F80303
        03030303F8FF0303F803F8FF0303F8FF03030303030303F9010303030303F901
        0101030303030303F8FFFFF8030303F8FF0303F8FF0303030303030303030303
        030303F901F903030303030303F8F80303030303F8FFFFFFF803030303030303
        03030303030303030303030303030303030303030303030303F8F8F803030303
        0303030303030303030303030303030303030303030303030303030303030303
        0303}
      Margin = 2
      NumGlyphs = 2
      Spacing = -1
      IsControl = True
    end
    object HelpBtn: TBitBtn
      Left = 5
      Top = 82
      Width = 75
      Height = 25
      Hint = 'How do I ...'
      TabOrder = 2
      Kind = bkHelp
      Margin = 2
      Spacing = -1
      IsControl = True
    end
    object CheckBox11: TCheckBox
      Left = 38
      Top = 236
      Width = 13
      Height = 13
      Hint = 'Check to print in colour'
      Caption = 'CheckBox11'
      TabOrder = 3
    end
    object CheckBox12: TCheckBox
      Left = 38
      Top = 158
      Width = 17
      Height = 17
      Hint = 'Print each list on new page'
      TabOrder = 4
    end
  end
  object Notebook: TNotebook
    Left = 0
    Top = 0
    Width = 507
    Height = 337
    Align = alClient
    PageIndex = 2
    TabOrder = 2
    IsControl = True
    object TPage
      Left = 0
      Top = 0
      Caption = 'Timetable'
      IsControl = True
      object grbTimetable: TGroupBox
        Left = 4
        Top = 0
        Width = 501
        Height = 264
        Caption = 'Timetable'
        TabOrder = 0
        IsControl = True
        object Label6: TLabel
          Left = 10
          Top = 21
          Width = 23
          Height = 13
          Caption = '&Day'
          FocusControl = ComboBox2
        end
        object DayLabel1: TLabel
          Left = 168
          Top = 21
          Width = 61
          Height = 13
          Caption = 'DayLabel1'
        end
        object Label4: TLabel
          Left = 10
          Top = 43
          Width = 106
          Height = 13
          Caption = 'Time Slots Shown:'
        end
        object ComboBox2: TComboBox
          Left = 43
          Top = 17
          Width = 115
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = ComboBox2Change
        end
        object YearClass1: TRadioGroup
          Left = 7
          Top = 207
          Width = 380
          Height = 33
          Caption = 'Show Year/Roll Class'
          Columns = 4
          Items.Strings = (
            '&Either'
            'Ye&ar'
            '&Roll Class'
            '&None')
          TabOrder = 1
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Print Timetable'
      object grbPrintTimetable: TGroupBox
        Left = 4
        Top = 0
        Width = 501
        Height = 327
        Caption = 'Print Timetable'
        TabOrder = 0
        IsControl = True
        object Label2: TLabel
          Left = 8
          Top = 16
          Width = 75
          Height = 13
          Caption = 'Days Shown:'
        end
        object Label3: TLabel
          Left = 8
          Top = 124
          Width = 79
          Height = 13
          Caption = 'Years Shown:'
        end
        object Label5: TLabel
          Left = 286
          Top = 268
          Width = 158
          Height = 13
          Hint = 'Set number of weekly timetable per page on printouts'
          Caption = '&Weekly timetables per page'
          FocusControl = MaskEdit1
        end
        object CheckBox9: TCheckBox
          Left = 206
          Top = 290
          Width = 147
          Height = 17
          Hint = 'Show Teachers free at bottom of main timetable'
          Caption = 'Show &Teachers Free'
          TabOrder = 0
        end
        object CheckBox10: TCheckBox
          Left = 366
          Top = 291
          Width = 125
          Height = 17
          Hint = 'Show Rooms free at bottom of main timetable'
          Caption = 'Show &Rooms Free'
          TabOrder = 1
        end
        object MaskEdit1: TMaskEdit
          Left = 452
          Top = 259
          Width = 21
          Height = 21
          Hint = 'Enter number of weekly timetables printed per page'
          EditMask = '99;1; '
          MaxLength = 2
          TabOrder = 2
          Text = '  '
          OnKeyPress = MaskEdit1KeyPress
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Student'
      IsControl = True
      object grbStudent: TGroupBox
        Left = 4
        Top = 0
        Width = 501
        Height = 264
        Caption = 'Student Lists'
        TabOrder = 0
        IsControl = True
        object Label1: TLabel
          Left = 12
          Top = 26
          Width = 80
          Height = 13
          Caption = 'Fields Shown:'
        end
        object CheckBox1: TCheckBox
          Left = 12
          Top = 68
          Width = 97
          Height = 17
          Hint = 'Check to show students'#39' gender'
          Caption = '&Sex'
          TabOrder = 0
        end
        object CheckBox2: TCheckBox
          Left = 12
          Top = 89
          Width = 97
          Height = 17
          Hint = 'Check to show students'#39' roll class'
          Caption = 'C&lass'
          TabOrder = 1
        end
        object CheckBox3: TCheckBox
          Left = 12
          Top = 110
          Width = 97
          Height = 17
          Hint = 'Check to show students'#39' house'
          Caption = 'Ho&use'
          TabOrder = 2
        end
        object CheckBox4: TCheckBox
          Left = 12
          Top = 131
          Width = 97
          Height = 17
          Hint = 'Check to show students'#39' ID'
          Caption = '&ID'
          TabOrder = 3
        end
        object CheckBox5: TCheckBox
          Left = 12
          Top = 157
          Width = 97
          Height = 17
          Hint = 'Check to show students'#39' tutor'
          Caption = '&Tutor'
          TabOrder = 4
        end
        object CheckBox6: TCheckBox
          Left = 12
          Top = 182
          Width = 97
          Height = 17
          Hint = 'Check to show students'#39' home room'
          Caption = 'H&ome Room'
          TabOrder = 5
        end
        object GroupBox6: TGroupBox
          Left = 310
          Top = 23
          Width = 115
          Height = 107
          Hint = 'Set gender order for student list windows'
          Caption = 'Gender Order'
          TabOrder = 6
          object RadioButton5: TRadioButton
            Left = 8
            Top = 20
            Width = 85
            Height = 17
            Caption = '&Both Sexes'
            TabOrder = 0
          end
          object RadioButton6: TRadioButton
            Left = 8
            Top = 45
            Width = 100
            Height = 17
            Caption = '&Females First'
            TabOrder = 1
          end
          object RadioButton7: TRadioButton
            Left = 8
            Top = 70
            Width = 83
            Height = 17
            Caption = '&Males First'
            TabOrder = 2
          end
        end
        object CheckBox8: TCheckBox
          Left = 348
          Top = 168
          Width = 125
          Height = 17
          Hint = 'Check for double spaced lists'
          Caption = '&Double Space lists'
          TabOrder = 7
        end
        object CheckBox7: TCheckBox
          Left = 346
          Top = 142
          Width = 121
          Height = 17
          Hint = 
            'If not selected, teacher and room seeks are restricted to studen' +
            'ts year on timetable'
          Caption = 'M&atch all years'
          TabOrder = 8
        end
        object CheckBox26: TCheckBox
          Left = 12
          Top = 47
          Width = 65
          Height = 17
          Hint = 'Check to show students'#39' year'
          Caption = '&Year'
          TabOrder = 9
        end
        object ListStyle1: TRadioGroup
          Left = 142
          Top = 23
          Width = 129
          Height = 107
          Caption = 'List Style'
          Items.Strings = (
            '&Name Only'
            'Other Sub&jects'
            'Fo&rm with boxes'
            'Form with lin&es')
          TabOrder = 10
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Extras lists'
      object GroupBox4: TGroupBox
        Left = 16
        Top = 16
        Width = 471
        Height = 111
        Caption = 'Show'
        TabOrder = 0
        object Label7: TLabel
          Left = 312
          Top = 28
          Width = 63
          Height = 13
          Caption = '&Blank lines'
          FocusControl = Edit1
        end
        object CheckBox13: TCheckBox
          Left = 20
          Top = 26
          Width = 117
          Height = 17
          Hint = 
            'Show absence reasons and codes on the absent teacher and cover t' +
            'eacher lists'
          Caption = '&Absence reason'
          TabOrder = 0
        end
        object CheckBox14: TCheckBox
          Left = 168
          Top = 26
          Width = 97
          Height = 17
          Hint = 
            'Include details of the class to be covered and then a list of st' +
            'udents in the class'
          Caption = 'St&udent list'
          TabOrder = 1
        end
        object CheckBox15: TCheckBox
          Left = 20
          Top = 64
          Width = 127
          Height = 17
          Hint = 'Show teacher changes only'
          Caption = '&Teacher changes'
          TabOrder = 2
        end
        object CheckBox16: TCheckBox
          Left = 168
          Top = 64
          Width = 121
          Height = 17
          Hint = 'Show room changes only'
          Caption = '&Room Changes'
          TabOrder = 3
        end
        object CheckBox25: TCheckBox
          Left = 312
          Top = 64
          Width = 121
          Height = 17
          Hint = 'Show summary at start of all current extras lists'
          Caption = '&Summary'
          TabOrder = 4
        end
        object Edit1: TEdit
          Left = 382
          Top = 26
          Width = 35
          Height = 21
          Hint = 
            'Number of lines to print after each time slot (by time slot), te' +
            'acher (by absent, cover teacher or added staff) or year (by year' +
            ')'
          MaxLength = 2
          TabOrder = 5
          Text = 'Edit1'
          OnKeyPress = Edit1KeyPress
        end
        object CheckBox27: TCheckBox
          Left = 312
          Top = 87
          Width = 121
          Height = 17
          Hint = 'Show summary at start of all current extras lists'
          Caption = 'Start/&End Times'
          TabOrder = 6
        end
      end
      object GroupBox10: TGroupBox
        Left = 16
        Top = 142
        Width = 471
        Height = 105
        Hint = 'These settings control the amount of detail in the summary'
        Caption = 'Summary'
        TabOrder = 1
        object CheckBox17: TCheckBox
          Left = 14
          Top = 28
          Width = 109
          Height = 17
          Hint = 'Show teachers absent with their teaching load'
          Caption = 'T&eacher absent'
          TabOrder = 0
        end
        object CheckBox18: TCheckBox
          Left = 155
          Top = 28
          Width = 82
          Height = 17
          Hint = 'Include absence codes and reasons with the absent teachers'
          Caption = 'Reaso&n'
          TabOrder = 1
        end
        object CheckBox19: TCheckBox
          Left = 246
          Top = 28
          Width = 97
          Height = 17
          Hint = 'Show teachers with lost classes with their teaching load'
          Caption = '&Lost teacher'
          TabOrder = 2
        end
        object CheckBox20: TCheckBox
          Left = 358
          Top = 28
          Width = 97
          Height = 17
          Hint = 'Show details of all new classes'
          Caption = 'Ne&w Classes'
          TabOrder = 3
        end
        object CheckBox21: TCheckBox
          Left = 14
          Top = 66
          Width = 125
          Height = 17
          Hint = 'Show rooms unavailable with their load map'
          Caption = 'R&ooms unavailable'
          TabOrder = 4
        end
        object CheckBox22: TCheckBox
          Left = 155
          Top = 66
          Width = 74
          Height = 17
          Hint = 'Show rooms with lost classes with their load map'
          Caption = 'Lost roo&m'
          TabOrder = 5
        end
        object CheckBox23: TCheckBox
          Left = 246
          Top = 66
          Width = 97
          Height = 17
          Hint = 'Show details of merged classes'
          Caption = 'Mer&ges'
          TabOrder = 6
        end
        object CheckBox24: TCheckBox
          Left = 358
          Top = 66
          Width = 97
          Height = 17
          Hint = 'Show added staff available with their teaching load'
          Caption = 'Ad&ded Staff'
          TabOrder = 7
        end
      end
      object chbSelectAll: TCheckBox
        Left = 88
        Top = 140
        Width = 75
        Height = 17
        Caption = 'Select all'
        TabOrder = 2
        OnClick = chbSelectAllClick
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'General '
      object grbGeneral: TGroupBox
        Left = 4
        Top = 0
        Width = 501
        Height = 264
        Caption = 'General'
        TabOrder = 0
        object CheckBox33: TCheckBox
          Left = 10
          Top = 32
          Width = 99
          Height = 13
          Hint = 'Show/Hide Floating Hints'
          Caption = '&Floating Hints'
          TabOrder = 0
          Visible = False
        end
        object CheckBox34: TCheckBox
          Left = 10
          Top = 31
          Width = 119
          Height = 17
          Hint = 'Backup dialogue is only shown on closing if this is selected.'
          Caption = '&Backup dialogue'
          TabOrder = 1
        end
        object CheckBox35: TCheckBox
          Left = 10
          Top = 59
          Width = 115
          Height = 17
          Hint = 'Yes/No check on closing is only shown if this is selected.'
          Caption = 'Exit &verify'
          TabOrder = 2
        end
        object CheckBox36: TCheckBox
          Left = 10
          Top = 87
          Width = 151
          Height = 17
          Hint = 'Autoload current custom file at start'
          Caption = '&Autoload custom file'
          TabOrder = 3
        end
        object GroupBox15: TGroupBox
          Left = 192
          Top = 21
          Width = 201
          Height = 116
          Caption = 'Text Export'
          TabOrder = 4
          object Label17: TLabel
            Left = 12
            Top = 88
            Width = 50
            Height = 13
            Caption = '&Subjects'
            FocusControl = Edit8
          end
          object Label18: TLabel
            Left = 12
            Top = 28
            Width = 56
            Height = 13
            Caption = 'Se&parator'
            FocusControl = Edit9
          end
          object Label19: TLabel
            Left = 12
            Top = 58
            Width = 50
            Height = 13
            Caption = '&Delimiter'
            FocusControl = Edit10
          end
          object Edit8: TEdit
            Left = 76
            Top = 84
            Width = 35
            Height = 21
            Hint = 'Number of subject choices to export'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Text = 'Edit7'
          end
          object Edit9: TEdit
            Left = 76
            Top = 24
            Width = 34
            Height = 21
            Hint = 'Ascii character number, eg. 9 for Tab, 44 for Comma.'
            MaxLength = 3
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
          end
          object Edit10: TEdit
            Left = 76
            Top = 54
            Width = 33
            Height = 21
            Hint = 
              'Ascii character number, eg. 34 for double quotes, 39 for single ' +
              'quotes'
            MaxLength = 3
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = 'Edit2'
          end
        end
        object RadioGeneric: TRadioGroup
          Left = 192
          Top = 157
          Width = 201
          Height = 76
          Hint = 'Type of text file export for main timetable'
          Caption = 'Timetable Export'
          Items.Strings = (
            '&Match Printout'
            '&Generic')
          TabOrder = 5
        end
        object EnableAuto: TCheckBox
          Left = 10
          Top = 115
          Width = 145
          Height = 17
          Hint = 'Check to enable automatic cover button on toolbar'
          Caption = '&Enable Auto Cover'
          TabOrder = 6
        end
      end
    end
  end
  object TabSet: TTabSet
    Left = 0
    Top = 337
    Width = 592
    Height = 21
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabHeight = 2
    Tabs.Strings = (
      'Timetable'
      'Print Timetable'
      'Student'
      'Extras lists'
      'General')
    TabIndex = 0
    OnClick = TabSetClick
  end
end
