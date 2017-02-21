unit Ttable;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Grids, StdCtrls, Menus,TCEglobals, GlobalToTcAndTcextra;

type
  TTtablewin = class(TForm)
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    Selection1: TMenuItem;
    N1: TMenuItem;
    PrintSetup1: TMenuItem;
    Print1: TMenuItem;
    MainMenu1: TMainMenu;
    Timetable1: TMenuItem;
    Configure1: TMenuItem;
    Timetable2: TMenuItem;
    N2: TMenuItem;
    Home1: TMenuItem;
    Goto1: TMenuItem;
    Goto2: TMenuItem;
    ShowSubjectTimetable1: TMenuItem;
    ShowTeacherTimetable1: TMenuItem;
    ShowRoomTimetable1: TMenuItem;
    ShowClassTimetable1: TMenuItem;
    Copy1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; Col, Row: Longint;
      var CanSelect: Boolean);
    procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1TopLeftChanged(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StringGrid1ColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Longint);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Selection1Click(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Home1Click(Sender: TObject);
    procedure Goto1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ShowSubjectTimetable1Click(Sender: TObject);
    procedure ShowTeacherTimetable1Click(Sender: TObject);
    procedure ShowRoomTimetable1Click(Sender: TObject);
    procedure ShowClassTimetable1Click(Sender: TObject);
    procedure Configure1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 procedure updateClashStatusBar(aForm: TTtablewin);
 procedure PeriodClash(d,p: integer);
 function FindCol(d,p: byte): integer;
 function FindRow(y,l: byte): integer;
 procedure BringIntoView;
 procedure MoveSelect(moveType: byte);
 procedure ttclash;
 procedure clashtotal;
 function FindLabel: integer;
 procedure ShowCurrentCell;
 function GetBlockLevels(d,p,y,l:integer; var ml1,ml2: integer): boolean;

var
  Ttablewin: TTtablewin;


procedure maintimetableprint;
procedure maintimetableOut;

implementation
uses main, tcommon, printers, ttprnsel, TtGoTo,tcommon2,ClassDefs;
{$R *.DFM}

 type TPrintTtableWin=class(TPrintDrawWin)
  public
   procedure head; override;
   procedure SetTabs; override;
   procedure PrintTtable;
 end;

 type TOutTtableWin=class(TOutputWin)
  public
   procedure head; override;
   procedure OutTtable;
   procedure GenericTimetabletext;
 end;

type
 tpteon=array[0..nmbrteachers,0..nmbrperiods] of integer;

var
 PrintTtableWin:    TPrintTtableWin;
 OutTtableWin:     TOutTtableWin;
 doubleclick: boolean;
 drawingClashBar: boolean;
 TeachOn: tpteon;

procedure ClearTeachOn;
var
 i,p: integer;
begin
 for i:=0 to nmbrteachers do
   for p:=0 to nmbrperiods do
    Teachon[i,p]:=0;
end;

function GetBlockLevels(d,p,y,l:integer; var ml1,ml2: integer): boolean;
var
 Sbyte,Nblock: byte;
 l2:    integer;
begin
 result:=false;
 Sbyte:=FNTbyte(d,p,y,l,6)^;
 Nblock:=sByte shr 3;
 if Nblock=0 then exit;
 result:=true;
 for l2:=1 to l do
  begin
   Sbyte:=FNTbyte(d,p,y,l2,6)^;
   if Nblock=(sByte shr 3) then
    begin
     ml1:=l2;
     break;
    end;
  end;
 for l2:=l to level[y] do
  begin
   Sbyte:=FNTbyte(d,p,y,l2,6)^;
   if Nblock=(sByte shr 3) then
     ml2:=l2;
  end;
end;


function FindLabel: integer;
var
 i,found: integer;
begin
 if Lnum=0 then
  begin
   inc(Lnum);
   result:=Lnum;
   exit;
  end;
 found:=0;
 for i:=1 to Lnum do
  if TcLabel[i]='' then
   begin
    found:=i;
    break;
   end;
 if (found=0) and (Lnum<nmbrLabels) then
  begin
   inc(Lnum);
   found:=Lnum;
  end;
 result:=found;
end;

function FindRow(y,l: byte): integer;
var
 i,count: integer;
begin
 count:=1;
 if y<years_minus_1 then for i:=years_minus_1 downto y+1 do
  inc(count,level[i]+1);
 inc(count,l+1);
 result:=count;
end;

function FindCol(d,p: byte): integer;
var
 i,count: integer;
begin
 count:=0;
 if d>0 then for i:=0 to d-1 do
  inc(count,Tlimit[i]);
 inc(count,p+1);
 result:=count;
end;

procedure BringIntoView;
var
  TRow,LCol,CurRow,CurCol,ShowCols,ShowRows,MaxRows,MaxCols: integer;
begin
 with Ttablewin.StringGrid1 do
  begin
   MaxRows:=RowCount-2;  MaxCols:=ColCount-1;
   ShowCols := (Gridwidth-ColWidths[0]) div ColWidths[1];
   if ShowCols<1 then ShowCols:=1;
   if ShowCols>MaxCols then ShowCols:=MaxCols;
   ShowRows:=(GridHeight-RowHeights[0]-RowHeights[1]) div RowHeights[2];
   if ShowRows>MaxRows then ShowRows:=MaxRows;
   if ShowRows < 1 then ShowRows := 1;
   TRow:=FindRow(yl,ll); LCol:=FindCol(dl,pl);  {current top row & left col}
   CurRow:=FindRow(ny,nl); CurCol:=FindCol(nd,np);  {current position}
   if CurRow>RowCount then CurRow:=RowCount;
   if CurCol>ColCount then CurCol:=ColCount;
   
   if (CurCol>(LCol+ShowCols-2)) and (CurCol<(LCol+ShowCols+1)) then
      LCol:=CurCol-ShowCols+2;
   if (CurCol>LCol+ShowCols) then LCol := CurCol;
   if CurCol<LCol then LCol:=CurCol;
   if LCol < 1 then LCol := 1;
   if LCol > ColCount-ShowCols then LCol:=ColCount-ShowCols;

   if (CurRow>(TRow+ShowRows-2)) and (CurRow<(TRow+ShowRows+1)) then
      TRow:=CurRow-ShowRows+2;
   if (CurRow>TRow+ShowRows) then TRow:=CurRow;
   if CurRow < TRow then TRow := CurRow;
   if (TRow=CurRow) and (nl=1) then dec(TRow);
   if TRow < 2 then TRow := 2;
   if TRow>RowCount-ShowRows+1 then TRow:=RowCount-ShowRows+1;
   ttCalc(TRow, LCol);
   dl := ttcalcD; pl := ttcalcP; yl := ttcalcY; ll := ttcalcL;
   LeftCol := LCol;
   TopRow := TRow;
   ShowCurrentCell;
  end;
end;

procedure ttclash;
var
 d,p: integer;
begin
 for d:=0 to days-1 do
  for p:=0 to Tlimit[d]-1 do
   periodclash(d,p);
 clashtotal;
end;

procedure clashtotal;
var
 i,j: integer;
begin
TclashTot:=0; RclashTot:=0;
 for i:=0 to days-1 do
  for j:=0 to periods-1 do
  begin
   inc(TclashTot,Tclash[i,j]);
   inc(RclashTot,Rclash[i,j]);
  end;
end;

procedure updateClashStatusBar(aForm: TTtablewin);
var
 p,d,i:     integer;
 blankwidth:            integer;
 theight:               integer;
 localx:                integer;
 basex:                 integer;
 aRect:                 trect;
 tmpcanvasbitmap:       Tbitmap;
 GridSpaceUsed:         integer;
begin
 if drawingClashBar then exit;
 drawingClashBar:=true;
     aForm.image1.width:=aForm.width;
     aForm.image1.height:=aForm.canvas.textheight('Ag')*2;
    {ensure canvas on image resizes so shove an image into it}
     tmpcanvasbitmap:=Tbitmap.create;
     tmpcanvasbitmap.width:=aForm.image1.width;
     tmpcanvasbitmap.height:=aForm.image1.height;
     aForm.image1.picture.graphic:=tmpcanvasbitmap;
     tmpcanvasbitmap.free;
     {after canvas finally resized, its forgotten what the font is -restore it}
     aForm.image1.canvas.font.assign(tcfont);
 aRect.top:=0; aRect.bottom:=aForm.image1.height; aRect.left:=0; aRect.right:=aForm.image1.width;
 aForm.image1.canvas.brush.color:=clSilver;
 aForm.image1.canvas.fillrect(aRect);
 blankwidth:=aForm.image1.canvas.textwidth(' ');
 theight:=aForm.image1.canvas.textheight('Ag');
 with aForm.Stringgrid1 do
  begin
   if leftcol<1 then leftcol:=1;
   ttcalc(toprow,leftcol);
   p:=ttcalcP;    d:=ttcalcD;
   basex:=colwidths[0]{+blankwidth};
   inc(basex,aForm.stringgrid1.gridLineWidth*2);
  end; {with Ttablewin.Stringgrid1}
 clashtotal;


   aForm.image1.canvas.font.color:=FontColorPair[cpTeach,1];
   aForm.image1.canvas.textout(0,0,'T:'+inttostr(TclashTot));
   aForm.image1.canvas.font.color:=FontColorPair[cpRoom,1];
   aForm.image1.canvas.textout(0,theight,'R:'+inttostr(RclashTot));

 GridSpaceUsed:=0;
 for i:=aForm.stringgrid1.leftcol to (aForm.stringgrid1.colcount-1) do
 begin
  inc(GridSpaceUsed,aForm.stringgrid1.colwidths[i]);
  if GridSpaceUsed>=aForm.stringgrid1.clientwidth then break;
 end;

 i:=0;
 while ((basex<GridSpaceUsed) {and (d<=days) and (p<=periods)})do
 begin
  localx:=basex+blankwidth*2{3}+fwCodeBlank[0];
  aForm.image1.canvas.font.color:=FontColorPair[cpTeach,1];
  aForm.image1.canvas.textout(localx,0,inttostr(Tclash[d,p]));
  localx:=localx+blankwidth{+halfblankwidth}+fwCodeBlank[1];
  aForm.image1.canvas.font.color:=FontColorPair[cpRoom,1];
  aForm.image1.canvas.textout(localx,theight,inttostr(Rclash[d,p]));
  inc(basex,aForm.stringgrid1.colwidths[aForm.stringgrid1.leftcol+i]);
  inc(i);
  inc(basex,aForm.stringgrid1.gridLineWidth);
  inc(p);
  if (p>={periods}tlimit[d]) then
  begin
   p:=0;
   inc(d);
  end;
  if (d>=days) then break;
 end;  {while (basex<Ttablewin.stringgrid1.clientwidth) }

 drawingClashBar:=false;
end;

procedure TTtablewin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
 wnFlag[wnTtable]:=false;   {need to create on next request}
 savewinpos(self);
end;

procedure TTtablewin.FormActivate(Sender: TObject);
var
 aRect:   trect;
begin
 self.font.assign(tcFont);
 label1.left:=panel1.clientwidth-label1.width;
 aRect.top:=0; aRect.bottom:=image1.height; aRect.left:=0; aRect.right:=image1.width;
 self.image1.canvas.brush.color:=clSilver;
 self.image1.canvas.fillrect(aRect);
 Mainform.UpdateToolbarIcons;
end;

procedure ShowCurrentCell;
begin
 with ttablewin do
  begin
   case box of
    bxcell: label1.caption:='['+yearshort+' '+yearname[ny]
      +' Lev:'+ inttostr(nl)+' '+Day[nd]+':'+inttostr(np+1)+']  ';
    bxLevel: label1.caption:='['+yearshort+' '+yearname[ny]
     +' Lev:'+ inttostr(nl)+']  ';
    bxYear: label1.caption:='['+yearshort+' '+yearname[ny]+']  ';
    bxYrTime: label1.caption:='['+yearshort+' '+yearname[ny]
     +' '+Day[nd]+':'+inttostr(np+1)+']  ';
    bxTime: label1.caption:='['+' '+Day[nd]+':'+inttostr(np+1)+']  ';
    bxblock: label1.caption:='['+yearshort+' '+yearname[ny]
     +' Lev:'+ inttostr(nl)+' '+Day[nd]+':'+inttostr(np+1)+']  ';
    bxday: label1.caption:='['+Day[nd]+']  ';
   end;
  label1.left:=panel1.clientwidth-label1.width;
 end; {with}

end;

procedure TTtablewin.StringGrid1SelectCell(Sender: TObject; Col,
  Row: Longint; var CanSelect: Boolean);
begin
 ttcalc(row,col);
 np:=ttcalcP;  nd:=ttcalcD;
 ny:=ttcalcY;  nl:=ttcalcL;
 ShowCurrentCell;
 ttablewin.repaint;
end;

procedure TTtablewin.StringGrid1DrawCell(Sender: TObject; Col,
  Row: Longint; Rect: TRect; State: TGridDrawState);
var
 d,p,y,l:       smallint;
 i,m,n:       smallint;
 a,x:                 longint;
 tempPointer:       pointer;
 tempIntPointer:    ^smallint;
 tmpStr:            string;
 localx,localy:     integer;
 blankwidth:        integer;
 topgap:            integer;
 oldbrushColor:     Tcolor;
 flgDouble:    boolean; {first 3 bits of 7th byte}
 blockNumber:                  smallint; {last 5 bits of 7th byte}
 flgTclash,flgRclash:          boolean; {4th & 5th (vals 8 &16) bits of 8th byte}
 sByte,cByte:                  byte;
 aRect:                        Trect; {for aligning highlights}
 fontHeight:                   integer;
 origColor:                    Tcolor;
 tlimitTotal:                  integer;

   procedure fcolor(col1: smallint);
   begin
    stringgrid1.canvas.font.color:=FontColorPair[col1,1]; {main color}
    stringgrid1.canvas.brush.color:=FontColorPair[col1,2];
   end;

begin
  localx:=0; localy:=0;
 origColor:=self.stringgrid1.canvas.brush.color;
 x:=years+1;     {plus 1 for period name row}
 for i:=years_minus_1 downto 0 do inc(x,Level[i]);
 if (row>x) then
 begin
  exit; {bottom max}
 end;
 tlimitTotal:=0;
 for i:=0 to days-1 do
  inc(tlimitTotal,tlimit[i]);
 if (col>tlimitTotal) then
 begin
  exit; {right max}
 end;
 ttcalc(row,col);
 p:=ttcalcP;  d:=ttcalcD;
 m:=ttcalcY;
 y:=m;
 n:=ttcalcL;
 l:=n;
 blankwidth:=stringgrid1.canvas.textwidth(' ');
 fontHeight:=stringgrid1.canvas.textheight('Ag');
 topgap:=blankwidth div 2;
 oldBrushColor:=stringgrid1.canvas.brush.color;
 if ((col<1) or (row<2)) then
 begin
  if col=0 then
  begin
   if row<2 then exit;
   fcolor(cpInfoHead);  {info win header color}
   if l=0 then
   begin
    tmpStr:=yearshort+' '+yearname[y];
    localx:=rect.left+blankwidth;
   end
   else
    begin
     tmpStr:=ClassCode[ClassShown[l,y]];
     localx:=rect.left+(rect.right-rect.left)-stringgrid1.canvas.textwidth(tmpStr)-blankwidth;
    end;
   stringgrid1.canvas.TextOut(localx,rect.top+topgap,tmpStr);
  end;
  if row=0 then
  begin
   if col<1 then exit;
   fcolor(cpInfoHead);   {info win header color}
   tmpStr:=Day[d]+':'+inttostr(p+1);
   localx:=rect.left+((rect.right-rect.left) div 2)-(stringgrid1.canvas.textwidth(tmpStr) div 2);
   stringgrid1.canvas.TextOut(localx,rect.top+topgap,tmpStr);
  end;
  if row=1 then
  begin
   if col<1 then exit;
   fcolor(cpInfoHead);   {info win header color}
   tmpStr:=TimeSlotName[d,p];
   localx:=rect.left+((rect.right-rect.left) div 2)-(stringgrid1.canvas.textwidth(tmpStr) div 2);
   stringgrid1.canvas.TextOut(localx,rect.top+topgap,tmpStr);
  end;
 end
 else  {main grid data}
 if l<>0 then {---------- DO NOT DISPLAY LEVEL 0 (ZERO) EVEN IF HAS DATA ---------------}
  begin
   a:=(word(ttMemSetting2.Value)*word(p))+(word(ttMemorySetting1.Value)*word(y))+(8*word(l){(l-1)});
   {parse flags etc.}
   tempPointer:=ttMain[d];
   tempIntPointer:=tempPointer;
   inc(tempIntPointer,((a+(3*2)) div 2));  {i:0..3 sub,teach,room,clashflags}
   m:=tempIntPointer^;
   sByte:=m and 255; {7th byte}
   cByte:=m shr 8; {8th byte}
   if ((sByte and 1)=1) then flgDouble:=true  {1st bit}
    else flgDouble:=false;
   blockNumber:=FNgetBlockNumber(d,p,y,l);
   if ((cByte and 8)=8) then flgTclash:=true  {4th bit}
    else flgTclash:=false;
   if ((cByte and 16)=16) then flgRclash:=true  {5th bit}
    else flgRclash:=false;
   {end flag parse}
   for i:=0 to 2 do
   begin
    tempPointer:=ttMain[d];
    tempIntPointer:=tempPointer;
    inc(tempIntPointer,((a+(i*2)) div 2));  {i:0..3 sub,teach,room,clashflags}
    m:=tempIntPointer^;
    stringgrid1.canvas.brush.color:=origColor;
    case i of
     0: begin
         if m>LabelBase then
           begin
            fcolor(cpNormal);   {label}
            if ((m-labelbase)<=nmbrlabels) then tmpStr:=TcLabel[m-LabelBase];
           end
          else if (flgDouble and (blockNumber>0)) then fcolor(cpDoubleBlock) {double subject block}
           else if flgDouble then fcolor(cpDouble)
             else if (blockNumber>0) then fcolor(cpTTblock)
              else  fcolor(cpSub); 
        end;
     1: if flgTclash then fcolor(cpTclash) {teacher clash}
         else fcolor(cpTeach); {teacher}
     2: if flgRclash then fcolor(cpRclash) {room clash color}
         else fcolor(cpRoom);  {room color}
    end;  {case}
    if not(m>LabelBase) then  //already set tmpstr if it's a label
    begin
     if ((m>0) and (m<=numcodes[i])) then
     begin
      case i of
       0: tmpStr:=Subcode[m];
       1: tmpStr:=TeCode[m,0];
       2: tmpStr:=TeCode[m,1];
      end;  {case}
     end
     else
      begin
       if l=0 then tmpStr:=''
       else
        begin
         case i of
          0: tmpStr:=copy('____________________',1,lencodes[0]){'__'};
          1: tmpStr:=copy('--------------------',1,lencodes[1]){'--'};
          2: tmpStr:=copy('....................',1,lencodes[2]){'..'};
         end; {case}
        end;
      end;
    end; {if not(m>LabelBase) then}
   { alligns:=0; }
    case i of
     0: begin
         localx:=rect.left+blankwidth;
         localy:=rect.top+topgap;
        end;
     1: begin
         localx:=rect.left+blankwidth+fwCodeBlank[0]+blankwidth;
         localy:=rect.top+topgap;
        end;
     2: begin
         localx:=rect.left+blankwidth+fwCodeBlank[0]+fwCodeBlank[1]+{alligns+}{fwCode[0]+fwCode[1]+}blankwidth*2;
         localy:=rect.top+topgap;
        end;
    end; {case}

    if (tmpStr>'') then  {only paint background if outputting text also}
     begin
  {   fill out rects to straighten up highlight alignments- i.e. get uniform sized highlights }
     case i of
      0: begin  {subject}
          if m>LabelBase then   {label}
           aRect.right:=localx+ttablewin.stringgrid1.canvas.textwidth(tmpStr)
          else          {subject -use font widths already calculated}
           aRect.right:=localx+fwCode[0];
         end;
      1: begin  {teacher}
          aRect.right:=localx+fwCode[1];
         end;
      2: begin  {room}
          aRect.right:=localx+fwCode[2];
         end;
     end;  {case}
     aRect.left:=localx; aRect.top:=localy; aRect.bottom:=aRect.top+fontHeight;
     stringGrid1.canvas.fillrect(aRect);   { create  uniformly sized highlights}
    end;
    stringgrid1.canvas.TextOut(localx,localy,tmpStr);
    if m>LabelBase then break; {finish i loop}
   end;  {for i}
  end;  {if ((col<1)  or  (row<2))}
 stringgrid1.canvas.brush.color:=oldBrushColor;
 if ((row=stringgrid1.toprow) and (col=stringgrid1.leftcol)) then   {only once per paint}
  updateClashStatusBar(Ttablewin);
end;

procedure TTtablewin.StringGrid1TopLeftChanged(Sender: TObject);
var
 p,d,y,l:     integer;
 blankwidth:            integer;
begin
 if scalingGridCellsFlag then exit;   {try to prevent multiple repaints as topleft changes as colwidth and rowheight change}
 blankwidth:=self.Stringgrid1.canvas.textwidth(' ');

 ttcalc(self.Stringgrid1.toprow,self.Stringgrid1.leftcol);
 p:=ttcalcP;  d:=ttcalcD;
 y:=ttcalcY;  l:=ttcalcL;

 {update vars}
  yl:=y;  ll:=l;  pl:=p;  dl:=d{+1};

 if l<1 then l:=1; {no zero level}
 label2.caption:='Top :'+yearshort+' '+yearname[y]+' Lev:'+ inttostr(l)+'  ';
 label2.left:=blankwidth;
 updateClashStatusBar(self);
end;

procedure TTtablewin.FormResize(Sender: TObject);
{var
 aRect:   trect;   }
{ blankwidth:      integer;}
begin
{ aRect.top:=0; aRect.bottom:=self.image1.height; aRect.left:=0; aRect.right:=self.width;
 self.image1.canvas.brush.color:=clSilver;
 self.image1.canvas.fillrect(aRect);    }
 label1.left:=panel1.clientwidth-stringgrid1.canvas.textwidth(label1.caption{+' '});
 if label1.left<label2.left+label2.width+stringgrid1.canvas.textwidth('  ') then
  label1.left:=label2.left+label2.width+stringgrid1.canvas.textwidth('  ');
 updateClashStatusBar(self);
end;

procedure TTtablewin.StringGrid1ColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Longint);
begin
 updateClashStatusBar(self);
