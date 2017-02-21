unit Subjcttt;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TSuTtable = class(TDrawWin)
    PopupMenu1: TPopupMenu;
    Selection2: TMenuItem;
    N2: TMenuItem;
    PrintSetup1: TMenuItem;
    Print1: TMenuItem;
    Copy1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Selection2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
  protected
    procedure SetTabs; override;
  end;

var
  SuTtable: TSuTtable;

procedure subjectTtableprint;
procedure subjectTtabletext;

implementation
uses tcommon,main,subttdlg,printers,tcommon2,ttable;


 type TPrintSubTt=class(TPrintDrawWin)
  public
   procedure head; override;
   procedure SetTabs; override;
   procedure SubTtPrint;
   procedure SubTtPrintWeekly;
   procedure SubTtPrintDaily;
 end;

 type TOutSubTt=class(TOutputWin)
  public
   procedure head; override;
   procedure SubTtOutput;
   procedure SubTtOutWeekly;
   procedure SubTtOutDaily;
 end;

var
 PrintSubTt:    TPrintSubTt;
 OutSubTt:      TOutSubTt;
 dx,tab1:    integer;
 PrntOffset,Prntdx,PrntTab1:  integer;
 subL1,subL2:                 integer;
 subtt,subttBlock,subttL1,subttL2,subttNum:  tpFclash;
 subttPnum:                                  tpPeriodData;
 aFnt:                  tpIntPoint;

{$R *.DFM}

procedure TSuTtable.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure TSuTtable.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnSubjectTt)
end;

procedure TSuTtable.Selection2Click(Sender: TObject);
begin
 SubjectTTdlg:=TSubjectTTdlg.create(self);   {allocate dlg}
 SubjectTTdlg.showmodal;
 SubjectTTdlg.free;
end;

procedure GetSubLevels;
var
 i,j: integer;
begin
 subL1:=0; subL2:=0; subttgroupcnt:=0;
 case subttlistselection of
  1: begin subL1:=subttlistvals[2]; subL2:=subL1; end;   {cell}
  2: begin subL1:=1; subL2:=level[subttlistvals[1]]; end;{Yr/Time}
  4: begin {block}
      getBlockLevels(subttlistvals[3],subttlistvals[4],subttlistvals[1],subttlistvals[2],subL1,subL2);
     end
 end;
 if subL1>0 then
  for i:=subL1 to subL2 do
   begin
    aFnt:=FNT(subttlistvals[3],subttlistvals[4],subttlistvals[1],i,0);
    j:=aFnt^;
    if ((j>0) and (j<LabelBase)) then
   begin
    inc(subttgroupcnt);
    subttgroup[subttgroupcnt]:=j;
   end;
  end; {for i}
end;

function GetSubtt: integer;
var
 d,p,L,s2: integer;
 count,allthere,countmax: integer;
begin
 countmax:=0;
 for D:=0 to days-1 do
  begin
   count:=0;
   for p:=0 to tlimit[d]-1 do
   begin
    subtt[d,p]:=0;
    allthere:=0;
    if subL1>0 then
    begin
     for s2:=1 to subttgroupcnt do
      for L:=subL1 to subL2 do
      begin
       aFnt:=FNT(D,p,subttlistvals[1],L,0);
       if (aFnt^=subttgroup[s2]) then
       begin
        inc(allthere);
        break;
       end;
      end; {for L}
     end;
    if (allthere=subttgroupcnt) then
    begin
     inc(count); subtt[d,p]:=1;
    end;
   end; {for p}
   if (count>countmax) then countmax:=count;
  end; {for D}
 result:=countmax;
end;

procedure TSuTtable.SetTabs;
var
 j,A1,tsNameNum:       integer;
 y,l,d,p,Ip:       integer;
 aFnt:        tpintpoint;
 countmx:    integer;
 sc:               integer;
 t1,lineheight:       integer;
 nblock:      integer;
 scrolltemp:      integer;
