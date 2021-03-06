object FrmStaffTT: TFrmStaffTT
  Left = 20
  Top = 100
  Caption = 'Teacher Timetable'
  ClientHeight = 422
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesigned
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHeading: TPanel
    Left = 0
    Top = 0
    Width = 592
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblHeading: TLabel
      Left = 15
      Top = 4
      Width = 64
      Height = 18
      Caption = 'lblHeading'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblFaculty: TLabel
      Left = 15
      Top = 24
      Width = 53
      Height = 16
      Caption = 'lblFaculty'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object grdTeacherTT: TZColorStringGrid
    Left = 0
    Top = 43
    Width = 592
    Height = 379
    Align = alClient
    ColCount = 7
    DefaultColWidth = 45
    DefaultRowHeight = 30
    DefaultDrawing = False
    FixedColor = clBtnFace
    FixedCols = 0
    PopupMenu = popTecaherTT
    TabOrder = 1
    DefaultCellStyle.Font.Charset = DEFAULT_CHARSET
    DefaultCellStyle.Font.Color = clWindowText
    DefaultCellStyle.Font.Height = -11
    DefaultCellStyle.Font.Name = 'Tahoma'
    DefaultCellStyle.Font.Style = []
    DefaultCellStyle.BGColor = clWindow
    DefaultFixedCellStyle.Font.Charset = DEFAULT_CHARSET
    DefaultFixedCellStyle.Font.Color = clWindowText
    DefaultFixedCellStyle.Font.Height = -11
    DefaultFixedCellStyle.Font.Name = 'Tahoma'
    DefaultFixedCellStyle.Font.Style = []
    DefaultFixedCellStyle.BGColor = clBtnFace
    LineDesign.LineUpColor = clWhite
    SelectedColors.BGColor = clWindow
    SelectedColors.FontColor = clBlack
    WordWrap = True
  end
  object OpenDialog1: TOpenDialog
    Left = 464
    Top = 88
  end
  object pipTeacherTtReport: TppJITPipeline
    InitialIndex = 0
    RecordCount = 99999999
    UserName = 'pipTeacherTtReport'
    OnGetFieldValue = PopulateFieldData
    Left = 384
    Top = 126
    object ppJITTeacherName: TppField
      FieldAlias = 'TeacherName'
      FieldName = 'fldTeacherName'
      FieldLength = 10
      DisplayWidth = 10
      Position = 0
      Selectable = False
      Sort = True
    end
    object ppJITFaculty: TppField
      FieldAlias = 'Faculty'
      FieldName = 'fldFaculty'
      FieldLength = 10
      DisplayWidth = 10
      Position = 1
      Selectable = False
      SortType = soDescending
    end
    object ppJITAbsenceReason: TppField
      FieldAlias = 'AbsenceReason'
      FieldName = 'fldAbsenceReason'
      FieldLength = 10
      DisplayWidth = 10
      Position = 2
    end
    object pipTeacherTtReportppAddedStaff: TppField
      FieldAlias = 'AddedStaff'
      FieldName = 'fldAddedStaff'
      FieldLength = 10
      DisplayWidth = 10
      Position = 3
    end
    object pipTeacherTtReportppPeriod: TppField
      FieldAlias = 'Period'
      FieldName = 'fldPeriod'
      FieldLength = 10
      DisplayWidth = 10
      Position = 4
    end
    object pipTeacherTtReportppTimeRange: TppField
      FieldAlias = 'TimeRange'
      FieldName = 'fldTimeRange'
      FieldLength = 10
      DisplayWidth = 10
      Position = 5
    end
    object pipTeacherTtReportppSubject: TppField
      FieldAlias = 'Subject'
      FieldName = 'fldSubject'
      FieldLength = 10
      DisplayWidth = 10
      Position = 6
    end
    object pipTeacherTtReportppRoom: TppField
      FieldAlias = 'Room'
      FieldName = 'fldRoom'
      FieldLength = 10
      DisplayWidth = 10
      Position = 7
    end
    object pipTeacherTtReportppYearName: TppField
      FieldAlias = 'YearName'
      FieldName = 'fldYearName'
      FieldLength = 10
      DisplayWidth = 10
      Position = 8
    end
    object pipTeacherTtReportppCasual: TppField
      FieldAlias = 'Casual'
      FieldName = 'fldCasual'
      FieldLength = 10
      DisplayWidth = 10
      Position = 9
    end
  end
  object repTeacherTtReport: TppReport
    AutoStop = False
    DataPipeline = pipTeacherTtReport
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
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
    DeviceType = 'Screen'
    EmailSettings.ReportFormat = 'PDF'
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
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zsPercentage
    PreviewFormSettings.ZoomPercentage = 90
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 408
    Top = 126
    Version = '12.04'
    mmColumnWidth = 0
    DataPipelineName = 'pipTeacherTtReport'
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 61119
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
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
      object ppLabel2: TppLabel
        UserName = 'Label2'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Teacher'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4953
        mmLeft = 17463
        mmTop = 33602
        mmWidth = 16002
        BandType = 0
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Faculty'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4953
        mmLeft = 17463
        mmTop = 41275
        mmWidth = 14605
        BandType = 0
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Casual'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4953
        mmLeft = 17463
        mmTop = 56092
        mmWidth = 13589
        BandType = 0
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Reason'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4953
        mmLeft = 17463
        mmTop = 48683
        mmWidth = 14986
        BandType = 0
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        VarType = vtDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4191
        mmLeft = 157957
        mmTop = 32015
        mmWidth = 37846
        BandType = 0
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Caption = 'Added Staff Timetable'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 16
        Font.Style = []
        Transparent = True
        mmHeight = 6477
        mmLeft = 77788
        mmTop = 16933
        mmWidth = 54991
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
      object txtTeacher: TppDBText
        UserName = 'txtTeacher'
        HyperlinkColor = clBlue
        AutoSize = True
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldTeacherName'
        DataPipeline = pipTeacherTtReport
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'pipTeacherTtReport'
        mmHeight = 4953
        mmLeft = 40217
        mmTop = 33602
        mmWidth = 25781
        BandType = 0
      end
      object txtFaculty: TppDBText
        UserName = 'txtFaculty'
        HyperlinkColor = clBlue
        AutoSize = True
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldFaculty'
        DataPipeline = pipTeacherTtReport
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'pipTeacherTtReport'
        mmHeight = 4953
        mmLeft = 40217
        mmTop = 41275
        mmWidth = 13081
        BandType = 0
      end
      object txtReason: TppDBText
        UserName = 'txtReason'
        HyperlinkColor = clBlue
        AutoSize = True
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldAbsenceReason'
        DataPipeline = pipTeacherTtReport
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'pipTeacherTtReport'
        mmHeight = 4953
        mmLeft = 40217
        mmTop = 48683
        mmWidth = 29972
        BandType = 0
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        HyperlinkColor = clBlue
        AutoSize = True
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldCasual'
        DataPipeline = pipTeacherTtReport
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'pipTeacherTtReport'
        mmHeight = 4953
        mmLeft = 40217
        mmTop = 55827
        mmWidth = 12700
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
      mmBottomOffset = 0
      mmHeight = 15875
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldPeriod'
        DataPipeline = pipTeacherTtReport
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        ParentDataPipeline = False
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipTeacherTtReport'
        mmHeight = 4953
        mmLeft = 19844
        mmTop = 2910
        mmWidth = 39688
        BandType = 4
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        HyperlinkColor = clBlue
        AutoSize = True
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldSubject'
        DataPipeline = pipTeacherTtReport
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clFuchsia
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'pipTeacherTtReport'
        mmHeight = 4953
        mmLeft = 76729
        mmTop = 529
        mmWidth = 13716
        BandType = 4
      end
      object txtRoom: TppDBText
        UserName = 'txtRoom'
        HyperlinkColor = clBlue
        AutoSize = True
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldRoom'
        DataPipeline = pipTeacherTtReport
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'pipTeacherTtReport'
        mmHeight = 4953
        mmLeft = 78052
        mmTop = 5556
        mmWidth = 10795
        BandType = 4
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        HyperlinkColor = clBlue
        AutoSize = True
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldAddedStaff'
        DataPipeline = pipTeacherTtReport
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'pipTeacherTtReport'
        mmHeight = 4953
        mmLeft = 73184
        mmTop = 10583
        mmWidth = 20447
        BandType = 4
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 15875
        mmTop = 15611
        mmWidth = 90223
        BandType = 4
      end
      object ppShape3: TppShape
        UserName = 'Shape3'
        Gradient.EndColor = clWhite
        Gradient.StartColor = clWhite
        Gradient.Style = gsNone
        mmHeight = 15875
        mmLeft = 106098
        mmTop = 0
        mmWidth = 265
        BandType = 4
      end
      object ppShape4: TppShape
        UserName = 'Shape4'
        Gradient.EndColor = clWhite
        Gradient.StartColor = clWhite
        Gradient.Style = gsNone
        mmHeight = 15875
        mmLeft = 15610
        mmTop = 0
        mmWidth = 265
        BandType = 4
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 15875
        mmTop = 0
        mmWidth = 90223
        BandType = 4
      end
      object ppShape1: TppShape
        UserName = 'Shape1'
        Gradient.EndColor = clWhite
        Gradient.StartColor = clWhite
        Gradient.Style = gsNone
        mmHeight = 15875
        mmLeft = 61383
        mmTop = 0
        mmWidth = 265
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        DataField = 'fldTimeRange'
        DataPipeline = pipTeacherTtReport
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'pipTeacherTtReport'
        mmHeight = 4953
        mmLeft = 19844
        mmTop = 8996
        mmWidth = 39688
        BandType = 4
      end
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 8731
      mmPrintPosition = 0
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4191
        mmLeft = 93663
        mmTop = 2646
        mmWidth = 18161
        BandType = 8
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object popTecaherTT: TPopupMenu
    OnPopup = SetupMenu
    Left = 416
    Top = 184
    object popStaffTTWeeklyTimetable: TMenuItem
      Caption = 'Weekly timetable'
      OnClick = PrintPreviwTimetable
    end
    object popStaffTTPrintPreview: TMenuItem
      Caption = 'PrintPreview'
      OnClick = PrintPreviewReport
    end
  end
end
