object TeWindow: TTeWindow
  Left = 209
  Top = 146
  Hint = 'Press '#39'V'#39' to change view'
  HelpContext = 65
  HorzScrollBar.Smooth = True
  HorzScrollBar.Tracking = True
  VertScrollBar.Smooth = True
  VertScrollBar.Tracking = True
  Caption = 'Teacher Codes'
  ClientHeight = 756
  ClientWidth = 572
  Color = clWhite
  Constraints.MinHeight = 330
  Constraints.MinWidth = 330
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
  OnDblClick = FormDblClick
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PopupMenu1: TPopupMenu
    Images = MainForm.ActionImages
    OnPopup = PopupMenu1Popup
    Left = 53
    Top = 34
    object add2: TMenuItem
      Caption = '&Add ...'
      HelpContext = 66
      Hint = 'Add a new code'
      OnClick = Add1Click
    end
    object Change2: TMenuItem
      Caption = '&Change ...'
      HelpContext = 67
      Hint = 'Change or set code'
      OnClick = Change1Click
    end
    object Delete2: TMenuItem
      Caption = '&Delete ...'
      HelpContext = 68
      Hint = 'Delete a code'
      OnClick = Delete1Click
    end
    object Times3: TMenuItem
      Caption = 'Tallies'
      Hint = 'Change teacher tallies'
      ImageIndex = 41
      OnClick = TeacherTallies
    end
    object EmailAddresses1: TMenuItem
      Caption = 'Email Addresses ...'
      HelpContext = 145
      Hint = 'Change Email addresses'
      ShortCut = 16449
      OnClick = EmailClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object popTeAbsentTeacher: TMenuItem
      Caption = '&Absent Teacher'
      HelpContext = 37
      Hint = 'Change absent teachers'
      ImageIndex = 16
      ShortCut = 49264
      OnClick = ChangeAbsentTeacher
    end
    object popTeLostClasses: TMenuItem
      Caption = '&Lost Classes ...'
      HelpContext = 38
      Hint = 'Change lost classes'
      ImageIndex = 18
      ShortCut = 49265
      OnClick = ChangeLostClass
    end
    object popTeN1: TMenuItem
      Caption = '-'
    end
    object Timetable1: TMenuItem
      Caption = '&Timetable ...'
      HelpContext = 106
      Hint = 'Show teacher timetable'
      ImageIndex = 46
      OnClick = Timetable1Click
    end
    object popTeacherVariationSheet: TMenuItem
      Caption = 'Variation Sheet'
      Visible = False
      OnClick = DisplayVariationSheet
    end
    object View2: TMenuItem
      Caption = '&View ...'
      HelpContext = 149
      Hint = 'Change window view'
      ImageIndex = 20
      ShortCut = 16471
      OnClick = View1Click
    end
    object CodeLengths2: TMenuItem
      Caption = 'Code &Lengths ...'
      HelpContext = 148
      Hint = 'Set maximum code length'
      ShortCut = 16460
      OnClick = Codelengths1Click
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
    Images = MainForm.ActionImages
    Left = 132
    Top = 76
    object Codes1: TMenuItem
      Caption = '&Codes'
      GroupIndex = 75
      HelpContext = 112
      Hint = 'The Codes Menu'
      OnClick = Codes1Click
      object SelectCode1: TMenuItem
        Caption = '&Select Code'
        HelpContext = 77
        Hint = 'Select a Code Window'
        OnClick = SelectCode1Click
        object Teacher1: TMenuItem
          Caption = '&Teacher'
          HelpContext = 65
          Hint = 'Teacher Codes window'
          ShortCut = 49201
        end
        object AddedStaff1: TMenuItem
          Caption = 'A&dded Staff'
          HelpContext = 70
          Hint = 'Added Staff Codes window'
          ShortCut = 49202
          OnClick = AddedStaff1Click
        end
        object Times1: TMenuItem
          Caption = 'T&imes'
          HelpContext = 73
          Hint = 'Time allotment window'
          ShortCut = 49203
          OnClick = Times1Click
        end
        object AbsenceReason1: TMenuItem
          Caption = 'Absence &Reason'
          HelpContext = 78
          Hint = 'Absence Reasons window'
          ShortCut = 49204
          OnClick = AbsenceReason1Click
        end
        object CoverNote1: TMenuItem
          Caption = '&Cover Note'
          HelpContext = 80
          Hint = 'Cover Notes window'
          ShortCut = 49205
          OnClick = CoverNote1Click
        end
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Add1: TMenuItem
        Caption = '&Add ...'
        HelpContext = 66
        Hint = 'Add a new code'
        OnClick = Add1Click
      end
      object Change1: TMenuItem
        Caption = '&Change ...'
        HelpContext = 67
        Hint = 'Change a code'
        OnClick = Change1Click
      end
      object Delete1: TMenuItem
        Caption = '&Delete ...'
        HelpContext = 68
        Hint = 'Delete a code'
        OnClick = Delete1Click
      end
      object Times2: TMenuItem
        Caption = 'Talli&es ...'
        HelpContext = 69
        Hint = 'Change Teacher tallies'
        ImageIndex = 41
        ShortCut = 32885
        OnClick = TeacherTallies
      end
      object Email: TMenuItem
        Caption = 'Email Addresses ...'
        HelpContext = 145
        Hint = 'Change Email addresses'
        ShortCut = 16449
        OnClick = EmailClick
      end
      object minTeN1: TMenuItem
        Caption = '-'
      end
      object mniTeAbsentTeachers: TMenuItem
        Caption = '&Absent Teacher'
        HelpContext = 37
        Hint = 'Change absent teachers'
        ImageIndex = 16
        ShortCut = 49264
        OnClick = ChangeAbsentTeacher
      end
      object mniTeLostClasses: TMenuItem
        Caption = '&Lost Classes ...'
        HelpContext = 38
        Hint = 'Change lost classes'
        ImageIndex = 18
        ShortCut = 49265
        OnClick = ChangeLostClass
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object View1: TMenuItem
        Caption = '&View ...'
        Enabled = False
        HelpContext = 149
        Hint = 'Open selection dialogue for top window'
        ImageIndex = 20
        ShortCut = 16471
        OnClick = View1Click
      end
      object Codelengths1: TMenuItem
        Caption = 'Code &Lengths ...'
        HelpContext = 148
        Hint = 'Set length of code'
        ShortCut = 16460
        OnClick = Codelengths1Click
      end
    end
  end
end