begin
 tsNameNum:=1;
 for j:=1 to days-1 do
  if tsDayGroup[j]<>tsDayGroup[j-1] then inc(tsNameNum);

 if subttlistselection<>3 then  {not class format}
  begin
   GetSubLevels;
   countmx:=GetSubtt;
   if subttgroupcnt=0 then
    begin
     maxH:=3*txtheight;
     maxW:=canvas.textwidth('No subjects selected.         ');
     exit;
    end
   else
    begin
     maxH:=(7+days)*txtHeight;
     maxW:=canvas.textwidth('Times for  ')
            +(longint(fwCode[0])+longint(blankwidth))*longint(subttgroupcnt);
     scrolltemp:=longint(fwdayname)+longint(countmx)*longint(fwperiodname)
         +longint(canvas.textwidth(':    '));
     if scrolltemp>maxW then maxW:=scrolltemp;
    end;
  end
 else
  begin {weekly class format}
   lineheight:=txtHeight+3; if not(subttWide) then lineheight:=2*txtHeight+3;
   dx:=8+fwCode[1]+fwCode[2]+blankwidth;
   A1:=8+fwCode[0];  if A1>dx then dx:=A1;
   A1:=8+fwdayname;  if A1>dx then dx:=A1;
   if subttWide then
   begin
    A1:=8+fwcode[0]+fwcode[1]+fwcode[2]+blankwidth*2;
    if A1>dx then dx:=A1;
   end;
   y:=subttlistvals[1];   t1:=0;
   for Ip:=1 to tsShowMax do
   begin
    p:=tsShow[DayOfMaxPeriods,Ip]; subttPnum[p]:=0;
    for d:=0 to days-1 do
    begin
     l:=subttlistvals[2];
     subttL1[d,p]:=l;subttL2[d,p]:=l; subttNum[d,p]:=0;
     if (p+1)>tlimit[d] then continue;
     aFnt:=FNT(d,p,y,l,0);
     sc:=aFnt^;
     nblock:=FNgetBlockNumber(d,p,y,l);
     if (sc>LabelBase) then   {label, so find first block below it}
     begin
      for l:=1 to level[y] do
      begin
       j:=FNgetBlockNumber(d,p,y,l);
       if j>0 then
       begin
        Nblock:=j;
        break;
       end;
      end; {for IIl}
     end;
     subttBlock[d,p]:=Nblock;
     if nblock>0 then
      for l:=1 to level[y] do
      begin
       aFnt:=FNT(d,p,y,l,0); sc:=aFnt^;
       if (((FNgetBlockNumber(d,p,y,l)=nblock) and (sc>0)) or (sc>LabelBase)) then
         begin
          if l<subttL1[d,p] then subttL1[d,p]:=l;
          if l>subttL2[d,p] then subttL2[d,p]:=l;
          inc(subttNum[d,p]);
         end;
      end {for l}
     else
      begin {single entry}
       subttNum[d,p]:=1;
      end;
     if subttNum[d,p]>subttPnum[p] then subttPnum[p]:=subttNum[d,p];
    end; {for d}
    inc(t1,subttPnum[p]);
   end; {for p}
   maxH:=6*txtheight+tsShowMax*9+t1*lineheight;
   maxW:=Hmargin*2+tsNameNum*(fwPeriodname+blankwidth)+(dx+3)*days;
  end;

end;


