object FindStudent: TFindStudent
  Left = 202
  Top = 132
  Hint = 'Double click to show another student'
  HelpContext = 30
  Caption = 'Find Student'
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
  OnDblClick = FormDblClick
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 16
  object PopupMenu1: TPopupMenu
    Images = MainForm.ActionImages
    Left = 190
    Top = 166
    object Selection2: TMenuItem
      Caption = '&Selection ...'
      HelpContext = 30
      Hint = 'Select student to find'
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
