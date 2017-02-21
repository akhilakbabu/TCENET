object MainForm: TMainForm
  Left = 103
  Top = 137
  HelpContext = 176
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'TimeChart Extra 6'
  ClientHeight = 726
  ClientWidth = 1122
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  FormStyle = fsMDIForm
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = True
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 67
    Width = 1122
    Height = 4
    Align = alTop
    TabOrder = 0
  end
  object stbMain: TAdvOfficeStatusBar
    Left = 0
    Top = 707
    Width = 1122
    Height = 19
    AnchorHint = False
    Panels = <
      item
        AppearanceStyle = psLight
        DateFormat = 'd/MM/yyyy'
        Progress.BackGround = clNone
        Progress.Indication = piPercentage
        Progress.Min = 0
        Progress.Max = 100
        Progress.Position = 0
        Progress.Level0Color = clLime
        Progress.Level0ColorTo = 14811105
        Progress.Level1Color = clYellow
        Progress.Level1ColorTo = 13303807
        Progress.Level2Color = 5483007
        Progress.Level2ColorTo = 11064319
        Progress.Level3Color = clRed
        Progress.Level3ColorTo = 13290239
        Progress.Level1Perc = 70
        Progress.Level2Perc = 90
        Progress.BorderColor = clBlack
        Progress.ShowBorder = False
        Progress.Stacked = False
        TimeFormat = 'h:mm:ss AMPM'
        Width = 221
      end
      item
        AppearanceStyle = psLight
        DateFormat = 'd/MM/yyyy'
        Progress.BackGround = clNone
        Progress.Indication = piPercentage
        Progress.Min = 0
        Progress.Max = 100
        Progress.Position = 0
        Progress.Level0Color = clLime
        Progress.Level0ColorTo = 14811105
        Progress.Level1Color = clYellow
        Progress.Level1ColorTo = 13303807
        Progress.Level2Color = 5483007
        Progress.Level2ColorTo = 11064319
        Progress.Level3Color = clRed
        Progress.Level3ColorTo = 13290239
        Progress.Level1Perc = 70
        Progress.Level2Perc = 90
        Progress.BorderColor = clBlack
        Progress.ShowBorder = False
        Progress.Stacked = False
        TimeFormat = 'h:mm:ss AMPM'
        Width = 69
      end
      item
        AppearanceStyle = psLight
        DateFormat = 'd/MM/yyyy'
        Progress.BackGround = clNone
        Progress.Indication = piPercentage
        Progress.Min = 0
        Progress.Max = 100
        Progress.Position = 0
        Progress.Level0Color = clLime
        Progress.Level0ColorTo = 14811105
        Progress.Level1Color = clYellow
        Progress.Level1ColorTo = 13303807
        Progress.Level2Color = 5483007
        Progress.Level2ColorTo = 11064319
        Progress.Level3Color = clRed
        Progress.Level3ColorTo = 13290239
        Progress.Level1Perc = 70
        Progress.Level2Perc = 90
        Progress.BorderColor = clBlack
        Progress.ShowBorder = False
        Progress.Stacked = False
        TimeFormat = 'h:mm:ss AMPM'
        Width = 1063
      end>
    SimplePanel = False
    URLColor = clBlue
    Version = '1.3.0.0'
  end
  object AdvDockPanel1: TAdvDockPanel
    Left = 0
    Top = 0
    Width = 1122
    Height = 67
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    MinimumSize = 3
    LockHeight = True
    Persistence.Location = plIniFile
    Persistence.Enabled = False
    ToolBarStyler = AdvToolBarOfficeStyler
    UseRunTimeHeight = False
    Version = '3.5.3.2'
    object AdvToolBar1: TAdvToolBar
      Left = 947
      Top = 1
      Width = 135
      Height = 52
      Cursor = crHandPoint
      AllowFloating = False
      Caption = 'Output'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'Tahoma'
      CaptionFont.Style = []
      CaptionHeight = 14
      CaptionAlignment = taCenter
      CompactImageIndex = -1
      ShowCaption = True
      ShowRightHandle = False
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Output'
      ToolBarStyler = AdvToolBarOfficeStyler
      Images = HotImages
      DisabledImages = DisabledImages
      ParentOptionPicture = True
      ParentShowHint = False
      ToolBarIndex = -1
      object btnPrintPreview: TAdvToolBarButton
        Left = 9
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Print Preview for top window'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = 'P&rint Preview'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 21
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = DoPrintPreviewExecute
      end
      object btnMainPrint: TAdvToolBarButton
        Left = 53
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Print top window'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Print ...'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 22
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = MainPrintExecute
      end
      object btnCopyWin: TAdvToolBarButton
        Left = 97
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Copy top window'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Copy'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 23
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = CopyWinExecute
      end
      object AdvToolBarSeparator18: TAdvToolBarSeparator
        Left = 87
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator19: TAdvToolBarSeparator
        Left = 43
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
    end
    object AdvToolBar2: TAdvToolBar
      Left = 810
      Top = 1
      Width = 135
      Height = 52
      Cursor = crHandPoint
      AllowFloating = False
      Caption = 'Extras'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'Tahoma'
      CaptionFont.Style = []
      CaptionHeight = 14
      CaptionAlignment = taCenter
      CompactImageIndex = -1
      ShowCaption = True
      ShowRightHandle = False
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Extras'
      ToolBarStyler = AdvToolBarOfficeStyler
      Images = HotImages
      DisabledImages = DisabledImages
      ParentOptionPicture = True
      ParentShowHint = False
      ToolBarIndex = -1
      object btnShowCurrentExtras: TAdvToolBarButton
        Left = 9
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Current Extras'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = 'Current &Extras'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 18
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ShowCurrentExtrasExecute
      end
      object btnShowPastExtras: TAdvToolBarButton
        Left = 53
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Past Extras'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Past Extras'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 19
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ShowPastExtrasExecute
      end
      object btnTeacherTallies: TAdvToolBarButton
        Left = 97
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Change Teacher tallies'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = 'Talli&es ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 20
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = actTeacherTalliesExecute
      end
      object AdvToolBarSeparator16: TAdvToolBarSeparator
        Left = 43
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator17: TAdvToolBarSeparator
        Left = 87
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
    end
    object AdvToolBar3: TAdvToolBar
      Left = 717
      Top = 1
      Width = 91
      Height = 52
      Cursor = crHandPoint
      AllowFloating = False
      Caption = 'Cover'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'Tahoma'
      CaptionFont.Style = []
      CaptionHeight = 14
      CaptionAlignment = taCenter
      CompactImageIndex = -1
      ShowCaption = True
      ShowRightHandle = False
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Cover'
      ToolBarStyler = AdvToolBarOfficeStyler
      Images = HotImages
      DisabledImages = DisabledImages
      ParentOptionPicture = True
      ParentShowHint = False
      ToolBarIndex = -1
      object btnManualCover: TAdvToolBarButton
        Left = 9
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Cover extras (manual)'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Cover ...'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 16
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ManualCoverExecute
      end
      object btnChangeEmailCovers: TAdvToolBarButton
        Left = 53
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Email Covers to Teachers'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Email Covers'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 17
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ChangeEmailCoversExecute
      end
      object AdvToolBarSeparator15: TAdvToolBarSeparator
        Left = 43
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
    end
    object AdvToolBar4: TAdvToolBar
      Left = 404
      Top = 1
      Width = 311
      Height = 52
      Cursor = crHandPoint
      AllowFloating = False
      Caption = 'Changes'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'Tahoma'
      CaptionFont.Style = []
      CaptionHeight = 14
      CaptionAlignment = taCenter
      CompactImageIndex = -1
      ShowCaption = True
      ShowRightHandle = False
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Changes'
      ToolBarStyler = AdvToolBarOfficeStyler
      Images = HotImages
      DisabledImages = DisabledImages
      ParentOptionPicture = True
      ParentShowHint = False
      ToolBarIndex = -1
      object btnChangeAbsent: TAdvToolBarButton
        Left = 9
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Change absent teachers'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Absent Teacher'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 9
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ChangeAbsentExecute
      end
      object btnChangeLost: TAdvToolBarButton
        Left = 53
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Change lost classes'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Lost Classes ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 10
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ChangeLostExecute
      end
      object btnChangeAddedStaff: TAdvToolBarButton
        Left = 97
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Change Added Staff Available'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = 'A&dded Staff ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 11
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ChangeAddedStaffExecute
      end
      object btnChangeNewClass: TAdvToolBarButton
        Left = 141
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Change New Classes'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&New Class ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 12
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ChangeNewClassExecute
      end
      object btnChangeMergeClass: TAdvToolBarButton
        Left = 185
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Change merged classes'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Merge Class ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 13
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ChangeMergeClassExecute
      end
      object btnChangeUnavailRoom: TAdvToolBarButton
        Left = 229
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Change unavailable rooms'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Unavailable Room ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 14
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ChangeUnavailRoomExecute
      end
      object btnChangeRoomSwap: TAdvToolBarButton
        Left = 273
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Change room swaps'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Room Swap ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 15
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ChangeRoomSwapExecute
      end
      object AdvToolBarSeparator3: TAdvToolBarSeparator
        Left = 175
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator4: TAdvToolBarSeparator
        Left = 43
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator11: TAdvToolBarSeparator
        Left = 131
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator12: TAdvToolBarSeparator
        Left = 219
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator13: TAdvToolBarSeparator
        Left = 87
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator14: TAdvToolBarSeparator
        Left = 263
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
    end
    object AdvToolBar5: TAdvToolBar
      Left = 3
      Top = 1
      Width = 399
      Height = 52
      Cursor = crHandPoint
      AllowFloating = False
      Caption = 'Home'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'Tahoma'
      CaptionFont.Style = []
      CaptionHeight = 14
      CaptionAlignment = taCenter
      CompactImageIndex = -1
      ShowCaption = True
      ShowRightHandle = False
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Home'
      ToolBarStyler = AdvToolBarOfficeStyler
      Images = HotImages
      DisabledImages = DisabledImages
      ParentOptionPicture = True
      ParentShowHint = False
      ToolBarIndex = -1
      object btnNextView: TAdvToolBarButton
        Left = 229
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Show next view for top window'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = 'Next &View'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 5
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = NextViewExecute
      end
      object btnShowSelection: TAdvToolBarButton
        Left = 273
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Open selection dialogue for top window'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Selection ...'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 6
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = ShowSelectionExecute
      end
      object btnPreferences: TAdvToolBarButton
        Left = 317
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Set preferences'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Preferences'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 7
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = PreferencesExecute
      end
      object btnCoverWeights: TAdvToolBarButton
        Left = 361
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Set cover weights'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = 'Wei&ghts ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 8
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = CoverWeightsExecute
      end
      object btnFileNewDay: TAdvToolBarButton
        Left = 53
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Start new day'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = 'New &Day ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 1
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = FileNewDayExecute
      end
      object btnWorkAheadOpen: TAdvToolBarButton
        Left = 141
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Open an Extra'#39's file'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Open ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 3
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = WorkAheadOpenExecute
      end
      object btnWorkAheadUse: TAdvToolBarButton
        Left = 185
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Use work ahead file'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&Use ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 4
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = WorkAheadUseExecute
      end
      object AdvToolBarSeparator2: TAdvToolBarSeparator
        Left = 87
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object btnNewData: TAdvToolBarButton
        Left = 9
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Load new data'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&New Data ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 0
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = NewDataExecute
      end
      object btnWorkAheadNew: TAdvToolBarButton
        Left = 97
        Top = 16
        Width = 34
        Height = 34
        Hint = 'Open a new work ahead file'
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Tahoma'
        Appearance.CaptionFont.Style = []
        Caption = '&New ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 2
        ParentFont = False
        Position = daTop
        Version = '3.5.3.2'
        OnClick = WorkAheadNewExecute
      end
      object AdvToolBarSeparator1: TAdvToolBarSeparator
        Left = 219
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator5: TAdvToolBarSeparator
        AlignWithMargins = True
        Left = 43
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator6: TAdvToolBarSeparator
        Left = 131
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator7: TAdvToolBarSeparator
        Left = 175
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator8: TAdvToolBarSeparator
        Left = 263
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator9: TAdvToolBarSeparator
        Left = 307
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
      object AdvToolBarSeparator10: TAdvToolBarSeparator
        Left = 351
        Top = 16
        Width = 10
        Height = 48
        LineColor = clBtnShadow
      end
    end
  end
  object MainMenu: TMainMenu
    Images = ActionImages
    Left = 378
    Top = 170
    object FileMenu: TMenuItem
      Caption = '&File'
      HelpContext = 1
      Hint = 'The File Menu'
      OnClick = FileMenuClick
      object NewDayItem: TMenuItem
        Action = FileNewDay
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Save1: TMenuItem
        Caption = '&Work Ahead'
        HelpContext = 4
        Hint = 'Work with changes for a future date'
        object WorkAheadNew1: TMenuItem
          Action = WorkAheadNew
        end
        object WorkAheadOpen1: TMenuItem
          Action = WorkAheadOpen
          ShortCut = 16463
        end
        object WorkAheadUse1: TMenuItem
          Action = WorkAheadUse
        end
      end
      object Close1: TMenuItem
        Caption = '&Close'
        HelpContext = 8
        Hint = 'Close the active window'
        ShortCut = 16499
        OnClick = Close1Click
      end
      object mniFileCloseAll: TMenuItem
        Caption = 'Close All'
        OnClick = CloseAllWindows
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object OpenTimetable1: TMenuItem
        Caption = '&Open Timetable ...'
        HelpContext = 9
        Hint = 'Open an existing timetable'
        ShortCut = 32884
        OnClick = OpenTimetable1Click
      end
      object NewData1: TMenuItem
        Action = NewData
      end
      object ExportFile: TMenuItem
        Caption = '&Export as Text File ...'
        HelpContext = 132
        Hint = 'Export top window as text file'
        OnClick = ExportFileClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Print1: TMenuItem
        Action = MainPrint
      end
      object PrintSetup1: TMenuItem
        Action = FilePrintSetup1
      end
      object PrintPreview1: TMenuItem
        Action = DoPrintPreview
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object CreateBackup1: TMenuItem
        Caption = 'Create Backup ...'
        HelpContext = 118
        Hint = 'Backup data'
        ShortCut = 16450
        OnClick = CreateBackup1Click
      end
      object RestorefromBackup1: TMenuItem
        Caption = 'Restore from Backup ...'
        HelpContext = 119
        Hint = 'Restore data from backup'
        OnClick = RestorefromBackup1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object FileExitItem: TMenuItem
        Caption = 'E&xit'
        HelpContext = 13
        Hint = 'Exit Time Chart Extra'
        ShortCut = 32883
        OnClick = FileExit
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object Copy1: TMenuItem
        Action = CopyWin
      end
    end
    object Display: TMenuItem
      Caption = '&Display'
      GroupIndex = 145
      HelpContext = 14
      Hint = 'The Display Menu'
      OnClick = DisplayClick
      object Font1: TMenuItem
        Action = SetFont
      end
      object Preferences1: TMenuItem
        Action = Preferences
        ShortCut = 24656
      end
      object Margins1: TMenuItem
        Caption = '&Margins ...'
        HelpContext = 21
        Hint = 'Set Margins and Date stamp'
        ShortCut = 16461
        OnClick = Margins1Click
      end
      object Custom1: TMenuItem
        Caption = '&Custom'
        HelpContext = 22
        Hint = 'The Custom sub-menu'
        OnClick = Custom1Click
        object Clear1: TMenuItem
          Caption = '&Clear'
          HelpContext = 23
          Hint = 'Clear Custom Information'
          ShortCut = 24643
          OnClick = Clear1Click
        end
        object New1: TMenuItem
          Caption = '&New...'
          HelpContext = 24
          Hint = 'New Custom Information'
          ShortCut = 24654
          OnClick = New1Click
        end
        object opencustomfile1: TMenuItem
          Caption = '&Open...'
          HelpContext = 25
          Hint = 'Open Custom File'
          ShortCut = 24655
          OnClick = opencustomfile1Click
        end
        object Editcustomfile1: TMenuItem
          Caption = '&Edit...'
          HelpContext = 26
          Hint = 'Edit Custom Information'
          ShortCut = 24645
          OnClick = Editcustomfile1Click
        end
        object Savecustomfile1: TMenuItem
          Caption = '&Save...'
          HelpContext = 27
          Hint = 'Save Custom File'
          ShortCut = 24659
          OnClick = Savecustomfile1Click
        end
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object Selection1: TMenuItem
        Action = ShowSelection
      end
      object NextView1: TMenuItem
        Action = NextView
      end
    end
    object User1: TMenuItem
      Caption = '&User'
      GroupIndex = 145
      HelpContext = 178
      OnClick = User1Click
      object Info2: TMenuItem
        Caption = '&Info ...'
        HelpContext = 181
        OnClick = Info2Click
      end
      object Changepassword1: TMenuItem
        Caption = '&Change password ...'
        HelpContext = 180
        OnClick = Changepassword1Click
      end
      object Logonasdifferentuser1: TMenuItem
        Caption = '&Log on as different user...'
        HelpContext = 179
        OnClick = Logonasdifferentuser1Click
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object Showusers1: TMenuItem
        Caption = '&Show users'
        HelpContext = 185
        OnClick = Showusers1Click
      end
      object Adduser1: TMenuItem
        Caption = '&Add user ...'
        HelpContext = 177
        OnClick = Adduser1Click
      end
      object Edituser1: TMenuItem
        Caption = '&Edit user ...'
        HelpContext = 183
        OnClick = Edituser1Click
      end
      object Deleteuser1: TMenuItem
        Caption = '&Delete user ...'
        HelpContext = 184
        OnClick = Deleteuser1Click
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object Autoloadtime1: TMenuItem
        Caption = 'Autoload &time ...'
        HelpContext = 189
        OnClick = Autoloadtime1Click
      end
      object mniUserClearUserAccessLocks: TMenuItem
        Caption = 'Clear User Access Locks'
        OnClick = ClearUserAccessLocks
      end
      object Savedefaultdisplaysettings1: TMenuItem
        Caption = 'Save default display settings'
        HelpContext = 187
        OnClick = SaveDefaultDisplaySettings
      end
      object Setcurrentdatadirectoryasdefault1: TMenuItem
        Caption = 'Set current data directory as default'
        HelpContext = 188
        OnClick = SetCurrentDataDirectoryAsDefault
      end
    end
    object Find1: TMenuItem
      Caption = 'F&ind'
      GroupIndex = 145
      HelpContext = 29
      Hint = 'The Find Menu'
      object Student2: TMenuItem
        Caption = '&Student...'
        HelpContext = 30
        Hint = 'Find a student'
        ShortCut = 32880
        OnClick = Student2Click
      end
      object Teacher3: TMenuItem
        Caption = '&Teacher...'
        HelpContext = 31
        Hint = 'Find a teacher'
        ShortCut = 32881
        OnClick = Teacher3Click
      end
      object Room3: TMenuItem
        Caption = '&Room...'
        HelpContext = 32
        Hint = 'Find a room'
        ShortCut = 32882
        OnClick = Room3Click
      end
    end
    object Student1: TMenuItem
      Caption = '&Student'
      GroupIndex = 145
      HelpContext = 33
      Hint = 'The Student Menu'
      object Select1: TMenuItem
        Caption = 'Select ...'
        HelpContext = 165
        Hint = 'Select a group of students'
        OnClick = Select1Click
      end
      object Sort1: TMenuItem
        Caption = 'Sort ...'
        HelpContext = 165
        Hint = 'Sort students'
        OnClick = Sort1Click
      end
      object N11: TMenuItem
        Caption = '-'
        HelpContext = 165
      end
      object grp01: TMenuItem
        Tag = 1
        Caption = 'grp0'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp11: TMenuItem
        Tag = 2
        Caption = 'grp1'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp21: TMenuItem
        Tag = 3
        Caption = 'grp2'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp31: TMenuItem
        Tag = 4
        Caption = 'grp3'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp41: TMenuItem
        Tag = 5
        Caption = 'grp4'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp51: TMenuItem
        Tag = 6
        Caption = 'grp5'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp61: TMenuItem
        Tag = 7
        Caption = 'grp6'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp71: TMenuItem
        Tag = 8
        Caption = 'grp7'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp81: TMenuItem
        Tag = 9
        Caption = 'grp8'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp91: TMenuItem
        Tag = 10
        Caption = 'grp9'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp101: TMenuItem
        Tag = 11
        Caption = 'grp10'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp111: TMenuItem
        Tag = 12
        Caption = 'grp11'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp121: TMenuItem
        Tag = 13
        Caption = 'grp12'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp131: TMenuItem
        Tag = 14
        Caption = 'grp13'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp141: TMenuItem
        Tag = 15
        Caption = 'grp14'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp151: TMenuItem
        Tag = 16
        Caption = 'grp15'
        HelpContext = 165
        OnClick = grp01Click
      end
    end
    object Timetable2: TMenuItem
      Caption = '&Timetable'
      GroupIndex = 160
      HelpContext = 34
      Hint = 'The Timetable Menu'
      OnClick = Timetable2Click
      object Levels1: TMenuItem
        Caption = '&Levels ...'
        HelpContext = 35
        Hint = 'Set the number of levels for each year'
        Visible = False
        OnClick = Levels1Click
      end
      object Timetable3: TMenuItem
        Action = ShowTimetable
      end
    end
    object Changes1: TMenuItem
      Caption = 'Ch&anges'
      GroupIndex = 170
      HelpContext = 36
      Hint = 'The Changes Menu'
      object AbsentTeacher1: TMenuItem
        Action = ChangeAbsent
      end
      object LostClass1: TMenuItem
        Action = ChangeLost
      end
      object AddedStaff2: TMenuItem
        Action = ChangeAddedStaff
      end
      object Newclass1: TMenuItem
        Action = ChangeNewClass
      end
      object MergeClass1: TMenuItem
        Action = ChangeMergeClass
      end
      object RoomClass1: TMenuItem
        Action = ChangeUnavailRoom
      end
      object RoomSwaps2: TMenuItem
        Action = ChangeRoomSwap
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object RescanTimetable1: TMenuItem
        Caption = 'Rescan Timetable'
        HelpContext = 163
        Hint = 'Rescan if timetable has changed'
        OnClick = RescanTimetable1Click
      end
    end
    object Cover1: TMenuItem
      Caption = '&Cover'
      GroupIndex = 180
      HelpContext = 46
      Hint = 'The Cover Menu'
      object Manual1: TMenuItem
        Action = ManualCover
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object EmailCovers1: TMenuItem
        Action = ChangeEmailCovers
      end
      object EmailSetup1: TMenuItem
        Caption = 'Email &Setup ...'
        HelpContext = 144
        Hint = 'Open setup dialogue for emails'
        OnClick = EmailSetup1Click
      end
      object CoverasPDF1: TMenuItem
        Caption = 'Cover as PDF'
        OnClick = CreateCoverInPDF
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object Weights1: TMenuItem
        Action = CoverWeights
      end
      object ExcludeYears1: TMenuItem
        Action = DoIncludeYears
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object Wipe1: TMenuItem
        Caption = '&Refresh'
        HelpContext = 55
        Hint = 'Clear out old data before starting a new cycle'
        object WeeklyExtras1: TMenuItem
          Caption = '&Weekly Extras'
          HelpContext = 56
          Hint = 'Clear short term cycle'
          OnClick = WeeklyExtras1Click
        end
        object InLieus1: TMenuItem
          Caption = '&In Lieus'
          HelpContext = 57
          Hint = 'Clear In Lieu tallies'
          OnClick = InLieus1Click
        end
        object ReplaceExtras1: TMenuItem
          Caption = '&Replacements'
          HelpContext = 167
          Hint = 'Clear replacement tallies'
          OnClick = ReplaceExtras1Click
        end
        object TotalExtras1: TMenuItem
          Caption = '&Total Extras'
          HelpContext = 58
          Hint = 'Clear all extras tallies'
          OnClick = TotalExtras1Click
        end
        object LastExtraDate1: TMenuItem
          Caption = 'Last Extra Date'
          HelpContext = 168
          Hint = 'Clear date of last extra'
          OnClick = WipeLastExtras
        end
        object mniCoverWipeAll: TMenuItem
          Caption = '&All'
          OnClick = WipeAll
        end
      end
      object PastExtras2: TMenuItem
        Caption = '&Delete Past Extras'
        HelpContext = 59
        Hint = 'Clear long term cycle'
        OnClick = PastExtras2Click
      end
    end
    object WindowMenu: TMenuItem
      Caption = '&Window'
      GroupIndex = 190
      HelpContext = 60
      Hint = 'The Window menu'
      OnClick = WindowMenuClick
      object Info1: TMenuItem
        Action = ShowInfoWin
      end
      object Codes1: TMenuItem
        Caption = 'C&odes'
        HelpContext = 112
        Hint = 'The Codes sub-menu'
        object Teacher2: TMenuItem
          Caption = '&Teacher'
          HelpContext = 65
          Hint = 'Teacher codes window'
          ShortCut = 49201
          OnClick = Teacher2Click
        end
        object AddedStaff3: TMenuItem
          Caption = 'A&dded Staff'
          HelpContext = 70
          Hint = 'Added Staff codes window'
          ShortCut = 49202
          OnClick = AddedStaff3Click
        end
        object Times1: TMenuItem
          Caption = 'T&imes'
          HelpContext = 73
          Hint = 'Time allotments window'
          ShortCut = 49203
          OnClick = Times1Click
        end
        object AbsenceReasons1: TMenuItem
          Caption = 'Absence &Reason'
          HelpContext = 78
          Hint = 'Absence Reasons window'
          ShortCut = 49204
          OnClick = AbsenceReasons1Click
        end
        object CoverNotes1: TMenuItem
          Caption = '&Cover Note'
          HelpContext = 80
          Hint = 'Cover Notes window'
          ShortCut = 49205
          OnClick = CoverNotes1Click
        end
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object AbsentTeachers1: TMenuItem
        Action = ShowAbsentTeachers
      end
      object LostClasses1: TMenuItem
        Action = ShowLostTeachers
      end
      object AddedStaff1: TMenuItem
        Action = ShowAddedAvail
      end
      object NewClasses1: TMenuItem
        Action = ShowNewClasses
      end
      object MergedClasses1: TMenuItem
        Action = ShowMergeClass
      end
      object UnavailableRooms1: TMenuItem
        Action = ShowUnavailRoom
      end
      object RoomSwaps1: TMenuItem
        Action = ShowRoomSwaps
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object CurrentExtras1: TMenuItem
        Action = ShowCurrentExtras
      end
      object PastExtras1: TMenuItem
        Action = ShowPastExtras
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object SubjectList1: TMenuItem
        Caption = 'Su&bject List'
        HelpContext = 95
        Hint = 'Subject list sub-menu'
        object BySubject1: TMenuItem
          Action = ShowSubjectList
          HelpContext = 97
        end
        object ByTimeslot1: TMenuItem
          Caption = 'By &Time slot'
          HelpContext = 126
          Hint = 'Subject list by time slot'
          ShortCut = 49221
          OnClick = ByTimeslot1Click
        end
      end
      object StudentList1: TMenuItem
        Action = ShowStudList
      end
      object StudentTimetable1: TMenuItem
        Action = ShowStudentTt
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Timetable1: TMenuItem
        Action = ShowTimetable
      end
      object Teacher1: TMenuItem
        Action = ShowTeacherTimetable
      end
      object Room1: TMenuItem
        Action = ShowRoomTimetable
      end
      object Subject1: TMenuItem
        Action = ShowSubjectTimetable
      end
      object teachersFree1: TMenuItem
        Caption = 'Teachers Free'
        Visible = False
        OnClick = teachersFree1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object WindowTileItem: TMenuItem
        Caption = 'Tile Hori&zontal'
        HelpContext = 109
        Hint = 'Tile all windows'
        OnClick = WindowTile
      end
      object TileVertical1: TMenuItem
        Caption = 'Tile &Vertical'
        HelpContext = 109
        Hint = 'Tile all windows'
        OnClick = TileVertical1Click
      end
      object WindowCascadeItem: TMenuItem
        Action = WindowCascade1
      end
      object WindowArrangeItem: TMenuItem
        Caption = 'Arran&ge All'
        HelpContext = 109
        Hint = 'Arrange minimized windows'
        OnClick = WindowArrange
      end
    end
    object HelpMenu: TMenuItem
      Caption = '&Help'
      GroupIndex = 200
      HelpContext = 113
      Hint = 'The Help Menu'
      object HelpContentsItem: TMenuItem
        Caption = '&Contents'
        HelpContext = 113
        Hint = 'Display the help contents screen'
        OnClick = HelpContents
      end
      object HelpSearchItem: TMenuItem
        Caption = '&Search for Help On ...'
        HelpContext = 113
        Hint = 'Search help file for a topic'
        OnClick = HelpSearch
      end
      object HelpHowToUseItem: TMenuItem
        Caption = '&How to Use Help'
        HelpContext = 113
        Hint = 'Help on using the help system'
        OnClick = HelpHowToUse
      end
      object N3: TMenuItem
        Caption = '-'
        HelpContext = 113
      end
      object VisitAmigSystemsWebsite1: TMenuItem
        Caption = 'AMIG SYSTEMS Website'
        Hint = 'Surf internet at www.amig.com.au'
        OnClick = VisitAmigSystemsWebsite1Click
      end
      object Checkforupdates1: TMenuItem
        Caption = 'Check for updates...'
        Hint = 'Surf to our updates page online...'
        Visible = False
        OnClick = Checkforupdates1Click
      end
      object mniHelpSystem: TMenuItem
        Caption = 'System'
        Hint = 'System Sub-menu'
        object mniHelpSystemArchiveData: TMenuItem
          Caption = 'Archive Data'
          Hint = 'Archive data in compressed format'
          OnClick = ArchiveData
        end
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object HelpAboutItem: TMenuItem
        Caption = '&About ...'
        HelpContext = 113
        Hint = 'About Time Chart Extra ...'
        OnClick = HelpAbout
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'Timetable|*.tt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofShowHelp, ofPathMustExist, ofFileMustExist]
    Title = 'Load Timetable'
    Left = 495
    Top = 199
  end
  object SaveDialog: TSaveDialog
    Filter = 'Timetable|*.tt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofShowHelp, ofPathMustExist]
    Title = 'Save Timetable'
    Left = 376
    Top = 199
  end
  object PrintDialog: TPrintDialog
    HelpContext = 13
    Copies = 1
    Options = [poWarning, poHelp]
    Left = 466
    Top = 199
  end
  object PrintSetupDialog: TPrinterSetupDialog
    HelpContext = 14
    Left = 437
    Top = 199
  end
  object FontDialog1: TFontDialog
    HelpContext = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = []
    Left = 407
    Top = 199
  end
  object ActionImages: TImageList
    Masked = False
    Left = 408
    Top = 170
    Bitmap = {
      494C010131003400780010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000D000000001001000000000000068
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F00000000EF3D0000
      EF3D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E03D000000000000EF3D
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07F0000000000000000
      0000000000000000E003E003E003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07F0000000000000000
      EF3D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07FE07FE07FE07FEF3D
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EF3D0000EF3D
      0000EF3D0000EF3DEF3D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EF3D
      EF3D0000EF3D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003B5FD42DEF0C
      AE00AE00EF0CD42D3B5F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DF7BD429AE0013013601
      580137013601F300AE00D429DF7B000000000000000000000000000000000000
      000000000000FF03000000000000FF0300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000DF7B5119F100780179017901
      79017901790159013701D1005119DF7B00000000E07FE07F0000000000000000
      000000000000FF0300000000E003000000000000E07FE07F0000000000000000
      00000000000000000000E0030000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000D42911019901990199019901
      376F376F9901790179015801D100D42900000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      00000000000000000000E0030000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000003B5FEF009801B905B905BA05DA05
      586F586FB9059901990179015801AE003B5F0000E07FE07F0000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      00000000000000000000E0030000000000000000E07FE07F0000000000000000
      000000000000000000000000E00300000000F52D5401B905DA05DA05FB05FB05
      58735873DA05B9059905990179011301D42D0000E07FE07F0000000000000000
      0000EF3D00000000E003E003E003000000000000E07FE07F0000000000000000
      0000EF3D000000000000E0030000000000000000E07FE07F0000000000000000
      0000EF3D00000000E003E003000000000000300D9705DA05FB05FC051C061C02
      59735973FB05DA05BA05990179015601EF0C0000E07FE07F00000000EF3D0000
      EF3D000000000000E00300000000FF0300000000E07FE07F00000000EF3D0000
      EF3D0000000000000000E0030000000000000000E07FE07F00000000EF3D0000
      EF3D000000000000E003E003E00300000000EF00D905FC057F0EBF1ADF22FF22
      9B7B9B7B9F167F0E3F06FC0599057801AE0000000000E03D000000000000EF3D
      0000EF3D000000000000000000000000000000000000E03D000000000000EF3D
      0000EF3D000000000000E00300000000000000000000E03D000000000000EF3D
      0000EF3D00000000000000000000000000000F01D905BF22FF2AFF26FF22FF22
      BB7BBB7BBF167F0E5F0A1F06DC057801AE000000E07FE07F0000000000000000
      0000000000000000E00300000000FF0300000000E07FE07F0000000000000000
      0000000000000000E003E003E003000000000000E07FE07F0000000000000000
      000000000000000000000000000000000000500DD809DF22FF261F231F231F1F
      FF1ADF16BF127F0A5F061E06DC057701100D00000000E07F0000000000000000
      0000000000000000E003E003E0030000000000000000E07F0000000000000000
      000000000000E003E003E003E003E003000000000000E07F0000000000000000
      0000000000000000E003E003E00300000000353295099F0EFF22FF1E1F1F3F1B
      BB7FBB7FBF0E7F063F061D06DA055401F42D00000000E07F0000000000000000
      EF3D00000000FF03000000000000FF03000000000000E07F0000000000000000
      EF3D0000000000000000000000000000000000000000E07F0000000000000000
      EF3D000000000000000000000000000000005B6372113D06DF1AFF1A1F1B1F17
      BC7FBC7F9F0A7F063E06FC05DA09510D3B5F00000000E07FE07FE07FE07FEF3D
      0000EF3D000000000000000000000000000000000000E07FE07FE07FE07FEF3D
      0000EF3D000000000000000000000000000000000000E07FE07FE07FE07FEF3D
      0000EF3D00000000000000000000000000000000152E171EBF12DF12FF16FF12
      DF0EBF0A9F025E061D063F0AD61DF42900000000000000000000EF3D0000EF3D
      0000EF3D0000EF3DEF3D00000000000000000000000000000000EF3D0000EF3D
      0000EF3D0000EF3DEF3D00000000000000000000000000000000EF3D0000EF3D
      0000EF3D0000EF3DEF3D00000000000000000000DF7BB31D381E1F331F27FF1A
      BF0E9F0A9F0EBF1EDF2EF71D9219DF7B0000000000000000000000000000EF3D
      EF3D0000EF3D000000000000000000000000000000000000000000000000EF3D
      EF3D0000EF3D000000000000000000000000000000000000000000000000EF3D
      EF3D0000EF3D00000000000000000000000000000000DF7B152E92159A2A3F47
      9F579F5B3E477A2A7111F429DF7B000000000000000000000000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000EF3D000000000000000000000000000000000000000000005C6335327111
      2F052F05711135323B6300000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000000001F001F00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      000000000000000000001F000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      00000000000000001F001F000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      0000000000001F001F001F001F001F0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      0000000000001F001F001F001F001F0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      00000000000000001F001F000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      000000000000000000001F000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001F001F001F001F00
      1F001F0000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000EA7EA37EA37EE87E127BC665
      C665C665C665C665C665C665C665C6654B6A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000737FC67E0C7FA37EA37EA37E967F
      0000E37E0000E37E0000296AE665E665E66500000000000000000000DD73B963
      544B744B754FFD770000000000000000000000000000000000000000DD73B963
      544B744B754FFD77000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E37EB87F0000087FE37EE37EE57E
      E37EE37EE37EE37EE37E8E6EE665E665E6650000000000000000DD73113F313F
      D75FF75FD6577347FC7300000000000000000000000000000000DD73113F313F
      D75FF75FD6577347FC7300000000000000000000000000000000000000000000
      000000000000000000000000000000000000E37E4E7F957F057FE37EE37EE37E
      E37EE37EE37EE37E527B086AE665E665E665000000000000FF7FFE7BDC73B963
      323FD75BF863F85F5243B963000000000000000000000000FF7FFE7BDC73B963
      323FD75BF863F85F5243B9630000000000000000000000000000000000000000
      000000000000000000000000000000000000FE7F057FE37EE37EE37E717F0000
      00000000000000004B6EE769E769E769E76900000000FF7F713FD44F00000000
      FF7F3243B553D657D75B313FBB6B0000000000000000FF7F713FD44F00000000
      FF7F3243B553D657D75B313FBB6B000000000000000000000000000000000000
      0000000000000000000000000000000000000000FE7F937F717FB87FD072E769
      E769E769E769E769E769E769E769E769E7690000FF7F303B2F33703B95530000
      00000000313F9553944FB553313FFF7F00000000FF7F303B2F33703B95530000
      00000000313F9553944FB553313FFF7F00000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000076A076A
      076A076A076A076A076A076A076A076A076A0000113BED2E0E2F2E2F2F339653
      00000000BA67103B734B7347F036BC6F00000000113BED2E0E2F2E2F2F339653
      00000000BA67103B734B7347F036BC6F00000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000076A076A
      0000076A076A076A076A076A076A076A076AB0364A1ACC26ED2AEE2E0E2F0E2F
      7653DE779A67CE2E113BF036AE2E1653BD73B0364A1ACC26ED2AEE2E0E2F0E2F
      7653DE779A67CE2E113BF036AE2E1653BD730000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000076E076E
      0000076E076E076E076E076E076E076E076EDD7357572A16AD2AEE2E6B1EDC6F
      FE7BD23EE9118D268D266D228D2A0A166F2EDD7357572A16AD2AEE2E6B1EDC6F
      FE7BD23EE9118D268D266D228D2A0A166F2E0000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000086E086E
      0000086E086E086E086E086E086E086E086E0000BC6F09128D26AD2A4B1A7963
      0000000091360A164B1E4C1E2B1E4D2600000000BC6F09128D26AD2A4B1A7963
      0000000091360A164B1E4C1E2B1E4D2600000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000086E086E
      086E086E086E086E086E086E086E086E086E0000FF7F2B1AAF2E8E2AAF2E0B1A
      FF7F000000006F2EE90D0A160B1A000000000000FF7F2B1AAF2E8E2AAF2E0B1A
      FF7F000000006F2EE90D0A160B1A000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000286E286E
      286E286E286E286E286E286E286E286E286E000000007A632B1A3243113BF036
      2C1EFF7B000000004D22E90DFF7F00000000000000007A632B1A3243113BF036
      2C1EFF7B000000004D22E90DFF7F000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000296E296E
      296E296E296E296E296E296E296E296E296E00000000000016534C1E96539657
      75532B1AF44A7A63DD73FF7F00000000000000000000000016534C1E96539657
      75532B1AF44A7A63DD73FF7F0000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000296E296E
      296E296E296E296E296E296E296E296E296E00000000000000009B6B4D22D036
      3347544B2B1A2C1EBC6F000000000000000000000000000000009B6B4D22D036
      3347544B2B1A2C1EBC6F00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000296E296E
      296E296E296E296E296E296E296E296E296E00000000000000000000BD739032
      4E266E2A3653DD730000000000000000000000000000000000000000BD739032
      4E266E2A3653DD73000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000F376296E
      296E296E296E296E296E296E296E296EAE760000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000003C003C
      003C003C003C0000000000000000000000000000000000000000C922C922C922
      C92200000000000000000000000000000000007C007CE03DE03DE03D00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000003C
      003C003C00000000000000000000000000000000000000000000C922C922C922
      C922000000000000DB6F745330432E3B0000007C007C007CE03DE03DE03DE03D
      E03DE03D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      003C000000000000000000000000000000000000000000000000C926C926C926
      C9260000BA6B2E3BC926C926C926C9260000007C007C007C007CE03DE03DE03D
      E03DE03DE03D0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000007C007C
      007C007C007C0000000000000000000000000000000000000000C926C926C926
      C926534FC926C926C926C926C926C92600000000007C007C007C007CE03DE03D
      E03DE03DE03D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007C007C007C
      007C007C007C007C000000000000000000000000000000000000E926E926E926
      E926E926E926E926E926E926E926E926000000000000007C007C007C007CE03D
      E03DE03DE03D0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C007C007C007C
      007C007C007C007C007C00000000000000000000000000000000E82AE82AE82A
      E82AE82AE82AE82A2E3FB867FE7B0000000000000000E03D007C007C007C007C
      E03D0000E03D0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C007C007C007C
      007C007C007C007C007C00000000000000000000000000000000E82AE82AE82A
      E82AE82AEA32B8670000000000000000000000000000E03DE03D007C007C007C
      007C0000E03D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007C007C007C
      000000000000007C000000000000000000000000000000000000E82EE82EE82E
      E82EE82EBA6B00000000000000000000000000000000E03DE03DE03D007C007C
      007C007CE03D0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C0000007C0000
      0000007C00000000007C00000000000000000000000000000000E82EE82EE82E
      E82E514F000000000000000000000000000000000000E03DE03DE03DE03D007C
      007C007C007C0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C000000000000
      007C007C007C007C007C00000000000000000000000000000000E82EE82EE82E
      E82EDB73000000000000000000000000000000000000E03DE03DE03DE03DE03D
      007C007C007C007C000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C007C007C007C
      007C007C007C007C007C00000000000000000000000000000000E832E832E832
      E8320000000000000000000000000000000000000000E03DE03DE03DE03DE03D
      E03D007C007C007C007C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007C007C007C
      007C007C007C007C000000000000000000000000514FE832E832E832E832E832
      E832E832E832514F0000000000000000000000000000E03DE03DE03DE03DE03D
      E03DE03D007C007C007C007C0000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000007C007C
      007C007C007C000000000000000000000000000000005153E836E836E836E836
      E836E836515300000000000000000000000000000000E03DE03DE03DE03DE03D
      E03DE03DE03D007C007C007C007C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      003C000000000000000000000000000000000000000000005153E836E836E836
      E836515300000000000000000000000000000000000000000000000000000000
      0000000000000000007C007C007C007C00000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000003C
      003C003C000000000000000000000000000000000000000000005153E836E836
      5153000000000000000000000000000000000000000000000000000000000000
      00000000000000000000007C007C007C007C0000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000003C003C
      003C003C003C0000000000000000000000000000000000000000000051535153
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000007C007C007C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF7F944FB44FFF7F000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000BF733B327A420000
      00000000000000007C738E59536A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FE7B703B703BFD77000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000005F2AFC25B9219C73
      00000000000000000000B372CD6D000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF7FBD7FDE7F000000000000
      000000000000FE7B2E332E33FD77000000000000000000000000000000000000
      000000000000000000000000000000000000000000001873FA29DA253A360000
      985F0F37B967396711422C52777B000000000000000000000000000000001F00
      1F001F000000000000000000000000000000085D425C00602168C6706B75DE7F
      FE7F8E2EAD26EF32EE2EEE2EEF32CE2A6E260000000000000000000000000000
      00000000000000000000000000000000000000000000AC6D3419571172259B7B
      0000EC36545B0000A746895E8D6AFF7F00000000000000000000000000001F00
      1F001F000000000000000000000000000000A55C005C00642170EF792274E374
      297F2A262D166E26AF2EAF2E8F2E6E266E260000000000000000000000000000
      00000000000000000000000000000000000000000000557FE45CA070C26CDD7F
      00007723987F0000CA469309D7097C5F00000000000000000000000000001F00
      1F001F000000000000000000000000000000E75C005C2971397FB1622979A174
      497F49774A6BA6626F2E6F2E0000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E971027DC174A0782E76
      0000D172367B00006A36B9013A02FC2A00000000000000000000000000001F00
      1F001F000000000000000000000000000000526EA564BD7F14734C5A117A8379
      4A7F697F077F636E6F2E6F2E0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002B72877D0475C270A278
      EB6D13238D3E00002A468524C62837260000000000001F001F001F001F001F00
      1F001F001F001F001F001F0000000000000000009372915E6C666E628E76C77E
      287F5377AA650C5E6F2E6F2E0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000997F4F7A2C7E8879C3700571
      5B5F771B131B4E5D8E64A4386440C84CBE7B000000001F001F001F001F001F00
      1F001F001F001F001F001F000000000000000000166B804DAF6A8E664A62446A
      2F7F7D6F44555B6BB17700000000000000000000000000000000000000000000
      00000000000000000000000000000000000000007701157FF67E2C7E467D2E76
      974BC606E70A6C5DC6448640464889543772000000001F001F001F001F001F00
      1F001F001F001F001F001F000000000000000000A649C055AE6AF276D072A251
      7A73B16EA6514C5EBB7F00000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF7F9801AE04926A26396461513B
      2D37E8025123BC6BC341C7484965F368156E0000000000000000000000001F00
      1F001F0000000000000000000000000000000000A649E055A96A1477337FC355
      BC7BF272B06A8E6A6E6A00000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D6F76013111EB0C2925AA456B7B
      F13E1163684EEC73EF622C6BEC7F287B00000000000000000000000000001F00
      1F001F0000000000000000000000000000000000E951A0514362C651C751A251
      2B56F36EF272F176D072FE7F0000000000000000000000000000000000000000
      0000000000000000000000000000000000001B5B77019601161AE7204B2DCD7F
      974FB83B310F8B57B46BEA728B7F477300000000000000000000000000001F00
      1F001F0000000000000000000000000000000000DD7B6245A14DC151A0510756
      C74D8F66347B337FF17AFE7F0000000000000000000000000000000000000000
      0000000000000000000000000000000000007877B321504E1D2B4E77AF7FAF7F
      DE5BFE47FC1F4D33AB6B497F667FB47700000000000000000000000000001F00
      1F001F00000000000000000000000000000000000000BC7BC74DA6490952FF7F
      64458649D26AF172F176FF7F0000000000000000000000000000000000000000
      00000000000000000000000000000000000000007252A855F26E6E62EE6EFF7F
      FE6B0B4A893DDD73B4660B5AD97F0000FF7F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8549C355235EA549CA49FF7F0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000185F0539F3726749F36E0000
      00008F6A26350000F6620D565A6F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      BB7B0877A86A2C5A9B7700000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF7F0000176B7A6B884D9B7B0000
      0000D36ACC4D0000FE7F9A7700000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F00
      0F000F000F000F000F000F000F000F000F000000000000000000000000000000
      0000000000000000EF3DEF3DEF3D0000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F00
      000000000000000000000000000000000F000000000000000000000000000000
      000000000000EF3DEF3DEF3D00000000F75E00000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F00
      000000000000000000000000000000000F000000000000000000EF3DEF3DEF3D
      F75EEF3DEF3DEF3D00000000F75EEF3DF75E00000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F00
      000000000000000000000000000000000F00000000000000EF3DEF3D00000000
      00000000000000000000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000F000F000F000F00
      0F000F000F000F000F000F000F000F000F0000000000EF3DEF3D000000000000
      00000000000000000000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000F00000000000F00
      0F000F000F000F000F000F000F0000000F000000EF3DEF3D00000000EF3DF75E
      0000EF3DEF3DF75EEF3D000000000000F75E00000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000F00000000000F00
      0F000F000F000F000F000F000F000F000F000000F75EEF3D0000000000000000
      0000000000000000000000000000EF3D000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000F00000000000000
      000000000000000000000F000000000000000000EF3DEF3D0000F75E00000000
      00000000000000000000F75E00000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000F00
      0F000F000F000F000F000F000F000F00000000000F000F000F000F000F000F00
      0F000F000F000F000F000F000000000000000000EF3D00000000000000000000
      000000000000EF3D0000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000F0000000F000F000F000F00
      0F000F000F000F0000000F000000000000000000EF3D0000F75E000000000000
      0000EF3D000000000000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000F0000000F000F000F000F00
      0F000F000F000F000F000F000000000000000000F75E00000000000000000000
      EF3DEF3D000000000000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000F000F000F000F00
      0F000F000F000F000F00000000000000000000000F0000000000000000000000
      0000000000000F00000000000000000000000000F75E0000000000000000EF3D
      EF3D0000EF3D000000000000EF3D0000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000F000F000F000F000F000F00
      0F000F000F000F000000000000000000000000000000000000000000EF3DEF3D
      0000F75E000000000000EF3D00000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E0000000000000000000000000F000F000F000F000F000F00
      0F000F000F0000000000000000000000000000000F000F000F000F000F000F00
      0F000F0000000F000000000000000000000000000000000000000000EF3D0000
      000000000000EF3D0000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000F000F000F000F000F000F00
      0F000F000F000F000000000000000000000000000000000000000000EF3DEF3D
      00000000000000000000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF7F9452282539670000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000DE7B1042122612268A315A6B
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EF3DE07F000000000000000000000000EF3DEF3DEF3D
      0000EF3D003CEF3D00000000EF3D000000000000000000000000000000000000
      000000000000000000000000000000000000FF7F31461226122612263226C810
      7B6F000000000000000000000000000000000000000000000000EF3DEF3D0000
      00000000000000000000E07F0000000000000000000000000000007C003CEF3D
      0000003C003CEF3D000000000000EF3D00000000000000000000000000000000
      0000000000000000000000000000000000007B6FCE39122612261226F85A8C31
      104A000000000000000000000000000000000000000000000000000000000000
      E07F000000000000EF3D0000E07F000000000000000000000000EF3D003C003C
      003C003C003CEF3D0000000000000000EF3D0000000000000000000000000000
      000000000000000000000000000000000000EF3D12261226332AF85A12268C3D
      D65A000000000000000000000000000000000000E07FE07FEF3DE07F00000000
      0000E07F00000000E07F00000000000000000000EF3DEF3DEF3D003C003C007C
      007C007C003C003CEF3DEF3DEF3D000000000000000000000000000000000000
      0000000000000000000000000000000000000621122612265A6B5A63B556AC45
      DE7B00000000000000000000000000000000E07F00000000E07F000000000000
      E07FE03D000000000000E07F0000000000000000003C003C003C003C007C0000
      00000000007C003C003C003C003C000000000000000000000000000000001F00
      0000000000000000000000000000000000009452E941CF52953A1863176F1042
      FF7F000000000000000000000000000000000000E07FE07F0000E07FE07F0000
      E03D00000000E07FE07F00000000000000000000EF3D007C003C003C00000000
      000000000000007C003C007CEF3DEF3D0000000000000000000000001F00FF03
      1F001F001F00000000000000000000000000000039674B19AD356A45F75E734E
      CE39DE7B00000000000000000000000000000000E07F00000000000000000000
      E07FE07F0000E07F00000000000000000000000000000000007C003C00000000
      000000000000007C003C000000000000000000000000EF3D00001F00FF03FF03
      FF03FF031F00000000000000000000000000000000009C7394527B6F00000000
      94528C31DE7B0000BD773967DE7B00000000E07F00000000000000000000E07F
      00000000E07F00000000000000000000000000000000EF3D003C003C00000000
      000000000000003C003C003CEF3D00000000000000000000000000001F00FF03
      1F001F001F0000000F000F000000000000000000000000000000000000000000
      0000D65ACE39F85A953A953AA52C9C7300000000E07F000000000000E07F0000
      E07FE07F00000000000000000000000000000000EF3D003C003C003C003C0000
      00000000003C003C003C003C003C0000000000000000EF3DEF3D000000001F00
      00000000000000000F000F000000000000000000000000000000000000000000
      00000000F85ACE399452953A953A29299C730000E07FE07F0000E07FE07F0000
      E07F000000000000000000000000000000000000EF3D007CEF3D007C003C003C
      003C003C003CEF3DEF3DEF3DEF3D000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF7F12269452CE39953A953A8C31CE39E07F00000000E07F0000E07FEF3D
      0000EF3DE07F0000000000000000000000000000000000000000EF3D003C003C
      007C003C003CEF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DE7B1226953A953A953AF85AAD35E7390000E07FE07F0000E07F0000EF3D
      EF3DE07F00000000000000000000000000000000000000000000007C003C007C
      0000007C003C003C000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF7FCE39953A953AF85A8C31D252734E0000E07FE07F0000E07FE07FE07F
      E07FE07F00000000000000000000000000000000000000000000EF3D007C0000
      00000000007CEF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF7F1042F85AEF3D3667D65AFF7FE07F00000000E07F0000E07FE07F
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF7FB5560C3EB556FF7F0000000000000000FF7BFF7B7B7F0068
      006800680068006800680068006800689C7F0000000000000000000000000000
      0000000000000000000000000000000000004B6AC665C665C665C665C665C665
      C665C665C665C665C6654B6A00000000000000000000000000000000195BF22D
      2D0D2D0DF22D1A5B00000000000000000000DF7B9F4A9F1D5F0D7E090068D572
      D572D572D572D572D572D572D572737200680000000000000000000000000000
      000000000000000000000000000000000000E665E665E665E665E665E665E665
      E6650000000000000000E6650000000000000000000000003B634F096E0DF229
      533A3336AF210B090D0D3A63000000000000DF2D7D015E017F01DF01F629CD69
      CD69CD69CD69CD69CD69CD69CD69CD69BD7B0000000000000000000000000000
      000000000000000000000000000000000000E665E665E665E665E665E665E665
      E6650000000000000000E66500000000000000000000B84A9101B7429C73FF7F
      00000000DE7F5A6B1236CA04974A00000000FF2DBD019E019F011F029F02DF02
      FF01DF021F03FF1600000000000000000000000000000000000000001F001F00
      1F001F001F001F0000000000000000000000E665E665E665E665E665E665E665
      E6650000000000000000000000000000000000003B5FF5019D5F000000000000
      00000000000000000000974AEB04974A00005F3EDD0DDD01BF013F029F021F06
      CF391D069F033F1B00000000000000000000000000000000000000001F001F00
      000000000000000000000000000000000000E769E769E769E769E769E769E769
      E7690000000000000000316EDE7F000000005C6785745C67DE738574DE73A574
      DE738574DE738574DE738574DF73857400009F6FDE211C02DF01FF01BF001C63
      44713D335F025F2F00000000000000000000000000000000000000001F001F00
      000000000000000000000000000000000000E769E769E769E769E769E769E769
      E7690000000000000000C5604A69DE7F00008574DE738574DE738574DE73A574
      DE738574DE738574DE738574DF738574F95600007F6B9D05DE01BF00DF774F5A
      CA51DF77FF02DF6F00000000000000000000000000000000000000001F001F00
      000000000000000000000000000000000000076A076A076A076A076A076A076A
      076A0000C664C664C664C664C6646B69DE7F8574DE738574DE738574DE738574
      DE738574DE738574DE738574DF738574FA52000000009F6BBF151F5FD16E6449
      86493A5BBF6B000000000000000000000000000000000000000000001F001F00
      000000000000000000000000000000000000076A076A076A076A076A076A0000
      076A0000E768E768E768E768E768E6686B6D9E63B67A8574DE738574DE738574
      A5748574DE7385748574DE73DF738574FA52000000000000FF7F9E738D6E2B5E
      4C624B629A77000000000000000000000000000000000000000000001F001F00
      000000000000000000000000000000000000076A076A076A076A076A076A0000
      076A0000086D086D086D076DE76CE7688C6DDE738574DE73DE738574DE738574
      DE738574DE738574DE738574DF7385741A57000000000000000000002B62B06A
      AF6A8D6AB06E000000000000000000000000000000000000000000001F001F00
      000000000000000000000000000000000000076A076A076A076A076A076A0000
      076A0000287128710871087108718C71DE7F8574DE73B67ADE738574DE738574
      DE738574DE738574DE738574DF738574FA520000000000000000366FB16AF26E
      D172D072AF6EFF7F00000000000000000000000000000000000000001F001F00
      000000000000000000000000000000000000076E076E076E076E076E076E076E
      076E00000000000000002975AD75DE7F00008574DE73A574DE738574DE738574
      D67A8574DE738574DE738574DF738574FA5200000000000000000B56F36EF272
      1277127BD072FE7F00000000000000000000000000000000000000001F001F00
      000000000000000000000000000000000000086E086E086E086E086E086E086E
      086E0000000000000000737ADE7F000000005B6785743B67857485748574DE73
      8574B67ADE738574A574DE73857485748574000000000000BC7B8649E9551377
      127B127FD072FF7F000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000086E086E086E086E086E086E086E
      086E0000000000000000000000000000000000005C671C4FFF7BFF7FDE739C6F
      9C6F9C6F9C73FF770000DF737A0A3B5B00000000000000009B7744456545E32C
      906AAF6ED0720000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000286E286E286E286E286E286E286E
      286E0000000000000000286E00000000000000000000FA5A1B53DF730000FF7F
      FF7FFF7FFF7F0000BE679A1ADA4200000000000000000000DD7B6545E455225E
      E32C8645CB4D0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000286E286E286E286E286E286E286E
      286E0000000000000000286E0000000000000000000000005C6BDA4A5C5B9E6B
      BE6FBE6F9E63FB46792E5C5F0000000000000000000000000000F16EA76A856A
      075A0B5679730000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008D72296E296E296E296E296E296E
      296E296E296E296E296EAE76000000000000000000000000000000003B63B94A
      783E783A983E1B5B000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000007B6FF21C00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B6FF31CF534481E00000000E07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000007B6FF31CF534881E7B6F00000000E07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000001F00000000000000000000000000000000000000
      0000000000007B6FF31CF534881E7B6F000000000000E07F0000000000000000
      00000000000000000000000000000000000000000000000000001F001F000000
      0000000000001F001F0000000000000000000000000000000000000000000000
      0000000000000000000000001F0000000000000000000000000000009C730000
      000000007B6FF31CF534881E7B6F0000000000000000E07F00000000EF3D0000
      00000000000000000000000000000000000000000000000000001F001F000000
      0000000000001F001F0000000000000000000000000000000000000000000000
      0000000000000000000000001F00000000000000000000000000145F22571663
      00007B6FF31CF534881E7B6F00000000000000000000E07F00000000EF3D0000
      EF3D00000000000000000000000000000000000000000000000000001F001F00
      1F001F001F001F00000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000017674966905A3163E067D25A
      F662A8513141881E7B6F000000000000000000000000E03D000000000000EF3D
      0000EF3D0000000000000000000000000000000000000000000000001F001F00
      000000001F001F00000000000000000000000000000000000000000000000000
      1F7C000000000000000000000000000000000000B166E07E607AEA41C0639356
      E16D807E24527B6F0000000000000000000000000000E07F00000000EF3D0000
      EF3D00000000000000000000000000000000000000000000000000001F001F00
      000000001F001F0000000000000000000000000000000000000000000000007C
      00000000000000000000000000000000000000007B6F2462847F6566E535A662
      807F016E596F00000000000000000000000000000000E07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000001F00
      1F001F001F00000000000000000000000000000000001F7C0000000000000000
      1F7C000000000000000000000000000000001663125FD65A885AEE7FEB7FE67F
      C462714E316333630000000000000000000000000000E07F0000000000000000
      EF3D0000EF3D0000000000000000000000000000000000000000000000001F00
      1F001F001F000000000000000000000000001F7C007C0000000000000000007C
      0000000000000000000000000000000000002257E067C063A531EE7FF57FEB7F
      634A815FE06722577B6F000000000000000000000000E07FE07FE07FE07FEF3D
      0000EF3D0000EF3DEF3D00000000000000000000000000000000000000000000
      1F001F000000000000000000000000000000000000000000000000001F7C0000
      000000000000000000000000000000000000145F31634E4A645AF57FEC7FEF7F
      066F0E4AB5561863000000000000000000000000000000000000EF3D0000EF3D
      0000EF3D0000EF3DEF3D00000000000000000000000000000000000000000000
      1F001F0000000000000000000000000000001F7C00000000000000001F7C0000
      000000000000007C0000000000000000000000001767C16EA27FA662E735254E
      817F607AB262000000000000000000000000000000000000000000000000EF3D
      EF3D0000EF3D0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000001F7C00000000000000000000
      0000F75E000000000000000000000000000000009062407FC16EB45A815F714E
      0462807E49660000000000000000000000000000000000000000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007C0000007C
      0000000000000000F75E000000000000000000007B6FB166596FB556E0673163
      7B6FB16617670000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001F7C0000000000000000
      00001F7C00001F7C00000000000000000000000000000000000018632257145F
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000151EF5157C63572A1B53000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF7FFF7F00000000
      000000000000FF7FFF7FFF7FFF7F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009D6B
      F5153722B305B305B305B30537220000000000000000000000000000EF3DEF3D
      00000000EF3D0000000000000000000000000000FF7FFF7F00000000FF7FFF7F
      00000000FF7FFF7F00000000FF7FFF7F0000000000000000003C003C007C003C
      007C007C003C007C000000000000000000000000000000000000000000005C5B
      B405B405B405B405B405B405B40557263B53000000000000000000000000FF03
      0000FF03FF0300000000EF3DFF03000000000000000000000000000000000000
      00000000000000000000000000000000FF7F00000000007C003C007C007C003C
      007C007C003C007C007C003C003C0000000000000000000000000000BE73B93A
      B405B40599327D635C5BD50DB405B405782A00000000EF3D0000FF0300000000
      00000000000000000000FF03000000000000BD77EF3D000000000000630CBD77
      00000000BD77630C000000000000EF3DBD7700000000003C003C003C003C007C
      003C003C007C003C003C007C003C0000000000000000000000000000DA3AD505
      D505371E0000000000005C5BD505D5057D630000000000000000000000000000
      FF03000000000000EF3D0000FF0300000000EF3DE818D7467B677B6F534A6308
      00000000630C734A9C739C67BE5B953EEF3D0000000000000000003C007C003C
      007C007C003C007C007C003C007C0000000000000000000000000000BE731716
      D50578260000000000007D63D505D50517160000FF03FF03EF3DFF0300000000
      0000FF0300000000FF03000000000000000042089D57FF67BF6BDF7BFF7F0000
      000000000000FF7BDF779F6BFF6B7B53420800000000E03D00000000003C003C
      007C007C003C007C007C003C007C003C000000000000000000000000DF7B3716
      F605170E9E6B00000000BA36F605F605581EFF0300000000FF03000000000000
      FF03E03D000000000000FF0300000000000042089D5BFF67FF73FF7F00000100
      0000000000000000FF7FDF73FF6B7B53420800000000E03D00000000003C007C
      003C003C007C003C003C007C003C003C000000000000B77F00002C7F3767F705
      F705F705170E7926581EF705F705792600000000FF03FF030000FF03FF030000
      E03D00000000FF03FF0300000000000000000000A5101036734A734EAD35640C
      630C630C640C8C2D5146313ECF3163082104000000000000E07F0000007C003C
      007C007C003C007C007C003C007C003C00000000B77FA07EE47EA07EE67ECB66
      B442F705F705F705F705F705F705381600000000FF0300000000000000000000
      FF03FF030000FF0300000000000000000000AD3521040000000000008410D65A
      DE7BDE7BF75E84100000000000004208B55600000000003C003C007C007C003C
      007C007C003C007C007C003C007C003C0000937F087FC07EE67E087FC27EC07E
      EF66F70558165816F705FB3E5D5B9E6B0000FF0300000000000000000000FF03
      00000000FF0300000000000000000000000039676B2D6B2D0000000000000000
      00000000000000000000FF7F4A298C3100000000003C007C00000000003C007C
      003C003C007C003C003C007C003C00000000287FC07E4C7F00000000D97FE27E
      E47E3567DF7BBE73FB3EBE730000000000000000FF03000000000000FF030000
      FF03FF0300000000000000000000000000000000BD77C6184A29BD7700000000
      0000000000000000BD772925E71CDE7BFF7F0000003C00000000007C00000000
      0000000000000000007C003C007C000000006E7FE07EB77F000000000000287F
      E07E937F00000000000000000000000000000000FF03FF030000FF03FF030000
      FF0300000000000000000000000000000000FF7F0000DE7B4A29082118630000
      000000000000F75E08212925DE7B0000FF7F00000000007C00000000003C003C
      00001F7C1F7C0000007C003C003C00000000E07EE07EB57F000000000000267F
      027FFD7F0000000000000000000000000000FF0300000000FF0300000000EF3D
      0000EF3DFF030000000000000000000000000000FF7F00000000104208212925
      0000000029250821524A00000000FF7F000000000000003C003C003C003CE03D
      0000003C007C003C003C003C003C00000000FB7F007F027FB57FD77F6C7F007F
      007FB57F00000000000000000000000000000000FF03FF030000FF030000EF3D
      FF03FF03000000000000000000000000000000000000FF7F00000000DE7BEF3D
      000000001042FF7F00000000FF7F000000000000000000000000E001E001E03D
      0000003C003C003C003C00000000000000000000227F007F007F007F007F467F
      0000000000000000000000000000000000000000FF03FF030000FF03FF030000
      0000000000000000000000000000000000000000000000000000FF7F00000000
      0000000000000000FF7F000000000000000000000000E003EF3DEF3D00000000
      E03D000000000000000000000000000000000000FB7FFD7F007F6C7F8E7F917F
      000000000000000000000000000000000000FF0300000000FF03000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E003E001EF3DE00100000000
      00000000000000000000000000000000000000000000000000009C738C318C31
      8C318C2D6C2D6C2D6C2D8C2D4A294A2900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF7FFF7FFF7FFF7F00000000630C
      00000000000000000000000021042104210400000000FF7FFF7F7B6F4A29FF7F
      FF7FFF7FFF7FFF7F7C6B7C6B1A5B4A2900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7F0000630C
      00000000000000000000000000000000000000000000000000009C734A29D65A
      3146524A524A524A524A3146D7564A2900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000630C
      000000000000000000000000000000000000000029256B2D6B2DF75E4A29FF7F
      FF7FFF7FFF7FFF7F7C6B7C6B3A634A2900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D52DF62DF72D1A2AFC5200000000
      00000000000000000000000000000000000000004A29F75E5A6BB5524A29F75E
      524A734E734E734E734E524A185F4A2900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E03DE03DE03D
      E03DE03DE03DE03D00000000000000000000D200160138013601F4358C005801
      550D974A00005A6B941D58059B09560D922500004A295A6B945231464A29FF7F
      FF7FFF7FFF7FFF7FFF7FFF7F3A634A2900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E07FE03DE03D
      E03DE03DE03DE03DE03D0000000000000000AE00AF00D004AF00363E00008C00
      1632FF7FFF7F0000F85A370159018C00000000004A297B6F5A6BB5564A291863
      94529452945294529452934E39674A2900000000000000000000000000000000
      000000000000000000000000000000000000000000000000E07F00000000E03D
      E03DE03DE03DE03DE03DE03D000000000000121554257525331D163A00008C00
      5315DF77FF7FFF7F363A370155118C00FF7F00004A293967945231464A29FF7F
      FF7FFF7FFF7FFF7FFF7FFF7F7B6F4A2900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E07FE07F0000
      000000000000000000000000000000000000690D2C1A4C1E0B16513A00005B67
      8C00321574195219340915018C00FF7FFF7F00004A299C73BD77F75E4A291863
      945294529452FF7FFF7FFF7FD65A4A2900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E07FE07F0000
      E07FE07F0000000000000000000000000000E001A002E002C0028E3A0000FF7F
      8C00110D783EB425F200F2008C000000FF7B00004A2918633146EF3D4A290000
      0000000000000000103E103E103E4A2900000000000000000000000000000000
      000000000000000000000000000000000000000000000000E07F000000000000
      00000000000000000000000000000000000000016001800160014E3A00000000
      8C00511900005642D1008C009C730000FF7F00004A299C73BD7718636B2D0000
      0000000000000000103E39636B2DFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A40D281E491E06166E3A00000000
      8C00CE0CD8567221AF008C000000FF7F000000004A2918631042CE394A29D65A
      D65AF75ED65AF75E103E4A29FF7F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C128033D0441E3380E4A00000000
      00008C000F15CE0C8C008C000000FF7F000000004A29BD77FF7FDE7B29256B2D
      6B2D4A294A294A296B2D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000054006000680064CE610000FF7F
      00008C00EF0831158C00FF7F00000000000000004A29DE7B0000000000000000
      BD77103E7C6B6B2D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000003C003C00400040CE590000FF7F
      00008C0017367A3E8C00000000000000000000004A299C73DE7BDE7BDE7BDE7B
      7B6F103E6B2D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A44807512851E64CEE5D0000FF7F
      000000008C008C003B67000000000000000000004A294A294A294A294A294A29
      4A2929250000FF7FFF7F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004955EE690F6EAB65105E00000000
      000000008C008C00BE7700000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF7F0000524A524A524A524A524A
      524A524A524A524A524A524A524A0000FF7F0000000000000000000000000000
      000000000000000000000000000000000000000000003D67DB3D1E259E3DBF66
      9F5ADF355F25FF18FD20DE3D5E6B00000000000000000000754AF13DF13DF13D
      F13DF13DF13DF13DF13D113E01310008905A0000DE7B524A9C739C739C739C73
      9C739C739C739C739C739C73524ADE7B00000000000000000000000000000000
      00000000000000000000000000000000000000000000F71C9D045F2A9F53DF5B
      7F4BFF3A7F261F1A9F0D9D041721000000000F42072500001B5F000000000000
      00000000000000000000013100084D7FC64D0000724A9C73534A9C739C739C73
      9C739C739C739C739C73524A9C73724AFF7F0000000000000000000000000000
      000000000000000000000000000000000000000000009D04DF15DF329F4FDF5B
      7F4BFF3E9F2E7F225F1E9F0D9C0400000000CD3D18630000AD31CE394B292A21
      4A214A212A214B29013100084D7FC64DCD3D724A9C739C73724A534A534A534A
      534A524A524A524A524A724A9C739C73724A0000000000000000000000000000
      000000000000000000000000000000000000000000009E00BF153F269F4F9F57
      7F4BBF3A5F2A3F1E3F1E9F0D9E000000000072527B6F7B6F7B6F103EF131D84A
      3B5B3B5BD84AF131E718AD39C64D80227252724A9C739C739C739C739C739C73
      9C739C739C739C739C739C739C739C73724A0000000000000000000000000000
      000000000000000000000000000000000000000000007D04FF0C7F1DBF423E4F
      BF3E3F32BF1D7F193F15FF089D0400000000B55ABD77BD77D756323A7B67BD77
      BD77BD77BD777B671136A93DBD77BD77B55A724A9C739C739C73DD0EDD0EDD0E
      DD0EDD0EDD0EDD0EDD0E9C739C739C73724A0000000000000000000000000000
      000000000000000000000000000000000000000000007B085F119F2E9F4FDF5B
      7F4BFF3E9F2A5F22DF191F097A08000000001763FE7F6E1DCF2D6D1D0B0DF129
      96469646F1290B0D6D1DCF2D6E1DFE7F1763724A9C739C73DD0E1E03FE02FE02
      FE02FE02FE02FE02FE021E039C739C73724A0000000000000000000000000000
      0000000000000000000000001F0000000000000000009E04DF15BF2E9F4FDF5B
      5F4BFF3A9F2A5F225F1E9F0D9D0400000000386B00008F19F131151E181A181A
      181A181A181A181A151EF1318F190000386B724A9C739C737A0A370A16061706
      170617061706170217067A029C739C73724A0000000000000000000000000000
      00000000000000001F001F001F001F001F00000000009E04BF159F2E3F479F57
      1F43BF3A5F2A3F1E3F1A9F0D9E0000000000596B0000F421F135763E7F537F53
      7F537F537F537F53763EF135F4210000596B0000724A9C73341AEF39524E524A
      524A524A524A524A724A341A9C73724A00000000000000000000000000000000
      000000001F001F001F001F001F001F001F00000000009D041F0D7F255F42BE56
      5E42DF319F213F153F15FF089C0400000000396BDE7B581ED12DC8100B110000
      B121B12100000B11C810D12D581EDE7B396BFF7F0000724AD11D724A00000000
      0000000000000000724AB015724A000000000000000000000000000000000000
      00000000000000001F001F001F001F001F00000000007C043F0D5F2E7F4BDF5B
      5F47FF3E9F2E3F22DF19FF087B04000000007B6F1763381A7646AE2D29214B29
      000000004B292921AE2D123E381A17637B6F00000000FF7FFF7F724AFF7FFF7F
      FF7FFF7FFF7FFF7F724A0000FF7F000000000000000000000000000000000000
      0000000000000000000000001F0000000000000000009E04DF15BF2E9F4FDF5B
      7F4BFF3E9F2E7F225F1E9F0D9D0400000000000000000000D956D752AE2D0921
      081D081D0921AE2DD75233420000000000000000000000000000724AFF7FFF7F
      FF7FFF7FFF7F0000724A00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009D009F0D3F26DF427F57
      FF4A7F3A1F26DF15BF115F099D0000000000000000000000D956FF77FA56543E
      F135F135543EFA56FF7733460000000000000000000000000000724AFF7FFF7F
      FF7FFF7FFF7F0000724A00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007E049F211F3A9F4A1F57
      FF52BF4A7F3E1F36BF295F197E0400000000000000000000F95A00007F677F67
      7F677F677F677F67000033460000000000000000000000000000724A00000000
      000000000000DE7B724A00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001F3E1F473F4B5F4B5F4B
      7F4B7F4B5F4B5F4B3F47DF3E5E2100000000000000000000FA5A000000000000
      0000000000000000000053460000000000000000000000000000724ABD77BD77
      BD77BD77BD777B6F724A00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009F321F1E9F2EFF361F3F
      1F3F1F3FFF3ADF36BF2EDF151F2200000000000000000000FA5AFA5AFA5AFA5A
      FA5AFA5AFA5AFA5AFA5A97520000000000000000000000000000724A724A724A
      724A724A724A724A000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DF77BF461F2E5F15FF08
      FF041F055F095F15FF295F3EBF6F00000000424D3E000000000000003E000000
      2800000040000000D00000000100010000000000800600000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFC1000000000000
      9FC10000000000009FCF00000000000083CF000000000000804F000000000000
      904F000000000000D04F000000000000904100000000000081C1000000000000
      8E41000000000000807F0000000000009001000000000000E407000000000000
      F81F000000000000FFFF000000000000F00FFFFFFFFFFFFFC003FFC1FFE3FFC9
      80019FC19FE39FC980019FF99FE39FC9000083F983E383C10000804180638041
      00009041906390410000D04FD063D0410000904190419041000081C1818081C1
      00008E418E418E410000807F807F807F80019001900190018001E407E407E407
      C003F81FF81FF81FF00FFFFFFFFFFFFFFFFFFFFFFFFFC007FFFFFFFFFFFF8003
      FFFFFFFFFFFFBFF3F9FFF9FFFE7FBFF3F9FFF9F7FE7FB033F9FFF9E7FE7FBFF3
      F9FFF9C1FE7FB033F81FF9C1FE7FBFF3F9CFF9E7FC3FB033F9CFF9F7F99FBFF3
      F9CFF9FFF3CFB133F81FE07FF3CFBFF3FFFFFFFFFFFFBFF3FFFFFFFFFFFFAAAB
      FFFFFFFFFFFFD557FFFFFFFFFFFFEAAF8000FFFFFFFFFFFF0150F81FF81FFFFF
      2000F00FF00FFFFF0000E007E007F81F03E0C603C603F9FF800083818381F9FF
      F80081818181F9FFF90000000000F83FF90000000000F9FFF90081818181F9FF
      F80080C380C3F9FFF800C063C063F81FF800E007E007FFFFF800F00FF00FFFFF
      F800F81FF81FFFFFF800FFFFFFFFFFFFFFFFF83FF0FF0007FFFFFC7FF0E10007
      FEFFFEFFF0810007FEFFF83FF0018007FEFFF01FF001C007FEFFE00FF003C007
      FEFFE00FF01FC007FEFFF1DFF03FC007FEFFEB6FF07FC007FEFFEE0FF07FC007
      FEFFE00FF0FFC007FEFFF01F801FC007FEFFF83FC03FC003FEFFFEFFE07FC001
      FFFFFC7FF0FFFFF0FFFFF83FF9FFFFF8FFFFFFC3FFFFE3E3FFFFFFC3FFFFE1F3
      FFFF8FC3FFFFC203FC3F0000F39FC121FC3F0000F31FC121FC3F0007F31FC121
      E0070007F21FC021C0078007F09F8000C007800FF09F8000C007800FF19F0000
      FC3F800FF19F0001FC3F8007F39F0001FC3F8007FFFF0001FC7FC007FFFF8002
      FFFFFE07FFFF8323FFFFFE0FFFFF4327F81FFFFFFC00FFE1F81FF800FDFEFFC2
      F81FFBFEFDFEF000F81FFBFEFDFEE01BF81FFBFEE000C7F6F81FFBFEEC02890C
      F81F1BFEEC0087F1F81F7BFEEFF78433F81F780080078B93F81F7800A0178713
      F81F7FF7A0078E33F81F6007BFDF9C33F81F7FDF801FF847F81F001F805FF99F
      F81F001F801FF87FF81FFFFFFFFFFFFFFFFFFFFFFFFFC3FFFFF3FFF1FFFF81FF
      FFC3F113FFFF00FFF007F115FFFF00FF000BF01E800100FF830F8003BFFD00FF
      6C378383BDFD00FF924F87C1B83D807FB05FE7CF903DC62345BFC7C3B825FF01
      8A5F83838DE5FF80921F8003BFFDFF00681FF01F8001FF00907FF11FFFFFFF00
      907FF39FFFFFFF8069FFFFFFFFFFFFC1E000FFFF0007F81F0000FFFF00F7E007
      0000FFFF00F7C183001FF81F00FF8FF1001FF9FF00F30001001FF9FF00F10000
      801FF9FF00800000C03FF9FF02800000E03FF9FF02800000F83FF9FF02800000
      F01FF9FF00F10000F01FF9FF00F30000E01FFFFF00FF8011E03FFFFF00F7C423
      E03FFFFF00F7E007F03FFFFF0007F81FF7E7FFF9FFFFFFFFF7F9FFF09FFFFFFF
      F7E9FFE09FFFFFFFF7B1FFC183E3F3CFF7D1FB838003F3CFF451F1079007F81F
      F85B800F9007F99FF847801F900FF99FF8BF803F81C7FC3FD8FF001FC633FC3F
      39FF000F800DFE7FF3FF001FD001FE7F73DF803FE407FFFFA77F803FF91FFFFF
      E5EF803FFFFFFFFFCF5FF1FFFFFFFFFFFF83FFFFE7C3F81FFC03F9339999E007
      FC00E003FFFEC003F800C0070180C003F870000B0180F003F870830F0180D800
      F8306C3705A0D800D001924F0000E8008001B05F0000C000000145BF1FF19801
      1807825F87E0B7E11C7F921F43C2D8231C7F6C1FB18DC103007F907FD99BF10F
      81FF93FFF7EFC27F81FF6FFFFFFF877FF001FFFFFFFF0D48C001FFFFFFFF0548
      F001C007FFFFFD488001DFF7C01F07FF8001DFF7C01F00408001DFF7D0070421
      8001DFF7C80304008001DFF7D00304008001DFF7D25F040283E1DFF7C81F0642
      83E1DFF7E7E306058003DF87FF6B0705800FDFAFFF9F05079E1FDF9FFFFF050F
      803FC03FFFFF058F804FFFFFFFFF078FFFFF40028007C003E0008001BFF7C003
      0FF08000A017C00300000000ACD7C00300000000AFD7C00300000000AFD7C003
      00000000AFD3C00340020000AFC0C00340028001A380C003024047E3AFC0C003
      0180C00BA1D3C003E007F02FAFD7C003E007F02FA017C003E817F7CFBFF7C003
      EFF7F00F8007C003E007F01FFFFFC00300000000000000000000000000000000
      000000000000}
  end
  object ActionManager1: TActionManager
    ActionBars.SessionCount = 38
    ActionBars = <
      item
        Items.CaptionOptions = coNone
        Items = <
          item
            Action = NextView
            ImageIndex = 10
            ShortCut = 86
          end
          item
            Color = clNone
            Action = ShowSelection
            ImageIndex = 20
            ShortCut = 16471
          end
          item
            Action = Preferences
            ImageIndex = 8
            ShortCut = 24646
          end
          item
            Action = DoIncludeYears
            ImageIndex = 42
            LastSession = 3
            ShortCut = 16473
          end
          item
            Action = CoverWeights
            ImageIndex = 23
            LastSession = 3
          end
          item
            Action = ToolSpace
            Caption = 'Sp&ace'
            ImageIndex = 32
          end
          item
            Action = ChangeAbsent
            Caption = 'A&bsent Teacher'
            ImageIndex = 16
            ShortCut = 49264
          end
          item
            Action = ChangeLost
            ImageIndex = 18
            ShortCut = 49265
          end
          item
            Action = ChangeAddedStaff
            ImageIndex = 29
            ShortCut = 49266
          end
          item
            Action = ChangeNewClass
            ImageIndex = 31
            ShortCut = 49267
          end
          item
            Action = ChangeMergeClass
            ImageIndex = 34
            ShortCut = 49268
          end
          item
            Action = ChangeUnavailRoom
            ImageIndex = 36
            ShortCut = 49269
          end
          item
            Action = ChangeRoomSwap
            ImageIndex = 38
            ShortCut = 49270
          end
          item
            Action = ToolSpace
            Caption = 'Spa&ce'
            ImageIndex = 32
          end
          item
            Action = ManualCover
            Caption = 'C&over ...'
            ImageIndex = 13
            ShortCut = 49219
          end
          item
            Action = MyAutoCover
            Caption = 'Auto Cover'
            ImageIndex = 12
            LastSession = 3
          end
          item
            Action = ChangeEmailCovers
            ImageIndex = 22
            ShortCut = 16459
          end
          item
            Action = ToolSpace
            ImageIndex = 32
          end
          item
            Action = ShowCurrentExtras
            Caption = 'Curren&t Extras'
            ImageIndex = 39
            ShortCut = 16453
          end
          item
            Action = ShowPastExtras
            Caption = 'Past E&xtras'
            ImageIndex = 40
            ShortCut = 49232
          end
          item
            Action = actTeacherTallies
            Caption = 'Tall&ies ...'
            ImageIndex = 41
            ShortCut = 32885
          end
          item
            Action = ToolSpace
            ImageIndex = 32
          end
          item
            Action = DoPrintPreview
            Caption = 'Print Previe&w'
            ImageIndex = 0
            LastSession = 9
          end
          item
            Action = MainPrint
            Caption = 'Print ...'
            ImageIndex = 1
            ShortCut = 16464
          end
          item
            Action = CopyWin
            Caption = 'Copy'
            ImageIndex = 4
            ShortCut = 16451
          end>
        AutoSize = False
      end>
    Images = ActionImages
    Left = 466
    Top = 170
    StyleName = 'XP Style'
    object DoPrintPreview: TAction
      Category = 'File'
      Caption = 'P&rint Preview'
      Enabled = False
      HelpContext = 136
      Hint = 'Print Preview for top window'
      ImageIndex = 0
      OnExecute = DoPrintPreviewExecute
    end
    object MainPrint: TAction
      Category = 'File'
      Caption = '&Print ...'
      Enabled = False
      HelpContext = 11
      Hint = 'Print top window'
      ImageIndex = 1
      ShortCut = 16464
      OnExecute = MainPrintExecute
    end
    object FilePrintSetup1: TFilePrintSetup
      Category = 'File'
      Caption = 'Print Set&up...'
      HelpContext = 12
      Hint = 'Print Setup'
      ImageIndex = -2
    end
    object NewData: TAction
      Category = 'File'
      Caption = '&New Data ...'
      HelpContext = 10
      Hint = 'Load new data'
      ImageIndex = 3
      OnExecute = NewDataExecute
    end
    object CopyWin: TAction
      Category = 'Edit'
      Caption = '&Copy'
      Enabled = False
      HelpContext = 134
      Hint = 'Copy top window'
      ImageIndex = 4
      ShortCut = 16451
      OnExecute = CopyWinExecute
    end
    object WorkAheadNew: TAction
      Category = 'Work Ahead'
      Caption = '&New ...'
      HelpContext = 5
      Hint = 'Open a new work ahead file'
      ImageIndex = 5
      ShortCut = 16462
      OnExecute = WorkAheadNewExecute
    end
    object WorkAheadOpen: TAction
      Category = 'Work Ahead'
      Caption = '&Open ...'
      HelpContext = 6
      Hint = 'Open Extras file'
      ImageIndex = 6
      ShortCut = 16465
      OnExecute = WorkAheadOpenExecute
    end
    object SetFont: TAction
      Category = 'Display'
      Caption = '&Font ...'
      HelpContext = 15
      Hint = 'Set font, size and style'
      ImageIndex = 7
      ShortCut = 16454
      OnExecute = SetFontExecute
    end
    object Preferences: TAction
      Category = 'Display'
      Caption = '&Preferences'
      HelpContext = 16
      Hint = 'Set preferences'
      ImageIndex = 8
      ShortCut = 24646
      OnExecute = PreferencesExecute
    end
    object ShowSelection: TAction
      Category = 'Display'
      Caption = '&Selection ...'
      Enabled = False
      HelpContext = 61
      Hint = 'Open selection dialogue for top window'
      ImageIndex = -20
      ShortCut = 16471
      OnExecute = ShowSelectionExecute
    end
    object NextView: TAction
      Category = 'Display'
      Caption = 'Next &View'
      Enabled = False
      HelpContext = 141
      Hint = 'Show next view for top window'
      ImageIndex = 10
      ShortCut = 86
      OnExecute = NextViewExecute
    end
    object ManualCover: TAction
      Category = 'Cover'
      Caption = '&Cover ...'
      Enabled = False
      HelpContext = 47
      Hint = 'Cover extras (manual)'
      ImageIndex = 13
      ShortCut = 49219
      OnExecute = ManualCoverExecute
    end
    object MyAutoCover: TAction
      Category = 'Cover'
      Caption = '&Auto Cover'
      Enabled = False
      HelpContext = 48
      Hint = 'Cover extras (automatic)'
      ImageIndex = -12
      OnExecute = MyAutoCoverExecute
    end
    object ShowInfoWin: TAction
      Category = 'Window'
      Caption = '&Info'
      HelpContext = 63
      Hint = 'Info window'
      ImageIndex = 44
      ShortCut = 49225
      OnExecute = ShowInfoWinExecute
    end
    object ShowAbsentTeachers: TAction
      Category = 'Window'
      Caption = '&Absent Teachers'
      HelpContext = 82
      Hint = 'Absent Teachers window'
      ImageIndex = -15
      ShortCut = 49217
      OnExecute = ShowAbsentTeachersExecute
    end
    object ChangeAbsent: TAction
      Category = 'Changes'
      Caption = '&Absent Teacher'
      HelpContext = 37
      Hint = 'Change absent teachers'
      ImageIndex = 16
      ShortCut = 49264
      OnExecute = ChangeAbsentExecute
    end
    object ShowLostTeachers: TAction
      Category = 'Window'
      Caption = '&Lost Classes'
      HelpContext = 83
      Hint = 'Lost Classes window'
      ImageIndex = -17
      ShortCut = 49228
      OnExecute = ShowLostTeachersExecute
    end
    object ChangeLost: TAction
      Category = 'Changes'
      Caption = '&Lost Classes ...'
      HelpContext = 38
      Hint = 'Change lost classes'
      ImageIndex = 18
      ShortCut = 49265
      OnExecute = ChangeLostExecute
    end
    object FileNewDay: TAction
      Category = 'File'
      Caption = 'New &Day ...'
      HelpContext = 2
      Hint = 'Start new day'
      ImageIndex = 19
      ShortCut = 16452
      OnExecute = FileNewDayExecute
    end
    object WorkAheadUse: TAction
      Category = 'Work Ahead'
      Caption = '&Use ...'
      HelpContext = 7
      Hint = 'Use work ahead file'
      ImageIndex = 21
      ShortCut = 16469
      OnExecute = WorkAheadUseExecute
    end
    object CustomizeActionBars1: TCustomizeActionBars
      Category = 'Tools'
      Caption = '&Customize'
      Hint = 'Customize toolbar'
      ImageIndex = 27
      CustomizeDlg.StayOnTop = False
    end
    object ChangeEmailCovers: TAction
      Category = 'Cover'
      Caption = '&Email Covers'
      Enabled = False
      HelpContext = 142
      Hint = 'Email Covers to Teachers'
      ImageIndex = -23
      ShortCut = 16459
      OnExecute = ChangeEmailCoversExecute
    end
    object CoverWeights: TAction
      Category = 'Cover'
      Caption = 'Wei&ghts ...'
      HelpContext = 53
      Hint = 'Set cover weights'
      ImageIndex = 23
      OnExecute = CoverWeightsExecute
    end
    object ToolSpace: TAction
      Category = 'Tools'
      Caption = 'Space'
      Hint = 'toolbar spacer'
      ImageIndex = 32
    end
    object ChangeAddedStaff: TAction
      Category = 'Changes'
      Caption = 'A&dded Staff ...'
      HelpContext = 39
      Hint = 'Change Added Staff Available'
      ImageIndex = 29
      ShortCut = 49266
      OnExecute = ChangeAddedStaffExecute
    end
    object ShowAddedAvail: TAction
      Category = 'Window'
      Caption = 'A&dded Staff Available'
      HelpContext = 84
      Hint = 'Show Added Staff Available'
      ImageIndex = -28
      ShortCut = 49220
      OnExecute = ShowAddedAvailExecute
    end
    object ChangeNewClass: TAction
      Category = 'Changes'
      Caption = '&New Class ...'
      HelpContext = 42
      Hint = 'Change New Classes'
      ImageIndex = 31
      ShortCut = 49267
      OnExecute = ChangeNewClassExecute
    end
    object ShowNewClasses: TAction
      Category = 'Window'
      Caption = '&New Classes'
      HelpContext = 85
      Hint = 'New Classes window'
      ImageIndex = -30
      ShortCut = 49230
      OnExecute = ShowNewClassesExecute
    end
    object ChangeMergeClass: TAction
      Category = 'Changes'
      Caption = '&Merge Class ...'
      HelpContext = 43
      Hint = 'Change merged classes'
      ImageIndex = 34
      ShortCut = 49268
      OnExecute = ChangeMergeClassExecute
    end
    object ShowMergeClass: TAction
      Category = 'Window'
      Caption = '&Merged Classes'
      HelpContext = 86
      Hint = 'Show merged classes'
      ImageIndex = -33
      ShortCut = 49229
      OnExecute = ShowMergeClassExecute
    end
    object ShowUnavailRoom: TAction
      Category = 'Window'
      Caption = '&Unavailable Rooms'
      HelpContext = 87
      Hint = 'Show unavailable rooms'
      ImageIndex = -35
      ShortCut = 49237
      OnExecute = ShowUnavailRoomExecute
    end
    object ShowRoomSwaps: TAction
      Category = 'Window'
      Caption = 'Room S&waps'
      HelpContext = 88
      Hint = 'Show room swaps'
      ImageIndex = 37
      ShortCut = 49235
      OnExecute = ShowRoomSwapsExecute
    end
    object ShowCurrentExtras: TAction
      Category = 'Window'
      Caption = 'Current &Extras'
      HelpContext = 89
      Hint = 'Current Extras'
      ImageIndex = -39
      ShortCut = 16453
      OnExecute = ShowCurrentExtrasExecute
    end
    object ShowPastExtras: TAction
      Category = 'Window'
      Caption = '&Past Extras'
      HelpContext = 92
      Hint = 'Past Extras'
      ImageIndex = -40
      ShortCut = 49232
      OnExecute = ShowPastExtrasExecute
    end
    object ShowSubjectList: TAction
      Category = 'Window'
      Caption = '&Subject List'
      HelpContext = 95
      Hint = 'Subject lists window'
      ImageIndex = -43
      ShortCut = 49222
      OnExecute = ShowSubjectListExecute
    end
    object ShowStudList: TAction
      Category = 'Window'
      Caption = 'Student &List'
      HelpContext = 99
      Hint = 'Student List window'
      ImageIndex = -11
      ShortCut = 16467
      OnExecute = ShowStudListExecute
    end
    object ShowStudentTt: TAction
      Category = 'Window'
      Caption = '&Student Timetable'
      HelpContext = 101
      Hint = 'Student Timetable'
      ImageIndex = -45
      ShortCut = 49223
      OnExecute = ShowStudentTtExecute
    end
    object ShowTimetable: TAction
      Category = 'Window'
      Caption = '&Timetable'
      HelpContext = 104
      Hint = 'Timetable window'
      ImageIndex = -14
      ShortCut = 16468
      OnExecute = ShowTimetableExecute
    end
    object ShowTeacherTimetable: TAction
      Category = 'Window'
      Caption = 'Teac&her'
      HelpContext = 106
      Hint = 'Teacher Timetable'
      ImageIndex = -46
      ShortCut = 49236
      OnExecute = ShowTeacherTimetableExecute
    end
    object ShowRoomTimetable: TAction
      Category = 'Window'
      Caption = '&Room'
      HelpContext = 107
      Hint = 'Room Timetable'
      ImageIndex = -47
      ShortCut = 49234
      OnExecute = ShowRoomTimetableExecute
    end
    object ShowSubjectTimetable: TAction
      Category = 'Window'
      Caption = 'Sub&ject'
      HelpContext = 108
      Hint = 'Subject Timetable'
      ImageIndex = -48
      ShortCut = 49226
      OnExecute = ShowSubjectTimetableExecute
    end
    object WindowCascade1: TWindowCascade
      Category = 'Window'
      Caption = '&Cascade'
      Enabled = False
      HelpContext = 109
      Hint = 'Cascade windows'
      ImageIndex = -26
    end
    object ChangeUnavailRoom: TAction
      Category = 'Changes'
      Caption = '&Unavailable Room ...'
      HelpContext = 44
      Hint = 'Change unavailable rooms'
      ImageIndex = 36
      ShortCut = 49269
      OnExecute = ChangeUnavailRoomExecute
    end
    object ChangeRoomSwap: TAction
      Category = 'Changes'
      Caption = '&Room Swap ...'
      HelpContext = 45
      Hint = 'Change room swaps'
      ImageIndex = 38
      ShortCut = 49270
      OnExecute = ChangeRoomSwapExecute
    end
    object actTeacherTallies: TAction
      Category = 'Codes'
      Caption = 'Talli&es ...'
      HelpContext = 69
      Hint = 'Change Teacher tallies'
      ImageIndex = 41
      ShortCut = 32885
      OnExecute = actTeacherTalliesExecute
    end
    object DoIncludeYears: TAction
      Category = 'Cover'
      Caption = 'Include &Years ...'
      HelpContext = 54
      Hint = 'Include Years'
      ImageIndex = -42
      ShortCut = 16473
      OnExecute = DoIncludeYearsExecute
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 495
    Top = 171
  end
  object ImageList1: TImageList
    ImageType = itMask
    Masked = False
    Left = 437
    Top = 170
    Bitmap = {
      494C010131003600780010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000D000000001001000000000000068
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F00000000EF3D0000
      EF3D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF7FE03D000000000000EF3D
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07F0000000000000000
      0000000000000000E003E003E003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07F0000000000000000
      EF3D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07FE07FE07FE07FEF3D
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EF3D0000EF3D
      0000EF3D0000EF3DEF3D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EF3D
      EF3D0000EF3D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
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
      000000000000FF03000000000000FF0300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      1F001F001F001F001F0000000000000000000000E07FE07F0000000000000000
      000000000000FF0300000000E003000000000000E07FE07F0000000000000000
      00000000000000000000E0030000000000000000E07FE07F0000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      1F001F001F001F001F0000000000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      00000000000000000000E0030000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      1F001F001F000000000000000000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      00000000000000000000E0030000000000000000E07FE07F0000000000000000
      000000000000000000000000E003000000000000000000000000000000000000
      1F001F001F000000000000000000000000000000E07FE07F0000000000000000
      0000EF3D00000000E003E003E003000000000000E07FE07F0000000000000000
      0000EF3D000000000000E0030000000000000000E07FE07F0000000000000000
      0000EF3D00000000E003E0030000000000000000000000000000000000000000
      1F001F001F000000000000000000000000000000E07FE07F00000000EF3D0000
      EF3D000000000000E00300000000FF0300000000E07FE07F00000000EF3D0000
      EF3D0000000000000000E0030000000000000000E07FE07F00000000EF3D0000
      EF3D000000000000E003E003E003000000000000000000000000000000000000
      1F001F001F000000000000000000000000000000FF7FE03D000000000000EF3D
      0000EF3D00000000000000000000000000000000FF7FE03D000000000000EF3D
      0000EF3D000000000000E0030000000000000000FF7FE03D000000000000EF3D
      0000EF3D00000000000000000000000000000000000000000000000000001F00
      1F001F001F000000000000000000000000000000E07FE07F0000000000000000
      0000000000000000E00300000000FF0300000000E07FE07F0000000000000000
      0000000000000000E003E003E003000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      1F001F001F0000000000000000000000000000000000E07F0000000000000000
      0000000000000000E003E003E0030000000000000000E07F0000000000000000
      000000000000E003E003E003E003E003000000000000E07F0000000000000000
      0000000000000000E003E003E003000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07F0000000000000000
      EF3D00000000FF03000000000000FF03000000000000E07F0000000000000000
      EF3D0000000000000000000000000000000000000000E07F0000000000000000
      EF3D000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07FE07FE07FE07FEF3D
      0000EF3D000000000000000000000000000000000000E07FE07FE07FE07FEF3D
      0000EF3D000000000000000000000000000000000000E07FE07FE07FE07FEF3D
      0000EF3D00000000000000000000000000000000000000000000000000000000
      1F001F001F000000000000000000000000000000000000000000EF3D0000EF3D
      0000EF3D0000EF3DEF3D00000000000000000000000000000000EF3D0000EF3D
      0000EF3D0000EF3DEF3D00000000000000000000000000000000EF3D0000EF3D
      0000EF3D0000EF3DEF3D00000000000000000000000000000000000000000000
      1F001F001F00000000000000000000000000000000000000000000000000EF3D
      EF3D0000EF3D000000000000000000000000000000000000000000000000EF3D
      EF3D0000EF3D000000000000000000000000000000000000000000000000EF3D
      EF3D0000EF3D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000000001F001F00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      000000000000000000001F000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      00000000000000001F001F000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      0000000000001F001F001F001F001F0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      0000000000001F001F001F001F001F0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      00000000000000001F001F000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      000000000000000000001F000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001F001F001F001F00
      1F001F0000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000007C007CE03D0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001F0000001F001F000000000000000000000000000000
      000000000000000000000000000000000000007C007C007CE03DE03DE03DE03D
      000000000000000000000000000000000000000000000000000000000000E001
      E001E001E0010000000000000000000000000000000000000000000000000000
      000000000000000000001F001F001F001F000000000000000000000000000000
      000000000000000000000000000000000000007C007C007C007CE03DE03DE03D
      E03D0000000000000000000000000000000000000000E0010000E001E001E001
      E001E001E001E001E001000000000000000000000000000000000000E001E001
      E001E0010000000000001F001F001F0000000000000000000000000000000000
      000000000000000000000000000000000000E03D007C007C007C007CE03DE03D
      E03D0000000000000000000000001F0000000000E001E001E001E001E001E001
      E001E001E001E001E001E001E001000000000000E0010000E001E001E001E001
      E001E001E001E00100001F001F001F001F000000000000000000000000000000
      000000000000000000000000000000000000E03DE03D007C007C007C007CE03D
      E03D000000000000000000001F001F001F000000E001E001E001E001E0010000
      0000000000000000E001E001E001E0010000E001E001E001E001E001E001E001
      E001E001E001E001E001E0010000000000000000000000000000000000000000
      000000000000000000000000000000000000E03DE03DE03D007C007C007C007C
      E03D00000000000000001F001F001F001F000000E001E001E001E00100000000
      00000000000000000000E001E001E0010000E001E001E001E001E00100000000
      000000000000E001E001E001E001000000000000000000000000000000000000
      000000000000000000000000000000000000E03DE03DE03DE03D007C007C007C
      007C000000000000000000001F001F001F000000E001E001E001E001E0010000
      000000000000000000000000E001E0010000E001E001E001E001000000000000
      0000000000000000E001E001E001000000000000000000000000000000000000
      000000000000000000000000000000000000E03DE03DE03DE03DE03D007C007C
      007C007C000000000000000000001F0000000000E001E001E001E001E001E001
      000000000000000000000000000000000000E001E001E001E001E00100000000
      00000000000000000000E001E001000000000000000000000000000000000000
      000000000000000000000000000000000000E03DE03DE03DE03DE03D0000007C
      007C007C007C0000000000000000000000000000000000000000000000000000
      0000000000000000E001E001E001E0010000E001E001E001E001E001E0010000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E03DE03DE03DE03DE03DE03DE03D
      007C007C007C007C000000000000000000000000E001E001E001000000000000
      0000000000000000E001E001E001E00100000000000000000000000000000000
      000000000000E001E001E001E001000000000000000000000000000000000000
      000000000000000000000000000000000000E03DE03DE03DE03DE03DE03DE03D
      E03D007C007C007C007C000000000000000000000000E001E001E00100000000
      000000000000E001E001E001E001E0010000E001E001E0010000000000000000
      000000000000E001E001E001E001000000000000000000000000000000000000
      000000000000000000000000000000000000E03DE03DE03DE03DE03DE03DE03D
      E03D0000007C007C007C007C00000000000000000000E001E001E001E001E001
      E001E001E001E001E001E001E001E00100000000E001E001E001000000000000
      00000000E001E001E001E001E001000000000000000000000000000000000000
      000000000000000000000000000000000000E03DE03DE03DE03DE03DE03DE03D
      E03D00000000007C007C007C007C00000000000000000000E001E001E001E001
      E001E001E001E001E001E001E001E00100000000E001E001E001E001E001E001
      E001E001E001E001E001E001E001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000007C007C007C007C00000000000000000000E001E001E001
      E001E001E001E001E001000000000000000000000000E001E001E001E001E001
      E001E001E001E001E001E001E001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000007C007C007C007C00000000000000000000E001E001
      E001E001E001000000000000000000000000000000000000E001E001E001E001
      E001E001E001E001000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000007C007C007C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E001E001E001
      E001E00100000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000003C003C
      003C003C003C000000000000000000000000000000000000003C003C003C003C
      003C00000000000000000000000000000000007C007CE03DE03DE03D00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000003C
      003C003C00000000000000000000000000000000000000000000003C003C003C
      000000000000000000000000000000000000007C007C007CE03DE03DE03DE03D
      E03DE03D00000000000000000000000000000000000000000000000000000000
      0000FF7F00000000000000000000000000000000000000000000000000000000
      003C0000000000000000000000000000000000000000000000000000003C0000
      000000000000000000000000000000000000007C007C007C007CE03DE03DE03D
      E03DE03DE03D0000000000000000000000000000000000000000000000000000
      0000FF7F000000000000000000000000000000000000000000000000007C007C
      007C007C007C000000000000000000000000000000000000007C007C007C007C
      007C000000000000000000000000000000000000007C007C007C007CE03DE03D
      E03DE03DE03D0000000000000000000000000000000000000000000000000000
      0000FF7F00000000000000000000000000000000000000000000007C007C007C
      007C007C007C007C0000000000000000000000000000007C007C007C007C007C
      007C007C000000000000000000000000000000000000007C007C007C007CE03D
      E03DE03DE03D0000000000000000000000000000000000000000000000000000
      0000FF7F0000000000000000000000000000000000000000007C007C007C007C
      007C007C007C007C007C00000000000000000000007C007C007C007C007C007C
      007C007C007C00000000000000001F00000000000000E03D007C007C007C007C
      E03D0000E03D0000000000000000000000000000000000000000000000000000
      0000FF7F0000000000000000000000000000000000000000007C007C007C007C
      007C007C007C007C007C00000000000000000000007C007C007C007C007C007C
      007C007C007C0000000000001F001F00000000000000E03DE03D007C007C007C
      007C0000E03D0000000000000000000000000000000000000000000000000000
      0000FF7F00000000000000000000000000000000000000000000007C007C007C
      000000000000007C0000000000000000000000000000007C007C007C00000000
      0000007C0000000000001F001F001F001F0000000000E03DE03DE03D007C007C
      007C007CE03D0000000000000000000000000000000000000000000000000000
      0000FF7F0000000000000000000000000000000000000000007C0000007C0000
      0000007C00000000007C00000000000000000000007C0000007C00000000007C
      00000000007C000000001F001F001F001F0000000000E03DE03DE03DE03D007C
      007C007C007C0000000000000000000000000000000000000000000000000000
      0000FF7F0000000000000000000000000000000000000000007C000000000000
      007C007C007C007C007C00000000000000000000007C000000000000007C007C
      007C007C007C0000000000001F001F00000000000000E03DE03DE03DE03DE03D
      007C007C007C007C000000000000000000000000000000000000000000000000
      0000FF7F0000000000000000000000000000000000000000007C007C007C007C
      007C007C007C007C007C00000000000000000000007C007C007C007C007C007C
      007C007C007C00000000000000001F00000000000000E03DE03DE03DE03DE03D
      E03D007C007C007C007C00000000000000000000000000000000000000000000
      0000FF7F00000000000000000000000000000000000000000000007C007C007C
      007C007C007C007C0000000000000000000000000000007C007C007C007C007C
      007C007C000000000000000000000000000000000000E03DE03DE03DE03DE03D
      E03DE03D007C007C007C007C0000000000000000000000000000000000000000
      0000FF7F000000000000000000000000000000000000000000000000007C007C
      007C007C007C000000000000000000000000000000000000007C007C007C007C
      007C0000000000000000000000000000000000000000E03DE03DE03DE03DE03D
      E03DE03DE03D007C007C007C007C000000000000000000000000000000000000
      0000FF7F00000000000000000000000000000000000000000000000000000000
      003C0000000000000000000000000000000000000000000000000000003C0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000007C007C007C007C00000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000003C
      003C003C00000000000000000000000000000000000000000000003C003C003C
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000007C007C007C007C0000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000003C003C
      003C003C003C000000000000000000000000000000000000003C003C003C003C
      003C000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000007C007C007C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000001F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001F001F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001F00
      1F001F0000000000000000000000000000000000000000000000000000000000
      00000000000000001F001F001F001F001F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001F00
      1F001F000000000000000000000000000000000000000000000000001F001F00
      1F000000000000001F001F001F001F001F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001F000000000000000000000000000000000000001F00
      1F001F000000000000000000000000000000000000000000000000001F001F00
      1F0000000000000000001F001F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000001F001F000000000000000000000000000000000000001F00
      1F001F000000000000000000000000000000000000000000000000001F001F00
      1F00000000000000000000001F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001F001F001F001F001F000000000000001F001F001F001F001F00
      1F001F001F001F001F001F00000000000000000000000000000000001F001F00
      1F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001F001F001F001F001F000000000000001F001F001F001F001F00
      1F001F001F001F001F001F0000000000000000001F001F001F001F001F001F00
      1F001F001F001F001F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000001F001F00000000000000000000001F001F001F001F001F00
      1F001F001F001F001F001F0000000000000000001F001F001F001F001F001F00
      1F001F001F001F001F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001F000000000000000000000000000000000000001F00
      1F001F00000000000000000000000000000000001F001F001F001F001F001F00
      1F001F001F001F001F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001F00
      1F001F000000000000000000000000000000000000000000000000001F001F00
      1F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001F00
      1F001F000000000000000000000000000000000000000000000000001F001F00
      1F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001F00
      1F001F000000000000000000000000000000000000000000000000001F001F00
      1F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000001F001F00
      1F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F00
      0F000F000F000F000F000F000F000F000F000000000000000000000000000000
      0000000000000000EF3DEF3DEF3D0000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F00
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0F000000000000000000000000000000
      000000000000EF3DEF3DEF3D00000000F75E00000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF7F00000000000000000000000000000F00
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0F000000000000000000EF3DEF3DEF3D
      F75EEF3DEF3DEF3D00000000F75EEF3DF75E00000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF7F00000000000000000000000000000F00
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0F00000000000000EF3DEF3D00000000
      00000000000000000000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF7F00000000000000000F000F000F000F00
      0F000F000F000F000F000F000F000F000F0000000000EF3DEF3D000000000000
      00000000000000000000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF7F00000000000000000F00FF7FFF7F0F00
      0F000F000F000F000F000F000F00FF7F0F000000EF3DEF3D00000000EF3DF75E
      0000EF3DEF3DF75EEF3D000000000000F75E00000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF7F00000000000000000F00FF7FFF7F0F00
      0F000F000F000F000F000F000F000F000F000000F75EEF3D0000000000000000
      0000000000000000000000000000EF3D000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E00000000000000000000000000000000000000000000FF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000F00FF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0F000000000000000000EF3DEF3D0000F75E00000000
      00000000000000000000F75E00000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000F00
      0F000F000F000F000F000F000F000F00000000000F000F000F000F000F000F00
      0F000F000F000F000F000F000000000000000000EF3D00000000000000000000
      000000000000EF3D0000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000F00FF7F0F000F000F000F00
      0F000F000F000F00FF7F0F000000000000000000EF3D0000F75E000000000000
      0000EF3D000000000000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E00000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F000000000000000000000F00FF7F0F000F000F000F00
      0F000F000F000F000F000F000000000000000000F75E00000000000000000000
      EF3DEF3D000000000000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000F000F000F000F00
      0F000F000F000F000F00000000000000000000000F00FF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F0F00000000000000000000000000F75E0000000000000000EF3D
      EF3D0000EF3D000000000000EF3D0000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F00000000000000000000000000000F000F000F000F000F000F00
      0F000F000F000F000000000000000000000000000000000000000000EF3DEF3D
      0000F75E000000000000EF3D00000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E0000000000000000000000000F000F000F000F000F000F00
      0F000F000F0000000000000000000000000000000F000F000F000F000F000F00
      0F000F00FF7F0F000000000000000000000000000000000000000000EF3D0000
      000000000000EF3D0000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000F000F000F000F000F000F00
      0F000F000F000F000000000000000000000000000000000000000000EF3DEF3D
      00000000000000000000000000000000000000000000000000000000F75EEF3D
      F75EF75EEF3DF75E000000000000000000000000000000000000000000000000
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
      00000000000000000000EF3DE07F000000000000000000000000EF3DEF3DEF3D
      0000EF3D003CEF3D00000000EF3D000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EF3DEF3D0000
      00000000000000000000E07FFF7F000000000000000000000000007C003CEF3D
      0000003C003CEF3D000000000000EF3D00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E07F000000000000EF3DFF7FE07F000000000000000000000000EF3D003C003C
      003C003C003CEF3D0000000000000000EF3D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF7FE07FE07FEF3DE07F0000FF7F
      FF7FE07F00000000E07FFF7F0000000000000000EF3DEF3DEF3D003C003C007C
      007C007C003C003CEF3DEF3DEF3D000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E07FFF7FFF7FE07FFF7FFF7F0000
      E07FE03D0000FF7FFF7FE07F0000000000000000003C003C003C003C007C0000
      00000000007C003C003C003C003C000000000000000000000000000000001F00
      000000000000000000000000000000000000000000000000000000000000003C
      003C003C003C000000000000000000000000FF7FE07FE07FFF7FE07FE07FFF7F
      E03D0000FF7FE07FE07F00000000000000000000EF3D007C003C003C00000000
      000000000000007C003C007CEF3DEF3D0000000000000000000000001F00FF03
      1F001F001F00000000000000000000000000000000000000000000000000003C
      003C003C003C000000000000000000000000FF7FE07F0000FF7F000000000000
      E07FE07FFF7FE07F00000000000000000000000000000000007C003C00000000
      000000000000007C003C000000000000000000000000EF3D00001F00FF03FF03
      FF03FF031F00000000000000000000000000000000000000000000000000003C
      003C003C003C000000000000000000000000E07FFF7F000000000000FF7FE07F
      FF7FFF7FE07FFF7F0000000000000000000000000000EF3D003C003C00000000
      000000000000003C003C003CEF3D00000000000000000000000000001F00FF03
      1F001F001F0000000F000F00000000000000000000000000000000000000003C
      003C003C003C000000000000000000000000FF7FE07F00000000FF7FE07FFF7F
      E07FE07FFF7F0000000000000000000000000000EF3D003C003C003C003C0000
      00000000003C003C003C003C003C0000000000000000EF3DEF3D000000001F00
      00000000000000000F000F000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF7FE07FE07FFF7FE07FE07FFF7F
      E07F000000000000000000000000000000000000EF3D007CEF3D007C003C003C
      003C003C003CEF3DEF3DEF3DEF3D000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E07FFF7FFF7FE07FFF7FE07FEF3D
      0000EF3DE07F0000000000000000000000000000000000000000EF3D003C003C
      007C003C003CEF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF7FE07FE07FFF7FE07F0000EF3D
      EF3DE07FFF7F0000000000000000000000000000000000000000007C003C007C
      0000007C003C003C000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF7FE07FE07FFF7FE07FE07FE07F
      E07FE07F00000000000000000000000000000000000000000000EF3D007C0000
      00000000007CEF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E07FFF7FFF7FE07FFF7FE07FE07F
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000003C003C003C003C003C003C003C
      003C003C003C003C003C003C003C003C003C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000003C003C1F001F001F001F001F00
      1F001F00003C003C003C003C003C003C003C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000003C1F001F001F001F001F001F00
      1F001F001F00003C003C003C003C003C003C000000001F001F00000000000000
      00001F001F00000000000000000000000000000000000000000000001F001F00
      1F001F001F001F00000000000000000000000000000000001F001F001F001F00
      1F001F0000000000000000000000000000001F001F001F001F001F001F001F00
      1F001F001F001F00003C003C003C003C003C000000001F001F00000000000000
      00001F001F000000000000001F0000000000000000000000000000001F001F00
      0000000000000000000000000000000000000000000000001F001F0000000000
      0000000000000000000000000000000000000000000000000000E07FE07FE07F
      007C007C007C007C003C003C003C003C003C0000000000001F001F001F001F00
      1F001F000000000000001F001F0000000000000000000000000000001F001F00
      0000000000000000000000000000000000000000000000001F001F0000000000
      000000000000000000001F000000000000000000000000000000E07F007CE07F
      007C007C007C007C007C003C003C003C003C0000000000001F001F0000000000
      1F001F00000000001F001F001F001F001F00000000000000000000001F001F00
      0000000000000000000000000000000000000000000000001F001F0000000000
      00000000000000001F001F00000000000000000000000000007CE07FE07FE07F
      007C007C007C007C007C007C003C003C003C0000000000001F001F0000000000
      1F001F00000000001F001F001F001F001F00000000000000000000001F001F00
      0000000000000000000000000000000000000000000000001F001F0000000000
      0000000000001F001F001F001F001F00000000000000E07FE07F0000007CE07F
      E07F007C007C007C007C007C007C003C003C00000000000000001F001F001F00
      1F0000000000000000001F001F0000000000000000000000000000001F001F00
      0000000000000000000000000000000000000000000000001F001F0000000000
      0000000000001F001F001F001F001F00000000000000000000000000E07FE07F
      E07FE07F007C007C007C007C007C003C003C00000000000000001F001F001F00
      1F00000000000000000000001F0000000000000000000000000000001F001F00
      0000000000000000000000000000000000000000000000001F001F0000000000
      00000000000000001F001F000000000000000000000000000000E07F007CE07F
      E07FE07FE07F007C007C007CE07FE07F003C000000000000000000001F001F00
      000000000000000000000000000000000000000000000000000000001F001F00
      0000000000000000000000000000000000000000000000001F001F0000000000
      000000000000000000001F000000000000000000000000000000E07FE07F0000
      0000E07FE07F007CE07FE07FE07FE07FE07F000000000000000000001F001F00
      000000000000000000000000000000000000000000000000000000001F001F00
      0000000000000000000000000000000000000000000000001F001F0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E07F007CE07FE07FE07F007CE07FE07F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E07FE07F000000000000E07FE07F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E07F0000000000000000E07F007C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000E07F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000001F00000000000000000000000000000000000000
      0000000000000000000000001F000000000000000000E07F0000000000000000
      00000000000000000000000000000000000000000000000000001F001F000000
      0000000000001F001F0000000000000000000000000000000000000000000000
      0000000000000000000000001F00000000000000000000000000000000000000
      0000000000000000000000001F000000000000000000E07F00000000EF3D0000
      00000000000000000000000000000000000000000000000000001F001F000000
      0000000000001F001F0000000000000000000000000000000000000000000000
      0000000000000000000000001F00000000000000000000000000000000000000
      0000000000000000000000001F000000000000000000E07F00000000EF3D0000
      EF3D00000000000000000000000000000000000000000000000000001F001F00
      1F001F001F001F00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E03D000000000000EF3D
      0000EF3D0000000000000000000000000000000000000000000000001F001F00
      000000001F001F00000000000000000000000000000000000000000000000000
      1F7C000000000000000000000000000000000000000000000000000000000000
      1F7C0000000000000000000000000000000000000000E07F00000000EF3D0000
      EF3D00000000000000000000000000000000000000000000000000001F001F00
      000000001F001F0000000000000000000000000000000000000000000000007C
      000000000000000000000000000000000000000000000000000000000000007C
      00000000000000000000000000000000000000000000E07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000001F00
      1F001F001F00000000000000000000000000000000001F7C0000000000000000
      1F7C000000000000000000000000000000000000000000000000000000000000
      1F7C0000000000000000000000000000000000000000E07F0000000000000000
      EF3D0000EF3D0000000000000000000000000000000000000000000000001F00
      1F001F001F000000000000000000000000001F7C007C0000000000000000007C
      000000000000000000000000000000000000000000000000000000000000007C
      00000000000000000000000000000000000000000000E07FE07FE07FE07FEF3D
      0000EF3D0000EF3DEF3D00000000000000000000000000000000000000000000
      1F001F000000000000000000000000000000000000000000000000001F7C0000
      000000000000000000000000000000000000000000000000000000001F7C0000
      0000000000000000000000000000000000000000000000000000EF3D0000EF3D
      0000EF3D0000EF3DEF3D00000000000000000000000000000000000000000000
      1F001F0000000000000000000000000000001F7C00000000000000001F7C0000
      000000000000007C00000000000000000000000000000000000000001F7C0000
      000000000000000000000000000000000000000000000000000000000000EF3D
      EF3D0000EF3D0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000001F7C00000000000000000000
      0000F75E00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007C0000007C
      0000000000000000F75E00000000000000000000000000000000007C00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001F7C0000000000000000
      00001F7C00001F7C00000000000000000000000000001F7C0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FFF7FE07FE07FFF7FE07F
      FF7FE07FFF7FE07FFF7FFF7FE07FFF7F000000000000000000000000EF3DEF3D
      00000000EF3D0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000003C003C007C003C
      007C007C003C007C000000000000000000000000FF7FE07FFF7FFF7FE07FFF7F
      E07FFF7FE07F0000E07FE07F0000E07F0000000000000000000000000000FF03
      0000FF03FF0300000000EF3DFF03000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007C003C007C007C003C
      007C007C003C007C007C003C003C000000000000E07FFF7F00000000FF7FE07F
      FF7FE07FFF7FE07F00000000E07FFF7F000000000000EF3D0000FF0300000000
      00000000000000000000FF03FF7F000000000000000000000000000000000000
      00000000000000000000000000000000000000000000003C003C003C003C007C
      003C003C007C003C003C007C003C000000000000FF7F0000000000000000FF7F
      E07FFF7FE07FFF7FE07FE07FFF7FE07F00000000000000000000000000000000
      FF03000000000000EF3DFF7FFF03000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000003C007C003C
      007C007C003C007C007C003C007C000000000000E07FFF7FE07FE07F00000000
      FF7FE07FFF7FE07F00000000E07FFF7F0000FF7FFF03FF03EF3DFF030000FF7F
      FF7FFF0300000000FF03FF7F0000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E03D0000FF7F003C003C
      007C007C003C007C007C003C007C003C00000000FF7FE07FFF7FFF7FE07F0000
      0000FF7FE07F0000E07FE07F0000E07F0000FF03FF7FFF7FFF03FF7FFF7F0000
      FF03E03D0000FF7FFF7FFF03000000000000000000000000000000000000E003
      FF7F000000000000E003FF7FE0030000000000000000E03D0000FF7F003C007C
      003C003C007C003C003C007C003C003C00000000E07FFF7FE07FE07FFF7FE07F
      FF7FE07FFF7FE07FFF7FFF7FE07FFF7F0000FF7FFF03FF03FF7FFF03FF03FF7F
      E03D0000FF7FFF03FF03000000000000000000000000000000000000E003FF7F
      E003E00300000000FF7FE003FF7F00000000000000000000E07F0000007C003C
      007C007C003C007C007C003C007C003C00000000FF7FE07F00000000E07FFF7F
      E07FFF7FE07FFF7FE07FE07FFF7FE07F0000FF7FFF030000FF7F000000000000
      FF03FF03FF7FFF030000000000000000000000000000000000000000E003FF7F
      E003E00300000000FF7FE003FF7F0000000000000000003C003C007C007C003C
      007C007C003C007C007C003C007C003C00000000E07F0000000000000000E07F
      FF7FE07FFF7FE07FFF7FFF7FE07FFF7F0000FF03FF7F000000000000FF7FFF03
      FF7FFF7FFF03FF7F00000000000000000000000000000000000000000000E003
      FF7F000000000000E003FF7FE003000000000000003C007CFF7F0000003C007C
      003C003C007C003C003C007C003C000000000000FF7FE07FFF7FFF7F00000000
      E07FFF7FE07FFF7FE07FE07FFF7FE07F0000FF7FFF03000000000000FF03FF7F
      FF03FF03FF7F0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000003CFF7FFF7F007C00000000
      0000000000000000007C003C007C000000000000E07FFF7FE07FE07FFF7F0000
      0000E07FFF7FE07FFF7FFF7FE07FFF7F0000FF7FFF03FF03FF7FFF03FF03FF7F
      FF03000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007CFF7F0000003C003C
      00001F7C1F7C0000007C003C003C000000000000FF7FE07FFF7FFF7FE07FFF7F
      E07FFF7FE07FFF7FE07FE07FFF7FE07F0000FF03FF7FFF7FFF03FF7FFF7FEF3D
      0000EF3DFF030000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000003C003C003C003CE03D
      0000003C007C003C003C003C003C00000000000000000000000000000000E07F
      FF7FE07FFF7FE07FFF7FFF7FE07FFF7F0000FF7FFF03FF03FF7FFF030000EF3D
      FF03FF03FF7F0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E001E001E03D
      0000003C003C003C003C00000000000000000000FF7FE07FFF7FFF7FE07F0000
      000000000000000000000000000000000000FF7FFF03FF03FF7FFF03FF030000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E003EF3DEF3D00000000
      E03D000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF03FF7FFF7FFF03FF7F00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E003E001EF3DE00100000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000EF3D003CEF3D00000000000000000000000000000000000000000F00
      0F000F000F000F000F000F000F000F0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000003C000000000000000000000000000000000000000000000F00
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F0F000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000003C0000EF3D0000000000000000000000000000000000000F00
      FF7F00000000000000000000FF7F0F000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000E03DE03DE03D
      E03DE03DE03DE03D000000000000000000000000000000000000000000000000
      000000000000003C003C003C0000000000000000000000000000000000000F00
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F0F000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000000000000000000000000000FF7FE07FE03DE03D
      E03DE03DE03DE03DE03D00000000000000000000000000000000000000000000
      000000000000003C0000EF3D0000000000000000FF7FFF7FFF7FFF7FFF7F0F00
      FF7F00000000000000000000FF7F0F000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000000000000000000000000000E07FFF7F0000E03D
      E03DE03DE03DE03DE03DE03D000000000000000000000000000000000F3C0000
      EF3D00000000003C00000000EF3D000000000000FF7F00000000000000000F00
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F0F000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000000000000000000000000000FF7FE07FE07F0000
      00000000000000000000000000000000000000000000000000000000EF3D0F3C
      000000000000003C003C003C003C000000000000FF7FFF7FFF7FFF7FFF7F0F00
      FF7F00000000FF7F0F000F000F000F000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000000000000000000000000000FF7FE07FE07FFF7F
      E07FE07FFF7F0000000000000000000000000000000000000000000000000F3C
      0000000000000000000000000000000000000000FF7F00000000000000000F00
      FF7FFF7FFF7FFF7F0F00FF7F0F0000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000000000000000000000000000E07FFF7F00000000
      0000000000000000000000000000000000000000000000000000000000000F3C
      0000000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7F0F00
      FF7FFF7FFF7FFF7F0F000F00000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000F3C0F3C
      0F3C000000000000000000000000000000000000FF7F00000000FF7F00000F00
      0F000F000F000F000F000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7F00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F3C
      0000000000000000000000000000000000000000FF7FFF7FFF7FFF7F0000FF7F
      000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7F0000FF7F000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F3C
      EF3D000000000000000000000000000000000000FF7FFF7FFF7FFF7F00000000
      000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7F00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0F3C0F3C00000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7F00000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7F0000000000000000000000000000F75EF75EF75EF75EF75E
      F75EF75EF75EF75E0000F75E0000000000000000000000000000000000000000
      0000000000000000000000000000000000001F001F000000FF7FFF7FFF7FFF7F
      FF7FFF7F00000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000F75E000000000000000000000000000000000000
      0000000000000000000000000000000000001F00FF7F0000FF7FFF7FFF7FFF7F
      FF7FFF7F00000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7F
      0000EF3D00000000EF3D00000000000000000000F75EF75EF75EF75EF75EF75E
      E07FE07FE07FF75EF75E00000000000000000000000000000000000000000000
      0000000000000000000000000000000000001F00FF7F00000000000000000000
      0000000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7F0000
      EF3D00000000FF03EF3DEF3D0000000000000000F75EF75EF75EF75EF75EF75E
      EF3DEF3DEF3DF75EF75E0000F75E000000000000000000000000000000000000
      0000000000000000000000000000000000001F00FF7F00000000000000000000
      0000000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7F0000
      0000000000000000EF3D00000000000000000000000000000000000000000000
      000000000000000000000000F75EF75E00000000000000000000000000000000
      0000000000000000000000001F00000000001F001F001F001F001F001F001F00
      1F0000000000000000000000FF7FFF7F00000000FF7FFF7FFF7FFF7FFF7F0000
      0000FF0300000000EF3D00000000000000000000F75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75E0000F75E0000F75E00000000000000000000000000000000
      00000000000000001F001F001F001F001F001F001F001F001F001F001F001F00
      1F00000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7F0000
      EF3DFF03FF030000EF3DEF3D0000000000000000000000000000000000000000
      0000000000000000F75E0000F75E000000000000000000000000000000000000
      000000001F001F001F001F001F001F001F000000000000000000000000000000
      0000000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7F
      0000EF3D00000000EF3D0000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7F0000F75E0000F75E00000000000000000000000000000000
      00000000000000001F001F001F001F001F000000000000000000000000000000
      000000000000000000001F001F001F001F000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F000000000000000000000000000000000000000000000000FF7F00000000
      000000000000FF7F000000000000000000000000000000000000000000000000
      0000000000000000000000001F00000000000000000000000000000000000000
      FF7FFF7F0000000000001F001F001F001F000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7F000000000000000000000000000000000000FF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001F001F001F001F000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0000000000000000000000000000000000000000000000000000FF7F0000
      0000000000000000FF7F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F0000000000000000000000000000000000000000000000000000FF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000D00000000100010000000000800600000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFC1000000000000
      9FC10000000000009FCF00000000000083CF000000000000804F000000000000
      904F000000000000904F000000000000904100000000000081C1000000000000
      8E41000000000000807F0000000000009001000000000000E407000000000000
      F81F000000000000FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFC1FFE3FFC9
      F80F9FC19FE39FC9F80F9FF99FE39FC9FE3F83F983E383C1FE3F804180638041
      FE3F904190639041FE3F904F90639041FC3F904190419041FE3F81C1818081C1
      FFFF8E418E418E41FFFF807F807F807FFE3F900190019001FE3FE407E407E407
      FFFFF81FF81FF81FFFFFFFFFFFFFFFFFFFFFFFFFFFFFC007FFFFFFFFFFFF8003
      FFFFFFFFFFFFBFF3F9FFF9FFFE7FBFF3F9FFF9F7FE7FB033F9FFF9E7FE7FBFF3
      F9FFF9C1FE7FB033F81FF9C1FE7FBFF3F9CFF9E7FC3FB033F9CFF9F7F99FBFF3
      F9CFF9FFF3CFB133F81FE07FF3CFBFF3FFFFFFFFFFFFBFF3FFFFFFFFFFFFAAAB
      FFFFFFFFFFFFD557FFFFFFFFFFFFEAAF001FFFFFFFF4FFFF001FF83FFFF0FFFF
      001F900FF071FFFF001D80032010F81F001883E10007F9FF001087F107C3F9FF
      001883F90FE3F9FF001D81FF07F3F83F001FFFE103FFF9FF001F8FE1FFC3F9FF
      000FC7C11FC3F9FF0007C0018F83F81F0003E0018003FFFF0001F00DC003FFFF
      FFF0F83FE01BFFFFFFF8FFFFF07FFFFFFFFFF83FE0FF0007FFFFFC7FF1FF0007
      FE7FFEFFFBFF0007FE7FF83FE0FF8007FE7FF01FC07FC007FE7FE00F803DC007
      FE7FE00F8039C007FE7FF1DFC770C007FE7FEB6FADB0C007FE7FEE0FB839C007
      FE7FE00F803DC007FE7FF01FC07FC007FE7FF83FE0FFC003FE7FFEFFFBFFC001
      FFFFFC7FF1FFFFF0FFFFF83FE0FFFFF8FFFFFFFFFFFFFFFFFFFFFFFBFFFFFFFF
      FFFFFFF3FFFFFFFFFC3FFFE0F39FCE7FFC3FF860F31FCC77FC3FF873F31FCC67
      E007F87BF21FC841C007C00FF09FC241C007800FF09FC267C007800FF19FC677
      FC3F800FF19FC67FFC3FF87FF39FCE7FFC3FF87FFFFFFFFFFC7FF87FFFFFFFFF
      FFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFFF81FFFFFFC00FFE1F81FF800FC00FFC2
      F81FFBFCFC00F000F81FFBFCFC00E01BF81FFBFCE000C7F6F81FFBFCE000890C
      F81F1BFCE00087F1F81F7800E0078433F81F780080078B93F81F780080078713
      F81F600780078E33F81F6007801F9C33F81F001F801FF847F81F001F801FF99F
      F81F001F801FF87FF81FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FFF1FFFF0FF0
      FFC3F113FFFF0FF0F003F115FFFF03C00003F01E800103C000078003BFFD03C0
      00078383BDFD0000000F87C1B83D0000201FE7CF903D0000001FC7C3B8250000
      001F83838DE503C0001F8003BFFD03C0001FF01F800103C0003FF11FFFFF0FF0
      007FF39FFFFF0FF001FFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF0000
      FFFFFFFFFFFF0000CF3FF81FE07F0000CF3BF9FFE7FFF000E073F9FFE7F7F000
      E660F9FFE7E7E000E660F9FFE7C1C800F0F3F9FFE7C1F800F0FBF9FFE7E7F000
      F9FFF9FFE7F7F300F9FFF9FFE7FFFE01FFFFFFFFFFFFFE73FFFFFFFFFFFFFEF3
      FFFFFFFFFFFFFFFBFFFFFFFFFFFFFFFFF7E7F7E7FFFFFFFFF7F9F7F99FFFFFFF
      F7E9F7E99FFFFFFFF7B1F7B183E3F3CFF7D1F7D18003F3CFF451F4519007F81F
      F85BF85B9007F99FF847F847900FF99FF8BFF8BF81C7FC3FD8FFF8FFC633FC3F
      39FFF9FF800DFE7FF3FFF3FFD001FE7F73DFF3FFE407FFFFA77FE7FFF91FFFFF
      E5EFE7FFFFFFFFFFCF5FCFFFFFFFFFFF8001FFFFFFFFF81F0000F933FFFFE007
      0000E003FFFFC0030000C003FFFFC00300000003FFFFF00300000007FCE3D000
      00000007F863D0000000000FF801E8000000201FB001C0000000001FA8638801
      0000001FDCE387E10000001FFFFFC8230000001FFFFFC1030000003FFFFFF10F
      000103FFFFFFC27F83FF07FFFFFF877FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F
      FC01C007FFFFFFDFFC01C007C01FFFD7FC01C007C01FFFC70001C007C007FFD7
      0001C007C003FADB0001C007C003F9C30001C007C01FFDFF0003C007C01FFDFF
      0007C007E7E3F8FF000FC007FF6BFDFF00FFC00FFF9FFCFF01FFC01FFFFFFE7F
      03FFC03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8007C03F000CC007BFF7C03F
      00088003A017003F00010001ACD7003F00630001AFD71FBF00C30001AFD70030
      01EB0000AFD300F0016B0000AFC000E000238000A380FFDF0067C000AFC0FC30
      000FE001A1D3FC00000FE007AFD7FC30000FF007A017FFDF005FF003BFF7FFE0
      003FF8038007FFF0007FFFFFFFFFFFF000000000000000000000000000000000
      000000000000}
  end
  object AdvToolBarOfficeStyler: TAdvToolBarOfficeStyler
    Style = bsWindowsXP
    BackGroundTransparent = False
    BorderColor = clSilver
    BorderColorHot = clSilver
    ButtonAppearance.Color = clBtnFace
    ButtonAppearance.ColorTo = clBtnFace
    ButtonAppearance.ColorChecked = clBtnFace
    ButtonAppearance.ColorDown = 11899524
    ButtonAppearance.ColorHot = 15717318
    ButtonAppearance.BorderDownColor = 13542013
    ButtonAppearance.BorderHotColor = 16504504
    ButtonAppearance.BorderCheckedColor = 16504504
    ButtonAppearance.CaptionFont.Charset = DEFAULT_CHARSET
    ButtonAppearance.CaptionFont.Color = clWindowText
    ButtonAppearance.CaptionFont.Height = -11
    ButtonAppearance.CaptionFont.Name = 'Segoe UI'
    ButtonAppearance.CaptionFont.Style = []
    CaptionAppearance.CaptionColor = clNavy
    CaptionAppearance.CaptionColorTo = clNavy
    CaptionAppearance.CaptionBorderColor = clNavy
    CaptionAppearance.CaptionColorHot = clNavy
    CaptionAppearance.CaptionColorHotTo = clNavy
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'Segoe UI'
    CaptionFont.Style = []
    ContainerAppearance.LineColor = clBtnShadow
    ContainerAppearance.Line3D = True
    Color.Color = clBtnFace
    Color.ColorTo = clBtnFace
    Color.Direction = gdVertical
    Color.Mirror.Color = clBtnFace
    Color.Mirror.ColorTo = clBtnFace
    Color.Mirror.ColorMirror = clBtnFace
    Color.Mirror.ColorMirrorTo = clBtnFace
    ColorHot.Color = 15717318
    ColorHot.ColorTo = 15717318
    ColorHot.Direction = gdVertical
    ColorHot.Mirror.Color = 15266548
    ColorHot.Mirror.ColorTo = 15266548
    ColorHot.Mirror.ColorMirror = 15266548
    ColorHot.Mirror.ColorMirrorTo = 15266548
    CompactGlowButtonAppearance.BorderColor = 12179676
    CompactGlowButtonAppearance.BorderColorHot = clHighlight
    CompactGlowButtonAppearance.BorderColorDown = clHighlight
    CompactGlowButtonAppearance.BorderColorChecked = clBlack
    CompactGlowButtonAppearance.ColorTo = 12179676
    CompactGlowButtonAppearance.ColorChecked = 12179676
    CompactGlowButtonAppearance.ColorCheckedTo = 12179676
    CompactGlowButtonAppearance.ColorDisabled = 15921906
    CompactGlowButtonAppearance.ColorDisabledTo = 15921906
    CompactGlowButtonAppearance.ColorDown = 11899524
    CompactGlowButtonAppearance.ColorDownTo = 11899524
    CompactGlowButtonAppearance.ColorHot = 15717318
    CompactGlowButtonAppearance.ColorHotTo = 15717318
    CompactGlowButtonAppearance.ColorMirror = 12179676
    CompactGlowButtonAppearance.ColorMirrorTo = 12179676
    CompactGlowButtonAppearance.ColorMirrorHot = 15717318
    CompactGlowButtonAppearance.ColorMirrorHotTo = 15717318
    CompactGlowButtonAppearance.ColorMirrorDown = 11899524
    CompactGlowButtonAppearance.ColorMirrorDownTo = 11899524
    CompactGlowButtonAppearance.ColorMirrorChecked = 12179676
    CompactGlowButtonAppearance.ColorMirrorCheckedTo = 12179676
    CompactGlowButtonAppearance.ColorMirrorDisabled = 11974326
    CompactGlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    CompactGlowButtonAppearance.GradientHot = ggVertical
    CompactGlowButtonAppearance.GradientMirrorHot = ggVertical
    CompactGlowButtonAppearance.GradientDown = ggVertical
    CompactGlowButtonAppearance.GradientMirrorDown = ggVertical
    CompactGlowButtonAppearance.GradientChecked = ggVertical
    DockColor.Color = clBtnFace
    DockColor.ColorTo = clBtnFace
    DockColor.Direction = gdHorizontal
    DockColor.Steps = 128
    DragGripStyle = dsSingleLine
    FloatingWindowBorderColor = clHighlight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    GlowButtonAppearance.BorderColor = 12179676
    GlowButtonAppearance.BorderColorHot = clHighlight
    GlowButtonAppearance.BorderColorDown = clHighlight
    GlowButtonAppearance.BorderColorChecked = clBlack
    GlowButtonAppearance.ColorTo = 12179676
    GlowButtonAppearance.ColorChecked = 12179676
    GlowButtonAppearance.ColorCheckedTo = 12179676
    GlowButtonAppearance.ColorDisabled = 15921906
    GlowButtonAppearance.ColorDisabledTo = 15921906
    GlowButtonAppearance.ColorDown = 11899524
    GlowButtonAppearance.ColorDownTo = 11899524
    GlowButtonAppearance.ColorHot = 15717318
    GlowButtonAppearance.ColorHotTo = 15717318
    GlowButtonAppearance.ColorMirror = 12179676
    GlowButtonAppearance.ColorMirrorTo = 12179676
    GlowButtonAppearance.ColorMirrorHot = 15717318
    GlowButtonAppearance.ColorMirrorHotTo = 15717318
    GlowButtonAppearance.ColorMirrorDown = 11899524
    GlowButtonAppearance.ColorMirrorDownTo = 11899524
    GlowButtonAppearance.ColorMirrorChecked = 12179676
    GlowButtonAppearance.ColorMirrorCheckedTo = 12179676
    GlowButtonAppearance.ColorMirrorDisabled = 11974326
    GlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    GlowButtonAppearance.GradientHot = ggVertical
    GlowButtonAppearance.GradientMirrorHot = ggVertical
    GlowButtonAppearance.GradientDown = ggVertical
    GlowButtonAppearance.GradientMirrorDown = ggVertical
    GlowButtonAppearance.GradientChecked = ggVertical
    GroupAppearance.BorderColor = clHighlight
    GroupAppearance.Color = 15717318
    GroupAppearance.ColorTo = 15717318
    GroupAppearance.ColorMirror = 15717318
    GroupAppearance.ColorMirrorTo = 15717318
    GroupAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.Font.Color = clWindowText
    GroupAppearance.Font.Height = -11
    GroupAppearance.Font.Name = 'Segoe UI'
    GroupAppearance.Font.Style = []
    GroupAppearance.Gradient = ggVertical
    GroupAppearance.GradientMirror = ggVertical
    GroupAppearance.TextColor = clBlack
    GroupAppearance.CaptionAppearance.CaptionColor = 15915714
    GroupAppearance.CaptionAppearance.CaptionColorTo = 15915714
    GroupAppearance.CaptionAppearance.CaptionTextColor = clBlack
    GroupAppearance.CaptionAppearance.CaptionColorHot = 15915714
    GroupAppearance.CaptionAppearance.CaptionColorHotTo = 15915714
    GroupAppearance.CaptionAppearance.CaptionTextColorHot = clBlack
    GroupAppearance.PageAppearance.BorderColor = clBlack
    GroupAppearance.PageAppearance.Color = 15717318
    GroupAppearance.PageAppearance.ColorTo = clBtnFace
    GroupAppearance.PageAppearance.ColorMirror = clBtnFace
    GroupAppearance.PageAppearance.ColorMirrorTo = clBtnFace
    GroupAppearance.PageAppearance.Gradient = ggVertical
    GroupAppearance.PageAppearance.GradientMirror = ggVertical
    GroupAppearance.PageAppearance.ShadowColor = clBlack
    GroupAppearance.PageAppearance.HighLightColor = 15526887
    GroupAppearance.TabAppearance.BorderColor = clHighlight
    GroupAppearance.TabAppearance.BorderColorHot = clHighlight
    GroupAppearance.TabAppearance.BorderColorSelected = clBlack
    GroupAppearance.TabAppearance.BorderColorSelectedHot = clHighlight
    GroupAppearance.TabAppearance.BorderColorDisabled = clNone
    GroupAppearance.TabAppearance.BorderColorDown = clNone
    GroupAppearance.TabAppearance.Color = clBtnFace
    GroupAppearance.TabAppearance.ColorTo = clWhite
    GroupAppearance.TabAppearance.ColorSelected = 15717318
    GroupAppearance.TabAppearance.ColorSelectedTo = 15717318
    GroupAppearance.TabAppearance.ColorDisabled = clNone
    GroupAppearance.TabAppearance.ColorDisabledTo = clNone
    GroupAppearance.TabAppearance.ColorHot = 15717318
    GroupAppearance.TabAppearance.ColorHotTo = 15717318
    GroupAppearance.TabAppearance.ColorMirror = clWhite
    GroupAppearance.TabAppearance.ColorMirrorTo = clWhite
    GroupAppearance.TabAppearance.ColorMirrorHot = 15717318
    GroupAppearance.TabAppearance.ColorMirrorHotTo = 15717318
    GroupAppearance.TabAppearance.ColorMirrorSelected = 15717318
    GroupAppearance.TabAppearance.ColorMirrorSelectedTo = 15717318
    GroupAppearance.TabAppearance.ColorMirrorDisabled = clNone
    GroupAppearance.TabAppearance.ColorMirrorDisabledTo = clNone
    GroupAppearance.TabAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.TabAppearance.Font.Color = clWindowText
    GroupAppearance.TabAppearance.Font.Height = -11
    GroupAppearance.TabAppearance.Font.Name = 'Tahoma'
    GroupAppearance.TabAppearance.Font.Style = []
    GroupAppearance.TabAppearance.Gradient = ggVertical
    GroupAppearance.TabAppearance.GradientMirror = ggVertical
    GroupAppearance.TabAppearance.GradientHot = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorHot = ggVertical
    GroupAppearance.TabAppearance.GradientSelected = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorSelected = ggVertical
    GroupAppearance.TabAppearance.GradientDisabled = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorDisabled = ggVertical
    GroupAppearance.TabAppearance.TextColor = clBlack
    GroupAppearance.TabAppearance.TextColorHot = clBlack
    GroupAppearance.TabAppearance.TextColorSelected = clBlack
    GroupAppearance.TabAppearance.TextColorDisabled = clWhite
    GroupAppearance.TabAppearance.ShadowColor = 10796223
    GroupAppearance.TabAppearance.HighLightColor = 16775871
    GroupAppearance.TabAppearance.HighLightColorHot = 16643309
    GroupAppearance.TabAppearance.HighLightColorSelected = 6540536
    GroupAppearance.TabAppearance.HighLightColorSelectedHot = 12451839
    GroupAppearance.TabAppearance.HighLightColorDown = 16776144
    GroupAppearance.ToolBarAppearance.BorderColor = clBlack
    GroupAppearance.ToolBarAppearance.BorderColorHot = clHighlight
    GroupAppearance.ToolBarAppearance.Color.Color = clBtnFace
    GroupAppearance.ToolBarAppearance.Color.ColorTo = clBtnFace
    GroupAppearance.ToolBarAppearance.Color.Direction = gdHorizontal
    GroupAppearance.ToolBarAppearance.ColorHot.Color = 15717318
    GroupAppearance.ToolBarAppearance.ColorHot.ColorTo = 15717318
    GroupAppearance.ToolBarAppearance.ColorHot.Direction = gdHorizontal
    PageAppearance.BorderColor = clBlack
    PageAppearance.Color = clBtnFace
    PageAppearance.ColorTo = clBtnFace
    PageAppearance.ColorMirror = clBtnFace
    PageAppearance.ColorMirrorTo = clBtnFace
    PageAppearance.Gradient = ggVertical
    PageAppearance.GradientMirror = ggVertical
    PageAppearance.ShadowColor = 10070188
    PageAppearance.HighLightColor = clBlack
    PagerCaption.BorderColor = clBlack
    PagerCaption.Color = clBtnFace
    PagerCaption.ColorTo = clBtnFace
    PagerCaption.ColorMirror = clBtnFace
    PagerCaption.ColorMirrorTo = clBtnFace
    PagerCaption.Gradient = ggVertical
    PagerCaption.GradientMirror = ggVertical
    PagerCaption.TextColor = clGray
    PagerCaption.TextColorExtended = clBlue
    PagerCaption.Font.Charset = DEFAULT_CHARSET
    PagerCaption.Font.Color = clWindowText
    PagerCaption.Font.Height = -13
    PagerCaption.Font.Name = 'Segoe UI'
    PagerCaption.Font.Style = []
    QATAppearance.BorderColor = clGray
    QATAppearance.Color = clBtnFace
    QATAppearance.ColorTo = clBtnFace
    QATAppearance.FullSizeBorderColor = clGray
    QATAppearance.FullSizeColor = clBtnFace
    QATAppearance.FullSizeColorTo = clBtnFace
    RightHandleColor = clBtnFace
    RightHandleColorTo = clNone
    RightHandleColorHot = 15717318
    RightHandleColorHotTo = clNone
    RightHandleColorDown = 11899524
    RightHandleColorDownTo = clNone
    TabAppearance.BorderColor = clNone
    TabAppearance.BorderColorHot = clHighlight
    TabAppearance.BorderColorSelected = clBlack
    TabAppearance.BorderColorSelectedHot = clHighlight
    TabAppearance.BorderColorDisabled = clNone
    TabAppearance.BorderColorDown = clNone
    TabAppearance.Color = clBtnFace
    TabAppearance.ColorTo = clWhite
    TabAppearance.ColorSelected = clWhite
    TabAppearance.ColorSelectedTo = clBtnFace
    TabAppearance.ColorDisabled = clWhite
    TabAppearance.ColorDisabledTo = clSilver
    TabAppearance.ColorHot = 15717318
    TabAppearance.ColorHotTo = 15717318
    TabAppearance.ColorMirror = clWhite
    TabAppearance.ColorMirrorTo = clWhite
    TabAppearance.ColorMirrorHot = 15717318
    TabAppearance.ColorMirrorHotTo = 15717318
    TabAppearance.ColorMirrorSelected = clBtnFace
    TabAppearance.ColorMirrorSelectedTo = clBtnFace
    TabAppearance.ColorMirrorDisabled = clWhite
    TabAppearance.ColorMirrorDisabledTo = clSilver
    TabAppearance.Font.Charset = DEFAULT_CHARSET
    TabAppearance.Font.Color = clWindowText
    TabAppearance.Font.Height = -11
    TabAppearance.Font.Name = 'Segoe UI'
    TabAppearance.Font.Style = []
    TabAppearance.Gradient = ggVertical
    TabAppearance.GradientMirror = ggVertical
    TabAppearance.GradientHot = ggVertical
    TabAppearance.GradientMirrorHot = ggVertical
    TabAppearance.GradientSelected = ggVertical
    TabAppearance.GradientMirrorSelected = ggVertical
    TabAppearance.GradientDisabled = ggVertical
    TabAppearance.GradientMirrorDisabled = ggVertical
    TabAppearance.TextColor = clBlack
    TabAppearance.TextColorHot = clBlack
    TabAppearance.TextColorSelected = clBlack
    TabAppearance.TextColorDisabled = clGray
    TabAppearance.ShadowColor = 10796223
    TabAppearance.HighLightColor = 16775871
    TabAppearance.HighLightColorHot = 16643309
    TabAppearance.HighLightColorSelected = 6540536
    TabAppearance.HighLightColorSelectedHot = 12451839
    TabAppearance.HighLightColorDown = 16776144
    TabAppearance.BackGround.Color = clBtnFace
    TabAppearance.BackGround.ColorTo = clBtnFace
    TabAppearance.BackGround.Direction = gdVertical
    Left = 408
    Top = 144
  end
  object ToolBarCustomizer: TAdvToolBarCustomizer
    Commands = <>
    EnablePersistence = True
    FileName = '.\untitled.ini'
    ButtonProperties.Caption = False
    ButtonProperties.Glyph = True
    ButtonProperties.Hint = True
    ButtonProperties.Visible = True
    ButtonProperties.ShowCaption = False
    DialogSettings.ToolBarLabel = 'ToolBar Items:'
    DialogSettings.CommandLabel = 'Commands'
    DialogSettings.CaptionLabel = 'Caption'
    DialogSettings.GlyphPosLabel = 'Glyph Position'
    DialogSettings.LargeIconCheck = 'Large Icon'
    DialogSettings.TopHint = 'Move to Top'
    DialogSettings.UpHint = 'Move Up'
    DialogSettings.DownHint = 'Move Down'
    DialogSettings.BottomHint = 'Move to Bottom'
    DialogSettings.AddHint = 'Add Item'
    DialogSettings.AddSeparatorHint = 'Add Separator'
    DialogSettings.DeleteHint = 'Delete Item'
    DialogSettings.DeleteAllHint = 'Delete All'
    DialogSettings.EditHint = 'Edit Item'
    DialogSettings.Caption = 'Customizer'
    DialogSettings.ButtonEditCaption = 'Customize Button'
    DialogSettings.ButtonEditCaptionLabel = 'Caption'
    DialogSettings.ButtonEditHintLabel = 'Hint'
    DialogSettings.ButtonEditIconLabel = 'Icon'
    DialogSettings.ButtonEditCaptionCheck = 'Show Caption'
    DialogSettings.ButtonEditVisibleCheck = 'Visible'
    DialogSettings.OKButtonCaption = '&Ok'
    DialogSettings.CancelButtonCaption = '&Cancel'
    DialogSettings.ResetButtonCaption = '&Reset'
    DialogSettings.AddGlowButtonHint = 'Insert GlowButton'
    DialogSettings.GlyphPositionLeftCaption = 'Left'
    DialogSettings.GlyphPositionTopCaption = 'Top'
    DialogSettings.GlyphPositionRightCaption = 'Right'
    DialogSettings.GlyphPositionBottomCaption = 'Bottom'
    DialogSettings.GlyphEditNoneIconCaption = 'None'
    DialogSettings.EditGlyphVisible = True
    DialogSettings.EditCaption = True
    DialogSettings.EditGlyphPosition = True
    DialogSettings.LargeIcon = False
    DialogSettings.Customize = 'Customize'
    Options.ReOrder = True
    Options.AddButton = True
    Options.AddSeparator = True
    Options.Delete = True
    Options.DeleteAll = False
    Left = 440
    Top = 144
  end
  object AdvMainMenu: TAdvMainMenu
    Images = ActionImages
    Version = '2.5.3.0'
    Left = 376
    Top = 144
    object mnuFile: TMenuItem
      Caption = '&File'
      object NewDay1: TMenuItem
        Action = FileNewDay
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object WorkAhead1: TMenuItem
        Caption = '&Work Ahead'
        HelpContext = 4
        Hint = 'Work with changes for a future date'
        object New2: TMenuItem
          Action = WorkAheadNew
        end
        object Open1: TMenuItem
          Action = WorkAheadOpen
        end
        object Use1: TMenuItem
          Action = WorkAheadUse
        end
      end
      object mniFileClose: TMenuItem
        Caption = '&Close'
        HelpContext = 8
        Hint = 'Close the active window'
        ShortCut = 16499
        OnClick = Close1Click
      end
      object mniFileCloseAllb: TMenuItem
        Caption = 'Close All'
        OnClick = CloseAllWindows
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object OpenTimetable2: TMenuItem
        Caption = '&Open Timetable ...'
        HelpContext = 9
        Hint = 'Open an existing timetable'
        ShortCut = 32884
        OnClick = OpenTimetable1Click
      end
      object NewData2: TMenuItem
        Action = NewData
      end
      object ExportasTextFile1: TMenuItem
        Caption = '&Export as Text File ...'
        HelpContext = 132
        Hint = 'Export top window as text file'
        OnClick = ExportFileClick
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object Print2: TMenuItem
        Action = MainPrint
      end
      object PrintSetup2: TMenuItem
        Action = FilePrintSetup1
      end
      object PrintPreview2: TMenuItem
        Action = DoPrintPreview
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object CreateBackup2: TMenuItem
        Caption = 'Create Backup ...'
        HelpContext = 118
        Hint = 'Backup data'
        ShortCut = 16450
        OnClick = CreateBackup1Click
      end
      object RestorefromBackup2: TMenuItem
        Caption = 'Restore from Backup ...'
        HelpContext = 119
        Hint = 'Restore data from backup'
        OnClick = RestorefromBackup1Click
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        HelpContext = 13
        Hint = 'Exit Time Chart Extra'
        ShortCut = 32883
        OnClick = FileExit
      end
    end
    object mnuEdit: TMenuItem
      Caption = '&Edit'
      object Copy2: TMenuItem
        Action = CopyWin
      end
    end
    object mnuDisplay: TMenuItem
      Caption = '&Display'
      object Font2: TMenuItem
        Action = SetFont
      end
      object Preferences2: TMenuItem
        Action = Preferences
      end
      object Margins2: TMenuItem
        Caption = '&Margins ...'
        HelpContext = 21
        Hint = 'Set Margins and Date stamp'
        ShortCut = 16461
        OnClick = Margins1Click
      end
      object Custom2: TMenuItem
        Caption = '&Custom'
        HelpContext = 22
        Hint = 'The Custom sub-menu'
        object Clear2: TMenuItem
          Caption = '&Clear'
          HelpContext = 23
          Hint = 'Clear Custom Information'
          ShortCut = 24643
          OnClick = Clear1Click
        end
        object New3: TMenuItem
          Caption = '&New...'
          HelpContext = 24
          Hint = 'New Custom Information'
          ShortCut = 24654
          OnClick = New1Click
        end
        object Open2: TMenuItem
          Caption = '&Open...'
          HelpContext = 25
          Hint = 'Open Custom File'
          ShortCut = 24655
          OnClick = opencustomfile1Click
        end
        object Edit2: TMenuItem
          Caption = '&Edit...'
          HelpContext = 26
          Hint = 'Edit Custom Information'
          ShortCut = 24645
          OnClick = Editcustomfile1Click
        end
        object Save2: TMenuItem
          Caption = '&Save...'
          HelpContext = 27
          Hint = 'Save Custom File'
          ShortCut = 24659
          OnClick = Savecustomfile1Click
        end
      end
      object N15N: TMenuItem
        Caption = '-'
      end
      object Selection2: TMenuItem
        Action = ShowSelection
      end
      object NextView2: TMenuItem
        Action = NextView
      end
    end
    object mnuUser: TMenuItem
      Caption = '&User'
      object Info3: TMenuItem
        Caption = '&Info ...'
        HelpContext = 181
        OnClick = Info2Click
      end
      object Changepassword2: TMenuItem
        Caption = '&Change password ...'
        HelpContext = 180
        OnClick = Changepassword1Click
      end
      object Logonasdifferentuser2: TMenuItem
        Caption = '&Log on as different user...'
        HelpContext = 179
        OnClick = Logonasdifferentuser1Click
      end
      object N27: TMenuItem
        Caption = '-'
      end
      object Showusers2: TMenuItem
        Caption = '&Show users'
        HelpContext = 185
        OnClick = Showusers1Click
      end
      object Adduser2: TMenuItem
        Caption = '&Add user ...'
        HelpContext = 177
        OnClick = Adduser1Click
      end
      object Edituser2: TMenuItem
        Caption = '&Edit user ...'
        HelpContext = 183
        OnClick = Edituser1Click
      end
      object Deleteuser2: TMenuItem
        Caption = '&Delete user ...'
        HelpContext = 184
        OnClick = Deleteuser1Click
      end
      object N28: TMenuItem
        Caption = '-'
      end
      object Autoloadtime2: TMenuItem
        Caption = 'Autoload &time ...'
        HelpContext = 189
        OnClick = Autoloadtime1Click
      end
      object Savedefaultdisplaysettings2: TMenuItem
        Caption = 'Save default display settings'
        HelpContext = 187
        OnClick = SaveDefaultDisplaySettings
      end
      object Setcurrentdatadirectoryasdefault2: TMenuItem
        Caption = 'Set current data directory as default'
        HelpContext = 188
        OnClick = SetCurrentDataDirectoryAsDefault
      end
    end
    object mnuFind: TMenuItem
      Caption = 'F&ind'
      object Student3: TMenuItem
        Caption = '&Student...'
        HelpContext = 30
        Hint = 'Find a student'
        ShortCut = 32880
        OnClick = Student2Click
      end
      object eacher1: TMenuItem
        Caption = '&Teacher...'
        HelpContext = 31
        Hint = 'Find a teacher'
        ShortCut = 32881
        OnClick = Teacher3Click
      end
      object Room2: TMenuItem
        Caption = '&Room...'
        HelpContext = 32
        Hint = 'Find a room'
        ShortCut = 32882
        OnClick = Room3Click
      end
    end
    object mnuStudent: TMenuItem
      Caption = '&Student'
      object Select2: TMenuItem
        Caption = 'Select ...'
        HelpContext = 165
        Hint = 'Select a group of students'
        OnClick = Select1Click
      end
      object Sort2: TMenuItem
        Caption = 'Sort ...'
        HelpContext = 165
        Hint = 'Sort students'
        OnClick = Sort1Click
      end
      object N29: TMenuItem
        Caption = '-'
        HelpContext = 165
      end
      object grp0S: TMenuItem
        Tag = 1
        Caption = 'grp0'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp1S: TMenuItem
        Tag = 2
        Caption = 'grp1'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp2S: TMenuItem
        Tag = 3
        Caption = 'grp2'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp3S: TMenuItem
        Tag = 4
        Caption = 'grp3'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp4S: TMenuItem
        Tag = 5
        Caption = 'grp4'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp5S: TMenuItem
        Tag = 6
        Caption = 'grp5'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp6S: TMenuItem
        Tag = 7
        Caption = 'grp6'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp7S: TMenuItem
        Tag = 8
        Caption = 'grp7'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp8S: TMenuItem
        Tag = 9
        Caption = 'grp8'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp9S: TMenuItem
        Tag = 10
        Caption = 'grp9'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp10S: TMenuItem
        Tag = 11
        Caption = 'grp10'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp11S: TMenuItem
        Tag = 12
        Caption = 'grp11'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp12S: TMenuItem
        Tag = 13
        Caption = 'grp12'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp13S: TMenuItem
        Tag = 14
        Caption = 'grp13'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp14S: TMenuItem
        Tag = 15
        Caption = 'grp14'
        HelpContext = 165
        OnClick = grp01Click
      end
      object grp15S: TMenuItem
        Tag = 16
        Caption = 'grp15'
        HelpContext = 165
        OnClick = grp01Click
      end
    end
    object mnuTimetable: TMenuItem
      Caption = '&Timetable'
      object Levels2: TMenuItem
        Caption = '&Levels ...'
        HelpContext = 35
        Hint = 'Set the number of levels for each year'
        OnClick = Levels1Click
      end
      object imetable1: TMenuItem
        Action = ShowTimetable
      end
    end
    object mnuChanges: TMenuItem
      Caption = 'Ch&anges'
    end
    object mnuCover: TMenuItem
      Caption = '&Cover'
    end
    object mnuWindow: TMenuItem
      Caption = '&Window'
    end
    object mnuHelp: TMenuItem
      Caption = '&Help'
    end
  end
  object HelpRouter1: THelpRouter
    HelpType = htHTMLhelp
    ShowType = stMain
    CHMPopupTopics = 'CSHelp.txt'
    ValidateID = False
    Left = 466
    Top = 143
  end
  object HotImages: TImageList
    BlendColor = clMenu
    BkColor = 15790320
    Height = 32
    Width = 32
    Left = 376
    Top = 232
    Bitmap = {
      494C010118002400440020002000F0F0F000FF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000080000000E0000000010010000000000000E0
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDE7B1863E71CE71CE71CE71CE71CE71CE71CE71CE71CE71CE71CE71CE71C
      E71CE71CE71CE71CE71CE71CE71CDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7B195B
      543E543E543E543E543E543E543E543E543E543E543E543E543E543E543E543E
      543ED752FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D856534653465346534653465346534653465346534653465346534653465346
      5346D856DE7BDE7BDE7B367365456441DE7BDE7BDE7BDE7BDE7B6B296B296B29
      6B296B296B296B296B296B296B296B296B296B296B296B296B296B296B296B29
      6B296B296B296B296B296B29DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDE7BF75EE71C7B6F5A673967396739631963195F185FF85EF85AF85AF856
      D756D752D752B74ED8525342E71CDE7BFF7FDE7BDE7BDE7BDE7BDE7B195BF856
      3A5B3B5F195BF956195BF856F956D852D852D74ED84ED852B74ED852D74ED84E
      D74E333EB64EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      3B63DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B754ADE7BDE7B36736545A124295A8449DE7BDE7BDE7BFF7FDE7B6B29DE7B
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B5A6B6B29DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDE7BF75EE71CDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7BFF7BFF77
      DF77DF73BF6FBF6F9E67D752E71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E3A63
      103EAD31AE353A63F85A8D2D8D2D113E7C6B323E6C298D2DB64E5B67AE2D6C29
      F035D74E543EFF7FDE7BDE7BDE7BDE7BDE7BDE7B30466931692D692D692D8314
      3B63DE7B9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F
      DE7B754E8314A9416545A124295A52776D62DE7BDE7B39673142EF3DEF3D6B29
      DE7BFF7FDE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDE7BFF7FFF7FFF7FFF7F
      DE7BFF7F7B6F6B29EF3D103EEF3D3967DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDE7BF75EE71CFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7BFF7B
      DF77DF77BF6F3A5F3A5FD752E71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543EF85E
      524A52462204F856744E734A0921E8183A63324694524308113AD6568510640C
      A510D74E543EFF7FDE7BDE7BDE7BDE7BDE7B514EEE3DD65A396739673967C618
      3C63DE7B9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F
      DE7B954E47316545A124295A5277295A4E52DE7B3967314239677B6FBD77EF3D
      6B29FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7F9C736B29EF3D7B6F1863D656724A3967DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDE7BF75EE71CDE7B524A29254A294A294A294A294A294A294A294A294A29
      4A294A294A292925195FF856E71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E1963
      103EEF3D081D395FB552734E8D318C295B673246744E081D7446D756E81CE81C
      C718B74E543EFF7FDE7BDE7BDE7BDE7BDE7BEE41186339673967396739678410
      96523967F95AF95AF95AF95AF95AF95AF95AF95AF95AF95AF95AF95AF95AF95A
      39672F4E6545A124295A5277295AB25EEE41DE7B1042B556396739679C73103E
      C6146B296B294B296B296B296B296B296B296B296B294B296B296B296B296B29
      6B2D29258510EF3D39673967F75ED656724ADE7BDE7BFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FD65AE71CDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7FFF7BDF77
      DF77DF73BE73BE6FBE6FD756E71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E9D6F
      9C6F9C6F9D6FBE73BE735A677C6B7C6BBE735B673A635B679D6FD756524A185F
      6C2DB64E543EFF7FDE7BDE7BDE7BDE7BDE7B724E5A6B5A6B5A6B5A6B5A6B630C
      AE31CE39AE31AE31AE31AE31AE316C294B252A21291D291D2A214B256C29AE31
      CE396545A124295A5277295AD3625A6B724EDE7BEF3DD65A39675A6B7B6F7B6F
      103EEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3D
      EF3DEF3DF03D1863186318631863D656724ADE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B1863E71CDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F
      FF7FFF7BFF77DF77BF73D856E71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E5B67
      F039AE31AE313A63F75A8D2D8C2D113A7C6B113E6C296C29B64EF75A94525A6B
      AD31B64E543EFF7FDE7BDE7BDE7BDE7BDE7BB4567B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6FD65A6C296C293242B652F75AF75AB65232426C296C29
      103E272D295A5277295A83427B6F7B6FB456DE7BEF3DD65A39675A6B7B6F7B6F
      9C739D739C739C739C739C739C737B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      5B6B5A6B5A6B3967396339673963D656724ADE7BDE7BE71CE71CE71CE71CE71C
      E71CE71C8C31E71CDE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7BFF7B5B67195FE71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E185F
      324652462200185F744E94524A29C7145B67324695524308113E195FAD31CE35
      4B29B64E543EFF7FDE7BDE7BDE7BDE7BDE7BB55A9C739C739C739C739C739C73
      9C739C739C739C7394524B21323EF75619635B6B7C6F9C735B6B1963F756323E
      4B21AE35F5624B5EC34600339C739C73B55ADE7B1042F75E39675A6B7B6F7B6F
      5A6B5A6B5A6B5A6B5A6B3A675A675A6739673967396739673967396739671963
      1963396339633967396739673967D656724AFF7FDE7BE71C31469452734E734E
      744E9552CE39E71CDE7B734E4A296B2D6B2D6B2D6B2D6B2D6B2D6B2D6B2D6B2D
      6B2D6B2D6B2D4A295B67195FE71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E3A63
      103EEF3909215B67B656734A8D31AE319C6B3246734E2921744A5A67CF39AE35
      EF35D852543EFF7FDE7BDE7BDE7BDE7BDE7BD65E9C739C739C739C739C739C73
      9C739C739C73F75E6C255342185F9C73BD77DE7BDE7BDE7BDE7BBD779C73185F
      53426C25B5529C739C739C739C739C73D65EDE7B3142F75E39675A6B7B6F7B6F
      7B6F7B6F7B6F7A6F5A6F5A6B5A6B5A6B5A6B5A6B5A6B5A6B5A6B396B396B396B
      3967396739673967396739673967D656724ADE7BDE7BE71C7B6FDE7BDE7BDE7B
      DE7BDE7BF85EE71CDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BFF7FFF7BFF7B185FE71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543EBD73
      BD73BD73BE77DE77DE777B6B9D6F9D6FDE779C6B5B679C6B9C6FBE737C677C6B
      7C6B5B63543EFF7FDE7BDE7BDE7BDE7BDE7BF75EBD77BD77BD77D74E8F1D6E19
      6E196E196E194B21113A954A533AB64AD852195F7C6B7C6B195BD852B64A533A
      954A113A4B218F1DD74EBD77BD77BD77F75EDE7B314618635A675A6B7B6F7B73
      7B735B6B7B6B5B6B7B6B5B6B5A6B5A6B5A6B5A6B5A6B5A6B5A6B3A673A673A67
      3A673967396F396B396739675A6BD656724ADE7BDE7BE71C5A6BFF7FFF7FFF7F
      FF7FFF7F734AE71CDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BFF7F195FE71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E7B6B
      EF398D2DAE315B67F75A8D2D6C29113E9C6F113E6C296C29B64E39638D2D4B25
      AE2DD852543EFF7FDE7BDE7BDE7BDE7BDE7B1763DE7BDE7BDE7BB121362E772E
      772E772ED125F0317446B8461A533B571B533B577D677D673B571B533B571A53
      B8467446F031D025B121DE7BDE7BDE7B1763DE7B324618635A6B5A6B7B735B57
      FC22FD16DC16FD16DC16FD16FD16DC16FD16FD16FC16FD16FD16FC16FC16FC16
      FC16FC16FC223A57396F39675A6BD656724ADE7BDE7BE71C7B6F9C73C6180821
      08212921C618E71CDE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7F9C733A67E71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E1963
      F03D534A21001963944ED65A2921E8187C6BEF3DB55643083242F75A944EAD35
      640CD752543EFF7FDE7BDE7BDE7BDE7BDE7B3867FF7FFF7FFF7FD121B93A5726
      57265726AF25F135553EB83EDA46D93E993698329832983298329936D93EDA46
      B9427542F135AF29D121FF7FFF7FFF7F3867DE7B524A39675A6B7A6F5B5FFD0A
      FD02DD02FD02FD02FD02DD02FD02DD02FD02FD02FD02FD02DD02FD02FD02FD02
      FD02DD021D03FD0E3A5F5A6B5A6BD656724ADE7BDE7BE71C5A6BFF7FFF7FFF7F
      FF7FFF7F524AE71CDE7B734E6B2DAD358C318C318C318C318C318C318C318C31
      8C318C31AD356B2D9C735A67E71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E5A67
      104231422A257C6BD65632466C2DCF35BD73314252462A25B65239633146CF39
      6C29195B543EFF7FDE7BDE7BDE7BDE7BDE7B596BFF7FFF7FFF7FF325FB46792A
      792A792AD031D0315536983AB93A9932992E992E792E792E992E992E9932B93A
      B93E753AD031F031F325FF7FFF7FFF7F596BDE7B734A39675A677A73FC36DD02
      9C029C029C029C029C029C02BC02BC02BD02BD02BD02BC02BC02BC02BD02BC02
      BD02BD02BD02FD021B43596F5A6BD656724ADE7BDE7BE71C3967DE7BDE7BDE7B
      DE7BDE7B1863E71CDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7B3967E71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543EBE77
      DE77BE77DF7BFF7BFF7B9D6FDE77BE77FF7BBD737C6BBD73BD73DE775B677C6B
      9D6F7C67543EFF7FDE7BDE7BDE7BDE7BDE7B5A6BDE7BDE7BDE7B352A3C4F3C4F
      3C4F3C4F123ACF31753ED94A1B4F3C4F3C4F3C4F3C4F3C4F3C4F3C4F3C4F1B4F
      FA4A7642CF31123A352ADE7BDE7BDE7B5A6BDE7B734E396739675A6BBA2A7A02
      7B067B067C069C069C069C029C029C029C029C029C029C029C029D029D029D02
      9D029D029C02BC02FA42396F5A6BD656724ADE7BDE7BE71C5A6BFF7FFF7FFF7F
      FF7FFF7F734EE71CDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7B3967E71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E7B6B
      F0396C2DAD317B6BF75A8D2D6C29113E9D7331426C294B25B6523A63AE314B25
      AE2DF85A543EFF7FDE7BDE7BDE7BDE7BDE7B5A6FDE7BDE7BDE7B562E5D575D57
      5D575D577442CF31333AD84A1B535D575D575D575D575D575D575D575D571B53
      D94A543ACF317442562EDE7BDE7BDE7B5A6FDE7B734E39673963396BB932780E
      791636163516361636123612361236123612361236123612361236123612360E
      360E360E790E7A02F942386B3A67D656724ADE7BDE7BE71C7B6F9C73E71C2925
      29252925E71CE71CDE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7F9C735A6BE71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E3963
      1142314221003963944E734AE81CE8189C6F1142955222045242F75A734E1142
      6308F85A543EFF7FDE7BDE7BDE7BDE7BDE7B7A6FDE7BDE7BDE7B98327E5B7E5B
      7E5B7E5B9546D031F0319742FA4A3C535D577E577E577E577E575D573C53FA4E
      9742F131D03195469832DE7BDE7BDE7B7A6FDE7B944E39631863386797325712
      131E082108210821082108210821082108210821082108210821082108210821
      0921E7208E1D790ED84618673967D656724ADE7BDE7BE71C5A6BFF7FFF7FFF7F
      FF7FFF7FB556E71CDE7B9452AD35CE39CE39CE39CE39CE39CE39CE39CE39CE39
      CE39CE39EF3DAD35BD777B6FE71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E5B6B
      F03D11424B299C6FD75A52468C2DF03DDE77314252464B25D7563A67103EF03D
      8C2D3A5F543EFF7FDE7BDE7BDE7BDE7BDE7B7A6FFF7FFF7FFF7F99325E53FD36
      FD36FD36B746F1356D211426562A99321C471C3FFD3E1D3F1D433C4BBA3A572A
      14266D21F135B74E9932FF7FFF7FFF7F7A6FDE7B3967734EF75EF65E7632361A
      AF1D724A7B6F5A6B5A6B5A6B5A6B5A6B5A6B5A6B5A6B5A6B5A6B5A6B5A6B5A6B
      7B6B724AAF255712B6421767D656734E3967DE7BDE7BE71C3967DE7BDE7BDE7B
      DE7BDE7B1863E71CDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9C739C739C735A6BB556E71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543EDE7B
      DE7BBE77FF7FFF7FFF7F9D73DF7BDF7BFF7FBE779C6FDE77BE77DF777C639C63
      DE6B9C6B543EFF7FDE7BDE7BDE7BDE7BDE7B5A6BBD77DE7BDE7B992E1D43FD36
      14261426543674464B212C156D19753ED74E3436D84ED84ED84ED84EB74AAF21
      2C154B217446DA46992EDE7BDE7BBD775A6BDE7BDE7B3967734EB5565432341E
      F31D724ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B724A3426351675429456734E3967DE7BDE7BDE7BE71C5A6BDE7BFF7FFF7F
      FF7FFF7F1042E71CDE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      39678D2D8D2D8D2D8D2D8D2DE71CDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E7B6B
      F03DAE356C297B6BF75ACF354B25F03DBD7332428D312A21B6525B73D0656D69
      0A55195B543EFF7FDE7BDE7BDE7BDE7BDE7B9B735A6BBC77BD77992EDC36DC32
      F95ADE7B7D6BF856F0352A2153465A677B6BF85A9C6F9C6F7C6F7B6F5A67744A
      4B25F035D752DC36992EBD77BC775A6B9B73DE7BDE7BDE7B3967724A1132F11D
      AF19724AFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F724A122E131EF031534A3967DE7BDE7BDE7BDE7BE71C7B6F7B6FA514E71C
      E71CE71CA514E71CDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B
      39678D2D7E63BF6FFF7BE71CDE7BDE7BFF7FDE7BDE7BDE7BFF7FDE7B543E5A67
      F03D534A64089C6FB552B552091D6B29BE7752465246640CB64E5B7F747EF27D
      466C5B63543EFF7FDE7BDE7BDE7BDE7BDE7BFF7F7B6F39673867792A792A792A
      F95ADE7B9E6B3B63F856AE2D2A21113EB652954E7B6B7B6B3A67D656113E2A21
      AE2DF8567732792A792A386739677B6FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B724ADE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7F
      DE7B724ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE71C5A6BDE7BFF7FFF7F
      FF7FFF7FD65AE71CDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B
      39678D2DBE6FDF7BE71CDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B543EBD73
      5A6B39635A6BDE7B9C73186339637B6FDE7B3963185F19637C6F9C73F86ED76E
      196B7C679646FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      F95ADE7B9E6B9E6B3A5FF85ACF35081D6C29AE31D039D039AE316C29081DCF35
      F85A754ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7BDE7BDE7BDE7B
      DE7B724ADE7BFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7F
      DE7B724ADE7BDE7BDE7BDE7BFF7FDE7BDE7BDE7BDE7BE71C3967DE7BDE7BDE7B
      DE7BFF7F1863E71CFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDE7B
      39678D2DFF7FE71CDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BFF7FDE7BCF31CE35
      AE398D398B354A2D4A2D4A314A31292D08292929292928290725E620071D071D
      2821C614C614FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      1A5FDE7B9E6F9E6F9E6F5B63F85AB652CF354A25081D081D4A25CF35B652F85A
      9C73754ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B724ADE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7F
      DE7B724ADE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BE71C5A6BDE7BFF7FFF7F
      FF7FFF7FEF3DE71CDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      5B6B8D2DE71CDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B29296B2D
      D125FC32992E992E992E992A7926582658223822181E181E181E181E181EF819
      181E4A29A614FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      1A5FDE7B9E6F9E6F9E6F9E6F9E6B3A5FF85A195B395F395F195BF85A3A5F9E6B
      DE7B754ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B724ADE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7F
      DE7B724ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE71C7B6F7B6FC6180821
      08210821C618E71C9452734E734E734E734E734E734E734E944E734EB556B556
      524AE71CDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B29294A29
      753AFF4B9F3B9F3B7F377F375F335F331F2F1E2FDE26DE26DE26BD22BD22BD22
      5B1A2A29C618FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      1A5FDE7B9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F9E6F
      DE7B954EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B724ADE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7BFF7FFF7F
      DE7B724ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE71C3967DE7BDE7BDE7B
      DE7BDE7B9C73E71CE71CE71CE71CE71CE71CE71CE71CE71CE71CE71CE71CE71C
      E71CDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B29294B29
      954AFF537E335E335E335E2F3E2B3E2B1D27FD22FD229C1A7C167B123B0E9C1E
      5A222929C614FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      1A5FDE7B9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F
      DE7B954EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B724ADE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7F
      DE7B724ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE71C5A6BDE7BFF7FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF03D53465346534AB552E71CE71C
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B29294B29
      9552FF577E337E377E335E335E2F3E2F1D2BFD26DD1EBC1A7B125B0E5B0E7C1E
      5A222929C618FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      1A5FDE7B9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F9F6F
      DE7B954EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B724ADE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B724A724A
      724A724ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE71C5A6BDE7BFF7FDE7B
      FF7FDE7BFF7FFF7FFF7FFF7FFF7FFF7FBC778D2D1B573A5FBE6F5A6BE71CDE7B
      FF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B29296B29
      B556FF57BF379F379F379F337F335F2F3E2B1E271E27DD22BD1EBD1E9C1ABD26
      7B224A29C618FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      1A5FDE7BBF73BF73BF73BF73BF73BF73BF73BF73BF73BF73BF73BF73BF73BF73
      DE7B954EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B724AFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDE7B724AF75E
      1863724ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE71C5A6BDE7BFF7FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7BBD77CF397D67DF779C6FE71CDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B29296B29
      B656FF77FF67FF67FF63FF5FFF5BDF57BF4F9F477F3F5F3B1F2F1F2BFF2ADF22
      7D1E4B2DA614DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      1A63DE7BBF73BF73BF73BF73BF73BF73BF73BF73BF73BF73BF73BF73BF73BF73
      DE7B964EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B724ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B724A1863
      724ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE71C3967FF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FBD77EF39FF7B9C6FE71CDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B103E2929
      09216C316B314B2D4B2D4B2D4B2D4B294B252A252A212A1D0A1D0A190A190A15
      0A15E718AD31DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      3A63DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BD856DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B724ABD77BD77BD77BD77BD77BD77BD77BD77BD77BD77BD77BD77724A724A
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE71C5A6BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDD7B3146BD77E71CDE7BDE7BFF7FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9C73F03D
      29292929292929292929292929292929292929292929292929290825E620C61C
      C61C8C319C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      3B633B633B633B633B633B633B633B633B633B633B633B633B633B633B633B63
      3B63F85ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B724A724A724A724A724A724A724A724A724A724A724A724A724A724ADE7B
      DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE71CB5565A6B39675A6B
      5A6B5A6B5A6B5A6B5A6B5A6B5A6B5A6B1863EF3DE71CDE7BDE7BFF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      3967185F185F185FF85EF75EF75AD75AD656D656B656B552B5529552944E744E
      744EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7BE71CE71CE71CE71CE71C
      E71CE71CE71CE71CE71CE71CE71CE71CE71C0821DE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BD65ACF14CD20D65ADE7BDE7B734EE71CE71CE71CE71C
      E71CDE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC129E57DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B863D65416541
      6541654165416541643D643D643D643D643D653D654165416541654169358D2D
      8F258E258B2D6739863DDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BD65AD20C992497446B29DE7BDE7B071DE71CE71CE71CE71C
      E71CDE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B160A160A160A160A160A160A160A
      160A160A160A160A160A160A160A160A160A160A160A160A160A160A160A160A
      160A160A160A160A160A160A160A160A160ADE7BDE7BDE7BDE7B8549A54DA54D
      A54DA54D844DA64DC74DC74DC74DC74DC74DC74DC74DC64DCC3DD419F8051902
      1902F801D701B5058F25BE77DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BD65AD20C992497442C260516DE7BDE7B0821082108210821071D
      E71CDE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B160A160A160A160A160A160A160A
      160A160A160A160A160A160A160A160A160A160A160A160A160A160A160A160A
      160A160A160A160A160A160A160A160A160ADE7BDE7BDE7BDE7BA549A651A54D
      A64D83494D5A7B6B7B6B7B6B7B6B7B6B7B6B7B6B7B6B9942F8097A129B16BC16
      BC16BC169C167B12F709D6159D6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BD65AD20C992497442C26A40ED65ADE7BDE7B08210821082108210821
      0821DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B160A160A160AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F160A160A160ADE7BDE7BDE7BDE7B8549C651A54D
      844DB1627B6BDE7B7B6BDE7BDE7BDE7BFF7FDE7B1C53F8093A027E4FDE7BFF7F
      DE7BFF7FFF7FFF7BBC1EF701D515BE73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BD65AD20C992498442C26A40ED65ADE7BDE7BDE7B08210821082108210821
      0821DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B160A160A160AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F160A160A160ADE7BDE7BDE7BDE7BA549C551A64D
      F5667B6BDE7BDE7B7B6BF041DE7BDE7BDE7BBE73F8113A025C029D0AFF7BFF7F
      FF7FFF7FDE7BFF7F5C027C06D6017836DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AD20C992498442C26A412D65ADE7BDE7BDE7BDE7B08210821082108210821
      0821DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B170A170A170AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FB863FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F170A170A170ADE7BDE7BDE7BDE7BA649A44D2B56
      7B6BDE7BDE7BDE7B7B6BDE7BDE7BFF7FDE7BDB4A19067B027C027D027E4FFF7F
      9D06FF7FFF7FDD1A7C027C023A02B509BE73DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD65A
      D20C992498442C26A412D65ADE7BDE7BDE7BDE7BDE7B08210821082108210821
      0821DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B370A370A370AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0D33FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F370A370A370ADE7BDE7BDE7BDE7BA649A54D2B56
      7B6B7B6B7B6B7B6B7B6BF041DE7BDE7BDE7B592A3A027C029D029D02BD0EFF7F
      BD12BD12FF7F9D029D027C027C02F705FB52DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD65AD20C
      992098442C26A412D65ADE7BDE7BDE7BDE7BDE7BDE7B29252925292528250821
      0821DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B370A370A370AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FDB6FC922DD77FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F370A370A370ADE7BDE7BDE7BDE7BA64DA5512B56
      7B6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F39263A027C029D029D029D02BD0E
      FF7FFF7F9D069D029D029D027C021802BA42DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD65AD20C9920
      98442C26A412D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7B29252925292529252925
      2925DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B370A370A370AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7F7557C9267557FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F370A370A370ADE7BDE7BDE7BDE7BA64DC5512B5A
      7B6BDE7BF041F041F041F041DE7BDE7BDF7B592E5A027C029D029D029D029D06
      FF7FFF7F7D029D029D029D027C021902BA3EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B7B6F9C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BD65AD20C99209844
      2C26A412D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B29252925292529252925
      2925DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B370A370A370AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7F0D37C926EB32FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F370A370A370ADE7BDE7BDE7BDE7BA64DC5512B5A
      7B6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F9A3A5A067C029D029D029D06FF7F
      FF7FFF7FFF7F9D029D029D027C021906DB4ADE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B524A443E043A1863DE7BDE7BDE7BDE7BDE7BD65AD20C992098442C2A
      A412D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B29252925292529252925
      2925DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B370A370A370AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FDD77C926C926C926B863FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F370A370A370ADE7BDE7BDE7BDE7BC64DC5514B5A
      7B6BDE7BDE7BDE7BDE7BDE7BDE7BF041F04156427A1E5B029C029D02FE22FF7F
      7D027D02FF7FBD0E7D027C025B02F8095D67DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE735E067E0670C42DE7BDE7BDE7BDE7BD65AD20C992098442C2AA412
      D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B29252925292529252925
      2925DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B380A380A380AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F514BE926E926E9262E3FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F380A380A380ADE7BDE7BDE7BDE7BC64DC5514C5A
      7B6BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B7D6BBB425B067C029D06FF7F5D02
      7D027D027D02FF7F7C027C023A023822FF7FDE7BDE7BDE7BDE7B734E734E3967
      DE7BDE7BA531E067E0676B4ADE7BDE7BDE7B734ED20C992098442C2AA412D65A
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B4A294A294A2529252925
      2925DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B580A580A580AFF7FFF7FFF7FFF7F
      FF7FFF7FDD77E82AE82AE82AE82AE82ABA6BFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F580A580A580ADE7BDE7BDE7BDE7BC74DE6554C5A
      7B6BDE7BF041F041F041F041DE7BDE7BDE7BDE7BFB52BB363A021D37FF7F3E3B
      3E3B3E3B3E3BFF7FBC163A02F8095D63DE7BDE7BDE7BDE7B6935C171007A834D
      D65ADE7BE735E067E067EF3DDE7B7B6F4735C16DE1792E592C2AA412D65ADE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B4A294A294A294A294A29
      4A29DE7BBC12BC12BC12BC12BC12BC12BC12DC225D439E5F9E5F5E4B1D2FBC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B580A580A580AFF7FFF7FFF7FFF7F
      FF7FFF7F514BE82AE82AE82AE82AE82A2E3FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F580A580A580ADE7BDE7BDE7BDE7BC751E6554C5E
      7B6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDF7BFB52BB32FC36FF7FFF7F
      FF7FFF7FFF7FFF7F9B16F805DB4ADE7BFF7FDE7BDE7BDE7B634D407E807E607E
      A35518630E42E067615B734EDE7B4735E079E07DE07D2166A412D65ADE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B4A294A294A294A294A29
      4A29DE7BBC12BC12BC12BC12BC12BC125D43DF735D431D2F1D2F1D2F5E4BBC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B580E580E580EFF7FFF7FFF7FFF7F
      FF7FBA6BE82AE82AE82AE82AE82AE82AE82ABA6BFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F580E580E580EDE7BDE7BDE7BDE7BE751E6554C5E
      7B6BDE7BF041F041F041F041DE7BF041F041F041F041DF7B57429B365A0E1A02
      1A021A021902F901D70DFB52DE7BFF7FDE7BDE7BDE7BDE7B8649607EE07EA07E
      407E8641B556024FA3467B6FEE41C171007E007F007EC25DB556DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B4A294A294A294A294A29
      4A29DE7BBC12BC12BC12BC12BC125D43DF6BDC1ABC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B580E580E580EFF7FFF7FFF7FFF7F
      FE7B0D3FE82EE82EE82EE82EE82EE82EE82E0B37FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F580E580E580EDE7BDE7BDE7BDE7BE751E6596C5E
      7B6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9E6FFC569A3E
      5A2E39261526EF39E949DE7BFF7FDE7BDE7BDE7BDE7BDE7BB556C259807E607F
      027F21720E42043AE93939678355A07EC07F607EE079AB3DDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B4A294A294A294A294A29
      4A29DE7BBC12BC12BC12BC12DC1AFF7BDC22BC121D2F5D43DC1ABC121D2F5D43
      DC22BC12BC12BC12BC12BC12BC12DE7BDE7B590E590E590EFF7FFF7FFF7FFF7F
      7253E82EE82EE82EE82E0D3F514FE82EE82EE82E955BFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F590E590E590EDE7BDE7BDE7BDE7BE751065A6C5E
      7B6BDE7BF041F041F041F041DE7BF041F041F041F041DE7BF041F041F041F041
      FF7F5B6B6C5E065AE751FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B524AA34DC07E
      E57F667FE34D29258A310442C07FE17F207FA2658B35DE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B6B2D6B296B296B294A29
      4A29DE7BBC12BC12BC12BC123D3FBF67BC123D3FDE7B7E537E531D2FDF731D2F
      BF67FD26BC12BC12BC12BC12BC12DE7BDE7B590E590E590EFF7FFF7FFF7F9763
      E82EE82EE82EE82E514FFF7FFE7B0D3FE82EE82EEA36DD77FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F590E590E590EDE7BDE7BDE7BDE7BE755075A6D5E
      7B6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B
      DE7B7B6B6D5E075AE755DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1863A841
      E266ED7FEA7FE37FE37FE47FE37FC07B8449734EDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B6B2D6B2D6B2D6B2D6B2D
      6B2DDE7BBC12BC12BC12BC125E4B7E53BC12BF67DF6BBC12BC12DF6BBF67BC12
      DC1ADF73BC12BC12BC12BC12BC12DE7BDE7B590E590E590EFF7FFF7FDB73E832
      E832E8320B3BB867FF7FFF7FFF7FDD77EA36E832E8322E47FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F590E590E590EDE7BDE7BDE7BDE7B0856075A6D5E
      7B6BFF7FFA52FA4EFB465C67F956DE7BDE7B00000000DE7B00000000DE7B0000
      FF7F7B6B6D5E075A0856DE7BDE7BDE7BDE7B18630C426B4AED3D734E3967DE7B
      EB3DE27FF47FF07FEC7FE97FE37FA356D65A734EEB39043A6342043A714EDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B6B2D6B2D6B2D6B2D6B2D
      6B2DDE7BBC12BC12BC12BC125E4B7E53BC129E57DF73BC12BC125E4BDF73BC12
      BC12BF67FD26BC12BC12BC12BC12DE7BDE7B790E790E790EFF7FFF7FBA6F745B
      745BBA6FFF7FFF7FFF7FFF7FFF7FFF7FDB73EA36E832E832745BFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F790E790E790EDE7BDE7BDE7BDE7B0856275E8D62
      7B6BDE7BDA42FC3EF7627D67BB3ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B7B6B6D62275E0856DE7BDE7BDE7BDE7B063AE067E067E067815FC24A083E
      8C31616FF37FF47FF07FEC7FE27FA5356342815FE067E067E067E06763427B6F
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B6B2D6B2D6B2D6B2D6B2D
      6B2DDE7BBC12BC12BC12BC121D37BF67BC121D2FDE7B3D3FBC121D37DE7BBC12
      BC12BF671D2FBC12BC12BC12BC12DE7BDE7B790E790E790EFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDB73EA36E832E832B867FF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F790E790E790EDE7BDE7BDE7BDE7B0856285E8D62
      7B6BDE7BDA42B936127F753A7B1EDE7BDE7B0000000000000000DE7BDE7BDE7B
      DE7B7B6B8D62285E0856DE7BDE7BDE7BDE7B443EE067E067E067E067615B043A
      4A292267F97FF87FF47FF07FE57FA535EB39443E2257E067E067E067063ADE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B6B2D6B2D6B2D6B2D6B2D
      6B2DDE7BBC12BC12BC12BC12BC12FF7BDC1ABC123D3FDE7B9E579E5FDE7B1D2F
      BC12DF6B1D2FBC12BC12BC12BC12DE7BDE7B7A0E7A0E7A0EFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDB730A3BE8320A3BDB73FF7F
      FF7FFF7FFF7FFF7FFF7FFF7F7A0E7A0E7A0EDE7BDE7BDE7BDE7B085A285E8D62
      7B6BDE7BDA42792A095E0F329C1EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B7B6B8D62285E085ADE7BDE7BDE7BDE7BD65AE735A531E7350E42B5561042
      C641E97FFF7FF37FF07FF47FED7FE2620E423967D65A524AAD3510423967DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B8C318C318C2D8C2D6B2D
      6B2DDE7BBC12BC12BC12BC12BC125D437E53BC12BC12FD265E4B9E575E4BDC1A
      DC22FF7BBC12BC12BC12BC12BC12DE7BDE7B7A0E7A0E7A0EFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDB732D43E8360A3BDB73
      FF7FFF7FFF7FFF7FFF7FFF7F7A0E7A0E7A0EDE7BDE7BDE7BDE7B295A48628E62
      7B6BDE7B1A53792A5532B9369932DE7BDE7B0000000000000000000000000000
      DE7B7B6B8E624862295ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9C73CB3D6266
      627FF57FE57F2267616FE27FEC7FE77F607A8641D65ADE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B8C318C318C318C318C31
      8C31DE7BBC12BC12BC12BC12BC12BC129E575D43BC12BC12BC12BC12BC12DC1A
      DF6B1D37BC12BC12BC12BC12BC12DE7BDE7B7A0E7A0E7A0EFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFE7B5153E8360A3B
      DB73FF7FFF7FFF7FFF7FFF7F7A0E7A0E7A0EDE7BDE7BDE7BDE7B295A4862AE66
      7B6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B7B6BAE664862295ADE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F6735E07A407F
      E37F807FC73DAD352925EB3D2173E17F607F407EA355D65ADE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B8C318C318C318C318C31
      8C31DE7BBC12BC12BC12BC12BC12BC12BC125E4BDF6B5E4B1D2F1D377E53DF73
      3D3FBC12BC12BC12BC12BC12BC12DE7BDE7B7A0E7A0E7A0EFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FB86B0B3F
      0A3BDB73FF7FFF7FFF7FFF7F7A0E7A0E7A0EDE7BDE7BDE7BDE7B295A6962AE66
      7B6B9C6F9C6F9C6F9C6F9C6F9C6F9C6F9C6F9C6F9C6F9C6F9C6F9C6F9C6F9C6F
      9C6F7B6BAE666962295ADE7BDE7BDE7BDE7BDE7BDE7BDE7BCC41C07A407FC07F
      407F23561863EB3963423967873DA07E807FC07E207E64499C73DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B8C318C318C318C318C31
      8C31DE7BBC12BC12BC12BC12BC12BC12BC12BC12DC1A1D375E4B5E4B1D37DC1A
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B9A0A9A0A9A0AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFE7B
      745B0B439767FF7FFF7FFF7F9A0A9A0A9A0ADE7BDE7BDE7BDE7B495E6966AE66
      7B6BFF7B9D6FDE7BBD77BE77BD77BD77BD77BD77BD77BD77BD77BD77DE779C6F
      FF7B7B6BAE666966495EDE7BDE7BDE7BDE7BDE7BDE7B9C73634D207F807F607F
      C16EEE419C736342815F524A1863A355607E807E407EC265734EDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B8C318C318C318C318C31
      8C31DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B9A0A9A0A9A0AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFE7B97679767FF7FFF7F9A0A9A0A9A0ADE7BDE7BDE7BDE7B4A5E8A66AC66
      7B6B7B6B7B6B7B6B7B6B7B6B7B6B7B6B7B6B7B6B7B6B7B6B7B6B7B6B7B6B7B6B
      7B6B7B6BAC668A664A5EDE7BDE7BDE7BDE7BDE7BDE7BDE7B4441607E207F8172
      CA41DE7BB556615BE067EB39DE7B524AC259407E207EA261B556DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B8C318C318C318C318C31
      8C31DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B9B0A9B0A9B0AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F9B0A9B0A9B0ADE7BDE7BDE7BDE7B6A5EAB6A8A66
      896689668A668C66AE668D629C6F68666866686668669C6F8D62AE668C668A66
      896689668A66AB6A6A5EDE7BDE7BDE7BDE7BDE7BDE7BDE7BD65A44414441304A
      DE7BDE7B1042E067E067043ADE7BDE7B734E66416449CD3DDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B8C318C318C318C318C31
      8C31DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B9B0A9B0A9B0AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F9B0A9B0A9B0ADE7BDE7BDE7BDE7B6A5EAB6A8B66
      AB6AAB6AAB668A6A896668669C6F9C6F9C6F9C6F9C6F9C6F686689668A6AAB66
      AB6AAB6A8B66AB6A6A5EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BAD35E067E0676342DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B8C318C318C318C318C31
      8C31DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B9B0A9B0A9B0A9B0A9B0A9B0A9B0A
      9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A
      9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0ADE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B9C6F9C6F9C6F9C6F9C6F9C6FDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B1042E067E067043ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B8C318C318C318C318C31
      8C31DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC12BC12DE7BDE7B9B0A9B0A9B0A9B0A9B0A9B0A9B0A
      9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A
      9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0ADE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B9C6FDE7BDE7BDE7BDE7B9C6FDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B7B6F063A443E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD65A8C318C318C318C31
      8C31DE7BBC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12BC12
      BC12BC12BC12BC12BC12BC129E57DE7BDE7B9B0A9B0A9B0A9B0A9B0A9B0A9B0A
      9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A
      9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0A9B0ADE7BDE7BDE7BDE7BFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F9C6F9C6F9C6F9C6F9C6F9C6FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B3D5FDD4EDD52FF7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BF76A9C77B66ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BC922C922C922C922C922C922C922DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDB7F2D7FC37EA07EC47E
      2D7FDC7FDE7BFF7F8F6EE765C561C561C561C561C561C561C561C561C561C561
      C561C561C561C561C561C561E7658F6EDE7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFD56
      BC4AFC293E2A3F2A1932DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      325AA74886580A5D115ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BC922C922C922C922C922C922C922DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB77FA17EA07EA07EA07EA07E
      A07EA17EB77FDE7BD272C665C665C665C665C665C665C665C665C665C665C665
      C665C665C665C665C665C665C665C6658F6EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9E731E2A
      3F2ADB253E2A3E2A74211863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9C770D6E4A6509659D7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BC922C922C922C922C922C922C922DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDB6FB863745374537453DE7BDE7BDB7FA17EA07EA07EA07EA07EA07E
      A07EA07EA27EDC7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B096AC665C665C665C665C665C665E765DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFB29
      1D26DA211D261D26383E1863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      BD77BD777623367B137FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BC922C922C922C922C922C922C922DE7BDE7BDE7BDE7BDE7BFE7B975F
      3043C922C922C922C922C922C922DE7BDE7B2C7FC37EB77FFE7FB77FC37EA07E
      A07EA07EA07EA07EA07E947FDE7B947F947FDE7B947F947FDE7B947FA07EDA7F
      DE7B8F6EC665C665C665C665C665C665C665DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDD73B85FB657B54FB553D657F863FC73DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3B32
      DC21BA1DDC25FC259846DE7BDE7BDE7BDE7BBA6F9867DE7BDE7BFF7FF75EB556
      734E8C31F276777F347FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BC926C926C926C926C926C926C926DE7BDE7BDE7BFE7B5147EA2AC926
      C926C926C926C926C926C926C926DE7BDE7BE47EB87FDE7BDE7BDE7BB87FC07E
      C07EC07EC07EC07EC07EC27E967FC27EC27E967FC27EC27E967FC27EC07E507F
      DE7B3677E665E665E665E665E665E665E665DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDD73754F503B6F37B13FD243D247F243F13FF143D44FFB6FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B115E7466B62D
      BA219919BA21BB213D63DE7BDE7BBA6FCA1EAA2AEA123147765FFF7FB556AD35
      4B2DCD39AF6E3573357FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BC926C926C926C926C926C926C926DE7BDE7B755BEA2AC926C926C926
      C926C926C926C926C926C926C926DE7BDE7BE27EFE7FDE7BDE7BDE7BFE7FC27E
      C27EC27EC27EC27EC27EC27EC27EC27EC27EC27EC27EC27EC27EC27EC27E067F
      DE7BBC7FE665E665E665E665E665E665E665DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B134B6B1E0C27B243F553F557F557F557F557F557F557F34FD03FB247
      FC6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2A61C760312D
      991D7819991D991D0F4AB166DE7BDE7B9867EC12CB26511F7657DE7BDE7BA746
      8646A5468E6AB06A1477DD7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BC926C926C926C926C926C926C926FE7B5147C926C926C926C926C926
      C926C926C926C926C926C926C926DE7BDE7B067FB87FDE7BDE7BDE7BB87FE27E
      E27EE27EE27EE27EE27EE27EE27EE27EE27EE27EE27EE27EE27EE27EE27E927F
      DE7B5777E665E665E665E665E665E665E665DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7779639A67775732432E2F903BF44FF553F553F553F453F553F557F34B
      6F33DA67DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF576B27A303D
      561535111311130DED4D9B77DE7BDE7BDE7B115F1063117BDD77DE7BDE7BC74A
      A84AC74EEA51EA514D5EBC7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BC926C926C926C926C926C926C9260D37C926C926C926C926C926C926
      C926C926C926C926C926C926C926DE7BDE7B6E7F067FB87FFE7FB87F067FE27E
      E27EE27EE27EE27EE27EE27EE27EE27EE27EE27EE27EE27EE27EE27E717FDE7B
      DD7F086AE665E665E665E665E665E665E665DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FA67FE7BDE7BDE7BDE7BDE7BFE7B975B2F33B143F453F44FF44FF44FF44FF453
      F44F6E33B85FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBA7F567F8F39
      E64CC364C26CC3644859DE7BDE7BDE7BDE7B997F777F547FDE7FDE7BDE7BE84E
      A846ED21930DB505F31D9D6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BC926C926C926C926C926C926C926C926C926C926C926C926C926C926
      C926C926C926C926C926C926C926DE7BDE7BDC7F047FE27EE27EE27EE27EE27E
      E27EE27E047FFC7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      AF6EE665E665E665E665E665E665E665E665DE7BDE7BDE7BDE7BDE7BDE7BDA67
      6D2BB247DE7BDE7BDE7BDE7BDE7BDE7BFE7B503B703BF44FF44FF44FF44FF44F
      F44FF44B2D2BDB6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B797F2B76017D
      E07CC07CA078C078C07C707ADE7BDE7BDE7B787F567B337FDC7FDE7BDE7BC84E
      0B2A9601B601D7015B02BA2ABE73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE92AE92AE92AE92AE92AE92AE92AE92AE92AE92AE92AE92AE92AE92A
      E92AE92AE92AE92AEA2E2E3F2E3FDE7BDE7BDE7BB77F047FE27EE27EE27EE27E
      E27E047FB87FDE7BF272E765E765E765E765E765E765E765E765E765E765E765
      E765E765E765E765E765E765E765E765E765DE7BDE7BDE7BDE7BDE7BDB6F4D2F
      4C2B6D2BB44FDE7BDE7BDE7BDE7BDE7BDE7BFF7F513F703BF44BD34BD34BD34B
      D34BD34B9243F036FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B13772379237D
      227DE17CC078A078C0780C7ADE7BDE7BDE7B35773577127B9A7BDE7BDE7BE84E
      0C269601B701D7013A02DD163C53DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE82AE82AE82AE82AE82AE82AE82AE82AE82AE82AE82AE82AE82AE82A
      E82A0B33955BDD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDC7F6F7F067F037F277F
      6F7FDC7FDE7BF272E769E769E769E769E769E769E769E769E769E769E769E769
      E769E769E769E769E769E769E769E769E769DE7BDE7BDE7BDE7BDC732D2B2C27
      2C274C2B6D2BB553DE7BDE7BDE7BDE7BDE7BDE7BFE7B0F33913FD347B247B247
      B247B247B3472E2F585BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD16E8779657D
      447D237DC278C178C0786775CA75F67ADE7BB16A6E66AF6E797BDE7BDE7BC74A
      ED21B701D701D7015B02BD023C4BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE82AE82AE82AE82AE82AE82AE82AE82AE82AE82AE82AE82AE82A0B37
      975FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BE769E769E769E769E769E769E769E769E769E769E769E769E769
      E769E769E769E769E769E769E769E769E769DE7BDE7BDE7BFE7BEF32EB220B23
      2B272C272C274C2BB85FDE7BDE7BDE7BDE7BDE7BDE7B9A670D27B24392439243
      924392439243713B8F32DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF46EEA75877D
      867D657DE374C278C174C274C2784671DC776B3A8B2A4A425773DE7BDE7BC74A
      2B2A3011C824C8240C1D39063D47DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE82AE82AE82AE82AE82AE82AE82AE82AE82AE82AE82AE82A514BFE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BE769E7691477FE7F1477E769E769E769E769E769E769E769E769
      E769E769E769E769E769E769E769E769E769DE7BDE7BFF7FD03A8B22AB22CB22
      0B230B230B272C272C27B963DE7BDE7BDE7BDE7BDE7BDE7BD03A5037913F713F
      713F713F513B513B2B229B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7B6E6E0C7AC97D
      A87D877D0479E274C274C274C2742571D052771F5517F31EF03ADC77DE7BC94D
      C84583308338843C8548A938FA4EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE82AE82AE82AE82AE82AE82AE82AE82AE82AE82AE82A975FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B076A076AFE7FDE7BFE7F076A076A076A076A076A076A076A076A
      076A076A076A076A076A076A076A076A076ADE7BDE7BB03A2A1E6B1E8B22AB22
      CB22EB22EB220B230B230C27DB6FDE7BDE7BDE7BDE7BDE7B3657ED26513B5037
      303730370F3310372C22D44ADE7BDE7BDE7BDE7BDE7BDE7BBC7F0C72707E2D7E
      CA7DA87D4679E374C274C274CB75D36A3443561F3417F216D226D14A4F5D8D60
      CF64A53C843C6540874C68546E51FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE82EE82EE82EE82EE82EE82EE82EE82EE82EE82E9763DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B076A076A1477DE7B1477076A076A076A076A076A076A076A076A
      076A076A076A076A076A076A076A076A076ADE7B923EC71109162A1E6B1E8B22
      AB22AB22CB22CB22CB22CB22ED2ADD73DE7BDE7BDE7BDE7B9B6B2B1E0F33EF2E
      EF2EEE2ECE2ACE2A2B22503ADE7BDE7BDE7BDE7BDE7BBC7BAD76907AD37E917E
      0C7ECA7DA77DE474C374C174D66E5D635C57561F1217AD1AAF1A0D518B588C5C
      AD60EB50653C664468506A58684CF365DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE82EE82EE82EE82EE82EE82EE82EE82EE82E514FDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B076A076A076ADE7B076A076A076A076A076A076A076A076A076A
      076A076A076A076A076A076A076A076A076A924224016609A70D091A2A1E6B22
      8B22AB22AB22AB22AB22AB228B22CE2EDD77BD77375B585FF54EA811AE2AAD26
      8D266D264C264C26EA198921185F175F385FDE7BDE7BF61DB60D754EF57EF57E
      2D7EEB7DA97D467DC3740475BD7B9B6F553BC90EA606C702A92A0B598E602749
      6B58EB546540674869586B5C8A508D5CFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE82EE82EE82EE82EE82EE82EE82EE82E0B37FE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B086A086A086ADE7B086A086A086A086A086A086A086A086A086A
      086A086A086A086A086A086A086A086A086A7A6B7B6B9B6B2D2AE9150A1E4B22
      6B228B22AC22CC228B227963BC6FBB6FFE7BDD7768152501670DA8112C262C22
      0B220B220B1E0B1ECA1925052501A200934ADE7BFF7F7401B801DA46D27E387F
      B27E0C7EA87DA77D24798575DE7B965FEA12C802C602C702C916D15A6A56C34A
      684C6848664068504A5C4C60AE5C4C60FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE82EE82EE82EE82EE82EE82EE82EE82EBA6BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B086A086A086ADE7B086A086A086A086A086A086A086A086A086A
      086A086A086A086A086A086A086A086A086ADE7BDE7BDE7B703AA8110A1A0B1E
      2B224B226C228C262A1E9B6BDE7BDE7BDE7BDE7BBD774715A811EB1DCA19CA19
      CA19CA19CA19CA19CA19EB1D25059246DE7BDE7BDE777501B80152096E31177F
      D37A0A62AA556755A275A77EBB7F524B2F332F2BA6060C1B15435C5F335B4353
      853C653C664849544B5C6E64F3708E60DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE82EE82EE82EE82EE82EE82EE82E0B3BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B086E086E1577DE7B1577086E086E086E086E086E086E086E086E
      086E086E086E086E086E086E086E086E086EDE7BDE7BDE7BB44E6609EA190A1E
      0B1E2B224B226C260A1A1553DE7BDE7BDE7BDE7BDE7B9C6F05098811A915A915
      A915A915A915A915C91525050F3ADE7BDE7BDE7B7D677401B701F00411053309
      2A25E524492D6549807EE77EBC7FB96B2F1F0B03E902EA02302378634D5FA752
      8549A6488D6EAB72CB6DB36914715165DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE82EE82EE82EE82EE82EE82EE82E955FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B086E086EFE7FDE7BFE7F086E086E086E086E086E086E086E086E
      086E086E086E086E086E086E086E086E086EDE7BDE7BDE7B7B6B0501EA1DEA1D
      0B1E0B222B222C260B1EEB21DE7BDE7BDE7BDE7BDE7BDE7B3963E404670D8811
      88118811881188112505CC29FF7FDE7BDE7BDE7B3B5B75017601110932095301
      841008216B2D492D4866087B76777653EC36CD2EED2AAB2E652ACC67AB676D62
      D16E6756CF7FAD7FAA7F677FAE69FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE832E832E832E832E832E832E832DD77DE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B086E086E3577FE7F3577086E086E086E086E086E086E086E086E
      086E086E086E086E086E086E086E086E086EDE7BDE7BDE7BDE7B8A21CA190C22
      0B220B220C222C262C264609175BDE7BDE7BDE7BDE7BDE7BDE7B175BC3006609
      670D6709670D25058921FF7FDE7BDE7BDE7BDE7BFA527501760193195209B901
      CF396B2D8C3128254D66E972CD7FB74F4A52B06EF2766E6A4952CC6BCC6BC54E
      115B445FAC7FAC7F8A7F877FAE77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BE832E832E832E832E832E8320A37DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B286E286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286EDE7BDE7BDE7BDE7BD55667096D2A
      4C264C264C264C264D260B1E2611DD77DE7BDE7BDE7BDE7BDE7BDE7B924AE300
      4605460925052711BD73DE7BDE7BDE7BDE7BDE7B9942750196019601B801F901
      8D29E71CCE394A29492DAC7FCD7FB557EE3A0E3B741710238616AB5FAA57B167
      7D678E5E8A7F6B7F687F867F9277DE7BDE7BDE7BDE7B514FE832E832E832E832
      E832E832E832E832E832E832E832E832E832E832E832E832E832E8322D43FE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B286E286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286EDE7BDE7BDE7BDE7BFF7F8A210B22
      CE2EAE2AAE2AAE2AAE2AAE2EEA1D691DBD77DE7BDE7BDE7BDE7BDE7BDE7B513E
      E3000401050D9B6FDE7BDE7BDE7BDE7BDE7BDE7B3732750176019701371AF70D
      79166B318C318C3192528B7FCD7F534BDC47DB53DC47B92773036B3FCC5BEB6B
      23536C62687F6B7F467F8B7FDC7BDE7BDE7BDE7BDE7BDE7B514FE832E832E832
      E832E832E832E832E832E832E832E832E832E832E832E832E8322D43FE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B286E286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286EDE7BDE7BDE7BDE7BDE7B9B6F2505
      CF2EF036CF32EF32EF32EF32F036EB1D26157B6FDE7BDE7BDE7BDE7BDE7BDE7B
      ED2DA2005967DE7BDE7BDE7BDE7BDE7BDE7BDE7B505232467601B701925A561E
      3E2F135725565277867FCC7F8E77DD3FFF6BDD4FDC3BDA2F96132D078B5BCD6B
      47638A7F497F6F7F227F6977DE7BDE7BDE7BDE7BDE7BDE7BDE7B5153E832E832
      E832E832E832E832E832E832E832E832E832E832E832E8322D43FE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B286E286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286EDE7BDE7BDE7BDE7BDE7BDE7BF65A
      4609EF32323F113B113B113B113B313F8D2A2609503E9C73DE7BDE7BDE7BDE7B
      DE7B5963DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB87F4F4E9215CD41AD76782A
      5D4FE572DC7F987FAA7FCE7FDA7FBA3FFF5BFF47763B9723B7175003514BCF6B
      2C634E7B8C7F697F8A7FDB7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5153E836
      E836E836E836E836E836E836E836E836E836E836E8362D43FE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B286E286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      3863260D4D26734773475243524352437243523F2C264609691D303AB34A934A
      BD73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B935A3246CA55EA5DB35E
      886635736E621177AE7FB67FDE7BDD7BDA43B23AF3764D5AAA31333BDE7BDE7B
      8F664D5E8C66947BFE7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5153
      E836E836E836E836E836E836E836E836E836E8362D43FE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B286E286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9C73ED31670DAE2A7243944BB44FB44FB44FD553944BAE2E2505C3047142
      FE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1767304ECA5526596D6E
      FB7F4D620B5AE955BC7BDE7BDE7BDE7BFF7FA3242C5AEB5505317B73DE7B586F
      0C5AB1664E625A6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      5153E836E836E836E836E836E836E836E8362D43FE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B286E286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B7B6F503E89198811CA19EB1DEB1DA9158811AB21B34ADE77DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F8C2D67456C6AF07E
      FE7F0C56884D8E6A9A7BDE7BDE7BDE7BDE7B0B56B06AEB550531BD77DE7BD756
      B45AB35ECA4D935ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B5153E836E836E836E836E836E8362D47FE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B286E286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BBC73175F72462F3A303ED5523863DE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1767273505310B5A
      BD7B884D0B5E347B9A7BDE7BDE7BDE7BFF7FF272347BCB4D0531DE7BDE7B156B
      547F6E5E4839D562DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B5153E836E836E836E8362D47FE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B4A6E286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E4A6EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BAB45705A7977
      DE7B874D664DB06E376FDE7BDE7BDE7BDE7F6E62B16A2735AB45DE7BDE7BFF7F
      7A73D566AA41DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B5153E836E8362D47FE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BD176286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286ED176DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B5A73D36A9A77FF7FDE7BDE7BDE7BDE7B9B7BD466CB499C77DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7B51532D47FE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BFE7FD1764A6E286E286E286E286E286E286E286E286E286E286E
      286E286E286E286E286E286E4A6ED176FE7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      9256C841A63DD45EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BBD7FF77A63706370637063706370637063706370637063706370
      63706370637063706370C6747B7FDE7BDE7BDE7BD1720866C665C665C665C665
      C665C665C665C665C665C665C665C665C665C665C665C665C665C665C665C665
      0866D172DE7BFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFE7B
      D863D85FFD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FF75EC841
      064E27524852E5451767DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDF77FF7B737600680068426C846CC66CE770087108712971087108710871
      E76CC66CA56C636C006800686368D67ADE7BD172C665C665C665C665C665C665
      C665C665C665C665C665C665C665C665C665C665C665C665C665C665C665C665
      C665C665D272FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD75B
      B143B143B557FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F1863AE35EF390F42
      084A274E274E485626523967DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F3F635F3ADF21
      9F11BF09BE0DA75C496D8C6DCE6DCE6DCE6DCE6DAD6DAD6DAD6DAD6DAD6DAD6D
      CD6DCE6DCE6DCE6DAD6D6A69A564CE6DDE7B0866C665C665C665C665C665C665
      C665C665C665C665C665C665C665C665C665C665C665C665C665C665C665C665
      C665C665086AFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFE77703F
      703F903F703BDC6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BB552F75E734AEF3DF856
      B452274E274E675A687FC8317B6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3F677F191F01FF003F01
      5F019F019E016C55736E316A316A316A316A316A316A316A316A316A316A316A
      116A316A316A316A316A526ACE65316ADE7BC665C665C665C665C665C665C665
      C665C665C665C665C665C665C665C665C665FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      C665C665C665FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFD77503B
      4F3B4F3B4F37DB6BDE7BDE7BDE7BDE7BDE7BDE7BFF7FCE397B6F734A5246FF7F
      BC73284E074A076BE67F6C3A4E059C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7F4A3E059D015E013F015F01
      7F01BF01FF015229EE71B476B4769476B47694769476947694769476B572D66E
      B66EB56ED66ED56EB56E946EAD615A77DE7BE665E665E665E665E665E665E665
      E665E665E665E665E665E665E665E665E665FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      E665E665E665FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFD772F37
      2F372F372F33DB6BDE7BDE7BDE7BDE7BDE7BDE7BD75AEF39EF393142BD73DE7B
      346B064A4756A77FC67F301E3702E82CBD7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5F427D01BD017E015F015F01
      9F01DF011F023F0294196F398F398F39AF39AF39D039D039B039B139D059CE65
      CE65CE65CE65CE65CE65316ADE7FDE7BDE7BE665E665E665E665E665E665E665
      E665E665E665E665E665E665E665E665E665FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      E665E665E665FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7F9C7F9C7FDE7F
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFE7B0E33
      0E2F0E2F0E2FDC6FDE7BDE7BDE7BDE7BDE7BFF7FEC3D3242944EBD77DE7BBB77
      2852064E4873E67F086737029A02074D4951FF7FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9F4E7D05DC019D017F017F01
      BF01FF011F027F02BF02FF021F035F035F03FF025F033F031F03DF025E47DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE665E665E665E665E665E665E665
      E665E665E665E665E665E665E665E665E665FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      E665E665E665FF7FFF7FFF7FFF7FFF7FFF7FFF7F9472E760425C216021644268
      C66CCE75187BDE7FDE7BDE7BDE7BDE7BDE7BDE7B585B344B544B554F544BED2A
      ED2AED2AED2A5347554F554F344B5657FF7B1763E545B15AFF7FDE7B99734952
      E549F066F47FC77F4F26FF02790A0669C464DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF5A9D0DFC01BD019E019F01
      BF01FF013F027F02BF02FF023F033F039F021F027F035F033F03FF027F3BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE665E665E665E665E665E665E665
      E665E665E665E665E665E665E665E665E665FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F4A6184580058005C006000640068
      0068006C2975A570CE759C7FFF7FFE7FFD7FF246E8052A166B1EAD26CE2AEE2E
      EE2EEE32EE2ECE2EAD2A8C224A1A080E8F2E0B462752274EAF5ACF5E274EE549
      D062FF7FFD7FAE469A0A5F03D029047DE55CFF7FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5F67BE191B02DD01BE01BF01
      DF011F023F027F02DF02FF02FF02BF02AE3D5B0E9F039F035F031F037F3FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE665E665E665E665E665E665E665
      E665E665E665E665E665E665E665E665E665FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FE75CC65C0058005C006400640068
      006C6374B57E217400704270697E0A7F097F08220B124C1E6D268E2AAE2EAF2E
      CF32CF32CF2EAE2E8E2A8D264D222B1AEA1586394852274E064E064A074EF266
      DE7BDE7B1657772A5F27BA1AE65C057DAB59DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBF771F2E3B02FC01DE01BF01
      DF011F025F029F02BF029F021F13EC59E06C341ABF039F035F031F039F4BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE765E765E765E765E765E765E765
      E765E765E765E765E765E765E765E765E765FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F8C692965BD7FFF7FFF7FFF7FFF7FFF7F085DE760005C006000640068006C
      A574737EB36E6378007400706475297F287F49360D162D224E226E268F2A8F2E
      8F2E8F2E8F2E8F328F2E6E2A4E264E264E2AEB41274E074E074E67564D73FE7F
      DE7BF752B646FF7B7E4B6B41267DE46C396FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBF4A1B021C02DD01DE01
      DF011F025F023F023F0A1F4FB76601692261B8369F039F035F031F03BF5FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE769E769E769E769E769E769E769
      E769E769E769E769E769E769E769E769E769FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FA560A5602965BD7FFF7FFF7FFF7FFF7F4A610861215C00600064846C317A
      7C7FF4724D5EEF7D00780074A479297F297F2977693A4B2E4B2E6B2E4A2A4E26
      6F2E6F2E6F2A4D226F2A6E2A6F2E9036BC6FDE7B2A4AC6666773C67FE87FD17B
      9342D74ADE7BFF7F315E71760C7ECC59FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9F6FDD053C02FD01DE01
      DF011F02FF013F225F6BBF773D6B446987651E675F277F033F031F0FFF7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE769E769E769E769E769E769E769
      E769E769E769E769E769E769E769E769E769FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FA560A560A5606B69DE7FFF7FFF7FFF7FEF69E760425C0060086D7B7FDE7F
      597BE9590B5A5A7F63780074067A297F297F4A7F6A7F8A7FAB7FAA7F076F6E2A
      9136913690327963DE7BDE7BDE7BDE7BDE7BDE7BFF7FCD5E666F8773E9525122
      BB1ADF57BE73315E3973DE7B4F66BD7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3F323B02FD01DE01
      DF01BF01BF197F73BF7B7E6F945E4545FA66BF7B3F433F031F037F43DE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE769E769E769E769E769E769E769
      E769E769E769E7691477FE7F1477E769E769FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FC664C660C660A560AD69FF7FFF7FFF7F1877A55C635C426073769C7F9C7F
      8E66E8550B5A9B7F2A790070A77E297F297F4A7F8B7FAB7F677FC37EA56A902E
      D33ED23EB23A595FDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F9446F301BD023F03
      5F17982A6B519276FF7F386BB556F85EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDF77FF1DFC01FD01
      DE013F051F63FF7F5B6FEA554345E138EB4DDF7F5F4FFF021F17FF7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE769E769E769E769E769E769E769
      E769E769E769E769FE7FFF7FFE7FE769E769FF7FFF7F187B0869C664C664C664
      C664C664C664C664C664C664CE6DFF7FFF7FDE7BAD69215C2969DE7BDF7F1477
      4C66095A4D5E9C7F85742275087F297F497F6A7F687F257F647E62658266B136
      F54AF44AF342595FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1957B119132A
      6C45E564257DAA7D2F627B73734E734EF75ADE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F5F32BE01
      9E01DF2DDE7B7B772A5EA751854923418845FE7F5F3B1F23DF73DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BE769E769E769E769E769E769E769
      E769E769E769E7691477FF7F1477E769E769FF7FFF7F4A6DE768E768E768E768
      C664C664C664C664C664C664C6641072FF7FDE7BDE7B106E2969DE7B59738E6E
      8E6E2A5E6E62FF7F097A867EE87E097F4A7F277FEC721A6788614361A85ED23E
      37573753164F795FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B396FA360
      C378E474E4605162DE7FDE7BDE7B734E734EF75ADE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1F57
      9F0D9F46DE7BD16E2A5EC85585496445C951146F7C5FDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B076A076A076A076A076A076A076A
      076A076A076A076A076AFF7F076A076A076AFF7FFF7FE768E768E768E768E768
      E768E768E768E768E768E768C664C6645272DE7BDE7BDE7BF772CA4921392B5E
      AF722B622B5E6D6A877EC77EC87E097F077FF0727F6F9F6FCA61ED653C63AF3A
      174F595FB23ADE77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      F76A386BDE7BDE7BDE7BDE7BDE7BDE7B9452524AD65ADE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DF773F57FD7FAF724C62E855E8554C5E4B62095E08669A7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B076A076A076A076A076A076A076A
      076A076A076A076A076AFF7F076A076A076AFF7FFF7F086D086DE76CE76CE768
      E768E768E768E768E768E768E768E7685272DE7BDE7BDE7B915E2041E355117B
      6E666E666D664B622962456EC87EE77EEE76BF737D732E5A4441945ABF776E73
      0A5B1553DD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556524AD65ADE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BFE7FD0764C662A5E8F668F666E664C664B626E66FF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B076A076A076A076A076A076A076A
      076A076A076A076A076AFF7F076A076A076AFF7FFF7F6B71086D086D086D086D
      086D086DE76CE76CE768E768E7683172FF7FDE7BDE7BFF7F84458049E259AE6A
      B16AB06A8F6A8E6A6C668149246AC77E7B77BE772C5E854D223DCA4DDF7BAE7F
      F87FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556524AD75ADE7BDE7BDE7B
      DE7BFF7FDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B337B4C62B066B06A8F6A8E6A8D6A6D666C667877DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B076A076A076A076A076A076A076A
      076A076A076A076A1477FF7F1477076A076AFF7FFF7F187B29710871086D086D
      086D086D086D086D086D086D1072FF7FFF7FDE7BDE7B9A774045A04DE0558D66
      F26ED16ED072AF72AF72055A6049C97ADF7F1473095EA7516549EA55136FDB7F
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB5563146D65ADE7BBD7B
      CE55434422488548D666DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B1477B066D16AB06AB06EAF6EAF6E8E6A8D6AF372DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B076A076A076A076A076A076A076A
      076A076A076A076AFE7FFF7FFE7F076A076AFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F08710871086D086DCE71FF7FFF7FFF7FDE7BDE7B386F6045A051005A6866
      F372F272F276F176F17648626049136FFD7FF2764B62095A4D624C622A5E9066
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556524A324A2248
      0258435C4358235C014CF866DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B58738F66F36ED26ED16ED16ED072D072AF72AF6ED06EFF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B086A086A086A086A086A086A086A
      086A086A086A086A1477FE7F1477086A086AFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F297129712971CE75DE7FFF7FFF7FFF7FDE7BDE7B586F6045A051005E6366
      F3721377137B327F127B29626049B062DE7B557F4C668F66AF6A8E666D664C66
      7977DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524E73528D59
      02584358435843582358024C5A6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9B77E951146FF36EF26EF272F172F176F176D076D072D072FE7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B086E086E086E086E086E086E086E
      086E086E086E086E086E086E086E086E086EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F29752971AD75DE7FFF7FFF7FFF7FFF7FDE7BDE7B7A736045A04D005A6066
      CF6EF272337F337F127F686A804DF366DE7B5777B06AD16AB06EAF6E8E6E8D6A
      F372DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FE8506450B556
      AE5922584358435843582368E934BD73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B6F5E4D5E3673F36EF272F272F2761277127BF17AF176D076DD7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B086E086E086E086E086E086E086E
      086E086E086E086E086E086E086E086E086EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FEF75AD75BD7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BFE7F8349804DE0554066
      6A668749C8510B5A0C5EC551C155BD7B59738F66F36ED16ED172D072D072AF72
      D072FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6F0150225C854C
      9456C758225843584354226C4E3D6E2AFE7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FC8512B5AF46EB066F372F2721277127B337F127F117BD076DD7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B086E086E086E086E086E086E086E
      086E086E086E086E086E086E086E086E086EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7B2B568049C051205E
      265EA351A251824962456245E355FE7F2C5AF36EF36EF272F272F276F176F076
      D072DE7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B315A025843582258
      435443584358435843542274932D2E33336BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      9B77864D864D85490A561373F2721277127B327F127F117BF076DD7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B086E086E086E086E086E086E086E
      086E086E086E086E086E086E086E086E086EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7B79736045804DC055
      C051A251C155C155A151814DAE667973E955F36ED26EF3721277127B327F117B
      F176DD7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BCF55025843584358
      2358435843582254226043743A0A8C47EA62DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      5873854965496549EA551477F272F2761277127BF17AF076F076FE7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B086E086E086E086E086E086E086E
      086E086E086E086E086E086E086E086E086EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      086E086E086EFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BB16260456049
      6245A14DC151C055A0510656FF7FD366864DA64D6E6213771277127B327F127B
      F176DE7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB562015443584358
      435843580254865CCC7D6D45FE028467EE62DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      166F644544456445A74DF3721377F276F276F176D076D072F172FF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      286E286E286EFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BD2626545
      224161458149A24D8C62DD7BDE7B6F5E654964454C5E1377F2721277F17AF076
      F176FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F854422584358
      4354225408617B7F7C6B3D43533F60777A6FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      166F4441233D4341654987416F62D16E8F6A8E6AF076AF721477DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      286E286E286EFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BFE7F
      596F166B386FBD7BDE7BDE7BDE7B4E5A2341434186496F5EF272D172D072CF72
      1377DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BC74C2264
      22684274717E7C637D67FC77F57FEC62FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      5873434102398549E555E455233524312235C228EA512B5E705ADE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B286E286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      286E286E286EFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7B6F5E023D6445E55584454535233966414C62
      705EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FAE45
      4D417139381A5E43DA77FB7B3967DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      BD7B86496449055A4362A26E027BC272836EE655E424C424EC49DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B4B72286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E4B72FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7B156B8549E5596366E176C172636685450631
      0D4EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F
      D33E2F2F8F3F866789731863BD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BAF66045E6366A272E176A1726366E459A651C7514D5ABC7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF376286E286E286E286E286E286E
      286E286E286E286E286E286E286E286E286E286E286E286E286E286E286E286E
      286E286E1377FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BFE7FCD6AA56EE376A26E2362C551EA55D36A
      DE7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7F346BC862C85E566BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BFE7F52774D7B4C7BC7726666285A0B56705E5873FF7FDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF3764B72286E286E286E286E
      286E286E286E286E286E286E286E286E286E286E286E286E286E286E286E286E
      4B721377DE7BFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFE7FD97FB77F3273D16A166F9B77DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B210021002100
      2100210021002100210021002100210021002100210021002100210021002100
      210021002100210021002100DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFE7F2E4EEB49A941A941A941A941A941
      A941A941A9416735C31C5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBE6B781E360ABE67DE7B
      DE7BDE7BBE6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100FF77FF73
      FF73FF6FFF6FFF6FFF6BFF6BFF6BFF67DF67DF67DF67DF63DF63DF63DF5FDF5F
      DF5FDF5FDF5FDF5FFF632100DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F0C4AEB45A941A941A941A941A941
      A941A941A9416735C31C5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3B47160216025712BE6B
      DF77DA3216029926DF77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100FF73DF6F
      DF6FDF6FDF6BDF6BDF6BDF67DF67DF67DF63DF63DF63DF63BF5FBF5FBF5FBF5F
      BF5FBF5FBF5FBF5FDF5F2100DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7A6FA941CA41A941A941A941A941A941
      A941A941A9416735A21C5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7B7D5B5C53FF7B9E67370E1602160216021602
      1602160216021602DF73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100FF73DF6F
      DF6FDF6FDF6BDF6BDF6BDF67DF67DF67DF67DF63DF63DF63BF5FBF5FBF5FBF5F
      BF5FBF5FBF5FBF5FDF632100DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F
      FF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDD7B8A3505256739A941A941A941A941A941A941
      A941A941A9416735A2187A6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B7D5B160216021602160216021602160216021602
      1602160216021602BE6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100FF73DF6F
      DF6FDF6FDF6BDF6BDF6BDF6BDF67DF67DF67DF63DF63DF63DF63007C007C007C
      007C007C007CBF5FDF632100DE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7FDE7BDE7B
      DE7BDE7BDE7BFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BFF7FAA39E3244731883DA941A941A941A941A941A941
      A941A941A9418839A21CED3DDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B5C57160216021602160216021602160216021602
      16021602160216029926BE6FDE73DF77DE7BDE7BDE7BDE7BDE7B2100FF73FF73
      DF6FDF6FDF6FDF6BDF6BDF6BDF67DF67DF67DF67DF63DF63DF63007C007C007C
      007C007C007CBF5FDF632100DE7BDE7BDE7BDE7BDE7BFF7FDE7BDE7BFF7FBD77
      9C739C73DE7BFF7FDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B9C775A6B
      1863F75E18637B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7B2F4A252D883DA941A941A941A941A941A941A941A941
      A941A941A941A941252960103867DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BFF7B160216021602160216021602160216021602
      1602160216021602160216021602B926DE7BDE7BDE7BDE7BDE7B2100FF73FF73
      DF6FDF6FDF6FDF6BDF6BDF6BDF6BDF67DF67DF67DF67DF63DF63DF63DF63BF63
      BF5FBF5FBF5FBF5FDF632100DE7BDE7BDE7BFF7FDE7BDE7B1863CE390821E71C
      C618C71808214A29524ABD77DE7BDE7BDE7BDE7BDE7BDE7B18638C31C618C618
      E71CE718C614A514E71C314ADE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BD55E252D883DA941A941A941A941A941A941A941A941A941
      A941A941A941A94188398118CC39DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BBE67170217021702170237061B43BE6FFF7FBE6F
      1B433706170217021702170217021702BE6FDE7BDE7BDE7BDE7B2100FF77FF73
      DF6FDF6FDF6FDF6FDF6BDF6BDF6BDF67DF67DF67DF67DF67DF63DF63DF63DF63
      DF63DF63DF63DF63DF672100DE7BDE7BDE7BFF7FFF7F3146420C0819113AB54E
      D656D65A9452EF39C718C5181863DE7BFF7FFF7FDE7B734E84108C29B6525A6B
      7B6F9C6B5B63F852D03163084A2DDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B7A6F262D6739A941A941A941A941A941A941A941A941A941A941
      A941A941A941A941A93DE3208A35DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BBE6B3C47580E37023702370237069E63DE7BDE7BDE7BDE7B
      DE7B9E6337063702370237023702FA32DE7BDE7BDE7BDE7BDE7B2100FF77FF73
      34053405DF6FDF6F340534053405340534053405340534053405DF63DF633405
      340534053405DF63FF672100DE7BDE7BDE7BDE7BB5562104333ADF67FF6FFF73
      FF7BDE7BDE7BFF7FDF6BF035A5145A6BDE7BDE7B18638410964AFF73FF7BDE7B
      FF7FFF77DF6FDF6BFF6B1A4F630C3146DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B596B47314631A941A941A941A941A941A941A941A941A941A941A941
      A941A941A941A941A93DE424AB35DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7B991E370237023702370237021B43DE7BDE7BDE7BDE7BDE7B
      DE7BDE7B1B433702370237023702DF77DE7BDE7BDE7BDE7BDE7B2100FF77FF73
      34053405DF6FDF6F340534053405340534053405340534053405DF67DF673405
      340534053405DF63FF672100DE7BDE7BDE7BDE7B4A296C21DF639F5F9F63BF6B
      BF6FDF77DF7BBE739E67FF6F8C29CE39DE7BDE7BAD35CF31FF6F7E63BE6FFF7B
      DF7BDF73BF6B9F637E5BDF63F131E71CFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDD7B67354631A93DA941A941A941A941A941A941A941A941A941A941A941
      A941A941A941A941A93DE424AB39DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7B580A37023702370237023702DE6FDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE6F3702370237023702BE6FDE7BDE7BDE7BDE7BDE7B2100FF77FF73
      FF73FF73DF6FDF6FDF6FDF6FDF6BDF6BDF6BDF6BDF67DF67DF67DF67DF67DF67
      DF67DF67DF67DF67FF672100DE7BDE7BDE7BD65AE71C963ABF5F7F5B9F63BF6B
      DF73FF7BFF7FDF737E63BF67F8522925DE7BDE7B2A25F852BF677E63BF73FF7B
      FF7BDF73BF6BBF677F5BBF5BD842A514DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      9C73B45EC941C941A941CA45EB45EB45A941A941A941A941A941A941A941A941
      A941A941A941A941A93DE424AB39DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BBE6779163702370237023702DE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BFF7F37023702370237027916BE67DE7BDE7BDE7BDE7B2100FF77FF73
      FF73FF73FF73DF6FDF6FDF6FDF6FDF6BDF6BDF6BDF6BDF6BDF67DF67DF67DF67
      DF67DF67DF67DF67FF6B2100DE7BDE7BDE7B5146E718D8429F5B7F5B9F63BF6B
      DF73DF7BFF7FDF737E639F675C5F2A219C739C732A215B5B9F677E63DF73FF7F
      FF7BDF73BF6B9F677F5F9F5BFA46A510BD77DE7BDE7BDE7BDE7BDE7BDE7BB55A
      4208B3560D4ECA45A83D0C4A915A0D4ECA41A941A941A941A941A941A941A941
      A941A941A941A941A93DE424AB39DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BBE6F3802380238023802DE6FDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE6F38023802380238023802580ADE7BDE7BDE7BDE7B2100FF77FF77
      34053405FF73FF6F340534053405340534053405340534053405DF6BDF673405
      340534053405DF67FF6B2100DE7BDE7BDE7B3146081DFA469F5B7E5B9F63BF6B
      DF73FF7BFF7FDF737E637E639D634B259C73BD774B259D637E637D63BE73FF7B
      DF7BDF73BF6B9F637E5B9F5B3B4BA5109C73DE7BDE7BDE7BDE7BDE7B94562100
      8B2937670D4ECA4567390D4A586F0D4ECA45A941A941A941A941A941A941A941
      A941A941A941A941A93D0425AB39DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDF7738023802380238023C43DE7BDE7BDE7BDE7BDE7B
      DE7BDE7B1C43380238023802380238029A1EDE7BDE7BDE7BDE7B2100FF7BFF77
      34053405FF73FF73340534053405340534053405340534053405DF6BDF6B3405
      340534053405DF6BFF6B2100DE7BDE7BDE7BE71C630CB63EFF639F5F9F639F6B
      BF6FDF77DF7BBE737E63BF6BBF67091DB556D65AC6145B5FFF6FBF67DF73FF7B
      DF77DF73BF6BBF67BF63FF63543A42086A29DE7BDE7BDE7BDE7B396B21006A29
      BD7B7A730C4ACA454631EC41376BEC49CA45A941A941A941A941A941A941A941
      A941A941A941A941A93D0429AB39DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BFB36580258025802580258069E67DE7BDE7BDE7BDE7B
      DE7B9E67580658025802580279123C4BBE6BDE7BDE7BDE7BDE7B2100FF7BFF77
      FF77FF73FF73FF73FF73DF6FDF6FDF6FDF6FDF6FDF6FDF6BDF6BDF6BDF6BDF6B
      DF6BDF6BDF6BDF6BFF6F2100DE7BDE7BDE7B4A29420CA510533A5C57DF6BFF73
      FF7BDE7BDE7BFF7FBF6B3A576B25620CC618C6186310C614523E3B5BBE73FF7F
      FF7FFF77DF6F7C5FD74A8D25420842087556DE7BDE7BDE7BFF7F8310E7189C73
      9A5FF5560D4EEB456735EC45376BEC49CA45CA45EB45EB45C941C941CA45CA45
      CA41CA41CA45EB45A941E4242F46DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE6F58025802580258025802580259063C43DF6FDE7BDF6F
      3C4359065802580258025802BE6BDE7BDE7BDE7BDE7BDE7BDE7B2100FF7BFF77
      FF77FF77FF73FF73FF73FF73FF73DF6FDF6FDF6FDF6FDF6FDF6FDF6BDF6BDF6B
      DF6BDF6BDF6BDF6BFF6F2100DE7BDE7BDE7BDE7BAD352104A514A51029218C2D
      CE39EF3DCE398C2D081D84108B3118637B6F5A6B7B6F314AE71C8510E71C2925
      4A252925081DA51084106B2D630C8C31DE7BDE7BDE7BDE7B73524204B456DD73
      090A1557925E4F56A941B25E596F0C4ACA45CA454F524F52EB45C9410D4E2E4E
      EB45CA412D4E4F52CA45E320B456DE7BDE7BDE7BDE7BDE7BDE7BFD7FDA7FDE7B
      DE7B4F7FA17E507FDE7BDB2A5906590659065906590659065906590659065906
      590659065906590659065906FF7BDE7BDE7BDE7BDE7BDE7BDE7B2100FF7BFF77
      34053405FF77FF73340534053405340534053405340534053405DF6FDF6F3405
      340534053405DF6FFF6F2100DE7BDE7BDE7BDE7B5A6BA51452461863EF3D8C31
      6B2D4A296B2DAD35524A3967DE7BDE7BDE7BDE7BDE7BDE7BFF7F396794523146
      31463146734ED65AFF7F9452A5147B6FFF7FDE7BDE7BFF7FA514281DBD7B8F26
      C60159675977F56AD4665757365F0D4EA93DA93D9B73B25EEB458739D462D462
      EC49883DF562176B4F52252DB356DE7BDE7BDE7BDE7BDE7BDA7FA17EA17E4F7F
      4F7FA07EA07EC47EFE7FFF77BC77DF6FDB265906590659065906590659065906
      5906590659065906590659067D57DE7BDE7BDE7BDE7BDE7BDE7B2100FF7BFF77
      34053405FF77FF77340534053405340534053405340534053405DF6FDF6F3405
      340534053405DF6FFF732100DE7BDE7BDE7BDE7BDE7B734E84109C6FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7B7B6F8410734EDE7BDE7BDE7BDE7B9C73410410429B6BE701
      C7018E26F236F236D02A6B0AF55A0D4E883947319C77D4624E52883DF562376B
      7056A94116679B73D35ECA45386BDE7BDE7BDE7BDE7BDE7BDA7FA07EA07EA07E
      A07EA07EA07EA07EC47EE77EA07E4E7FDF6F5906590659065906590659065906
      5906590659065906590679069E5BDE7BDE7BDE7BDE7BDE7BDE7B2100FF7FFF7B
      FF77FF77FF77FF77FF77FF73FF73FF73FF73FF73FF73FF73FF73DF6FDF6FDF6F
      DF6FDF6FDF6FDF6FFF732100DE7BDE7BDE7BFF7FFF7FFF7F6B2DE71CDE7BFF7F
      FF7FDE7BFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7FFF7F
      FF7FFF7FFF7FDE7BE71C6B2DFF7FFF7FDE7BDE7BDE7BD65E62049456D442C601
      E701E7010702070227026A06F55A0C4E883926297A6F5973B3620D523867BB73
      366B915ABC77DE7BBD7BBD7BDE7BDE7BDE7BDE7BDE7BDE7B4F7FA07EA07EA07E
      A07EA07EA07EA07EA07EA07EA07E087FDF775906590659065906590659065906
      59069A12BE67FF7B7D579E5BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100FF7FFF7B
      FF7BFF77FF77FF77FF77FF77FF77FF73FF73FF73FF73FF73FF73FF73FF73FF73
      FF73FF73FF73FF73FF772100DE7BDE7BDE7BDE7BDE7BDE7BBD77C618AD35DE7B
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BFF7FDE7B8C31C618DE7BDE7BDE7BDE7BDE7BDE7B524E840893564E2AC601
      E80128022802490248028B0AF55A0C4E88390529F34255435863575B0F230B1A
      524E734E1867DE7BDE7BDE7BDE7BDE7BDE7BFE7FC37EC27EA07EA07EA17E707F
      DB7FFF7FDB7F707FA17EA07EA07E4F7FFF77DB2A59061C37FF77BE6F9A165906
      59065D4BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100FF7FFF7B
      34053405FF7BFF77340534053405340534053405340534053405BE6BBE6B3405
      340534053405BE6BDF732100DE7BDE7BDE7BDE7BDE7BDE7BDE7B3967630C524A
      DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDE7B3146630C3967DE7BDE7BDE7BDE7BDE7BDE7B314AA40C514E0C1EE701
      080228024802490248028B0AF55A0C4E8839E528D23E6802AB06AA02A9026501
      A5106A29D65EDE7BDE7BDE7BDE7BDE7BDE7B947FA07EA07EA07EC17EB87FDE7B
      DE7BDE7BDE7BDE7BB87FC17EA07EE47EDA7FDE7BDE6FDE7BDE7BDE7BBE6B790E
      BA22BE6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100FF7FFF7B
      34053405FF7BFF7B3405340534053405340534053405340534057346744A3405
      340534053405944AD64E2100DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556630C
      9452DE7BFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F
      DE7B524A630CD65ADE7BDE7BDE7BDE7BDE7BDE7BDE7B7352840CEF41EC1DE701
      080228024902490269028B0AF55A0C4E8839E524D23E890289028902AA026609
      E718AC35F762DE7BDE7BDE7BDE7BDE7BDE7BFF7F097FC17EC17E707FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7B507FC17EC17EC17E087FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100FF7FFF7B
      FF7BFF7BFF7BFF7BFF7BFF7BFF7BFF7BFF7BFF7BFF7BD6522100210021002100
      210021002100210021002100DE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B734E
      4208524ADE7BDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      10424208B556DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7B18676308AC35CC25E701
      28024902490269026902AB0AF55A0C4E8839E524F23E890289028902C906050D
      4A25CD3D7B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7B717FC17EC17EDB7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDB7FC17EC17EC17EE47EDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100DE7BFF7B
      FF7BFF7BFF7BFF7BFF7BFF7BFF7BFF7BFF7BFF7BFF7BB55221007B6BBD739D73
      9D739D739D73DE7B2100DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B
      945242088C31BD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F4A29
      630CD65ADE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD7B62084925AC2DC801
      28024902690269026902AB0A165F4F56CA41062DF23E89028902A902680A8308
      0F3EEE41DE7FDE7BDE7BDE7BDE7BDE7BDE7BDB7FE57EC17EC17EDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BFF7FC17EC17EE57EDC7FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100DE7BFF7F
      34053405FF7BFF7B3405340534053405340534053405B5522100DE77FF7FFF7B
      FF7FFF7FDE7B2100DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BF75EE71CA514CE399452D65ADE7BDE7BDE7BFF7F945210426B2D84104A29
      5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2929E6146B2D890D
      280249026902690269028A065867F56A4F52CB4914438902A902C9064605C614
      1763524EDE7BDE7BDE7BDE7BDE7BDE7BDE7BE47EC17EC17EC17EDB7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDB7FC17EC17E727FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100DE7BFF7F
      34053405FF7FFF7B3405340534053405340534053405B5522100BE6FFF77FF77
      FF77FF7F2100DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BBD77734E4A29C6186B2DBD77DE7BDE7BDE7BEF3D2925AD35D65AFF7F
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1867630849254921
      C80169026902690289026902112F9A6F37673657CD16A802E90608066304524A
      F6627B73DE7BDE7BDE7BDE7BDE7BDE7BDE7B2B7FC27EC27EC27E717FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7B717FC27EC27E297FFF7FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100DE7BFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FB5562100BE67FF73FF73
      FF7B2100DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BFF7FDE7BDE7BFF7FBD77DE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2929C6104925
      0715E80189028902890289028902AB0ACD12AA02A802E906280663046B2DBD77
      7352DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDB7F067FE27EE37ED97FDE7B
      DE7BDE7BDE7BDE7BD97FE37EE27EE27EE27E957FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100DE7BFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FB5562100BE63DF6BFF73
      2100DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD7B84100719
      2821E61087016902AA02AA02AA02A902A902C906A906A60563046A29DD775252
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B707FE27EE27EE37E717F
      DB7FDE7BDB7F717FE37EE27EE27E057F077FFE7FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100DE7BFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FB55621009E63FF6F2100
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B73A414
      071D2921C614C5086605E8054806480A070E6605A304840C0F3EDD7B7356BD77
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B297FE27EE27EE27EE27E
      E27EE27EE27EE27EE27EE27E927FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100DE7BFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FB5522100DF672100DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9C77
      2825E61849252821C614A510A40C840C840CC618CD3539677B737352DE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B927F037F4B7F277FE27E
      E27EE27EE27EE27EE27EE27EDA7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B2100DE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7FD65A21002100DE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FB55A082508216A29AC31CD350F3E934E1763186794561867FF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFD7FDE7BFF7F277F
      E27E037F717F927F047F057FDB7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B210021002100
      2100210021002100210021002100210021002100210021002100DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BFF7F1867CE41282928294A31AD3D72525A6BFF7FDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B927F
      057F717FDE7BDE7BDC7FFE7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BBE77195B343A8F192D0D2D0D8F19543A195BBE77DE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD41DD51DF51DF51D
      F51DF51DF51DF51DF51DF51DF51DF51DF51DF51DF51DF51DF51DF51DF51DF51D
      F51DF51DF51DF51DD5195732DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BFF7F1A5BB021EB00CB00EB000C010C01EB00EB00CA00CA00CA00B0211A5F
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD615DF5FFF63FF5F
      FF5FFF5FFF5FFF5FFF5FFF5FFF5FFF5FFF5FDF5FDF5FDF5FDF5FDF5FDF5FDF5F
      DF5FDF5FDF5FFF5FBF5BF525DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDF7B
      BF777F6F1F67DF5EDF66FF6A1F73FE6ABE5E5E521E4A3F4A3F465F4EBF561F63
      7F73BF77DF7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      5C676F110C012E016F05D11D122E533A543E533E1236D0296E150C05CA00A900
      4D117C6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD615FF63FF67FF67
      FF67FF67FF67FF67FF67FF67FF67FF63FF63FF63FF63FF63FF63FF63FF63FF63
      FF63FF63FF63FF67DF5FF425DE7BDE7BDE7BDE7BDE7BDE7BDE7B9C73BD77FF7F
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDF7B7D4E7E31
      9E2DDE2D7F3E1F539F67DF6FDF73DF6F9F673F53DE467E363E2A1E26DE21BE21
      9E259F31BE39DE5AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F963E
      2E017001D211753EF85A5A6B7B739C739C779C737B735A6BF862944EF02D2C09
      CA00CA007542FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD615FF63FF67FF63
      FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63
      FF63FF63FF63FF63DF5FF521DE7BDE7BDE7BDE7BDE7BFF7F106B4B564F4E7352
      F75E5A6BBD77DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A25BC0C9E1D
      7F2EBF3AFF465F53BF5FFF6BFF6FFF6BBF635F531F47DF3EBF369F329F2E7F2E
      5F26DE1D1E11DC14FC3DDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F14227001
      D305963A5A6BBC77DE7BFF7FFF7FDE7BDE7BDE7BDE7BFF7FDE7BBD775A6BB656
      CF29EB00A900D125FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BD615FF63FF67FF63
      FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63
      FF63FF63FF63FF63DF5FF61DDE7BDE7BDE7BFF7FDE7BDB7FC86E5077E8728766
      685E4A524E4E724ED65A5A6B9C73DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDD0C7F151F26
      7F2EBF3AFF465F53BF5FFF6BFF6FFF6BBF635F531F47DF3EBF369F329F329F32
      7F2E3F26DF1D5E15DB10DE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F3522B201150E
      1A57BD7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FBD77
      3967323E0C05C900F129FF7FDE7BDE7BDE7BDE7BDE7BDE7BD615FF5FFF67FF63
      FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63
      FF63FF63FF63FF63DF5FD51DDE7BDE7BDE7BFF7FDE7BBA7BA76ADA7F927F4C7F
      2B7F0A7BE872A766685E4A564D4E714ED65A5A6B9C73DE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1D117F151F22
      7F2EBF3AFF465F53BF5FFF6BFF6FFF6B9F635F531F47DF3EBF36BF329F329F32
      7F2E3F26DF1D7F15FD10DE7BDE7BDE7BDE7BDE7BDE7BDE7BB83AD401360E7B67
      DE7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F
      DE7B7B6F74462C05A900753EDE7BDE7BDE7BDE7BDE7BDE7BD615FF5FFF67FF63
      FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63
      FF63FF63FF63FF63DF5FD519DE7BDE7BDE7BFF7FDE7BB97BA46A5277D77F6D7F
      6F7F6F7F6F7F6D7F4C7F2B7BE872C76A88624A564D52704EB55639679C73DE7B
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1D117F15FF21
      7F2EBF3AFF425F53BF5FFF6BFF6FFF6BBF635F531F47DF3EBF369F329F329F32
      7F2E3F26DF1D5F15FD10DE7BDE7BDE7BDE7BDE7BDE7B7D63D50137069D5FDE7B
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDE7B9C6F74420B01A9007C6BDE7BDE7BDE7BDE7BDE7BD615FF5FFF67FF63
      FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63
      FF63FF63FF63FF63DF5FD615DE7BDE7BDE7BFF7FDE7B977BC7720B73DA7F6F7F
      6E7F6F7F6F7F8F7F8F7F907F8F7F8F7F6D7F4B7B0A77C86E8762495A4C52504E
      93523967FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1D117F151F22
      7F2EBF3AFF3E3F4B9E5BFE63FE6BDE637E5B1E4BDE42BF36BF329F2E9F2E9F2E
      7F2E3F26DF1D7F15FD10DE7BDE7BDE7BDE7BDE7BFF7F370A37021A47177FB57A
      5A7FDE7BFF7F397F397FFF7F5A7F187FDE7F5A7F187FDE7F397F397F9C7F187F
      7B7FFF7FF776936AD029EA004D11FF7FDE7BDE7BDE7BDE7BD615FF5FFF67FF63
      FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63
      FF63FF63FF63FF63DF5FD615DE7BDE7BDE7BFF7FDE7B75770A77E872977BB37F
      8F7F8F7F8F7F8F7F8F7F8F7F8F7F907F907FB07FB07F8F7F8E7F6D7F2A77E86E
      6762304ABD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1D117F15DF21
      BE217E21BE2D1E3A9E52DE621E6BFE669E5A1E42BE315E253E1D3E193E195E1D
      7E1DDF21DF1D7F15FD10DE7BDE7BDE7BDE7BDE7B7D5F1802991AAD7122742274
      4374947EFE7F85748474DE7F6C7922745A7F4A7943745A7FE7786474527A0174
      6B79FF7FA574646C945A6E0DA9003B63DE7BDE7BDE7BDE7BD615FF5FFF67FF63
      FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63FF63
      FF63FF63FF63FF63DF5FD711DE7BDE7BDE7BFF7FDE7B53770B77097B3073D87F
      8F7FB07FB07FB07FB07FB07FB07FB07FB07FB07FB07FB07FB07FB17FB17FD17F
      2B7B49521863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFD101E15BE14
      9D10BE29BF425F5BDF6BFF73FF77FF73DF6B7F5B1F4BDF3EBF369F325F2EFE25
      3E1D9E107D0C1E151D11DE7BDE7BDE7BDE7BDE7BBA1E59025C53E7788574AD79
      2274AD79FE7F85748574FF7FCE792274397F2A7984749B7FE8788574527A2274
      8C79FF7FA6748574186F3332EB00D125DE7BDE7BDE7BDE7BD615FF5FFF63FF63
      FF63FF63FF63FF63FF63FF63FF63FF63FF63DE63DE63FF63FF63FF63FF63FF63
      FF63FF63FF63FF63DF5FD711DE7BDE7BDE7BFF7FDE7B51730B772C7FE96ED97F
      B17FB07FB07FB07FB07FB07FB07FB07FB07FB07FB07FB07FB07FB07FB07FB07F
      6F7FA86A514AFE7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDC10DD10BF21
      5F2EBF3AFF425F4F9F5FFF67FF6FFF6B9F5F5F531F47DF3EBF369F329F329F32
      9F2E3F261E11DC10FC10DE7BDE7BDE7BDE7BDF777A029A0EDE7BC678A674537A
      2274AE79DE7FA5748574FF7F107A2274737EE878A674BD7FE8788574527A2274
      8C79FF7FA67485745A77F7564E05EA00DE7BDE7BDE7BDE7BD615FF5FFF63FF63
      FF63FF63FF63FF63FF63FF63FF63FF63DE63DE5FDE5FDE63DE63DE63DF63FF63
      FF63FF63FF63FF63DF5FD711DE7BDE7BDE7BFF7FDE7B2F730C774E7FC7729577
      F57FB07FD17FD17FD17FD17FD17FD17FD17FD17FD17FD17FD17FD17FD17FB07F
      907F6D7B2B4E5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFD107F15FF21
      7F2EBF3AFF425F539F5FFF6BFF6FFF6BBF635F571F4BDF3EBF36BF329F329F32
      7F2E3F26DF1D7F151D11DE7BDE7BDE7BDE7B7D577A021C33FE7FC678A674327A
      2274AD79DE7B85748574FF7F527A227443744374E878DE7FE7788574527A2274
      8C79FF7FA67485749C7B5A6BD119CB003A5FDE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63FF63FF63FF63FF63DE63DE5FDE5FDE5FDE5FDE5FDE5FDE63DE63
      DE63DE63FF63FF63DF5FD711DE7BDE7BDE7BFF7FDE7B0E732D7B4E7FE97A0E73
      F97FD17FD27FD27FD27FD27FD27FD27FD27FD27FD27FD27FD27FD17FD27FD17F
      907FD47F8862734EFE7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1D117F15FF21
      7F2EBF3AFF425F4F9F5FFF6BFF6FFF6BBF635F571F4BDF3EBF369F329F329F32
      7F2E3F26DF1D7F151D11DE7BDE7BDE7BDE7BFC3E7A0A7D53FE7F85748574317A
      2274AD75BD7B85748574DE7F747A22744A7985740979FE7FE7788574737E2274
      8C79FF7FA67485749C7F9C73342E0C01753EDE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63FF63FF63DF63DE63DE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5F
      DE5FDE5FDE5FFF63DF5BB711DE7BDE7BDE7BFF7FDE7B0D732D7B2D7F2B7FC86E
      D97FF37FF27FF27FF27FF27FF27FF27FF27FF27FF27FF27FF27FF27FF27FF27F
      6F7FF87F4D772C4ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1D117F15FF21
      7F2EBF3AFF425F4F9F5FFF6BFF6FFF6BBF635F571F4BDF3EBF36BF329F329F32
      7F2E3F26DF1D7F151D11DE7BDE7BDE7BDE7BBB2E9A1A9E67FF7FEF79F0755276
      02748D75BC7785748574DE7BB57A2274107AA6784A79FF7FC7788574317A2274
      6C79FF7FA6748574BD7FBD77953E4E01D121DE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63FF63FF63DE63DE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5F
      DE5FDE5FDE5FFE63BF5BD611DE7BDE7BDE7BFF7FDE7B0C6F2E7B2D7F2D7FC772
      7477F77FF17FF27FF27FF27FF37FF37FF37FF37FF37FF37FF37FF37FF37FF27F
      6F7FF97FD57F685EB556FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B1D117F15FF21
      7F2EBF36FF423F4F9F5BDF67FF6BDF677F5B3F4FFF46BF3ABF369F329F329F32
      7F2E3F26DF1D7F151D11DE7BDE7BDE7BDE7BBB329A22BE6BDE7BFF7FDE7B0975
      017431769C7785748574BD7BD67A2274AD7985746C79FF7FE778437464744374
      D67EFF7FA6748574BD7FDE7BB7467001B019DE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63FE63DE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5F
      DE5FDE5FDE5FFE63BE57D615DE7BDE7BDE7BDE7BDE7BEB6E507F2D7F4D7F2B7B
      EB6EFB7FF97FF87FF77FF57FF47FF47FF47FF47FF47FF47FF47FF47FF47FF47F
      907FF87FFB7F0C732D4A7B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7B1D117F15FF21
      1F2AFE2DFE313E42BE561E6B5E735E6F1E639E521E3EBE2D7E257E257E219E25
      DF251F26DF1D7F151D11DE7BDE7BDE7BDE7BBB369A2ABE6FDE7B9C7BE8740174
      4B759C737B7385748574BC77187B43744A796474AE79FF7FE7746474E8784374
      737EFF7FA6748574BD7FDE7BD84A9101D119DE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63DE63DE63DE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5FDE5F
      DE5FDE5FDE5FFE637E4FF719DE7BDE7BDE7BDE7BFE7FEA6E717F4E7F4D7F6F7F
      2B77EA6E0E7351737577B87BD97FFB7FF87FF57FF67FF67FF67FF67FF67FF67F
      717FF97FFC7FB57F4856D65AFF7FDE7BDE7BDE7BDE7BDE7BDE7BFD101E15FE14
      3E21BE315F3EFF56BF6BFF73FF77FF77DF6F9F5F3F53DF429F367F321F2EDF29
      5E25FE18FE101E11FD10DE7BDE7BDE7BDE7BDB42BA2E9E67FF7F6B7901746C75
      7B739D735A73857485749C7739776374E8784374EF79FF7BC7748574737E2274
      6B79FE7FA6748574BD7FDE7BD8429201342ADE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63DE63DE5FDE5FDE5FDE5FDE5FBD5FBD5FBD5FBD5FBD5FBD5FBD5F
      BD5FBD5FDE5FDE637E4BF621DE7BDE7BDE7BDE7BDD7FEA6E927F6F7F6E7F6F7F
      907F6E7F6D7B4B772A770A730A730C6FB97BFC7FF77FF87FF87FF87FF87FF77F
      727FFB7FFC7FFD7FEB6E2F4ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDC10FD14BF21
      5F2EBF36FF425F4F9F5FFF67FF6FFF6BBF635F571F4BDF3EBF36BF329F329F32
      7F2E3F267E19DC10FC10DE7BDE7BDE7BDE7B3C5BBA2E7E5FFE7FC67485745276
      A674CF717B73857485747B775A778474A6744374317AFF7BC7748574727A2274
      6C79DE7BA67485749C7FDE7B97369201D846DE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63DE63DE5FDE5FDE5FDE5FDE5FBD5FBD5BBD5BBD5BBD5BBD5BBD5B
      BD5BBD5FBD5FDE633D43172ADE7BDE7BDE7BDE7BDB7BEA6E937F907F8F7F8F7F
      8F7F907FB07FB17FB17FB17FB07F8E7BE86E7677FE7FFC7FFC7FFB7FFA7FF97F
      717FFB7FFC7FFE7F957B29521863DE7BDE7BDE7BDE7BDE7BDE7BFD107F15FF21
      7F2EBF36FF423F4F9F5FFF67FF6FFF6BBF635F571F4BDF3EBF36BF329F329F32
      7F2E3F26DF1D7F15FD10DE7BDE7BDE7BDE7B9E6FBA363D4FFE7FE774A6741076
      01748C757B6F857485747B737B77A674647442747376DE77C7748574527A2274
      6B75BD77A67485749C7FDD77561E92017C67DE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63DE63DE5FDE5FDE5FDE5FDE5FBD5FBD5B9C5B9C5BBD5BBD5BBD5B
      BD5BBD5BBD5BDD63FD365736DE7BDE7BDE7BDE7BB97B0C73D57FB07FB07FB07F
      B07FB07FB07FB07FB07FB07FB17FD27FD17F09732F737577977BDA7BFC7FFD7F
      D97FFF7FDE7BDE7BFF7FCA6A524EDE7BDE7BDE7BDE7BDE7BDE7B1D117F15FF21
      7F2EBF36FF423F4F9F5BFF67FF6FFF6BBF635F571F4BDF3EBF36BF329F329F32
      7F2E3F26DF1D7F151D11DE7BDE7BDE7BDE7BFF7BDB3EFC3EBE7B2779C6743176
      22748D759C6FA57485747B739C73C674437443749476BD73C7748574737E2274
      6B75BD77A6748578BD7F9C67F505D305FF7FDE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63DE5FDE5FDE5FDE5FDE5FDE5FBD5FBD5B9C5B9C5B9C5B9C5B9C5B
      9C5B9C5BBD5BDD5F9C269846DE7BDE7BDE7BDE7B977B2F73F67FD17FD17FD17F
      D17FD17FD27FD17FD27FD27FD17FD17FF27FF37F8D7B4B772B730A730B730D73
      30737377B77BB87BDD7F52776D56FF7FDE7BDE7BDE7BDE7BDE7B1D117F15FF21
      7F2EBF36FF423F4F9F5FFF67FF6FFF6BBF635F571F4BDF3EBF36BF329F329F32
      7F2E3F26DF1D7F151D11DE7BDE7BDE7BDE7BDE7B3C57DB3A5C63897DA4742975
      22746C75107264744374EF717B6FE77443744274B5729C6FC674647429792274
      4A75317664744374107AD93AD401B836DE7BDE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FE63DE63DE5FDE5FDE5FDE5FBD5FBD5BBD5B9C5B9C579C579C579C57
      9C579C5B9C5B9D571B0E1A5FDE7BDE7BDE7BDE7B75775277F77FF27FF27FF27F
      F27FF27FF27FF27FF27FF27FF27FF27FF27FF37FF47FF47FF47FF37FF27FD07F
      8566905A5473527730732F739777DE7BDE7BDE7BDE7BDE7BDE7B1D117F15FF21
      7F2E9F32BF3A1E477E53DE5FDE67BE637E5BFE4EDE429F367F327F2A7F2A7F2A
      7F2A3F26DF1D7F151D11DE7BDE7BDE7BDE7BDE7BBE77DB421B4BB37A27796374
      C774B5722975A574A57408757B6F4B758574A674D76E7B6FE87485746474A674
      94764A75A674C6782965370AD501BE6FDE7BDE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63DE63DE5FDE5FDE5FDE5FBD5FBD5BBD5B9C5B7B577B535B537B57
      9B5B9B5B9B5BBD2ADA0DBE77DE7BDE7BDE7BDE7B987B5173FA7FF27FF37FF37F
      F37FF37FF37FF37FF27FF47FF57FF47FF37FF27FF27FF27FF27FF27FF37FF37F
      A866F75EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1D119F199E15
      9E1D9E259E2DDE3D7E56FE6A3F731F6FFF669F5A5F4EFF41BF357E2D3E211E19
      1E155E157E157F151D15DE7BDE7BDE7BDE7BDE7BDE7B1B53FC467E5BDD7F7B7F
      BD7BDE777B735A6F3A6F5A6F7B6F5A6F3A6F5A6F7B6F7B6F396F396F39737B73
      DE7BBD7BDE7FDE7FDA321702B92EDE7BDE7BDE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63DE63DE5FDE5FDE5FDE5FBD5FBD5B9C5B9C5B7B57F946F946F946
      FA42FA3EBC2E1C0A9746DE7BDE7BDE7BDE7BFF7FFF7F0C6FDA7FF47FF27FF37F
      F37FF37FF37FF27FFA7FDA7F967BD87FD87FF87FF77FF77FF67FF47FF37FF67F
      8962F75EFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFD149E251F3E
      BF52FF5A3F5F7F639F639F5F7F5F7F5F7F5B7F5B9F5F9F5F9F5F7F635F5F3F5B
      DF527F46DF315E1DFD14DE7BDE7BDE7BDE7BDE7BDE7BDE77FB4A1C47BF6BDE7B
      FF7FDE7BBD779C737C6F7B6F7B6F7B6B7B6B7B6B7B6B7B6F9C6F9C73BE77DE7B
      FF7FFF7FDE7B7D5759023802DF7BDE7BDE7BDE7BDE7BDE7BD615DF5FFF63FF63
      FF63FF63FF63DE63DE5FDE5FDE5FDE5FBD5FBD5B9C5B9C5B7B5719477C577C57
      5B535B531947D656DE7BDE7BDE7BDE7BDE7BFF7FDE7B75775277FB7FF37FF37F
      F27FF27FF17FFA7FDA7FCB6A4F772F730E730D730E7351737377957BD87FB87F
      88629B73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3D4A5F637F5B
      5F535F535F535F575F575F575F575F575F575F575F575F575F575F535F535F53
      5F533F4F3F53DF4ADD39DE7BDE7BDE7BDE7BDE7BDE7BDE7B7D6B1C4F1C4BBE6F
      DE7BFF7FFF7BDE7BBD779C739C737C6F7B6F7B6F7C6F9C73BD73BE77DE7BFF7F
      FF7FDE7B9E63790639027D5FDE7BDE7BDE7BDE7BDE7BDE7BD615DE5FFF63FF63
      FF63FF63FF63DE63DE5FDE5FDE5FDE5FBD5FBD5B9C5B9C5B7B57F9427C579C5B
      9C5B3953D656DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B0D739577D97BFA7F
      FB7FFA7FFB7FB97BC96AB97BDE7BDE7BDE7BFE7FDB7B977B73773173EE6A0D73
      5273DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5F5B1F471F47
      3F4B3F4F3F4F5F4F5F535F535F535F535F535F535F535F535F4F3F4F3F4F3F4B
      1F4B1F47FF42DF3E1F4BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5C631C531C4F
      9E6BDE7BDE7BFF7FFF7FDE7BDE7BBE77BD77BD77BE77DE7BDE7BFF7FFF7FFF7F
      DE7B7D5B7A165A023D4FDE7BDE7BDE7BDE7BDE7BDE7BDE7BD615DE5FFF63FF63
      FF63FF63FF63DE63DE5FDE5FDE5FDE5FBD5FBD5B9C5B9C577B57FA427C53BD5B
      184BF75ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDC7F51772F730E73
      0E7330735277EB6EDC7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7F5F7F32DF3A
      FF42FF421F471F471F4B1F4B3F4B3F4B3F4B1F4B1F4B1F4B1F471F47FF42FF42
      FF3EDF3EBF367F2E3F53DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5C671C53
      1C4F5D5FDF77DE7BDE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDF77
      1B479A1E7B0E5D53DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD615DE5FFF63FF63
      FF63FF63DF63DE63DE5FDE5FDE5FDE5FBD5FBD5B9C5B9C577B57FB3E9D57F74A
      1863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DD7FBA7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBF73DF46
      9F369F369F36BF36DF3ADF3EFF3EFF3EFF3EDF3EDF3ABF3ABF369F369F329F36
      9F367F369F3E7F67FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBE73
      3C573C533C537D5FBE73FF7FDE7BDE7BDE7BDE7BDE7BDE7BFF7FBE6F3C53BA32
      9B22BB269E6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD615DE5FFF63FF63
      FF63FF63DF63DE63DE5FDE5FDE5FDE5FBD5FBD5B9C5B9C5B5B4FDC36D6465A6B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7BDF77BF6F5F5FFF4EBF469F3E9F367F367F369F369F3EDF42FF4A3F5B9F6F
      DF77DF77FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7F5C631B531C4F1C4F3C535D577D5F7D637D5F5D5B3C4FFB42BA36BA2EBB2E
      3C53FF7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD615FF63FF67FF67
      FF67FF67FF63FF63FE63FE63FE63DE63DE63DD63BD5F5C4F7E1A16267B6FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BFF7B7D6B3C5B1B4F1C4BFC46FB46FB42DB3EDB3ADB3AFC467D63FF7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD611DE63DF5FDF5F
      DF5FDF5FDF5BBF5BBE577E4F7E4B3D43FD369C261B0EDB09F7219C73DE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BFF7FDF7B9E6F7D675C637D677D679E6FDF7BFF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1432F425F521D61D
      B515B611B611B60DB60DB611B615F61DF629573AD84E7C6BFF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B424D3E000000000000003E000000
      2800000080000000E00000000100010000000000000E00000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
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
      00000000000000000000000000000000FFFFFFFFFFFFFFFFCFFFFFFFFE800002
      FC00003FFE000071F0000005FE800002F800003FFEFFFF60E800004FFE9FE002
      E800001F00800100C0000001FE800002E800001F0080010080000000FE900002
      E800001F0000000080000000C01FE002E800001F0000000080000000FF9FFC02
      E800001F0000000080000000C0100002E800001F000000008000000040100002
      E800001F0000000080000000CF9FFF82E800001F0000000080000000C01FFFE2
      E800001F0000000080000000C0100002E800001F0000000080000000C0100002
      E800001F0000000080000000CF9FFFF2E800001F7000000E80000000C01FFFF2
      E800001F7000000E80000000C0100002E800001F7000000E80000000C0100002
      E800001F0000000080000000CF9FFF02E800001F00000000C07FFF01C0100002
      E800001F00800000E0000003C017FA06E800001F00800000FC6FF97FC817FA0F
      E800001FFE80007FDF4FF97BCF00021BE800001FFE80007FFF6FF96FC01FFE37
      E800001FFE80017FFF6FF97FC000006FE800001FFE80017FFF6FE97FCF8000FF
      E800001FFE80017FFF6FF97FCBFF01FFE800001FFE80017FFF6FE87FCA80027F
      E800001FFE80017FFF00087FCBFA07FFE800003FFE80017FFF7FF8FFC0000FFF
      E800003FFEFFFF7FFF0001FFCFFE1BFFF800003FFE00007FFF00037FC00037FF
      FE0000FFFFFFFFFFFFFFFEFF40007FFFFFFFFFF0C0800003FFFFFFFFF000000B
      FFFFFFE0C080000300000000F0000005FFFFFFC0C080000300000000F0000003
      FFFFFF80C080000300000000F02E8501FFFFFF01C080000300000000F0670041
      FFFFFE03C080000300000000F0ED0000FFFFFC07C080000300000000F0070000
      FFFFF80FC080000300000000F0FE0000FFFFF01FC080000300000000F0860000
      FFCFE03FC080000300000000F0FE0000FF87C07FC080000300000000F0FC0000
      FF8780FFC080000300000000F0FD0000E18601FFC080000300000000F0878001
      E08403FFC080000300000000F0FF8002C00007FFC080000300000000F0840005
      E0000FFFC080000300000000F0FFF00BE0001FFFC080000300000000F0842007
      F0001FFFC080400300000000F0FFFB0FF8007FFFC080000300000000F003240F
      000003FFC080000300000000F083FF0F000001FFC080440300000000F0830F0F
      000001FFC080240300000000F083FF0F000003FFC080000300000000F083010F
      F0003FFFC080000300000000F0FFFF0FE0001FFFC080000300000000F000000F
      E0000FFFC080000300000000F000000FC0000FFFC080000300000000F000000F
      E0040FFFC080000300000000F000000FE0860FFFC080000300000000F000000F
      FF87FFFFC080000300000000FFF81FFFFF87FFFFC080000300000000FFFBDFFF
      FF87FFFFC080000300000000F000000FFF0FFF1FFF80FFFFC0400000FFFFFFFF
      F80FFE0FFF80FFFF80200000FFFFFFFFF807FF07FF80FF83001FFF00FFFFFFFF
      FC07FE0FFF80F80300049100FFF00FFFFC0F300FFF80E00338000100FFC003FF
      F00C0007FF80C00338000100FF0000FFF0060C07FF80000338000100FF00007F
      F0070C07FF80000300000200FE78003FF00F0C07FF800003001FFE00FC7E001F
      F0070C03FF80000380200000F83F000FF0070C03FF80001FC0400000F01F800F
      F0010C03FF8000FFFFC00000E00FC00FF0000C03FF8001FFFFC00000C007E007
      F0000403FF8007FFFFC40000C003E007E0000001FF800FFFFFC400008001E007
      C0000001FF801FFFFFC4000000000000C0000000FF801FFFFFC4000000000000
      80040000FF803FFFFFC40000E007800180000001FF807FFFFFC40000E007C003
      80000001FF807FFFFFC40000E007E00380000001FF807FFFFFC00000F003F007
      80000003FF80FFFFFFC00000F001F80F80000003C00001FFFFC00000F000FC1F
      80000003E00003FFFFC00000F8007E3F80000007F00007FFFFC00000FC001E7F
      80000007F8000FFFFFC00000FE0000FFC004060FFC001FFFFFC00000FF0000FF
      C00E041FFE003FFFFFC00000FFC003FFC00E041FFF007FFFFFC00000FFF00FFF
      E00E0C1FFF80FFFFFFC00000FFFFFFFFF10E0C1FFFC1FFFFFFC00000FFFFFFFF
      FF0F0FFFFFE3FFFFFFC00000FFFFFFFFFC1FFFFFFFC0000380000040FFFFFC3F
      F00FFFFFFE00000100000000FFFFFC1FC007FFFFE000000100000000FFFFF81F
      C003FFFFC000000100000000FFFFF81F8001FFFF8000000100000000FFFFF81F
      8200FFFF8000000300000000E1FFF81F04007FFF800003FF00000000001F8000
      08007FFF800003FF000000000000000000007FFF800003FF0000000000000000
      0180FFFF800003FF00000000000000000100FFFFC00003FF0000000000000000
      0040FFFFC00003FF000000000000001F8009FFFFE00007FF000000000000001F
      C001FFFFE00007FF000000008800001FF000FFFFF0400FFF00000000C800001F
      F80C7FFFFC403FFF00000000E000001FFC3E3FFFFE001FFF00000000E000003F
      FFFF1FFFFF800FFF00000000C00000FFFFFF8F1FFFC00FFF00000000C00001FF
      FFFFC40FFFC00FFF00000000C00000FFFFFFE007FF8007FF00000000C00100FF
      FFFFF003FF0007FF00000000C00100FFFFFFE001FF0007FF00000000C000007F
      FFFFE000FE0007FF00000000E000007FFFFFE000FE0007FF00000000E000007F
      FFFFE000FE0007FF00000000F000007FFFFFE000FE0007FF00000000F804007F
      FFFFE000FE000FFF00000000FC1C00FFFFFFF000FE000FFF00000000FFFC00FF
      FFFFF801FE000FFF00000000FFFC00FFFFFFFC03FF000FFF00000000FFFC00FF
      FFFFFE07FF001FFF80000040FFFE03FFF0000007FFFFFFFFFFFE0007FFFFC3BF
      F0000007FFFFFFFFFFFE0007FFFFC00FF0000007FFFFFFFFFFFE0007FFFC000F
      F0000007FE1FFC1FFFF80007FFF8000FF0000007E7C7E7F7FFF00007FFF80001
      F0000007D81BF80FFFF00003FFF80001F00000076007E002FFE00003FFF80000
      F000000700024000FFC00003FFE01F01F000000780C18201FF800003FFE03F81
      F000000700018000FF000003FFE03F81F000000700000000FE000003FFE07F80
      F000000700000000FC000003FFF03F80F000000700000000F8000003FFF03F80
      F000000700000000F0000003FFF01F00F000000700C00000E0000003FFE00403
      F000000700000001E0000003F3100003F00000078007E000C0000003E0000003
      F000000747FFFFE2C0000003E0000003F0000007008FF001C0000027E0000007
      F0000007E2FFFF47C000003F0000007FF0000007F17FFE8FC000003F03E0B87F
      F0000007F89FFD1FC000003F07F07FFFF0000007F477FE2FC000003F87F07FFF
      F400000FFA1FF85FC000003F0FF07FFFF400005FFF0180FFE000007F07F0FFFF
      F400003FFF8181FFE000007F07F07FFFF400007FFF63EFFFF00000FF83E07FFF
      F40000FFFFDFF3FFF00000FFC0807FFFF40001FFFFF7FFFFF80001FFC003FFFF
      F40003FFFFFFFFFFFC0003FFC003FFFFF7FF07FFFFFFFFFFFE0007FFE803FFFF
      F0000FFFFFFFFFFFFF801FFFFC67FFFF00000000000000000000000000000000
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
      000000000000}
  end
  object DisabledImages: TImageList
    BlendColor = clMenu
    BkColor = 15790320
    Height = 32
    Width = 32
    Left = 408
    Top = 232
    Bitmap = {
      494C010118003000480020002000F0F0F000FF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000080000000E0000000010010000000000000E0
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B7B6F3146314631463146314631463146314631463146314631463146
      3146314631463146524A31463146DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7B3967
      9452945294529452945294529452945294529452945294529452945294529452
      94521863FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      B556945294529452945294529452945294529452945294529452945294529452
      9452B556DE7BDE7BDE7B7B6F524A524ADE7BDE7BDE7BDE7BDE7B524A524A524A
      524A524A524A524A524A524A524A524A524A524A524A524A524A524A524A524A
      524A524A524A524A524A524ADE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B7B6F3146D65AD65AD65AD65AD65AD65AD65AD65AB556B556B556B556
      B556B556B556B556B55694523146DE7BFF7FDE7BDE7BDE7BDE7BDE7B3967D65A
      D65AD65AD65AB556B556B556B556B556B556B556B556B556B556B556B556B556
      B5569452F75EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75E9452DE7BDE7B7B6F524A31469452734EDE7BDE7BDE7BDE7BDE7B524AF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75E1863D65A524ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B7B6F3146F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EB5563146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      734E734E734ED65AB556734E734E9452D65A9452734E734EB556D65A734E734E
      734EB5569452FF7FDE7BDE7BDE7BDE7BDE7BFF7FD65A524A524A524A524A3146
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EB5563146734E524A31469452D65AD65ADE7BDE7B5A6BB556734E734E524A
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75E524A734E9452734E5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B7B6F3146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75ED65AD65AB5563146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452B556
      945294521042B55694529452524A3146D65A9452B55610429452B55631463146
      3146B5569452FF7FDE7BDE7BDE7BDE7BDE7BD65A734EB556D65AD65AD65A3146
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EB556524A524A31469452D65A9452B556DE7B5A6B9452D65AD65AF75E734E
      524AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75E524A734ED65AD65AB55694525A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B7B6F3146F75E9452524A524A524A524A524A524A524A524A524A524A
      524A524A524A524AD65AB5563146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      9452734E524AD65AB5569452734E524AD65A94529452524A9452B55631463146
      3146B5569452DE7BDE7BDE7BDE7BDE7BDE7B9452D65AD65AD65AD65AD65A3146
      B556D65AB556B556B556B556B556B556B556B556B556B556B556B556B556B556
      D65A9452524A31469452D65A9452B5569452DE7BB556B556D65AD65AF75E9452
      3146524A524A524A524A524A524A524A524A524A524A524A524A524A524A524A
      524A524A3146734ED65AD65AB556B5569452DE7BDE7BFF7FFF7FFF7FFF7FFF7F
      FF7FFF7F7B6F3146F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EB5563146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452F75E
      F75EF75EF75EF75EF75ED65AD65AD65AF75ED65AD65AD65AF75EB5569452D65A
      734EB5569452FF7FDE7BDE7BDE7BDE7BDE7B9452D65AD65AD65AD65AD65A1042
      734E734E734E734E734E734E734E524A524A524A524A524A524A524A524A734E
      734E524A31469452D65A9452B556D65A9452DE7B9452B556D65AD65AD65AD65A
      734E734E734E734E734E734E734E734E734E734E734E734E734E734E734E734E
      734E734E734ED65AD65AD65AD65AB5569452DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B9C733146F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EB5563146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      734E734E734ED65AB556734E524A9452D65A9452524A524AB556B556B556D65A
      734EB5569452FF7FDE7BDE7BDE7BDE7BDE7BB556D65AD65AD65AD65AD65AD65A
      D65AD65AD65AD65AD65AB556524A524A9452B556B556B556B5569452524A524A
      9452524A9452D65A9452734ED65AD65AB556DE7B9452B556D65AD65AD65AD65A
      F75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AB5569452DE7BDE7B31463146314631463146
      31463146B5563146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75ED65AD65A3146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      945294521042B5569452B556524A3146D65A9452B55610429452D65A734E734E
      524AB5569452FF7FDE7BDE7BDE7BDE7BDE7BB556F75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EB556524A9452B556D65AD65AD65AF75ED65AD65AB5569452
      524A734EB5569452734E734EF75EF75EB556DE7B9452B556D65AD65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AB5569452FF7FDE7B31469452B55694529452
      9452B556734E3146F75E9452524A524A524A524A524A524A524A524A524A524A
      524A524A524A524AD65AD65A3146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      734E734E524AD65AB5569452734E734ED65A94529452524A9452D65A734E734E
      734EB5569452FF7FDE7BDE7BDE7BDE7BDE7BB556F75EF75EF75EF75EF75EF75E
      F75EF75EF75EB556524A9452B556F75EF75EF75EF75EF75EF75EF75EF75EB556
      9452524AB556F75EF75EF75EF75EF75EB556DE7B9452B556D65AD65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AB5569452DE7BDE7B3146F75E186318631863
      18631863D65A3146F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75ED65A3146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452F75E
      F75EF75EF75EF75EF75ED65AF75EF75EF75ED65AD65AD65AF75EF75ED65AD65A
      F75ED65A9452FF7FDE7BDE7BDE7BDE7BDE7BB556F75EF75EF75EB556524A524A
      524A524A524A524A945294529452B556B556D65AD65AD65AD65AB556B5569452
      94529452524A524AB556F75EF75EF75EB556DE7B9452D65AD65AD65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AB5569452DE7BDE7B3146D65AF75EF75EF75E
      F75EF75E94523146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75E1863D65A3146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      734E734E734ED65AB556734E524A9452F75E9452524A524AB556D65A734E524A
      734EB5569452FF7FDE7BDE7BDE7BDE7BDE7BD65AF75EF75EF75E734E94529452
      94529452734E734E9452B556B556D65AB556D65AD65AD65AD65AB556D65AB556
      B5569452734E734E734EF75EF75EF75ED65ADE7B9452D65AD65AD65AD65AD65A
      B556945294529452945294529452945294529452945294529452945294529452
      94529452B556D65AD65AD65AD65AB5569452DE7BDE7B3146D65AF75E3146524A
      524A524A31463146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75ED65A3146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      734E94521042D65AB556B556524A3146D65A734EB55610429452B556B556734E
      3146B5569452FF7FDE7BDE7BDE7BDE7BDE7BD65AF75EF75EF75E734EB5569452
      94529452734E734E9452B556B556B556945294529452945294529452B556B556
      B5569452734E734E734EF75EF75EF75ED65ADE7B9452D65AD65AD65AD65A9452
      9452945294529452945294529452945294529452945294529452945294529452
      9452945294529452D65AD65AD65AB5569452DE7BDE7B3146D65AF75EF75EF75E
      F75EF75E94523146F75E9452524A734E734E734E734E734E734E734E734E734E
      734E734E734E524AF75ED65A3146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      94529452524AD65AB5569452524A734EF75E94529452524AB556D65A9452734E
      734EB5569452FF7FDE7BDE7BDE7BDE7BDE7BD65AF75EF75EF75E734EB5569452
      94529452734E734E94529452B55694529452945294529452945294529452B556
      B5569452734E734E734EF75EF75EF75ED65ADE7BB556D65AD65AD65AB5569452
      9452945294529452945294529452945294529452945294529452945294529452
      9452945294529452B556D65AD65AB5569452DE7BDE7B3146D65A1863F75EF75E
      F75EF75ED65A3146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75E1863D65A3146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452F75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75ED65AF75EF75EF75ED65AD65A
      F75ED65A9452FF7FDE7BDE7BDE7BDE7BDE7BD65AF75EF75EF75E9452D65AD65A
      D65AD65A9452734E9452B556B556D65AD65AD65AD65AD65AD65AD65AD65AD65A
      B5569452734E94529452F75EF75EF75ED65ADE7BB556D65AD65AD65A9452734E
      9452945294529452945294529452945294529452945294529452945294529452
      9452945294529452B556D65AD65AB5569452DE7BDE7B3146D65AF75EF75EF75E
      F75EF75E94523146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75E1863D65A3146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      734E734E734ED65AB556734E524A9452F75E9452524A524AB556D65A734E524A
      734EB5569452FF7FDE7BDE7BDE7BDE7BDE7BD65AF75EF75EF75E9452D65AD65A
      D65AD65A9452734E9452B556D65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      B5569452734E94529452F75EF75EF75ED65ADE7BB556D65AD65AD65A9452734E
      9452734E734E734E734E734E734E734E734E734E734E734E734E734E734E734E
      734E734E9452734EB556D65AD65AB5569452DE7BDE7B3146D65AF75E3146524A
      524A524A31463146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75ED65A3146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      945294521042D65AB556945231463146F75E9452B55610429452B55694529452
      1042B5569452FF7FDE7BDE7BDE7BDE7BDE7BD65AF75EF75EF75E9452D65AD65A
      D65AD65A9452734E734EB556B556D65AD65AD65AD65AD65AD65AD65AD65AB556
      B556734E734E94529452F75EF75EF75ED65ADE7BB556D65AD65AD65A9452734E
      734E524A524A524A524A524A524A524A524A524A524A524A524A524A524A524A
      524A3146524A9452B556D65AD65AB5569452DE7BDE7B3146D65A1863F75EF75E
      F75EF75EB5563146F75EB556734E734E734E734E734E734E734E734E734E734E
      734E734E734E734EF75ED65A3146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      734E9452524AF75EB5569452734E734EF75E94529452524AB556D65A9452734E
      734ED65A9452FF7FDE7BDE7BDE7BDE7BDE7BD65AF75EF75EF75E9452D65AB556
      B556B556B556734E524A734E94529452B556B556B556B556B556D65AB5569452
      734E524A734EB5569452F75EF75EF75ED65ADE7B5A6B9452D65AB5569452734E
      734E9452D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65A9452734E734EB556D65AB55694525A6BDE7BDE7B3146D65A1863F75EF75E
      F75EF75ED65A3146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75ED65AB5563146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452F75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75ED65AD65A
      F75ED65A9452FF7FDE7BDE7BDE7BDE7BDE7BD65AF75EF75EF75E9452B556B556
      734E734E94529452524A524A524A9452B5569452B556B556B556B556B556734E
      524A524A9452B5569452F75EF75EF75ED65ADE7BDE7B5A6B9452B5569452734E
      734E9452F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75E9452734E734E9452B55694525A6BDE7BDE7BDE7B3146D65AF75EF75EF75E
      F75EF75E94523146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      D65A734E734E734E734E734E3146DE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      734E734E524AD65AB556734E524A734EF75E9452734E524AB556D65A94529452
      734ED65A9452FF7FDE7BDE7BDE7BDE7BDE7B3967D65AF75EF75E9452B556B556
      B556F75ED65AB556734E524A9452D65AD65AB556F75EF75ED65AD65AD65A9452
      524A734EB556B5569452F75EF75ED65A3967DE7BDE7BDE7B5A6B94529452734E
      734E9452F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      1863945294529452945294525A6BDE7BDE7BDE7BDE7B3146D65AF75E31463146
      3146314631463146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      D65A734ED65AF75EF75E3146DE7BDE7BFF7FDE7BDE7BDE7BFF7FDE7B9452D65A
      734E94521042F75EB556B556524A524AF75E945294521042B556F75EB556B556
      734ED65A9452FF7FDE7BDE7BDE7BDE7BDE7BFF7F3967D65AD65A945294529452
      D65AF75EF75ED65AB556734E524A9452B556B556D65AD65AD65AB5569452524A
      734EB556945294529452D65AD65A3967FF7FDE7BDE7BDE7BDE7BDE7BDE7BBD77
      BD779452F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      18639452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3146D65A1863F75EF75E
      F75EF75EB5563146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      D65A734EF75EF75E3146DE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B9452F75E
      D65AD65AD65AF75EF75ED65AD65AD65AF75ED65AB556D65AD65AF75ED65AD65A
      D65AD65AB556FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AF75EF75EF75ED65AB556734E3146524A734E734E734E734E524A3146734E
      B556B556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9452F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      18639452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3146D65A1863F75EF75E
      F75EF75ED65A3146F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E1863
      D65A734E18633146DE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BFF7FDE7B734E734E
      734E734E734E524A524A524A524A524A524A524A524A524A524A314631463146
      524A31463146FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AF75EF75EF75EF75ED65AB556B556734E524A31463146524A734EB556B556
      F75E9452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9452F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      18639452DE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7B3146D65AF75EF75EF75E
      F75EF75E734E3146F75EF75EF75EF75EF75EF75EF75EF75E1863F75E18631863
      F75E734E3146DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B524A524A
      734EB556945294529452945294529452945294529452945294529452734E734E
      9452524A3146FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AF75EF75EF75EF75EF75EF75ED65AB556D65AD65AD65AD65AB556D65AF75E
      F75EB556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9452F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      18639452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3146D65AF75E3146524A
      524A524A31463146B556945294529452945294529452945294529452B556B556
      94523146DE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B524A524A
      9452D65AD65AD65AD65AD65AB556B556B556B556B556B556B556945294529452
      9452524A524AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EB556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9452F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      18639452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3146D65A1863F75EF75E
      F75EF75EF75E3146314631463146314631463146314631463146314631463146
      3146DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B524A524A
      B556D65AB556B556B556B556B556B556B556B556B55694529452945294529452
      9452524A3146DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EB556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9452F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E1863
      18639452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3146D65A1863F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E734E945294529452B55631463146
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B524A524A
      B556F75EB556B556B556B556B556B556B556B556945294529452945294529452
      9452524A524ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EB556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9452F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75EF75E94529452
      94529452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3146D65A1863F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E734ED65AD65AF75ED65A3146DE7B
      FF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B524A524A
      B556F75ED65AD65AD65AD65AB556B556B556B556B556B556945294529452B556
      9452524A524AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EB556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9452F75E1863F75EF75EF75EF75EF75EF75EF75EF75EF75E18639452B556
      D65A9452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3146D65A1863F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E734ED65AF75EF75E3146DE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B524A524A
      B556F75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AB556B556B556B556
      9452524A3146DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EB556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B94521863186318631863186318631863186318631863186318639452D65A
      9452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3146D65A1863F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E734E1863F75E3146DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7BB556524A
      524A734E524A524A524A524A524A524A524A524A524A524A524A524A524A524A
      31463146B556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EB556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9452F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E94529452
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3146D65A1863F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E9452F75E3146DE7BDE7BFF7FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD77B556
      524A524A524A524A524A524A524A524A524A524A524A524A524A524A31463146
      3146B556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AB556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B94529452945294529452945294529452945294529452945294529452DE7B
      DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3146B556D65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AD65AD65A734E3146DE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      5A6B39675A6B3967396739673967396739673967396739673967396739671863
      1863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B31463146314631463146
      314631463146314631463146314631463146524ADE7BDE7BFF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7B5A6B524A524A5A6BDE7BDE7B18633146314631463146
      3146DE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294527B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E524A524A
      524A524A524A524A524A524A524A524A524A524A524A524A524A524A524A734E
      734E734E734E524A734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7B5A6B524A734E734E734EDE7BDE7B31463146314631463146
      3146DE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E
      734E734E734E734E734E734E734E734E734E734E734E734E734E734E734E734E
      734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B5A6B524A734E734E734E524ADE7BDE7B524A524A524A524A3146
      3146DE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E
      734E524A9452D65AD65AD65AD65AD65AD65AD65AD65AB556734E945294529452
      9452945294529452734E9452BD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B5A6B524A734E734E734E524A5A6BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E734E
      734EB556D65AF75ED65AF75EF75EF75EF75EF75ED65A734E734ED65AF75EF75E
      F75EF75EF75EF75E9452734E9452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B5A6B524A734E734E734E524A5A6BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E734E
      B556D65AF75EF75ED65A9452F75EF75EF75EF75E734E734E734E9452F75EF75E
      F75EF75EF75EF75E734E9452734EF75EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      5A6B524A734E734E734E524A5A6BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75EF75EF75EF75EF75ED65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75EF75EF75ED65AF75EF75EF75EF75EB556734E734E94529452D65AF75E
      9452F75EF75E945294529452734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B
      524A734E734E734E524A5A6BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E9452F75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AD65AD65AD65AD65A9452F75EF75EF75E9452734E9452945294529452F75E
      94529452F75E9452945294529452734E5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B524A
      734E734E734E524A5A6BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EDE7BF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75EF75EF75EF75EF75EF75EF75EF75E9452734E94529452945294529452
      F75EF75E94529452945294529452734E1863DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B524A734E
      734E734E524A5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75EF75EF75EF75EB556DE7BB556F75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75E9452945294529452F75EF75EF75E9452734E94529452945294529452
      F75EF75E94529452945294529452734E1863DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BBD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B524A734E734E
      734E524A5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75EF75EF75EF75E9452DE7B734EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75EF75EF75EF75EF75EF75EF75EF75EB556734E9452945294529452F75E
      F75EF75EF75E9452945294529452734E3967DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B1863734E524A7B6FDE7BDE7BDE7BDE7BDE7B5A6B524A734E734E734E
      524A5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75EF75EF75EF75EDE7BDE7BDE7BD65AF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75EF75EF75EF75EF75EF75E9452945294529452734E94529452B556F75E
      94529452F75E9452945294529452734E9C73DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E94529452B556DE7BDE7BDE7BDE7B5A6B524A734E734E734E524A
      5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75EF75EF75EB556DE7BDE7BDE7B9452F75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EB556734E734E9452F75E734E
      945294529452F75E734E9452734EB556FF7FDE7BDE7BDE7BFF7F186318639C73
      DE7BDE7B524A94529452D65ADE7BDE7BFF7F1863524A734E734E734E524A5A6B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75EF75EF75E734E734E734E734E734ED65AF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75E9452945294529452F75EF75EF75EF75EB556B556734EB556F75EB556
      B556B556B556F75E94529452734E9C73DE7BDE7BDE7BDE7B734E734E734E524A
      5A6BDE7B734E94529452D65ADE7BBD77734E734E734E734E734E524A5A6BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B9452945294529452945294529452D65A39679C739C735A6BF75E9452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75EF75EB556734E734E734E734E734E9452F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EB556B556B556F75EF75E
      F75EF75EF75EF75E9452734E3967DE7BDE7BDE7BDE7BFF7F524A945294529452
      734E7B6FD65A945294521863FF7F734E734E734E734E734E524A5A6BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B9452945294529452945294523967DE7B3967F75EF75EF75E5A6B9452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75ED65A734E734E734E734E734E734E734ED65AF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75E9452945294529452F75E9452945294529452F75E9452B5569452734E
      734E734E734E734E734E5A6BDE7BFF7FDE7BDE7BDE7BDE7B734E945294529452
      9452734E3967734E734EBD77D65A734E945294529452734E3967DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B945294529452945294523967BD77B556945294529452945294529452
      9452945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      F75E9452734E734E734E734E734E734E734E9452F75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75ED65AB556
      945294529452734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967734E94529452
      9452734ED65A524A94529C73734E9452B5569452734E9452DE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B9452945294529452B556FF7FD65A9452F75E3967B5569452F75E3967
      D65A945294529452945294529452DE7BDE7B734E734E734EF75EF75EF75EF75E
      B556734E734E734E734E9452B556734E734E734ED65AF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75E9452945294529452F75E9452945294529452F75E9452945294529452
      F75ED65A9452734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1863734E9452
      B556B556734E524A734E734EB556B5569452734E9452FF7FDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294521863BD7794521863DE7B7B6F7B6FF75EDE7BF75E
      BD77D65A94529452945294529452DE7BDE7B734E734E734EF75EF75EF75ED65A
      734E734E734E734EB556F75EF75E9452734E734E734EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E734E9452
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75ED65A9452734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F9452
      9452D65AD65AB556B556B556B556B556524A1863DE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294525A6B7B6F9452BD77BD7794529452BD77BD779452
      B556DE7B94529452945294529452DE7BDE7B734E734E734EF75EF75EF75E734E
      734E734E9452D65AF75EF75EF75EF75E734E734E734E9452F75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E734E734E734EDE7BDE7BDE7BDE7B734E94529452
      D65AF75EB556B556B556D65AB556F75EF75E10421042F75E10421042F75E1042
      F75ED65A94529452734EDE7BDE7BDE7BDE7B7B6FB556D65AB55618639C73FF7F
      B556B556F75ED65AD65AD65AB556734E5A6B1863B556524A734E524A1863DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294525A6B7B6F94527B6FDE7B945294525A6BDE7B9452
      9452BD77D65A9452945294529452DE7BDE7B945294529452F75EF75ED65AB556
      B556D65AF75EF75EF75EF75EF75EF75EF75E734E734E734EB556F75EF75EF75E
      F75EF75EF75EF75EF75EF75E945294529452DE7BDE7BDE7BDE7B734E94529452
      D65AF75EB556B556B556D65AB556F75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75ED65A94529452734EDE7BDE7BDE7BDE7B734E9452945294529452734E9452
      94529452D65AF75ED65AD65AB556524A734E94529452945294529452734EBD77
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294521863BD779452F75EDE7B186394521863DE7B9452
      9452BD77F75E9452945294529452DE7BDE7B945294529452F75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75E734E734E734ED65AF75EF75E
      F75EF75EF75EF75EF75EF75E945294529452DE7BDE7BDE7BDE7B734E94529452
      D65AF75EB556B556D65A94529452F75EF75E1042104210421042F75EF75EF75E
      F75ED65A94529452734EDE7BDE7BDE7BDE7B734E94529452945294529452524A
      734E9452F75EF75EF75ED65AB556524AB556734E9452945294529452734EFF7F
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A524A524A
      524ADE7B94529452945294529452FF7FB55694521863DE7B7B6F9C73DE7BF75E
      9452BD77F75E9452945294529452DE7BDE7B945294529452F75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E9452734E9452F75EF75E
      F75EF75EF75EF75EF75EF75E945294529452DE7BDE7BDE7BDE7B734E94529452
      D65AF75EB55694529452734E9452F75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75ED65A94529452734EDE7BDE7BDE7BDE7B5A6B734E524A734ED65A3967F75E
      734ED65AF75ED65AD65AF75ED65A9452D65A9C735A6B1863B556F75E9C73DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E524A524A524A
      524ADE7B9452945294529452945239677B6F94529452D65A5A6B7B6F5A6BB556
      D65AFF7F94529452945294529452DE7BDE7B945294529452F75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E9452734E9452F75E
      F75EF75EF75EF75EF75EF75E945294529452DE7BDE7BDE7BDE7B945294529452
      D65AF75EB5569452945294529452F75EF75E1042104210421042104210421042
      F75ED65A945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452734E
      B556F75EB55694529452B556D65AB5569452734E5A6BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E734E734E
      734EDE7B9452945294529452945294527B6F396794529452945294529452B556
      BD77186394529452945294529452DE7BDE7B945294529452F75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EB556734E9452
      F75EF75EF75EF75EF75EF75E945294529452DE7BDE7BDE7BDE7B94529452B556
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75ED65AB55694529452DE7BDE7BDE7BDE7BDE7BDE7BDE7BBD77734E94529452
      B556B556734EB556524AB5569452B55694529452734E5A6BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E734E734E
      734EDE7B94529452945294529452945294525A6BBD775A6BF75E18637B6FDE7B
      1863945294529452945294529452DE7BDE7B945294529452F75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75ED65A9452
      9452F75EF75EF75EF75EF75E945294529452DE7BDE7BDE7BDE7B94529452B556
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75ED65AB55694529452DE7BDE7BDE7BDE7BDE7BDE7BDE7BB55694529452B556
      9452734E7B6FB556734E9C73734E9452945294529452524ADE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E734E734E
      734EDE7B94529452945294529452945294529452B55618635A6B5A6B1863B556
      9452945294529452945294529452DE7BDE7B945294529452F75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      B5569452D65AF75EF75EF75E945294529452DE7BDE7BDE7BDE7B94529452B556
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75ED65AB55694529452DE7BDE7BDE7BDE7BDE7BDE7BDE7B524A945294529452
      9452D65ADE7B734E945218637B6F734E945294529452734E1863DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E734E734E
      734EDE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B945294529452F75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75ED65AD65AF75EF75E945294529452DE7BDE7BDE7BDE7B945294529452
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65A945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7B524A945294529452
      B556FF7F396794529452B556DE7B1863734E94529452734E3967DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E734E734E
      734EDE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B945294529452F75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E945294529452DE7BDE7BDE7BDE7B9452B5569452
      945294529452B556B556B556F75E9452945294529452F75EB556B556B5569452
      945294529452B5569452DE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B524A524AF75E
      FF7FDE7BF75E94529452524ADE7BDE7B1863734E524AB556FF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E734E734E
      734EDE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B945294529452F75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E945294529452DE7BDE7BDE7BDE7B945294529452
      945294529452945294529452F75EF75EF75EF75EF75EF75E9452945294529452
      94529452945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BB55694529452734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E734E734E
      734EDE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B9452945294529452945294529452
      9452945294529452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BF75EF75EF75EF75EF75EF75EDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BF75E94529452524ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E734E734E
      734EDE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294529452DE7BDE7B9452945294529452945294529452
      9452945294529452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BF75EDE7BDE7BDE7BDE7BF75EDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BBD77734E734E1863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967734E734E734E734E
      734EDE7B94529452945294529452945294529452945294529452945294529452
      9452945294529452945294527B6FDE7BDE7B9452945294529452945294529452
      9452945294529452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FF75EF75EF75EF75EF75EF75EFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B7B6F39675A6BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B7B6FDE7B7B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967B5569452D65A
      3967DE7BDE7BFF7F18639452734E734E734E734E734E734E734E734E734E734E
      734E734E734E734E734E734E94521863FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F
      3967B55694529452D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      1863734E734E94521863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9C73B5569452945294529452
      9452B5569C73DE7B3967734E734E734E734E734E734E734E734E734E734E734E
      734E734E734E734E734E734E734E734E1863DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452
      9452945294529452734E7B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BB556734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BBD779C73396739673967DE7BDE7BDE7BB55694529452945294529452
      94529452B556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BB556734E734E734E734E734E734E9452DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556
      9452945294529452F75E9C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BD65A1863D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BFF7F7B6F
      F75E734E734E734E734E734E734EDE7BDE7B3967B556BD77FF7FBD77B5569452
      945294529452945294527B6FDE7B7B6F7B6FDE7B7B6F7B6FDE7B7B6F9452DE7B
      DE7B1863734E734E734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B7B6F5A6B396739675A6B7B6FBD77DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD65A
      94529452945294521863DE7BDE7BDE7BDE7BBD779C73DE7BDE7BFF7F5A6B3967
      F75E734ED65A1863F75EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734EDE7BDE7BDE7BFF7F18639452734E
      734E734E734E734E734E734E734EDE7BDE7BB556BD77DE7BDE7BDE7BBD779452
      94529452945294529452B5569C73B556B5569C73B556B5569C73B55694525A6B
      DE7B7B6F734E734E734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7B3967D65AB556B556B556B556B556B556D65A3967BD77DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B18633967B556
      9452734E945294529C73DE7BDE7BBD779452B556734E18637B6FFF7F1863734E
      734E9452B556F75ED65AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734EDE7BDE7B5A6B9452734E734E734E
      734E734E734E734E734E734E734EDE7BDE7B9452FF7FDE7BDE7BDE7BFF7F9452
      945294529452945294529452945294529452945294529452945294529452D65A
      DE7BDE7B734E734E734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BFF7F1863734E9452B556D65AD65AD65AD65AD65AD65AD65AD65AB5561863
      BD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556734E734E
      734E734E734E734ED65A1863DE7BDE7B9C73734E945294525A6BDE7BDE7B9452
      734E9452B556B556D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734EFF7F1863734E734E734E734E734E
      734E734E734E734E734E734E734EDE7BDE7BD65ABD77DE7BDE7BDE7BBD779452
      9452945294529452945294529452945294529452945294529452945294525A6B
      DE7B7B6F734E734E734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B9C739C735A6B1863B556B556D65AD65AD65AD65AD65AD65AD65AD65A
      B5569C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1863D65A734E
      734E524A524A524A9452BD77DE7BDE7BDE7BF75ED65AD65ADE7BDE7BDE7BB556
      94529452734E734E9452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734EB556734E734E734E734E734E734E
      734E734E734E734E734E734E734EDE7BDE7B3967D65ABD77FF7FBD77D65A9452
      945294529452945294529452945294529452945294529452945294525A6BDE7B
      FF7F9452734E734E734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      9C73FF7FDE7BDE7BDE7BDE7BFF7F7B6FD65AB556D65AD65AD65AD65AD65AD65A
      D65AB5567B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6BF75E9452
      524A524A524A524A9452DE7BDE7BDE7BDE7B7B6F1863D65ADE7BDE7BDE7BB556
      734E734E524A734E734EBD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734E734E734E734E734E734E734E734E
      734E734E734E734E734E734E734EDE7BDE7BDE7BB55694529452945294529452
      94529452B556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      186394529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7B9C73
      94521863DE7BDE7BDE7BDE7BDE7BDE7BFF7FF75EB556D65AD65AD65AD65AD65A
      D65AD65A9452BD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967B556734E
      734E734E734E734E734E3967DE7BDE7BDE7B5A6BF75ED65ABD77DE7BDE7BB556
      734E524A734E734E734EB556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734E734E734E734E734E734E734E734E
      734E734E734E734E9452D65AD65ADE7BDE7BDE7B9C73B5569452945294529452
      9452B556BD77DE7B396794529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BBD77B556
      945294523967DE7BDE7BDE7BDE7BDE7BDE7BFF7FF75EB556D65AD65AD65AD65A
      D65AD65AB556D65AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75E734E734E
      734E734E734E734E734E1863DE7BDE7BDE7B3967D65AD65A7B6FDE7BDE7BB556
      734E734E734E734E734E94525A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734E734E734E734E734E734E734E734E
      734EB5565A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967D65AB556D65A
      3967DE7BDE7B3967945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BB5569452
      9452945294525A6BDE7BDE7BDE7BDE7BDE7BDE7BFF7FD65AB556B556B556B556
      B556B556B55694527B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75E94529452
      734E734E734E734E734EB556D65A7B6FDE7BF75EB556B5565A6BDE7BDE7BB556
      734E734E734E734E734E94525A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734E734E734E734E734E734E734EB556
      7B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B9452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BFF7FD65A94529452
      94529452945294527B6FDE7BDE7BDE7BDE7BDE7BDE7B9C739452B556B556B556
      B556B556B556B556D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B186394529452
      94529452734E734E734E734E734E9452DE7B734E734E734E7B6FDE7BDE7BB556
      734E524A524A524A524A734E5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734E734E734E734E734E734E1863FF7F
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B94529452D65AF75ED65A94529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BFF7FD65A734E94529452
      945294529452945294529C73DE7BDE7BDE7BDE7BDE7BDE7BF75EB556B556B556
      B556B556B556B556734EBD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BD65A94529452
      94529452734E734E734E734E734E734EB556945294529452B556DE7BDE7B9452
      734E314631463146524A524A5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734E734E734E734E734E7B6FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B94529452F75EF75EF75E94529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BF75E734E734E734E9452
      945294529452945294529452BD77DE7BDE7BDE7BDE7BDE7B5A6B9452B556B556
      B556B55694529452734E5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556B556B556
      94529452734E734E734E734EF75EF75EB55694529452734E9452F75ED65A734E
      734E524A3146524A524A524AD65AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734E734E734E734E7B6FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B94529452D65AF75ED65A94529452945294529452945294529452
      945294529452945294529452945294529452DE7B1863524A734E734E734E734E
      734E94529452945294529452B556DE7BDE7BDE7BDE7BDE7BBD77734E94529452
      9452945294529452734E1863DE7BDE7BDE7BDE7BDE7BDE7BB556F75ED65AB556
      B55694529452734E734E734E3967D65AD65A94529452734E734E9452734E734E
      734E734E524A524A524A524A524A1863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734E734E734E1863DE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B945294529452F75E945294529452945294529452945294529452
      9452945294529452945294529452945294523967524A524A524A734E734E734E
      734E9452945294529452734E734EB556DE7BDE7B7B6F9C735A6B734E94529452
      9452945294529452734EB5569C739C739C73DE7BDE7BB556734E1863D65AD65A
      B556945294529452734E9452DE7B5A6BB556524A524A524A734E734E734E524A
      734E734E524A524A524A734E734E9452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734E734EB556FF7FDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B945294529452F75E945294529452945294529452945294529452
      945294529452945294529452945294529452BD77BD77BD77D65A734E734E734E
      734E94529452945294529C73BD77BD77FF7FDE7B9452524A524A734E734E734E
      734E734E734E734E734E524A524A31463967DE7BDE7B734E734E3967D65AD65A
      B556B55694529452734E9452DE7B7B6F734E524A524A524A734EB556B556734E
      524A524A524A524A734E734E734E734EFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734E734E9C73DE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B945294529452F75E945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7B1863734E734E734E
      734E734E734E9452734EBD77DE7BDE7BDE7BDE7BDE7B9452734E734E734E734E
      734E734E734E734E734E734E524A3967DE7BDE7BFF7F524A734E734E734ED65A
      D65A9452734E734E734E9452DE7B186394529452524A734EB556D65AD65A9452
      524A524A524A524A734E734E94529452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734EB556DE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B94529452D65AF75ED65A94529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7B5A6B524A734E734E
      734E734E734E734E734E5A6BDE7BDE7BDE7BDE7BDE7BDE7B524A524A734E734E
      734E734E734E734E734E524AF75EDE7BDE7BDE7BBD77524A734E524A524A524A
      524A3146524A524A9452B556DE7BBD779452524A524A524A9452F75EB5569452
      734E524AB556B556945294529452D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734E5A6BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B94529452F75EF75EF75E94529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BBD77524A734E734E
      734E734E734E734E734EB556DE7BDE7BDE7BDE7BDE7BDE7B9C73524A524A524A
      524A524A524A524A524AD65AFF7FDE7BDE7BDE7B7B6F524A524A524A524A524A
      3146524A524A524A9452B5567B6F39679452734E734E734E524AB556B5569452
      B5569452D65AD65AB556B556B556FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B94529452D65AF75ED65A94529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BB556734E734E
      734E734E734E734E734E524A7B6FDE7BDE7BDE7BDE7BDE7BDE7B7B6F3146524A
      524A524A524A524AB556FF7FDE7BDE7BDE7BDE7B7B6F524A524A734E524A734E
      734E524A734E524A9452B556D65AD65A9452B556B556B5569452B556B556734E
      B5569452D65AD65AB556B5561863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B734E734E734E734E734E734E9452DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B9452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7B7B6F524A9452
      94529452945294529452734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B39673146
      524A524A524A734EDE7BDE7BDE7BDE7BDE7BDE7B3967524A524A524A734E734E
      734E3146734E524A524AD65AD65AD65A9452945294529452524AB556B556B556
      D65A9452B556B556B556B5565A6BDE7BDE7BDE7BDE7B1863734E734E734E734E
      734E734E734E734E734E734E734E734E734E734E734E734E734E734ED65AFF7F
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B9452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BB556734E
      945294529452945294529452734E9452DE7BDE7BDE7BDE7BDE7BDE7BDE7B1863
      3146524A734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75E524A524A734E734E734E
      9452524A734E734E9452D65AD65AD65AD65AD65AD65AB556734E9452B556B556
      94529452B556B556B556D65ADE7BDE7BDE7BDE7BDE7BDE7B1863734E734E734E
      734E734E734E734E734E734E734E734E734E734E734E734E734ED65AFF7FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B9452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7B524A
      9452945294529452945294529452734E734EBD77DE7BDE7BDE7BDE7BDE7BDE7B
      D65A3146BD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BD65A9452524A734EB5569452
      B556B556734ED65AB556D65AD65AF75EF75ED65AD65AB5569452734EB556B556
      9452B556B556D65A9452B556DE7BDE7BDE7BDE7BDE7BDE7BDE7B1863734E734E
      734E734E734E734E734E734E734E734E734E734E734E734ED65AFF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B9452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7B7B6F
      524A9452B556B556B556B556B556B5569452524A1863DE7BDE7BDE7BDE7BDE7B
      FF7F9C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD779452524A734EB5569452
      D65A9452F75EF75EB556F75EBD77F75EF75ED65AB556B5569452734E1863F75E
      B556B556D65AB556B556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1863734E
      734E734E734E734E734E734E734E734E734E734E734ED65AFF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B9452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      9C73734E9452B556B556B556B556B556B556B556734E524AB55618635A6B3967
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967F75E94529452D65A
      B556D65A9452B556D65A7B6FDE7BDE7BF75E9452D65A9452524AF75EDE7BDE7B
      B5569452B5567B6FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1863
      734E734E734E734E734E734E734E734E734E734ED65AFF7FDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B9452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BD65A734E9452B556D65AD65AD65AD65AD65AB5569452524A524A3967
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6FD65A9452734EB556
      DE7BD65A9452734EDE7BDE7BDE7BDE7BFF7F314694529452524ABD77DE7B9C73
      9452B556B5569C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      1863734E734E734E734E734E734E734E734ED65AFF7FDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B9452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BBD7718639452734E734E734E734E734E734EB5565A6BFF7FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452524A9452B556
      BD77B556734EB5569C73DE7BDE7BDE7BFF7F9452B5569452524ADE7BDE7BF75E
      B556B556734E3967DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B1863734E734E734E734E734E734ED65AFF7FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B9452945294529452945294529452945294529452945294529452
      945294529452945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B9C733967186318635A6B9C73FF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F524A524A9452
      BD77734E9452D65A7B6FDE7BDE7BDE7BFF7FB556D65A734E524ADE7BDE7B3967
      D65A9452524A5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B1863734E734E734E734ED65AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BB556945294529452945294529452945294529452945294529452
      94529452945294529452945294529452B556DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B94529452F75E
      DE7B734E734EB5563967DE7BDE7BDE7BFF7FB556B556524A9452DE7BDE7BDE7B
      F75EB5569452FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B1863734E734ED65AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B1863945294529452945294529452945294529452945294529452
      945294529452945294529452945294521863DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B9C73F75E1863FF7FDE7BDE7BDE7BDE7B5A6BB5569452DE7BDE7BDE7BDE7B
      DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7B1863D65AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BFF7F1863B5569452945294529452945294529452945294529452
      945294529452945294529452B5561863FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD77
      F75E734E734E1863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7B9C73734E734E734E734E734E734E734E9452734E734E734E
      734E734E734E734E734EB556BD77DE7BDE7BDE7B39679452734E734E734E734E
      734E734E734E734E734E734E734E734E734E734E734E734E734E734E734E734E
      94523967DE7BFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      5A6B5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967734E
      734E734E734E734E5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FFF7FFF7F5A6B524A524A524A734E734E734E734E734E734E734E734E734E
      734E734E734E524A524A524A734E9C73DE7B3967734E734E734E734E734E734E
      734E734E734E734E734E734E734E734E734E734E734E734E734E734E734E734E
      734E734E3967FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967
      B556B5561863FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F5A6B734E734E9452
      734E734E734E734E734E5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F9C733967D65A
      B55694529452734E734E94529452945294529452945294529452945294529452
      945294529452945294529452734E1863DE7BB556734E734E734E734E734E734E
      734E734E734E734E734E734E734E734E734E734E734E734E734E734E734E734E
      734E734EB556FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556
      945294529452BD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BF75EB5569452734EB556
      B556734E734E9452B556524A7B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD77B556734E734E734E
      734E734E734E734EB556B556B556B556B556B556B556B556B556B556B556B556
      B556B556B556B556B556B55694521863DE7B734E734E734E734E734E734E734E
      734E734E734E734E734E734E734E734E734EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      734E734E734EFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556
      9452945294529C73DE7BDE7BDE7BDE7BDE7BDE7BDE7B734ED65A94529452F75E
      F75E734E734E9452B556734E524A9C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B734E734E734E734E734E
      734E734E734E734E9452B556B556B556B556B556B556B556B556B556B556B556
      B556B556B556B556B556B556D65ABD77DE7B734E734E734E734E734E734E734E
      734E734E734E734E734E734E734E734E734EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      734E734E734EFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452
      9452945294529C73DE7BDE7BDE7BDE7BDE7BDE7B3967734E734E9452F75EF75E
      D65A734E734EB556B556734E734E524ABD77DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967734E734E734E734E734E
      734E734E94529452734E734E734E734E734E734E734E734E734E734ED65AF75E
      F75EF75EF75EF75EF75E3967FF7FDE7BDE7B734E734E734E734E734E734E734E
      734E734E734E734E734E734E734E734E734EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      734E734E734EFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BFF7FDE7BDE7BFF7F
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452
      945294529452BD77DE7BDE7BDE7BDE7BDE7BFF7F94529452B556F75EF75EF75E
      734E734EB556B5569452734E734E524A9452FF7FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B734E734E734E734E734E
      734E734E9452945294529452945294529452945294529452945294525A6BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E734E734E734E734E
      734E734E734E734E734E734E734E734E734EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      734E734E734EFF7FFF7FFF7FFF7FFF7FFF7FFF7F5A6BB556734E524A524A734E
      945218639C73FF7FDE7BDE7BDE7BDE7BDE7BDE7B7B6F18631863396718639452
      734E734E734EF75E3967396718635A6BFF7F3967734EB556F75EF75ED65A9452
      734EB556F75EB556734E9452734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F9452734E734E734E734E
      734E734E9452945294529452945294529452945294529452945294523967DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E734E734E734E734E
      734E734E734E734E734E734E734E734E734EFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FB556524A31463146524A524A524A
      524A524A734E94521863DE7BDE7BFF7FDE7B1863524A524A734E734E734E9452
      9452945294529452734E734E524A524AD65A9452734E734E9452B556734E734E
      B556F75EF75E945294529452734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD77B556734E734E734E734E
      734E734E945294529452945294529452734E9452B556B556945294525A6BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F734E734E31463146524A524A524A
      524A524AD65A524A524A734ED65AD65AB556524A524A734E734E734E734E9452
      945294529452734E734E734E734E524A734E524A734E734E734E734E734EB556
      F75EF75EB5569452B5569452734E734EB556FF7FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75E734E734E734E734E
      734E94529452945294529452B5569452524A734EB556B556945294527B6FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FD65AB556DE7BFF7FFF7FFF7FFF7FFF7F9452734E524A524A524A524A524A
      734EB556B556734E524A524A734EB556B556734E524A734E734E734E734E734E
      734E734E734E9452734E734E734E734EB5569452734E734E734E734EB556F75E
      F75EB556B556F75ED65A734E734E734E7B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B734E734E734E734E
      734E734E945294529452D65AB556734E524A9452B556B55694529452BD77DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F524A524AB556DE7BFF7FFF7FFF7FFF7FB556734E524A524A524A734EB556
      F75EB5569452B556524A524A9452B556B556B556734E734E734E734E734E734E
      734E734E734E9452B556B556B556D65ABD77BD7794529452B556B556D65AD65A
      9452B556F75EF75E9452B556B556B556FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452734E734E734E
      734E9452734E9452F75EF75ED65A734E734ED65AB55694529452B556FF7FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F734E524A524AB556FF7FFF7FFF7FFF7F1863734E524A524A734EF75EF75E
      D65A734E9452F75E734E524A9452B556B556B556B556B556D65AB556B556734E
      9452945294529C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BD65AB556B5569452734E
      9452D65AF75E9452D65AF75EB556BD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1863734E734E734E
      734E734E9452F75EF75EF75EB556524AD65AF75ED65A945294525A6BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      9452945294529452D65AF75ED65A94529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F734E734E734E734ED65ADE7BFF7FFF7F9C73524A524A524AB556F75EF75E
      B556734E9452F75E9452524AB556B556B556B556B556D65AB556945294529452
      9452945294529C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FF75E524A94529452
      B5569452734EB556F75ED65AB5561863FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FD65A734E734E
      734E734ED65AF75ED65A734E524A524A734EF75ED65A9452D65AFF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      9452945294529452F75EF75EF75E94529452FF7FFF7F9C739452734E734E734E
      734E734E734E734E734E734EF75EFF7FFF7FDE7BF75E524A734EF75EF75ED65A
      945294529452F75E734E734EB556B556B556B556B556B5569452734E94529452
      B556B55694529C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967734E734E
      734E734E734E9452B5569C73F75E94521863FF7FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F1863734E
      734E9452F75EF75E9452734E734E524A734EF75ED65AF75EDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      9452945294529452D65AF75ED65A94529452FF7FFF7FB556734E734E734E734E
      734E734E734E734E734E734E734E1863FF7FDE7BDE7B3967734EF75ED65AB556
      B55694529452186394529452B556B556B556B556B556D65A734E734E94529452
      B556B556B5569C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F524A
      734E734E734EF75EDE7BDE7BFF7FF75E94521863FF7FDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F
      9452B556F75EB5569452734E734E524A734EB5567B6FDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      94529452945294529452F75E945294529452FF7FFF7F734E734E734E734E734E
      734E734E734E734E734E734E734E734E3967DE7BDE7BDE7B7B6F734E524A9452
      B55694529452B5569452B556B556B556B556B556F75EF75E94529452D65A9452
      B556D65AB556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD77
      5A6B5A6BBD77DE7BDE7BDE7BDE7BFF7FF75E94521863FF7FDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7F5A6B1863B5569452734E734E94529452945294529C73DE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      94529452945294529452F75E945294529452FF7FFF7F734E734E734E734E734E
      734E734E734E734E734E734E734E734E3967DE7BDE7BDE7B3967524A734ED65A
      945294529452945294529452B556B556B556F75EF75E9452524AB556F75EB556
      B5563967DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F186394521863FF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BB55694529452B556B556945294529452B556FF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      94529452945294529452F75E945294529452FF7FFF7FB556734E734E734E734E
      734E734E734E734E734E734E734E1863FF7FDE7BDE7BFF7F9452524A734EB556
      B556B556B556B5569452524A9452B556F75EF75E9452734E524A734EF75ED65A
      9C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B186394521863FF7FDE7BDE7B
      DE7BDE7BBD77FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BF75E9452B556B556B556B556B556945294527B6FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      9452945294529452D65AF75ED65A94529452FF7FFF7F9C739452734E734E734E
      734E734E734E734E734E734EF75EFF7FFF7FDE7BDE7BBD77524A524A734E9452
      B556B556B556B556B556734E524AB556F75ED65A9452734E524A734ED65ABD77
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B186394521863FF7FBD77
      D65A524A3146524A3967DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B1863B556B556B556B556B556B556B556B5561863DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      9452945294529452F75EF75EF75E94529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F734E734E734E734EF75EDE7BFF7FFF7FDE7BDE7B9C73524A524A734E9452
      B556B556B556B556B5569452524A5A6B9C73D65A94529452945294529452F75E
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B18639452B556524A
      524A524A524A524A31465A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B9C73B556B556B556B556B556B556B556B556B556D65AFF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      9452945294529452D65AF75ED65A94529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F734E734E734ED65AFF7FFF7FFF7FFF7FDE7BDE7B9C73524A524A734E9452
      B556D65AD65AD65AD65A9452524A3967DE7B18639452B556B556B55694529452
      9C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75E94529452
      524A524A524A524A524A31467B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BBD779452B556B556B556B556B556B556B556B556B556B556FF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7F9452734ED65AFF7FFF7FFF7FFF7FFF7FDE7BDE7BBD77524A524A734E734E
      B556B556D65AD65AD65A9452524A5A6BDE7B5A6BB556B556B556B556B556B556
      1863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F9452524AB556
      9452524A524A524A524A524A524A9C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BF75E9452D65AB556B556B556B556D65AD65AB556B556B556DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FF75ED65ADE7BFF7FFF7FFF7FFF7FFF7FDE7BDE7BFF7F734E524A734E734E
      9452734E734E94529452734E734EDE7B9C73B556B556B556B556B556B556B556
      D65AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F3146524A524A
      B556734E524A524A524A524A734E9452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7F94529452B556B556B556B556D65AD65AD65AD65AD65AB556DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BF75E524A524A734E
      734E734E524A524A524A524A9452FF7FB556B556B556B556B556B556B556B556
      D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75E524A524A524A
      524A524A524A524A524A524A734E94523967DE7BDE7BDE7BDE7BDE7BDE7BDE7B
      BD77734E734E734E9452D65AB556D65AD65AD65AD65AD65AB556DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BBD77524A524A734E
      524A734E734E734E524A524A18639C73734EB556B556B556D65AD65AD65AD65A
      D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD65A524A524A524A
      524A524A524A524A524A734E734E9452D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7B
      9C73734E524A524A9452D65AB556B556D65AD65AB556B556D65AFF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      945294529452FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7B3967524A524A
      524A524A524A524A524AB556FF7F3967734E734E9452D65AD65AD65AD65AD65A
      D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B39673146524A524A
      524A524A524A524A9452734E94529452F75EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      7B6F524A524A524A734EB556D65AB556B556B556B556B556D65ADE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      945294529452FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7B5A6B734E
      524A524A524A734EF75EDE7BDE7BF75E524A524A9452D65AB556D65AB556B556
      D65AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B524A524A524A
      524A524A734EF75ED65AB556B55694527B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      7B6F524A524A524A524A734E9452B556B556B556B556B5561863DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      945294529452FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BFF7F
      9C737B6F9C73DE7BDE7BDE7BDE7BF75E524A524A734E9452B556B556B556B556
      F75EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD77734E524A
      524A524AB556D65AD65AF75ED65AD65AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      9C73524A524A734E734E734E524A524A524A3146734E9452F75EDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452945294529452945294529452
      945294529452945294529452945294529452FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      945294529452FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BF75E524A524A734E524A524A524A524A9452
      F75EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9452
      734E734E9452D65AF75EF75ED65ABD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B734E524A734E734E9452945294529452734E31463146D65ADE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556945294529452945294529452
      9452945294529452945294529452945294529452945294529452945294529452
      94529452B556FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B524A734E945294529452734E524A524A
      D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      D65A94529452B556B556F75EBD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B1863734E734E945294529452734E734E734E734ED65ABD77DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967945294529452945294529452
      9452945294529452945294529452945294529452945294529452945294529452
      945294523967FF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FF75EB556B5569452734E734EB5563967
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7F3967D65AD65A5A6BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BFF7F5A6B39671863D65AB5569452B55618639C73FF7FDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967B5569452945294529452
      9452945294529452945294529452945294529452945294529452945294529452
      B5563967DE7BFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FBD779C735A6B39677B6FBD77DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B104210421042
      1042104210421042104210421042104210421042104210421042104210421042
      104210421042104210421042DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F9452734E734E734E734E734E734E
      734E734E734E524A31461863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD77D65A9452BD77DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E1042DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F734E734E734E734E734E734E734E
      734E734E734E524A31461863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B734E734EB556BD77
      DE7B1863734EF75EFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E1042DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BBD771863734E734E734E734E734E734E734E
      734E734E734E524A31461863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7B9C737B6FFF7FBD779452734E734E734E734E
      734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E1042DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B5A6B734E3146524A734E734E734E734E734E734E
      734E734E734E524A31461863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B9C73734E734E734E734E734E734E734E734E734E
      734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E524A524A524A
      524A524A524AF75EF75E1042DE7BDE7BDE7BDE7BDE7BDE7BFF7FFF7FDE7BDE7B
      DE7BDE7BDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7B7B6F734E3146524A734E734E734E734E734E734E734E
      734E734E734E524A3146734EBD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B7B6F734E734E734E734E734E734E734E734E734E
      734E734E734E734ED65ADE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E524A524A524A
      524A524A524AF75EF75E1042DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B
      DE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD77
      9C737B6F9C73BD77FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BBD779452524A734E734E734E734E734E734E734E734E734E
      734E734E734E734E524A1042F75EFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BFF7F734E734E734E734E734E734E734E734E734E
      734E734E734E734E734E734E734EF75EDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E1042DE7BDE7BDE7BFF7FDE7BDE7B9C73F75E9452734E
      734E734E734EB5563967DE7BDE7BDE7BDE7BDE7BDE7BDE7B9C73D65A734E524A
      524A524A524A524A734E1863FF7FDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BD65A524A734E734E734E734E734E734E734E734E734E734E
      734E734E734E734E524A3146734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BBD77734E734E734E734E734E3967DE7BFF7FDE7B
      3967734E734E734E734E734E734E734EDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E1042DE7BDE7BDE7BFF7FDE7B18633146524A9452D65A
      D65AD65AB55694523146524A9C73DE7BDE7BDE7BDE7B39673146734ED65AF75E
      18631863F75ED65A94521042B556FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BFF7F1863524A524A734E734E734E734E734E734E734E734E734E734E
      734E734E734E734E734E3146734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BBD775A6B9452734E734E734E734EBD77DE7BDE7BDE7BDE7B
      DE7BBD77734E734E734E734E734E1863DE7BDE7BDE7BDE7BDE7B1042F75EF75E
      524A524AF75EF75E524A524A524A524A524A524A524A524A524AF75EF75E524A
      524A524A524AF75EF75E1042DE7BDE7BDE7BDE7B5A6B1042B556396739673967
      396739673967396739679452524ABD77DE7BDE7B9C733146D65A396739673967
      39673967396739673967F75E10421863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BF75E524A524A734E734E734E734E734E734E734E734E734E734E734E
      734E734E734E734E734E3146734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BD65A734E734E734E734E734E3967DE7BDE7BDE7BDE7BDE7B
      DE7BDE7B3967734E734E734E734EFF7FDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      524A524AF75EF75E524A524A524A524A524A524A524A524A524AF75EF75E524A
      524A524A524AF75EF75E1042DE7BDE7BDE7BFF7FB556734E3967186318631863
      186339673967186318633967734EF75EDE7BDE7BD65A734E3967186318633967
      3967186318631863186339679452734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B5A6B524A524A734E734E734E734E734E734E734E734E734E734E734E734E
      734E734E734E734E734E3146734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7B9452734E734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E1042DE7BDE7BDE7B7B6F734EB5561863186318631863
      186339673967186318633967D65A9452FF7FFF7F9452D65A3967186318633967
      396718631863186318631863D65A524AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      9C73B556734E734E734E734E734E734E734E734E734E734E734E734E734E734E
      734E734E734E734E734E3146734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BBD77B556734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BFF7F734E734E734E734EB556BD77DE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E1042DE7BDE7BDE7B3967734ED65A1863186318631863
      186339673967186318631863F75E734EDE7BDE7B734EF75E1863186318633967
      396739671863186318631863D65A3146DE7BDE7BDE7BDE7BDE7BDE7BDE7B1863
      1042B5569452734E734E734E94529452734E734E734E734E734E734E734E734E
      734E734E734E734E734E3146734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B734E734E734E734EDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B734E734E734E734E734E9452DE7BDE7BDE7BDE7B1042F75EF75E
      524A524AF75EF75E524A524A524A524A524A524A524A524A524AF75EF75E524A
      524A524A524AF75EF75E1042DE7BDE7BDE7B1863734ED65A1863186318631863
      3967396739673967186318631863734EDE7BDE7B734E18631863186318633967
      3967186318631863F75E1863F75E3146DE7BDE7BDE7BDE7BDE7BDE7B18631042
      524AD65A9452734E524A9452D65A9452734E734E734E734E734E734E734E734E
      734E734E734E734E734E3146734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BFF7F734E734E734E734E3967DE7BDE7BDE7BDE7BDE7B
      DE7BDE7B3967734E734E734E734E734ED65ADE7BDE7BDE7BDE7B1042F75EF75E
      524A524AF75EF75E524A524A524A524A524A524A524A524A524AF75EF75E524A
      524A524A524AF75EF75E1042DE7BDE7BDE7B734E3146D65A3967186318631863
      1863186339671863186318631863524A5A6B7B6F3146F75E3967186318633967
      396718631863186318633967B55610429452DE7BDE7BDE7BDE7B5A6B1042524A
      F75ED65A734E734E524A734ED65A734E734E734E734E734E734E734E734E734E
      734E734E734E734E734E3146734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7B1863734E734E734E734E9452BD77DE7BDE7BDE7BDE7B
      DE7BBD779452734E734E734E94525A6BBD77DE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E1042DE7BDE7BDE7B945231463146B556F75E39673967
      39673967396739671863F75E734E3146524A524A31463146B556F75E18633967
      3967396739671863D65A734E104210423967DE7BDE7BDE7BDE7B31463146F75E
      D65AB5569452734E524A734ED65A734E734E734E734E734E734E734E734E734E
      734E734E734E734E734E31469452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7B734E734E734E734E734E734E94525A6BDE7BDE7BDE7B
      5A6B9452734E734E734E734EBD77DE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E1042DE7BDE7BDE7BFF7FD65A1042524A3146524A734E
      94529452734E734E524A3146B5569C73BD77BD77BD773967734E3146524A524A
      524A524A524A31463146B5563146B556DE7BDE7BDE7BDE7B18631042B556F75E
      524AB556B5569452734EB556D65A734E734E734E94529452734E734E94529452
      734E734E94529452734E3146B556FF7FDE7BDE7BDE7BDE7BDE7BFF7FDE7BDE7B
      DE7B5A6BB5565A6BDE7BF75E734E734E734E734E734E734E734E734E734E734E
      734E734E734E734E734E734EFF7FDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      524A524AF75EF75E524A524A524A524A524A524A524A524A524AF75EF75E524A
      524A524A524AF75EF75E1042DE7BDE7BDE7BDE7BBD77524A18639C73F75ED65A
      B556B556B556D65A39679C73DE7BDE7BDE7BDE7BDE7BDE7BFF7FBD775A6B3967
      1863186339677B6FFF7F3967524ABD77FF7FDE7BDE7BFF7F3146524AF75E734E
      3146D65AD65AB556B556D65AB5569452734E734ED65AB556734E524AB556B556
      734E524AB556D65A9452524AB556FF7FDE7BDE7BDE7BDE7BDE7BB55694525A6B
      5A6B94529452D65AFF7FFF7FBD77DE7BF75E734E734E734E734E734E734E734E
      734E734E734E734E734E734E7B6FDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      524A524AF75EF75E524A524A524A524A524A524A524A524A524AF75EF75E524A
      524A524A524AF75EF75E1042DE7BDE7BDE7BFF7FDE7B39673146BD77DE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BBD7731463967DE7BFF7FDE7BDE7B9C7310429452D65A3146
      3146734E945294529452524AB5569452524A524AF75EB5569452524AB556D65A
      9452734EB556F75EB556734EF75EFF7FDE7BDE7BDE7BDE7BDE7B945294529452
      9452945294529452D65AF75E94523967DE7B734E734E734E734E734E734E734E
      734E734E734E734E734E94529C73DE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E1042DE7BDE7BDE7BFF7FFF7FFF7FB556734EFF7FFF7F
      FF7FDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F
      FF7FFF7FFF7FFF7F734EB556FF7FFF7FDE7BDE7BDE7B39671042B55694523146
      314631463146524A524A524AB5569452524A524AD65AD65AB5569452D65AF75E
      D65A945239679C7339673967BD77DE7BDE7BDE7BDE7BDE7B5A6B945294529452
      9452945294529452945294529452F75EDE7B734E734E734E734E734E734E734E
      734EB556BD77FF7F7B6F9C73DE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E1042DE7BDE7BDE7BDE7BDE7BDE7BDE7B524AD65ADE7B
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BFF7FDE7BD65A524ADE7BDE7BDE7BDE7BDE7BDE7BF75E1042B556734E3146
      3146524A524A524A524A524AB5569452524A524A9452B556D65AD65A9452524A
      945294525A6BDE7BDE7BDE7BDE7BDE7BDE7BFF7FB556B5569452945294525A6B
      DE7BFF7FDE7B5A6B9452945294525A6BFF7FF75E734E1863FF7FDE7BB556734E
      734E5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      524A524AF75EF75E524A524A524A524A524A524A524A524A524AF75EF75E524A
      524A524A524AF75EF75E1042DE7BDE7BDE7BDE7BDE7BDE7BDE7B9C7331461863
      DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDE7B186331469C73DE7BDE7BDE7BDE7BDE7BDE7BF75E31469452734E3146
      524A524A524A524A524A524AB5569452524A31469452524A524A524A524A3146
      3146524A3967DE7BDE7BDE7BDE7BDE7BDE7B7B6F9452945294529452BD77DE7B
      DE7BDE7BDE7BDE7BBD7794529452D65ADE7BDE7BDE7BDE7BDE7BDE7BBD779452
      D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      524A524AF75EF75E524A524A524A524A524A524A524A524A524A94529452524A
      524A524A524A9452B5561042DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B1042
      3967DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B396731467B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75E3146734E524A3146
      524A524A524A524A524A524AB5569452524A31469452524A524A524A524A3146
      3146734E3967DE7BDE7BDE7BDE7BDE7BDE7BDE7BF75E945294525A6BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7B5A6B945294529452F75EDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EB5561042104210421042
      104210421042104210421042DE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B3967
      10423967DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      F75E10425A6BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7B5A6B1042734E734E3146
      524A524A524A524A524A524AB5569452524A31469452524A524A524A524A3146
      524A734E7B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B94529452DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B945294529452B556DE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EB5561042D65AF75EF75E
      F75EF75EF75EF75E1042DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B
      39671042B556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD779452
      31467B6FDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD771042524A734E3146
      524A524A524A524A524A524AB5569452734E524A9452524A524A524A524A1042
      734E9452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD65A94529452DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BFF7F94529452D65ADE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      524A524AF75EF75E524A524A524A524A524A524A524AB5561042F75EF75EF75E
      F75EF75EF75E1042DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B7B6F524A3146D65A39677B6FFF7FDE7BDE7BFF7F5A6BF75EB55631469452
      BD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F734E3146524A524A
      524A524A524A524A524A524AD65AB5569452734EB556524A524A524A31463146
      D65AD65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BB556945294529452DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7B945294525A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      524A524AF75EF75E524A524A524A524A524A524A524AB5561042F75EF75EF75E
      F75EF75E1042DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B39679452524AB556DE7BDE7BDE7BFF7FF75E9452D65A7B6FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B1042524A524A
      3146524A524A524A524A524A9452D65AD65AB556734E524A524A524A10429452
      B5569C73DE7BDE7BDE7BDE7BDE7BDE7BDE7B18639452945294525A6BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7B5A6B94529452F75EDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EB5561042F75EF75EF75E
      F75E1042DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BFF7FDE7BDE7BDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BFF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F734E3146524A
      3146524A524A524A524A524A524A524A734E524A524A524A524A1042524AF75E
      D65AFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BD65A9452B556BD77DE7B
      DE7BDE7BDE7BDE7BBD77B5569452945294529C73DE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EB5561042F75EF75EF75E
      1042DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BBD7731463146
      524A31463146524A524A524A524A524A524A524A524A31461042524AF75EB556
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B94529452B5565A6B
      DE7BDE7BDE7B5A6BB55694529452D65AD65AFF7FDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EB5561042D65AF75E1042
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9C733146
      3146524A314631463146524A524A524A524A314610421042734EF75EB556BD77
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75E9452945294529452
      9452945294529452945294525A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EB5561042F75E1042DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B9C73
      734E3146524A524A314631463146314631463146734ED65AD65AD65ABD77DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6BB5561863D65A9452
      945294529452945294529452DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B1042F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EB55610421042DE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7F1863524A524A524A734E734E734E9452D65AD65AB5565A6BFF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FDE7BFF7FD65A
      9452B5565A6B7B6FB556B556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B104210421042
      1042104210421042104210421042104210421042104210421042DE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7B5A6BB556524A524A524A9452F75E7B6FDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B
      D65A5A6BDE7BDE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BFF7FBD773967D65A734E524A524A9452D65A3967BD77FF7FDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB5569452B556B556
      B556B556B556B556B556B556B556B556B556B556B556B556B556945294529452
      94529452945294529452F75EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7B5A6B9452314631463146314631463146314631463146314694525A6B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75ED65AD65ADE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F
      DE7BBD777B6F39673967186318631863F75EF75EF75EF75EF75E186339677B6F
      BD77DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      7B6F734E31463146524A734E734E9452945294529452734E524A314631463146
      734E7B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EB556DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F3967D65A
      B556B556B556D65AF75EF75EF75EF75EF75ED65AB556B5569452945294529452
      9452B556D65A7B6FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FF75E
      524A524A734E9452B556D65AD65AF75EF75EF75ED65AD65AB556B556734E524A
      31463146F75EFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EB556DE7BDE7BDE7BDE7BDE7BFF7F3967D65A18633967
      7B6FBD77DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556734E9452
      B556B556D65AD65AF75EF75EF75EF75EF75ED65AD65AB556B556B556B556B556
      94529452734E734E1863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556524A
      524A9452D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75ED65AB556
      734E314631469452FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EB556DE7BDE7BDE7BFF7FDE7BDE7B9452D65A94529452
      B556D65AF75E39677B6FBD77DE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75EF75ED65AD65AB556B556B556B556B556
      B55694529452734E734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7FB556524A734E
      D65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      D65A945231463146B556FF7FDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E9452DE7BDE7BDE7BFF7FDE7BBD779452F75ED65AB556
      B556B556B5569452B556D65AF75E39677B6FBD77DE7BFF7FDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75EF75ED65AD65AB556B556B556B556B556
      B556945294529452734EDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75E524A734ED65A
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75ED65A945231463146F75EDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E9452DE7BDE7BDE7BFF7FDE7BBD779452D65AF75ED65A
      D65AD65AD65AD65AB556B556B5569452B556D65AF75E18635A6B9C73DE7BFF7F
      FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75EF75ED65AD65AB556B556B556B556B556
      B55694529452734E734EDE7BDE7BDE7BDE7BDE7BDE7B7B6F734E734ED65AF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75E9452314631467B6FDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E9452DE7BDE7BDE7BFF7FDE7B9C739452B556F75ED65A
      D65AD65AD65AD65AD65AD65AD65AD65AD65AB556B5569452B556B556D65A1863
      5A6B9C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75ED65AD65AB556B556B556B556B556B556
      B55694529452734E734EDE7BDE7BDE7BDE7BDE7BFF7F734E734EB556D65AD65A
      F75EF75EF75ED65AD65AF75EF75ED65AF75EF75ED65AF75ED65AD65AF75ED65A
      F75EF75ED65AB556734E3146524AFF7FDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E9452DE7BDE7BDE7BFF7FDE7B7B6FB556B556D65AD65A
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AB556B5569452
      94521863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      945294529452B556B556D65AD65AD65AD65AB55694529452734E734E734E9452
      9452945294529452734EDE7BDE7BDE7BDE7BDE7B5A6B734E94529452524A524A
      524AB556F75E734E734EF75E9452524AF75E9452524AF75E734E734EB556524A
      9452F75E734E524AB556524A31465A6BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E9452DE7BDE7BDE7BFF7FDE7B5A6BB556B556B556F75E
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      B556B5569C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E
      734E9452B556D65AF75EF75EF75EF75EF75ED65AD65AB556B556B556B5569452
      734E734E734E734E734EDE7BDE7BDE7BDE7BFF7FB556734ED65A734E734E9452
      524A9452F75E734E734EF75E9452524AD65A9452734EF75E734E734EB556524A
      9452F75E734E734ED65A945231469452FF7FDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E734EDE7BDE7BDE7BFF7FDE7B3967B556D65AB556F75E
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AB5563967FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E734E9452
      B556B556B556D65AD65AF75EF75EF75ED65AD65AD65AB556B556B556B556B556
      B5569452734E734E734EDE7BDE7BDE7BDE7BBD77734E9452F75E734E734EB556
      524A9452F75E734E734EF75EB556524AB556734E734EF75E734E734EB556524A
      9452F75E734E734ED65AB556524A3146BD77DE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E9452DE7BDE7BDE7BFF7FDE7B3967B556D65A9452D65A
      F75ED65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AB556D65ABD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75EF75ED65AD65AB556B556B556B556B556
      B556945294529452734EDE7BDE7BDE7BDE7B5A6B734EB556F75E734E734EB556
      524A9452F75E734E734EF75EB556524A734E524A734EF75E734E734EB556524A
      9452F75E734E734EF75ED65A734E31465A6BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75E9452DE7BDE7BDE7BFF7FDE7B1863B556D65AB556B556
      F75ED65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AF75EB5563967FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75EF75ED65AD65AB556B556B556B556B556
      B556945294529452734EDE7BDE7BDE7BDE7BF75E9452D65AF75E734E734EB556
      524A9452F75E734E734EF75EB556524A9452734E9452F75E734E734EB556524A
      9452F75E734E734EF75EF75E94523146F75EDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75ED65A9452DE7BDE7BDE7BFF7FDE7BF75EB556D65AB5569452
      F75ED65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AF75EB556F75EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75EF75ED65AD65AB556B556B556B556B556
      B556945294529452734EDE7BDE7BDE7BDE7BB5569452F75EF75EB556B556B556
      524A9452F75E734E734EF75ED65A524AB556734E9452F75E734E734EB556524A
      9452F75E734E734EF75EF75E9452524A9452DE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75ED65A9452DE7BDE7BDE7BDE7BDE7BF75EB556B556B5569452
      D65AF75ED65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AF75EF75EB5565A6BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75ED65AD65AB556B556B556B556B556B556
      B556945294529452734EDE7BDE7BDE7BDE7BB5569452F75EF75EF75EF75E734E
      524AB556F75E734E734EF75ED65A524A9452734E9452F75E734E734E734E524A
      D65AF75E734E734EF75EF75EB556524A734EDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75ED65A9452DE7BDE7BDE7BDE7BDE7BD65AD65AD65AB556B556
      B556F75EF75EF75EF75EF75EF75ED65AD65AF75EF75EF75EF75EF75EF75ED65A
      D65AF75EF75EB556F75EDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      945294529452B556D65AD65AF75EF75ED65AB556B55694529452945294529452
      9452945294529452734EDE7BDE7BDE7BDE7BB5569452F75EF75EF75E734E524A
      9452F75ED65A734E734EF75ED65A524A9452734E9452F75E734E734E734E524A
      B556F75E734E734EF75EF75EB556524A734EDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AF75EF75ED65AB556DE7BDE7BDE7BDE7BFF7FD65AD65AD65AD65AD65A
      B556B556B556D65AD65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      D65AF75EF75ED65AB5567B6FFF7FDE7BDE7BDE7BDE7BDE7BDE7B734E734E734E
      94529452B556D65AF75EF75EF75EF75EF75ED65AD65AB556B556B55694529452
      9452734E734E734E734EDE7BDE7BDE7BDE7BD65A9452F75EF75E9452524A9452
      D65AF75ED65A734E734EF75ED65A734E734E734EB556F75E734E734EB556524A
      9452F75E734E734EF75EF75EB556524AB556DE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AD65AF75ED65AB556DE7BDE7BDE7BDE7BDE7BB556D65AD65AD65AD65A
      D65AD65AB556B556B556B556B556B556F75EF75EF75EF75EF75EF75EF75EF75E
      D65AF75EF75EF75EB5561863FF7FDE7BDE7BDE7BDE7BDE7BDE7B734E734E9452
      B556B556B556D65AD65AF75EF75EF75EF75ED65AD65AB556B556B556B556B556
      B55694529452734E734EDE7BDE7BDE7BDE7B18639452D65AF75E734E734EB556
      734E9452D65A734E734EF75ED65A734E734E524AB556F75E734E734EB556524A
      9452F75E734E734EF75EF75E9452524A1863DE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AD65AF75EB556D65ADE7BDE7BDE7BDE7BDE7BB556D65AD65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AD65A9452D65AF75EF75EF75EF75EF75EF75E
      D65AF75EF75EF75ED65AB5569C73DE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75EF75ED65AD65AB556B556B556B556B556
      B556945294529452734EDE7BDE7BDE7BDE7B7B6FB556D65AF75E734E734EB556
      524A9452D65A734E734ED65AF75E734E734E524AB556F75E734E734EB556524A
      9452F75E734E734EF75EF75E9452524A7B6FDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AD65AF75EB5561863DE7BDE7BDE7BDE7BBD77B556F75ED65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AD65AD65AB556B556D65AD65AF75EF75EF75E
      F75E1863186318631863B5563967FF7FDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75EF75ED65AD65AB556B556B556B556B556
      B556945294529452734EDE7BDE7BDE7BDE7BDE7BB556B556F75E734E734EB556
      524A9452F75E734E734ED65AF75E734E734E524AB556F75E734E734EB556524A
      9452F75E734E734EF75ED65A734E734EDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AD65AD65A94523967DE7BDE7BDE7BDE7B9C73B556F75ED65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AB556B556B556B556B556
      B556D65AD65AF75EF75ED65AF75EFF7FDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75EF75ED65AD65AB556B556B556B556B556
      B556945294529452734EDE7BDE7BDE7BDE7BDE7B1863B556D65A9452734E9452
      524A9452B556734E734E9452D65A734E524A524AB556F75E734E734E9452524A
      9452B556734E734EB556B556524AF75EDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AD65AD65A734E9C73DE7BDE7BDE7BDE7B9C73D65AF75ED65AD65AD65A
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AF75EF75EF75ED65AD65AD65A
      945239677B6F39671863F75E9C73DE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      B556B556B556D65AD65AF75EF75EF75ED65AD65AB556B556B556B556B556B556
      B556945294529452734EDE7BDE7BDE7BDE7BDE7B9C73B556B556B556734E734E
      734EB5569452734E734E734ED65A9452734E734ED65AD65A734E734E734E734E
      B5569452734E734E734E734E734E9C73DE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AD65AB5569452DE7BDE7BDE7BDE7BDE7B9C73D65AF75ED65AF75ED65A
      D65AD65AD65AF75ED65AF75EF75EF75EF75ED65AD65AD65AD65AD65AF75ED65A
      94527B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E94529452
      945294529452B556B556D65AF75ED65AD65AD65AB556B556945294529452734E
      734E734E94529452734EDE7BDE7BDE7BDE7BDE7BFF7FF75EB556D65AF75EF75E
      F75EF75ED65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AF75E
      F75EF75EF75EF75EB556734ED65AFF7FDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AB556B556B556
      B556B556B556734E3967DE7BDE7BDE7BDE7BFF7FFF7FD65AF75EF75ED65AD65A
      D65AD65AF75ED65AF75EF75ED65AF75EF75EF75EF75EF75EF75EF75EF75EF75E
      B5567B6FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734E9452B556
      D65AD65AD65AD65AF75ED65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AB55694529452734EDE7BDE7BDE7BDE7BDE7BDE7BBD77B556B556F75EF75E
      F75EF75EF75EF75ED65AD65AD65AD65AD65AD65AD65AD65AD65AF75EF75EF75E
      F75EF75EF75ED65A734E734EBD77DE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AB556D65AD65A
      D65AD65AB5563967DE7BDE7BDE7BDE7BDE7BFF7FDE7B9C73D65AF75EF75EF75E
      D65AD65AD65AF75EF75EB55639671863F75ED65AB556B556D65AD65AF75EF75E
      9452BD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BB556D65AD65A
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AD65AD65AB556DE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6BB556B556F75E
      F75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AF75EF75EF75EF75EF75E
      F75EF75ED65A734E734E5A6BDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AB556D65AD65A
      D65AD65A5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75ED65AF75EF75E
      F75EF75EF75EF75EB556BD77DE7BDE7BDE7BFF7FDE7B9C737B6F3967F75ED65A
      5A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75ED65AD65A
      D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65A
      D65AD65AB556B556F75EDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F1863D65AD65A
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75ED65A9452734E3967DE7BDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AB556D65AD65A
      B5565A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B5A6B1863F75E
      D65AD65AD65AD65ADE7BDE7BFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6FD65AB556
      B556D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AD65AB556
      B556B556B556B5565A6BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BFF7F3967D65A
      D65AD65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      B556945294523967DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AB556D65AD65A
      9C73DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FBD77DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B3967
      F75ED65AD65AB556B556B556B556B556B556B556B556B556B556B556B556D65A
      D65AD65A1863BD77FF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B7B6F
      D65AD65AD65AD65AF75EF75EF75EF75EF75EF75EF75EF75EF75EF75ED65AB556
      9452B5567B6FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75ED65AD65AD65AD65AD65AD65AB556D65A9C73
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      FF7FDE7BDE7B9C735A6B39671863F75EF75EF75EF75E186339675A6B7B6FBD77
      DE7BFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7B1863D65AD65AD65AD65AD65AD65AD65AD65AD65AD65AB556B55694529452
      1863DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75ED65AD65A9452B556BD77DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BBD773967F75EB556B556B556B556B556B556B556B556D65A3967DE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B734EF75EF75EF75E
      F75EF75ED65AD65AD65AD65AD65AB556B5569452734E734ED65ADE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BFF7FBD777B6F3967396739675A6B7B6FBD77FF7FDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BF75ED65AB556B556
      9452945294529452945294529452B556D65A18635A6BBD77FF7FDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      DE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7BDE7B424D3E000000000000003E000000
      2800000080000000E00000000100010000000000000E00000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
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
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFF800002
      FC00003FFE000071F0000005FF800002F800003FFE000060E800000FFF800002
      E800001F00000000C0000001FF800002E800001F0000000080000000FF800002
      E800003F0000000080000000C0000002E800001F0000000080000000FF800002
      E800001F0000000080000000C0000002E800001F000000008000000040000002
      E800001F0000000080000000C0000002E800001F0000000080000000C0000002
      E800001F0000000080000000C0000002E800001F0000000080000000C0000002
      E800001F0000000080000000C0000002E800001F0000000080000000C0000002
      E800001F0000000080000000C0000002E800001F0000000080000000C0000002
      E800001F0000000080000000C0000002E800001F00000000C0000001C0000002
      E800001F00000000E0000003C0000006E800001F00000000FC00007FC000000F
      E800001FFE00007FFF00007FC000001BE800001FFE00007FFF00006FC000003F
      E800001FFE00007FFF00007FC000006FE800001FFE00007FFF00007FC00000FF
      E800003FFE00007FFF00007FC00001FFE800003FFE00007FFF00007FC000027F
      E800001FFE00007FFF00007FC00007FFE800003FFE00007FFF0000FFC0000FFF
      E800003FFE00007FFF0001FFC0001BFFF800003FFE00007FFF00037FC0003FFF
      FE0000FFFFFFFFFFFFFFFEFF40006FFFFFFFFFF0C0800003FFFFFFFFF000000F
      FFFFFFE0C0800003FFFFFFFFF0000007FFFFFFC0C0800003FFFFFFFFF0000003
      FFFFFF80C080000300000000F0000001FFFFFF01C080000300000000F0000001
      FFFFFE03C080000300000000F0000000FFFFFC07C080000300000000F0000000
      FFFFF80FC080000300080000F0000000FFFFF01FC080000300080000F0000000
      FFCFE03FC080000300080000F0000000FF87C07FC0800003001C0000F0000000
      FF8780FFC0800003001C0000F0000000E18601FFC080000300000000F0000001
      E08403FFC080000300000000F0000003C00007FFC080000300000000F0000005
      E0000FFFC080000300000000F000000FE0001FFFC080000300000000F000000F
      F0001FFFC080400300000000F000000FF8007FFFC080000300000000F000000F
      000003FFC080000300000000F000000F000001FFC080440300000000F000000F
      000001FFC080240300000000F000000F000003FFC080000300000000F000000F
      F0003FFFC080000300000000F000000FE0001FFFC080000300000000F000000F
      E0000FFFC080000300000000F000000FC0000FFFC080000300000000F000000F
      E0040FFFC080000300000000F000000FE0860FFFC080000300000000F000000F
      FF87FFFFC080000300000000FFF81FFFFF87FFFFC080000300000000FFFBDFFF
      FF87FFFFC080000300000000F000000FFF0FFF1FFF80FFFFC0400000FFFFFFFF
      FC0FFE0FFF80FFFF80200000FFFFFFFFF807FF07FF80FF83001FFF00FFFFFFFF
      FC07FE0FFF80F80300049100FFF00FFFFC0F300FFF80E00338000100FFC003FF
      F00C0007FF80C00338000100FF0000FFF0060C07FF80000338000100FF00007F
      F0070C07FF80000300000200FE78003FF00F0C07FF800003001FFE00FC7E001F
      F0070C03FF80000380200000F83F000FF0070C03FF80001FC0400000F01F800F
      F0010C03FF8000FFFFC00000E00FC00FF0000C03FF8001FFFFC00000C007E007
      F0000403FF8007FFFFC00000C003E007E0000001FF800FFFFFC000008001E007
      C0000001FF801FFFFFC0000000000000C0000001FF801FFFFFC0000000000000
      C0040000FF803FFFFFC00000E007800180000001FF807FFFFFC00000E007C003
      80000001FF807FFFFFC00000E007E00380000001FF807FFFFFC00000F003F007
      80000003FF80FFFFFFC00000F001F80F80000003C00001FFFFC00000F800FC1F
      80000003E00003FFFFC00000F8007E3F80000007F00007FFFFC00000FC001E7F
      80000007F8000FFFFFC00000FE0000FFC004060FFC001FFFFFC00000FF0000FF
      C00E041FFE003FFFFFC00000FFC003FFE00E041FFF007FFFFFC00000FFF00FFF
      E00E0C1FFF80FFFFFFC00000FFFFFFFFF10E0C1FFFC1FFFFFFC00000FFFFFFFF
      FF0F0F7FFFE3FFFFFFC00000FFFFFFFFFC1FFFFFFFC0000380000040FFFFFC3F
      F00FFFFFFE00000100000000FFFFFC1FC007FFFFE000000100000000FFFFF81F
      C003FFFFC000000100000000FFFFF81F8001FFFF8000000100000000FFFFF81F
      8000FFFF8000000300000000E1FFF81F00007FFF800003FF00000000001F8000
      00007FFF800003FF000000000004000000007FFF800003FF0000000000000000
      00007FFF800003FF00000000000000000000FFFFC00003FF0000000000000000
      0000FFFFC00003FF000000000000001F8001FFFFE00007FF000000040000001F
      C000FFFFE00007FF000000008000001FF0007FFFF0000FFF00000000C000001F
      F8083FFFFC003FFF00000000E000001FFC3C1FFFFE001FFF00000000E000003F
      FFFE0FFFFF800FFF00000000C00000FFFFFF871FFFC00FFF00000000C00001FF
      FFFFC00FFFC00FFF00000004C00000FFFFFFE007FF8007FF00000000C00100FF
      FFFFF003FF0007FF00000000C00100FFFFFFE001FF0007FF00000000C000007F
      FFFFE000FE0007FF00000000E000007FFFFFE000FE0007FF00000000E000007F
      FFFFE000FE0007FF00000000F000007FFFFFE000FE000FFF00000000F804007F
      FFFFE000FE000FFF00000000FC1C00FFFFFFF000FE000FFF00000000FFFC00FF
      FFFFF801FE000FFF00000000FFFC00FFFFFFFC03FF000FFF00000000FFFC00FF
      FFFFFE07FF001FFF80000040FFFE03FFF0000007FFFFFFFFFFFE0007FFFFC3BF
      F0000007FFFFFFFFFFFE0007FFFFC00FF0000007FFFFFFFFFFFC0007FFFC000F
      F0000007FFFFFFFFFFF80007FFF8000FF0000007E7EFEFF7FFF00003FFF80001
      F0000007F83FF80FFFE00001FFF80001F00000076007E002FFC00001FFF80000
      F00000074003C001FF800001FFE01F01F000000780018001FF000001FFE03F81
      F000000700018001FF000001FFE03F81F000000700000000FE000001FFE07F80
      F000000700000000FC000001FFF03F80F000000700000000F8000001FFF03F80
      F000000700000000F0000001FFF01F00F000000700000000E0000001FFE00403
      F000000700000001E0000001F3100003F00000078007E000C0000001E0000003
      F000000747FFFFE2C0000001E0000003F000000700DFFC01C0000003E0000007
      F0000007E2FFFF47C000003F0000007FF0000007F17FFE8FC000003F03E0B87F
      F0000007F8BFFF1FC000003F87F07FFFF0000007F47FFE2FC000003F87F07FFF
      F000000FFA1FF85FC000003F0FF07FFFF000001FFF0180FFC000007F07F0FFFF
      F000003FFF8183FFE000007F07F0FFFFF000007FFF73EFFFE000007F83E07FFF
      F00000FFFFDFFBFFF00000FFC0807FFFF00001FFFFFFFFFFF80001FFC003FFFF
      F00003FFFFFFFFFFFC0003FFC003FFFFF00007FFFFFFFFFFFE0007FFE803FFFF
      F0000FFFFFFFFFFFFF801FFFFC67FFFFFFFFFFFFFFC003FFE0000007FFFFFFFF
      FFFFFFFFFF0000FFE0000007FFFFFFFFFC00003FFE00007FE0000007F1FFFFFF
      F000000FF800001FE0000007C01FFFFFF000000FF000000FE00000074001FFFF
      F000000FE0000007E000000740001FFFF000000FE0000007E0000007400000FF
      F000000FC0000003E00000074000007FF000000F80000001E00000074000003F
      F000000F80000001E00000074000003FF000000F00000000E00000074000001F
      F000000F00000000E00000074000001FF000000F00000000E00000074000000F
      F000000F00000000E00000074000000FF000000F00000000E0000007C0000007
      F000000F00000000E0000007C0000007F000000F00000000E000000780000003
      F000000F00000000E000000780000003F000000F00000000E000000780000003
      F000000F00000000E000000780000001F000000F00000000E000000780000001
      F000000F80000001E000000780000003F000000F80000001E00000078000007F
      F000000F80000001E000000F0000003FF000000FC0000003E000001F4000007F
      F000000FE0000007E000003FE00700FFF000000FE000000FE000007FE00BFFFF
      F000000FF000001FE00000FFFE7FFFFFF800000FFC00003FE00001FFFFFFFFFF
      FE00003FFE00007FE00003FFFFFFFFFFFFFFFFFFFF8001FFE00007FFFFFFFFFF
      FFFFFFFFFFE007FFE0000FFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
