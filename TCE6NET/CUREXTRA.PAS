unit Curextra;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TCurrentExtrasWin = class(TStudListWin)
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N6: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    StudentTimetable1: TMenuItem;
    Copy1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Change2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure StudentTimetable1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
  protected
    procedure SetTabs; override;
    procedure GetLists; override;
    procedure GetListContents(i: integer); override;
    procedure PaintHead;  override;
    procedure ListHead(i:integer);  override;
  end;

var
  CurrentExtrasWin: TCurrentExtrasWin;

procedure CurrentExtrasWinprint;
procedure CurrentExtrasWinOut;

implementation

uses
  tcommon,tcommon2,vwcrextr,main,tcommon3,printers,StCommon, ManCover, EXCOVER;
{$R *.DFM}

type TPrintCurrentExtras=class(TPrintStudListWin)
  private
   DoneHeading: boolean;
   procedure ImplementPrint;
   procedure PeriodHead;
   procedure YearHead;
   procedure CoverHead;
  public
   procedure head; override;
   procedure SetTabs; override;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i:integer); override;
 end;

type TOutCurrentExtras=class(TOutStudListWin)
  private
   procedure ImplementPrint;
  public
   procedure head; override;
   procedure SetTabs;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i:integer); override;
 end;

var
 PrintCurrentExtras:    TPrintCurrentExtras;
 OutCurrentExtras:      TOutCurrentExtras;

 free2:   array[0..nmbrteachers] of integer;
 num:           integer;
 ETprint: bool;
 Stab,PrntStab: array[1..16] of integer; {summary tabs}
 treqtot,temp: double;
 treqtotal,tgottotal,tneedtotal,tavailtotal: integer;
 rreqtotal,rgottotal,rneedtotal,ravailtotal: integer;

function GenType(gen: smallint):string;
begin
  result:='';
  case gen of
   0: result:='Change';
   1: result:='Absent';
   2: result:='New';
   3: result:='Merge';
   5: result:='Conseq.';
   6: result:='Swap';
  end; {case}
end;

function GenType2(k: integer):string;
begin
 result:='';
 case Changes[k].gen of
   0: result:='Room change';
   1: result:=tename[Changes[k].oldte,0]+' absent';
   2: result:='New class';
   3: result:='Merged class';
   5: result:='Consequent change';
   6: result:='Teacher swap from '+tename[Changes[k].oldte,0];
  end; {case}
end;

procedure resourceCount;
var
 i,i5,p,aflag,rflag,iflag: integer;
 astr:   string;
 tempreplace,tempinlieu: double;
 tempextra,a: integer;
begin
 for i:=1 to tlimit[ttday] do
 begin
  tneed[i]:=0; tgot[i]:=0; tavail[i]:=0; trequire[i]:=0; treq[i]:=0;
  rneed[i]:=0; rgot[i]:=0; ravail[i]:=0; rrequire[i]:=0; treplace[i]:=0;
  tlieu[i]:=0; rlost[i]:=0; eavail[i]:=0; textra[i]:=0;
 end;
 if numchanges>0 then 
  for i:=1 to numchanges do
  begin
   if ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].gen=4) then continue;
   a:=Changes[i].timeslot;
   if bool(Changes[i].kind and not(Changes[i].needte)) then
    begin inc(tgot[a]); inc(trequire[a]); treq[a]:=treq[a]+getEallot(1,Changes[i].year,ttday,a); end;
   if bool(Changes[i].needte) then
    begin inc(tneed[a]); inc(trequire[a]); treq[a]:=treq[a]+getEallot(1,Changes[i].year,ttday,a); end;
   if Changes[i].needroom=1 then
    begin inc(rneed[a]); inc(rrequire[a]); end;
   if Changes[i].needroom=2 then
    begin inc(rgot[a]); inc(rrequire[a]); end;
  end; {for i}


 for i:=1 to numcodes[1] do
 begin
  astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
  for p:=1 to tlimit[ttday] do
  begin
   aflag:=0; rflag:=0; iflag:=0;
   if ((getEallot(4,0,ttday,p)+Etaken[i])<=Emax[i])
    or (teavail[i]>=getEallot(4,0,ttday,p))
    or (telieudbl[i]>=getEallot(4,0,ttday,p)) then
     if bool(teon[i] and (1 shl p) and (teAbsent[i]) and (tena[i])) then
      begin inc(tavail[p]); aflag:=-1; end;
   if aflag<>0 then
   begin
    if teavail[i]>=getEallot(4,0,ttday,p) then
     begin rflag:=-1; inc(treplace[p]); end
     else
      if telieudbl[i]>=getEallot(4,0,ttday,p) then
       begin iflag:=-1; inc(tlieu[p]); end;
   end;
   if bool(aflag) and (rflag=0) and (iflag=0) then inc(textra[p]);
  end; {for p}
 end; {for i}

 for i:=1 to numcodes[2] do
  for p:=1 to tlimit[ttday] do
  begin
   if bool(roomon[i] and (1 shl p) and roAbsent[i]) then
   begin
    inc(ravail[p]);
    if (rolost[i] and (1 shl p))=0 then inc(rlost[p]);
   end;
  end;
 for i5:=1 to etnum1 do
 begin
  i:=Etpointer[i5];
  astr:=copy(etsub[i],1,2); if astr='00' then continue;
  for p:=1 to tlimit[ttday] do
  begin
   if (Etmax[i]>=(Ettaught[i]+getEallot(4,0,ttday,p))) and
    bool(etavail[i] and Eton[i] and (1 shl p)) then
    begin inc(tavail[p]); inc(eavail[p]); end;
  end; {for p}
 end; {for i5}
 treqtotal:=0; treqtot:=0; tgottotal:=0; tneedtotal:=0; tavailtotal:=0;
 rreqtotal:=0; rgottotal:=0; rneedtotal:=0; ravailtotal:=0;
 for p:=1 to tlimit[ttday] do
 begin
  inc(treqtotal,trequire[p]); treqtot:=treqtot+treq[p];
  inc(tgottotal,tgot[p]); inc(tneedtotal,tneed[p]);
  inc(rreqtotal,rrequire[p]); inc(rgottotal,rgot[p]);
  inc(rneedtotal,rneed[p]);
  if rneed[p]>0 then
   inc(ravailtotal,ravail[p]);
 end; {for p}
 for i5:=1 to etnum1 do
 begin
  i:=Etpointer[i5];
  astr:=copy(etsub[i],1,2); if astr='00' then continue;
  temp:=Etmax[i]-Ettaught[i];
  for p:=1 to tlimit[ttday] do
   if (tneed[p]>0) and (temp>=getEallot(7,i,ttday,p)) and
    bool(etavail[i] and Eton[i] and (1 shl p)) then
    begin inc(tavailtotal); temp:=temp-getEallot(7,i,ttday,p); end;
 end; {for i5}
 for i:=1 to numcodes[1] do
 begin
  astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
  tempreplace:=teavail[i]; tempextra:=0; tempinlieu:=telieudbl[i];
  for p:=1 to tlimit[ttday] do
  begin
   if bool(tempextra) or (tneed[p]<=0) then continue;
   if ((teon[i] and (1 shl p) and teAbsent[i]) and (tena[i]))=0 then continue;
   if tempreplace>=getEallot(2,i,ttday,p) then
   begin
    inc(tavailtotal); tempreplace:=tempreplace-getEallot(2,i,ttday,p); continue;
   end;
   if tempinlieu>=getEallot(2,i,ttday,p) then
   begin
    inc(tavailtotal); tempinlieu:=tempinlieu-getEallot(2,i,ttday,p); continue;
   end;
   if ((getEallot(2,i,ttday,p)+Etaken[i])<=Emax[i]) then
   begin
    inc(tavailtotal); tempextra:=-1;
   end;
  end;
 end;
end;

procedure clearFree;
var
 v: integer;
begin
 for v:=0 to nmbrteachers do free2[v]:=0;
end;

procedure selectSub;
var i,kk:integer;
begin
 kk:=winView[wnCurrentExtras]-1;
 for i:=1 to winCurrentExtrasSelectionCount[kk] do
  free2[i]:=winCurrentExtrasSelection[kk][i];
 num:=winCurrentExtrasSelectionCount[kk];
end;

procedure ETallWeekly;
var
 i,j: integer;
 tag:   array[0..nmbrteachers] of bool;
begin
 num:=0;
 for i:=1 to nmbrteachers do tag[i]:=false;
 for i:=1 to numchanges do
  begin
   if (Changes[i].kind>9) and (not(IgnoreStatusMsgFlag)) then continue;
   if (Changes[i].kind<>1) then continue;
   tag[Changes[i].newte]:=true;
  end;
 for i:=1 to etnum1 do
  begin
   j:=Etpointer[i];
   if tag[j] then
      if (winCurrentExtrasBrief2=1)
       or(ETfaculty[j]=-1) or (ETfaculty[j]=winCurrentExtrasCode) then
    begin inc(num); free2[num]:=j; end;
  end;
end;

procedure allWeekly;
var
 i,j: integer;
 tag:   array[0..nmbrteachers] of bool;
begin
 num:=0;
 for i:=1 to nmbrteachers do tag[i]:=false;
 if winView[wnCurrentExtras]=2 {absent teachers} then
  for i:=1 to codenum[1] do
   begin
    j:=codepoint[i,1];
    if teAbsent[j]<>-1 then tag[j]:=true;
   end
 else {covering teachers}
 for i:=1 to numchanges do
  begin
   if (Changes[i].kind>9) and (not(IgnoreStatusMsgFlag)) then continue;
   if (Changes[i].kind=1) then continue;
   tag[Changes[i].newte]:=true
  end;
 for i:=1 to codenum[1] do
  begin
   j:=codepoint[i,1];
   if tag[j] then
      if (winCurrentExtrasBrief2=1)
      or (TeachInAnyFac(j,winCurrentExtrasCode)) then
    begin inc(num); free2[num]:=j; end;
  end;
end;

procedure ETweeklyInsub;
begin
 num:=0; clearFree;
 case winCurrentExtrasBrief2 of
  1,3: ETallweekly;
  2: selectSub;
 end;
end;

procedure weeklyInsub;
begin
 num:=0; clearFree;
 case winCurrentExtrasBrief2 of
  1,3: allweekly;
  2: selectSub;
 end;
end;

function CountStudClass(myset: integer):integer;
var
 j,count: integer;
begin
 count:=0;
 if Changes[myset].sub>0 then
  begin
   GetShares(myset);
    for j:=1 to GroupNum do
     if IncludeStud(j,myset) then inc(count);
  end
 else if ((Changes[myset].level>0) and (Changes[myset].gen=2)) then
     for j:=1 to GroupNum do
         if Stud[StPointer[j]].Tcclass=Changes[myset].level then
             inc(count);
 result:=count;
end;

Procedure GeneralListContents(i,size,myset:integer;var Contents: array of integer);
var
 j,count: integer;
begin
 count:=0;
 if Size=0 then exit;
 if Changes[myset].sub>0 then
  begin
   GetShares(myset);
    for j:=1 to GroupNum do
     if IncludeStud(j,myset) then
       begin inc(count); Contents[count]:=StPointer[j]; end;
  end
 else if ((Changes[myset].level>0) and (Changes[myset].gen=2)) then
     for j:=1 to GroupNum do
         if Stud[StPointer[j]].Tcclass=Changes[myset].level then
             begin inc(count); Contents[count]:=StPointer[j]; end;
end;

procedure TCurrentExtrasWin.GetListContents(i:integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TCurrentExtrasWin.ListHead(i:integer);
var
 te,su,j,k,p: integer;
 astr,bstr: string;
begin
 k:=ListSet[i];
 su:=Changes[k].sub;
 j:=Changes[k].level;
 te:=Changes[k].newte;
 p:=Changes[k].timeslot;
 fcolor(cpNormal);
 if etprint then astr:=ETname[te] else astr:=tename[te,0];
 astr:=astr+'   Date: '+dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth];
 printw(astr); newline; if double_space then newline;
 fcolor(codecolor);
 printw2('Time: ',TimeSlotName[ttDay,p-1]);
 if (EPTimes) then  begin
    DateTimeToString(astr,'hh:mm',tsStart[ttDay,p-1]);
    DateTimeToString(bstr,'hh:mm',tsEnd[ttDay,p-1]);
    printw2('',' ('+astr+'-'+bstr+')    ');
 end else begin
    printw2('','    ');
 end;
 printw2('Room: ',tecode[Changes[k].newroom,1]);
 newline; if double_space then newline;
 if ClassShown[j,Changes[k].year]>0 then
     astr:=ClassCode[ClassShown[j,Changes[k].year]]
   else astr:='';
 if (Changes[k].gen=2) then astr:=ClassCode[j];
 printw2(Yeartitle+': ',yearname[Changes[k].year]+'   ');
 if Trim(astr)<>'' then printw2('Class: ',astr+'   ');
 if su>0 then
  begin
   printw2('Subject: ',SubCode[su]+' '+subname[su]);
   GetShares(k);
   if SubShareFlag then printwl(' / '+SubCode[ShareSub]+' '+subname[ShareSub]+ '(share)');
  end;
 newline; if double_space then newline;
 printwl(GenType2(k));
 if (Changes[k].gen=1) and epreason and (Changes[k].reason>0) then
  begin
   printwl('   ('+Abcode[Changes[k].reason]+' '+Absent[Changes[k].reason]+')');
  end;
 newline; newline; if double_space then begin newline; newline; end;
 if not(etprint) then
  begin
   fcolor(cpNormal); printwl('Cover type: '); fcolor(codecolor);
   printwl(printkind(k));
   newline;  if double_space then newline;
  end;
 fcolor(cpNormal); printwl('Notes: '); fcolor(codecolor);
 printw(getstatusnote(k));
 newline; newline; fcolor(cpNormal); if double_space then begin newline; newline; end;
 if su>0 then
 begin
   printwl('Student List for ' + Trim(SubCode[su]) + ' ' + Trim(SubName[Su]));
   if SubShareFlag then
     printwl(' / ' + Trim(SubCode[ShareSub]) + ' ' + Trim(SubName[ShareSub]) + '(share):')
   else
     printwl(':');
 end
 else if ((j>0) and (Changes[k].gen=2)) then
   printw('Student List for '+ClassCode[j]+':');
 newline;
 fcolor(codecolor);
end;

procedure TCurrentExtrasWin.PaintHead;
var
 astr: string;
begin
  fcolor(cpNormal);
  if winView[wnCurrentExtras]=3 then
  begin
    astr := 'Cover teachers';
    Self.Caption := 'Current Extras - by Cover Teachers';
  end
  else
  begin
    astr := 'Added staff';
    Self.Caption := 'Current Extras - by Added Staff';
  end;
  if ListType=1 then
  printWl(astr+ ' subject lists for students in Group: '+groupname+' sorted by '+groupsortname[groupsort]);
  newline;
end;

procedure TCurrentExtrasWin.GetLists;
var
 i,j,p,te: integer;
begin  {start for main of student list range calc}
 NumOfLists:=1; SetArraySizes;
 NumOfLists:=0;
 for j:=1 to num do
 begin
  te:=free2[j];
  for p:=1 to tlimit[ttday] do
  begin
   for i:=1 to numchanges do
   begin
    if (Changes[i].timeslot<>p) or (Changes[i].newte<>te) then continue;
    if (Changes[i].kind>9) and (not(IgnoreStatusMsgFlag)) then continue;
    if (Changes[i].kind<>1) and (Changes[i].oldte=Changes[i].newte) then continue;
    if (ETprint xor (Changes[i].kind=1)) then continue;
    inc(NumOfLists); SetArraySizes;
    ListSet[NumOfLists]:=i;
    ListSize[NumOfLists]:=CountStudClass(i);
   end; {for i}
  end; {for p}
 end; {for j}
end;

procedure TCurrentExtrasWin.SetTabs;
var
 lc,i,i2,j,k,p,a,m,start,finish,y,count:     integer;
 found: bool;
 astr: string;
 te,sw,SummaryW:    integer;
 fwTeach,fwTeachName,fwNote: integer;
begin
 fwTeach:=fwcode[1]; if fwTeach<fwAddedStaffcode then fwTeach:=fwAddedStaffcode;
 fwTeachName:=fwCodeName[1];
 if fwTeachName<fwAddedStaffname then fwTeachName:=fwAddedStaffname;
 updateRoomMap;
 updateteachermap;
 displayCounts;
 merge_classes;
 new_classes;
 ListType:=2;  codeColor:=cpCurrent;
 etprint:=(winView[wnCurrentExtras]=4);
 if eplist and ((winView[wnCurrentExtras]=3) or (winView[wnCurrentExtras]=4)) then
  begin
   codeColor:=cpStList; EnrolFlag:=False; ShowZeroList:=true;
   ListType:=1;
   if winView[wnCurrentExtras]=3 then
     begin weeklyInsub; ListHeadLines:=9; end
    else begin ETweeklyInsub; ListHeadLines:=8; end;
   GetLists;
   CalcArrayTops;
   RedoSelection;
   exit;
  end;


 j:=canvas.textwidth('Note');
 if fwCoverNote>j then j:=fwCoverNote;
 if notenum>0 then
   for i:=1 to notenum do
    begin
     k:=canvas.textwidth(ExNote[i]);
     if k>j then j:=k;
    end;
 fwNote:=j;