procedure TSuTtable.FormPaint(Sender: TObject);


    procedure SUBJECTweekly;
    var
     Iy,Ip,lineheight,j,L:      integer;
     p,d,linecount,ytop:                    integer;
     aStr,bStr:                    string;
     offset1:                 integer;
     sc,te,ro:                   integer;
     y1t,y2t:                 integer;
     dayStart: array[0..nmbrdays] of integer;
     ShowTnames: array[0..nmbrdays] of boolean;


       procedure trimLabelToFit(var tmpStr: string);
       var
        i:   integer;
       begin
        i:=canvas.textwidth(tmpStr);
        while (i>(dx-2*blankwidth)) do
        begin
         tmpstr:=copy(tmpstr,1,Length(tmpstr)-1);
         i:=canvas.textwidth(tmpStr);
        end; {while}
       end;

    procedure ShowEntry;
    begin
     y:=ytop+linecount*lineheight;
     x:=dayStart[d]; if ShowTnames[d] then inc(x,tab1);
     astr:='';
     if sc>LabelBase then
      begin
       fcolor(cpNormal);
       aStr:=TcLabel[sc-LabelBase];
       trimLabelToFit(aStr);
      end
     else if ((sc>=0) and (sc<=numcodes[0])) then
        begin aStr:=subcode[sc]; fcolor(cpSub); end;

     if subttWide then
        begin
         offset1:=(dx-(fwcode[0]+fwcode[1]+fwcode[2]+blankwidth*2)) div 2;
         x:=x+offset1;
         printw(aStr);
         if sc<=LabelBase then {not for a label}
         begin
          if ((te>=0) and (te<=numcodes[1])) then aStr:=trim(tecode[te,0]) else aStr:='';
          if ((ro>=0) and (ro<=numcodes[2])) then bStr:=trim(tecode[ro,1]) else bStr:='';
          fcolor(cpTeach);
          inc(x,fwcode[0]+blankwidth);
          printw(aStr+' ');
          fcolor(cpRoom);
          inc(x,fwcode[1]+blankwidth);
          printw(bStr);
         end;
        end
       else
         begin
          offset1:=(dx-3-self.canvas.textwidth(aStr)) div 2;
          x:=x+offset1;
          printw(aStr);
          inc(y,txtHeight);
          if sc<=LabelBase then {not for a label}
          begin
           if ((te>=0) and (te<=numcodes[1])) then aStr:=trim(tecode[te,0]) else aStr:='';
           if ((ro>=0) and (ro<=numcodes[2])) then bStr:=trim(tecode[ro,1]) else bStr:='';
           offset1:=(dx-3-canvas.textwidth(trim(aStr+' '+bStr))) div 2;
           x:=dayStart[d]; if ShowTnames[d] then inc(x,tab1);
           x:=x+offset1;
           fcolor(cpTeach);
           printwl(aStr+' ');
           fcolor(cpRoom);
           printw(bStr);
          end;
         end;

     inc(linecount); y:=ytop;
    end;

    begin
     tab1:=fwPeriodname+blankwidth;
     dayStart[0]:=0;  ShowTnames[0]:=true;
     for d:=1 to days-1 do ShowTnames[d]:=(tsDayGroup[d]<>tsDayGroup[d-1]);
     for d:=1 to days do
      begin
       dayStart[d]:=dayStart[d-1]+dx;
       if ShowTnames[d-1] then inc(dayStart[d],tab1);
      end;
     lineheight:=txtHeight+3; if not(subttWide) then lineheight:=2*txtHeight+3;
     Iy:=subttlistvals[1];
     printwl('Timetable for '+yeartitle+' '+yearname[Iy]+' ');
     aStr:=trim(ClassCode[ClassShown[subttlistvals[2],subttlistvals[1]]]);
     if aStr='' then astr:=' (level '+ inttostr(subttlistvals[2])+')'
      else aStr:=' Class '+aStr;
     printw(aStr);
     newline; newline;
     for d:=0 to days-1 do
     begin
      x:=dayStart[d]; if ShowTnames[d] then inc(x,tab1);
      x:=x+((dx-canvas.textwidth(dayname[d])) div 2); {centre dayname}
      printw(dayname[d]);
     end; {for d}
     newline;
     inc(y,txtheight div 2);
     for Ip:=1 to tsShowMax do
     begin
      p:=tsShow[DayOfMaxPeriods,Ip];
      if Ip>1 then inc(y,lineheight*subttPnum[tsShow[DayOfMaxPeriods,Ip-1]]+9);
      y1t:=y-6;
      y2t:=y+lineheight*subttPnum[p]+3;
      fcolor(cpNormal);
      ytop:=y;
      for d:=0 to days-1 do
       begin
        p:=tsShow[d,Ip];
        if (p=0) and (Ip>1) then continue;
        if ShowTnames[d] then
         begin
          x:=dayStart[d]+blankwidth div 3;
          fcolor(cpNormal);
          printw(TimeSlotName[d,p]);
         end;
        x:=dayStart[d]; if ShowTnames[d] then inc(x,tab1);

       linecount:=0;
       for L:=subttL1[d,p] to subttL2[d,p] do
        begin
         aFnt:=FNT(d,p,Iy,L,0);
         sc:=aFnt^; inc(aFnt);  te:=aFnt^; inc(aFnt); ro:=aFnt^;
         j:=FNgetBlockNumber(d,p,Iy,L);
         if (sc>LabelBase) or ((j=subttBlock[d,p])and (sc>0)) or (subttBlock[d,p]=0)
            then ShowEntry;
        end;
      end;
      if Ip=1 then drawMyLine(-3,y1t,DayStart[days]-3,y1t);
      drawMyLine(-3,y2t,DayStart[days]-3,y2t);
      drawMyLine(-3,y1t,-3,y2t);
      for d:=0 to days do
       begin
        drawMyLine(DayStart[d]-3,y1t,DayStart[d]-3,y2t);
        if d<days then if ShowTnames[d] then
         drawMyLine(dayStart[d]+tab1-3,y1t,dayStart[d]+tab1-3,y2t);
       end;
     end; {for Ip}
    end;


    procedure SUBJECTDaily;
    var
     i,count,D,p,tab:     integer;
    begin
     if subttgroupcnt=0 then
     begin
      printw('No subjects selected.');
      exit;
     end;

     printwl('Times for ');
     fcolor(cpSub);  {subject}
     for i:=1 to subttgroupcnt do
     begin
      printwl(subcode[subttgroup[i]]+' ');
     end;
     fcolor(cpNormal);
     newline;
     printwl(yearshort+': '+yearname[subttlistvals[1]]+' ');
     if ((subttlistselection=1) or (subttlistselection=4)) then
      printw('Level '+inttostr(subttlistvals[2]));
     newline;
     count:=0;
     tab:=fwDayname+canvas.textwidth(': ');
     for D:=0 to days-1 do
     begin
      newline;
      printw(dayname[D]+': ');
      inc(x,tab);
      for p:=0 to tlimit[d]-1 do
       if subTT[d,p]=1 then
         begin
          inc(count);
          printwl(TimeSlotName[d,p]+' ');
         end;
     end; {for D}
     newline; newline;
     printw('Entries:'+inttostr(count));
    end;


