unit Findte;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TFindTeacherWin = class(TDrawWin)
    PopupMenu1: TPopupMenu;
    Selection2: TMenuItem;
    N2: TMenuItem;
    Print1: TMenuItem;
    PrintSetup1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Selection2Click(Sender: TObject);
    procedure PrintSetup1Click(Sender: TObject);
  protected
    procedure SetTabs; override;
  end;

var
  FindTeacherWin: TFindTeacherWin;

procedure findteacherWinprint;
procedure findteacherWinOut;

implementation
uses tcommon,tcommon2,main,printers,tcommon3;

{$R *.DFM}

 type TPrintFindTe=class(TPrintDrawWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutFindTe=class(TOutputWin)
  public
   procedure head; override;
 end;

var
 PrintFindTe:    TPrintFindTe;
 OutFindTe:     TOutFindTe;
 testatusStr,tecoverStr: string;
 roomchange,roomchangeflag:    bool;
 televel,teyear,teroom,tesub: integer;
 tefound: boolean;

procedure TFindTeacherWin.SetTabs;
var
 j,k,star: integer;
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



procedure TFindTeacherWin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TFindTeacherWin.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnFindTeach);
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

procedure checkExtras(p:integer);
var
 slot,i: integer;
 astr: string;
begin
 astr:='-'; slot:=(1 shl p);
 if (teach[tefindnum] and slot)=0 then astr:='T';
 if (tena[tefindnum] and slot)=0 then astr:='N';
 if (telost[tefindnum] and slot)=0 then astr:='L';
 if (tecover[tefindnum] and slot)=0 then astr:='C';
 if (tereplace[tefindnum] and slot)=0 then astr:='R';
 if (telieu[tefindnum] and slot)=0 then astr:='I';
 if (teAbsent[tefindnum] and slot)=0 then astr:='A';
 if astr='L' then tecoverStr:='Lost Class';
 if astr='A' then testatusStr:='Absent';
 roomchange:=false;
 if numchanges>0 then
  for i:=1 to numchanges do
   begin
    if ((Changes[i].timeslot=p) and (Changes[i].year=teyear)
     and (Changes[i].level=televel) and (Changes[i].oldte=tefindnum)) then
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
    if ((Changes[i].timeslot=p) and (Changes[i].newte=tefindnum)) then
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


procedure TFindTeacherWin.FormPaint(Sender: TObject);
var
 p,ETcode:       integer;
 astr:   string;

begin
 fcolor(cpNormal);
 codecolor:=cpTeach;
 ETcode:=0; if tefindnum>1000 then ETcode:=tefindnum-1000;
 printw2('Date: ',inttostr(exday)+' '+month[exmonth]);
 printw2('  Timetable day: ',dayname[ttday]);
 newline;
 if ETcode=0 then astr:=tecode[tefindnum,0]+'  '+tename[tefindNum,0]
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
    tefound:=GetTeachTtItem(tesub,teroom,TeYear,TeLevel,tefindnum,ttday,P-1);
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

procedure TFindTeacherWin.Selection2Click(Sender: TObject);
begin
 MainForm.Teacher3Click(self);
end;

procedure TFindTeacherWin.PrintSetup1Click(Sender: TObject);
begin
 
end;

{------------------ print procs follow -----------------------}

procedure TPrintFindTe.head;
begin
 UnderlineOn;
 printwl('Find Teacher');
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
end;

procedure TPrintFindTe.SetTabs;
var
 star,j: integer;
begin
 SetLength(PrntTabs,8);
 star:=PrintCanvas.textwidth('*');
 MaxTab(1,fwprntperiodname,'Time ');
 MaxTab(2,fwprntcode[0],'Subject ');
 MaxTab(3,fwprntcode[2]+star,'Room ');
 MaxTab(4,fwprntyearname,yeartitle);
 MaxTab(5,fwprntclass,'Class');
 j:=fwprntcode[0];if fwprntabsence>j then j:=fwprntabsence;
 MaxTab(6,j,'Status W');
 MaxTab(7,fwprntcode[1],'Lost Class ');
end;



procedure findteacherWinprint;
var
 ETcode:          integer;
 p:       integer;
 astr:   string;