// Summary tabs
  i:=canvas.textwidth('W');
  j:=canvas.textwidth('M');
  if j>i then i:=j;
  j:=canvas.textwidth('Rooms Unavailable 9999   ');
  k:=fwcode[2]+fwcodename[2]+blankwidth*2;
  if k>j then j:=k;
  k:=fwcode[0]+fwcodename[0]+blankwidth*2;
  if k>j then j:=k;
  Stab[1]:=fwcode[1]+fwcodename[1]+blankwidth*2;
  if Stab[1]<j then Stab[1]:=j;
  Stab[2]:=Stab[1]+i*tlimit[ttday]+blankwidth;
  Stab[3]:=Stab[2]+canvas.textwidth('Times  ');
  Stab[4]:=Stab[3]+canvas.textwidth('Alloted  ');
  Stab[5]:=Stab[4]+fwabsence;
  Stab[6]:=Stab[1]+i*tlimit[ttday]+blankwidth;

  j:=canvas.textwidth(YearTitle);
  if j<fwyearname then j:=fwyearname;
  Stab[7]:=Stab[6]+j+blankwidth;
  j:=canvas.textwidth('Class');
  if j<fwclass then j:=fwclass;
  Stab[8]:=Stab[7]+j+blankwidth;
  Stab[9]:=Stab[8]+canvas.textwidth('Teachers ')+blankwidth;
  Stab[10]:=Stab[9]+canvas.textwidth('Rooms ')+blankwidth;

  Stab[11]:=canvas.textwidth('Merged classes  999  ');
  j:=canvas.textwidth('Time slot');
  if j<fwperiodname then j:=fwperiodname;
  Stab[12]:=Stab[11]+j+blankwidth;
  j:=canvas.textwidth(YearTitle);
  if j<fwyearname then j:=fwyearname;
  Stab[13]:=Stab[12]+j+blankwidth;
  j:=canvas.textwidth('Class');
  if j<fwclass then j:=fwclass;
  Stab[14]:=Stab[13]+j+blankwidth;
  j:=canvas.textwidth('Teacher change');
  k:=canvas.textwidth('  =>  ');
  if j<(fwcode[1]*2+k) then j:=(fwcode[1]*2+k);
  Stab[15]:=Stab[14]+j+blankwidth;
  j:=canvas.textwidth('Room');
  if j<fwcode[2] then j:=fwcode[2];
  Stab[16]:=Stab[15]+j+blankwidth;

  lc:=3; SummaryW:=0;
  if esprint or (winView[wnCurrentExtras]=5) then
  begin
   if ESteach and (countAbsTes>0) then
     begin
      inc(lc,teabsent2+2);
      if Stab[5]>SummaryW then SummaryW:=Stab[5];
     end;
   if EStlost and (telostnum>0) then
     begin
      inc(lc,telostnum+2);
      if Stab[4]>SummaryW then SummaryW:=Stab[4];
     end;
   if ESadd and bool(ETselected) then
     begin
      inc(lc,ETselected+2);
      if Stab[4]>SummaryW then SummaryW:=Stab[4];
     end;
   if ESroom and bool(roomsUnavail) then
    begin
     inc(lc,roomsunavail+2);
     if Stab[4]>SummaryW then SummaryW:=Stab[4];
    end;
   if ESrlost and (rolostnum>0) then
    begin
     inc(lc,rolostnum+2);
     if Stab[4]>SummaryW then SummaryW:=Stab[4];
    end;
   if ESnew and (newClassnum>0) then
    begin
     inc(lc,newclassnum+2);
     if Stab[10]>SummaryW then SummaryW:=Stab[10];
    end;
   if ESmerge and (mergedClasses>0) then
    begin
     inc(lc,mergedclasses+2);
     if Stab[16]>SummaryW then SummaryW:=Stab[16];
    end;
  end;

 SetLength(Tabs,12);
 case winView[wnCurrentExtras] of
  0: begin {period Extras}
      MaxTab(1,fwperiodname,'Time');
      MaxTab(2,fwcode[0],'Subject');
      MaxTab(3,fwyearname,Yeartitle);
      MaxTab(4,fwclass,'Class');
      MaxTab(5,fwcode[1],'Teacher');
      MaxTab(6,fwcode[2],'Room');
      MaxTab(7,0,'Conseq.');
      MaxTab(8,fwcode[2],'Room ');
      MaxTab(9,fwTeach,'Teacher ');
      MaxTab(10,0,'Replace');
      Tabs[11]:=Tabs[10]+fwNote+blankwidth;
      maxW:=Tabs[11];
      inc(lc,5);
       for p:=1 to tlimit[ttday] do
       begin
        if tsOn[ttday,p-1] then
        begin
         count:=0;
         for i:=1 to numchanges do
         begin
          if (Changes[i].timeslot<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].gen=4) then continue;
          if not(EProom) and (Changes[i].oldte=Changes[i].newte) and (Changes[i].kind<>1) and
            (Changes[i].oldte>0) then continue;
          if not(EPteach) and (Changes[i].oldroom=Changes[i].newroom) then continue;
          inc(count);
         end; {for i}
         if count=0 then inc(count);
         inc(count);
         inc(lc,count);
        end;
       end; {for p}
     end;
  1: begin {year Extras}
      MaxTab(1,fwyearname,Yeartitle);
      MaxTab(2,fwclass,'Class');
      MaxTab(3,fwperiodname,'Time');
      MaxTab(4,fwcode[0],'Subject');
      MaxTab(5,fwcode[2],'Room');
      MaxTab(6,8*i,'Change');
      MaxTab(7,fwcode[2],'New Room');
      MaxTab(8,fwTeach,'Cover Teacher');
      maxW:=Tabs[8];
      if winCurrentExtrasyear<0 then
       begin start:=years_minus_1; finish:=0; end
      else
        begin start:=winCurrentExtrasyear; finish:=winCurrentExtrasyear; end;
       inc(lc,4);
       for y:=start downto finish do
       begin
        count:=0;
        for p:=1 to tlimit[ttday] do
        begin
         if not(tsOn[ttday,p-1]) then continue;
         for i:=1 to numchanges do
         begin
          if ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].gen=4) or (Changes[i].timeslot<>p) or (Changes[i].year<>y) then
           continue;
          if not(eproom) and (Changes[i].oldte=Changes[i].newte) and (Changes[i].kind<>1) and (Changes[i].oldte>0) then
           continue;
          if not(epteach) and (Changes[i].oldroom=Changes[i].newroom) then continue;
          inc(count);
         end; {for i}
        end; {for p}
        if count=0 then inc(count);
        inc(count);
        inc(lc,count);
       end; {for y}
     end;
  2: begin {absent Teachers}
      Self.Caption := 'Current Extras - by Absent Teachers';
      lc:=2;
      MaxTab(1,fwperiodname,'Time');
      MaxTab(2,fwcode[0],'Subject');
      MaxTab(3,fwyearname,Yeartitle);
      MaxTab(4,fwclass,'Class');
      MaxTab(5,fwcode[2],'Room');
      MaxTab(6,fwTeachName,'New Teacher');
      MaxTab(7,0,'Status W');
      Tabs[8]:=Tabs[7]+fwNote+blankwidth;
      maxW:=Tabs[8];
      weeklyInSub;
       if num>0 then
        for j:=1 to num do
         begin
          if teAbsent[free2[j]]=-1 then continue;
          inc(lc,6);
          for p:=1 to tlimit[ttday] do
           if (teAbsent[free2[j]] and (1 shl p))=0 then inc(lc);
         end; {for j}
     end;
  3,4: begin {covering teachers}
        PaintHead;
        MaxTab(1,fwcodename[1],'Teacher');
        j:=canvas.textwidth(dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth]);
        if Tabs[1]<j then Tabs[1]:=j;
        MaxTab(2,fwperiodname,'Time');
        MaxTab(3,fwcode[0],'Subject');
        MaxTab(4,fwyearname,Yeartitle);
        MaxTab(5,fwclass,'Class');
        MaxTab(6,fwcode[2],'Room');
        j:=fwcode[1]+canvas.textwidth(' absent');
        MaxTab(7,j,'Teacher swap');
        j:=canvas.textwidth('Status W'); if j<fwAbsence then j:=fwAbsence;
        MaxTab(8,j,'In Lieu');
        j:=fwNote+blankwidth; if epreason then j:=j+fwAbsence+blankwidth;
        Tabs[9]:=Tabs[8]+j;
        maxW:=Tabs[9];
        if winView[wnCurrentExtras]=3 then
         begin
          weeklyInsub;
          inc(lc,4);
          for j:=1 to num do
           begin
            te:=free2[j]; found:=false;
            for i:=1 to numchanges do
             begin
              if ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag)))
                  or (Changes[i].newte<>te) then continue;
              if not(false xor (Changes[i].kind=1)) then found:=true;
             end; {for i}
            if not(found) then continue;
            inc(lc);
            for p:=1 to tlimit[ttday] do
             for i:=1 to numchanges do
             begin
              if (Changes[i].timeslot<>p) or (Changes[i].newte<>te) then continue;
              if (false xor (Changes[i].kind=1)) then continue;
              inc(lc);
             end; {for i}
             inc(lc);
           end; {for j}
         end {if winView[wnCurrentExtras]=3}
        else
         begin {winView[wnCurrentExtras]=4}
          ETweeklyInsub;
          inc(lc,4);
          for j:=1 to num do
           begin
            te:=free2[j]; found:=false;
            for i:=1 to numchanges do
            begin
             if ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].newte<>te) then continue;
             if not(true xor (Changes[i].kind=1)) then found:=true;
            end; {for i}
            if not(found) then continue;
            inc(lc);
            for p:=1 to tlimit[ttday] do
             for i:=1 to numchanges do
             begin
              if (Changes[i].timeslot<>p) or (Changes[i].newte<>te) then continue;
              if (true xor (Changes[i].kind=1)) then continue;
              inc(lc);
             end; {for i}
             inc(lc);
           end; {for j}
         end;
       end;
  5: begin
      maxW:=SummaryW; {summary}
     end;
  6: begin {resources}
      Tabs[1]:=fwperiodname+blankwidth;
      MaxTab(2,0,'W');
      MaxTab(3,0,'Used: ');
      MaxTab(4,0,'Avail: ');
      Tabs[9]:=trunc(screen.width*0.9);
      maxW:=Tabs[9];
      resourceCount;
      inc(lc,4);
      for p:=1 to tlimit[ttday] do
       begin
        inc(lc);
        if tgot[p]>0 then inc(lc);
        if (tavail[p]>0) then
        begin
         if eavail[p]>0 then inc(lc);
         if treplace[p]>0 then inc(lc);
         if tlieu[p]>0 then inc(lc);
         if textra[p]>0 then inc(lc);
        end; {if (tavail[p]>0) then}
        inc(lc);
        if rgot[p]>0 then inc(lc);
        if ravail[p]>0 then
        begin
         if rlost[p]>0 then inc(lc);
         rextra[p]:=ravail[p]-rlost[p];
         if rextra[p]>0 then inc(lc);
        end;
        inc(lc);
       end; {for p}

{check for list lines which are split into more than one lines on screen}
      j:=0; sw:=trunc(screen.width*0.8);
      for p:=1 to tlimit[ttday] do
       begin
        if tgot[p]>0 then
        begin
         k:=0; m:=fwAddedStaffcode; if fwcode[1]>m then m:=fwcode[1];
         for i:=1 to numchanges do
         begin
          a:=Changes[i].timeslot;
          if (a<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) then continue;
          if ((Changes[i].kind>0) and (Changes[i].needte=0) and (Changes[i].newte>0)) then
          begin
           inc(k);
          end;
         end; {for i}
         inc(j,((k*m) div (sw-Tabs[4])));
        end; {if tgot[p]>0 then}

        if (tavail[p]>0) then
        begin
         if eavail[p]>0 then
         begin
          k:=0;
          for i2:=1 to etnum1 do
          begin
           i:=Etpointer[i2];
           if (Etmax[i]>=(Ettaught[i]+getEallot(7,i,ttday,p))) and
            bool(etavail[i] and Eton[i] and (1 shl p)) then
            inc(k);
          end; {for j}
          inc(j,((k*fwcode[1]) div (sw-Tabs[4])));
         end;

         if treplace[p]>0 then
         begin
          k:=0;
          for i2:=1 to codenum[1] do
          begin
           i:=codepoint[i2,1];
           astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
           if (teavail[i]>=getEallot(4,0,ttday,p)) and bool(teon[i] and (1 shl p) and teAbsent[i])
            and bool(tena[i]) then
            inc(k);
          end; {for j}
          inc(j,((k*fwcode[1]) div (sw-Tabs[4])));
         end;

         if tlieu[p]>0 then
         begin
          k:=0;
          for i2:=1 to codenum[1] do
          begin
           i:=codepoint[i2,1];
           astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
           if (telieu[i]>=getEallot(4,0,ttday,p))
            and (teavail[i]<getEallot(4,0,ttday,p)) and
            bool(teon[i] and (1 shl p) and teAbsent[i]) and bool(tena[i]) then
            inc(k);
          end; {for j}
          inc(j,((k*fwcode[1]) div (sw-Tabs[4])));
         end;

         if textra[p]>0 then
         begin
          k:=0;
          for i2:=1 to codenum[1] do
          begin
           i:=codepoint[i2,1];
           astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
           if ((getEallot(4,0,ttday,p)+Etaken[i])<=Emax[i])
            and (telieu[i]<getEallot(4,0,ttday,p)) and
            (teavail[i]<getEallot(4,0,ttday,p)) and bool(teon[i] and (1 shl p) and teAbsent[i])
             and bool(tena[i]) then
             inc(k);
          end; {for j}
          inc(j,((k*fwcode[1]) div (sw-Tabs[4])));
         end;
        end; {if (tavail[p]>0) then}

        if rgot[p]>0 then
        begin
         k:=0;
         for i:=1 to numchanges do
         begin
          a:=Changes[i].timeslot;
          if (a<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].newroom=0) or (Changes[i].needroom<>2) then continue;
          inc(k);
         end; {for i}
         inc(j,((k*fwcode[2]) div (sw-Tabs[4])));
        end;

        if ravail[p]>0 then
        begin
         if rlost[p]>0 then
         begin
          k:=0;
          for i2:=1 to codenum[2] do
          begin
           i:=codepoint[i2,2];
           astr:=copy(tecode[i,1],1,2); if astr='00' then continue;
           if bool(roomon[i] and (1 shl p) and roAbsent[i]) and
            ((rolost[i] and (1 shl p))=0) then
            inc(k);
          end; {for j}
          inc(j,((k*fwcode[2]) div (sw-Tabs[4])));
         end;

         rextra[p]:=ravail[p]-rlost[p];
         if rextra[p]>0 then
         begin
          k:=0;
          for i2:=1 to codenum[2] do
          begin
           i:=codepoint[i2,2];
           astr:=copy(tecode[i,1],1,2); if astr='00' then continue;
           if bool(roomon[i] and (1 shl p) and roAbsent[i] and rolost[i]) then
            inc(k);
          end; {for j}
          inc(j,((k*fwcode[2]) div (sw-Tabs[4])));
         end;
        end;
       end; {for p}
       inc(lc,j); {added lines which were split to fit}

      inc(lc,3);
     end;
 end;
 if SummaryW>maxW then maxW:=summaryW;
 inc(maxW,hmargin+blankwidth);
 maxH:=lc*txtheight;
 tabsdo:=false;
end;

procedure TCurrentExtrasWin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TCurrentExtrasWin.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnCurrentExtras);
end;

procedure TCurrentExtrasWin.FormDblClick(Sender: TObject);
begin
 if winView[wnCurrentExtras] = 0 then    //Mantis:- 0001637  ,27/04/2017
 begin
   SetCoverVariables;
   coverstart := 1;
   p := coverstart;
   Puse:=torder[coverstart,ttday];

   if not(GetNext(1)) then
   begin
     messagedlg('No changes to cover',mtError,[mbOK],0);
     exit;
   end;

   ManCoverdlg:=TManCoverdlg.create(CoverDlg);  {allocate dlg}
   ManCoverdlg.showmodal;
   ManCoverdlg.free;
 end;
end;

