unit Tcommon3;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, SysUtils,Messages,grids,TCEglobals
  ,Ttable, GlobalToTcAndTcextra;
                    
function countAbsTes:integer;
function printKind(i: integer): string;
procedure sortabCodes;
procedure sortLCCodes;
procedure NewClassWinSelect;
procedure LostClassWinSelect;
procedure deletechange(a: integer);
procedure resetAvail(place: integer);
procedure roomswapsWinSelect;
procedure UnavailableRoomsWinSelect;
procedure updateUnavailableClassesCnt;
procedure updateSwappedClassesCnt;

procedure removeteacher1(a: integer);
procedure MergedClassWinSelect;
procedure CurrentExtrasWinSelect;
procedure PastExtrasWinSelect;
procedure calcReasonsInUse;
procedure calcCoverInUse;

procedure addedstaffselwinSelect;
procedure removeConsequents;
procedure checktemplinks(place: integer);
procedure updateTelink;
procedure ETselectedCount;

procedure removeTeacherCover(i,p: integer);

procedure updatelostclassesCount;

function findroomstr(c: string):integer;
procedure updateRoomMap;
procedure displayCounts;
procedure merge_classes;
procedure new_classes;
procedure FindRoWinSelect;
procedure FindTeWinSelect;
procedure TeShowWinSelect;
function getAutoCoverIgnoredHint: string;


function isTeachingInROOM(te,p: integer):integer;

function findteString(c: string):integer;
function findSubString(c: string):integer;
function findPeriodString(c: string):integer;
procedure updateIgnoreChangesCount;
function getEallot(i,yy,dd,pp: integer): double;
procedure updateAbsence(myte: integer);
Procedure RemoveMyRoomCover(i,p:integer);
Procedure BalanceRoomSwap(ro1,ro,p: integer);
procedure removeAbsentRoom(p,place: integer);
procedure addAbsentRoom(p,place: integer);
procedure UpdateRoomAbsence(place: integer);

const
 gkind: array[1..10] of string[4]=('(C)','(R)','(I)','(C)','(T)','(S)','','','','');

var
 ttyear,ttlevel,ttroom,ttsub: integer;

 newclasses: smallint;
 newclassnum: smallint;

 lostclasses: smallint;

 unavailableClassesCnt,
 roomSwapsCnt:         smallint;


 mergedclasses: integer;
 teabsent2,newclasses1,roomsunavail,tesubs,teneeded,
 roomsneeded,telostnum,rolostnum: integer;


implementation
uses tcommon,tcommon2,main,newclass,lostclss,mrgclass,
     unavalro,roomswap,curextra,adstfsel,astfsldg,printers,pstextra,
     findte,teshow,findro,roshow,abtes,tceload;


Procedure RemoveMyRoomCover(i,p:integer);
var
 ro:      integer;
begin
 ro:=Changes[i].newroom; Changes[i].newroom:=0;
 roomon[ro]:=roomon[ro] or (1 shl p);
 rocover[ro]:=rocover[ro] or (1 shl p);
 Changes[i].needroom:=1;
end;


Procedure BalanceRoomSwap(ro1,ro,p: integer);
var
 te1,sub1,level1,year1,a,i: integer;
 found: boolean;
begin
  found:=false;
  te1:=0; sub1:=0; level1:=0; year1:=0;
  if not(GetRoomTtItem(sub1,te1,Year1,Level1,ro,ttday,p-1)) then exit;
  for i:=1 to numchanges do
   if Changes[i].timeslot=p then
    if Changes[i].oldroom=ro then
      begin
       Changes[i].newroom:=ro1; Changes[i].needroom:=2;
       roomon[ro1]:=roomon[ro1] and (not(1 shl p));
       found:=true;
      end;
 if not(found) then
  begin
    inc(numchanges); a:=numchanges; Changes[a].timeslot:=p; Changes[a].year:=year1;
    Changes[a].level:=level1; Changes[a].sub:=sub1; Changes[a].oldte:=te1; Changes[a].newte:=te1;
    Changes[a].oldroom:=ro; Changes[a].newroom:=ro1; Changes[a].kind:=0; Changes[a].needte:=0;
    Changes[a].needroom:=2; Changes[a].reason:=0; Changes[a].gen:=0;
    if bool(roomon[ro1] and (1 shl p)) then
     roomon[ro]:=roomon[ro] or (1 shl p);
    roomon[ro1]:=roomon[ro1] and not(1 shl p);
   end;
end;



function printKind(i: integer): string;
begin
 result:='';
 case Changes[i].kind of
  1: if Changes[i].newte>0 then result:='Add';
  2: result:='Replace';
  3: result:='In Lieu';
  4: result:='Extra';
  5: result:='Share';
  6: result:='Swap';
 end; {case}
 if bool(Changes[i].needte) then result:='Needed';
 if ((Changes[i].kind>9) and IgnoreStatusMsgFlag) then result:=IgnoreStatusMsg;
