unit Edroswap;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Buttons, StdCtrls,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  Tedroomswaps = class(TForm)
    Label8: TLabel;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    update: TBitBtn;
    finish: TBitBtn;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
  end;

var
  edroomswaps: Tedroomswaps;

implementation
uses tcommon,tcommon2,tcommon3,roomswap;
{$R *.DFM}

 type TRoomSwapTime=class(TTimeSet)
  protected
   function SmallCase(i:integer): boolean; override;
  public
   perlab3:   array of tlabel;
 end;

var
  RoomSwapTime:    TRoomSwapTime;
  needupdate:        boolean;
  myroom1,myroom2:       integer;

function TRoomSwapTime.SmallCase(i:integer): boolean;
begin
 result:=bool(roomon[myroom1] and (1 shl i))
end;


procedure Tedroomswaps.FormCreate(Sender: TObject);
const
 ygap=3;
var
 i,j:   integer;
begin
 label5.caption:=''; label4.caption:='';
 combobox6.maxlength:=lencodes[2];
 combobox7.maxlength:=lencodes[2];
 needupdate:=false;
 updateSwappedClassesCnt;
 label9.caption:=inttostr(roomSwapsCnt);

 combobox6.clear;
 for i:=1 to codenum[2] do
  combobox6.items.add(tecode[codepoint[i,2],1]);
 combobox7.clear;
 for i:=1 to codenum[2] do
  combobox7.items.add(tecode[codepoint[i,2],1]);

  RoomSwapTime:=TRoomSwapTime.create(GroupBox1);
 With RoomSwapTime do
  begin
   ButtonChar:='S';
   RoomSwapTime.Left:=10;
   RoomSwapTime.Top:=120;
   ButtonHint:='Toggles swapped for time slot';
   BaseGroup:=GroupBox1;
   makebuttons;
   SetLength(perlab3,1+Tlimit[ttday]);
   for i:=1 to Tlimit[ttday] do
    begin
      perlab3[i]:=tlabel.create(GroupBox1);
      perlab3[i].font.color:=clblue;
      perlab3[i].tag:=i;
      perlab3[i].parent:=groupbox1;
      perlab3[i].caption:='';
      perlab3[i].visible:=true;
      perlab3[i].left:=button1[i].left;
      perlab3[i].top:=perlab2[i].top+perlab2[i].height+ygap;
    end; {for i}
   label12.top:=perlab2[1].top;
   label13.top:=perlab3[1].top;
  end;

 combobox6.text:='';
 j:=roomswaps.selcode;
 if j>0 then j:=roomswaps.ItemPoint[j];
 if j>0 then
 begin
  combobox6.text:=tecode[j,1];
  combobox6change(self);
 end;
end;

procedure Tedroomswaps.updateClick(Sender: TObject);
var
 swap,i,p,y,L,a,swapstatus: integer;
 msg:      string;
 room1,room2,swaproom1,swaproom2:  integer;
 found1,found2,te1,te2,sub1,sub2,level1,level2:  integer;
 year1,year2,notused1,notused2:                  integer;
 afnt,bfnt:                                      tpintpoint;
 te,ro,sub,inchange1,inchange2:                                      integer;