procedure TCurrentExtrasWin.Change2Click(Sender: TObject);
begin
 // if the current selection is "by Time Slot".. open the manual cover window
{ if winView[wnCurrentExtras] = 0 then
 begin                                                  //commented Mantis:- 0001637  ,27/04/2017
   SetCoverVariables;
   coverstart := 1;
   p := coverstart;
   Puse:=torder[coverstart,ttday];

   if not(GetNext(1)) then
   begin
     messagedlg('No changes to cover',mtError,[mbOK],0);
     exit;
   end;

   ManCoverdlg:=TManCoverdlg.create(CoverDlg);  {allocate dlg}
 {  ManCoverdlg.showmodal;
   ManCoverdlg.free;
 end
 else
 begin  }
   ViewCurrentExtrasDlg:=TViewCurrentExtrasDlg.create(self);   {allocate dlg}
   ViewCurrentExtrasDlg.showmodal;
   ViewCurrentExtrasDlg.free;
// end;
end;

procedure TCurrentExtrasWin.FormPaint(Sender: TObject);
var
 etreason,count,te1,te,a:          integer;
 heading:      string;
 substr:            string;
 found:   integer;
 abtimes:                 integer;
 abload:                  double;

  procedure HighlightChange(i,myright:integer);
  var
   myrect: Trect;
  begin
    if ((Changes[i].needte<>0) or (Changes[i].needroom=1)) and (Changes[i].kind<10)
     then fcolor(cpTimeSel) else fcolor(cpCurrent);
    myrect.top:=y; myrect.bottom:=y+TxtHeight;
    myrect.left:=x+Hmargin-Hscroll;
    myrect.right:=myright+Hmargin-Hscroll;
    canvas.fillrect(myrect);
  end;

  procedure PrintTimeCode;
  var
   i: integer;
  begin
  for i:=1 to tlimit[ttday] do
   begin
    printw(tslotcode[i,ttday]);
    inc(x,letterW);
   end;
  end;


 
procedure absentSummary;
var
 i,i1,p1: integer;
 astr:    string;
begin
 fcolor(cpNormal);
 printw('Teachers absent '+inttostr(teabsent2)); 
 x:=Stab[1]; PrintTimeCode;
 x:=Stab[2]; printw('Times ');
 x:=Stab[3]; printw('Alloted  '); x:=Stab[4];
 if ESreason then printwl('Reason');
 newline;
 for i1:=1 to codenum[1] do
 begin
  if y>bottomCutoff then break;
  fcolor(cpCurrent);
  i:=codepoint[i1,1]; if teAbsent[i]=-1 then continue;
  printw(tecode[i,0]); x:=fwcode[1]+blankwidth;
  printw(tename[i,0]); x:=Stab[1];
  printmap(temap[i]);  x:=Stab[2];
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (teAbsent[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(2,i,ttday,p1);
   end;
  printw(inttostr(abtimes));  x:=Stab[3];
  str(abload:5:2,astr);
  printw(astr); x:=Stab[4];
  if ESreason then
   printw(Abcode[tabsreason[i]]+' '+Absent[tabsreason[i]]);
  newline;
 end; {for i1}
 newline;
end;


procedure telostSummary;
var
 i1,i,p1: integer;
 astr: string;
begin
 fcolor(cpNormal);
 printw('Teachers lost '+inttostr(telostnum)); x:=Stab[1];
 PrintTimeCode; x:=Stab[2];
 printw('Times'); x:=Stab[3];
 printw('Alloted');
 newline;
 for i1:=1 to codenum[1] do
 begin
  if y>bottomCutoff then break;
  fcolor(cpCurrent);
  i:=codepoint[i1,1]; if telost[i]=-1 then continue;
  printw(tecode[i,0]); x:=fwcode[1]+blankwidth;
  printw(tename[i,0]); x:=Stab[1];
  printmap(temap[i]); x:=Stab[2];
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (telost[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(2,i,ttday,p1);
   end;
  printw(inttostr(abtimes)); x:=Stab[3];
  str(abload:5:2,astr);
  printw(astr);
  newline;
 end; {for i1}
 newline;
end;



procedure addedSummary;
var
 i1,i,p1:   integer;
 astr,a:      string;
begin
 fcolor(cpNormal);
 printw('Added staff '+inttostr(ETselected)); x:=Stab[1];
 PrintTimeCode; x:=Stab[2];
 printw('Load'); x:=Stab[3];
 printw('Link');
 newline;
 for i1:=1 to ETnum1 do
 begin
  if y>bottomCutoff then break;
  fcolor(cpCurrent);
  i:=Etpointer[i1];
  if Etavail[i]=0 then continue;
  printw(etsub[i]); x:=fwcode[1]+blankwidth;
  printw(ETname[i]); x:=Stab[1];
  for p1:=1 to tlimit[ttday] do
  begin
   a:='-';
   if bool(Etavail[i] and (1 shl p1)) then a:='F';
   if (Eton[i] and (1 shl p1))=0 then a:='C';
   printw(a); inc(x,letterW);
  end;    x:=Stab[2];
  str(Etmax[i]:5:2,astr);
  printw(astr);  x:=Stab[3];
  te:=ETlink[i];
  if te<>0 then
  begin
   printwl(tecode[abs(ETlink[i]),0]);
   if te<0 then printwl(' *');
  end;
  newline;
 end;
 newline;
end;


procedure roomsSummary;
var
 i1,i,p1: integer;
 astr: string;
begin
 fcolor(cpNormal);
 printw('Rooms unavailable '+inttostr(roomsUnavail)); x:=Stab[1];
 PrintTimeCode; x:=Stab[2];
 printw('Times'); x:=Stab[3];
 printw('Alloted');
 newline;
 for i1:=1 to codenum[2] do
 begin
  if y>bottomCutoff then break;
  fcolor(cpRoom);
  i:=codepoint[i1,2]; if roAbsent[i]=-1 then continue;
  printw(tecode[i,1]); x:=fwcode[1]+blankwidth;
  printw(tename[i,1]); x:=Stab[1];
  printmap(romap[i]); x:=Stab[2];
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (roAbsent[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(2,i,ttday,p1);
   end;
  printw(inttostr(abtimes));  x:=Stab[3];
  str(abload:5:2,astr);
  printw(astr);
  newline;
 end; {for i1}
 newline;
end;


procedure rolostSummary;
var
 i1,i,p1: integer;
 astr: string;
begin
 fcolor(cpNormal);
 printw('Rooms lost '+inttostr(rolostnum)); x:=Stab[1];
 PrintTimeCode; x:=Stab[2];
 printw('Times Alloted'); x:=Stab[3];
 newline;
 for i1:=1 to codenum[2] do
 begin
  if y>bottomCutoff then break;
  fcolor(cpRoom);
  i:=codepoint[i1,2]; if rolost[i]=-1 then continue;
  printw(tecode[i,1]); x:=fwcode[1]+blankwidth;
  printw(tename[i,1]); x:=Stab[1];
  printmap(romap[i]); x:=Stab[2];
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (rolost[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(2,i,ttday,p1);
   end;
  printwl(inttostr(abtimes)); x:=Stab[3];
  str(abload:5:2,astr);
  printwl(astr);
  newline;
 end; {for i1}
 newline;
end;


procedure newSummary;
var
 i1,p1,a: integer;
begin
 fcolor(cpNormal);
 printw('New Classes '+inttostr(newclassnum)); x:=Stab[1];
 PrintTimeCode;
 x:=Stab[6];
 printw(yeartitle); x:=Stab[7];
 printw('Class');  x:=Stab[8];
 printw('Teachers');  x:=Stab[9];
 printw('Rooms');
 newline;
 for i1:=1 to newclassnum do
 begin
  if y>bottomCutoff then break;
  fcolor(cpClass);
  printwl(SubCode[nsub[i1]]); x:=Stab[1];
  for p1:=1 to tlimit[ttday] do
   if bool(ntime[i1] and (1 shl p1)) then
   begin printw('M'); inc(x,letterW); end
   else
    begin printw('-'); inc(x,letterW); end;

  x:=Stab[6];
  printw(yearname[nyear[i1]]); x:=Stab[7];
  a:=ClassShown[nlevel[i1],nyear[i1]];
  if a>0 then
   printw(ClassCode[a]);

  x:=Stab[8];
  printw(inttostr(nstaff[i1])); x:=Stab[9];
  printw(inttostr(nrooms[i1]));
  newline;
 end; {for i1}
 newline;
end;


procedure mergeSummary;
var
 i1,a: integer;
begin
 fcolor(cpNormal);
 printw('Merged Classes '+inttostr(mergedclasses)); x:=Stab[11];
 printw('Time slot'); x:=Stab[12];
 printw(yeartitle); x:=Stab[13];
 printw('Class'); x:=Stab[14];
 printw('Teacher change'); x:=Stab[15];
 printw('Room');
 newline;
 for i1:=1 to mergedclasses do
 begin
  if y>bottomCutoff then break;
  fcolor(cpClass);
  if mtime[i1]=0 then continue;
  printw(SubCode[msub[i1]]); x:=Stab[11];
  printw(TimeSlotName[ttDay,mtime[i1]-1]); x:=Stab[12];
  printw(yearname[myear[i1]]); x:=Stab[13];
  a:=ClassShown[mlevel[i1],myear[i1]];
  if a>0 then printw(ClassCode[a]);

  x:=Stab[14];
  printwl(tecode[Moldte[i1],0]+' => '+tecode[mnewte[i1],0]); x:=Stab[15];
  printw(tecode[mnewroom[i1],1]);
  newline;
 end; {for i1}
 newline;
end;

procedure extrasSummary;
begin
 if ESteach and (countAbsTes>0) then absentSummary;
 if EStlost and (telostnum>0) then telostSummary;
 if ESadd and bool(ETselected) then addedSummary;
 if ESroom and bool(roomsUnavail) then roomsSummary;
 if ESrlost and (rolostnum>0) then rolostSummary;
 if ESnew and (newClassnum>0) then newSummary;
 if ESmerge and (mergedClasses>0) then mergeSummary;
end;

procedure summary;
begin
  Self.Caption := 'Current Extras - Summary';
 fcolor(cpNormal);
 heading:='Changes for '+dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth]+
  ' '+inttostr(exyear);
 count:=0;
 printwl(heading); newline;
 extrasSummary;
end;

procedure periodHead;
begin
 fcolor(cpNormal);
 printwl('Time'); x:=Tabs[1];
 printwl('Subject'); x:=Tabs[2];
 printwl(yeartitle); x:=Tabs[3];
 // 821-2
 //printwl('Class'); x:=Tabs[4];
 printwl('Count'); x:=Tabs[4];
 printwl('Teacher'); x:=Tabs[5];
 printwl('Room'); x:=Tabs[6];
 printwl('Change'); x:=Tabs[7];
 printwl('New'); x:=Tabs[8];
 printwl('Cover'); x:=Tabs[9];
 printwl('Status'); x:=Tabs[10];
 printwl('Note');
 newline;
 x:=Tabs[7];
 printwl('Room'); x:=Tabs[8];
 printwl('Teacher');
 newline;
end;

procedure PeriodExtras;
var
 count,p,i,a:       integer;

begin
  Self.Caption := 'Current Extras - by Time Slot';
 fcolor(cpNormal);
 heading:='Changes for '+dayname[ttday]+' '+inttostr(Exday)+' '+month[exmonth]
  +' '+inttostr(exyear);
 if EPteach and not(EProom) then heading:='Teacher '+heading;
 if EProom and not(EPteach) then heading:='Room '+heading;
 printw(heading);   newline;
 if ESprint then extrasSummary;
 periodhead;  fcolor(cpCurrent);
 newline;
 for p:=1 to tlimit[ttday] do
 begin                                       
  if y>bottomCutoff then break;
  if tsOn[ttday,p-1] then
  begin
   printw(TimeSlotName[ttDay,p-1]); count:=0;
   for i:=1 to numchanges do
   begin
    if y>bottomCutoff then break;
    if (Changes[i].timeslot<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].gen=4) then continue;
    if not(EProom) and (Changes[i].oldte=Changes[i].newte) and (Changes[i].kind<>1) and
      (Changes[i].oldte>0) then continue;
    if not(EPteach) and (Changes[i].oldroom=Changes[i].newroom) then continue;
    x:=Tabs[1];
    HighlightChange(i,Tabs[11]);
    printw(SubCode[Changes[i].sub]);    x:=Tabs[2];
    printw(yearname[Changes[i].year]);   x:=Tabs[3];
    // 821-2
    //a:=ClassShown[Changes[i].level,Changes[i].year];
    //if a>0 then printw(ClassCode[a]);

    printw(inttostr(CountStudWithSub(Changes[i].sub)));

    x:=Tabs[4];
    printw(tecode[Changes[i].oldte,0]);  x:=Tabs[5];
    printw(tecode[Changes[i].oldroom,1]);  x:=Tabs[6];
    inc(count);
    printwl(GenType(Changes[i].gen));
    x:=Tabs[7];
    te1:=Changes[i].newte;
    if Changes[i].kind=1 then substr:=etsub[te1] else substr:=tecode[te1,0];
    printwl(tecode[Changes[i].newroom,1]);  x:=Tabs[8];
    printwl(substr);   x:=Tabs[9];
    x:=Tabs[9]; printwl(printkind(i));
    x:=Tabs[10]; printw(GetStatusNote(i));
    fcolor(cpCurrent);
    newline;
   end; {for i}
   if count=0 then
   begin
    x:=Tabs[1];
    printwl('(no change)'); newline;
   end;
   newline;
   drawmyline(0,y-(txtheight div 2),Tabs[11],y-(txtheight div 2));
  end;
 end; {for p}
end;

procedure absentTeacherExtras;
var
 j,i,p,te,a: integer;
 tmpstr1,tmpstr2: string;
 tallot,tcovallot: double;
 found,tlost,tcover:  integer;
 shown:  integer;
begin
 shown:=0;
 weeklyInSub; fcolor(cpNormal);
 if num=0 then
 begin
  printw2('Absent teachers selected: ','0');
  exit;
 end;
 for j:=1 to num do
 begin
  te:=free2[j];
  if teAbsent[te]=-1 then continue;
  inc(shown);   fcolor(cpNormal);
  printw2('Absent teacher: ',tename[te,0]+'     '+dayname[ttday]+'  '+
   inttostr(exday)+' '+month[exmonth]+' '+inttostr(exyear));
  if EPreason then printw2('   Reason: ',Abcode[tabsreason[te]]+' '+
   Absent[tabsreason[te]]);
  newline; newline;  fcolor(cpNormal);
  printw('Time'); x:=Tabs[1];
  printw('Subject'); x:=Tabs[2];
  printw(yeartitle); x:=Tabs[3];
  printw('Count'); x:=Tabs[4];
  printw('Room'); x:=Tabs[5];
  printw('New Teacher'); x:=Tabs[6];
  printw('Status'); x:=Tabs[7];
  printw('Note');
  newline; count:=0; tallot:=0; fcolor(codecolor);
  tcovallot:=0;
  for p:=1 to tlimit[ttday] do
  begin
   if bool(teAbsent[te] and (1 shl p)) then continue;
   printwl(TimeSlotName[ttDay,p-1]); found:=0; inc(count);
   for i:=1 to numchanges do
   begin
    if (Changes[i].gen=4) or (Changes[i].timeslot<>p)
     or (Changes[i].oldte<>te) then continue;
    found:=-1;
    x:=Tabs[1]; printw(SubCode[Changes[i].sub]);
    x:=Tabs[2]; printw(yearname[Changes[i].year]);
    x:=Tabs[3]; printw(inttostr(CountStudWithSub(Changes[i].sub)));  // 1113

//    a:=ClassShown[Changes[i].level,Changes[i].year];
//    if a>0 then printw(ClassCode[a]);

    x:=Tabs[4]; printw(tecode[Changes[i].newroom,1]);
    x:=Tabs[5];
    if Changes[i].kind=1 then printw(ETname[Changes[i].newte])
     else printw(tename[Changes[i].newte,0]);
    x:=Tabs[6];
    if (Changes[i].kind>9) then printw(IgnoreStatusMsg)
     else
      begin
       printwl(printkind(i));
       x:=Tabs[7]; printw(GetStatusNote(i));
      end;
    newline;
    tallot:=tallot+getEallot(2,te,ttday,p);
    tcovallot:=tcovallot+getEallot(2,te,ttday,p);
   end; {for i}
   tlost:=0; if (telost[te] and (1 shl p))=0 then tlost:=-1;

   if not(bool(found)) and bool(tlost) then
    begin  x:=Tabs[1]; printw('Lost Class'); newline; end;
   if not(bool(found)) and (tlost=0) then
    begin  x:=Tabs[1]; printw('Free'); newline; end;
  end; {for p}
  tcover:=0;
  for p:=1 to tlimit[ttday] do
   if copy(temap[te],p,1)='A' then inc(tcover);
  str(tallot:5:2,tmpstr1); str(tcovallot:5:2,tmpstr2);
  fcolor(cpNormal);
  printw('Absent times this day: '+inttostr(count)+' Alloted: '+tmpstr1+
   '     Cover: '+inttostr(tcover)+' Alloted: '+tmpstr2);
  newline; newline; newline;
 end; {for j}
 if shown=0 then printw2('Absent teachers selected: ','0');
end;

procedure resources;
var
 s,astr: string;
 p,i,j,a:      integer;
 sw:           integer;
begin
  Self.Caption := 'Current Extras - Resources';
 fcolor(cpNormal);
 sw:=trunc(screen.width*0.8);
 heading:='Resources for '+dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth]+' '+
  inttostr(exyear);
 count:=0;
 printwl(heading); newline;
 if Esprint then extrasSummary;
 fcolor(cpNormal);
 drawmyline(0,y+(txtheight div 2),Tabs[9],y+(txtheight div 2));
 newline;
 for p:=1 to tlimit[ttday] do
 begin
  if y>bottomCutoff then break;
  fcolor(cpNormal);
  printw(TimeSlotName[ttDay,p-1]);
  x:=Tabs[1]; printw2('Teachers required: ',inttostr(trequire[p]));
  str(treq[p]:5:2,s);
  printw2('   Allot: ',s);
  printw2('   Got: ',inttostr(tgot[p]));
  printw2('   Need: ',inttostr(tneed[p]));
  printw2('   Available: ',inttostr(tavail[p]));
  newline;
  if tgot[p]>0 then
  begin
   fcolor(cpNormal);
   x:=Tabs[2]; printw('Used: '); x:=Tabs[3]; fcolor(codecolor);
   for i:=1 to numchanges do
   begin
    a:=Changes[i].timeslot;
    if (a<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) then continue;
    if ((Changes[i].kind>0) and (Changes[i].needte=0) and (Changes[i].newte>0)) then
    begin
     if Changes[i].kind=1 then printwl(etsub[Changes[i].newte]+' ')
      else printwl(tecode[Changes[i].newte,0]+' ');
     printwl(gkind[Changes[i].kind]+' ');
    end;
    if x>sw then begin newline; x:=Tabs[3]; end;
   end; {for i}
   newline;
  end; {if tgot[p]>0 then}

  if (tavail[p]>0) then
  begin
   fcolor(cpNormal);
   x:=Tabs[2]; printw('Avail: '); x:=Tabs[4]; fcolor(codecolor);
   if eavail[p]>0 then
   begin
    fcolor(cpNormal); x:=Tabs[4]; printwl('Added staff '); fcolor(codecolor);
    for j:=1 to etnum1 do
    begin
     i:=Etpointer[j];
     if (Etmax[i]>=(Ettaught[i]+getEallot(7,i,ttday,p))) and
      bool(etavail[i] and Eton[i] and (1 shl p)) then
      printwl(etsub[i]+' ');
     if x>sw then begin newline; x:=Tabs[4]; end;
    end; {for j}
    newline;
   end;
   if treplace[p]>0 then
   begin
    fcolor(cpNormal); x:=Tabs[4]; printwl('Replace '); fcolor(codecolor);
    for j:=1 to codenum[1] do
    begin
     i:=codepoint[j,1];
     astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
     if (teavail[i]>=getEallot(8,i,ttday,p)) and bool(teon[i] and (1 shl p) and teAbsent[i])
      and bool(tena[i]) then
      printwl(tecode[i,0]+' ');
     if x>sw then begin newline; x:=Tabs[4]; end;
    end; {for j}
    newline;
   end;
   if tlieu[p]>0 then
   begin
    fcolor(cpNormal); x:=Tabs[4]; printwl('In Lieu '); fcolor(codecolor);
    for j:=1 to codenum[1] do
    begin
     i:=codepoint[j,1];
     astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
     if (telieudbl[i]>=getEallot(8,i,ttday,p)) and (teavail[i]<getEallot(8,i,ttday,p)) and
      bool(teon[i] and (1 shl p) and teAbsent[i]) and bool(tena[i]) then
      printwl(tecode[i,0]+' ');
     if x>sw then begin newline; x:=Tabs[4]; end;
    end; {for j}
    newline;
   end;
   if textra[p]>0 then
   begin
    fcolor(cpNormal); x:=Tabs[4]; printwl('Extra '); fcolor(codecolor);
    for j:=1 to codenum[1] do
    begin
     i:=codepoint[j,1];
     astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
     if ((getEallot(8,i,ttday,p)+Etaken[i])<=Emax[i])
      and (telieudbl[i]<getEallot(8,i,ttday,p)) and
      (teavail[i]<getEallot(8,i,ttday,p)) and bool(teon[i] and (1 shl p) and teAbsent[i])
       and bool(tena[i]) then
       printwl(tecode[i,0]+' ');
     if x>sw then begin newline; x:=Tabs[4]; end;
    end; {for j}
    newline;
   end;
  end; {if (tavail[p]>0) then}
  x:=Tabs[1];
  printw2('Rooms required: ',inttostr(rrequire[p]));
  printw2('   Got: ',inttostr(rgot[p]));
  printw2('   Need: ',inttostr(rneed[p]));
  printw2('   Available: ',inttostr(ravail[p]));
  newline;
  if rgot[p]>0 then
  begin
   fcolor(cpNormal); x:=Tabs[2]; printwl('Used:'); fcolor(codecolor); x:=Tabs[3];
   for i:=1 to numchanges do
   begin
    a:=Changes[i].timeslot;
    if (a<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].newroom=0) or (Changes[i].needroom<>2) then continue;
    printwl(tecode[Changes[i].newroom,1]+' ');
    if x>sw then begin newline; x:=Tabs[2]; end;
   end; {for i}
   newline;
  end;
  if ravail[p]>0 then
  begin
   fcolor(cpNormal); x:=Tabs[2]; printwl('Avail:'); fcolor(codecolor);
   if rlost[p]>0 then
   begin
    fcolor(cpNormal); x:=Tabs[4]; printwl('Replace '); fcolor(codecolor);
    for j:=1 to codenum[2] do
    begin
     i:=codepoint[j,2];
     astr:=copy(tecode[i,1],1,2); if astr='00' then continue;
     if bool(roomon[i] and (1 shl p) and roAbsent[i]) and
      ((rolost[i] and (1 shl p))=0) then
      printwl(tecode[i,1]+' ');
     if x>sw then begin newline; x:=Tabs[4]; end;
    end; {for j}
    newline;
   end;
   rextra[p]:=ravail[p]-rlost[p];
   if rextra[p]>0 then
   begin
    fcolor(cpNormal); x:=Tabs[4]; printwl('Free '); fcolor(codecolor);
    for j:=1 to codenum[2] do
    begin
     i:=codepoint[j,2];
     astr:=copy(tecode[i,1],1,2); if astr='00' then continue;
     if bool(roomon[i] and (1 shl p) and roAbsent[i] and rolost[i]) then
      printwl(tecode[i,1]+' ');
     if x>sw then begin newline; x:=Tabs[4]; end;
    end; {for j}
    newline;
   end;
  end;
  fcolor(cpNormal);
  drawmyline(0,y+(txtheight div 2),Tabs[9],y+(txtheight div 2));
  newline;
 end; {for p}

 printw('Totals:'); newline;
 printw2('Teachers required: ',inttostr(treqtotal));
 str(treqtot:5:2,s);
 printw2('   Allot: ',s);
 printw2('   Got: ',inttostr(tgottotal));
 printw2('   Need: ',inttostr(tneedtotal));
 if tneedtotal>0 then printw2('   Available: ',inttostr(tavailtotal));
 newline;
 printw2('Rooms required: ',inttostr(rreqtotal));
 printw2('   Got: ',inttostr(rgottotal));
 printw2('   Need: ',inttostr(rneedtotal));
 if rneedtotal>0 then printw2('   Available: ',inttostr(ravailtotal));
 newline;

end;

procedure YearExtras;
var
 i,yy,p,start,finish,a:       integer;
begin
  Self.Caption := 'Current Extras - by Year';
 if winCurrentExtrasyear<0 then
 begin start:=years_minus_1; finish:=0; end
 else
  begin start:=winCurrentExtrasyear; finish:=winCurrentExtrasyear; end;
 heading:='Changes for '+dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth]+
  ' '+inttostr(exyear);
 IF EPteach AND not(EProom) THEN heading:='Teacher '+heading;
 IF EProom AND not(EPteach) THEN heading:='Room '+heading;
 if ESprint then extrasSummary;  fcolor(cpNormal);
 printw(heading); newline;
 printw(Yeartitle); x:=Tabs[1];
 printw('Class'); x:=Tabs[2];
 printw('Time'); x:=Tabs[3];
 printw('Subject'); x:=Tabs[4];
 printw('Room'); x:=Tabs[5];
 printw('Change'); x:=Tabs[6];
 printw('New Room'); x:=Tabs[7];
 printw('Cover Teacher'); newline;
 fcolor(cpCurrent);
 for yy:=start downto finish do
 begin
  if y>bottomCutoff then break;
  printwl(yearname[yy]); count:=0;
  for p:=1 to tlimit[ttday] do
  begin
   if y>bottomCutoff then break;
   if not(tsOn[ttday,p-1]) then continue;
   for i:=1 to numchanges do
   begin
    if y>bottomCutoff then break;
    if ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].gen=4) or (Changes[i].timeslot<>p) or (Changes[i].year<>yy) then
     continue;
    if not(eproom) and (Changes[i].oldte=Changes[i].newte) and (Changes[i].kind<>1) and (Changes[i].oldte>0) then
     continue;
    if not(epteach) and (Changes[i].oldroom=Changes[i].newroom) then continue;
    x:=Tabs[1];
    HighlightChange(i,Tabs[8]);

    a:=ClassShown[Changes[i].level,yy];
    if a>0 then printw(ClassCode[a]);

    x:=Tabs[2]; printwl(TimeSlotName[ttDay,p-1]);
    x:=Tabs[3]; printwl(SubCode[Changes[i].sub]);
    x:=Tabs[4]; printwl(tecode[Changes[i].oldroom,1]); x:=Tabs[5];
    inc(count);
    printwl(GenType3(i));
    x:=Tabs[6];
    printwl(tecode[Changes[i].newroom,1]);  x:=Tabs[7];
    if Changes[i].kind=1 then printwl(ETname[Changes[i].newte])
     else printwl(tename[Changes[i].newte,0]);
    fcolor(cpCurrent); 
    newline;
   end; {for i}
  end; {for p}
  if count=0 then
  begin
   x:=Tabs[2];
   printwl('(no changes)');
   newline;
  end;
  newline;

  drawmyline(0,y-(txtheight div 2),Tabs[8],y-(txtheight div 2));
 end; {for yy}
end;

procedure CoveringTeacherExtras;
var
 j,i,p:  integer;
 shown: integer;
begin
 fcolor(cpNormal);
 ETreason:=0;   shown:=0;
 if ETprint then ETweeklyInsub else weeklyInsub;
 if num=0 then
 begin
  if ETprint then printw2('Added Staff selected: ','0')
   else printw2('Cover teachers selected: ','0');
  exit;
 end;
 heading:='Extras for teachers on '+dayname[ttday]+' '+inttostr(exday)+' '+
   month[exmonth]+' '+inttostr(exyear);
 count:=0;
 fcolor(cpNormal);
 printw(heading); newline;
 if esprint then extrasSummary;
 printw('Teacher'); x:=Tabs[1];
 printw('Time');    x:=Tabs[2];
 printw('Subject'); x:=Tabs[3];
 printw(yeartitle); x:=Tabs[4];
 printw('Count');   x:=Tabs[5]; // 1113
 printw('Room');    x:=Tabs[6];
 printw('Change');  x:=Tabs[7];
 printw('Status');  x:=Tabs[8];
 printw('Note');
 newline;
 drawmyline(0,y+(txtheight div 2),Tabs[9],y+(txtheight div 2));
 newline;
 for j:=1 to num do
 begin
  if y>bottomCutoff then break;
  te:=free2[j]; found:=0;
  for i:=1 to numchanges do
  begin
   if ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].newte<>te) then continue;
   if not(etprint xor (Changes[i].kind=1)) then found:=-1;
  end; {for i}
  if not(bool(found)) then continue;
  fcolor(codecolor);  inc(shown);
  if etprint then printw(ETname[te]) else printw(tename[te,0]);
  newline;
  printw(dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth]);
  for p:=1 to tlimit[ttday] do
  begin
   if y>bottomCutoff then break;
   for i:=1 to numchanges do
   begin
    if y>bottomCutoff then break;
    if (Changes[i].timeslot<>p) or (Changes[i].newte<>te) then continue;
    if (etprint xor (Changes[i].kind=1)) then continue;
    x:=Tabs[1]; printw(TimeSlotName[ttDay,p-1]);
    x:=Tabs[2]; printw(SubCode[Changes[i].sub]);
    x:=Tabs[3]; printw(yearname[Changes[i].year]);
    x:=Tabs[4]; printw(inttostr(CountStudWithSub(Changes[i].sub)));  // 1113

