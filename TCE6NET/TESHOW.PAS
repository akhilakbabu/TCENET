unit Teshow;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,classdefs,TCEglobals, GlobalToTcAndTcextra;

type
  TTeShowWin = class(TListTtWin)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    Procedure GeneralListContents(i,size,myset:integer;var Contents: array of integer);
    procedure CheckExtras(p:integer);
    procedure DisplayAddedTeTimetable;
  protected
    procedure SetTabs; override;
    procedure GetLists;  override;
    procedure GetListContents(i:integer); override;
    procedure ShowTtItems(i,d,p,x1: integer); override;
    procedure ListHead(i,d:integer); override;
    procedure ShowName(i:integer); override;
    procedure WeeklyFooter(i:integer); override;
  end;

var
  teshowwin: Tteshowwin;

implementation

uses
  tcommon,tcommon2,tcommon3, Mancover;

{$R *.DFM}

var
 testatusStr,tecoverStr: string;
 roomchange,roomchangeflag:    bool;
 televel,teyear,teroom,tesub: integer;
 tefound,IsActive: boolean;

procedure Tteshowwin.SetTabs;
var
 i,A1:       integer;
 j, k, star: integer;
begin
 if TeShowNum < 1000 then
 begin
   listtype:=winView[wnTeacherTt]+1;  CodeColor:=cpTeach; {teacher}
   day1:=tettlistvals[4]; day2:=tettlistvals[5];
   yFooter:=2*txtHeight;
   dx:=8+fwCode[0]+fwCode[2]+(blankwidth div 2);
   if tyr>0 then
     begin
      A1:=8+fwyearname;
      if A1>dx then dx:=A1;
      A1:=8+fwClass;
      if A1>dx then dx:=A1;
     end;
   if listtype=2 then
   begin         {weekly}
    A1:=8+fwDayname;
    if A1>dx then dx:=A1;
    tab1:=fwPeriodname+blankwidth;
   end
   else    {daily}
    begin
     A1:=8+fwperiodname;
     if A1>dx then dx:=A1;
     i:=fwcodename[1];
    if fwcode[1]>i then i:=fwcode[1];
    tab1:=i+blankwidth;
    end;
   GetLists;
   CalcArrayTops;
 end
 else
 begin
   SetLength(Tabs,8);
   star:=canvas.textwidth('*');
   MaxTab(1,fwperiodname,'Time ');
   MaxTab(2,fwcode[0],'Subject ');
   MaxTab(3,fwcode[2]+star,'Room ');
   MaxTab(4,fwyearname,yeartitle);
   MaxTab(5,fwclass,'Class');
   j:=fwcode[0];if fwabsence>j then j:=fwabsence;
   MaxTab(6,j,'Status W');
   MaxTab(7,fwcode[1],'Lost Class ');
   maxW:=tabs[7];
   maxH:=(7+periods)*txtheight;

   headwidth:=canvas.TextWidth('Date: 29 May  Timetable day: ')+fwDayname;
   j:=fwcode[1]+fwcodename[1];
   k:=fwAddedStaffcode+fwAddedStaffname;
   if k>j then j:=k;
   j:=canvas.textwidth('Teacher: ')+j+3*blankwidth;
   if j>headwidth then headwidth:=j;
 end;
end;


procedure TTeShowWin.ShowName(i: integer);
begin
 //tscount:=0; ldcount:=0;
 if listtype=1 then
  begin
   x:=blankwidth div 3;
   printw(tecode[i,0]);
   inc(y,txtHeight);
   printw(tename[i,0]);
   dec(y,txtHeight);
  end
  else printw(tecode[i,0]+' '+tename[i,0]);
end;

procedure TTeShowWin.ShowTtItems(i, d, p, x1: integer);
var
  ro,sc,teyear,lev,offset: integer;
  itemTt1,itemTt2,itemTt3: string;