end;

procedure TTtablewin.FormCreate(Sender: TObject);
begin
  drawingClashBar:=false;
  label1.caption:='';
  if winpos[wnTtable].height>0 then
   begin
    self.top:=winpos[wnTtable].top;
    self.left:=winpos[wnTtable].left;
    self.width:=winpos[wnTtable].width;
    self.height:=winpos[wnTtable].height;
    self.windowstate:=winpos[wnTtable].state;
   end;
 doubleclick:=false;
end;

procedure TTtablewin.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 aRow,aCol:   longint;
 p,d,k,n:     integer;
 curSelection:        TgridRect;
 i,j:                 integer;
begin
 if doubleclick then
  begin
   doubleclick:=false;
   exit;
  end;
  ttablewin.repaint;
 stringgrid1.mousetocell(x,y,aCol,aRow);
 ttcalc(aRow,aCol);
 p:=ttcalcP;  d:=ttcalcD;
 k:=ttcalcY;  n:=ttcalcL;

 if aRow<2 then
 begin  {period and day}
  if aCol<1 then exit;  {-----------nothing for top left corner---------------}
  if aRow=0 then {day}
  begin
   j:=1;
   for i:=0 to d-1 do
    inc(j,tlimit[i]);
   CurSelection.left:=j;     CurSelection.right:=j+tlimit[d]-1;
   CurSelection.top:=aRow;     CurSelection.bottom:=stringgrid1.rowcount;
   stringgrid1.selection:=CurSelection;
   nd:=d; np:=0; ny:=k; nl:=1;
   box:=6; ShowCurrentCell;
  end
  else
   begin  {period}
    CurSelection.left:=aCol;     CurSelection.right:=aCol;
    CurSelection.top:=aRow;     CurSelection.bottom:=stringgrid1.rowcount;
    stringgrid1.selection:=CurSelection;
    nd:=d; np:=p; ny:=k; nl:=1;
    box:=4; ShowCurrentCell;
   end;
 end {if aRow<2}
  else
  if aCol<1 then
  begin  {class and year}
   if n=0 then
   begin  {year}
    CurSelection.left:=aCol;     CurSelection.right:=stringgrid1.colcount;
    CurSelection.top:=aRow;     CurSelection.bottom:=aRow+level[k];
    stringgrid1.selection:=CurSelection;
    nd:=0; np:=0; ny:=k; nl:=1;
    box:=2; ShowCurrentCell;
   end
   else
   begin {class}
    CurSelection.left:=aCol;     CurSelection.right:=stringgrid1.colcount;
    CurSelection.top:=aRow;     CurSelection.bottom:=aRow;
    stringgrid1.selection:=CurSelection;
    nd:=0; np:=0; ny:=k; nl:=n;
    box:=1;  ShowCurrentCell;
   end;
  end
   else
   begin  {main block}
    if n=0 then {year timeslot}
    begin
    { stringgrid1.col:=aCol;  stringgrid1.row:=aRow+1; }
     CurSelection.left:=aCol;    CurSelection.right:=aCol;
     CurSelection.top:=aRow;     CurSelection.bottom:=aRow+level[k];
     stringgrid1.selection:=CurSelection;
     nd:=d; np:=p; ny:=k; nl:=1;
     box:=3; ShowCurrentCell;
    end
    else
    begin  {invididual cell}
     CurSelection.left:=aCol;     CurSelection.right:=aCol;
     CurSelection.top:=aRow;     CurSelection.bottom:=aRow;
     stringgrid1.selection:=CurSelection;
     nd:=d; np:=p; ny:=k; nl:=n;
     box:=0;
    end;
   end;