//  if ClassShown[Changes[i].level,Changes[i].year]>0 then
//     printw(ClassCode[ClassShown[Changes[i].level,Changes[i].year]]);

    x:=Tabs[5]; printw(tecode[Changes[i].newroom,1]);
    a:=Changes[i].gen; x:=Tabs[6];
    printw(GenType3(i));
    x:=Tabs[7];
    if etprint then
    begin
     if (etreason<>Changes[i].oldte) and (a=1) and epreason and (Changes[i].reason>0) then
     begin
      printw('('+Abcode[Changes[i].reason]+' '+Absent[Changes[i].reason]+')');
      etreason:=Changes[i].oldte;
     end;
     x:=Tabs[8];
     printw(GetStatusNote(i));
     newline;
    end
    else
     begin
       x:=Tabs[7]; printwl(printkind(i));
       x:=Tabs[8]; printwl(GetStatusNote(i));
      if (a=1) and epreason and (Changes[i].reason>0) then
      begin
       printw(' '+Abcode[Changes[i].reason]+' '+Absent[Changes[i].reason]);
      end;
      newline;
     end;

   end; {for i}
  end; {for p}
     fcolor(cpNormal);
     drawmyline(0,y+(txtheight div 2),Tabs[9],y+(txtheight div 2));
     newline;
 end; {for j}

 if shown=0 then
    if ETprint then printw2('Added Staff selected: ','0')
     else printw2('Cover teachers selected: ','0');

end;

begin
 if ListType<>1 then
 case winView[wnCurrentExtras] of
  0: PeriodExtras;
  1: YearExtras;
  2: absentTeacherExtras;
  3,4: coveringteacherExtras;
  5: summary;
  6: resources;
 end; {case}
end;

{                                                                           }
{ -----------------------  print procs follow ----------------------------- }
{                                                                           }

procedure TPrintCurrentExtras.GetLists;
var
 i: integer;
begin
 NumOfLists:=CurrentExtrasWin.NumOfLists;
 SetArraySizes;
 if NumOfLists>0 then
  for i:=1 to NumOfLists do
   begin
    ListSize[i]:=CurrentExtrasWin.ListSize[i];
    ListSet[i]:=CurrentExtrasWin.ListSet[i];
   end;
end;

