object FindTeacherWin: TFindTeacherWin
  Left = 215
  Top = 112
  Hint = 'Double click to show another teacher'
  HelpContext = 31
  Caption = 'Find Teacher'
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
    Left = 196
    Top = 110
    object Selection2: TMenuItem
      Caption = '&Selection ...'
      HelpContext = 31
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