end;


procedure TTtablewin.Selection1Click(Sender: TObject);
begin
 ttprintselectiondlg:=Tttprintselectiondlg.create(self);   {allocate dlg}
 ttprintselectiondlg.showmodal;
 ttprintselectiondlg.free;
end;

procedure MoveSelect(moveType: byte);
begin
if moveType=0 then exit{none};
 case moveType of
 1: begin  {right}
     if (nd=days-1) and (np=Tlimit[nd]-1) then exit; {already on right}
     inc(np);
     if (np>=Tlimit[nd]) then
      begin
       np:=0; inc(nd);
      end;
    end;
 2: begin     {left}
     if (nd=0) and (np=0) then exit;
     if (np=0) then
      begin
       dec(nd); np:=Tlimit[nd]-1;
      end else dec(np);
    end;
 3: begin    {down}
     if (ny=0) and (nl=level[ny]) then exit;
     inc(nl);
     if nl>level[ny] then
      begin
       dec(ny); nl:=1;
      end;
    end;
 4: begin     {up}
     if (ny=years_minus_1) and (nl=1) then exit;
     dec(nl);
     if nl<1 then
      begin
       inc(ny); nl:=level[ny];
      end;
    end;
 end; {case}
end;

procedure TTtablewin.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 Srect: TGridRect;
 row,col: longint;
 dochange:        boolean;