begin
 fcolor(cpNormal);
 if numcodes[0]=0 then
 begin
  printw('No subject data entered.');
  exit;
 end;
 if subttlistselection=3 then SUBJECTweekly
  else SUBJECTdaily;
end;



{ ------------------         print procs follow             --------------------}


procedure TPrintSubTt.head;
begin
 UnderlineOn;
 printwl('Subject Timetable ');
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
end;

procedure TPrintSubTt.SetTabs;
var
 A1:         integer;
begin
 Prntdx:=fwprntCode[1]+fwprntCode[2]+3*prntblankwidth;
 A1:=2*prntblankwidth+fwprntCode[0];
 if A1>Prntdx then Prntdx:=A1;
 A1:=2*prntblankwidth+fwprntdayname;
 if A1>Prntdx then Prntdx:=A1;
 if subttWide then
 begin
  A1:=fwprntcode[0]+fwprntcode[1]+fwprntcode[2]+prntblankwidth*4;
  if A1>Prntdx then Prntdx:=A1;
 end;
 PrntOffset:=(Prntdx-fwprntCode[0]) div 2;
 PrntTab1:=fwprntPeriodname+prntblankwidth;
end;

procedure TPrintSubTt.SubTtPrintWeekly;
var
 Iy,Ip,Il,j,L:      integer;
 p,d,lineheight,ytop,VertOffset:                    integer;
 aStr,bStr:                    string;
 offset1:                 integer;
 sc,te,ro:                   integer;
 y1t,y2t:                 integer;
 linepos:                      array[0..nmbrDays] of integer;
 dayStart: array[0..nmbrdays] of integer;
 ShowTnames: array[0..nmbrdays] of boolean;


    procedure WeeklyHead;
    var
     d: integer;
    begin
     UnderlineOn;
     printwl('Timetable for '+yeartitle+' '+yearname[Iy]+' ');
     aStr:=trim(ClassCode[ClassShown[subttlistvals[2],subttlistvals[1]]]);
     if aStr='' then astr:=' (level '+ inttostr(subttlistvals[2])+')'
      else aStr:=' Class '+aStr;
     printw(aStr);
     UnderlineOff;
     newline; newline;
     for d:=0 to days-1 do
     begin
      x:=dayStart[d]; if ShowTnames[d] then inc(x,PrntTab1);
      x:=x+((Prntdx-PrintCanvas.textwidth(dayname[d])) div 2); {centre dayname}
      printw(dayname[d]);
     end;
     newline;
     inc(y,PrnttxtHeight div 2);
    end;


  procedure trimLabelToFit(var tmpStr: string);
   var
    i:   integer;
   begin
    i:=PrintCanvas.textwidth(tmpStr);
    while (i>(Prntdx-2*prntblankwidth)) do
    begin
     tmpstr:=copy(tmpstr,1,Length(tmpstr)-1);
     i:=PrintCanvas.textwidth(tmpStr);
    end; {while}
   end;

    procedure ShowEntry;
    begin
       ytop:=y;
       x:=dayStart[d]; if ShowTnames[d] then inc(x,PrntTab1);
       astr:='';
       if sc>LabelBase then
        begin
         fcolor(cpNormal);
         aStr:=TcLabel[sc-LabelBase];
         trimLabelToFit(aStr);
        end
       else if ((sc>=0) and (sc<=numcodes[0])) then
          begin aStr:=subcode[sc]; fcolor(cpSub); end;

       if subttWide then
          begin
           offset1:=(Prntdx-(fwPrntcode[0]+fwPrntcode[1]+fwPrntcode[2]+Prntblankwidth*2)) div 2;
           x:=x+offset1;
           printw(aStr);
           if sc<=LabelBase then {not for a label}
           begin
            if ((te>=0) and (te<=numcodes[1])) then aStr:=trim(tecode[te,0]) else aStr:='';
            if ((ro>=0) and (ro<=numcodes[2])) then bStr:=trim(tecode[ro,1]) else bStr:='';
            fcolor(cpTeach);
            inc(x,fwPrntcode[0]+Prntblankwidth);
            printw(aStr+' ');
            fcolor(cpRoom);
            inc(x,fwPrntcode[1]+Prntblankwidth);
            printw(bStr);
           end;
          end
         else
           begin
            offset1:=(Prntdx-3-PrintCanvas.textwidth(aStr)) div 2;
            x:=x+offset1;
            printw(aStr);
            inc(y,PrnttxtHeight);
            if sc<=LabelBase then {not for a label}
            begin
             if ((te>=0) and (te<=numcodes[1])) then aStr:=trim(tecode[te,0]) else aStr:='';
             if ((ro>=0) and (ro<=numcodes[2])) then bStr:=trim(tecode[ro,1]) else bStr:='';
             offset1:=(Prntdx-3-PrintCanvas.textwidth(trim(aStr+' '+bStr))) div 2;
             x:=dayStart[d]; if ShowTnames[d] then inc(x,PrntTab1);
             x:=x+offset1;
             fcolor(cpTeach);
             printwl(aStr+' ');
             fcolor(cpRoom);
             printw(bStr);
            end;
           end;

       y:=ytop;
    end;

  procedure checkNeedContinue(Ip1: integer);
  var
   d: integer;
  begin
   if (Ip=tsShowMax) and (Il=subttPnum[p]) then exit;  {last one anyway}
    if (y+4*PrnttxtHeight)>(PrintPageheight-2*prntTxtHeight) then
    begin
     drawMyLine(-3,y2t,(-3+dayStart[days]),y2t);  {close off}
     startnewpage;
     header; WeeklyHead;
     y1t:=y-VertOffset;
     fcolor(cpNormal);
     if (Il<subttPnum[p]) then  {still more to print on this period}
      begin
       x:=blankwidth div 3;
       drawMyLine(-3,y1t,-3+dayStart[days],y1t);
       for d:=0 to days-1 do
        if ShowTnames[d] then
         begin
          p:=tsShow[d,Ip1];
          if (p=0) and (Ip1>1) then continue;
          fcolor(cpNormal);
          x:=dayStart[d]+PrntBlankwidth div 2;
          printw(TimeSlotName[d,p]);
         end;
      end;
    end;
  end; {local}