procedure TPrintCurrentExtras.GetListContents(i: integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TPrintCurrentExtras.SetTabs;
var
 i,j,k:     integer;
 fwTeach,fwTeachName,fwNote: integer;
begin
 fwTeach:=fwPrntcode[1]; if fwTeach<fwPrntAddedStaffcode then fwTeach:=fwPrntAddedStaffcode;
 fwTeachName:=fwPrntCodeName[1];
 if fwTeachName<fwPrntAddedStaffname then fwTeachName:=fwPrntAddedStaffname;
 ListType:=2; codeColor:=cpCurrent;
 etprint:=(winView[wnCurrentExtras]=4);
 if eplist and ((winView[wnCurrentExtras]=3) or (winView[wnCurrentExtras]=4)) then
  begin
   codeColor:=cpStList; EnrolFlag:=False; ShowZeroList:=true;
   ListType:=1;
   if winView[wnCurrentExtras]=3 then weeklyInsub else ETweeklyInsub;
   GetLists;
   exit;
  end;

 j:=PrintCanvas.textwidth('Note');
 if fwPrntCoverNote>j then j:=fwPrntCoverNote;
 if notenum>0 then
   for i:=1 to notenum do
    begin
     k:=PrintCanvas.textwidth(ExNote[i]);
     if k>j then j:=k;
    end;
 fwNote:=j;

// Summary tabs
  i:=PrintCanvas.textwidth('W');
  j:=PrintCanvas.textwidth('M');
  if j>i then i:=j;
  j:=PrintCanvas.textwidth('Rooms Unavailable 9999   ');
  k:=fwPrntcode[2]+fwPrntcodename[2]+PrntBlankwidth*2;
  if k>j then j:=k;
  k:=fwPrntcode[0]+fwPrntcodename[0]+PrntBlankwidth*2;
  if k>j then j:=k;
  PrntStab[1]:=fwPrntcode[1]+fwPrntcodename[1]+PrntBlankwidth*2;
  if PrntStab[1]<j then PrntStab[1]:=j;
  PrntStab[2]:=PrntStab[1]+i*tlimit[ttday]+PrntBlankwidth;
  PrntStab[3]:=PrntStab[2]+PrintCanvas.textwidth('Times ');
  PrntStab[4]:=PrntStab[3]+PrintCanvas.textwidth('Alloted ');
  PrntStab[5]:=PrntStab[4]+fwPrntabsence;
  PrntStab[6]:=PrntStab[1]+i*tlimit[ttday]+PrntBlankwidth;

  j:=PrintCanvas.textwidth(YearTitle);
  if j<fwPrntyearname then j:=fwPrntyearname;
  PrntStab[7]:=PrntStab[6]+j+PrntBlankwidth;
  j:=PrintCanvas.textwidth('Class');
  if j<fwclass then j:=fwclass;
  PrntStab[8]:=PrntStab[7]+j+PrntBlankwidth;
  PrntStab[9]:=PrntStab[8]+PrintCanvas.textwidth('Teachers ')+PrntBlankwidth;
  PrntStab[10]:=PrntStab[9]+PrintCanvas.textwidth('Rooms ')+PrntBlankwidth;

  PrntStab[11]:=PrintCanvas.textwidth('Merged classes  999  ');
  j:=PrintCanvas.textwidth('Time slot');
  if j<fwPrntperiodname then j:=fwPrntperiodname;
  PrntStab[12]:=PrntStab[11]+j+PrntBlankwidth;
  j:=PrintCanvas.textwidth(YearTitle);
  if j<fwPrntyearname then j:=fwPrntyearname;
  PrntStab[13]:=PrntStab[12]+j+PrntBlankwidth;
  j:=PrintCanvas.textwidth('Class');
  if j<fwPrntclass then j:=fwPrntclass;
  PrntStab[14]:=PrntStab[13]+j+PrntBlankwidth;
  j:=PrintCanvas.textwidth('Teacher change');
  k:=PrintCanvas.textwidth('  =>  ');
  if j<(fwPrntcode[1]*2+k) then j:=(fwPrntcode[1]*2+k);
  PrntStab[15]:=PrntStab[14]+j+PrntBlankwidth;
  j:=PrintCanvas.textwidth('Room');
  if j<fwPrntcode[2] then j:=fwPrntcode[2];
  PrntStab[16]:=PrntStab[15]+j+PrntBlankwidth;

 SetLength(PrntTabs,12);
 case winView[wnCurrentExtras] of
  0: begin {period Extras}
      MaxTab(1,fwPrntperiodname,'Time');
      MaxTab(2,fwPrntcode[0],'Subject');
      MaxTab(3,fwPrntyearname,Yeartitle);
      MaxTab(4,fwPrntclass,'Class');
      MaxTab(5,fwPrntcode[1],'Teacher');
      MaxTab(6,fwPrntcode[2],'Room');
      MaxTab(7,0,'Conseq.');
      MaxTab(8,fwPrntcode[2],'Room ');
      MaxTab(9,fwTeach,'Teacher ');
      MaxTab(10,0,'Replace');
      PrntTabs[11]:=PrntTabs[10]+fwNote+PrntBlankwidth;
     end;
  1: begin {year Extras}
      MaxTab(1,fwPrntyearname,Yeartitle);
      MaxTab(2,fwPrntclass,'Class');
      MaxTab(3,fwPrntperiodname,'Time');
      MaxTab(4,fwPrntcode[0],'Subject');
      MaxTab(5,fwPrntcode[2],'Room');
      MaxTab(6,8*i,'Change');
      MaxTab(7,fwPrntcode[2],'New Room');
      MaxTab(8,fwTeach,'Cover Teacher');
     end;
  2: begin {absent Teachers}
      MaxTab(1,fwPrntperiodname,'Time');
      MaxTab(2,fwPrntcode[0],'Subject');
      MaxTab(3,fwPrntyearname,Yeartitle);
      MaxTab(4,fwPrntclass,'Class');
      MaxTab(5,fwPrntcode[2],'Room');
      MaxTab(6,fwTeachName,'New Teacher');
      MaxTab(7,0,'Status W');
      PrntTabs[8]:=PrntTabs[7]+fwNote+PrntBlankwidth;
      weeklyInSub;
     end;
  3,4: begin {covering teachers}
        MaxTab(1,fwPrntcodename[1],'Teacher');
        j:=PrintCanvas.textwidth(dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth]);
        if PrntTabs[1]<j then PrntTabs[1]:=j;
        MaxTab(2,fwPrntperiodname,'Time');
        MaxTab(3,fwPrntcode[0],'Subject');
        MaxTab(4,fwPrntyearname,Yeartitle);
        MaxTab(5,fwPrntclass,'Count'); // 1113
        MaxTab(6,fwPrntcode[2],'Room');
        j:=fwPrntcode[1]+PrintCanvas.textwidth(' absent');
        MaxTab(7,j,'Teacher swap');
        j:=PrintCanvas.textwidth('Status W'); if j<fwPrntAbsence then j:=fwPrntAbsence;
        MaxTab(8,j,'In Lieu');
        j:=fwNote+PrntBlankwidth; if epreason then j:=j+fwPrntAbsence+PrntBlankwidth;
        PrntTabs[9]:=PrntTabs[8]+j;
        if winView[wnCurrentExtras]=3 then weeklyInsub else ETweeklyInsub;
       end;
  6: begin {resources}
      PrntTabs[1]:=fwPrntperiodname+Prntblankwidth;
      MaxTab(2,0,'W');
      MaxTab(3,0,'Used: ');
      MaxTab(4,0,'Avail: ');
      PrntTabs[9]:=trunc(screen.width*0.9);
      resourceCount;
     end;
 end;
 tabsdo:=false;
end;

procedure TPrintCurrentExtras.head;
var
 heading,astr,bstr: string;
begin
 UnderlineOn;
 printwl('Current Extras');
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(cpNormal);
 astr:=dayname[ttday]+' '+inttostr(Exday)+' '+month[exmonth]
  +' '+inttostr(exyear);
 bstr:='Changes for ';
 if EPteach and not(EProom) then bstr:='Teacher '+bstr;
 if EProom and not(EPteach) then bstr:='Room '+bstr;
  case winView[wnCurrentExtras] of
  0,1: heading:=bstr+astr;
  2: heading:='Absent Teachers '+astr;
  3,4: if ListType=2 then heading:='Extras for teachers on '+astr
    else
     begin
      if winView[wnCurrentExtras]=3 then astr:='Cover teachers' else astr:='Added staff';
      heading:=astr+ ' subject lists for students in Group: '+groupname+' sorted by '+groupsortname[groupsort];
     end;
  5: heading:='Changes for '+astr;
  6: heading:='Resources for '+astr;
 end; {case}
  printw(heading);
  x:=0; y:=y+2*PrnttxtHeight;
  if doneHeading then
   case winView[wnCurrentExtras] of
    0: Periodhead;
    1: YearHead;
    3,4: CoverHead;
   end;
  x:=0; y:=y+PrnttxtHeight;


end;

procedure TPrintCurrentExtras.ListHead(i:integer);
var
  te,su,j,k,p: integer;
  astr,bstr: string;
begin
  k:=ListSet[i];
  su:=Changes[k].sub;
  j:=Changes[k].level;
  te:=Changes[k].newte;
  p:=Changes[k].timeslot;
  fcolor(cpNormal);
  if etprint then astr:=ETname[te] else astr:=tename[te,0];
  astr:=astr+'   Date: '+dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth];
  printw(astr); newline; if double_space then newline;
  fcolor(codecolor);
  printw2('Time: ',TimeSlotName[ttDay,p-1]+'   ');
  if (EPTimes) then  begin
    DateTimeToString(astr,'hh:mm',tsStart[ttDay,p-1]);
    DateTimeToString(bstr,'hh:mm',tsEnd[ttDay,p-1]);
    printw2('',' ('+astr+'-'+bstr+')    ');
  end else begin
    printw2('','    ');
  end;
  printw2('Room: ',tecode[Changes[k].newroom,1]);
  newline; if double_space then newline;
  if ClassShown[j,Changes[k].year]>0 then
     astr:=ClassCode[ClassShown[j,Changes[k].year]]
   else astr:='';
  if (Changes[k].gen=2) then astr:=ClassCode[j];
  printw2(Yeartitle+': ',yearname[Changes[k].year]+'   ');
  if Trim(astr)<>'' then printw2('Class: ',astr+'   ');
  if su>0 then
  begin
    printw2('Subject: ',SubCode[su]+' '+subname[su]);
    GetShares(k);
    if SubShareFlag then printwl(' / '+SubCode[ShareSub]+' '+subname[ShareSub]+ '(share)');
  end;
  newline; if double_space then newline;
  printwl(GenType2(k));
  if (Changes[k].gen=1) and epreason and (Changes[k].reason>0) then
  begin
    printwl('   ('+Abcode[Changes[k].reason]+' '+Absent[Changes[k].reason]+')');
  end;
  newline; newline; if double_space then begin newline; newline; end;
  if not(etprint) then
  begin
    fcolor(cpNormal); printwl('Cover type: '); fcolor(codecolor);
    printwl(printkind(k));
    newline;  if double_space then newline;
  end;
  fcolor(cpNormal); printwl('Notes: '); fcolor(codecolor);
  printw(GetStatusNote(k));
  newline; newline; fcolor(cpNormal); if double_space then begin newline; newline; end;
  if su>0 then
  begin  //printwl('Student List for '+SubCode[su]+':');
    printwl('Student List for ' + Trim(SubCode[su]) + ' ' + Trim(SubName[Su]));
    if SubShareFlag then
      printwl(' / ' + Trim(SubCode[ShareSub]) + ' ' + Trim(SubName[ShareSub]) + '(share):')
    else
      printwl(':');
    end
    else if ((j>0) and (Changes[k].gen=2)) then
      printw('Student List for '+ClassCode[j]+':');
  newline;
  fcolor(codecolor);
end;

procedure TPrintCurrentExtras.YearHead;
begin
 fcolor(cpNormal);
 printw(Yeartitle); x:=PrntTabs[1];
 printw('Class'); x:=PrntTabs[2];
 printw('Time'); x:=PrntTabs[3];
 printw('Subject'); x:=PrntTabs[4];
 printw('Room'); x:=PrntTabs[5];
 printw('Change'); x:=PrntTabs[6];
 printw('New Room'); x:=PrntTabs[7];
 printw('Cover Teacher');
 newline;
 DoneHeading:=true;
end;

procedure TPrintCurrentExtras.CoverHead;
begin
 fcolor(cpNormal);
 printw('Teacher'); x:=PrntTabs[1];
 printw('Time');    x:=PrntTabs[2];
 printw('Subject'); x:=PrntTabs[3];
 printw(yeartitle); x:=PrntTabs[4];
 printw('Count');   x:=PrntTabs[5]; // 1113
 printw('Room');    x:=PrntTabs[6];
 printw('Change');  x:=PrntTabs[7];
 printw('Status');  x:=PrntTabs[8];
 printw('Note');
 newline;
 DoneHeading:=true;
end;

procedure TPrintCurrentExtras.periodHead;
begin
 fcolor(cpNormal);
 printwl('Time'); x:=PrntTabs[1];
 printwl('Subject'); x:=PrntTabs[2];
 printwl(yeartitle); x:=PrntTabs[3];
 //printwl('Class'); x:=PrntTabs[4];
 printwl('Count'); x:=PrntTabs[4];
 printwl('Teacher'); x:=PrntTabs[5];
 printwl('Room'); x:=PrntTabs[6];
 printwl('Change'); x:=PrntTabs[7];
 printwl('New'); x:=PrntTabs[8];
 printwl('Cover'); x:=PrntTabs[9];
 printwl('Status'); x:=PrntTabs[10];
 printwl('Note');
 newline;
 x:=PrntTabs[7];
 printwl('Room'); x:=PrntTabs[8];
 printwl('Teacher');
 newline;
 DoneHeading:=true;
end;

procedure TPrintCurrentExtras.ImplementPrint;
 var
 etreason,count,te1,te,a:          integer;
 heading:      string;
 substr:            string;
 found:   integer;
 abtimes:                 integer;
 abload:                  double;


 procedure PrintTimeCode;
  var
   i: integer;
  begin
  for i:=1 to tlimit[ttday] do
   begin
    printw(tslotcode[i,ttday]);
    inc(x,letterWprnt);
   end;
  end;


    procedure checkEPblank;
    var
     i:       integer;
    begin
     if EPblank<=0 then exit;
     if EPblank>1 then
      for i:=1 to (EPblank-1) do y:=y+prnttxtheight;
     newline; {only check for page break on last one so not have
                leading white space on next sheet}
    end;


procedure absentSummary;
var
 i,i1,p1: integer;
 astr:    string;