begin
 dochange:=false;
 if key=vk_up then
  begin
   key:=0;
   if (nl>1) or (ny<years_minus_1) then
    begin
     MoveSelect(4);
     dochange:=true;
    end;
  end;
 if key=vk_down then
  begin
   key:=0;
   if (ny>0) or (nl<level[ny]) then
    begin
     MoveSelect(3);
     dochange:=true;
    end;
  end;
 if (key=vk_home) then
  begin
   key:=0;
   dochange:=true;
   nd:=hd; np:=hp; ny:=hy; nl:=hl;
  end;
 if (key=vk_prior) then
  begin
   key:=0;
   if (ny<>years_minus_1) then
     begin
      dochange:=true;
      inc(ny); if ny>years_minus_1 then ny:=years_minus_1;
      nl:=1;  yl:=ny; ll:=1;
      row:=FindRow(yl,ll); dec(row);
      StringGrid1.TopRow:=row;
     end;
  end;
 if (key=vk_next) then
  begin
   key:=0;
   if (ny<>0) then
     begin
      dochange:=true;
      if ny>0 then dec(ny);
      nl:=1;  yl:=ny; ll:=1;
      row:=FindRow(yl,ll); dec(row);
      StringGrid1.TopRow:=row;
     end;
  end;
 if (key=190) then {> key}
  begin
   key:=0;
   if nd<days-1 then
    begin
     dochange:=true;
     inc(nd);
    end;
  end;
 if (key=188) then {< key}
  begin
   key:=0;
   if nd>0 then
    begin
     dochange:=true;
     dec(nd);
    end;
  end;

 if dochange then
  begin
   row:=findRow(ny,nl); col:=findCol(nd,np);
   Srect.top:=row;    Srect.left:=col;
   Srect.bottom:=row; Srect.right:=col;
   StringGrid1.selection:=Srect;
   box:=bxcell; BringIntoView;
  end;
