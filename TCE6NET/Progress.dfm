object ProgressForm: TProgressForm
  Left = 213
  Top = 201
  Hint = 'Progress of emails sent'
  BorderStyle = bsDialog
  Caption = 'Send Emails'
  ClientHeight = 170
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object UpdateDone: TBitBtn
    Left = 105
    Top = 137
    Width = 75
    Height = 25
    Hint = 'Click to close'
    Caption = '&OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 0
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
  object GroupBox1: TGroupBox
    Left = 12
    Top = 8
    Width = 253
    Height = 113
    TabOrder = 1
    object Label1: TLabel
      Left = 32
      Top = 24
      Width = 57
      Height = 13
      Caption = 'Last sent:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 93
      Top = 24
      Width = 37
      Height = 13
      Caption = '(none)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 32
      Top = 45
      Width = 95
      Height = 13
      Caption = 'Cover Teachers:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label4: TLabel
      Left = 132
      Top = 45
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 32
      Top = 66
      Width = 72
      Height = 13
      Caption = 'Added Staff:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label6: TLabel
      Left = 112
      Top = 66
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 32
      Top = 88
      Width = 101
      Height = 13
      Caption = 'Absent Teachers:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label8: TLabel
      Left = 135
      Top = 88
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object IdSMTP1: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AuthType = satSASL
    SASLMechanisms = <
      item
        SASL = IdSASLLogin1
      end
      item
        SASL = IdSASLPlain1
      end>
    Left = 64
    Top = 128
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 208
    Top = 128
  end
  object pipCover: TppJITPipeline
    InitialIndex = 0
    RecordCount = 99999999
    UserName = 'pipCover'
    OnGetFieldValue = PopulateFieldData
    Left = 2
    Top = 128
    object ppJITChangesDetails: TppField
      FieldAlias = 'ChangesDetails'
      FieldName = 'fldChangesDetails'
      FieldLength = 100
      DisplayWidth = 10
      Position = 0
    end
    object pipCoverppTeacherName: TppField
      FieldAlias = 'TeacherName'
      FieldName = 'fldTeacherName'
      FieldLength = 10
      DisplayWidth = 10
      Position = 1
    end
    object pipCoverppDayOfChanges: TppField
      Alignment = taRightJustify
      FieldAlias = 'DayOfChanges'
      FieldName = 'fldDayOfChanges'
      FieldLength = 10
      DisplayWidth = 10
      Position = 2
    end
    object pipCoverppCustomAddOn: TppField
      FieldAlias = 'CustomAddOn'
      FieldName = 'fldCustomAddOn'
      FieldLength = 10
      DisplayWidth = 10
      Position = 3
    end
  end
  object repCover: TppReport
    AutoStop = False
    DataPipeline = pipCover
    NoDataBehaviors = [ndMessageDialog, ndBlankPage]
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Teacher Cover'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    AllowPrintToArchive = True
    AllowPrintToFile = True
    DeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.Enabled = True
    EmailSettings.FileName = 'TeacherCover'
    LanguageID = 'Default'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    PDFSettings.EmbedFontOptions = []
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.Subject = 'Teacher Cover'
    PDFSettings.Title = 'Teacher Cover'
    PreviewFormSettings.WindowState = wsMaximized
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    ShowAutoSearchDialog = True
    ShowCancelDialog = False
    ShowPrintDialog = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 34
    Top = 128
    Version = '12.04'
    mmColumnWidth = 0
    DataPipelineName = 'pipCover'
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 47096
      mmPrintPosition = 0
      object lblSchoolName: TppLabel
        UserName = 'lblSchoolName'
        HyperlinkColor = clBlue
        AutoSize = False
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'AMIG SYSTEMS Secondary School'
        Ellipsis = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier SWA'
        Font.Size = 16
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        mmHeight = 8996
        mmLeft = 5556
        mmTop = 6879
        mmWidth = 190236
        BandType = 0
      end
      object lblTitle: TppLabel
        UserName = 'lblTitle'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Teacher Covers'
        Ellipsis = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier SWA'
        Font.Size = 16
        Font.Style = []
        Transparent = True
        mmHeight = 6223
        mmLeft = 75142
        mmTop = 16933
        mmWidth = 46228
        BandType = 0
      end
      object imgSchoolLogo: TppImage
        UserName = 'imgSchoolLogo'
        AlignHorizontal = ahCenter
        AlignVertical = avCenter
        MaintainAspectRatio = False
        Stretch = True
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        mmHeight = 15081
        mmLeft = 6879
        mmTop = 16140
        mmWidth = 34396
        BandType = 0
      end
      object txtTeacherName: TppDBText
        UserName = 'txtTeacherName'
        HyperlinkColor = clBlue
        AutoSize = True
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldTeacherName'
        DataPipeline = pipCover
        Ellipsis = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Name = 'Courier SWA'
        Font.Size = 14
        Font.Style = [fsBold]
        Transparent = True
        DataPipelineName = 'pipCover'
        mmHeight = 5588
        mmLeft = 6879
        mmTop = 36777
        mmWidth = 32131
        BandType = 0
      end
      object txtDayOfChanges: TppDBText
        UserName = 'txtDayOfChanges'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldDayOfChanges'
        DataPipeline = pipCover
        Ellipsis = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier SWA'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        DataPipelineName = 'pipCover'
        mmHeight = 9260
        mmLeft = 41804
        mmTop = 36777
        mmWidth = 153988
        BandType = 0
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 4763
        mmTop = 46567
        mmWidth = 191030
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background1.Gradient.EndColor = clWhite
      Background1.Gradient.StartColor = clWhite
      Background1.Gradient.Style = gsNone
      Background2.Brush.Style = bsClear
      Background2.Gradient.EndColor = clWhite
      Background2.Gradient.StartColor = clWhite
      Background2.Gradient.Style = gsNone
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 129117
      mmPrintPosition = 0
      object memStudentDetails: TppDBMemo
        UserName = 'memStudentDetails'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        CharWrap = False
        DataField = 'fldChangesDetails'
        DataPipeline = pipCover
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ResetGroup = ppGroup1
        Stretch = True
        Transparent = True
        DataPipelineName = 'pipCover'
        mmHeight = 127794
        mmLeft = 18785
        mmTop = 1323
        mmWidth = 177007
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        mmLeading = 0
      end
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 54769
      mmPrintPosition = 0
      object ppLine5: TppLine
        UserName = 'Line5'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 5556
        mmTop = 46038
        mmWidth = 189971
        BandType = 8
      end
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        VarType = vtPageNoDesc
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier SWA'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 95779
        mmTop = 47890
        mmWidth = 12965
        BandType = 8
      end
      object ppDBMemo1: TppDBMemo
        UserName = 'DBMemo1'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        CharWrap = False
        DataField = 'fldCustomAddOn'
        DataPipeline = pipCover
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipCover'
        mmHeight = 41275
        mmLeft = 6879
        mmTop = 3440
        mmWidth = 180711
        BandType = 8
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        mmLeading = 0
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'fldTeacherName'
      DataPipeline = pipCover
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      OutlineSettings.CreateNode = True
      NewPage = True
      ResetPageNo = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'pipCover'
      NewFile = False
      object ppGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object repAbsentTeacher: TppReport
    AutoStop = False
    DataPipeline = pipAbsentTeacher
    NoDataBehaviors = [ndMessageDialog, ndBlankPage]
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Teacher Cover'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    AllowPrintToArchive = True
    AllowPrintToFile = True
    DeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.Enabled = True
    LanguageID = 'Default'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    PDFSettings.EmbedFontOptions = []
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.Subject = 'Teacher Cover'
    PDFSettings.Title = 'Teacher Cover'
    PreviewFormSettings.WindowState = wsMaximized
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    ShowAutoSearchDialog = True
    ShowCancelDialog = False
    ShowPrintDialog = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 146
    Top = 104
    Version = '12.04'
    mmColumnWidth = 0
    DataPipelineName = 'pipAbsentTeacher'
    object ppHeaderBand2: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 54240
      mmPrintPosition = 0
      object lblSchoolNameAbsentTe: TppLabel
        UserName = 'lblSchoolName'
        HyperlinkColor = clBlue
        AutoSize = False
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'AMIG SYSTEMS Secondary School'
        Ellipsis = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier SWA'
        Font.Size = 16
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        mmHeight = 8996
        mmLeft = 5556
        mmTop = 6879
        mmWidth = 190236
        BandType = 0
      end
      object lblTitleAbsentTe: TppLabel
        UserName = 'lblTitle'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Teacher Covers'
        Ellipsis = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier SWA'
        Font.Size = 16
        Font.Style = []
        Transparent = True
        mmHeight = 6223
        mmLeft = 75142
        mmTop = 16933
        mmWidth = 46228
        BandType = 0
      end
      object ppImage1: TppImage
        UserName = 'imgSchoolLogo'
        AlignHorizontal = ahCenter
        AlignVertical = avCenter
        MaintainAspectRatio = False
        Stretch = True
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        mmHeight = 15081
        mmLeft = 6879
        mmTop = 16140
        mmWidth = 34396
        BandType = 0
      end
      object ppDBText1: TppDBText
        UserName = 'txtTeacherName'
        HyperlinkColor = clBlue
        AutoSize = True
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldTeacherName'
        DataPipeline = pipAbsentTeacher
        Ellipsis = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Name = 'Courier SWA'
        Font.Size = 14
        Font.Style = [fsBold]
        Transparent = True
        DataPipelineName = 'pipAbsentTeacher'
        mmHeight = 5588
        mmLeft = 6879
        mmTop = 36777
        mmWidth = 32131
        BandType = 0
      end
      object ppDBText2: TppDBText
        UserName = 'txtDayOfChanges'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldDayOfChanges'
        DataPipeline = pipAbsentTeacher
        Ellipsis = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier SWA'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        DataPipelineName = 'pipAbsentTeacher'
        mmHeight = 9260
        mmLeft = 40481
        mmTop = 36777
        mmWidth = 153459
        BandType = 0
      end
      object ppLine2: TppLine
        UserName = 'Line1'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 5556
        mmTop = 46302
        mmWidth = 190236
        BandType = 0
      end
      object ppLabel3: TppLabel
        UserName = 'Label1'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Time'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4318
        mmLeft = 11113
        mmTop = 47890
        mmWidth = 8636
        BandType = 0
      end
      object ppLabel4: TppLabel
        UserName = 'Label2'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Subject'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4318
        mmLeft = 30163
        mmTop = 47890
        mmWidth = 12954
        BandType = 0
      end
      object ppLabel5: TppLabel
        UserName = 'Label3'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Year'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4318
        mmLeft = 59267
        mmTop = 47890
        mmWidth = 7747
        BandType = 0
      end
      object ppLabel6: TppLabel
        UserName = 'Label4'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Class'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4318
        mmLeft = 72496
        mmTop = 47890
        mmWidth = 9398
        BandType = 0
      end
      object ppLabel7: TppLabel
        UserName = 'Label5'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Room'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4318
        mmLeft = 89429
        mmTop = 47890
        mmWidth = 10160
        BandType = 0
      end
      object ppLabel8: TppLabel
        UserName = 'Label6'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'New Teacher'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4318
        mmLeft = 108744
        mmTop = 47890
        mmWidth = 22479
        BandType = 0
      end
      object ppLabel9: TppLabel
        UserName = 'Label7'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Status'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4318
        mmLeft = 140494
        mmTop = 47890
        mmWidth = 10795
        BandType = 0
      end
      object ppLabel10: TppLabel
        UserName = 'Label8'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Note'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4318
        mmLeft = 164836
        mmTop = 47890
        mmWidth = 7874
        BandType = 0
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 5555
        mmTop = 53975
        mmWidth = 190236
        BandType = 0
      end
      object ppLine6: TppLine
        UserName = 'Line2'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 7673
        mmLeft = 195527
        mmTop = 46302
        mmWidth = 265
        BandType = 0
      end
      object ppLine7: TppLine
        UserName = 'Line7'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 7673
        mmLeft = 5556
        mmTop = 46302
        mmWidth = 265
        BandType = 0
      end
    end
    object ppDetailBand2: TppDetailBand
      Background1.Brush.Style = bsClear
      Background1.Gradient.EndColor = clWhite
      Background1.Gradient.StartColor = clWhite
      Background1.Gradient.Style = gsNone
      Background2.Brush.Style = bsClear
      Background2.Gradient.EndColor = clWhite
      Background2.Gradient.StartColor = clWhite
      Background2.Gradient.Style = gsNone
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 8731
      mmPrintPosition = 0
      object ppDBText3: TppDBText
        UserName = 'DBText1'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldTimeSlot'
        DataPipeline = pipAbsentTeacher
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipAbsentTeacher'
        mmHeight = 3683
        mmLeft = 6350
        mmTop = 1588
        mmWidth = 23019
        BandType = 4
      end
      object ppDBText4: TppDBText
        UserName = 'DBText2'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldSubject'
        DataPipeline = pipAbsentTeacher
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipAbsentTeacher'
        mmHeight = 3683
        mmLeft = 29633
        mmTop = 1588
        mmWidth = 28840
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText3'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldYearName'
        DataPipeline = pipAbsentTeacher
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipAbsentTeacher'
        mmHeight = 4233
        mmLeft = 59267
        mmTop = 1588
        mmWidth = 11642
        BandType = 4
      end
      object ppDBText6: TppDBText
        UserName = 'DBText4'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldClass'
        DataPipeline = pipAbsentTeacher
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipAbsentTeacher'
        mmHeight = 3683
        mmLeft = 71702
        mmTop = 1588
        mmWidth = 16140
        BandType = 4
      end
      object ppDBText7: TppDBText
        UserName = 'DBText5'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldRoom'
        DataPipeline = pipAbsentTeacher
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipAbsentTeacher'
        mmHeight = 3683
        mmLeft = 89694
        mmTop = 1588
        mmWidth = 17198
        BandType = 4
      end
      object ppDBText8: TppDBText
        UserName = 'DBText6'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldNewTeacher'
        DataPipeline = pipAbsentTeacher
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipAbsentTeacher'
        mmHeight = 3683
        mmLeft = 108479
        mmTop = 1588
        mmWidth = 30956
        BandType = 4
      end
      object ppDBText9: TppDBText
        UserName = 'DBText7'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldStatus'
        DataPipeline = pipAbsentTeacher
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipAbsentTeacher'
        mmHeight = 3704
        mmLeft = 141288
        mmTop = 1588
        mmWidth = 16140
        BandType = 4
      end
      object ppDBText10: TppDBText
        UserName = 'DBText8'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldNote'
        DataPipeline = pipAbsentTeacher
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipAbsentTeacher'
        mmHeight = 3704
        mmLeft = 157692
        mmTop = 1588
        mmWidth = 38100
        BandType = 4
      end
    end
    object ppFooterBand2: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 73554
      mmPrintPosition = 0
      object ppLine3: TppLine
        UserName = 'Line5'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 5556
        mmTop = 36513
        mmWidth = 189971
        BandType = 8
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable2'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        VarType = vtPageNoDesc
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier SWA'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 95779
        mmTop = 38365
        mmWidth = 12965
        BandType = 8
      end
      object ppDBMemo3: TppDBMemo
        UserName = 'DBMemo1'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        CharWrap = False
        DataField = 'fldCustomAddOn'
        DataPipeline = pipAbsentTeacher
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipAbsentTeacher'
        mmHeight = 34131
        mmLeft = 5556
        mmTop = 1058
        mmWidth = 190236
        BandType = 8
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        mmLeading = 0
      end
    end
    object ppGroup2: TppGroup
      BreakName = 'fldTeacherName'
      DataPipeline = pipAbsentTeacher
      GroupFileSettings.NewFile = True
      GroupFileSettings.EmailFile = False
      OutlineSettings.CreateNode = True
      NewPage = True
      ResetPageNo = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'pipAbsentTeacher'
      NewFile = True
      object ppGroupHeaderBand2: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
      object ppGroupFooterBand2: TppGroupFooterBand
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 19050
        mmPrintPosition = 0
        object memFooter: TppDBMemo
          UserName = 'memFooter'
          Border.BorderPositions = []
          Border.Color = clBlack
          Border.Style = psSolid
          Border.Visible = False
          CharWrap = False
          DataField = 'fldMisc'
          DataPipeline = pipAbsentTeacher
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          DataPipelineName = 'pipAbsentTeacher'
          mmHeight = 12171
          mmLeft = 5556
          mmTop = 6879
          mmWidth = 190236
          BandType = 5
          GroupNo = 0
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          mmMinHeight = 0
          mmLeading = 0
        end
        object ppLine8: TppLine
          UserName = 'Line8'
          Border.BorderPositions = []
          Border.Color = clBlack
          Border.Style = psSolid
          Border.Visible = False
          Weight = 0.750000000000000000
          mmHeight = 265
          mmLeft = 5821
          mmTop = 5027
          mmWidth = 189971
          BandType = 5
          GroupNo = 0
        end
      end
    end
    object ppParameterList2: TppParameterList
    end
  end
  object pipAbsentTeacher: TppJITPipeline
    InitialIndex = 0
    RecordCount = 99999999
    UserName = 'pipAbsentTeacher'
    OnGetFieldValue = PopulateFieldAbsentTe
    Left = 114
    Top = 104
    object ppField2: TppField
      FieldAlias = 'TeacherName'
      FieldName = 'fldTeacherName'
      FieldLength = 10
      DisplayWidth = 10
      Position = 0
    end
    object ppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'DayOfChanges'
      FieldName = 'fldDayOfChanges'
      FieldLength = 10
      DisplayWidth = 10
      Position = 1
    end
    object pipAbsentTeacherppTimeSlot: TppField
      FieldAlias = 'TimeSlot'
      FieldName = 'fldTimeSlot'
      FieldLength = 10
      DisplayWidth = 10
      Position = 2
    end
    object pipAbsentTeacherppSubject: TppField
      FieldAlias = 'Subject'
      FieldName = 'fldSubject'
      FieldLength = 10
      DisplayWidth = 10
      Position = 3
    end
    object pipAbsentTeacherppYearName: TppField
      FieldAlias = 'YearName'
      FieldName = 'fldYearName'
      FieldLength = 10
      DisplayWidth = 10
      Position = 4
    end
    object pipAbsentTeacherppClass: TppField
      FieldAlias = 'Class'
      FieldName = 'fldClass'
      FieldLength = 10
      DisplayWidth = 10
      Position = 5
    end
    object pipAbsentTeacherppRoom: TppField
      FieldAlias = 'Room'
      FieldName = 'fldRoom'
      FieldLength = 10
      DisplayWidth = 10
      Position = 6
    end
    object pipAbsentTeacherppNewTe: TppField
      FieldAlias = 'New Teacher'
      FieldName = 'fldNewTeacher'
      FieldLength = 10
      DisplayWidth = 10
      Position = 7
    end
    object pipAbsentTeacherStatus: TppField
      FieldAlias = 'Status'
      FieldName = 'fldStatus'
      FieldLength = 10
      DisplayWidth = 10
      Position = 8
    end
    object pipAbsentTeacherppNote: TppField
      FieldAlias = 'Note'
      FieldName = 'fldNote'
      FieldLength = 10
      DisplayWidth = 10
      Position = 9
    end
    object pipAbsentTeacherppMisc: TppField
      FieldAlias = 'MIsc'
      FieldName = 'fldMisc'
      FieldLength = 10
      DisplayWidth = 10
      Position = 10
    end
    object ppField4: TppField
      FieldAlias = 'CustomAddOn'
      FieldName = 'fldCustomAddOn'
      FieldLength = 10
      DisplayWidth = 10
      Position = 11
    end
  end
  object IdSASLLogin1: TIdSASLLogin
    UserPassProvider = IdUserPassProvider1
    Left = 200
    Top = 32
  end
  object IdSASLPlain1: TIdSASLPlain
    UserPassProvider = IdUserPassProvider1
    Left = 192
    Top = 64
  end
  object IdUserPassProvider1: TIdUserPassProvider
    Left = 224
    Top = 80
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':25'
    MaxLineAction = maException
    Port = 25
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv3
    SSLOptions.SSLVersions = [sslvSSLv3]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 8
    Top = 8
  end
end