begin
 fcolor(cpNormal);
 printw('Teachers absent '+inttostr(teabsent2)); x:=PrntStab[1];
 PrintTimeCode; x:=PrntStab[2];
 printw('Times'); x:=PrntStab[3];
 printw('Alloted '); x:=PrntStab[4];
 if ESreason then printwl('Reason');
 newline;
 for i1:=1 to codenum[1] do
 begin
  fcolor(cpCurrent);
  i:=codepoint[i1,1]; if teAbsent[i]=-1 then continue;
  printw(tecode[i,0]); x:=fwprntcode[1]+prntblankwidth;
  printw(tename[i,0]); x:=PrntStab[1];
  printmap(temap[i]);  x:=PrntStab[2];
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (teAbsent[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(2,i,ttday,p1);
   end;
  printw(inttostr(abtimes));  x:=PrntStab[3];
  str(abload:5:2,astr);
  printw(astr); x:=PrntStab[4];
  if ESreason then
   printw(Abcode[tabsreason[i]]+' '+Absent[tabsreason[i]]);
  newline;
 end; {for i1}
 newline;
end;



procedure telostSummary;
var
 i1,i,p1: integer;
 astr: string;
begin
 fcolor(cpNormal);
 printw('Teachers lost '+inttostr(telostnum)); x:=PrntStab[1];
 PrintTimeCode; x:=PrntStab[2];
 printw('Times'); x:=PrntStab[3];
 printw('Alloted');
 newline;
 for i1:=1 to codenum[1] do
 begin
  fcolor(cpCurrent);
  i:=codepoint[i1,1]; if telost[i]=-1 then continue;
  printw(tecode[i,0]); x:=fwprntcode[1]+prntblankwidth;
  printw(tename[i,0]); x:=PrntStab[1];
  printmap(temap[i]); x:=PrntStab[2];
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (telost[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(2,i,ttday,p1);
   end;
  printw(inttostr(abtimes)); x:=PrntStab[3];
  str(abload:5:2,astr);
  printw(astr);
  newline;
 end; {for i1}
 newline;
end;



procedure addedSummary;
var
 i1,i,p1:   integer;
 astr,a:      string;
begin
 fcolor(cpNormal);
 printw('Added staff '+inttostr(ETselected)); x:=PrntStab[1];
 PrintTimeCode; x:=PrntStab[2];
 printw('Load'); x:=PrntStab[3];
 printw('Link');
 newline;
 for i1:=1 to ETnum1 do
 begin
  fcolor(cpCurrent);
  i:=Etpointer[i1];
  if Etavail[i]=0 then continue;
  printw(etsub[i]); x:=fwprntcode[1]+prntblankwidth;
  printw(ETname[i]); x:=PrntStab[1];
  for p1:=1 to tlimit[ttday] do
  begin
   a:='-';
   if bool(Etavail[i] and (1 shl p1)) then a:='F';
   if (Eton[i] and (1 shl p1))=0 then a:='C';
   printw(a); inc(x,letterWprnt);
  end;    x:=PrntStab[2];
  str(Etmax[i]:5:2,astr);
  printw(astr);  x:=PrntStab[3];
  te:=ETlink[i];
  if te<>0 then
  begin
   printwl(tecode[abs(ETlink[i]),0]);
   if te<0 then printwl(' *');
  end;
  newline;
 end;
 newline;
end;



procedure roomsSummary;
var
 i1,i,p1: integer;
 astr: string;
begin
 fcolor(cpNormal);
 printw('Rooms unavailable '+inttostr(roomsUnavail)); x:=PrntStab[1];
 PrintTimeCode; x:=PrntStab[2];
 printw('Times'); x:=PrntStab[3];
 printw('Alloted');
 newline;
 for i1:=1 to codenum[2] do
 begin
  fcolor(cpRoom);
  i:=codepoint[i1,2]; if roAbsent[i]=-1 then continue;
  printw(tecode[i,1]); x:=fwprntcode[1]+prntblankwidth;
  printw(tename[i,1]); x:=PrntStab[1];
  printmap(romap[i]); x:=PrntStab[2];
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (roAbsent[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(3,i,ttday,p1);
   end;
  printw(inttostr(abtimes));  x:=PrntStab[3];
  str(abload:5:2,astr);
  printw(astr);
  newline;
 end; {for i1}
 newline;
end;


procedure rolostSummary;
var
 i1,i,p1: integer;
 astr: string;
begin
 fcolor(cpNormal);
 printw('Rooms lost '+inttostr(rolostnum)); x:=PrntStab[1];
 PrintTimeCode; x:=PrntStab[2];
 printw('Times Alloted'); x:=PrntStab[3];
 newline;
 for i1:=1 to codenum[2] do
 begin
  fcolor(cpRoom);
  i:=codepoint[i1,2]; if rolost[i]=-1 then continue;
  printw(tecode[i,1]); x:=fwprntcode[1]+prntblankwidth;
  printw(tename[i,1]); x:=PrntStab[1];
  printmap(romap[i]); x:=PrntStab[2];
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (rolost[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(3,i,ttday,p1);
   end;
  printwl(inttostr(abtimes)); x:=PrntStab[3];
  str(abload:5:2,astr);
  printwl(astr);
  newline;
 end; {for i1}
 newline;
end;



procedure newSummary;
var
 i1,p1: integer;
begin
 fcolor(cpNormal);
 printw('New Classes '+inttostr(newclassnum)); x:=PrntStab[1];
 PrintTimeCode;

 x:=PrntStab[6];
 printw(yeartitle); x:=PrntStab[7];
 printw('Class');  x:=PrntStab[8];
 printw('Teachers');  x:=PrntStab[9];
 printw('Rooms');
 newline;
 for i1:=1 to newclassnum do
 begin
  fcolor(cpClass);
  printwl(SubCode[nsub[i1]]); x:=PrntStab[1];
  for p1:=1 to tlimit[ttday] do
   if bool(ntime[i1] and (1 shl p1)) then
    begin printw('M'); inc(x,letterWprnt); end
   else
    begin printw('-'); inc(x,letterWprnt); end;
  x:=PrntStab[6];
  printw(yearname[nyear[i1]]); x:=PrntStab[7];
  printw(ClassCode[ClassShown[nlevel[i1],nyear[i1]]]); x:=PrntStab[8];
  printw(inttostr(nstaff[i1])); x:=PrntStab[9];
  printw(inttostr(nrooms[i1]));
  newline;
 end; {for i1}
 newline;
end;



procedure mergeSummary;
var
 i1: integer;
begin
 fcolor(cpNormal);
 printw('Merged Classes '+inttostr(mergedclasses)); x:=PrntStab[11];
 printw('Time slot'); x:=PrntStab[12];
 printw(yeartitle); x:=PrntStab[13];
 printw('Class'); x:=PrntStab[14];
 printw('Teacher change'); x:=PrntStab[15];
 printw('Room');
 newline;
 for i1:=1 to mergedclasses do
 begin
  if mtime[i1]=0 then continue;
  fcolor(cpClass);
  printw(SubCode[msub[i1]]); x:=PrntStab[11];
  printw(TimeSlotName[ttDay,mtime[i1]-1]); x:=PrntStab[12];
  printw(yearname[myear[i1]]); x:=PrntStab[13];
  printw(ClassCode[ClassShown[mlevel[i1],myear[i1]]]); x:=PrntStab[14];
  printwl(tecode[Moldte[i1],0]+' => '+tecode[mnewte[i1],0]); x:=PrntStab[15];
  printw(tecode[mnewroom[i1],1]);
  newline;
 end; {for i1}
 newline;
end;


procedure extrasSummary;
begin
 if ESteach and (countAbsTes>0) then absentSummary;
 if EStlost and (telostnum>0) then telostSummary;
 if ESadd and bool(ETselected) then addedSummary;
 if ESroom and bool(roomsUnavail) then roomsSummary;
 if ESrlost and (rolostnum>0) then rolostSummary;
 if ESnew and (newClassnum>0) then newSummary;
 if ESmerge and (mergedClasses>0) then mergeSummary;

 end;




procedure periodExtras;
var
 count,p,i:       integer;
begin
 fcolor(cpNormal);
 if ESprint then extrasSummary;
 periodhead; 
 newline;
 for p:=1 to tlimit[ttday] do
 begin
  if tsOn[ttday,p-1] then
  begin
   printw(TimeSlotName[ttDay,p-1]); count:=0;
   for i:=1 to numchanges do
   begin
     fcolor(cpCurrent);
    if (Changes[i].timeslot<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].gen=4) then continue;
    if not(EProom) and (Changes[i].oldte=Changes[i].newte) and (Changes[i].kind<>1) and
      (Changes[i].oldte>0) then continue;
    if not(EPteach) and (Changes[i].oldroom=Changes[i].newroom) then continue;
    x:=PrntTabs[1];
    printw(SubCode[Changes[i].sub]);    x:=PrntTabs[2];
    printw(yearname[Changes[i].year]);   x:=PrntTabs[3];
    // printw(ClassCode[ClassShown[Changes[i].level,Changes[i].year]]);  x:=PrntTabs[4];
    printw(inttostr(CountStudWithSub(Changes[i].sub))); x:=PrntTabs[4];
    printw(tecode[Changes[i].oldte,0]);  x:=PrntTabs[5];
    printw(tecode[Changes[i].oldroom,1]);  x:=PrntTabs[6];
    inc(count);
    printwl(GenType(Changes[i].gen));
    x:=PrntTabs[7];
    te1:=Changes[i].newte;
    if Changes[i].kind=1 then substr:=etsub[te1] else substr:=tecode[te1,0];
    printwl(tecode[Changes[i].newroom,1]);  x:=PrntTabs[8];
    printwl(substr);   x:=PrntTabs[9];
    x:=PrntTabs[9]; printwl(printkind(i));
    x:=PrntTabs[10]; printw(GetStatusNote(i));
    newline;
   end; {for i}
   if count=0 then
   begin
    x:=PrntTabs[1];
    printwl('(no change)'); newline;
   end;
   newline;
  checkEPblank;
  drawmyline(0,y-(prnttxtheight div 2),PrntTabs[11],y-(prnttxtheight div 2));
  end;
 end; {for p}
 printCustomAddon;
end;


procedure absentTeacherExtras;
var
 j,i,p,te: integer;
 tmpstr1,tmpstr2: string;
 tallot,tcovallot: double;
 found,tlost,tcover:  integer;
begin
 weeklyInSub; fcolor(cpNormal);
 if num=0 then exit;
 newline;
 for j:=1 to num do
 begin
  te:=free2[j];
  if teAbsent[te]=-1 then continue;
  printw2('Absent teacher: ',tename[te,0]+'     '+dayname[ttday]+'  '+
   inttostr(exday)+' '+month[exmonth]+' '+inttostr(exyear));
  if EPreason then printw2('   Reason: ',Abcode[tabsreason[te]]+' '+
   Absent[tabsreason[te]]);
  newline; newline;  fcolor(cpNormal);
  printw('Time'); x:=PrntTabs[1];
  printw('Subject'); x:=PrntTabs[2];
  printw(yeartitle); x:=PrntTabs[3];
  printw('Count'); x:=PrntTabs[4];
  printw('Room'); x:=PrntTabs[5];
  printw('New Teacher'); x:=PrntTabs[6];
  printw('Status'); x:=PrntTabs[7];
  printw('Note');
  newline; count:=0; tallot:=0; fcolor(codecolor);
  tcovallot:=0;
  for p:=1 to tlimit[ttday] do
  begin
   if bool(teAbsent[te] and (1 shl p)) then continue;
   printwl(TimeSlotName[ttDay,p-1]); found:=0; inc(count);
   for i:=1 to numchanges do
   begin
    if (Changes[i].gen=4) or (Changes[i].timeslot<>p) or (Changes[i].oldte<>te) then continue;
    found:=-1;
    x:=PrntTabs[1]; printw(SubCode[Changes[i].sub]);
    x:=PrntTabs[2]; printw(yearname[Changes[i].year]);
    // x:=PrntTabs[3]; printw(ClassCode[ClassShown[Changes[i].level,Changes[i].year]]);
    x:=PrntTabs[3]; printw(inttostr(CountStudWithSub(Changes[i].sub)));  // 1113
    x:=PrntTabs[4]; printw(tecode[Changes[i].newroom,1]);
    x:=PrntTabs[5];
    if Changes[i].kind=1 then printw(ETname[Changes[i].newte])
     else printw(tename[Changes[i].newte,0]);
    x:=PrntTabs[6];
    if (Changes[i].kind>9) then printw(IgnoreStatusMsg)
     else
      begin
       printwl(printkind(i));
       x:=PrntTabs[7]; printw(GetStatusNote(i));
      end;
    newline;
    tallot:=tallot+getEallot(2,te,ttday,p);
    tcovallot:=tcovallot+getEallot(2,te,ttday,p);
   end; {for i}
   tlost:=0; if (telost[te] and (1 shl p))=0 then tlost:=-1;
   if not(bool(found)) and bool(tlost) then
    begin  x:=PrntTabs[1]; printw('Lost Class'); newline; end;
   if not(bool(found)) and (tlost=0) then
    begin  x:=PrntTabs[1]; printw('Free'); newline; end;
  end; {for p}                                          
  tcover:=0; 
  for p:=1 to tlimit[ttday] do
   if copy(temap[te],p,1)='A' then inc(tcover);
  str(tallot:5:2,tmpstr1); str(tcovallot:5:2,tmpstr2);
  fcolor(cpNormal);
  printw('Absent times this day: '+inttostr(count)+' Alloted: '+tmpstr1+
   '     Cover: '+inttostr(tcover)+' Alloted: '+tmpstr2); newline;
  if Formfeed then
   begin
    printCustomAddon;
    if (j<num) then  begin StartNewPage; header; end;
   end
  else begin newline; newline; checkEPblank; end;
 end; {for j}
 if not(formfeed) then  printCustomAddon;
end;



procedure resources;
var
 s,astr: string;
 p,i,j,a:      integer;
 sw:           integer;
begin
 fcolor(cpNormal);
 sw:=trunc(PrintPageWidth*0.9)-prntHmargin;
 heading:='Resources for '+dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth]+' '+
  inttostr(exyear);
 count:=0;
 printwl(heading); newline;
 if Esprint then extrasSummary;
 fcolor(cpNormal);
 drawmyline(0,y+(prnttxtheight div 2),sw,y+(prnttxtheight div 2));
 newline;
 for p:=1 to tlimit[ttday] do
 begin
  fcolor(cpNormal);
  printw(TimeSlotName[ttDay,p-1]);
  x:=PrntTabs[1]; printw2('Teachers required: ',inttostr(trequire[p]));
  str(treq[p]:5:2,s);
  printw2('   Allot: ',s);
  printw2('   Got: ',inttostr(tgot[p]));
  printw2('   Need: ',inttostr(tneed[p]));
  printw2('   Available: ',inttostr(tavail[p]));
  newline;
  if tgot[p]>0 then
  begin
   fcolor(cpNormal);
   x:=PrntTabs[2]; printw('Used: '); x:=PrntTabs[3];
   fcolor(codecolor);
   for i:=1 to numchanges do
   begin
    a:=Changes[i].timeslot;
    if (a<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) then continue;
    if ((Changes[i].kind>0) and (Changes[i].needte=0) and (Changes[i].newte>0)) then
    begin
     if Changes[i].kind=1 then printwl(etsub[Changes[i].newte]+' ')
      else printwl(tecode[Changes[i].newte,0]+' ');
     printwl(gkind[Changes[i].kind]+' ');
    end;
    if x>sw then begin newline; x:=PrntTabs[3]; end;
   end; {for i}
   newline;
  end; {if tgot[p]>0 then}
  if (tavail[p]>0) then
  begin
   fcolor(cpNormal);
   x:=PrntTabs[2]; printw('Avail: '); x:=PrntTabs[4];
   fcolor(codecolor);
   if eavail[p]>0 then
   begin
    fcolor(cpNormal);
    x:=PrntTabs[4]; printwl('Added staff ');
    fcolor(codecolor);
    for j:=1 to etnum1 do
    begin
     i:=Etpointer[j];
     if (Etmax[i]>=(Ettaught[i]+getEallot(7,i,ttday,p))) and
      bool(etavail[i] and Eton[i] and (1 shl p)) then
      printwl(etsub[i]+' ');
      if x>sw then begin newline; x:=PrntTabs[4]; end;
    end; {for j}
    newline;
   end;
   if treplace[p]>0 then
   begin
    fcolor(cpNormal);
    x:=PrntTabs[4]; printwl('Replace ');
    fcolor(codecolor);
    for j:=1 to codenum[1] do
    begin
     i:=codepoint[j,1];
     astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
     if (teavail[i]>=getEallot(2,i,ttday,p)) and bool(teon[i] and (1 shl p) and teAbsent[i])
      and bool(tena[i]) then
      printwl(tecode[i,0]+' ');
     if x>sw then begin newline; x:=PrntTabs[4]; end;
    end; {for j}
    newline;
   end;
   if tlieu[p]>0 then
   begin
    fcolor(cpNormal);
    x:=PrntTabs[4]; printwl('In Lieu ');
    fcolor(codecolor);
    for j:=1 to codenum[1] do
    begin
     i:=codepoint[j,1];
     astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
     if (telieudbl[i]>=getEallot(2,i,ttday,p))
      and (teavail[i]<getEallot(2,i,ttday,p)) and
      bool(teon[i] and (1 shl p) and teAbsent[i]) and bool(tena[i]) then
      printwl(tecode[i,0]+' ');
     if x>sw then begin newline; x:=PrntTabs[4]; end;
    end; {for j}
    newline;
   end;
   if textra[p]>0 then
   begin
    fcolor(cpNormal);
    x:=PrntTabs[4]; printwl('Extra ');
    fcolor(codecolor);
    for j:=1 to codenum[1] do
    begin
     i:=codepoint[j,1];
     astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
     if ((getEallot(8,i,ttday,p)+Etaken[i])<=Emax[i])
       and (telieudbl[i]<getEallot(8,i,ttday,p)) and
      (teavail[i]<getEallot(8,i,ttday,p)) and bool(teon[i] and (1 shl p) and teAbsent[i])
       and bool(tena[i]) then
       printwl(tecode[i,0]+' ');
     if x>sw then begin newline; x:=PrntTabs[4]; end;
    end; {for j}
    newline;
   end;
  end; {if (tavail[p]>0) then}
  x:=PrntTabs[1];
  printw2('Rooms required: ',inttostr(rrequire[p]));
  printw2('   Got: ',inttostr(rgot[p]));
  printw2('   Need: ',inttostr(rneed[p]));
  printw2('   Available: ',inttostr(ravail[p]));
  newline;
  if rgot[p]>0 then
  begin
   fcolor(cpNormal);
   x:=PrntTabs[2]; printwl('Used:');
   fcolor(codecolor); x:=PrntTabs[3];
   for i:=1 to numchanges do
   begin
    a:=Changes[i].timeslot;
    if (a<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].newroom=0) or (Changes[i].needroom<>2) then continue;
    printwl(tecode[Changes[i].newroom,1]+' ');
    if x>sw then begin newline; x:=PrntTabs[2]; end;
   end; {for i}
   newline;
  end;
  if ravail[p]>0 then
  begin
   fcolor(cpNormal); x:=PrntTabs[2]; printwl('Avail:');
   fcolor(codecolor);
   if rlost[p]>0 then
   begin
    fcolor(cpNormal);
    x:=PrntTabs[4]; printwl('Replace ');
    fcolor(codecolor);
    for j:=1 to codenum[2] do
    begin
     i:=codepoint[j,2];
     astr:=copy(tecode[i,1],1,2); if astr='00' then continue;
     if bool(roomon[i] and (1 shl p) and roAbsent[i]) and
      ((rolost[i] and (1 shl p))=0) then
      printwl(tecode[i,1]+' ');
     if x>sw then begin newline; x:=PrntTabs[4]; end;
    end; {for j}
    newline;
   end;
   rextra[p]:=ravail[p]-rlost[p];
   if rextra[p]>0 then
   begin
    fcolor(cpNormal);
    x:=PrntTabs[4]; printwl('Free ');
    fcolor(codecolor);
    for j:=1 to codenum[2] do
    begin
     i:=codepoint[j,2];
     astr:=copy(tecode[i,1],1,2); if astr='00' then continue;
     if bool(roomon[i] and (1 shl p) and roAbsent[i] and rolost[i]) then
      printwl(tecode[i,1]+' ');
     if x>sw then begin newline; x:=PrntTabs[4]; end;
    end; {for j}
    newline;
   end;
  end;
  fcolor(cpNormal);
  //checkEPblank;            //one object on a page
  NewLine;
  NewLine;
  NewLine;
  drawmyline(0,y+(prnttxtheight div 2),sw,y+(prnttxtheight div 2));
  newline;
 end; {for p}

 printw('Totals:'); newline;
 printw2('Teachers required: ',inttostr(treqtotal));
 str(treqtot:5:2,s);
 printw2('   Allot: ',s);
 printw2('   Got: ',inttostr(tgottotal));
 printw2('   Need: ',inttostr(tneedtotal));
 if tneedtotal>0 then printw2('   Available: ',inttostr(tavailtotal));
 newline;
 printw2('Rooms required: ',inttostr(rreqtotal));
 printw2('   Got: ',inttostr(rgottotal));
 printw2('   Need: ',inttostr(rneedtotal));
 if rneedtotal>0 then printw2('   Available: ',inttostr(ravailtotal));
 newline;
 printCustomAddon;
end;


procedure yearExtras;
var
 i,yy,p,start,finish:       integer;
begin
 if winCurrentExtrasyear<0 then
 begin start:=years_minus_1; finish:=0; end
 else
  begin start:=winCurrentExtrasyear; finish:=winCurrentExtrasyear; end;
 if ESprint then extrasSummary;  fcolor(cpNormal);
 printw(heading); newline;
 YearHead;

 for yy:=start downto finish do
 begin
  printwl(yearname[yy]); count:=0;
  for p:=1 to tlimit[ttday] do
  begin
   if not(tsOn[ttday,p-1]) then continue;
   for i:=1 to numchanges do
   begin
    fcolor(cpCurrent);
    if ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].gen=4) or (Changes[i].timeslot<>p) or (Changes[i].year<>yy) then
     continue;
    if not(eproom) and (Changes[i].oldte=Changes[i].newte) and (Changes[i].kind<>1) and (Changes[i].oldte>0) then
     continue;
    if not(epteach) and (Changes[i].oldroom=Changes[i].newroom) then continue;
    x:=PrntTabs[1]; printwl(ClassCode[ClassShown[Changes[i].level,yy]]);

    x:=PrntTabs[2]; printwl(TimeSlotName[ttDay,p-1]);
    x:=PrntTabs[3]; printwl(SubCode[Changes[i].sub]);
    x:=PrntTabs[4]; printwl(tecode[Changes[i].oldroom,1]); x:=PrntTabs[5];
    inc(count);
    printwl(GenType3(i));
    x:=PrntTabs[6];
    printwl(tecode[Changes[i].newroom,1]);  x:=PrntTabs[7];
    if Changes[i].kind=1 then printwl(ETname[Changes[i].newte])
     else printwl(tename[Changes[i].newte,0]);
    newline;
   end; {for i}
  end; {for p}
  if count=0 then
  begin
   x:=PrntTabs[2];
   printwl('(no changes)'); newline;
  end;
  newline;
  checkEPblank;
  drawmyline(0,y-(prnttxtheight div 2),PrntTabs[8],y-(prnttxtheight div 2));
 end; {for yy}
 printCustomAddon;
end;



procedure coveringTeacherExtras;
var
 j,i,p:  integer;

begin
 fcolor(cpNormal);
 ETreason:=0;
 if ETprint then ETweeklyInsub else weeklyInsub;
 if num=0 then exit;
 count:=0;

 if esprint then extrasSummary;
 CoverHead;

 drawmyline(0,y+(prnttxtheight div 2),PrntTabs[9],y+(prnttxtheight div 2));
 newline;
 for j:=1 to num do
 begin
  te:=free2[j]; found:=0;
  for i:=1 to numchanges do
  begin
   if ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].newte<>te) then continue;
   if not(etprint xor (Changes[i].kind=1)) then found:=-1;
  end; {for i}
  if not(bool(found)) then continue;
  fcolor(codecolor);
  if etprint then printw(ETname[te]) else printw(tename[te,0]);
  newline;
  printw(dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth]);
  for p:=1 to tlimit[ttday] do
   for i:=1 to numchanges do
   begin
    if (Changes[i].timeslot<>p) or (Changes[i].newte<>te) then continue;
    if (etprint xor (Changes[i].kind=1)) then continue;
    x:=PrntTabs[1]; printw(TimeSlotName[ttDay,p-1]);
    x:=PrntTabs[2]; printw(SubCode[Changes[i].sub]);
    x:=PrntTabs[3]; printw(yearname[Changes[i].year]);
    // x:=PrntTabs[4]; printw(ClassCode[ClassShown[Changes[i].level,Changes[i].year]]);
    x:=PrntTabs[4]; printw(inttostr(CountStudWithSub(Changes[i].sub))); // 1113
    x:=PrntTabs[5]; printw(tecode[Changes[i].newroom,1]);
    a:=Changes[i].gen; x:=PrntTabs[6];
    printw(GenType3(i));
    x:=PrntTabs[7];
    if etprint then
    begin
     if (etreason<>Changes[i].oldte) and (a=1) and epreason and (Changes[i].reason>0) then
     begin
      printw('('+Abcode[Changes[i].reason]+' '+Absent[Changes[i].reason]+')');
      etreason:=Changes[i].oldte;
     end;
     x:=PrntTabs[8];
     printw(GetStatusNote(i));
     newline;
    end
    else
     begin
       x:=PrntTabs[7]; printwl(printkind(i));
       // x:=PrntTabs[8]; printwl(GetStatusNote(i));
       x:=PrntTabs[8]; printwl((GetStatusNote(i)));  //printw3   mantis-1667 01/06/2017
      if (a=1) and epreason and (Changes[i].reason>0) then
      begin
       printw(' '+Abcode[Changes[i].reason]+' '+Absent[Changes[i].reason]);
      end;
      newline;
     end;

   end; {for i}
  checkEPblank;
  fcolor(cpNormal);
  drawmyline(0,y+(prnttxtheight div 2),PrntTabs[9],y+(prnttxtheight div 2));
  if (y+(3+EPblank)*prnttxtheight)>PrintPageHeight then
   begin
    StartNewPage; header;
   end
  else newline;
 end; {for j}
 printCustomAddon;