end;

procedure PeriodClash(d,p: integer);
 var
  y,l,y2,l2:  integer;
  IntPoint,IntPoint2:  tpIntPoint;
  {tempPoint: pointer;}
  BytePoint,BytePoint2,BytePoint3:  tpBytePoint;
  {sByte,cByte: byte;}
  t1,t2,r1,r2,shareP,shareP2: integer;
begin
 if fclash[d,p]=0 then exit;
 Tclash[d,p]:=0; Rclash[d,p]:=0;
 for y:=0 to years_minus_1 do
  for l:=1 to level[y] do
   FNTByte(d,p,y,l,7)^:=0;
 for y:=0 to years_minus_1 do
  begin
   Intpoint:=FNT(d,p,y,0,4);
   Bytepoint:=FNTByte(d,p,y,0,6);
   for l:=1 to level[y] do
    begin
     inc(Intpoint,3); t1:=Intpoint^;
     inc(Intpoint); r1:=Intpoint^;
     inc(Bytepoint,8); shareP:=2 and Bytepoint^;
     if (t1=0) and (r1=0) then continue;
     for y2:=y to years_minus_1 do
      begin
       Intpoint2:=FNT(d,p,y2,0,4);
       Bytepoint2:=FNTByte(d,p,y2,0,6);
       for l2:=1 to level[y2] do
        begin
         inc(Intpoint2,3); t2:=Intpoint2^;
         inc(Intpoint2); r2:=Intpoint2^;
         inc(Bytepoint2,8); shareP2:=2 and Bytepoint2^;
         if (y2=y) and (l2<=l) then continue;
         if (shareP<>0) and (shareP2<>0) then continue;
         if (t1>0) and (t1=t2) then
          begin
          Bytepoint3:=Bytepoint; inc(Bytepoint3);
          Bytepoint3^:=8 or Bytepoint3^;
          Bytepoint3:=Bytepoint2; inc(Bytepoint3);
          Bytepoint3^:=8 or Bytepoint3^;
          inc(Tclash[d,p]);
          end; {t1=t2}
         if (r1>0) and (r1=r2) then
          begin
          Bytepoint3:=Bytepoint; inc(Bytepoint3);
          Bytepoint3^:=16 or Bytepoint3^;
          Bytepoint3:=Bytepoint2; inc(Bytepoint3);
          Bytepoint3^:=16 or Bytepoint3^;
          inc(Rclash[d,p]);
          end; {t1=t2}
        end; {l2};
      end; {y2}
    end; {l}
  end; {y}
 fclash[d,p]:=0;
end; {periodclash}



procedure TTtablewin.Home1Click(Sender: TObject);
var
 Srect: TGridRect;
 row,col: longint;
 dochange:        boolean;
begin
 dochange:=false;
 if (nd<>hd) or (ny<>hy) or (nl<>hl) or (np<>hp) then dochange:=true;
 nd:=hd; np:=hp; ny:=hy; nl:=hl;
 if dochange then
  begin
   row:=findRow(ny,nl); col:=findCol(nd,np);
   Srect.top:=row;    Srect.left:=col;
   Srect.bottom:=row; Srect.right:=col;
   StringGrid1.selection:=Srect;

  end;
 BringIntoView;
end;

procedure TTtablewin.Goto1Click(Sender: TObject);
begin
 Gotodlg:=TGotodlg.create(self);   {allocate dlg}
 Gotodlg.showmodal;
 Gotodlg.free;
end;



{
========================                                          ===============
========================                                          ===============
------------------------ PRINT ROUTINE FOR MAIN TIMETABLE FOLLOWS --------------
========================                                          ===============
========================                                          ===============
}

function ttselect(aFnt: tpintpoint): boolean;
var
 i,j,k,a:       integer;
 astr,bstr:     string;
 bFnt:          tpintpoint;
 place:         integer;
begin
 result:=false;
 if ttprntseltype<=1 then
  begin result:=true; exit; end;
 k:=0;  j:=0;
 bFnt:=aFnt;
 if bFnt^>LabelBase then {label}
   begin result:=true; exit; end;

 if ttprntseltype=5 then {fac}
  begin
   place:=bFnt^;
   aStr:=trim(uppercase(copy(subcode[place],1,lencodes[0]-1)));
   for i:=1 to facCount[ttPrntFac] do
   begin
    a:=facsubs[ttPrntFac,i];
    if a>0 then
    begin
     if a=place then
     begin
      result:=true;
      break;
     end;
    end
    else
     begin  {fac sub has a wild card}
      bStr:=trim(uppercase(copy(subcode[abs(a)],1,lencodes[0]-1)));
      if aStr=bStr then
      begin
       result:=true;
       break;
      end;
     end;
   end; {for i}
  end
else
 begin   {sub,te or ro}
  inc(bFnt,(ttprntseltype-2));
  place:=bFnt^;
  case ttprntseltype of
   2: j:=ttprntselsubg[0];  {sub}
   3: j:=ttprntselteachg[0]; {te}
   4: j:=ttprntselroomg[0];  {ro}
  end; {case}
  for i:=1 to j do
  begin
   case ttprntseltype of
    2: k:=ttprntselsubg[i];  {sub}
    3: k:=ttprntselteachg[i]; {te}
    4: k:=ttprntselroomg[i];  {ro}
   end; {case}
   if place=k then
   begin
    result:=true;
    break;
   end;
  end; {for i}
 end;
end;


procedure TPrintTtableWin.head;
begin
 UnderlineOn;
 printwl('Timetable');
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
end;


procedure TPrintTtableWin.SetTabs;
var
 i,tab1: integer;
begin
 SetLength(PrntTabs,3);
 tab1:=PrintCanvas.textwidth(' Time: ');
 i:=PrintCanvas.textwidth(yearshort)+2*prntblankwidth+fwprntyearname;
 if i>tab1 then tab1:=i;
 if fwprntclass>tab1 then tab1:=fwprntclass;
 if tfreeshow then
 begin
  i:=PrintCanvas.textwidth('Teachers')+2*prntblankwidth;
  if i>tab1 then tab1:=i;
 end;
 if rfreeshow then
 begin
  i:=PrintCanvas.textwidth('Rooms')+2*prntblankwidth;
  if i>tab1 then tab1:=i;
 end;
 PrntTabs[1]:=tab1;
end;