begin
 if GetTeachTtItem(sc,ro,teYear,Lev,i,d,p) then
  begin
   if (sc<>subNA) then
    begin
     //inc(tscount); ldcount:=ldCount+tsAllot[d,p];
    end;
   itemTt1:=trim(SubCode[sc]);
   itemTt2:=trim(tecode[ro,1]);
   itemTt3:=FNycSHARED(d,p,i,1);
   offset:=(dx-3-canvas.textwidth(ItemTt1+' '+itemTt2)) div 2;
   x:=x1+offset; fcolor(cpSub); printwl(ItemTt1+' '); {subject}
   fcolor(cpRoom); printw(ItemTt2); {room}
   inc(y,txtHeight);
   offset:=(dx-3-canvas.textwidth(itemTt3)) div 2;
   x:=x1+offset; fcolor(cpClass); printw(itemTt3); {class}
   dec(y,txtHeight);
  end;
end;

procedure TTeShowWin.WeeklyFooter(i: integer);
begin
  inherited;
  //Keep
end;

procedure Tteshowwin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if IsActive then MancoverDlg.checkbox1.checked:=false;
 Action:=caFree;
end;

procedure Tteshowwin.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnTeShow);
end;


procedure GetAddTtItem(ETcode,P: integer);
var
 j: integer;
begin
 for j:=1 to numchanges do
  begin
    if (Changes[j].timeslot<>p) or (Changes[j].newte<>ETcode) or(Changes[j].kind<>1) then continue;
    tefound:=true; tesub:=Changes[j].sub; teroom:=Changes[j].newroom; teyear:=Changes[j].year;
    televel:=Changes[j].level;
    if (Changes[j].newroom>0) and (Changes[j].oldroom>0) and (Changes[j].newroom<>Changes[j].oldroom)
     then roomchange:=true;
    testatusStr:=GenType3(j);
    break;
  end; {for j}
end;

procedure Tteshowwin.CheckExtras(p:integer);
var
 slot,i: integer;
 astr: string;
begin
 astr:='-'; slot:=(1 shl p);
 if (teach[teshownum] and slot)=0 then astr:='T';
 if (tena[teshownum] and slot)=0 then astr:='N';
 if (telost[teshownum] and slot)=0 then astr:='L';
 if (tecover[teshownum] and slot)=0 then astr:='C';
 if (tereplace[teshownum] and slot)=0 then astr:='R';
 if (telieu[teshownum] and slot)=0 then astr:='I';
 if (teAbsent[teshownum] and slot)=0 then astr:='A';
 if astr='L' then tecoverStr:='Lost Class';
 if astr='A' then testatusStr:='Absent';
 roomchange:=false;
 if numchanges>0 then
  for i:=1 to numchanges do
   begin
    if ((Changes[i].timeslot=p) and (Changes[i].year=teyear)
     and (Changes[i].level=televel) and (Changes[i].oldte=teshownum)) then
    begin
     tefound:=true;
     if ((Changes[i].newroom<>Changes[i].oldroom) and (Changes[i].newroom>0)) then
      begin roomchange:=true; roomchangeflag:=true; teroom:=Changes[i].newroom; end;
     if (Changes[i].gen=1) then
     begin
      if (Changes[i].reason>0) then testatusStr:=copy(Absent[Changes[i].Reason],1,20);
      if (Changes[i].newte>0) then
      begin
       tecoverStr:=tecode[Changes[i].newte,0];
       if Changes[i].kind=1 then tecoverStr:=etsub[Changes[i].newte];
      end;
      if bool(Changes[i].needte) then tecoverStr:='Needed';
     end; {if}
    end; {if}
    if ((Changes[i].timeslot=p) and (Changes[i].newte=teshownum)) then
    begin
     case Changes[i].kind of
      2,3,4,5: begin
                tefound:=true; tesub:=Changes[i].sub; teroom:=Changes[i].newroom;
                teyear:=Changes[i].year; televel:=Changes[i].level;
               end;
     end; {case}
     case Changes[i].kind of
      2: testatusStr:='Replace';
      3: testatusStr:='In Lieu';
      4: testatusStr:='Extra';
      5: testatusStr:='Shared';
     end; {case}
    end;
   end; {for i}
end;

procedure Tteshowwin.FormPaint(Sender: TObject);
begin
  //Keep
end;

procedure TTeShowWin.GeneralListContents(i, size, myset: integer; var Contents: array of integer);
var
  j,count,countfrom,t: integer;