begin
 swap:=0;
 room1:=codepoint[findroomstr(combobox6.text),2];
 if room1=0 then
 begin
  msg:='Check first room code';
  messagedlg(msg,mtError,[mbOK],0);
  combobox6.selectall; combobox6.setfocus;
  exit;
 end;
 room2:=codepoint[findroomstr(combobox7.text),2];
 if room2=0 then
 begin
  msg:='Check second room code';
  messagedlg(msg,mtError,[mbOK],0);
  combobox7.selectall; combobox7.setfocus;
  exit;
 end;

 for i:=1 to tlimit[ttday] do
  if uppercase(RoomSwapTime.button1[i].caption)='S' then swap:=swap or (1 shl i);
 msg:='';   y:=0;
 for p:=1 to tlimit[ttday] do
  if bool(swap and (1 shl p)) then
  begin
   if (roabsent[room1] and (1 shl p))=0 then
    begin
     msg:='Room '+Trim(tecode[room1,1])+' unavailable in time '+tslotcode[p,ttday];
     y:=1;
    end;
   if (roabsent[room2] and (1 shl p))=0 then
    begin
     msg:='Room '+Trim(tecode[room2,1])+' unavailable in time '+tslotcode[p,ttday];
     y:=2;
    end;
   swaproom1:=room2; swaproom2:=room1;
   if bool(numchanges) then
   begin
    for i:=1 to numchanges do
    begin
     if (Changes[i].gen<2) and (Changes[i].timeslot=p) and (Changes[i].newroom>0)
      and (Changes[i].newroom<>Changes[i].oldroom) then
     begin
      if Changes[i].oldroom=room1 then swaproom1:=Changes[i].newroom;
      if Changes[i].oldroom=room2 then swaproom2:=Changes[i].newroom;
     end;
    end;
   end;
   if swaproom1<>room2 then
    begin
     msg:='Room '+Trim(tecode[room1,1])+' swapped with room '+
      Trim(tecode[swaproom1,1])+' in time '+tslotcode[p,ttday];
     y:=1;
    end;
   if swaproom2<>room1 then
    begin
     msg:='Room '+Trim(tecode[room2,1])+' swapped with room '+
     Trim(tecode[swaproom2,1])+' in time '+tslotcode[p,ttday];
     y:=2;
    end;
  end;  {if bool(swap and (1 shl p)) then}
 if msg>'' then
 begin
  messagedlg(msg,mtError,[mbOK],0);
  case y of
   1: begin combobox6.setfocus; combobox6.selectall; end;
   2: begin combobox7.setfocus; combobox7.selectall; end;
  end;
  exit;
 end;

 for p:=1 to tlimit[ttday] do
 if (swap and (1 shl p))<>0 then
 begin
  found1:=0; found2:=0; te1:=0; sub1:=0; level1:=0; year1:=0;
  te2:=0; sub2:=0; level2:=0; year2:=0;
  notused1:=0; if (rolost[room1] and (1 shl p))=0 then notused1:=-1;
  notused2:=0; if (rolost[room2] and (1 shl p))=0 then notused2:=-1;
  for y:=0 to years_minus_1 do
  begin
   afnt:=FNT(ttday,(p-1),y,0,0);
   for L:=1 to level[y] do
   begin
    inc(afnt,4);
    sub:=afnt^; bfnt:=afnt; inc(bfnt);
    te:=bfnt^; inc(bfnt);
    ro:=bfnt^;
    if ro=room1 then
    begin
     found1:=-1; te1:=te; sub1:=sub; level1:=L; year1:=y;
    end;
    if ro=room2 then
    begin
     found2:=-1; te2:=te; sub2:=sub; level2:=L; year2:=y;
    end;
   end; {for L}
  end; {for y}
  inchange1:=0; inchange2:=0; swapstatus:=0;
  for i:=1 to numchanges do
   if Changes[i].timeslot=p then
   begin
    if Changes[i].newroom=room2 then
    begin
     Changes[i].newroom:=room1; Changes[i].needroom:=2;
     if (Changes[i].newroom=Changes[i].oldroom) then Changes[i].needroom:=0;
     if bool(roomon[room1] and (1 shl p)) then
      roomon[room2]:=roomon[room2] or (1 shl p);
     roomon[room1]:=roomon[room1] and (not(1 shl p));
     if Changes[i].oldroom=room2 then begin inchange2:=-1; swapstatus:=-1; end;
     if Changes[i].oldroom=room1 then inchange1:=-1;
    end
    else
     begin
      if Changes[i].newroom=room1 then
      begin
       Changes[i].newroom:=room2; Changes[i].needroom:=2;
       if (Changes[i].newroom=Changes[i].oldroom) then Changes[i].needroom:=0;
       if bool(roomon[room2] and (1 shl p)) then
        roomon[room1]:=roomon[room1] or (1 shl p);
        roomon[room2]:=roomon[room2] and (not(1 shl p));
        if Changes[i].oldroom=room1 then begin inchange1:=-1; swapstatus:=-1; end;
        if Changes[i].oldroom=room2 then inchange2:=-1;
      end;
     end;
    end; {i}


   if not(bool(inchange2 or (not(found2)) or notused2)) then
   begin
    inc(numchanges); a:=numchanges; Changes[a].timeslot:=p; Changes[a].year:=year2;
    Changes[a].level:=level2; Changes[a].sub:=sub2; Changes[a].oldte:=te2; Changes[a].newte:=te2;
    Changes[a].oldroom:=room2; Changes[a].newroom:=room1; Changes[a].kind:=0; Changes[a].needte:=0;
    Changes[a].needroom:=2; Changes[a].reason:=0; {inchange2:=-1;} Changes[a].gen:=0;
    swapstatus:=-1;
    if bool(roomon[room1] and (1 shl p)) then
     roomon[room2]:=roomon[room2] or (1 shl p);
    roomon[room1]:=roomon[room1] and not(1 shl p);
   end;
   if not(bool(inchange1 or (not(found1)) or notused1)) then
   begin
    inc(numchanges); a:=numchanges; Changes[a].timeslot:=p; Changes[a].year:=year1;
    Changes[a].level:=level1; Changes[a].sub:=sub1; Changes[a].oldte:=te1; Changes[a].newte:=te1;
    Changes[a].oldroom:=room1; Changes[a].newroom:=room2; Changes[a].kind:=0; Changes[a].needte:=0;
    Changes[a].needroom:=2; Changes[a].reason:=0; {inchange1:=-1;} Changes[a].gen:=0;
    swapstatus:=-1;
    if bool(roomon[room2] and (1 shl p)) then
     roomon[room1]:=roomon[room1] or (1 shl p);
    roomon[room2]:=roomon[room2] and (not(1 shl p));
   end;

   if bool(swapstatus) then
   begin
    roswap[room1]:=roswap[room1] and (not(1 shl p));
    roswap[room2]:=roswap[room2] and (not(1 shl p));
   end
   else
    begin
     roswap[room1]:=roswap[room1] or (1 shl p);
     roswap[room2]:=roswap[room2] or (1 shl p);
    end;

 end; {if (swap and (1 shl p))<>0 then}

 if bool(numchanges) then
 begin
  for a:=numchanges downto 1 do
   if ((Changes[a].gen=0) and (Changes[a].oldroom=Changes[a].newroom)) then
   begin
    roswap[Changes[a].oldroom]:=roswap[Changes[a].oldroom] or (1 shl Changes[a].timeslot);
    deleteChange(a);
   end;
 end;
 updateSwappedClassesCnt;
 label9.caption:=inttostr(roomSwapsCnt);

 UpdateExtrasWins; needupdate:=true;
 combobox6.setfocus;
 combobox6change(self);
 combobox7change(self);