end;


begin
 DoneHeading:=false;
 header;  fcolor(codecolor);
 case winView[wnCurrentExtras] of
  0: periodExtras;
  1: yearExtras;
  2: absentTeacherExtras;
  3,4: coveringteacherExtras;
  5: begin extrasSummary;  printCustomAddon; end;
  6: resources;
 end; {case}

end;

procedure CurrentExtrasWinprint;
begin
 PrintCurrentExtras:=TPrintCurrentExtras.Create;
 with PrintCurrentExtras do
  try
   SetTabs;
   if ListType=1 then ShowLists else ImplementPrint;
  finally
   PrintCurrentExtras.free;
  end;
end;

// ---------------- Ouput Procedures follow -------------------------


procedure TOutCurrentExtras.GetLists;
var
 i: integer;
begin
 NumOfLists:=CurrentExtrasWin.NumOfLists;
 SetArraySizes;
 if NumOfLists>0 then
  for i:=1 to NumOfLists do
   begin
    ListSize[i]:=CurrentExtrasWin.ListSize[i];
    ListSet[i]:=CurrentExtrasWin.ListSet[i];
   end;
end;

procedure TOutCurrentExtras.GetListContents(i: integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TOutCurrentExtras.SetTabs;
begin
 ListType:=2;
 etprint:=(winView[wnCurrentExtras]=4);
 if eplist and ((winView[wnCurrentExtras]=3) or (winView[wnCurrentExtras]=4)) then
  begin
   EnrolFlag:=False; ShowZeroList:=true;
   ListType:=1;
   if winView[wnCurrentExtras]=3 then weeklyInsub else ETweeklyInsub;
   GetLists;
   exit;
  end;
 case winView[wnCurrentExtras] of
  2: weeklyInSub; {absent Teachers}
  3,4: if winView[wnCurrentExtras]=3 then weeklyInsub else ETweeklyInsub;{covering teachers}
  6: resourceCount; {resources}
 end;
end;

procedure TOutCurrentExtras.head;
var
 heading,astr,bstr: string;
begin
 printLine(['Current Extras']);
 astr:=dayname[ttday]+' '+inttostr(Exday)+' '+month[exmonth]
  +' '+inttostr(exyear);
 bstr:='Changes for ';
 if EPteach and not(EProom) then bstr:='Teacher '+bstr;
 if EProom and not(EPteach) then bstr:='Room '+bstr;
  case winView[wnCurrentExtras] of
  0,1: heading:=bstr+astr;
  2: heading:='Absent Teachers '+astr;
  3,4: if ListType=2 then heading:='Extras for teachers on '+astr
    else
     begin
      if winView[wnCurrentExtras]=3 then astr:='Cover teachers' else astr:='Added staff';
      heading:=astr+ ' subject lists for students in Group: '+groupname+' sorted by '+groupsortname[groupsort];
     end;
  5: heading:='Changes for '+astr;
  6: heading:='Resources for '+astr;
 end; {case}
  printLine([heading]);
end;

procedure TOutCurrentExtras.ListHead(i:integer);
var
 te,su,j,k,p: integer;
 astr: string;
begin
 k:=ListSet[i];
 su:=Changes[k].sub;
 j:=Changes[k].level;
 te:=Changes[k].newte;
 p:=Changes[k].timeslot;
 if etprint then astr:=ETname[te] else astr:=tename[te,0];
 astr:=astr+'   Date: '+dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth];
 printw(astr); newline; if double_space then newline;
 printLine(['Time: ',TimeSlotName[ttDay,p-1],'Room: ',tecode[Changes[k].newroom,1]]);
 if double_space then newline;
 if ClassShown[j,Changes[k].year]>0 then
     astr:=ClassCode[ClassShown[j,Changes[k].year]]
   else astr:='';
 if (Changes[k].gen=2) then astr:=ClassCode[j];
 printw(Yeartitle+': '); printc(yearname[Changes[k].year]);
 if Trim(astr)<>'' then begin printc('Class:'); printc(astr); end;
 if su>0 then begin printc('Subject:'); printc(SubCode[su]);printc(subname[su]); end;
 newline; if double_space then newline;
 printc(GenType2(k));
 if (Changes[k].gen=1) and epreason and (Changes[k].reason>0) then
  begin
   printc('   ('+Abcode[Changes[k].reason]+' '+Absent[Changes[k].reason]+')');
  end;
 newline; newline; if double_space then begin newline; newline; end;
 if not(etprint) then
  begin
   printw('Cover type: ');
   printc(printkind(k));
   newline;  if double_space then newline;
  end;
 printw('Notes: ');
 printc(GetStatusNote(k));
 newline; newline; if double_space then begin newline; newline; end;

 if su > 0 then
 begin  //printwl('Student List for '+SubCode[su]+':');
   printw('Student List for ' + Trim(SubCode[su]) + ' ' + Trim(SubName[Su]));
   if SubShareFlag then
     printw(' / ' + Trim(SubCode[ShareSub]) + ' ' + Trim(SubName[ShareSub]) + '(share):')
   else
     printw(':');
   end
   else if ((j>0) and (Changes[k].gen=2)) then
     printw('Student List for '+ClassCode[j]+':');
 newline;
end;

procedure TOutCurrentExtras.ImplementPrint;
 var
 etreason,count,te1,te,a:          integer;
 heading:      string;
 substr:            string;
 found:   integer;
 abtimes:                 integer;
 abload:                  double;


 procedure PrintTimeCode;
  var
   i: integer;
   a: string;
  begin
   a:='';
   for i:=1 to tlimit[ttday] do a:=a+tslotcode[i,ttday];
   printc(a);
  end;


    procedure checkEPblank;
    var
     i:       integer;
    begin
     if EPblank<=0 then exit;
     for i:=1 to EPblank do newline;
    end;


procedure absentSummary;
var
 i,i1,p1: integer;
 astr:    string;
