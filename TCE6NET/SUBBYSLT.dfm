object SubByTimeSlotWin: TSubByTimeSlotWin
  Left = 402
  Top = 267
  Hint = 'Double click to show selection dialogue'
  HelpContext = 97
  HorzScrollBar.Smooth = True
  HorzScrollBar.Tracking = True
  VertScrollBar.Smooth = True
  VertScrollBar.Tracking = True
  Caption = 'SubByTimeSlotWin'
  ClientHeight = 289
  ClientWidth = 418
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = True
  PopupMenu = PopupMenu1
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnDblClick = FormDblClick
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 16
  object PopupMenu1: TPopupMenu
    Images = MainForm.ActionImages
    OnPopup = PopupMenu1Popup
    Left = 98
    Top = 58
    object TimeSlot2: TMenuItem
      Caption = 'Selection ...'
      HelpContext = 98
      Hint = 'Open Selection dialogue'
      ImageIndex = 20
      OnClick = TimeSlot2Click
    end
    object StudentTimetable1: TMenuItem
      Caption = 'Student Timetable'
      HelpContext = 101
      ImageIndex = 45
      OnClick = StudentTimetable1Click
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