procedure TPrintTtableWin.printttable;
var
 found:                boolean;
 astr:    string;
 strtday,finday: integer;
 strtyear,finyear: integer;
 d,yyear,L: integer;
 i,j,ttspace1,tab1,ygap,ygap1:          integer;
 lineprinted:                   integer;
 tab2:                          integer;
 numperiodsshown:               integer;
 ttprintcontinue:               boolean;

       procedure trimLabelToFit(var tmpStr: string);
       var
        i:   integer;
       begin
        i:=PrintTtableWin.PrintCanvas.textwidth(tmpStr);
        while (i>(ttspace1-2*prntblankwidth)) do
        begin
         tmpstr:=copy(tmpstr,1,Length(tmpstr)-1);
         i:=PrintTtableWin.PrintCanvas.textwidth(tmpStr);
        end; {while}
       end;


    procedure ttableprint;
    var
     i,j,k,l:     integer;
    begin
     tab1:=PrntTabs[1];
     j:=0;
     for i:=0 to tlimit[d]-1 do if tsOn[d,i] then inc(j);
     numperiodsshown:=j;

     inc(y,ygap1); drawmyline(0,y,tab1+numperiodsshown*ttspace1,y); inc(y,ygap1);

     printw(' Time:');
     k:=ttspace1 div 2;
     j:=1;
     for i:=0 to tlimit[d]-1 do
     begin
      if tsOn[d,i] then
      begin
       L:=PrintCanvas.textwidth(TimeSlotName[d,i]) div 2;
       x:=tab1+j*ttspace1-k-L;
       printw(TimeSlotName[d,i]);
       inc(j);
      end;
     end; {for i}
     newline;
     drawmyline(0,y-prnttxtheight-ygap1,0,y+ygap1);
     for i:=0 to numperiodsshown do
      drawmyline(tab1+i*ttspace1,y-prnttxtheight-ygap1,tab1+i*ttspace1,y+ygap1);
     inc(y,ygap1); drawmyline(0,y,tab1+numperiodsshown*ttspace1,y); inc(y,ygap1);
    end;


     procedure ttablefree;
      var
       i,ii,p,yyear2,L,line,tnum,a,k:       integer;
       tepoint:      array[0..nmbrperiods] of integer;
       astr:         string;
       te:           integer;
       afnt:    tpintpoint;

         procedure nextttableteacher;
         begin
          a:=0;
          while (a=0) do
          begin
           inc(tepoint[p]);
           te:=codepoint[tepoint[p],code];
           astr:=copy(tecode[te,code-1],1,2); a:=0;
           if tepoint[p]>codenum[code] then exit;
           if TeachOn[te,p]=0 then
           begin
            a:=te;
            if ((code=1) and (load[te]=0)) then a:=0;
           end;
           if ((te=0) or (astr='00')) then a:=0;
          end; {while}
         end;


      begin
       for i:=1 to nmbrteachers do
        for p:=0 to nmbrperiods do TeachOn[i,p]:=0;
       for p:=1 to tlimit[d] do
        if tsOn[d,p-1] then
        begin
         for yyear2:=0 to years_minus_1 do
         begin
          aFnt:=FNT(d,p-1,yyear2,0,2*code);
          for L:=1 to level[yyear2] do
          begin
           inc(aFnt,4);
           te:=aFnt^;
           inc(TeachOn[te,P]);
           inc(TeachOn[te,0]);
          end; {for L}
         end; {for yyear2}
        end; {if tsOn[d,p-1]}
       for p:=0 to periods do
        tepoint[p]:=0;
       case code of
        1: printw(' Teachers');
        2: printw(' Rooms');
       end; {case}
       line:=1;
       tnum:=(ttspace1-prntblankwidth) div (prntblankwidth+fwprntcode[code]);
       for i:=1 to numcodes[code] do
       begin
        found:=false;
        if line=2 then
        begin
         printw(' Free');
         inc(line);
        end;
        j:=0;
        for p:=1 to tlimit[d] do
         if TsOn[d,p-1] then
         begin
          for k:=1 to tnum do
          begin
           nextttableteacher;
           if a>0 then
           begin
            x:=tab1+j*ttspace1+((k-1)*(fwprntcode[code]+prntblankwidth))
                +((ttspace1-((fwprntcode[code]+prntblankwidth)*tnum)) div 2);
            if code=1 then fcolor(cpTeach) else if code=2 then fcolor(cpRoom);
            printw(FNsub(a,code));  fcolor(cpNormal);
            found:=true;
           end;
          end; {for k}
          inc(j);
         end; {if TsOn[d,p-1]}

{do vert lines as we go and close of at end with continued next header}
    drawmyline(0,y-(prnttxtheight*(1))-ygap,0,y+ygap+prnttxtheight);
    for ii:=0 to numperiodsshown do
      drawmyline(tab1+ii*ttspace1,y-prnttxtheight-ygap,tab1+ii*ttspace1,y+ygap+prnttxtheight);
    if (y+4*PrnttxtHeight)>(PrintPageHeight-2*prntTxtHeight) then
    begin
     drawmyline(0,y+ygap+prnttxtheight,tab1+numperiodsshown*ttspace1,y+ygap+prnttxtheight); {close off}
     startnewpage;
    newline;
    if ttPrntType=0 then
     astr:='Main Daily Timetable - '+dayname[d]+'  (continued)'
    else
     astr:=yeartitle+' '+yearname[ttprntselyear]+' Timetable - '+dayname[d]+'  (continued)';
    printw(astr);
    newline;
      ttableprint;
      ttprintcontinue:=true;

       case code of
        1: printw(' Teachers');
        2: printw(' Rooms');
       end; {case}
       line:=1;
    end;



        newline;
        inc(line);


        if not(found) then break;
       end; {for i}
      end;

    procedure ttableprint1;
    var
     i,j,p,a1:                  integer;
     aFnt,bFnt:            tpintpoint;
     code:                integer;
     tmpStr,cstr:                    string;

    begin
     lineprinted:=0;
     if ((L=1) or (ttprintcontinue)) then
     begin
      if ttprintcontinue then y:=y-prnttxtheight;
      ttprintcontinue:=false;
      printw(' '+yearshort+' '+yearname[yyear]);
      newline;
     end;
     printw(' '+ClassCode[ClassShown[l,yyear]]);
     j:=0;
     for p:=1 to tlimit[d] do
      if TsOn[d,p-1] then
      begin
       aFnt:=FNT(d,p-1,yyear,l,0);
       if ttselect(aFnt) then {no selection, or subg teg rog or fac - 2,3,4 or 5}
       begin
        tab2:=prntblankwidth;
        for code:=0 to 2 do
        begin
         x:=tab1+j*ttspace1+tab2;
         bfnt:=afnt;
         inc(bfnt,code);
         a1:=bfnt^;
         if ((code=0) and (a1>=LabelBase)) then
         begin
          cstr:=tclabel[a1-LabelBase];
          trimLabelToFit(cstr);
          printw(' '+cstr);
          break;
         end
         else
          begin
           tmpstr:=FNsub(a1,code);
           case code of
            0:fcolor(cpSub);
            1:fcolor(cpTeach);
            2:fcolor(cpRoom);
           end;
           printw(' '+tmpstr); fcolor(cpNormal);
          end;
         inc(tab2,fwprntcode[code]+prntblankwidth);
        end; {code}
       end; {if found}
       drawmyline(0,y-(prnttxtheight*(1))-ygap1,0,y+ygap+prnttxtheight);
       for i:=0 to numperiodsshown do
         drawmyline(tab1+i*ttspace1,y-(prnttxtheight*(1))-ygap1,tab1+i*ttspace1,y+ygap+prnttxtheight);
       if (y+4*PrnttxtHeight)>(PrintPageHeight-2*prntTxtHeight) then
        begin
         drawmyline(0,y+ygap+prnttxtheight,tab1+numperiodsshown*ttspace1,y+ygap+prnttxtheight); {close off}
         startnewpage;
         newline;
         if ttPrntType=0 then
          astr:='Main Daily Timetable - '+dayname[d]+'  (continued)'
         else
          astr:=yeartitle+' '+yearname[ttprntselyear]+' Timetable - '+dayname[d]+'  (continued)';
         printw(astr);
         newline;
         ttableprint;
         ttprintcontinue:=true;
        end;
       inc(j);
      end; {if TsOn[d,p-1]}
      newline;
      lineprinted:=-1;
    end;