begin
 printw('Teachers absent '+inttostr(teabsent2));
 printc('');
 PrintTimeCode;
 printc('Times');
 printc('Alloted ');
 if ESreason then printc('Reason');
 newline;
 for i1:=1 to codenum[1] do
 begin
  i:=codepoint[i1,1]; if teAbsent[i]=-1 then continue;
  printw(tecode[i,0]);
  printc(tename[i,0]);
  printc(temap[i]);
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (teAbsent[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(2,i,ttday,p1);
   end;
  printc(inttostr(abtimes));
  str(abload:5:2,astr);
  printc(astr);
  if ESreason then
   printc(Abcode[tabsreason[i]]);printc(Absent[tabsreason[i]]);
  newline;
 end; {for i1}
 newline;
end;



procedure telostSummary;
var
 i1,i,p1: integer;
 astr: string;
begin
 printw('Teachers lost '+inttostr(telostnum));
 printc('');
 PrintTimeCode;
 printc('Times');
 printc('Alloted');
 newline;
 for i1:=1 to codenum[1] do
 begin
  i:=codepoint[i1,1]; if telost[i]=-1 then continue;
  printw(tecode[i,0]);
  printc(tename[i,0]);
  printc(temap[i]);
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (telost[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(2,i,ttday,p1);
   end;
  printc(inttostr(abtimes));
  str(abload:5:2,astr);
  printc(astr);
  newline;
 end; {for i1}
 newline;
end;



procedure addedSummary;
var
 i1,i,p1:   integer;
 astr,a,s:      string;
begin
 printw('Added staff '+inttostr(ETselected));
 printc('');
 PrintTimeCode;
 printc('Load');
 printc('Link');
 newline;
 for i1:=1 to ETnum1 do
 begin
  i:=Etpointer[i1];
  if Etavail[i]=0 then continue;
  printw(etsub[i]);
  printc(ETname[i]);
  s:='';
  for p1:=1 to tlimit[ttday] do
  begin
   a:='-';
   if bool(Etavail[i] and (1 shl p1)) then a:='F';
   if (Eton[i] and (1 shl p1))=0 then a:='C';
   s:=s+a;
  end;    printc(s);
  str(Etmax[i]:5:2,astr);
  printc(astr);
  te:=ETlink[i];
  s:='';
  if te<>0 then
  begin
   s:=tecode[abs(ETlink[i]),0];
   if te<0 then s:=s+' *';
  end;
  printc(s);
  newline;
 end;
 newline;
end;



procedure roomsSummary;
var
 i1,i,p1: integer;
 astr: string;
begin
 printw('Rooms unavailable '+inttostr(roomsUnavail));
 printc('');
 PrintTimeCode;
 printc('Times');
 printc('Alloted');
 newline;
 for i1:=1 to codenum[2] do
 begin
  i:=codepoint[i1,2]; if roAbsent[i]=-1 then continue;
  printw(tecode[i,1]);
  printc(tename[i,1]);
  printc(romap[i]);
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (roAbsent[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(3,i,ttday,p1);
   end;
  printc(inttostr(abtimes));
  str(abload:5:2,astr);
  printw(astr);
  newline;
 end; {for i1}
 newline;
end;


procedure rolostSummary;
var
 i1,i,p1: integer;
 astr: string;
begin
 printw('Rooms lost '+inttostr(rolostnum));
 printc('');
 PrintTimeCode;
 printc('Times Alloted');
 newline;
 for i1:=1 to codenum[2] do
 begin
  i:=codepoint[i1,2]; if rolost[i]=-1 then continue;
  printw(tecode[i,1]);
  printc(tename[i,1]);
  printc(romap[i]);
  abtimes:=0; abload:=0;
  for p1:=1 to tlimit[ttday] do
   if (rolost[i] and (1 shl p1))=0 then
   begin
    inc(abtimes);
    abload:=abload+getEallot(3,i,ttday,p1);
   end;
  printc(inttostr(abtimes));
  str(abload:5:2,astr);
  printc(astr);
  newline;
 end; {for i1}
 newline;
end;



procedure newSummary;
var
 i1,p1: integer;
 s: string;
begin
 printw('New Classes '+inttostr(newclassnum));
 PrintTimeCode;
 printc(yeartitle);
 printc('Class');
 printc('Teachers');
 printc('Rooms');
 newline;
 s:='';
 for i1:=1 to newclassnum do
 begin
  printw(SubCode[nsub[i1]]);
  for p1:=1 to tlimit[ttday] do
   if bool(ntime[i1] and (1 shl p1))
     then s:=s+'M' else s:=s+'-';
  printc(s);
  printc(yearname[nyear[i1]]);
  printc(ClassCode[ClassShown[nlevel[i1],nyear[i1]]]);
  printc(inttostr(nstaff[i1]));
  printc(inttostr(nrooms[i1]));
  newline;
 end; {for i1}
 newline;
end;



procedure mergeSummary;
var
 i1: integer;
begin
 printw('Merged Classes '+inttostr(mergedclasses));
 printc('Time slot');
 printc(yeartitle);
 printc('Class');
 printc('Teacher change');
 printc('Room');
 newline;
 for i1:=1 to mergedclasses do
 begin
  if mtime[i1]=0 then continue;
  printw(SubCode[msub[i1]]);
  printc(TimeSlotName[ttDay,mtime[i1]-1]);
  printc(yearname[myear[i1]]);
  printc(ClassCode[ClassShown[mlevel[i1],myear[i1]]]);
  printc(tecode[Moldte[i1],0]+' => '+tecode[mnewte[i1],0]);
  printc(tecode[mnewroom[i1],1]);
  newline;
 end; {for i1}
 newline;
end;


procedure extrasSummary;
begin
 if ESteach and (countAbsTes>0) then absentSummary;
 if EStlost and (telostnum>0) then telostSummary;
 if ESadd and bool(ETselected) then addedSummary;
 if ESroom and bool(roomsUnavail) then roomsSummary;
 if ESrlost and (rolostnum>0) then rolostSummary;
 if ESnew and (newClassnum>0) then newSummary;
 if ESmerge and (mergedClasses>0) then mergeSummary;
end;



procedure periodHead;
begin
 printLine(['Time','Subject',yeartitle,'Class','Teacher','Room','Change',
  'New','Cover','Status','Note']);
 printLine(['','','','','','','','Room','Teacher','','']);
 newline;
end;


procedure periodExtras;
var
 count,p,i:       integer;
begin
 if ESprint then extrasSummary;
 periodhead;
 newline;
 for p:=1 to tlimit[ttday] do
 begin
  if tsOn[ttday,p-1] then
  begin
   printw(TimeSlotName[ttDay,p-1]); count:=0;
   for i:=1 to numchanges do
   begin
    if (Changes[i].timeslot<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].gen=4) then continue;
    if not(EProom) and (Changes[i].oldte=Changes[i].newte) and (Changes[i].kind<>1) and
      (Changes[i].oldte>0) then continue;
    if not(EPteach) and (Changes[i].oldroom=Changes[i].newroom) then continue;
    printc(SubCode[Changes[i].sub]);
    printc(yearname[Changes[i].year]);
    printc(ClassCode[ClassShown[Changes[i].level,Changes[i].year]]);
    printc(tecode[Changes[i].oldte,0]);
    printc(tecode[Changes[i].oldroom,1]);
    inc(count);
    printc(GenType(Changes[i].gen));
    te1:=Changes[i].newte;
    if Changes[i].kind=1 then substr:=etsub[te1] else substr:=tecode[te1,0];
    printc(tecode[Changes[i].newroom,1]);
    printc(substr);
    printc(printkind(i));
    printc(GetStatusNote(i));
    newline;
   end; {for i}
   if count=0 then
   begin
    printc('(no change)'); newline;
   end;
   newline;
  end;
  checkEPblank;
 end; {for p}
end;


procedure absentTeacherExtras;
var
 j,i,p,te: integer;
 tmpstr1,tmpstr2: string;
 tallot,tcovallot: double;
 found,tlost,tcover:  integer;
begin
 weeklyInSub;
 if num=0 then exit;
 newline;
 for j:=1 to num do
 begin
  te:=free2[j];
  if teAbsent[te]=-1 then continue;
  printw('Absent teacher:');printc(tename[te,0]);
  printc(dayname[ttday]);
  printc(inttostr(exday)+' '+month[exmonth]+' '+inttostr(exyear));
  if EPreason then
   begin
    printc('Reason:'); printc(Abcode[tabsreason[te]]);
    printc(Absent[tabsreason[te]]);
   end;
  newline; newline;
  PrintLine(['Time','Subject',yeartitle,'Class','Room','New Teacher','Status','Note']);
  count:=0; tallot:=0;
  tcovallot:=0;
  for p:=1 to tlimit[ttday] do
  begin
   if bool(teAbsent[te] and (1 shl p)) then continue;
   printw(TimeSlotName[ttDay,p-1]); found:=0; inc(count);
   for i:=1 to numchanges do
   begin
    if (Changes[i].gen=4) or (Changes[i].timeslot<>p) or (Changes[i].oldte<>te) then continue;
    found:=-1;
    printc(SubCode[Changes[i].sub]);
    printc(yearname[Changes[i].year]);
    printc(ClassCode[ClassShown[Changes[i].level,Changes[i].year]]);
    printc(tecode[Changes[i].newroom,1]);
    if Changes[i].kind=1 then printc(ETname[Changes[i].newte])
     else printc(tename[Changes[i].newte,0]);
    if (Changes[i].kind>9) then begin printc(IgnoreStatusMsg); printc(''); end
     else
      begin
       printc(printkind(i));
       printc(GetStatusNote(i));
      end;
    newline;
    tallot:=tallot+getEallot(2,te,ttday,p);
    tcovallot:=tcovallot+getEallot(2,te,ttday,p);
   end; {for i}
   tlost:=0; if (telost[te] and (1 shl p))=0 then tlost:=-1;
   if not(bool(found)) and bool(tlost) then
    begin  printc('Lost Class'); newline; end;
   if not(bool(found)) and (tlost=0) then
    begin  printc('Free'); newline; end;
  end; {for p}
  tcover:=0; 
  for p:=1 to tlimit[ttday] do
   if copy(temap[te],p,1)='A' then inc(tcover);
  str(tallot:5:2,tmpstr1); str(tcovallot:5:2,tmpstr2);
  printw('Absent times this day:'); printc(inttostr(count));
  printc('Alloted: '+tmpstr1);
  printc('Cover: '+inttostr(tcover));
  printc('Alloted: '+tmpstr2);
  newline; newline; newline;
  checkEPblank;
 end; {for j}
end;



procedure resources;
var
 s,astr: string;
 p,i,j,a:      integer;
 mycount,mycountmax: integer;
begin
 heading:='Resources for '+dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth]+' '+
  inttostr(exyear);
 count:=0; mycountmax:=10;
 printLine([heading]);
 if Esprint then extrasSummary;
 newline;
 for p:=1 to tlimit[ttday] do
 begin
  printw(TimeSlotName[ttDay,p-1]);
  printc('Teachers required:');printc(inttostr(trequire[p]));
  str(treq[p]:5:2,s);
  printc('Allot:'); printc(s);
  printc('Got:'); printc(inttostr(tgot[p]));
  printc('Need:'); printc(inttostr(tneed[p]));
  printc('Available:'); printc(inttostr(tavail[p]));
  newline;
  if tgot[p]>0 then
  begin
   printc('Used:'); mycount:=0;
   for i:=1 to numchanges do
   begin
    a:=Changes[i].timeslot;
    if (a<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) then continue;
    if ((Changes[i].kind>0) and (Changes[i].needte=0) and (Changes[i].newte>0)) then
    begin
     inc(mycount);
     if Changes[i].kind=1 then printc(etsub[Changes[i].newte]+' ')
      else printc(tecode[Changes[i].newte,0]+' ');
     printw(gkind[Changes[i].kind]+' ');
    end;
    if mycount>=mycountmax then begin newline; mycount:=0; end;
   end; {for i}
   if mycount>0 then newline;
  end; {if tgot[p]>0 then}
  if (tavail[p]>0) then
  begin
   printc('Avail:'); 
   if eavail[p]>0 then
   begin
    printc('Added staff');  mycount:=0;
    for j:=1 to etnum1 do
    begin
     i:=Etpointer[j];
     if (Etmax[i]>=(Ettaught[i]+getEallot(7,i,ttday,p))) and
      bool(etavail[i] and Eton[i] and (1 shl p)) then
      begin printc(etsub[i]);inc(mycount); end;
      if mycount>=mycountmax then begin newline; mycount:=0; end;
    end; {for j}
    if mycount>0 then newline;
   end;
   if treplace[p]>0 then
   begin
    printc('Replace');   mycount:=0;
    for j:=1 to codenum[1] do
    begin
     i:=codepoint[j,1];
     astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
     if (teavail[i]>=getEallot(2,i,ttday,p)) and bool(teon[i] and (1 shl p) and teAbsent[i])
      and bool(tena[i]) then
      begin printc(tecode[i,0]); inc(mycount); end;
     if mycount>=mycountmax then begin newline; mycount:=0; end;
    end; {for j}
    if mycount>0 then newline;
   end;
   if tlieu[p]>0 then
   begin
    printc('In Lieu');   mycount:=0;
    for j:=1 to codenum[1] do
    begin
     i:=codepoint[j,1];
     astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
     if (telieudbl[i]>=getEallot(2,i,ttday,p))
      and (teavail[i]<getEallot(2,i,ttday,p)) and
      bool(teon[i] and (1 shl p) and teAbsent[i]) and bool(tena[i]) then
      begin printc(tecode[i,0]);inc(mycount); end;
     if mycount>=mycountmax then begin newline; mycount:=0; end;
    end; {for j}
    if mycount>0 then newline;
   end;
   if textra[p]>0 then
   begin
    printc('Extra '); mycount:=0;
    for j:=1 to codenum[1] do
    begin
     i:=codepoint[j,1];
     astr:=copy(tecode[i,0],1,2); if astr='00' then continue;
     if ((getEallot(8,i,ttday,p)+Etaken[i])<=Emax[i])
       and (telieudbl[i]<getEallot(8,i,ttday,p)) and
      (teavail[i]<getEallot(8,i,ttday,p)) and bool(teon[i] and (1 shl p) and teAbsent[i])
       and bool(tena[i]) then
       begin printc(tecode[i,0]);inc(mycount); end;
     if mycount>=mycountmax then begin newline; mycount:=0; end;
    end; {for j}
    if mycount>0 then newline;
   end;
  end; {if (tavail[p]>0) then}
  printc('Rooms required:'); printc(inttostr(rrequire[p]));
  printc('Got:'); printc(inttostr(rgot[p]));
  printc('Need:'); printc(inttostr(rneed[p]));
  printc('Available:'); printc(inttostr(ravail[p]));
  newline;
  if rgot[p]>0 then
  begin
   printc('Used:'); mycount:=0;
   for i:=1 to numchanges do
   begin
    a:=Changes[i].timeslot;
    if (a<>p) or ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].newroom=0) or (Changes[i].needroom<>2) then continue;
    printc(tecode[Changes[i].newroom,1]); inc(mycount);
    if mycount>=mycountmax then begin newline; mycount:=0; end;
   end; {for i}
   if mycount>0 then newline;
  end;
  if ravail[p]>0 then
  begin
   printc('Avail:'); 
   if rlost[p]>0 then
   begin
    printc('Replace '); mycount:=0;
    for j:=1 to codenum[2] do
    begin
     i:=codepoint[j,2];
     astr:=copy(tecode[i,1],1,2); if astr='00' then continue;
     if bool(roomon[i] and (1 shl p) and roAbsent[i]) and
      ((rolost[i] and (1 shl p))=0) then
      begin printc(tecode[i,1]); inc(mycount); end;
     if mycount>=mycountmax then begin newline; mycount:=0; end;
    end; {for j}
    if mycount>0 then newline;
   end;
   rextra[p]:=ravail[p]-rlost[p];
   if rextra[p]>0 then
   begin
    printc('Free');  mycount:=0;
    for j:=1 to codenum[2] do
    begin
     i:=codepoint[j,2];
     astr:=copy(tecode[i,1],1,2); if astr='00' then continue;
     if bool(roomon[i] and (1 shl p) and roAbsent[i] and rolost[i]) then
      begin printc(tecode[i,1]); inc(mycount); end;
     if mycount>=mycountmax then begin newline; mycount:=0; end;
    end; {for j}
    if mycount>0 then newline;
   end;
  end;
  checkEPblank;
  newline;
 end; {for p}

 printLine(['Totals:']);
 printw('Teachers required:'); printc(inttostr(treqtotal));
 str(treqtot:5:2,s);
 printc('Allot:'); printc(s);
 printc('Got:'); printc(inttostr(tgottotal));
 printc('Need:'); printc(inttostr(tneedtotal));
 if tneedtotal>0 then begin printc('Available:'); printc(inttostr(tavailtotal)); end;
 newline;
 printw('Rooms required:'); printc(inttostr(rreqtotal));
 printc('Got:'); printc(inttostr(rgottotal));
 printc('Need:'); printc(inttostr(rneedtotal));
 if rneedtotal>0 then begin printc('Available:'); printc(inttostr(ravailtotal)); end;
 newline;
end;


procedure yearExtras;
var
 i,yy,p,start,finish:       integer;
begin
 if winCurrentExtrasyear<0 then
 begin start:=years_minus_1; finish:=0; end
 else
  begin start:=winCurrentExtrasyear; finish:=winCurrentExtrasyear; end;
 if ESprint then extrasSummary;
 printLine([heading]);
 printLine([Yeartitle,'Class','Time','Subject','Room','Change','New Room','Cover Teacher']);
 for yy:=start downto finish do
 begin
  printw(yearname[yy]); count:=0;
  for p:=1 to tlimit[ttday] do
  begin
   if not(tsOn[ttday,p-1]) then continue;
   for i:=1 to numchanges do
   begin
    if ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].gen=4) or (Changes[i].timeslot<>p) or (Changes[i].year<>yy) then
     continue;
    if not(eproom) and (Changes[i].oldte=Changes[i].newte) and (Changes[i].kind<>1) and (Changes[i].oldte>0) then
     continue;
    if not(epteach) and (Changes[i].oldroom=Changes[i].newroom) then continue;
    printc(ClassCode[ClassShown[Changes[i].level,yy]]);
    printc(TimeSlotName[ttDay,p-1]);
    printc(SubCode[Changes[i].sub]);
    printc(tecode[Changes[i].oldroom,1]);
    inc(count);
    printc(GenType3(i));
    printc(tecode[Changes[i].newroom,1]);
    if Changes[i].kind=1 then printc(ETname[Changes[i].newte])
     else printc(tename[Changes[i].newte,0]);
    newline;
   end; {for i}
  end; {for p}
  if count=0 then
  begin
   printc('(no changes)'); newline;
  end;
  newline;
  checkEPblank;
 end; {for yy}
end;



procedure coveringTeacherExtras;
var
 j,i,p:  integer;
begin
 ETreason:=0;
 if ETprint then ETweeklyInsub else weeklyInsub;
 if num=0 then exit;
 count:=0;

 if esprint then extrasSummary;
 printLine(['Teacher','Time','Subject',yeartitle,'Class','Room','Change','Status','Note']);
 newline;
 newline;
 for j:=1 to num do
 begin
  te:=free2[j]; found:=0;
  for i:=1 to numchanges do
  begin
   if ((Changes[i].kind>9) and (not(IgnoreStatusMsgFlag))) or (Changes[i].newte<>te) then continue;
   if not(etprint xor (Changes[i].kind=1)) then found:=-1;
  end; {for i}
  if not(bool(found)) then continue;
  if etprint then printw(ETname[te]) else printw(tename[te,0]);
  newline;
  printw(dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth]);
  for p:=1 to tlimit[ttday] do
   for i:=1 to numchanges do
   begin
    if (Changes[i].timeslot<>p) or (Changes[i].newte<>te) then continue;
    if (etprint xor (Changes[i].kind=1)) then continue;
    printc(TimeSlotName[ttDay,p-1]);
    printc(SubCode[Changes[i].sub]);
    printc(yearname[Changes[i].year]);
    printc(ClassCode[ClassShown[Changes[i].level,Changes[i].year]]);
    printc(tecode[Changes[i].newroom,1]);
    printc(GenType3(i));
    if etprint then
    begin
     if (etreason<>Changes[i].oldte) and (a=1) and epreason and (Changes[i].reason>0) then
     begin
      printc('('+Abcode[Changes[i].reason]+' '+Absent[Changes[i].reason]+')');
      etreason:=Changes[i].oldte;
     end;
     printc(GetStatusNote(i));
     newline;
    end
    else
     begin
       printc(printkind(i));
       printc(GetStatusNote(i));
      if (a=1) and epreason and (Changes[i].reason>0) then
      begin
       printc(' '+Abcode[Changes[i].reason]+' '+Absent[Changes[i].reason]);
      end;
      newline;
     end;

   end; {for i}
  checkEPblank;
  newline;
 end; {for j}
end;


begin
 header;
 case winView[wnCurrentExtras] of
  0: periodExtras;
  1: yearExtras;
  2: absentTeacherExtras;
  3,4: coveringteacherExtras;
  5: extrasSummary;
  6: resources;
 end; {case}
 printCustomAddon;
end;

procedure CurrentExtrasWinOut;
begin
 OutCurrentExtras:=TOutCurrentExtras.Create;
 with OutCurrentExtras do
  try
   SetTabs;
   if ListType=1 then ShowLists else ImplementPrint;
  finally
   OutCurrentExtras.free;
  end;
end;

procedure TCurrentExtrasWin.PopupMenu1Popup(Sender: TObject);
begin
 StudentTimetable1.visible:=(selcode>0);
end;

procedure TCurrentExtrasWin.StudentTimetable1Click(Sender: TObject);
begin
  ShowStudTt;
end;

end.