begin
  count:=0;
  if Size=0 then exit;
  if tettseltype=1 then countfrom:=codenum[1]
  else countfrom:=tettselection[0];
  for j:=1 to countfrom do
  begin
    t := TeShownum;
    if t > 1000 then
    begin
      t := t - 1000;
    end
    else
    begin
      //if tettseltype=2 then t:=tettselection[j] else t:=codepoint[j,1];
      if TeachInAnyFac(t,myset) then
      begin
        inc(count);
        Contents[count]:=t;
      end;
    end;
  end;
end;

procedure TTeShowWin.GetListContents(i: Integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TTeShowWin.GetLists;
var
  i,t,kk,count: integer;
begin
 NumOfLists:=1; SetArraySizes;
 if tettseltype=1 then count:=codenum[1]
  else count:=tettselection[0];
 kk:=0;
 if count>0 then
  for i:=1 to count do
   begin
    if tettseltype=2 then t:=tettselection[i] else t:=codepoint[i,1];
    if TeachInAnyFac(t,tettlistvals[3]) then inc(kk);
   end;
 ListSize[1]:=kk; ListSet[1]:=tettlistvals[3]
end;

procedure TTeShowWin.ListHead(i, d: integer);
var
  s:string;
  j: integer;
begin
 if listtype=1 then s:=dayname[d]+' for ' else s:='For ';
 j:=ListSet[i];
  case tettseltype of
   1: s:=s+'All Teachers';
   2: s:=s+'Teacher Selection';
  end; {case}
  if j>0 then s:=s+' in faculty '+facname[j];
  printw(s);   newline;
end;

procedure TTeShowWin.DisplayAddedTeTimetable;
var
 p,ETcode:       integer;
 astr:   string;
begin
  fcolor(cpNormal);
 codecolor:=cpTeach;
 ETcode:=0; if teshownum>1000 then ETcode:=teshownum-1000;
 printw2('Date: ',inttostr(exday)+' '+month[exmonth]);
 printw2('  Timetable day: ',dayname[ttday]);
 newline;
 if ETcode=0 then astr:=tecode[teshownum,0]+'  '+tename[teshownum,0]
   else astr:=etsub[ETcode]+'  '+ETname[ETcode];
 printw2('Teacher: ',astr);
 newline;       fcolor(cpNormal);
 printw('Time'); x:=tabs[1];
 printw('Subject'); x:=tabs[2];
 printw('Room'); x:=tabs[3];
 printw(Yeartitle); x:=tabs[4];
 printw('Class'); x:=tabs[5];
 printw('Status'); x:=tabs[6];
 printw('Cover');
 newline;
 roomchangeflag:=false;
 fcolor(codecolor);
 for p:=1 to tlimit[ttday] do
 begin
  tesub:=0; teroom:=0; teyear:=0; televel:=0; testatusStr:=''; tecoverStr:='';
  printw(TimeSlotName[ttDay,p-1]);  x:=tabs[1];
  tefound:=false; roomchange:=false;
  if ETcode>0 then   {added staff}
    GetAddTtItem(ETcode,P)
  else
   begin {normal teacher}
    tefound:=GetTeachTtItem(tesub,teroom,TeYear,TeLevel,teshownum,ttday,P-1);
    checkExtras(p);
   end;
  if tefound then
  begin
   printw(SubCode[tesub]);   x:=tabs[2];
   printwl(tecode[teroom,1]); if roomchange then printw('*');
   x:=tabs[3];
   printw(yearname[teyear]); x:=tabs[4];
   printw(ClassCode[ClassShown[televel,teyear]]); x:=tabs[5];

   printw(testatusStr); x:=tabs[6];
   printw(tecoverStr);
   {newline;   }
  end {if found}
  else
   if ETcode>0 then
    begin
     if (ETavail[ETcode] and (1 shl p))<>0 then astr:='(Free)' else
      astr:='(Not available)';
     printw(astr);
    end;
  newline;
 end; {for p}
 fcolor(cpNormal);
 if roomchangeflag then
 begin
  newline; printw('Note: * indicates a room change');
 end;
end;

procedure Tteshowwin.FormActivate(Sender: TObject);
begin
 IsActive:=true;
end;

procedure Tteshowwin.FormDeactivate(Sender: TObject);
begin
 IsActive:=false;
end;

end.