begin
 ygap:=3;
 ygap1:=PrnttxtHeight div 5;
 ClearTeachon;
 strtday:=0;
 finday:=days-1;
 if ((ttprntselyear=-1) or (ttPrntType=0)) then {all years or main tt}
 begin
  strtyear:=years-1;
  finyear:=0;
 end
 else
  begin
   strtyear:=ttprntselyear;
   finyear:=ttprntselyear;
  end;
 ttspace1:=4*prntblankwidth+fwprntcode[0]+fwprntcode[1]+fwprntcode[2];
 for d:=strtday to finday do
 begin
  if not(Dprint[d+1]) then continue;

 if ((y+10*PrnttxtHeight)>(PrintPageHeight-2*prntTxtHeight)) then
 {avoiding orphaned lines in print out -ensure at least 10 lines can print}
  begin
   startnewPage;
  end;

  if strtday<>finday then
  begin
   newline;
   if ttPrntType=0 then
    astr:='Main Daily Timetable - '+dayname[d]
   else
    astr:=yeartitle+' '+yearname[ttprntselyear]+' Timetable - '+dayname[d];
   printw(astr);
   newline;
  end;
  ttprintcontinue:=false;

  ttableprint;
  for yyear:=strtyear downto finyear do
  begin

   if pyear[yyear] then
   begin
    for L:=1 to level[yyear] do ttableprint1;
    inc(y,ygap); drawmyline(0,y,tab1+numperiodsshown*ttspace1,y); inc(y,ygap1);
   end;


   if yyear=finyear then if tfreeshow then
   begin
    code:=1;  ttablefree;

    inc(y,ygap); drawmyline(0,y,tab1+numperiodsshown*ttspace1,y); inc(y,ygap1);
   end;
   if yyear=finyear then if rfreeshow then
   begin
    code:=2;  ttablefree;

    inc(y,ygap); drawmyline(0,y,tab1+numperiodsshown*ttspace1,y); inc(y,ygap);
   end;

  end; {for yyear}
  newline;
  if ttPrntType=0 then {main and not year ttable so page break}
  begin
    if d<>finday then
    begin
     L:=0;
     for i:=d+1 to finday do
      if Dprint[i+1] then
      begin
       L:=1; break;
      end;
     if L>0 then {only if more days to come}
      begin
       startnewpage;
       Header;
      end;
    end;
  end;
 end; {for d}
end;

procedure maintimetableprint;
begin
 PrintTtableWin:=TPrintTtableWin.create;
 with PrintTtableWin do
  try
   PrintHead;
   printttable;
   printCustomAddon;
  finally
   PrintTtableWin.Free;
  end;
end;

{
========================                                          ===============
========================                                          ===============
------------------------    MAIN TIMETABLE TEXT OUTPUT ROUTINE   --------------
========================                                          ===============
========================                                          ===============
}



procedure TOutTtableWin.GenericTimetabletext;
var
 D,P,Y,L,sub,te,ro:      integer;
 aFnt:               tpintpoint;
begin
 For D:=0 to days-1 do
  For P:=0 to periods-1 do
   For Y:=0 to years_minus_1 do
    For L:=1 to level[Y] do
    begin
     aFnt:=FNT(D,P,Y,L,0);
     sub:=aFnt^; inc(aFnt);
     te:=aFnt^; inc(aFnt);
     ro:=aFnt^;
     if ((sub<=LabelBase) and ((sub>0) or (te>0) or (ro>0))) then
     begin
      if (pyear[Y] and dprint[D+1] and TsOn[D,P]) then
      begin
       PrintLine([inttostr(D+1),inttostr(P+1),trim(Subcode[sub]),trim(yearname[Y]),
        trim(tecode[te,0]),trim(tecode[ro,1])]);
      end; {if disp settings}
     end;
    end;
end;


procedure TOutTtableWin.OutTtable;
var
 j:            integer;
 found:                boolean;


procedure printttable;
var
 astr:    string;
 strtday,finday: integer;
 strtyear,finyear: integer;
 d,yyear,L: integer;
 i:          integer;
 lineprinted:                   integer;
 numperiodsshown:               integer;
 ttprintcontinue:               boolean;


    procedure ttableprint;
    var
     i,j:     integer;
    begin
     j:=0;
     for i:=1 to tlimit[d] do if TsOn[d,i-1] then inc(j);
     numperiodsshown:=j;
     printw('Time:'); printc('');
     for i:=0 to tlimit[d]-1 do
      if TsOn[d,i] then
       begin
        printc(TimeSlotName[d,i]); printc(''); printc('');
       end;
     newline;
    end;


     procedure ttablefree;
      var
       i,p,yyear2,L,line,tnum,a,k:       integer;
       tepoint:      array[0..nmbrperiods] of integer;
       astr:         string;
       te:           integer;
       afnt:    tpintpoint;

         procedure nextttableteacher;
         begin
          a:=0;
          while (a=0) do
          begin
           inc(tepoint[p]);
           te:=codepoint[tepoint[p],code];
           astr:=copy(tecode[te,code-1],1,2); a:=0;
           if tepoint[p]>codenum[code] then exit;
           if Teachon[te,p]=0 then
           begin
            a:=te;
            if ((code=1) and (load[te]=0)) then a:=0;
           end;
           if ((te=0) or (astr='00')) then a:=0;
          end; {while}
         end;

      begin
       for i:=1 to nmbrteachers do
        for p:=0 to nmbrperiods do
         Teachon[i,p]:=0;
       for p:=1 to tlimit[d] do
        if TsOn[d,p-1] then
        begin
         for yyear2:=0 to years_minus_1 do
         begin
          aFnt:=FNT(d,p-1,yyear2,0,2*code);
          for L:=1 to level[yyear2] do
          begin
           inc(aFnt,4);
           te:=aFnt^;
           inc(Teachon[te,P]);
           inc(Teachon[te,0]);
          end; {for L}
         end; {for yyear2}
        end; {if TsOn[d,p-1]}
       for p:=0 to periods do
        tepoint[p]:=0;
       case code of
        1: printw(' Teachers');
        2: printw(' Rooms');
       end; {case}
       line:=1;
       tnum:=1;
       for i:=1 to numcodes[code] do
       begin
        found:=false;
        if line=2 then
        begin
         printw(' Free');
         inc(line);
        end;
        j:=0;
        for p:=1 to tlimit[d] do
         if TsOn[d,p-1] then
         begin
          for k:=1 to tnum do
          begin
           nextttableteacher;
           if a>0 then
            begin
             printc(FNsub(a,code)); printc(''); printc('');
             found:=true;
            end
           else begin printc('');printc('');printc(''); end;
          end; {for k}
          inc(j);
         end; {if TsOn[d,p-1]}

        newline;
        inc(line);
        if not(found) then break;
       end; {for i}
      end;


    procedure ttableprint1;
    var
     p,a1:                  integer;
     aFnt,bFnt:            tpintpoint;
     code:                integer;
     tmpStr,cstr:                    string;

    begin
     lineprinted:=0;
     if ((L=1) or (ttprintcontinue)) then
     begin
      ttprintcontinue:=false;
      printw(yeartitle+' '+yearname[yyear]);
      newline;
     end;
     printw(ClassCode[ClassShown[l,yyear]]);
     for p:=1 to tlimit[d] do
      if TsOn[d,p-1] then
      begin
       aFnt:=FNT(d,p-1,yyear,l,0);
       if ttselect(aFnt) then {no selection, or subg teg rog or fac - 2,3,4 or 5}
       begin
        for code:=0 to 2 do
        begin
         bfnt:=afnt;
         inc(bfnt,code);
         a1:=bfnt^;
         if ((code=0) and (a1>LabelBase)) then
         begin
          cstr:=tclabel[a1-LabelBase];
          printc(cstr); printc(''); printc('');
          break;
         end
         else
          begin
           tmpstr:=FNsub(a1,code);
           printc(tmpstr);
          end;
        end; {code}
       end; {if found}
       {inc(j); }
      end; {if TsOn[d,p-1]}
      newline;
      lineprinted:=-1;
    end;


