unit Roshow;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,classdefs,TCEglobals, GlobalToTcAndTcextra;

type
  TRoShowWin = class(TDrawWin)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  protected
    procedure SetTabs; override;
  end;

var
  RoShowWin: TRoShowWin;

implementation
uses tcommon,tcommon2,tcommon3, Mancover;

{$R *.DFM}

var
 rocoverstr,rostatusstr:    string;
 rosub,royear,rolevel,roteach:              integer;
 roomchange,IsActive:    bool;


procedure TRoShowWin.SetTabs;
var
 j,star: integer;
begin
 SetLength(Tabs,8);
 star:=canvas.textwidth('*');
 MaxTab(1,fwperiodname,'Time ');
 MaxTab(2,fwcode[0],'Subject ');
 MaxTab(3,fwcode[1]+star,'Teacher* ');
 MaxTab(4,fwyearname,yeartitle);
 MaxTab(5,fwclass,'Class');
 j:=canvas.textwidth('Room Change');if fwabsence>j then j:=fwabsence;
 MaxTab(6,j,'Status W');
 j:=fwAddedStaffcode;if fwcode[1]>j then j:=fwcode[1];
 MaxTab(7,j,'Lost Class ');
 maxW:=tabs[7];
 maxH:=(7+periods)*txtheight;
 headwidth:=canvas.TextWidth('Date: 29 May  Timetable day: ')+fwDayname;
 j:=fwcode[2]+fwcodename[2];
 j:=canvas.textwidth('Room: ')+j+3*blankwidth;
 if j>headwidth then headwidth:=j;
end;

function checkroomExtras(P:smallint):bool;
 var
  slot,i: integer;
  found:        bool;
 begin
  slot:=(1 shl p); found:=false; roomchange:=false;
  if (rolost[roshownum] and slot)=0 then rocoverstr:='Lost Class';
  if (roAbsent[roshownum] and slot)=0 then rostatusstr:='Room Change';

  if numchanges>0 then
  begin
   for i:=1 to numchanges do
   begin
    if ((Changes[i].timeslot=p) and (Changes[i].year=royear)
     and (Changes[i].level=rolevel) and (Changes[i].oldroom=roshownum)) then
    begin
     found:=true;
     if ((Changes[i].newte<>Changes[i].oldte) and (Changes[i].newte>0)) then
     begin
      roomchange:=true; roteach:=Changes[i].newte;
      if (Changes[i].kind=1) then roteach:=roteach+1000;
     end;
     if (Changes[i].gen=1) then
     begin
      if (Changes[i].reason>0) then rostatusstr:=copy(Absent[Changes[i].reason],1,20);
      if (Changes[i].newte>0) then
      begin
       rocoverStr:=tecode[Changes[i].newte,0];
       if Changes[i].kind=1 then rocoverStr:=etsub[Changes[i].newte];
      end;
     end; {if}
     if ((Changes[i].newroom<>Changes[i].oldroom) and (Changes[i].newroom>0)) then
     begin
      rostatusstr:='Room Change'; rocoverstr:=tecode[Changes[i].newroom,1];
     end;
     if ((Changes[i].gen=1) and bool(Changes[i].needroom) and (Changes[i].newroom=0)) then
     begin
      rostatusstr:='Room Change'; rocoverstr:='Needed';
     end;
    end; {if}
   end; {for i}

   for i:=1 to numchanges do
   begin

    if ((Changes[i].timeslot=p) and (Changes[i].newroom=roshownum)) then
    begin
     found:=true;
     case Changes[i].kind of
      2,3,4,5: begin
                rosub:=Changes[i].sub; roteach:=Changes[i].newte;
                royear:=Changes[i].year; rolevel:=Changes[i].level;
               end;
      1: begin
          rosub:=Changes[i].sub; roteach:=Changes[i].newte+1000;
          royear:=Changes[i].year; rolevel:=Changes[i].level;
         end;
      0: if (Changes[i].oldroom<>Changes[i].newroom) then
         begin
          rosub:=Changes[i].sub; roteach:=Changes[i].oldte;
          royear:=Changes[i].year; rolevel:=Changes[i].level;
         end;
     end; {case}
     case Changes[i].kind of
      2: rostatusstr:='Replace';
      3: rostatusstr:='In Lieu';
      4: rostatusstr:='Extra';
      5: rostatusstr:='Shared';
      1: rostatusstr:='Added';
      0: if (Changes[i].oldroom<>Changes[i].newroom) then rostatusstr:='Room Change';
     end; {case}
    end;
   end; {for i}
  end; {if numchanges>0}
  result:=found;
 end;



procedure TRoShowWin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if IsActive then MancoverDlg.checkbox1.checked:=false;
 Action:=caFree;
end;

procedure TRoShowWin.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnRoShow);
end;

procedure TRoShowWin.FormPaint(Sender: TObject);
var
 p:       smallint;
 found,roomchangeflag:    bool;
 bstr:  string;

begin
 codecolor:=cpRoom;
 printw2('Date: ',inttostr(exday)+' '+month[exmonth]);
 printw2('  Timetable day: ',dayname[ttday]);
 newline;
 printw2('Room: ',tecode[roshownum,1]+' '+tename[roshownum,1]);
 newline;       fcolor(cpNormal);
 printw('Time'); x:=Tabs[1];
 printw('Subject'); x:=Tabs[2];
 printw('Teacher'); x:=Tabs[3];
 printw(Yeartitle); x:=Tabs[4];
 printw('Class'); x:=Tabs[5];
 printw('Status'); x:=Tabs[6];
 printw('Cover');
 newline;
 roomchangeflag:=false;
 fcolor(codecolor);
 for p:=1 to tlimit[ttday] do
 begin
  rosub:=0; royear:=0; rolevel:=0; rostatusstr:=''; rocoverstr:='';
  roteach:=0;
  printw(TimeSlotName[ttDay,p-1]);  x:=Tabs[1];
  found:=GetRoomTtItem(rosub,roteach,RoYear,rolevel,roshownum,ttday,p-1);
  if checkroomExtras(p) then found:=true;
  bstr:=''; if (roteach>1000) then bstr:=etsub[roteach-1000];
  if ((roteach>0) and (roteach<=numcodes[1])) then bstr:=tecode[roteach,0];
  if found then
  begin
   if ((rosub>0) and (rosub<=numcodes[0])) then printw(subcode[rosub]);
   x:=Tabs[2];
   if bstr>'' then
    begin
     printwl(bstr);
     if roomchange then begin printwl('*'); roomchangeflag:=true; end;
    end;
   x:=Tabs[3];
   if ((royear>=0) and (royear<years)) then printw(yearname[royear]);
   x:=Tabs[4];
   if ((rolevel>0) and (rolevel<=level[royear])) then
    printw(ClassCode[ClassShown[rolevel,royear]]);
   x:=Tabs[5];
   printw(rostatusstr); x:=Tabs[6];
   printw(rocoverstr);
  end; {if found}
  newline;
 end; {for p}
 fcolor(cpNormal);
 if roomchangeflag then
 begin
  newline; printw('Note: * indicates a teacher change');
 end;

end;


procedure TRoShowWin.FormActivate(Sender: TObject);
begin
 IsActive:=true;
end;

procedure TRoShowWin.FormDeactivate(Sender: TObject);
begin
 IsActive:=false;
end;

end.
