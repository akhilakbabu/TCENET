object AbsReasonWin: TAbsReasonWin
  Left = 229
  Top = 189
  Hint = 'Double Click to change reasons'
  HelpContext = 78
  HorzScrollBar.Smooth = True
  HorzScrollBar.Tracking = True
  VertScrollBar.Smooth = True
  VertScrollBar.Tracking = True
  Caption = 'Teacher Absence Reasons'
  ClientHeight = 322
  ClientWidth = 419
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = True
  PopupMenu = PopupMenu1
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  PixelsPerInch = 96
  TextHeight = 16
  object MainMenu1: TMainMenu
    Left = 42
    Top = 44
    object Codes1: TMenuItem
      Caption = '&Codes'
      GroupIndex = 75
      HelpContext = 112
      Hint = 'The Codes Menu'
      object SelectCode1: TMenuItem
        Caption = '&Select Code'
        HelpContext = 112
        Hint = 'Select Codes Window'
        OnClick = SelectCode1Click
        object Teacher1: TMenuItem
          Caption = '&Teacher'
          HelpContext = 65
          Hint = 'Open teacher codes window'
          ShortCut = 49201
          OnClick = Teacher1Click
        end
        object AddedStaff1: TMenuItem
          Caption = 'A&dded Staff'
          HelpContext = 70
          Hint = 'Open added staff codes window'
          ShortCut = 49202
          OnClick = AddedStaff1Click
        end
        object Times1: TMenuItem
          Caption = 'T&imes'
          HelpContext = 73
          Hint = 'Open times window'
          ShortCut = 49203
          OnClick = Times1Click
        end
        object AbsenceReason1: TMenuItem
          Caption = 'Absence &Reason'
          HelpContext = 78
          Hint = 'Open absence reason window'
          ShortCut = 49204
          OnClick = AbsenceReason1Click
        end
        object CoverNote1: TMenuItem
          Caption = '&Cover Note'
          HelpContext = 80
          Hint = 'Open cover notes window'
          ShortCut = 49205
          OnClick = CoverNote1Click
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Change1: TMenuItem
        Caption = '&Change ...'
        HelpContext = 79
        Hint = 'Change absence reasons'
        OnClick = Change1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Images = MainForm.ActionImages
    Left = 94
    Top = 88
    object Change2: TMenuItem
      Caption = '&Change ...'
      HelpContext = 79
      Hint = 'Change or set absence reason'
      OnClick = Change1Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object Print2: TMenuItem
      Action = MainForm.MainPrint
    end
    object PrintSetup2: TMenuItem
      Action = MainForm.DoPrintPreview
    end
    object Copy1: TMenuItem
      Action = MainForm.CopyWin
    end
  end
end
