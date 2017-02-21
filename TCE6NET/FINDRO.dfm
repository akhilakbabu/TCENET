object FindRoomWin: TFindRoomWin
  Left = 365
  Top = 272
  Hint = 'Double click to show another room'
  HelpContext = 32
  Caption = 'Find Room'
  ClientHeight = 262
  ClientWidth = 419
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
  OnCreate = FormCreate
  OnDblClick = Selection2Click
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 16
  object PopupMenu1: TPopupMenu
    Images = MainForm.ActionImages
    Left = 156
    Top = 104
    object Selection2: TMenuItem
      Caption = 'Selection ...'
      HelpContext = 32
      Hint = 'Print Preview for top window'
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
  end
end
