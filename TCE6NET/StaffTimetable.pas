unit StaffTimetable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, FileCtrl, StdCtrls, Grids, Contnrs, ppParameter,
  ppStrtch, ppMemo, ppBands, ppCtrls, ppVar, ppPrnabl, ppClass, ppCache, ppProd,
  ppReport, ppDB, ppComm, ppRelatv, ppDBJIT, uAMGCommon, Menus, ZColorStringGrid, GlobalToTcAndTcextra;

type
  TEntryDay = class
  private
    FYearName: string;
    FDayName: string;
    FRoomName: string;
    FSubjectCode: string;
    FDayID: Integer;
    FSubjectID: Integer;

    FPeriodID: Integer;
    FTimeRange: string;
    FPeriodName: string;
    FTeacherName: string;
    FAddedStaff: string;
    FFaculty: string;
    FAbsenceReason: string;
    FCasual: string;
    FCoverNote: string;
    FStatus: string;
    FFRollClass: string;
  public
    property DayID: Integer read FDayID write FDayID;
    property DayName: string read FDayName write FDayName;
    property SubjectID: Integer read FSubjectID write FSubjectID;
    property SubjectCode: string read FSubjectCode write FSubjectCode;
    property RoomName: string read FRoomName write FRoomName;
    property YearName: string read FYearName write FYearName;

    property PeriodID: Integer read FPeriodID write FPeriodID;
    property PeriodName: string read FPeriodName write FPeriodName;
    property TimeRange: string read FTimeRange write FTimeRange;
    property TeacherName: string read FTeacherName write FTeacherName;
    property Faculty: string read FFaculty write FFaculty;
    property AbsenceReason: string read FAbsenceReason write FAbsenceReason;
    property AddedStaff: string read FAddedStaff write FAddedStaff;
    property Casual: string read FCasual write FCasual;
    property CoverNote: string read FCoverNote write FCoverNote;
    property Status: string read FStatus write FStatus;
    property FRollClass: string read FFRollClass write FFRollClass;
  end;

  TEntryDays = class(TObjectList)

  end;

  TTimetablePeriod = class
  private
    FEntryDays: TEntryDays;
  public
    property EntryDays: TEntryDays read FEntryDays write FEntryDays;
  end;

  TTimetablePeriods = class(TObjectList)
  end;

  TFrmStaffTT = class(TForm)
    pnlHeading: TPanel;
    OpenDialog1: TOpenDialog;
    lblHeading: TLabel;
    lblFaculty: TLabel;
    grdTeacherTT: TZColorStringGrid;
    pipTeacherTtReport: TppJITPipeline;
    ppJITTeacherName: TppField;
    ppJITFaculty: TppField;
    ppJITAbsenceReason: TppField;
    repTeacherTtReport: TppReport;
    ppHeaderBand1: TppHeaderBand;
    lblSchoolName: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel5: TppLabel;
    imgSchoolLogo: TppImage;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    txtRoom: TppDBText;
    ppDBText4: TppDBText;
    ppLine3: TppLine;
    ppShape3: TppShape;
    ppShape4: TppShape;
    ppFooterBand1: TppFooterBand;
    ppSystemVariable2: TppSystemVariable;
    ppParameterList1: TppParameterList;
    pipTeacherTtReportppAddedStaff: TppField;
    pipTeacherTtReportppPeriod: TppField;
    pipTeacherTtReportppSubject: TppField;
    pipTeacherTtReportppRoom: TppField;
    pipTeacherTtReportppYearName: TppField;
    popTecaherTT: TPopupMenu;
    ppLine1: TppLine;
    txtTeacher: TppDBText;
    txtFaculty: TppDBText;
    txtReason: TppDBText;
    ppShape1: TppShape;
    pipTeacherTtReportppTimeRange: TppField;
    ppDBText5: TppDBText;
    pipTeacherTtReportppCasual: TppField;
    ppDBText3: TppDBText;
    popStaffTTWeeklyTimetable: TMenuItem;
    popStaffTTPrintPreview: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure AlignTimeText(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure kgdTeacherTTDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    function PopulateFieldData(aFieldName: string): Variant;
    procedure PrintPreviewReport(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PrintPreviwTimetable(Sender: TObject);
    procedure SetupMenu(Sender: TObject);
  private
    FSelectedTe: Integer;
    FEntryDays: TEntryDays;
    FCasual: string;
    FTeStatus: string;
    FTeCover: string;
    FRoomChange: Boolean;
    FTeFound: Boolean;
    FTeLevel: Integer;
    FTeYear: Integer;
    FRoomChangeFlag: Boolean;
    FTeRoom: Integer;
    FTeSub: Integer;
    FIsOKToRefreshTT: Boolean;
    FIsCoverSouce: Boolean;
    procedure SetGrid(Sender : TObject; C, R : integer; Rect : TRect; Style : TFontStyles; Wrap : boolean; Just : TAlignment; CanEdit : boolean);
    procedure DrawSGCell(Sender: TObject; C, R: Integer; Rect: TRect; Style: TFontStyles; Wrap: Boolean; Just: TAlignment; CanEdit: Boolean);
    function GetFieldValue(pRecIndex: Integer; const pFieldName: string): Variant;
    procedure PrintTeacherTtReport(const pOutputType: TOutputType);
    procedure CheckExtras(pTimeSlot: Integer);
  public
    function RefreshTimetable: Boolean;
    property SelectedTe: Integer read FSelectedTe write FSelectedTe;
    property IsCoverSouce: Boolean read FIsCoverSouce write FIsCoverSouce;
  end;

var
  FrmStaffTT: TFrmStaffTT;

implementation

uses
  TCEGlobals, TCommon, Tcommon2, DateUtils, uAMGConst, Mancover;

{$R *.dfm}

procedure TFrmStaffTT.SetGrid(Sender : TObject; C, R : integer; Rect : TRect; Style : TFontStyles; Wrap : boolean; Just : TAlignment; CanEdit : boolean);
{ draws formatted contents in string grid cell at col C, row R;
Style is a set of fsBold, fsItalic, fsUnderline and fsStrikeOut;
Wrap invokes word wrap for the cell's text; Just is taLeftJustify,
taRightJustify or taCenter; if CanEdit false, cell will be given
the background color of fixed cells; call this routine from
grid's DrawCell event
var
  lStr: string;
  DrawRect: TRect;   }
begin
  (*with (Sender as tStringGrid), Canvas do
  begin
    //erase earlier contents from default drawing
    if (R>= FixedRows) and (C>= FixedCols) and CanEdit then
      Brush.Color:= Color
    else
      Brush.Color:= FixedColor;
    FillRect(Rect);
    //get cell contents
    lStr := Cells[C, R];
    if length(lStr) > 0 then
    begin
      case Just of
        taLeftJustify : lStr := ' ' + lStr;
        taRightJustify : lStr := lStr + ' ';
      end;
      //set font style
      Font.Style:= Style;
      //copy of cell rectangle for text sizing
      DrawRect:= Rect;
      if Wrap then
      begin
        //get size of text rectangle in DrawRect, with word wrap
        DrawText(Handle, PChar(lStr), length(lStr), DrawRect, dt_calcrect or dt_wordbreak or dt_center);
        if (DrawRect.Bottom - DrawRect.Top) > RowHeights[R] then
        begin
          //cell word-wraps; increase row height
          RowHeights[R]:= DrawRect.Bottom - DrawRect.Top;
        end
        else
        begin
          //cell doesn't word-wrap
          DrawRect.Right:= Rect.Right;
          FillRect(DrawRect);
          case Just of
            taLeftJustify : DrawText(Handle, PChar(lStr), length(lStr), DrawRect, dt_wordbreak or dt_left);
            taCenter : DrawText(Handle, PChar(lStr), length(lStr), DrawRect, dt_wordbreak or dt_center);
            taRightJustify : DrawText(Handle, PChar(lStr), length(lStr), DrawRect, dt_wordbreak or dt_right);
          end;  // Case
        end
        end
        else
          //no word wrap
          case Just of
            taLeftJustify : DrawText(Handle, PChar(lStr), length(lStr), DrawRect, dt_singleline or dt_vcenter or dt_left);
            taCenter : DrawText(Handle, PChar(lStr), length(lStr), DrawRect, dt_singleline or dt_vcenter or dt_center);
            taRightJustify : DrawText(Handle, PChar(lStr), length(lStr), DrawRect, dt_singleline or dt_vcenter or dt_right);
          end;
      //restore no font styles
      Font.Style:= [];
    end;  // if
  end;  // with*)
end;

procedure TFrmStaffTT.SetupMenu(Sender: TObject);
begin
   popStaffTTWeeklyTimetable.Visible := SelectedTe < 1000;
   popStaffTTPrintPreview.Visible := not FIsCoverSouce and not popStaffTTWeeklyTimetable.Visible;
end;

procedure TFrmStaffTT.AlignTimeText(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  x, y: Integer;
  MergedRect: TRect;
  TopRect: TRect;
  BottomRect: TRect;
begin
  if ARow mod 2 = 1 then
  begin
    if gdFixed in State then Exit;
    if ARow > 1 then Exit;
    with Sender as TStringGrid do
    begin
      if aRow < Pred(RowCount) then
        Rect.Bottom := Rect.Bottom + RowHeights[Arow];

    //Figure out where the text of the first cell would start relative to the current cells rect.
      y := Rect.Top + 2;
      x := Rect.Left + 2;
      y := y + RowHeights[aRow + 1];

      //Paint cell pale yellow
      TopRect := CellRect(ACol, ARow);
      BottomRect := CellRect(Acol, ARow + 1);
      MergedRect.Left := TopRect.Left;
      MergedRect.Top := TopRect.Top;
      MergedRect.Right := TopRect.Right;
      MergedRect.Bottom := BottomRect.Bottom;
      Canvas.FillRect(MergedRect);
      Canvas.Brush.Color := $7FFFFF;
      Canvas.Brush.Style := bsSolid;
      Canvas.Font := Font;
      Canvas.TextRect(MergedRect, x, y, Cells[3, 2]);
    end; // with
  end; // if

  {if ACol = 0 then
    SetGrid(Sender, ACol, ARow, Rect, [fsBold], True, taRightJustify, False);

  if ARow = 0 then
    SetGrid(Sender, ACol, ARow, Rect, [fsBold], True, taCenter, False);}
end;

procedure TFrmStaffTT.CheckExtras(pTimeSlot: Integer);
var
  slot, i: Integer;
  astr: string;
begin
 astr:='-'; slot:=(1 shl pTimeSlot);
 if (teach[teshownum] and slot)=0 then astr:='T';
 if (tena[teshownum] and slot)=0 then astr:='N';
 if (telost[teshownum] and slot)=0 then astr:='L';
 if (tecover[teshownum] and slot)=0 then astr:='C';
 if (tereplace[teshownum] and slot)=0 then astr:='R';
 if (telieu[teshownum] and slot)=0 then astr:='I';
 if (teAbsent[teshownum] and slot)=0 then astr:='A';
 if astr='L' then FTeCover := 'Lost Class';
 if astr='A' then FTeStatus :='Absent';
 FRoomChange := False;
 if numchanges>0 then
  for i:=1 to numchanges do
   begin
    if ((Changes[i].timeslot = pTimeSlot) and (Changes[i].year = FTeYear)
     and (Changes[i].level= FTeLevel) and (Changes[i].oldte=teshownum)) then
    begin
     FTeFound := True;
     if ((Changes[i].newroom<>Changes[i].oldroom) and (Changes[i].newroom>0)) then
     begin
       FRoomChange := true;
       FRoomChangeFlag := True;
       FTeRoom := Changes[i].newroom;
     end;
     if (Changes[i].gen=1) then
     begin
      if (Changes[i].reason>0) then FTeStatus:=copy(Absent[Changes[i].Reason],1,20);
      if (Changes[i].newte>0) then
      begin
       FTeCover := tecode[Changes[i].newte,0];
       if Changes[i].kind=1 then FTeCover :=etsub[Changes[i].newte];
      end;
      if bool(Changes[i].needte) then FTeCover :='Needed';
     end; {if}
    end; {if}
    if ((Changes[i].timeslot= pTimeSlot) and (Changes[i].newte=teshownum)) then
    begin
     case Changes[i].kind of
      2,3,4,5: begin
                FTeFound := True;
                FTeSub := Changes[i].sub;
                FTeRoom := Changes[i].newroom;
                FTeYear := Changes[i].year;
                FTeLevel := Changes[i].level;
               end;
     end; {case}
     case Changes[i].kind of
      2: FTeStatus := 'Replace';
      3: FTeStatus := 'In Lieu';
      4: FTeStatus := 'Extra';
      5: FTeStatus := 'Shared';
     end; {case}
    end;
   end; {for i}
end;

procedure TFrmStaffTT.DrawSGCell(Sender : TObject; C, R : integer; Rect : TRect; Style : TFontStyles; Wrap : boolean; Just : TAlignment; CanEdit : boolean);
{ draws formatted contents in string grid cell at col C, row R;
Style is a set of fsBold, fsItalic, fsUnderline and fsStrikeOut;
Wrap invokes word wrap for the cell's text; Just is taLeftJustify,
taRightJustify or taCenter; if CanEdit false, cell will be given
the background color of fixed cells; call this routine from
grid's DrawCell event
var
  S : string;
  DrawRect : TRect;}
begin
  (*//with (Sender as TKStringGrid), Canvas do
  begin
    // erase earlier contents fr om default drawing
    if {(R >= FixedRows) and } (C >= FixedCols) and CanEdit then
      Brush.Color:= Color
    else
      Brush.Color:= FixedColor;
    FillRect(Rect);
    { get cell contents }
    S:= Cells[C, R];
    if length(S)>0 then
    begin
      case Just of
        taLeftJustify : S:= ' ' + S;
        taRightJustify : S:= S + ' ';
      end;
      { set font style }
      Font.Style:= Style;
      { copy of cell rectangle for text sizing }
      DrawRect:= Rect;
      if Wrap then
      begin
        { get size of text rectangle in DrawRect, with word wrap }
        DrawText(Handle, PChar(S), length(S), DrawRect,
        dt_calcrect or dt_wordbreak or dt_center);
        if (DrawRect.Bottom - DrawRect.Top) > DefaultRowHeight then //RowHeights[R] then
        begin
          { cell word-wraps; increase row height }
          //RowHeights[R] := DrawRect.Bottom - DrawRect.Top;
          //SetGridHeight(Sender as tStringGrid);
        end
        else
        begin
          { cell doesn't word-wrap }
          DrawRect.Right:= Rect.Right;
          FillRect(DrawRect);
          case Just of
            taLeftJustify : DrawText(Handle, PChar(S), length(S),
            DrawRect,
            dt_wordbreak or dt_left);
            taCenter : DrawText(Handle, PChar(S), length(S),
            DrawRect,
            dt_wordbreak or dt_center);
            taRightJustify : DrawText(Handle, PChar(S), length(S),
            DrawRect,
            dt_wordbreak or dt_right);
          end;
        end;  // if
      end
      else
        { no word wrap }
        case Just of
          taLeftJustify : DrawText(Handle, PChar(S), length(S), DrawRect,
          dt_singleline or dt_vcenter or dt_left);
          taCenter : DrawText(Handle, PChar(S), length(S), DrawRect,
          dt_singleline or dt_vcenter or dt_center);
          taRightJustify : DrawText(Handle, PChar(S), length(S), DrawRect,
          dt_singleline or dt_vcenter or dt_right);
        end;  // case
      // restore no font styles
      Font.Style:= [];
    end;  // if
  end;  // with*)
end;

procedure TFrmStaffTT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(MancoverDlg) and Assigned(MancoverDlg.CheckBox1) then
    MancoverDlg.CheckBox1.Checked := False;
end;

procedure TFrmStaffTT.FormCreate(Sender: TObject);
begin
  FEntryDays := TEntryDays.Create;
end;

procedure TFrmStaffTT.FormDestroy(Sender: TObject);
begin
  if Assigned(FEntryDays) then
    FreeAndNil(FEntryDays);
end;

procedure TFrmStaffTT.FormShow(Sender: TObject);
var
  //dI: Integer;
  lWidth: Integer;
  i: Integer;
begin
  lWidth := 0;
  grdTeacherTT.DefaultColWidth := 80;
  //for dI := 0 to Days - 1 do
  //begin
    grdTeacherTT.ColWidths[0] := 96;
    Inc(lWidth, grdTeacherTT.ColWidths[0]);
    grdTeacherTT.RowHeights[0] := 16;
    grdTeacherTT.Cells[1, 0] := 'Time Slot';

    Inc(lWidth, grdTeacherTT.DefaultColWidth);
    grdTeacherTT.Cells[1, 0] := 'Subject';

    grdTeacherTT.ColWidths[2] := 40;
    Inc(lWidth, grdTeacherTT.ColWidths[2]);
    grdTeacherTT.Cells[2, 0] := 'Room';

    grdTeacherTT.ColWidths[3] := 40;
    Inc(lWidth, grdTeacherTT.ColWidths[3]);
    grdTeacherTT.Cells[3, 0] := 'Year';

    grdTeacherTT.ColWidths[4] := 50;
    Inc(lWidth, grdTeacherTT.ColWidths[4]);
    grdTeacherTT.Cells[4, 0] := 'Class';

    Inc(lWidth, grdTeacherTT.DefaultColWidth);
    grdTeacherTT.Cells[5, 0] := 'Status';

    grdTeacherTT.ColWidths[6] := 100;
    Inc(lWidth, grdTeacherTT.ColWidths[6]);
    grdTeacherTT.Cells[6, 0] := 'Cover Note';

    for i := 1 to 6 do
      grdTeacherTT.CellStyle[i, 0].HorizontalAlignment := taCenter;

  //end; //for dI
  Self.ClientWidth := lWidth + 10;
  Self.ClientHeight := pnlHeading.Height + 36 + Periods * grdTeacherTT.DefaultRowHeight;
  FIsOKToRefreshTT := False;
end;

procedure TFrmStaffTT.kgdTeacherTTDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  DrawSGCell(Sender, ACol, ARow, Rect, [], True, taCenter, False);
end;

function TFrmStaffTT.PopulateFieldData(aFieldName: string): Variant;
begin
  Result := GetFieldValue(pipTeacherTtReport.RecordIndex, aFieldName);
end;


function TFrmStaffTT.GetFieldValue(pRecIndex: Integer; const pFieldName: string): Variant;
begin
  if pFieldName = 'fldTeacherName' then
    Result := TEntryDay(FEntryDays.Items[pRecIndex - 1]).FTeacherName
  else if pFieldName = 'fldFaculty' then
    Result := TEntryDay(FEntryDays.Items[pRecIndex - 1]).FFaculty
  else if pFieldName = 'fldAbsenceReason' then
    Result := TEntryDay(FEntryDays.Items[pRecIndex - 1]).FAbsenceReason
  else if pFieldName = 'fldAddedStaff' then
    Result := TEntryDay(FEntryDays.Items[pRecIndex - 1]).FAddedStaff
  else if pFieldName = 'fldCasual' then
    Result := Fcasual
  else if pFieldName = 'fldPeriod' then
    Result := TEntryDay(FEntryDays.Items[pRecIndex - 1]).FPeriodName
  else if pFieldName = 'fldTimeRange' then
    Result := TEntryDay(FEntryDays.Items[pRecIndex - 1]).FTimeRange
  else if pFieldName = 'fldSubject' then
  begin
      Result := TEntryDay(FEntryDays.Items[pRecIndex - 1]).FSubjectCode;
      if Result = '' then
        Result := '(Free)'
  end
  else if pFieldName = 'fldRoom' then
  begin    Result := TEntryDay(FEntryDays.Items[pRecIndex - 1]).FRoomName;
      if Result = 'Free' then
        txtRoom.Font.Color := clBlack
      else
        txtRoom.Font.Color := clTeal;
  end
  else if pFieldName = 'fldYearName' then
    Result := YearTitle + ' ' + TEntryDay(FEntryDays.Items[pRecIndex - 1]).FYearName;
end;

procedure TFrmStaffTT.PrintPreviewReport(Sender: TObject);
begin
  PrintTeacherTtReport(OtScreen);
end;

procedure TFrmStaffTT.PrintPreviwTimetable(Sender: TObject);
begin
  TeTTSelection[0] := 1;
  TeTTSelection[1] := SelectedTe;
  TeTTListVals[3] := 0;    //fac
  TeTTSelType := 2;  //selection
  winView[wnTeacherTt] := 1; //weekly
  TeachTtablewinSelect;
  UpdateWindow(wnTeacherTt);
  FIsOKToRefreshTT := True;
end;

procedure TFrmStaffTT.PrintTeacherTtReport(const pOutputType: TOutputType);
begin
  pipTeacherTtReport.InitialIndex := 1;
  pipTeacherTtReport.RecordCount := FEntryDays.Count;
  lblSchoolName.Caption := School;
  repTeacherTtReport.DeviceType := GetDeviceType(pOutputType);
  repTeacherTtReport.Print;
end;

function TFrmStaffTT.RefreshTimetable: Boolean;
var
  //dI,
  Ip, p: Integer;
  i: Integer;
  lCelEntry: string;
  lFaculties: string;
  lEntryDay: TEntryDay;
  lTimeRange: string;
  lReason: string;

  function GetAddTtItem(ETcode, P: Integer): string;
  var
    j: integer;
    lStr: string;
  begin
    for j := 1 to NumChanges do
    begin
      if Changes[j].NewTe = ETcode then
      begin
        if (Changes[j].TimeSlot = p)  then
//        if (Changes[j].TimeSlot = p) and (Changes[j].Kind = 1) then
        begin
          lEntryDay.FTeacherName := TeCode[Changes[j].OldTe, 0];
          lEntryDay.FDayID := 0; //ToDo
          lEntryDay.FDayName := DayName[lEntryDay.FDayID];
          if (lReason = '') and (Absent[Changes[j].Reason] <> '') then
            lReason := Absent[Changes[j].Reason];
          lEntryDay.FAbsenceReason := lReason;
          lStr := SubCode[Changes[j].Sub];
          lEntryDay.FSubjectID := Changes[j].Sub;
          lEntryDay.FSubjectCode := lStr;
          if (FCasual = '') and (ETname[ETcode] <> '') then
            FCasual := ETname[ETcode];
          lEntryDay.FAddedStaff := ETname[ETcode];
          //lStr := lStr + #10#13 + TeCode[Changes[j].NewRoom, 1];
          lEntryDay.FRoomName := TeCode[Changes[j].NewRoom, 1];
          //lStr := lStr + #10#13 + YearName[Changes[j].Year];
          lEntryDay.FYearName := YearName[Changes[j].Year];
          lEntryDay.FCoverNote := ExNote[Changes[j].Notes];
          lEntryDay.FStatus := GenType3(j);
          if (Changes[j].newroom > 0) and (Changes[j].oldroom > 0) and (Changes[j].newroom <> Changes[j].oldroom) then
            FRoomChange := True;
          Break;
        end;
      end;
    end; {for j}
    if Trim(lStr) <> '' then
      Result := lStr
    else
      Result := '(Free)';
  end;

  // Passed Ip to help with #72
  function GetTtItems(i, d, p, Ip: Integer): string;
  var
    ro, sc,teyear,lev: Integer;
    j: Integer;
  begin
    ro := 0;
    Sc := 0;
    TeYear := 0;
    Lev := 0;
    lEntryDay := TEntryDay.Create;
    lEntryDay.FDayID := 0; ///ToDo
    lEntryDay.FDayName := DayName[lEntryDay.FDayID];
    lEntryDay.FTeacherName := TeCode[i, 0];
    lEntryDay.PeriodID := TsShow[d, p + 1];
    lEntryDay.PeriodName := TimeSlotName[d, lEntryDay.PeriodID];
    lEntryDay.Faculty := lFaculties;
    lEntryDay.FTimeRange := lTimeRange;
    lEntryDay.FAbsenceReason := Absent[TAbsReason[i]];

    // Put this chunk of code here to help with #72
      for j := 1 to NumChanges do
      begin
         // OldTe and i will never match ?
         // Kind =1 - what about the others
        if  (Changes[j].newte = i) and (Changes[j].TimeSlot = Ip)  then
//        if (Changes[j].OldTe = i) and (Changes[j].TimeSlot = p) and (Changes[j].Kind = 1) then
        begin
          lEntryDay.FDayID := 0; ///ToDo
          lEntryDay.FDayName := DayName[lEntryDay.FDayID];
          if (lReason = '') and (Absent[Changes[j].Reason] <> '') then
            lReason := Absent[Changes[j].Reason];
          lEntryDay.FAddedStaff := ETname[Changes[j].NewTe];
          if (FCasual = '') and (lEntryDay.FAddedStaff <> '') then
            FCasual := lEntryDay.FAddedStaff;
          lEntryDay.FAbsenceReason := lReason;
          lEntryDay.FSubjectID := Changes[j].Sub;
          lEntryDay.FSubjectCode := SubCode[Changes[j].Sub];
          lEntryDay.FRoomName := TeCode[Changes[j].NewRoom, 1];
          lEntryDay.FYearName := YearName[Changes[j].Year];
          lEntryDay.FRollClass := ClassCode[ClassShown[Lev,teyear]];
          lEntryDay.FStatus := FTeStatus;
          lEntryDay.FCoverNote := FTeCover;
          Break;
        end;
      end;

    if GetTeachTtItem(sc, ro, TeYear, Lev, i, d, lEntryDay.PeriodID) then
    begin
      if (Sc <> subNA) then
      begin
        //inc(tscount);
        //ldcount:=ldCount+tsAllot[d,p];
      end;
      lEntryDay.FSubjectID := Sc;
      if Sc > 0 then
        lEntryDay.FSubjectCode := Trim(SubCode[Sc]);
      if ro > 0 then
        lEntryDay.FRoomName := Trim(TeCode[ro, 1]);
      if TeYear >= 0 then
        lEntryDay.FYearName := YearName[teYear];

      for j := 1 to NumChanges do
      begin
         // OldTe and i will never match ?
         // Kind =1 - what about the others
        if  (Changes[j].newte = i) and (Changes[j].TimeSlot = p)  then
//        if (Changes[j].OldTe = i) and (Changes[j].TimeSlot = p) and (Changes[j].Kind = 1) then
        begin
          lEntryDay.FDayID := 0; ///ToDo
          lEntryDay.FDayName := DayName[lEntryDay.FDayID];
          if (lReason = '') and (Absent[Changes[j].Reason] <> '') then
            lReason := Absent[Changes[j].Reason];
          lEntryDay.FAddedStaff := ETname[Changes[j].NewTe];
          if (FCasual = '') and (lEntryDay.FAddedStaff <> '') then
            FCasual := lEntryDay.FAddedStaff;
          lEntryDay.FAbsenceReason := lReason;
          lEntryDay.FSubjectID := Changes[j].Sub;
          lEntryDay.FSubjectCode := SubCode[Changes[j].Sub];
          lEntryDay.FRoomName := TeCode[Changes[j].NewRoom, 1];
          lEntryDay.FYearName := YearName[Changes[j].Year];
          lEntryDay.FRollClass := ClassCode[ClassShown[Lev,teyear]];
          lEntryDay.FStatus := FTeStatus;
          lEntryDay.FCoverNote := FTeCover;
          Break;
        end;
      end;
    end;  // if
    FEntryDays.Add(lEntryDay);
    Result := lEntryDay.FSubjectCode;
  end;

begin
  if FEntryDays.Count > 0 then
    FEntryDays.Clear;
  lReason := '';
  FCasual := '';
  if SelectedTe > 1000 then
  begin
    lblHeading.Caption := Trim(EtSub[SelectedTe - 1000]) + '  ' + Trim(ETname[SelectedTe - 1000]);
    if ETfaculty[SelectedTe - 1000] <> -1 then
      lFaculties := FacName[ETfaculty[SelectedTe - 1000]]
    else
      lFaculties := AMG_ALL_FACULTIES;
  end
  else
  begin
    lblHeading.Caption := Trim(TeCode[SelectedTe, 0]) + '  ' + Trim(TeName[SelectedTe, 0]);
    lFaculties := '';
    for i := 1 to nmbrTeFacs do
    begin
      if (lFaculties <> '') and (FacName[TFaculty[SelectedTe, i]] <> '') then
        lFaculties := lFaculties + ', ';
      lFaculties := lFaculties + FacName[TFaculty[SelectedTe, i]];
    end;
  end;
  if lFaculties = '' then
    lFaculties := AMG_NONE;
  lblFaculty.Caption := 'Faculty  ' + lFaculties;
  if lblHeading.Caption = '' then
    lblHeading.Caption := 'No Teacher Name';

  //ShowTnames[0] := True;
  //for dI := 1 to days - 1 do
  //ShowTnames[ttDay] := (tsDayGroup[ttDay] <> tsDayGroup[ttDay - 1]);

  for i := 1 to grdTeacherTT.RowCount - 1 do
    grdTeacherTT.Rows[i].Clear;
  grdTeacherTT.RowCount := 2;

  for Ip := 1 to tsShowMax do
  begin
    lCelEntry := '';
    p := tsShow[ttDay, Ip];
    if (p = 0) and (Ip > 1) then Continue;
    FTeCover := '';
    CheckExtras(p);

    lTimeRange := '';
    //Period names
    //if ShowTnames[ttDay] then
    begin
      lTimeRange := FormatDateTime('h:mmam/pm', TSSTart[ttDay, p]) + ' - ' + FormatDateTime('h:mmam/pm', TSEnd[ttDay, p]);
      grdTeacherTT.Cells[0, p + 1] := TimeSlotName[ttDay, p] + #10#13 + lTimeRange;
      grdTeacherTT.RowCount := grdTeacherTT.RowCount + 1;
      grdTeacherTT.CellStyle[0, p + 1].HorizontalAlignment := taRightJustify;
      //lEntryDay.PeriodName := tsName[dI, p];
    end;

    if SelectedTe > 1000 then
    begin
      lEntryDay := TEntryDay.Create;
      lCelEntry := GetAddTtItem(SelectedTe - 1000, P + 1);
      lEntryDay.FPeriodID := p;
      lEntryDay.FPeriodName := TimeSlotName[ttDay, p];
      lEntryDay.FTimeRange := lTimeRange;
      lEntryDay.Faculty := lFaculties;
      lEntryDay.FCoverNote := FTeCover;
      //lEntryDay.Status := FTeStatus;
      FEntryDays.Add(lEntryDay);
    end
    else
    begin
      //if ttDay = dI then
      lCelEntry := GetTtItems(SelectedTe, ttDay, p, Ip);
    end;
    if Trim(lCelEntry) <> '' then
    begin
      grdTeacherTT.Cells[1, Ip] := lCelEntry;
      grdTeacherTT.Cells[2, Ip] := lEntryDay.FRoomName;
      grdTeacherTT.Cells[3, Ip] := lEntryDay.FYearName;
      grdTeacherTT.Cells[4, Ip] := lEntryDay.FRollClass;
      grdTeacherTT.Cells[5, Ip] := lEntryDay.FStatus;
      grdTeacherTT.Cells[6, Ip] := lEntryDay.FCoverNote;
      //grdTeacherTT.CellStyle[dI + 1, Ip].BGColor := clRelevantControlOnDlg;
    end;
    grdTeacherTT.CellStyle[1, Ip].HorizontalAlignment := taCenter;
    grdTeacherTT.CellStyle[2, Ip].HorizontalAlignment := taCenter;
    grdTeacherTT.CellStyle[3, Ip].HorizontalAlignment := taCenter;
    grdTeacherTT.CellStyle[4, Ip].HorizontalAlignment := taCenter;
    grdTeacherTT.CellStyle[5, Ip].HorizontalAlignment := taCenter;
    grdTeacherTT.CellStyle[6, Ip].HorizontalAlignment := taCenter;
  end; //for Ip
  if grdTeacherTT.RowCount > 2 then
    grdTeacherTT.RowCount := grdTeacherTT.RowCount -1;
  grdTeacherTT.Col := grdTeacherTT.ColCount -1;
  grdTeacherTT.Row := grdTeacherTT.RowCount -1;
  if FIsOKToRefreshTT and (SelectedTe <= 1000) then
    PrintPreviwTimetable(Self);
end;

end.
