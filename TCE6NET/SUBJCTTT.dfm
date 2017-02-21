object SuTtable: TSuTtable
  Left = 399
  Top = 252
  Hint = 'Double click to select timetable'
  HelpContext = 108
  HorzScrollBar.Smooth = True
  HorzScrollBar.Tracking = True
  VertScrollBar.Smooth = True
  VertScrollBar.Tracking = True
  Caption = 'Subject Timetable'
  ClientHeight = 243
  ClientWidth = 242
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'System'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = True
  PopupMenu = PopupMenu1
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 16
  object PopupMenu1: TPopupMenu
    Images = MainForm.ActionImages
    OnPopup = PopupMenu1Popup
    Left = 140
    Top = 96
    object Selection2: TMenuItem
      Caption = '&Selection ...'
      HelpContext = 108
      Hint = 'Open Selection dialogue'
      ImageIndex = 20
      OnClick = Selection2Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Print1: TMenuItem
      Action = MainForm.MainPrint
    end
    object PrintSetup1: TMenuItem
      Action = MainForm.DoPrintPreview
    end
    object Copy1: TMenuItem
      Action = MainForm.CopyWin
    end
  end
end
