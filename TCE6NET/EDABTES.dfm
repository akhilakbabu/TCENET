object EditAbsTeacherss: TEditAbsTeacherss
  Left = 301
  Top = 184
  HelpContext = 37
  BorderStyle = bsDialog
  Caption = 'Change Teacher Absences'
  ClientHeight = 246
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label8: TLabel
    Left = 10
    Top = 218
    Width = 101
    Height = 13
    Caption = 'Absent Teachers:'
  end
  object Label9: TLabel
    Left = 114
    Top = 218
    Width = 39
    Height = 13
    Caption = 'Label9'
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 443
    Height = 205
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 22
      Width = 30
      Height = 13
      Caption = '&Code'
      FocusControl = ComboBox2
    end
    object Label3: TLabel
      Left = 8
      Top = 81
      Width = 52
      Height = 13
      Caption = 'Comment'
    end
    object Label4: TLabel
      Left = 74
      Top = 81
      Width = 39
      Height = 13
      Caption = 'Label4'
    end
    object Label6: TLabel
      Left = 8
      Top = 107
      Width = 44
      Height = 13
      Caption = '&Reason'
      FocusControl = cboReason
    end
    object Label7: TLabel
      Left = 8
      Top = 134
      Width = 103
      Height = 13
      Caption = 'Time Slots Absent'
    end
    object Label10: TLabel
      Left = 339
      Top = 81
      Width = 25
      Height = 13
      Caption = 'Link'
    end
    object Label11: TLabel
      Left = 373
      Top = 81
      Width = 46
      Height = 13
      Caption = 'Label11'
    end
    object Label2: TLabel
      Left = 178
      Top = 22
      Width = 37
      Height = 13
      Caption = 'Name:'
    end
    object Label5: TLabel
      Left = 216
      Top = 22
      Width = 39
      Height = 13
      Caption = 'Label5'
    end
    object Label13: TLabel
      Left = 132
      Top = 54
      Width = 5
      Height = 13
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object cboReason: TComboBox
      Left = 60
      Top = 103
      Width = 361
      Height = 21
      Hint = 'Select reason for absence'
      Style = csDropDownList
      DropDownCount = 15
      ItemHeight = 0
      TabOrder = 2
    end
    object ComboBox2: TComboBox
      Left = 48
      Top = 18
      Width = 107
      Height = 21
      Hint = 'Enter teacher code'
      DropDownCount = 10
      ItemHeight = 0
      Sorted = True
      TabOrder = 0
      Text = 'ComboBox2'
      OnChange = ComboBox2Change
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 52
      Width = 121
      Height = 17
      Hint = 
        'With Exclude Team on, an absent teacher who is team teaching DOE' +
        'SN'#39'T generate an absence change to be covered'
      Caption = '&Exclude Team'
      TabOrder = 1
      OnClick = CheckBox1Click
    end
  end
  object update: TBitBtn
    Left = 196
    Top = 213
    Width = 75
    Height = 25
    Hint = 'Update teacher absences'
    Caption = '&Update'
    Default = True
    TabOrder = 1
    OnClick = updateClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333377F3333333333000033334224333333333333
      337337F3333333330000333422224333333333333733337F3333333300003342
      222224333333333373333337F3333333000034222A22224333333337F337F333
      7F33333300003222A3A2224333333337F3737F337F33333300003A2A333A2224
      33333337F73337F337F33333000033A33333A222433333337333337F337F3333
      0000333333333A222433333333333337F337F33300003333333333A222433333
      333333337F337F33000033333333333A222433333333333337F337F300003333
      33333333A222433333333333337F337F00003333333333333A22433333333333
      3337F37F000033333333333333A223333333333333337F730000333333333333
      333A333333333333333337330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn3: TBitBtn
    Left = 360
    Top = 214
    Width = 75
    Height = 25
    Hint = 'How do I ...'
    TabOrder = 3
    Kind = bkHelp
  end
  object finish: TBitBtn
    Left = 277
    Top = 214
    Width = 75
    Height = 25
    Hint = 'Exit from dialogue'
    Cancel = True
    Caption = 'C&lose'
    ModalResult = 2
    TabOrder = 2
    Glyph.Data = {
      BE060000424DBE06000000000000360400002800000024000000120000000100
      0800000000008802000000000000000000000001000000000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000C0DCC000F0CA
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
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030404040406
      0303030303040404040303030303FFFFFFFF030303030303FFFFFFFF03030303
      FAFAFA0403030303030302FA040303030303F8F80303FF0303030303F8F803FF
      030303030302FA0406030303030302FA0403030303030303F803FF0303030303
      03F803FF030303030302FA02040303030306FA060603030303030303F80303FF
      03030303F803FF03030303030303FAFA040603030602FA040303030303030303
      03F803FF030303F80303FF0303030303030306FAFA04040602FA040603030303
      0303030303F80303FFFFF80303FF03030303030303030302FAFA020202040603
      03030303030303030303F80303030303FF030303030303030303030306FAFAFA
      020206040603030303030303030303F803030303FFF8FFFF0303030304040404
      0606FAFA040306FA04030303030303F8FFFFFFF8F80303FF03F803FF03030303
      06FAFA020406FA02040306FA04030303030303F8F80303FFF80303FF03F803FF
      03030303030306FA0204FAFA040402FA040303030303030303F80303FF0303FF
      FFF803FF0303030303030303FA02FAFA02FAFA0403030303030303030303F803
      030303030303FF030303030303030303030202FAFAFA04030303030303030303
      030303F80303030303FF0303030303030303030303030202FA04030303030303
      0303030303030303F8030303FF0303030303030303030303030404FA04030303
      03030303030303030303030303F803FF0303030303030303030303030306FA02
      04030303030303030303030303030303F80303FF030303030303030303030303
      0306FAFA04030303030303030303030303030303F80303FF0303030303030303
      03030303030306060603030303030303030303030303030303F8F8F803030303
      0303}
    NumGlyphs = 2
  end
end
