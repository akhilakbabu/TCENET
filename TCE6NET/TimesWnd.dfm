object TimesWindow: TTimesWindow
  Left = 209
  Top = 175
  Hint = 'Double click to set time allotments'
  HelpContext = 73
  HorzScrollBar.Smooth = True
  HorzScrollBar.Tracking = True
  VertScrollBar.Smooth = True
  VertScrollBar.Tracking = True
  Caption = 'Times'
  ClientHeight = 337
  ClientWidth = 529
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = Change1Click
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object PopupMenu1: TPopupMenu
    Images = MainForm.ActionImages
    Left = 278
    Top = 112
    object Change2: TMenuItem
      Caption = '&Change ...'
      HelpContext = 77
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
  object MainMenu1: TMainMenu
    Left = 40
    Top = 38
    object Codes1: TMenuItem
      Caption = '&Codes'
      GroupIndex = 75
      HelpContext = 112
      Hint = 'The Codes Menu'
      object SelectCode1: TMenuItem
        Caption = '&Select Code'
        HelpContext = 77
        Hint = 'Open a codes window'
        OnClick = SelectCode1Click
        object Teacher1: TMenuItem
          Caption = '&Teacher'
          HelpContext = 65
          Hint = 'Teacher codes window'
          ShortCut = 49201
          OnClick = Teacher1Click
        end
        object AddedStaff1: TMenuItem
          Caption = 'A&dded Staff'
          HelpContext = 70
          Hint = 'Added staff codes window'
          ShortCut = 49202
          OnClick = AddedStaff1Click
        end
        object Times1: TMenuItem
          Caption = 'T&imes'
          HelpContext = 73
          Hint = 'Times window'
          ShortCut = 49203
          OnClick = Times1Click
        end
        object AbsenceReason1: TMenuItem
          Caption = 'Absence &Reason'
          HelpContext = 78
          Hint = 'Absence Reason window'
          ShortCut = 49204
          OnClick = AbsenceReason1Click
        end
        object CoverNote1: TMenuItem
          Caption = '&Cover Note'
          HelpContext = 80
          Hint = 'Cover notes window'
          ShortCut = 49205
          OnClick = CoverNote1Click
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Change1: TMenuItem
        Caption = '&Change ...'
        HelpContext = 77
        Hint = 'Change cover notes'
        OnClick = Change1Click
      end
    end
  end
end