{=========----------============-----------===========-----------=============}
begin   {start of main weekly}
 Iy:=subttlistvals[1]; y2t:=0;
 dayStart[0]:=0;  ShowTnames[0]:=true;
 for d:=1 to days-1 do ShowTnames[d]:=(tsDayGroup[d]<>tsDayGroup[d-1]);
 for d:=1 to days do
  begin
   dayStart[d]:=dayStart[d-1]+Prntdx;
   if ShowTnames[d-1] then inc(dayStart[d],PrntTab1);
  end;

 VertOffset:=PrntTxtHeight div 3;
 lineheight:=PrntTxtHeight+VertOffset;
 if not(subttWide) then lineheight:=2*PrntTxtHeight+VertOffset;
 WeeklyHead;
 for Ip:=1 to tsShowMax do
  begin
   p:=tsShow[DayOfMaxPeriods,Ip];
   y1t:=y-VertOffset;
   for d:=0 to days-1 do
    if ShowTnames[d] then
     begin
      p:=tsShow[d,Ip];
      if (p=0) and (Ip>1) then continue;
      fcolor(cpNormal);
      x:=dayStart[d]+PrntBlankwidth div 2;
      printw(TimeSlotName[d,p]);
     end;
   drawMyLine(-3,y1t,-3+dayStart[days],y1t);
   for d:=0 to days-1 do linepos[d]:=subttL1[d,p];
   for Il:=1 to subttPnum[p] do
    begin
     y2t:=y+lineheight+3;
     for d:=0 to days-1 do
      begin
       p:=tsShow[d,Ip];
       if (p=0) and (Ip>1) then continue;
       if linepos[d]<=subttL2[d,p] then
       for L:=linepos[d] to subttL2[d,p] do
        begin
         aFnt:=FNT(d,p,Iy,L,0);
         sc:=aFnt^; inc(aFnt);  te:=aFnt^; inc(aFnt); ro:=aFnt^;
         j:=FNgetBlockNumber(d,p,Iy,L);
         if (sc>LabelBase) or ((j=subttBlock[d,p])and (sc>0)) or (subttBlock[d,p]=0)
            then begin ShowEntry; linepos[d]:=L+1; break; end;
        end;
      end;
     inc(y,lineheight); if Il=subttPnum[p] then inc(y,VertOffset);
     drawMyLine(-3,y1t,-3,y2t);
     for d:=0 to days do
      begin
       drawMyLine(-3+dayStart[d],y1t,-3+dayStart[d],y2t);
       if (d<days) and ShowTnames[d]
        then drawMyLine(-3+dayStart[d]+PrntTab1,y1t,-3+dayStart[d]+PrntTab1,y2t);
      end;
     y1t:=y2t;
     checkNeedContinue(Ip);
    end;  {for Il}
 end; {for Ip}
 drawMyLine(-3,y2t,(-3+dayStart[days]),y2t);  {close off}
 newline; newline;    {so custom doesnt overlap}