end;


function GetTTRoYear(myro,dd,pp: integer):integer;
var
 y,yy,l:  integer;
 afnt:  tpintpoint;
begin
 yy:=years_minus_1;
 for y:=0 to years_minus_1 do
 begin
  afnt:=FNT(ttday,pp-1,y,0,2);
  for l:=1 to level[y] do
  begin
   inc(afnt,6);
   if myro=afnt^ then
   begin
    yy:=y; break;
   end;
  end; {l}
  if yy<>years_minus_1 then break;
 end; {y}
 GetTTRoYear:=yy;
end;

function GetTTTeYear(myte,dd,pp: integer):integer;
var
 y,yy,l:  integer;
 afnt:  tpintpoint;
begin
 yy:=years_minus_1;
 for y:=0 to years_minus_1 do
 begin
  afnt:=FNT(ttday,pp-1,y,0,2);
  for l:=1 to level[y] do
  begin
   inc(afnt,4);
   if myte=afnt^ then
   begin
    yy:=y; break;
   end;
  end; {l}
  if yy<>years_minus_1 then break;
 end; {y}
 GetTTTeYear:=yy;
end;

function GetTTTeYear2(myte,dd,pp: integer):integer;
var
 yy,i:  integer;
begin
 GetTTTeYear2:=0;   {return 0 if not found}
 yy:=0;
 if numchanges=0 then exit;
 for i:=1 to numchanges do
 begin
  if (Changes[i].newte=myte) and (Changes[i].timeslot=pp) then
   begin yy:=Changes[i].year; break; end;
 end; {i}
 GetTTTeYear2:=yy;
end;

function GetAdstfYear(myte,dd,pp: integer):integer;
var
 yy,i:  integer;
begin
 GetAdstfYear:=0;   {return 0 if not found}
 yy:=0;
 if numchanges=0 then exit;
 for i:=1 to numchanges do
 begin
  if (Changes[i].newte=myte) and (Changes[i].timeslot=pp) then
   begin yy:=Changes[i].year; break; end;
 end; {i}
 GetAdstfYear:=yy;
end;

function GetAvEallot(dd,pp: integer):double;
var
 y:  integer;
 max:        double;
begin
 max:=0;
 for y:=0 to years_minus_1 do
  max:=max+Eallot[y,dd{ttday},pp];
 max:=max / years;
 GetAvEallot:=max;
end;

function GetMaxEallot(dd,pp: integer):double;
var
 y:  integer;
 max,t:        double;
begin
 max:=0;
 for y:=0 to years_minus_1 do
 begin
  t:=Eallot[y,dd{ttday},pp];
  if t>max then max:=t;
 end; {y}
 GetMaxEallot:=max;
end;

function GetMinEallot(dd,pp: integer):double;
var
 y:  integer;
 min,t:        double;
begin
 min:=99999;
 for y:=0 to years_minus_1 do
 begin
  t:=Eallot[y,dd{ttday},pp];
  if t<min then min:=t;
 end; {y}
 GetMinEallot:=min;
end;