begin
 strtday:=0;
 finday:=days-1;
 if ((ttprntselyear=-1) or (ttPrntType=0)) then {all years or main tt}
 begin
  strtyear:=years-1;
  finyear:=0;
 end
 else
  begin
   strtyear:=ttprntselyear;
   finyear:=ttprntselyear;
  end;
 for d:=strtday to finday do
 begin
  if not(Dprint[d+1]) then continue;
  if strtday<>finday then
  begin
   newline;
   if ttPrntType=0 then
//    astr:='Main Daily Timetable - '+dayname[d]
    astr:=dayname[d]
   else
//    astr:=yeartitle+' '+yearname[ttprntselyear]+' Timetable - '+dayname[d];
    astr:=dayname[d];
   printw(astr);
   newline;  newline; newline;
  end;
  ttprintcontinue:=false;
  ttableprint;
  for yyear:=strtyear downto finyear do
  begin
   if pyear[yyear] then
   begin
    for L:=1 to level[yyear] do
    begin
     ttableprint1;
    end; {for L}
   end;

   if yyear=finyear then if tfreeshow then
   begin
    code:=1;  ttablefree;
   end;
   if yyear=finyear then if rfreeshow then
   begin
    code:=2;  ttablefree;
   end;

  end; {for yyear}
  newline;
  if ttPrntType=0 then {main and not year ttable so page break}
  begin
    if d<>finday then
    begin
     L:=0;
     for i:=d+1 to finday do
      if Dprint[i+1] then
      begin
       L:=1; break;
      end;
    end;
  end;
 end; {for d}
end;



begin
 ClearTeachOn;
 printttable;
 printCustomAddon;
end;


procedure TOutTtableWin.head;
begin
 printLine(['Timetable']);
end;



procedure maintimetableOut;
begin
 OutTtableWin:=TOutTtableWin.create;
 with OutTtableWin do
  try
   if GenericTtableFlag then GenericTimetabletext
    else
     begin
       Header;
       Outttable;
     end;
  finally
   OutTtableWin.Free;
  end;
end;


procedure TTtablewin.PopupMenu1Popup(Sender: TObject);
var
 aFnt:    tpintpoint;
 s,t,r,i,j:   integer;
begin
 showSubjecttimetable1.visible:=false;
 showteachertimetable1.visible:=false;
 showroomtimetable1.visible:=false;
 showclasstimetable1.visible:=false;

 if box=bxCell then
 begin
  aFnt:=FNT(nd,np,ny,nl,0);
  s:=aFnt^; inc(aFnt);
  t:=aFnt^; inc(aFnt);
  r:=aFnt^;
  showSubjecttimetable1.visible:=((s>0) and (s<=LabelBase));  {avoid call on labels}
  showteachertimetable1.visible:=((t>0) and (s<=LabelBase));
  showroomtimetable1.visible:=((r>0) and (s<=LabelBase));
 end;
 if box=bxlevel then
 begin
  showclasstimetable1.visible:=(ClassCode[ClassShown[nl,ny]]>'');
 end;
 if box=bxyrtime then
 begin
  j:=0;
  for i:=1 to level[ny] do {see if any subs present}
  begin
   aFnt:=Fnt(nd,np,ny,i,0);
   s:=aFnt^;
   if ((s>0) and (s<=LabelBase)) then
   begin
    j:=1;
    break;
   end;
  end;    {for i}
  showsubjecttimetable1.visible:=bool(j);
 end;

end;

procedure TTtablewin.ShowSubjectTimetable1Click(Sender: TObject);
var
 aFnt:    tpintpoint;
 i,j:   integer;
begin
 if box=bxCell then
 begin
  subttlistvals[1]:=ny;
  subttlistvals[2]:=nl;
  subttlistvals[3]:=nd;
  subttlistvals[4]:=np; {period}
  subttlistselection:=1;

  aFnt:=FNT(subttlistvals[3],subttlistvals[4],subttlistvals[1],subttlistvals[2],0);
  j:=aFnt^;
  if ((j>0) and (j<=LabelBase)) then
  begin
   subttGroupcnt:=1;
   subttgroup[1]:=j;
   subjectTtablewinSelect;
   UpdateWindow(wnSubjectTt);
  end
 end
 else
  if box=bxyrtime then
  begin
   subttlistvals[1]:=ny;
   subttlistvals[2]:=nl;
   subttlistvals[3]:=nd;
   subttlistvals[4]:=np; {period}
   subttlistselection:=2;

   subttgroupcnt:=0;
   for i:=0 to level[subttlistvals[1]] do
   begin
    aFnt:=FNT(subttlistvals[3],subttlistvals[4],subttlistvals[1],i,0);
    j:=aFnt^;
    if ((j>0) and (j<=LabelBase)) then
    begin
     inc(subttgroupcnt);
     subttgroup[subttgroupcnt]:=j;
    end;
   end; {for i}
   if bool(subttgroupcnt) then {only if some subs were there}
   begin
    subjectTtablewinSelect;
    UpdateWindow(wnSubjectTt);
   end;
  end;
end;

procedure TTtablewin.ShowTeacherTimetable1Click(Sender: TObject);
var
 te:   integer;
begin
 if box=bxCell then
 begin
  te:=FNT(nd,np,ny,nl,2)^;
  if te>0 then
  begin
   tettselection[0]:=1;
   tettselection[1]:=te;  {selection}
   tettlistvals[3]:=0;    {fac}
   tettseltype:=2; {selection}
   winView[wnTeacherTt]:=1; {weekly}
   teachttablewinselect;
   UpdateWindow(wnTeacherTt);
  end;
 end;
end;

procedure TTtablewin.ShowRoomTimetable1Click(Sender: TObject);
var
 r:   integer;
begin
 if box=bxCell then
 begin
  r:=FNT(nd,np,ny,nl,4)^;
  if r>0 then
  begin
   rottselection[0]:=1;
   rottselection[1]:=r;  {selection}
   rottlistvals[3]:=0;    {fac}
   rottseltype:=2; {selection}
   winView[wnRoomTt]:=1; {weekly}
   roomttablewinselect;
   UpdateWindow(wnRoomTt);
  end;
 end;
end;



procedure TTtablewin.ShowClassTimetable1Click(Sender: TObject);
begin
 if ClassCode[ClassShown[nl,ny]]>'' then
 begin
  subttlistvals[1]:=ny;
  subttlistvals[2]:=nl;
  subttlistvals[3]:=nd;
  subttlistvals[4]:=np; {period}
  subttlistselection:=3;
  subjectTtablewinSelect;
  UpdateWindow(wnSubjectTt);
 end;
end;

procedure TTtablewin.Configure1Click(Sender: TObject);
begin
 mainform.Levels1Click(self);
end;

procedure TTtablewin.FormDestroy(Sender: TObject);
begin
 Mainform.ToolbarClear;
end;

initialization

scalingGridCellsFlag:=false;

end.