end;

procedure TPrintSubTt.SubTtPrintDaily;
var
 i,count,D,p,tab:     integer;
begin
 if subttgroupcnt=0 then
 begin
  printw('No subjects selected.');
  exit;
 end;

 UnderlineOn;
 printwl('Times for ');
 for i:=1 to subttgroupcnt do printwl(subcode[subttgroup[i]]+' ');
 newline;
 printwl(yearshort+': '+yearname[subttlistvals[1]]+' ');
 if ((subttlistselection=1) or (subttlistselection=4)) then
  printw('Level '+inttostr(subttlistvals[2]));
 UnderlineOff;
 newline;
 count:=0;
 tab:=fwprntDayname+PrintCanvas.textwidth(': ');
 for D:=0 to days-1 do
 begin
  newline;
  printw(dayname[D]+': ');
  inc(x,tab);
  for p:=0 to tlimit[d]-1 do
   if subtt[d,p]=1 then
     begin
      inc(count);
      printwl(TimeSlotName[d,p]+' ');
     end;
 end; {for D}
 newline; newline;
 printw('Entries:'+inttostr(count));
 newline;
end;


Procedure TPrintSubTt.SubTtPrint;
begin
 TabsDo:=true;
 PrintHead;
 if numcodes[0]=0 then
   begin
    printw('No subject codes entered.');
    exit;
   end;
 if subttlistselection=3 then SubTtPrintWeekly
  else SubTtPrintDaily;

 printCustomAddon;