function getEallot(i,yy,dd,pp: integer): double;
begin
 getEallot:=0;
 if (pp>0) and (pp<=periods) then
  case i of
   1: getEallot:=Eallot[yy,dd,pp];  {know year, day and time}
   2: {don't know year, teach in yy - get year from tt }
     begin
      getEallot:=Eallot[GetTTTeYear(yy,dd,pp),dd{ttday},pp];
     end;
   3:{don't know year, room in yy - get year from tt }
     begin
      getEallot:=Eallot[GetTTRoYear(yy,dd,pp),dd{ttday},pp];
     end;
   4:{get min}
     begin
      getEallot:=GetMinEallot(dd,pp);
     end;
   5:{get max}
     begin
      getEallot:=GetMaxEallot(dd,pp);
     end;
   6:begin   {get av}
      getEallot:=GetAvEallot(dd,pp)
     end;
   7:begin {don't know year, add staff in yy - get year from changes }
      getEallot:=Eallot[GetAdstfYear(yy,dd,pp),dd{ttday},pp];
     end;
   8:begin {don't know year, te in yy - get year from changes }
      getEallot:=Eallot[GetTTTeYear2(yy,dd,pp),dd{ttday},pp];
     end;
  end; {case}

end;

function getAutoCoverIgnoredHint: string;
var
 tmpstr: string;
 i,j,ignoredyear: integer;
begin
 tmpstr:='';  ignoredyear:=0;
 j:=0;
 for i:=0 to years_minus_1 do
  if not(coveryear[i]) then
  begin
   inc(j); ignoredyear:=i;
  end;
 if j=0 then   {only check for individual ignoreds if not already ignoring year}
 begin
  updateIgnoreChangesCount;
  if ignoredChangesCount>0 then
  begin
   if ignoredChangesCount=1 then
    tmpstr:=tmpstr+inttostr(ignoredChangesCount)+' change set to ignored.'
   else
    tmpstr:=tmpstr+inttostr(ignoredChangesCount)+' changes set to ignored.'
  end;
 end
 else {give hint for year ignore}
  begin
   if j=1 then
    tmpstr:=tmpstr+yeartitle+' '+yearname[ignoredyear]+' set to ignored.'
   else
    if j=years then
     tmpstr:=tmpstr+'ALL '+yeartitle+'s set to ignored.'
    else
     tmpstr:=tmpstr+inttostr(j)+' '+yeartitle+'s set to ignored.';
  end;
 result:=tmpstr;
end;

procedure updateIgnoreChangesCount;
var
 i:       integer;
begin
 ignoredChangesCount:=0;
 for i:=1 to numchanges do
  if Changes[i].kind>=10 then inc(ignoredChangesCount);
end;

function findPeriodString(c: string):integer;
var
 i,j: integer;
begin
 j:=-1;
 for i:=1 to tlimit[ttday] do
  if uppercase(Trim(TimeSlotName[ttday,i-1]))=uppercase(Trim(c)) then
  begin
   j:=i; break;
  end;
 result:=j;
end;


function findteString(c: string):integer;
var
 i,j:      integer;
begin
 j:=0;
 for i:=1 to codenum[1] do
  if uppercase(Trim(tecode[codepoint[i,1],0]))=uppercase(Trim(c)) then
  begin
   j:=codepoint[i,1]; break;
  end;
 result:=j;
end;

function findSubString(c: string):integer;
var
 i,j:      integer;
begin
 j:=0;
 for i:=1 to codenum[0] do
  if uppercase(Trim(subcode[i]))=uppercase(Trim(c)) then
  begin
   j:=i; break;
  end;
 result:=j;
end;


procedure FindTeWinSelect;
begin
if wnFlag[wnFindTeach] then FindTeacherWin.show
 else FindTeacherWin:=tFindTeacherWin.create(application);
end;

procedure TeShowWinSelect;
begin
 TeShowWin:=tTeShowWin.create(application);
end;



procedure FindRoWinSelect;
begin
if wnFlag[wnFindRoom] then FindRoomWin.show
 else FindRoomWin:=tFindRoomWin.create(application);
end;


procedure calcReasonsInUse;
var
 i,j:  integer;
begin
 j:=0;
 for i:=nmbrreasons downto 0 do
  if ((Trim(Absent[i])>'') or (Trim(Abcode[i])>'')) then
   begin j:=i; break; end;
 nmbrReasonsInUse:=j;
end;


procedure calcCoverInUse;
var
 i,j:  integer;
begin
 j:=0;
 for i:=nmbrreasons downto 0 do
  if (Trim(Cover[i])>'') then
   begin j:=i; break; end;
 nmbrCoverInUse:=j;
end;

function isTeachingInROOM(te,p: integer):integer;
var
 afnt: tpIntpoint;
 y,L:  integer;
 ro:    integer;
begin
 ro:=0;
 for y:=0 to years_minus_1 do
 begin
  for L:=1 to level[y] do
  begin
   afnt:=FNT(ttday,(p-1),y,L,2);
   if afnt^=te then
   begin
    inc(afnt); ro:=afnt^;
    break;
   end;
  end; {for l}
  if bool(ro) then break;
 end; {for y}

 result:=ro;
end;



{-----------------print procs for cur extras ---------------}




procedure updatelostclassesCount;
var
 i: integer;
begin
 lostclasses:=0;
 for i:=1 to numcodes[1] do
  if (telost[i]<>-1) then inc(lostclasses);


end;







procedure new_classes;
var
 i,a:     integer;
begin
 newclasses:=0; newclassnum:=0;
 for i:=1 to nmbrnewclasses do
 begin
  ntime[i]:=0; nsub[i]:=0; nyear[i]:=0; nlevel[i]:=0; nstaff[i]:=0;
  nrooms[i]:=0; nflag[i]:=0;
 end;
 for i:=1 to numchanges do
 begin
  if Changes[i].gen<>2 then continue;
  a:=Changes[i].reason;
  ntime[a]:=ntime[a] or (1 shl Changes[i].timeslot);
  if nflag[a]=0 then nflag[a]:=Changes[i].timeslot;
  if nflag[a]<>Changes[i].timeslot then continue;

  nsub[a]:=Changes[i].sub; nyear[a]:=Changes[i].year; nlevel[a]:=Changes[i].level;
  if bool(Changes[i].needte) or bool(Changes[i].newte) then inc(nstaff[a]);
  if bool(Changes[i].needroom) then inc(nrooms[a]);
  if a>newclasses then newclasses:=a;
 end;
 if newclasses=0 then exit;
 a:=0;
 for i:=1 to newclasses do
 begin
  if (nrooms[i]>0) or (nstaff[i]>0) then
  begin
   inc(a);
   ntime[a]:=ntime[i]; nsub[a]:=nsub[i]; nyear[a]:=nyear[i];
   nlevel[a]:=nlevel[i]; nstaff[a]:=nstaff[i]; nrooms[a]:=nrooms[i];
  end;
 end;
 newclassnum:=a;
end;


procedure merge_classes;
var
 i,a: integer;
begin
 mergedclasses:=0;
 for i:=1 to nmbrmergedclasses do
 begin
  mtime[i]:=0; mkind[i]:=0; msub[i]:=0; myear[i]:=0; mlevel[i]:=0;
  moldte[i]:=0; mnewte[i]:=0; moldroom[i]:=0; mnewroom[i]:=0; mflag[i]:=0;
 end;
 try
   for i:=1 to numchanges do
   begin
    if (Changes[i].gen<>3) and (Changes[i].gen<>5) then continue;
    a:=Changes[i].reason; mtime[a]:=Changes[i].timeslot;
    if (Changes[i].gen=3) and (Changes[i].oldte<>Changes[i].newte) then
    begin
     msub[A]:=Changes[I].sub; myear[A]:=Changes[I].year; mlevel[A]:=Changes[I].level;
     Moldte[A]:=Changes[I].oldte; Mnewte[A]:=Changes[I].newte; Moldroom[A]:=Changes[i].oldroom;
     Mnewroom[A]:=Changes[I].newroom; Mkind[A]:=Changes[i].kind;
    end;
    if (Changes[i].gen=5) and (Changes[i].oldte=Changes[i].newte) and (Changes[i].oldroom<>Changes[i].newroom) then
     mflag[a]:=-1;
    if a>mergedclasses then mergedclasses:=a;
   end;
 except
 end;
end;

procedure ETselectedCount;
var
 i: integer;
begin
ETselected:=0;
for i:=1 to etnum1 do
  if bool(etavail[Etpointer[i]]) then inc(ETselected);
end;


procedure displayCounts;
var
 i: integer;
begin
 ETselectedCount;
 teabsent2:=0; newclasses1:=0; roomsunavail:=0; tesubs:=0;
 teneeded:=0; roomsneeded:=0; telostnum:=0; rolostnum:=0;
 if numchanges<>0 then
  for i:=1 to numchanges do
  begin
   if (Changes[i].gen=2) then inc(newclasses1);
   if bool(Changes[i].needte) then inc(teneeded);
   if Changes[i].needroom=1 then inc(roomsneeded);
  end;
 for i:=1 to numcodes[1] do
 begin
  if teavail[i]>0 then tesubs:=tesubs+trunc(teavail[i]);
  if telost[i]<>-1 then inc(telostnum);
  if teAbsent[i]<>-1 then inc(teabsent2);
 end;
 for i:=1 to numcodes[2] do
 begin
  if roAbsent[i]<>-1 then inc(roomsunavail);
  if rolost[i]<>-1 then inc(rolostnum);
 end;
end;


procedure addedstaffselwinSelect;
begin
if wnFlag[wnAddedSel] then addedstaffselwin.show
 else addedstaffselwin:=taddedstaffselwin.create(application);
end;



procedure CurrentExtrasWinSelect;
begin
if wnFlag[wnCurrentExtras] then CurrentExtrasWin.show
 else CurrentExtrasWin:=tCurrentExtrasWin.create(application);
end;



procedure PastExtrasWinSelect;
begin
if wnFlag[wnPastExtras] then PastExtrasWin.show
  else PastExtrasWin:=tPastExtrasWin.create(application);
end;



procedure updateUnavailableClassesCnt;
var
 i,j:   integer;
begin
 j:=0;
 for i:=1 to numcodes[2] do
  if (roAbsent[i]<>-1) then inc(j);
 UnavailableClassesCnt:=j;
end;

procedure updateSwappedClassesCnt;
var
 i,j:   integer;
begin
 j:=0;
 for i:=1 to numcodes[2] do
  if (roswap[i]<>-1) then inc(j);
 roomSwapsCnt:=j;
end;


function findroomstr(c: string):integer;
var
 i,j:      integer;
begin
 j:=0;
 for i:=1 to codenum[2] do
  if uppercase(Trim(tecode[codepoint[i,2],1]))=uppercase(Trim(c)) then
  begin
   j:=i; break;
  end;
 result:=j;
end;

procedure checktemplinks(place: integer);
var
 i,te,p:   integer;
begin
 te:=abs(ETlink[place]);
 for i:=1 to numchanges do
 begin
  if (Changes[i].gen<>1) or (Changes[i].oldte<>te) then continue;
  p:=Changes[i].timeslot;
  if bool( Eton[place] and (1 shl p) ) and
   bool((getEallot(1,Changes[i].year,ttday,p)+Ettaught[place])<=Etmax[place])
    and bool(Changes[i].needte<>0)  then
  begin
   Changes[i].needte:=0; Changes[i].newte:=place; Changes[i].kind:=1;
   Eton[place]:=Eton[place] and (not(1 shl p));
   etavail[place]:=etavail[place] or (1 shl p);
   Ettaught[place]:=Ettaught[place]+getEallot(1,Changes[i].year,ttday,p);
  end;
 end; {for i}
end;


procedure updateTelink;
var
 i,a,s: integer;
 astr: string;
begin
 s:=0;
 if Etnum>0 then
  for i:=1 to Etnum do
  begin
   astr:=copy(etsub[i],1,2); a:=ETlink[i];
   if ((astr<>'00') and (ETlink[i]<>0)) then
   begin
    if a=0 then s:=0
     else if a<0 then s:=-1
           else if a>0 then s:=1;
    telink[abs(a)]:=s*i;
   end;
  end; {for i}

end;





procedure updateRoomMap;
var
 i,p:   integer;
 lostflag,emptyflag,slot: integer;
 a: string;
begin
 for i:=1 to numcodes[2] do
 begin
  romap[i]:='';
  for p:=1 to tlimit[ttday] do
  begin
   lostflag:=0; emptyflag:=-1; a:='-'; slot:=1 shl p;
   if (roomteach[i] and slot)=0 then begin a:='T'; emptyflag:=0; end;
   if (rolost[i] and slot)=0 then begin a:='L'; lostflag:=-1; end;
   if (roCover[i] and slot)=0 then a:='C';
   if (roswap[i] and slot)=0 then
   begin
    a:='S'; if bool(roomon[i] and slot) then a:='s';
   end;
   if (roAbsent[i] and slot)=0 then
   begin
    a:='U'; if bool(emptyflag) or bool(lostflag) then a:='u';
   end;
   romap[i]:=romap[i]+a;
  end;
 end;


end;


 procedure resetAvail(place: integer);
 var
  p4,i: integer;
 begin
  teavail[place]:=0;
  for p4:=1 to tlimit[ttday] do
  begin
   if bool((not(telost[place])) and (not(teach[place])) and teAbsent[place]
    and tena[place] and (1 shl p4)) then
     teavail[place]:=teavail[place]+getEallot(2,place,ttday,p4);
  end; {for p4}
  if numchanges=0 then exit;
  for i:=1 to numchanges do
   if (Changes[i].gen<>4) and (Changes[i].kind=2) and (Changes[i].newte=place) then
   begin
    p4:=Changes[i].timeslot;
    if teavail[place]>=getEallot(8,place,ttday,p4) then
     teavail[place]:=teavail[place]-getEallot(1,Changes[i].year,ttday,p4)
     else {remove replacement cover}
       begin Changes[i].newte:=0; Changes[i].needte:=-1; Changes[i].kind:=0;
        tereplace[place]:=tereplace[place] or (1 shl p4);
        teon[place]:=(teach[place] or not(telost[place])) and teCover[place] and tereplace[place] and tElieu[place];
       end;
   end;
 end;


procedure removeroom1(a: integer);
var
 ro:      integer;
begin
 if ((Changes[a].gen=5) or (Changes[a].kind=5)) then
 begin
  ro:=Changes[a].oldroom;
  if ((ro<>Changes[a].newroom) and (Changes[a].needroom=0) and ((rolost[ro] and (1 shl Changes[a].timeslot))=0)) then
  begin
   rolost[ro]:=rolost[ro] or (1 shl Changes[a].timeslot);
   roomon[ro]:=roomon[ro] and (not(1 shl Changes[a].timeslot));
  end;
 end;
 if (Changes[a].needroom>0) or (Changes[a].kind=5) then
 begin
  ro:=Changes[a].newroom;
  if bool(ro) and (Changes[a].newroom<>Changes[a].oldroom) then
  begin
   Changes[a].newroom:=0; roomon[ro]:=roomon[ro] or (1 shl Changes[a].timeslot);
   roCover[ro]:=roCover[ro] or (1 shl Changes[a].timeslot);
  end;
 end;
end;


 procedure removeTeacherCover(i,p: integer);
 var
  te,i5:      integer;
  ETused:     boolean;
 begin
  te:=Changes[i].newte; Changes[i].newte:=0; ETused:=false;
  if (Changes[i].kind=1) then
  begin
   ETused:=true;
   Ettaught[te]:=Ettaught[te]-getEallot(1,Changes[i].year,ttday,p);
   Eton[te]:=Eton[te] or (1 shl p);
   if Ettaught[te]<0 then Ettaught[te]:=0;
  end;
  if (Changes[i].kind=2) then
  begin
   teon[te]:=teon[te] or (1 shl p);
   teavail[te]:=teavail[te]+getEallot(1,Changes[i].year,ttday,p);
   tereplace[te]:=tereplace[te] or (1 shl p);
  end;
  if (Changes[i].kind=3) then
  begin
   teon[te]:=teon[te] or (1 shl p);
   telieudbl[te]:=telieudbl[te]+getEallot(1,Changes[i].year,ttday,p);
   telieu[te]:=telieu[te] or (1 shl p);
  end;
  if (Changes[i].kind=4) then
  begin
   teon[te]:=teon[te] or (1 shl p);
   doingextra[te]:=doingextra[te]-getEallot(1,Changes[i].year,ttday,p);
   teCover[te]:=teCover[te] or (1 shl p);
   if doingextra[te]<0 then doingextra[te]:=0;
  end;
  Changes[i].kind:=0;
  Changes[i].needte:=-1;
  if ETused then exit;
  for i5:=1 to numchanges do
   if (((Changes[i5].gen=5) or (Changes[i5].gen=6)) and (Changes[i5].oldte=te)) then
   begin
    inc(consequentnum);
    consequent[consequentnum]:=te;
    contime[consequentnum]:=Changes[i5].timeslot;
   end;
end;




procedure removeteacher1(a: integer);
begin
 if bool(Changes[a].newte) and (Changes[a].newte<>Changes[a].oldte) then
  begin
   ConsequentNum:=0;
   removeteachercover(a,Changes[a].timeslot);
   if ConsequentNum>0 then RemoveConsequents;
  end;
end;



procedure deletechange(a: integer);
var
 n1,b:      integer;
begin
 n1:=Changes[a].notes;
 if n1>1000 then
 begin
  n1:=n1-1000;
  ExNote[n1]:='';
 end;
 b:=numchanges;
 removeroom1(a); removeteacher1(a);
 if b>a then Changes[a]:=Changes[b];
 Changes[b].timeslot:=0; Changes[b].year:=0; Changes[b].level:=0; Changes[b].oldte:=0; Changes[b].sub:=0; Changes[b].newte:=0;
 Changes[b].oldroom:=0; Changes[b].newroom:=0; Changes[b].kind:=0; Changes[b].needte:=0; Changes[b].needroom:=0; Changes[b].notes:=0;
 Changes[b].reason:=0; Changes[b].gen:=0;
 dec(numchanges);
end;


Procedure RemoveConsequents;
var
 i5,ConCount,a:  integer;
 found:     bool;
begin
 Concount:=1; a:=0;
 while (numchanges>0) and (ConCount<=ConsequentNum) do
  begin
   found:=false;
   for i5:=1 to numchanges do
    if ((Changes[i5].gen=5) or (Changes[i5].gen=6)) and
      (Changes[i5].timeslot=Contime[ConCount]) and
      (Changes[i5].oldte=consequent[ConCount]) then
     begin
      found:=true; a:=i5
     end;
   if found then DeleteChange(a);
   inc(ConCount);
  end; {while}
end;

procedure checkForLink(place: integer);
var
 i,etplace,p:   integer;
 perm:          bool;
begin
 etplace:=abs(telink[place]);
 perm:=(telink[place]<0);

 for i:=1 to numchanges do
 begin
  if (Changes[i].gen<>1) or (Changes[i].oldte<>place) then continue;
  p:=Changes[i].timeslot;
  if (perm or
   bool((getEallot(1,Changes[i].year,ttday,p)+Ettaught[etplace])<=Etmax[etplace]))
   and bool(Changes[i].needte<>0) and bool(Eton[etplace] and (1 shl p)) then
  begin
   Changes[i].needte:=0; Changes[i].newte:=etplace; Changes[i].kind:=1;
   Eton[etplace]:=Eton[etplace] and (not(1 shl p));
   etavail[etplace]:=etavail[etplace] or (1 shl p);
   Ettaught[etplace]:=Ettaught[etplace]+getEallot(1,Changes[i].year,ttday,p);
  end;
 end; {for i}
end;


function CheckTeamTeach(myte,ttperiod:integer): bool;
var
 y,l,ro,te,share,i,teamte: integer;
 afnt,bfnt:      tpintpoint;
begin
 result:=false; teamte:=0;
 GetTTsub(myte,ttperiod);
 if (ttshare=0) or (tsharecount<>1) then exit;
 for y:=0 to years_minus_1 do
  begin
   afnt:=FNT(ttday,ttperiod-1,y,0,2);
   for l:=1 to level[y] do
    begin
     inc(afnt,4); bfnt:=afnt;
     te:=afnt^;
     inc(bfnt); ro:=bfnt^;
     share:=FNTbyte(ttday,ttperiod-1,y,l,6)^ and 2;
     if (share<>0) and (ro=ttroom) and (te<>myte) then teamte:=te;
    end; {l}
  end; {y}
 if teamte=0 then exit;
 if (teAbsent[teamte] and (1 shl ttperiod))<>0 then
  begin
   result:=true;
   exit;
  end;
 if numchanges=0 then exit;
 for i:=1 to numchanges do
  begin
   if (Changes[i].gen=1) and (Changes[i].timeslot=ttperiod) and (Changes[i].oldte=teamte)
    then result:=true;
  end;
end;

procedure addAbsentRoom(p,place: integer);
var
 i,sub,te,year1,level1,a:  integer;
 found: boolean;
begin
 te:=0;sub:=0;year1:=0;level1:=0;
 if not(GetRoomTtItem(sub,te,Year1,Level1,place,ttday,p-1)) then exit;

 found:=false;
 if numchanges<>0 then
 begin
  for i:=1 to numchanges do
  begin
   if Changes[i].timeslot=p then
    if Changes[i].oldroom=place then
    begin
     found:=true; a:=i;
     if Changes[a].newroom=place then
     begin
      Changes[a].newroom:=0; Changes[a].needroom:=1;
     end;
     break;
    end;
  end; {for i}
  if found or (numchanges=nmbrchanges) then exit;
 end;
 inc(numchanges); a:=numchanges;
 Changes[a].timeslot:=p; Changes[a].year:=year1; Changes[a].level:=level1; Changes[a].sub:=sub;
 Changes[a].oldroom:=place; Changes[a].newroom:=0; Changes[a].oldte:=te; Changes[a].newte:=te;
 Changes[a].kind:=0; Changes[a].needte:=0; Changes[a].needroom:=1; Changes[a].notes:=0; Changes[a].reason:=0;
 Changes[a].gen:=0;
end;


procedure removeAbsentRoom(p,place: integer);
var
 i,a,ro:    integer;
 found: boolean;
begin
 if numchanges=0 then exit;
 found:=false;  a:=0;
 for i:=1 to numchanges do
 if Changes[i].timeslot=p then
  if Changes[i].oldroom=place then
  begin
   found:=true;
   a:=i; break;
  end;
 if not(found) then exit;
 if Changes[a].gen>0 then
 begin
  Changes[a].newroom:=place; Changes[a].needroom:=0; exit;
 end;
 if Changes[a].needroom>0 then
 begin
  ro:=Changes[a].newroom;
  if bool(ro) then
  begin
   roomon[ro]:=roomon[ro] or (1 shl p);
   rocover[ro]:=rocover[ro] or (1 shl p);
  end;
 end;
 deletechange(a);
end;



procedure UpdateRoomAbsence(place: integer);
var
 p,i: integer;
 isRoomOn, isRoomAbsent: boolean;
begin
  for p:=1 to tlimit[ttday] do
  begin
    isRoomOn := boolean(roomon[place] and (1 shl p));
    isRoomAbsent := boolean(roabsent[place] and (1 shl p));
    if bool((not(roomon[place])) and (not(roabsent[place])) and (1 shl p)) then begin
        addabsentroom(p,place)
    end else begin
      // This is the brute force fix for #146 until I can work out why we want this left in
       removeabsentroom(p,place);
      // Now working on #821-5 and I am guessing we need it for this
      // There are other changes related to #146 - maybe this isnt crucial
    end;
  end;
 for i:=1 to numchanges do
 begin
  p:=Changes[i].timeslot;
  if not(bool(roabsent[place] and (1 shl p))) then
   if Changes[i].newroom=place then
   begin
    Changes[i].newroom:=0; Changes[i].needroom:=1; roomon[place]:=roomon[place] or (1 shl p);
   end;
 end;
end;

// how to add multi-reasons ????
procedure updateAbsence(myte: integer);
var
 i,p,ttperiod: integer;
 teamteach:  bool;
begin
 consequentnum:=0;
 for ttperiod:=1 to tlimit[ttday] do
 begin
  teamteach:=false; if teamexclude then teamteach:=CheckTeamTeach(myte,ttperiod);
  if (not(teamteach))
   and bool(not(teAbsent[myte]) and (telost[myte]) and (tena[myte]) and (1 shl ttperiod))
    then addabsent(myte,ttperiod)
   else
    removeabsent(myte,ttperiod);
 end; {for ttperiod}
 for i:=1 to numchanges do
 begin
  p:=Changes[i].timeslot;
  if bool(teAbsent[myte] and (1 shl p)) then continue;
  if Changes[i].newte<>myte then continue;
  if (Changes[i].kind=0) or (Changes[i].kind=1) then continue;
  removeteachercover(i,p);
 end; {for i}
 if (telink[myte]<>0) then checkForLink(myte); {temps}
 if consequentnum>0 then removeconsequents;
 resetavail(myte);
end;

procedure NewClassWinSelect;
begin
if wnFlag[wnNewClass] then NewClasseswin.show
  else NewClasseswin:=tNewClasseswin.create(application);
end;



procedure MergedClassWinSelect;
begin
if wnFlag[wnMergeClass] then MergedClasseswin.show
  else MergedClasseswin:=tMergedClasseswin.create(application);
end;



procedure LostClassWinSelect;
begin
if wnFlag[wnLostClass] then LostClasseswin.show
 else LostClasseswin:=tLostClasseswin.create(application);
end;



procedure UnavailableRoomsWinSelect;
begin
if wnFlag[wnUnavailRooms] then unavailablerooms.show
 else unavailablerooms:=tunavailablerooms.create(application);
end;



procedure roomswapsWinSelect;
begin
if wnFlag[wnRoomSwap] then roomswaps.show
 else roomswaps:=troomswaps.create(application);
end;



function countAbsTes:integer;
var
 i,j:      integer;
begin
 j:=0;
 for i:=1 to codenum[1] do
  if (teAbsent[codepoint[i,1]]<>-1) then
   inc(j);
 countAbsTes:=j;
end;


procedure sortabCodes;
  var
    D,H,i,pos:         integer;
    J,L,A,B:           integer;
    aStr,tmpStr1,tmpStr2: string;
  label label1,label2;
 var
    num1:             integer;
    oSel:             integer;
begin
 pos:=0;
 for i:=1 to numcodes[1] do
   begin
    aStr:=tecode[i,0];
    aStr:=copy(aStr,1,2);
    if (aStr<>'00') then
     begin
      inc(pos);
      abcodepoint[pos]:=i;
     end;
   end;
{ codenum[code]:=pos; }
 if absorttype=0 then exit;
 D:=1;
 while D<codenum[1] do D:=D+D;
 label1:
 D:=(D-1) div 2;
 if D=0 then exit;
 H:=codenum[1]-D;
 for i:=1 to H do
   begin
    J:=i;
    Label2:
    L:=J+D;
    A:=abcodepoint[L];
    B:=abcodepoint[J];
    case absorttype of
     1: begin
         tmpStr1:=uppercase(tecode[A,0]);
         tmpStr2:=uppercase(tecode[B,0]);
        end;
     2: begin
         tmpStr1:=uppercase(tename[A,0]);
         tmpStr2:=uppercase(tename[B,0]);
        end;
     3: begin
         tmpStr1:=uppercase(Ecomment[A]);
         tmpStr2:=uppercase(Ecomment[B]);
        end;
     4: begin
         tmpStr1:=uppercase(Abcode[tabsreason[a]]+' '+Absent[tabsreason[a]]);
         tmpStr2:=uppercase(Abcode[tabsreason[b]]+' '+Absent[tabsreason[b]]);
        end;
    end; {case}

    if tmpStr1<tmpStr2 then
      begin
       abcodepoint[J]:=A;
       abcodepoint[L]:=B;
       dec(J,D);
      end;
    if (tmpStr1<tmpStr2) and (J>0) then goto Label2;
  end; {for}
  goto label1;

  if wnFlag[wnAbsentTe] then {restore selection}
  begin
   if osel<>0 then
   begin
    for i:=1 to num1 do
    begin
     if abcodepoint[i]=osel then
     begin osel:=i; break; end;
    end;  {for i}
    absentte.selcode:=osel;
   end;
  end;  {if wnFlag[wnAbsentTe]}

end;

procedure sortLCCodes;
  var
    D,H,i,pos:         integer;
    J,L,A,B:           integer;
    aStr,tmpStr1,tmpStr2: string;
  label label1,label2;

begin
 pos:=0;
 for i:=1 to numcodes[1] do
   begin
    aStr:=tecode[i,0];
    aStr:=copy(aStr,1,2);
    if (aStr<>'00') then
     begin
      inc(pos);
      lccodepoint[pos]:=i;
     end;
   end;
{ codenum[code]:=pos; }
 if lcsorttype=0 then exit;
 D:=1;
 while D<codenum[1] do D:=D+D;
 label1:
 D:=(D-1) div 2;
 if D=0 then exit;
 H:=codenum[1]-D;
 for i:=1 to H do
   begin
    J:=i;
    Label2:
    L:=J+D;
    A:=lccodepoint[L];
    B:=lccodepoint[J];
    case lcsorttype of
     1: begin
         tmpStr1:=uppercase(tecode[A,0]);
         tmpStr2:=uppercase(tecode[B,0]);
        end;
     2: begin
         tmpStr1:=uppercase(tename[A,0]);
         tmpStr2:=uppercase(tename[B,0]);
        end;
     3: begin
         tmpStr1:=uppercase(Ecomment[A]);
         tmpStr2:=uppercase(Ecomment[B]);
        end;
     4: begin
         tmpStr1:=uppercase(Abcode[tabsreason[a]]+' '+Absent[tabsreason[a]]);
         tmpStr2:=uppercase(Abcode[tabsreason[b]]+' '+Absent[tabsreason[b]]);
        end;
    end; {case}


    if tmpStr1<tmpStr2 then
      begin
       lccodepoint[J]:=A;
       lccodepoint[L]:=B;
       dec(J,D);
      end;
    if (tmpStr1<tmpStr2) and (J>0) then goto Label2;
  end; {for}
  goto label1;
end;


end.