begin
 PrintFindTe:=TPrintFindTe.Create;
 with PrintFindTe do
  try
   PrintHead;
   fcolor(cpNormal); codecolor:=cpTeach;
   ETcode:=0; if tefindnum>1000 then ETcode:=tefindnum-1000;
   printw2('Date: ',inttostr(exday)+' '+month[exmonth]);
   printw2('  Timetable day: ',dayname[ttday]);
   newline;
   if ETcode=0 then astr:=tecode[tefindnum,0]+'  '+tename[tefindNum,0]
     else astr:=etsub[ETcode]+'  '+ETname[ETcode];
   printw2('Teacher: ',astr);
   newline; fcolor(cpNormal);
   printw('Time'); x:=PrntTabs[1];
   printw('Subject'); x:=PrntTabs[2];
   printw('Room'); x:=PrntTabs[3];
   printw(Yeartitle); x:=PrntTabs[4];
   printw('Class'); x:=PrntTabs[5];
   printw('Status'); x:=PrntTabs[6];
   printw('Cover');
   newline;
   roomchangeflag:=false;
   fcolor(codecolor);
   for p:=1 to tlimit[ttday] do
   begin
    tesub:=0; teroom:=0; teyear:=0; televel:=0; testatusStr:=''; tecoverStr:='';
    printw(TimeSlotName[ttDay,p-1]);  x:=PrntTabs[1];
    tefound:=false; roomchange:=false;
    if ETcode>0 then   {added staff}
     GetAddTtItem(ETcode,P)
    else
     begin {normal teacher}
      tefound:=GetTeachTtItem(tesub,teroom,TeYear,TeLevel,tefindnum,ttday,P-1);
      checkExtras(p);
     end;
    if tefound then
    begin
     printw(SubCode[tesub]);   x:=PrntTabs[2];
     printwl(tecode[teroom,1]); if roomchange then printw('*');
     x:=PrntTabs[3];
     printw(yearname[teyear]); x:=PrntTabs[4];
     printw(ClassCode[ClassShown[televel,teyear]]); x:=PrntTabs[5];
     printw(testatusStr); x:=PrntTabs[6];
     printw(tecoverStr);
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
   printCustomAddon;
 finally
  PrintFindTe.free;
 end;
end;




{------------------ TEXT OUTPUT procs follow -----------------------}

procedure TOutFindTe.head;
begin
 printLine(['Find Teacher']);
end;



procedure findteacherWinOut;
var
 ETcode:          integer;
 p:       integer;
 s,astr:   string;
begin
 OutFindTe:=TOutFindTe.Create;
 with OutFindTe do
  try
   Header;
   ETcode:=0; if tefindnum>1000 then ETcode:=tefindnum-1000;
   printw('Date:'); printc(inttostr(exday)+' '+month[exmonth]);
   printc('Timetable day:'); printc(dayname[ttday]);
   newline;
   if ETcode=0 then astr:=tecode[tefindnum,0]+'  '+tename[tefindNum,0]
     else astr:=etsub[ETcode]+'  '+ETname[ETcode];
   printw('Teacher:'); printc(astr);
   newline;
   printLine(['Time','Subject','Room',Yeartitle,'Class','Status','Cover']);
   roomchangeflag:=false;
   for p:=1 to tlimit[ttday] do
   begin
    tesub:=0; teroom:=0; teyear:=0; televel:=0; testatusStr:=''; tecoverStr:='';
    printw(TimeSlotName[ttDay,p-1]);
    tefound:=false; roomchange:=false;
    if ETcode>0 then   {added staff}
     GetAddTtItem(ETcode,P)
    else
     begin {normal teacher}
      tefound:=GetTeachTtItem(tesub,teroom,TeYear,TeLevel,tefindnum,ttday,P-1);
      checkExtras(p);
     end;
    if tefound then
    begin
     printc(SubCode[tesub]);
     s:=tecode[teroom,1]; if roomchange then s:=s+'*';
     printc(s);
     printc(yearname[teyear]);
     printc(ClassCode[ClassShown[televel,teyear]]);
     printc(testatusStr);
     printc(tecoverStr);
    end {if found}
    else
     if ETcode>0 then
      begin
       if (ETavail[ETcode] and (1 shl p))<>0 then astr:='(Free)' else
        astr:='(Not available)';
       printc(astr);
      end;
    newline;
   end; {for p}
   if roomchangeflag then
   begin
    newline; printLine(['Note: * indicates a room change']);
   end;
   printCustomAddon;
 finally
  OutFindTe.free;
 end;
end;

end.