end;

procedure subjectTtableprint;
begin
 PrintSubTt:=TPrintSubTt.create;
 try
  PrintSubTt.SubTtPrint;
 finally
  PrintSubTt.free;
 end;
end;


procedure TSuTtable.PopupMenu1Popup(Sender: TObject);
begin
 selection2.enabled:=(numcodes[0]>0);
end;

procedure TSuTtable.FormDblClick(Sender: TObject);
begin
 selection2click(self);
end;

{ -------------- TEXT OUTPUT PROCEDURES -----------------------------}

procedure TOutSubTt.head;
begin
 printLine(['Subject Timetable']);
end;


procedure TOutSubTt.SubTtOutWeekly;
var
 Iy,Ip,Il,j,L:      integer;
 p,d:                    integer;
 aStr,bStr,cStr,dStr:                    string;
 sc,te,ro:                   integer;
 doprint:                   bool;
 linepos:                      array[0..nmbrDays] of integer;
 ShowTnames: array[0..nmbrdays] of boolean;


  procedure ShowEntry;
  begin
   astr:=''; bStr:=''; cStr:='';
   if sc>LabelBase then aStr:=TcLabel[sc-LabelBase]
    else if ((sc>=0) and (sc<=numcodes[0])) then
      begin
       aStr:=subcode[sc];
       if ((te>=0) and (te<=numcodes[1])) then bStr:=trim(tecode[te,0]);
       if ((ro>=0) and (ro<=numcodes[2])) then cStr:=trim(tecode[ro,1]);
      end;
    dStr:='';
    if ShowTnames[d] then
    begin
     if (Il=1) and ((p>0) or (Ip=1)) then dStr:=TimeSlotName[d,p];
     if d=0 then printw(dStr) else printc(dStr);
    end;
    printc(aStr); printc(bStr);printc(cStr);
    doprint:=true;
  end;

  procedure ShowDummy;
  begin
   astr:=''; bStr:=''; cStr:='';
   dStr:='';
   if ShowTnames[d] then
    begin
     if (Il=1) and ((p>0) or (Ip=1)) then dStr:=TimeSlotName[d,p];
     if d=0 then printw(dStr) else printc(dStr);
    end;

   printc(aStr); printc(bStr);printc(cStr); doprint:=true;
  end;

