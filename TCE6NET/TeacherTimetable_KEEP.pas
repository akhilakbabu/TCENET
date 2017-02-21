unit TeacherTimetable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, FileCtrl, StdCtrls, Grids, NiceGrid, kstrgrid,
  ZColorStringGrid, Contnrs, ppParameter, ppStrtch, ppMemo, ppBands, ppCtrls,
  ppVar, ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppDB, ppComm, ppRelatv,
  ppDBJIT, uAMGCommon, Menus;

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

  TFrmTecaherTT = class(TForm)
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
    popTeacherTTVariationSheet: TMenuItem;
    ppLine1: TppLine;
    txtTeacher: TppDBText;
    txtFaculty: TppDBText;
    txtReason: TppDBText;
    ppShape1: TppShape;
    pipTeacherTtReportppTimeRange: TppField;
    ppDBText5: TppDBText;
    pipTeacherTtReportppCasual: TppField;
    ppDBText3: TppDBText;
    procedure FormShow(Sender: TObject);
    procedure AlignTimeText(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure kgdTeacherTTDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    function PopulateFieldData(aFieldName: string): Variant;
    procedure PrintPreviewReport(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FSelectedTe: Integer;
    FEntryDays: TEntryDays;
    FCasual: string;
    procedure SetGrid(Sender : TObject; C, R : integer; Rect : TRect; Style : TFontStyles; Wrap : boolean; Just : TAlignment; CanEdit : boolean);
    procedure DrawSGCell(Sender: TObject; C, R: Integer; Rect: TRect; Style: TFontStyles; Wrap: Boolean; Just: TAlignment; CanEdit: Boolean);
    function GetFieldValue(pRecIndex: Integer; const pFieldName: string): Variant;
    procedure PrintTeacherTtReport(const pOutputType: TOutputType);
  public
    function RefreshTimetable: Boolean;
    property SelectedTe: Integer read FSelectedTe write FSelectedTe;
  end;

var
  FrmTecaherTT: TFrmTecaherTT;

implementation

uses
  TCEGlobals, TCommon, Tcommon2, DateUtils, uAMGConst;

{$R *.dfm}

procedure TFrmTecaherTT.SetGrid(Sender : TObject; C, R : integer; Rect : TRect; Style : TFontStyles; Wrap : boolean; Just : TAlignment; CanEdit : boolean);
{ draws formatted contents in string grid cell at col C, row R;
Style is a set of fsBold, fsItalic, fsUnderline and fsStrikeOut;
Wrap invokes word wrap for the cell's text; Just is taLeftJustify,
taRightJustify or taCenter; if CanEdit false, cell will be given
the background color of fixed cells; call this routine from
grid's DrawCell event }
var
  lStr: string;
  DrawRect: TRect;
begin
  with (Sender as tStringGrid), Canvas do
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
  end;  // with
end;

(*procedure TFrmTecaherTT.AlignTimeText(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);

   procedure FColor(col1: smallint);
   begin
     grdTeacherTT.canvas.font.color:=FontColorPair[col1,1]; {main color}
     grdTeacherTT.canvas.brush.color:=FontColorPair[col1,2];
   end;
var
   Sentence,                  { What is left in the cell to output }
   CurWord : String;          { The word we are currently outputting }
   SpacePos,                  { The position of the first space }
   CurX,                      { The x position of the 'cursor' }
   CurY : Integer;            { The y position of the 'cursor' }
   EndOfSentence : Boolean;   { Whether or not we are done outputting the cell }
begin
   { Initialize the font to be the control's font }
   Canvas.Font := Font;

   with Canvas do begin
      { If this is a fixed cell, then use the fixed color }
      if gdFixed in State then begin
         //Pen.Color   := FixedColor;
         //Brush.Color := FixedColor;
      end
      { else, use the normal color }
      else begin
         Pen.Color   := Color;
         Brush.Color := Color;
      end;

      { Prepaint cell in cell color }
      Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
   end;

   { Start the drawing in the upper left corner of the cell }
   CurX := Rect.Left;
   CurY := Rect.Top;

   { Here we get the contents of the cell }
   Sentence := (Sender as TStringgrid).Cells[ACol, ARow];
   if Trim(Sentence)  <> '' then
   begin
     //for each word in the cell
     EndOfSentence := FALSE;
     while (not EndOfSentence) do
     begin
        { to get the next word, we search for a space }
        SpacePos := Pos(' ', Sentence);
        if SpacePos > 0 then begin
           { get the current word plus the space }
           CurWord := Copy(Sentence, 0, SpacePos);

           { get the rest of the sentence }
           Sentence := Copy(Sentence, SpacePos + 1, Length(Sentence) - SpacePos);
        end
        else
        begin
           { this is the last word in the sentence }
           EndOfSentence := TRUE;
           CurWord := Sentence;
        end;

        with Canvas do begin
           { if the text goes outside the boundary of the cell }
           //if (TextWidth(CurWord) + CurX) > Rect.Right then
           if (aRow > 0) and (aCol > 0) then
           begin
              { wrap to the next line }
              CurY := CurY + TextHeight(CurWord);
              CurX := Rect.Left;
           end;

           // write out the word
           FColor(cpTeach); //teacher
           TextOut(CurX, CurY, CurWord);
           FColor(cpSub);
           //FColor(cpTeach); //teacher
           //FColor(cpRoom);  //Room color
           { increment the x position of the cursor }
           //CurX := CurX + TextWidth(CurWord);
           //DisplayGridText(grdTeacherTT, Rect, CurWord, taCenter);
        end;
     end;
   end;

*)

(* Merge the whole line
var
  i, x, y: Integer;
begin
  if gdFixed in State then Exit;
  if ARow > 1 then Exit;

  //draw row 1 with text from cell 1,1 spanning all cells in the row
  with Sender as TStringGrid do
  begin
    //extend rect to include grid line on right, if not last cell in row
    if aCol < Pred(ColCount) Then
      Rect.Right := Rect.Right + GridlineWidth;

    //figure out where the text of the first cell would start relative to the current cells rect.
    y := Rect.Top + 2;
    x := Rect.Left + 2;
    for i := 1 to aCol-1 do
      x := x - ColWidths[i] - GridlineWidth;

    //Paint cell pale yellow
    Canvas.Brush.Color := $7FFFFF;
    Canvas.Brush.Style := bsSolid;
    Canvas.FillRect( Rect );
    Canvas.Font := Font;

    //Paint text of cell 1,1 clipped to current cell.
    Canvas.TextRect( Rect, x, y, Cells[2, 2] );
  end;*)


procedure TFrmTecaherTT.AlignTimeText(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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

procedure TFrmTecaherTT.DrawSGCell(Sender : TObject; C, R : integer; Rect : TRect; Style : TFontStyles; Wrap : boolean; Just : TAlignment; CanEdit : boolean);
{ draws formatted contents in string grid cell at col C, row R;
Style is a set of fsBold, fsItalic, fsUnderline and fsStrikeOut;
Wrap invokes word wrap for the cell's text; Just is taLeftJustify,
taRightJustify or taCenter; if CanEdit false, cell will be given
the background color of fixed cells; call this routine from
grid's DrawCell event }
var
  S : string;
  DrawRect : TRect;
begin
  with (Sender as TKStringGrid), Canvas do
  begin
    { erase earlier contents fr om default drawing }
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
  end;  // with
end;

procedure TFrmTecaherTT.FormCreate(Sender: TObject);
begin
  FEntryDays := TEntryDays.Create;
end;

procedure TFrmTecaherTT.FormDestroy(Sender: TObject);
begin
  if Assigned(FEntryDays) then
    FreeAndNil(FEntryDays);
end;

procedure TFrmTecaherTT.FormShow(Sender: TObject);
var
  dI: Integer;
  lWidth: Integer;
begin
  lWidth := 0;
  grdTeacherTT.ColCount := Days + 1;
  grdTeacherTT.DefaultColWidth := 88;
  grdTeacherTT.ColWidths[0] := 115;
  grdTeacherTT.RowHeights[0] := 20;
  Inc(lWidth, 115);
  for dI := 0 to Days - 1 do
  begin
    Inc(lWidth, grdTeacherTT.DefaultColWidth);
    grdTeacherTT.Cells[dI + 1, 0] := DayName[dI];
    grdTeacherTT.CellStyle[dI + 1, 0].HorizontalAlignment := taCenter;
  end; //for dI
  Self.ClientWidth := lWidth + 30;
  Self.ClientHeight := pnlHeading.Height + 30 + Periods * grdTeacherTT.DefaultRowHeight;
end;

procedure TFrmTecaherTT.kgdTeacherTTDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  DrawSGCell(Sender, ACol, ARow, Rect, [], True, taCenter, False);
end;

function TFrmTecaherTT.PopulateFieldData(aFieldName: string): Variant;
begin
  Result := GetFieldValue(pipTeacherTtReport.RecordIndex, aFieldName);
end;


function TFrmTecaherTT.GetFieldValue(pRecIndex: Integer; const pFieldName: string): Variant;
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
      Result := TEntryDay(FEntryDays.Items[pRecIndex - 1]).FSubjectCode
  else if pFieldName = 'fldRoom' then
  begin    Result := TEntryDay(FEntryDays.Items[pRecIndex - 1]).FRoomName;
      if Result = 'Free' then
        txtRoom.Font.Color := clBlack
      else
        txtRoom.Font.Color := clTeal;
  end
  else if pFieldName = 'fldYearName' then
      Result := TEntryDay(FEntryDays.Items[pRecIndex - 1]).FYearName;
end;

procedure TFrmTecaherTT.PrintPreviewReport(Sender: TObject);
begin
  PrintTeacherTtReport(OtScreen);
end;

procedure TFrmTecaherTT.PrintTeacherTtReport(const pOutputType: TOutputType);
begin
  pipTeacherTtReport.InitialIndex := 1;
  pipTeacherTtReport.RecordCount := FEntryDays.Count;
  lblSchoolName.Caption := School;
  repTeacherTtReport.DeviceType := GetDeviceType(pOutputType);
  repTeacherTtReport.Print;
end;

function TFrmTecaherTT.RefreshTimetable: Boolean;
var
  dI, Ip, p: Integer;
  ShowTnames: array[0..nmbrdays] of Boolean;
  i: Integer;
  lCelEntry: string;
  lFaculties: string;
  lEntryDay: TEntryDay;
  lTimeRange: string;
  lReason: string;
  //lTimetablePeriod: TTimetablePeriod;

  function GetAddTtItem(ETcode, P: Integer): string;
  var
    j: integer;
    lStr: string;
  begin
    for j := 1 to NumChanges do
    begin
      if Changes[j].NewTe = ETcode then
      begin
        if (Changes[j].TimeSlot = p) and (Changes[j].Kind = 1) then
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
          lStr := lStr + #10#13 + TeCode[Changes[j].NewRoom, 1];
          lEntryDay.FRoomName := TeCode[Changes[j].NewRoom, 1];
          lStr := lStr + #10#13 + YearName[Changes[j].Year];
          lEntryDay.FYearName := YearTitle + ' ' + YearName[Changes[j].Year];
          Break;
        end;
      end
      else
      begin
        lEntryDay.FRoomName := 'Free';
      end;
    end; {for j}
    if Trim(lStr) <> '' then
      Result := lStr
    else
      Result := 'Free';
  end;



 {for Ip:=1 to tsShowMax do
 begin
  y2t:=y+txtHeight+3;  y1t:=y-txtHeight-6;
  dec(y,txtheight);
  for dI:=0 to days-1 do
  begin
   p:=tsShow[dI,Ip];
   if (p=0) and (Ip>1) then continue;
   if ShowTnames[dI] then
    begin
     inc(y,txtHeight);
     x:=dayStart[dI]+blankwidth div 3;
     fcolor(cpNormal);
     printw(tsName[dI,p]);
     dec(y,txtheight);
    end;
   x:=dayStart[dI]; if ShowTnames[dI] then inc(x,tab1);
   ShowTtItems(studnum,dI,p,x);
  end;} //for dI



  function GetTtItems(i, d, p: Integer): string;
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
    lEntryDay.PeriodName := TsName[d, lEntryDay.PeriodID];
    lEntryDay.Faculty := lFaculties;
    lEntryDay.FTimeRange := lTimeRange;
    lEntryDay.FAbsenceReason := Absent[TAbsReason[i]];
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
      if TeYear > 0 then
        lEntryDay.FYearName := YearName[teYear];

      for j := 1 to NumChanges do
      begin
        if (Changes[j].OldTe = i) and (Changes[j].TimeSlot = p) and (Changes[j].Kind = 1) then
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
          lEntryDay.FYearName := YearTitle + ' ' + YearName[Changes[j].Year];
          Break;
        end;
      end;
    end;  // if
    FEntryDays.Add(lEntryDay);
    Result := '';
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

  ShowTnames[0] := True;
  for dI := 1 to days - 1 do
    ShowTnames[dI] := (tsDayGroup[dI] <> tsDayGroup[dI - 1]);

  for i := 1 to grdTeacherTT.RowCount - 1 do
    grdTeacherTT.Rows[i].Clear;
  grdTeacherTT.RowCount := 2;

  for Ip := 1 to tsShowMax do
  begin
    for dI := 0 to Days - 1 do
    begin
      lCelEntry := '';
      p := tsShow[dI,Ip];
      if (p = 0) and (Ip > 1) then Continue;

      lTimeRange := '';
      //Period names
      if ShowTnames[dI] then
      begin
        lTimeRange := FormatDateTime('h:mmam/pm', TSSTart[dI, p]) + ' - ' + FormatDateTime('h:mmam/pm', TSEnd[dI, p]);
        grdTeacherTT.Cells[0, p + 1] := tsName[dI, p] + #10#13 + lTimeRange;
        grdTeacherTT.RowCount := grdTeacherTT.RowCount + 1;
        grdTeacherTT.CellStyle[0, p + 1].HorizontalAlignment := taRightJustify;
        //lEntryDay.PeriodName := tsName[dI, p];
      end;

      if SelectedTe > 1000 then
      begin
        if ttDay = dI then
        begin
          lEntryDay := TEntryDay.Create;
          lCelEntry := GetAddTtItem(SelectedTe - 1000, P + 1);
          lEntryDay.FPeriodID := p;
          lEntryDay.FPeriodName := tsName[dI, p];
          lEntryDay.FTimeRange := lTimeRange;
          lEntryDay.Faculty := lFaculties;
          FEntryDays.Add(lEntryDay);
        end;
      end
      else
      begin
        if ttDay = dI then
          lCelEntry := GetTtItems(SelectedTe, dI, p);
      end;
      if Trim(lCelEntry) <> '' then
      begin
        grdTeacherTT.Cells[dI + 1, Ip] := lCelEntry;
        grdTeacherTT.CellStyle[dI + 1, Ip].HorizontalAlignment := taCenter;
        //grdTeacherTT.CellStyle[dI + 1, Ip].BGColor := clRelevantControlOnDlg;
      end;
    end; {for dI}
    //lTimetablePeriod.EntryDays := lEntryDays;
  end; //for Ip
  if grdTeacherTT.RowCount > 2 then
    grdTeacherTT.RowCount := grdTeacherTT.RowCount -1;
end;

end.