end;


procedure Tedroomswaps.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if needupdate then SaveExtras;
end;

procedure Tedroomswaps.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_return then updateclick(self);
end;

procedure Tedroomswaps.ComboBox6Change(Sender: TObject);
var
 i: integer;
 swaproom1: integer;
 codeStr:  string;
 show: boolean;
begin
 codeStr:=Trim(Combobox6.text);
 myroom1:=checkCode(2,codeStr);

 if myroom1>0 then
  begin
   label5.caption:=tename[myroom1,1];
   for i:=1 to tlimit[ttday] do
    begin
     show:=((roswap[myroom1] and (1 shl i))=0);
     RoomSwapTime.ButtonShow(i,show);
     RoomSwapTime.perlab2[i].caption:=' '+romap[myroom1][i];
    end;
  end
 else
  begin
   label5.caption:='';
   for i:=1 to tlimit[ttday] do RoomSwapTime.perlab2[i].caption:='';
   exit;
  end;
 swaproom1:=0;
 if numchanges>0 then
  for i:=1 to numchanges do
  begin
   if (Changes[i].gen<2) and (Changes[i].newroom>0)
    and (Changes[i].newroom<>Changes[i].oldroom) then
   begin
    if Changes[i].oldroom=myroom1 then swaproom1:=Changes[i].newroom;
   end;
  end;
 if swaproom1>0 then combobox7.text:=tecode[swaproom1,1];

 codeStr:=Trim(Combobox7.text);
 myroom2:=checkCode(2,codeStr);

 if myroom2=0 then
 begin
  for i:=1 to tlimit[ttday] do RoomSwapTime.perlab3[i].caption:='';
  label4.caption:='';
  exit;
 end;

 label4.caption:=tename[myroom2,1];
 for i:=1 to tlimit[ttday] do
 begin
  if (roswap[myroom2] and (1 shl i))=0 then
  begin
   RoomSwapTime.button1[i].caption:='S';
   if bool(roomon[myroom2] and (1 shl i)) then RoomSwapTime.button1[i].caption:='s';
  end
   else RoomSwapTime.button1[i].caption:='';
  RoomSwapTime.perlab3[i].caption:=' '+romap[myroom2][i];
 end;

end;

procedure Tedroomswaps.ComboBox7Change(Sender: TObject);
var
 i: integer;
 codeStr:  string;
begin
 codeStr:=Trim(Combobox7.text);
 myroom2:=checkCode(2,codeStr);

 if myroom2=0 then
 begin
  for i:=1 to tlimit[ttday] do RoomSwapTime.perlab3[i].caption:='';
  label4.caption:='';
  exit;
 end;
 label4.caption:=tename[myroom2,1];
 for i:=1 to tlimit[ttday] do
 begin
  if (roswap[myroom2] and (1 shl i))=0 then
  begin
   RoomSwapTime.button1[i].caption:='S';
   if bool(roomon[myroom2] and (1 shl i)) then RoomSwapTime.button1[i].caption:='s';
  end
   else RoomSwapTime.button1[i].caption:='';
  RoomSwapTime.perlab3[i].caption:=' '+romap[myroom2][i];
 end;
end;

initialization
 myroom1:=0;
 myroom2:=0;

end.