begin   {start of main weekly}
 ShowTnames[0]:=true;
 for d:=1 to days-1 do ShowTnames[d]:=(tsDayGroup[d]<>tsDayGroup[d-1]);

 Iy:=subttlistvals[1];
 bStr:='Timetable for '+yeartitle+' '+yearname[Iy]+' ';
 aStr:=trim(ClassCode[ClassShown[subttlistvals[2],subttlistvals[1]]]);
   if aStr='' then astr:=' (level '+ inttostr(subttlistvals[2])+')'
    else aStr:=' Class '+aStr;
 printw(bStr+aStr); newline;
 for d:=0 to days-1 do
   begin
    aStr:=dayname[d];
    if (ShowTnames[d] and (d>0)) then printc('');
    printc(aStr); printc('');  printc('');
   end; {for dI}
  newline;

  for Ip:=1 to tsShowMax do
    begin
     p:=tsShow[DayOfMaxPeriods,Ip];
     for d:=0 to days-1 do linepos[d]:=subttL1[d,p];
     for Il:=1 to subttPnum[p] do
      begin
       for d:=0 to days-1 do
        begin
         p:=tsShow[d,Ip];
         if (p=0) and (Ip>1) then
          begin
           ShowDummy;
           continue;
          end;
         doprint:=false;
         if linepos[d]<=subttL2[d,p] then
         for L:=linepos[d] to subttL2[d,p] do
          begin
           aFnt:=FNT(d,p,Iy,L,0);
           sc:=aFnt^; inc(aFnt);  te:=aFnt^; inc(aFnt); ro:=aFnt^;
           j:=FNgetBlockNumber(d,p,Iy,L);
           if (sc>LabelBase) or ((j=subttBlock[d,p])and (sc>0)) or (subttBlock[d,p]=0)
              then begin ShowEntry; linepos[d]:=L+1; break; end;
          end;
         if not(doprint) then ShowDummy;
        end;
       newline;
      end;  {for Il}
   end; {for Ip}
 newline; newline;
end;


procedure TOutSubTt.SubTtOutDaily;
var
 i,count,p,D:     integer;
begin
 if subttgroupcnt=0 then
 begin
  printw('No subjects selected.');
  exit;
 end;
 printw('Times for ');
 for i:=1 to subttgroupcnt do
 begin
  printc(subcode[subttgroup[i]]+' ');
 end;
 newline;
 printw(yearshort+': '+yearname[subttlistvals[1]]+' ');
 if ((subttlistselection=1) or (subttlistselection=4)) then
  printw('Level '+inttostr(subttlistvals[2]));
 newline;
 count:=0;

 for D:=0 to days-1 do
 begin
  newline;
  printc(dayname[D]+': ');
  for p:=0 to tlimit[d]-1 do
   if subtt[d,p]=1 then
     begin
      inc(count);
      printc(TimeSlotName[d,p]+' ');
     end;
 end; {for D}
 newline; newline;
 printc('Entries:'); printc(inttostr(count)); newline;
end;


procedure TOutSubTt.SubTtOutput;
begin
 Header;
 if numcodes[0]=0 then
   begin
    printw('No subject data entered.');
    exit;
   end;
 if subttlistselection=3 then SubTtOutWeekly
  else SubTtOutDaily;
 printCustomAddon;
end;

procedure subjectTtabletext;
begin
 OutSubTt:=TOutSubTt.create;
 try
  OutSubTt.SubTtOutput;
 finally
  OutSubTt.free;
 end;
end;


end.
