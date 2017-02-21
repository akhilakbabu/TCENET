unit Excover;

interface

uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Forms,
     Controls, Dialogs, Buttons, StdCtrls, ExtCtrls,TCEglobals, GlobalToTcAndTcextra;

type
  TCoverDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Label2: TLabel;
    cmbTimeSlots: TComboBox;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
  private
    procedure DoManualCover;
  end;

function GetNext(dir: integer): bool;
procedure findCoverFaculty;
procedure GetFreeStaff;
procedure GetFreeRooms;
procedure RemoveTeacherCover2;
procedure RemoveRoomCover;
Procedure AddRoomCover(ro: integer);
Procedure AddETcover(te: integer);
Procedure AddStaffCover(te: integer);
procedure DoAutoCover;
procedure ResetLoads;
procedure SetCoverVariables;
procedure TestReplace(j,alreadyOn:integer);

var
  CoverDlg: TCoverDlg;
  p,myI,Puse,freetotal,facultyIn:     integer;
  Allotmax:    double;
  DoingTeacherCover,CoverFlag:           bool;
  CanDoReplace,CanDoLieu:       boolean;
  ShouldDoReplace,ShouldDoLieu:     boolean;
  AutoKind: integer;  {selected cover kind}

implementation

uses
  tcommon, DlgCommon, tcommon2, tcommon3, mancover, main;

var
 orderuse:  array[0..nmbrperiods+1] of integer;
 orderLo,orderHi,CoverCount:   integer;
 tfree:                        tpExdata;
{$R *.DFM}

procedure TCoverDlg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

Procedure ResetLoad(te: integer);
var
 p3: integer;
begin
 teload[te]:=0;
 for p3:=1 to Tlimit[ttday] do
  if ((teabsent[te] and (1 shl p3))<>0) and ((teon[te] and (1 shl p3))=0)
   and ((tena[te] and (1 shl p3))<>0)
   then teload[te]:=teload[te]+getEallot(1,Changes[myI].year,ttday,p3);
end;

Procedure ResetLoads;
var
 j:  integer;
begin
 for j:=1 to numcodes[1] do ResetLoad(j);
end;

procedure SetCoverVariables;
var
 j,k:  integer;
begin
 orderLo:=1; orderHi:=1;
 for j:=1 to Tlimit[ttday] do
  begin
   orderuse[torder[j,ttday]]:=j;
   if torder[j,ttday]>orderHi then orderHi:=torder[j,ttday];
  end;
 if (coverstart<1) or (coverstart>Tlimit[ttday]) or (torder[coverstart,ttday]=0)
  then coverstart:=orderuse[1];
 for j:=1 to numcodes[1] do
  for k:=1 to 5 do
   if likeday[j,k]=ttday then
    if liketime[j,k]>0 then prefer[j]:=prefer[j] or (1 shl liketime[j,k]);
 Allotmax:=0;
 for j:=1 to Tlimit[ttday] do
  Allotmax:=Allotmax+getEallot(1,Changes[myI].year,ttday,j);
 ResetLoads;
 CoverFlag:=false;
end;

procedure TCoverDlg.FormCreate(Sender: TObject);
var
 tmpstr: string;

 procedure PopulateTimeSlots;
 var
   p, j: integer;
   itemStr: string;
 begin
   cmbTimeSlots.Clear;
   for j:=1 to tlimit[ttday] do
   begin
     for p:=1 to tlimit[ttday] do
     begin
       if Torder[p,dg[1,1]] = j then
       begin
         itemStr := TimeSlotName[ttday, p - 1]; // + ' - ' + IntToStr(Torder[p,dg[1,1]]);
         cmbTimeSlots.AddItem(itemStr,TObject(p));
       end;
     end;
   end;
   cmbTimeSlots.ItemIndex := 0;
 end;

begin
 SetCoverVariables;
 radiogroup1.itemindex:=autocover;
 radiogroup2.itemindex:=coverall;
 if (radiogroup1.itemindex=1) then  {only for autocover}
 begin
  tmpstr:=getAutoCoverIgnoredHint;
  label2.caption:=tmpstr;
  if Trim(tmpstr)>'' then
   OKbtn.hint:='Perform cover changes'+endline+endline+tmpstr;
 end
 else
  begin
   label2.caption:='';
   OKbtn.hint:='Perform cover changes';
  end;
 label2.update;
 OKbtn.update;

 PopulateTimeSlots;
 //edit1.text:=inttostr(coverstart);
end;

procedure TCoverDlg.RadioGroup1Click(Sender: TObject);
var
 tmpstr: string;
begin
 //edit1.enabled:=(radiogroup1.itemindex=0);
 cmbTimeSlots.Enabled := radiogroup1.itemindex=0;
 radiogroup2.enabled:=cmbTimeSlots.Enabled;//edit1.enabled;
 if (radiogroup1.itemindex=1) then  {only for autocover}
 begin
  tmpstr:=getAutoCoverIgnoredHint;
  label2.caption:=tmpstr;
  if Trim(tmpstr)>'' then
   OKbtn.hint:='Perform cover changes'+endline+endline+tmpstr;
 end
 else
  begin
   label2.caption:='';
   OKbtn.hint:='Perform cover changes';
  end;
 label2.update;
 OKbtn.update;
end;

Procedure RemoveTeacherCover2;
begin
 ConsequentNum:=0;
 RemoveTeacherCover(myI,p);
 if ConsequentNum>0 then RemoveConsequents;
end;

Procedure RemoveRoomCover;
var
 ro:      integer;
begin
 ro:=Changes[myI].newroom; Changes[myI].newroom:=0;
 roomon[ro]:=roomon[ro] or (1 shl p);
 rocover[ro]:=rocover[ro] or (1 shl p);
 Changes[myI].needroom:=1;
end;

Procedure SetIgnore;
begin
 if (Changes[myI].kind>0) and (Changes[myI].newte>0) then RemoveTeacherCover2;
 if (Changes[myI].needroom<>0) and (Changes[myI].newroom>0) then RemoveRoomCover;
 if Changes[myI].kind<10 then inc(Changes[myI].kind,10);
 ResetLoads;
end;

procedure SortFreeStaff;
var
 i,D,H,J,L:       integer;
 A,B:                 double;
label  label1,label2,label3,label4;

begin
 if freetotal<2 then exit;
 D:=1;
label1:
 inc(D,D);
 if D<freetotal then goto label1;
label4:
 D:=(D-1) div 2;
 if D=0 then goto label2;
 H:=freetotal-D;
 for i:=1 to H do
 begin
  J:=i;
label3:
  L:=J+D;
  A:=tfree[L]; B:=tfree[J];
  if A>B then
  begin
   tfree[L]:=B; tfree[J]:=A;
   swapint(tepoint[L],tepoint[J]);
   dec(J,D);
   if J>0 then goto label3;
  end;
 end; {for i}
 goto label4;
label2: {"end sort"}
end;

procedure TestReplace(j,alreadyOn:integer);
var
 teAvail1,teLieu1:          double;
begin
 teAvail1:=teavail[j];
 if (j=alreadyOn) then if (Changes[myI].kind=2) then teAvail1:=teAvail1+getEallot(1,Changes[myI].year,ttday,p);
 teLieu1:=telieudbl[j];
 if (j=alreadyOn) then if (Changes[myI].kind=3) then teLieu1:=teLieu1+getEallot(1,Changes[myI].year,ttday,p);
 CanDoReplace:=(teAvail1>0) and ((teAvail1+0.00001)>=getEallot(1,Changes[myI].year,ttday,p));
 CanDoLieu:=(teLieu1>0) and ((teLieu1+0.00001)>=getEallot(1,Changes[myI].year,ttday,p));
 ShouldDoReplace:=CanDoReplace; ShouldDoLieu:=CanDoLieu;
 if CanDoReplace and CanDoLieu then
  begin
   if WtReplace>=WtLieu then ShouldDoLieu:=false else ShouldDoReplace:=false;
  end;
end;

Procedure GetFreeStaff;
var
 j,lastDays,alreadyOn:  integer;
 perc,W1,doing1,ETtaught1,teload1:          double;
 spare,test:            boolean;
begin
 lastDays:=0;
 if WtLastNum>0 then
  for j:=0 to WtLastNum-1 do
   lastDays:=lastDays or (1 shl j);
 freetotal:=0;
 alreadyOn:=0;
 if Changes[myI].kind=1 then alreadyOn:=Changes[myI].newte;  {ET}
 if ETnum>0 then
   for j:=1 to ETnum do
    if (j=alreadyOn) or bool(ETavail[j] and Eton[j] and (1 shl p))
          and ((Ettaught[j]+getEallot(1,Changes[myI].year,ttday,p))<=Etmax[j]) then
     if copy(etsub[j],1,2)<>'00' then
      begin
       inc(freetotal); tepoint[freetotal]:=1000+j;
       ETtaught1:=Ettaught[j];
       if j=alreadyOn then ETtaught1:=ETtaught1-getEallot(1,Changes[myI].year,ttday,p);
       tfree[freetotal]:=WtET+WtFrees*(Etmax[j]-ETtaught1);
       if ETfaculty[j]=facultyIn then
        tfree[freetotal]:=tfree[freetotal]+WtETfac;
     end;
 alreadyOn:=0;
 if Changes[myI].kind<>1 then alreadyOn:=Changes[myI].newte;  {not ET}
 for j:=1 to numcodes[1] do
  begin
   test:=((Emax[j]>=(Etaken[j]+doingextra[j]+getEallot(1,Changes[myI].year,ttday,p))) or ((telieudbl[j]>0) and
    ((telieudbl[j]+0.0001)>=getEallot(1,Changes[myI].year,ttday,p))) or ((teavail[j]>0) and
    ((teavail[j]+0.0001)>=getEallot(1,Changes[myI].year,ttday,p))) ) and ((teon[j] and (1 shl p)
    and (teabsent[j] and tena[j])<>0) );

   if ((not(test)) and (j<>alreadyOn)) or (copy(tecode[j,0],1,2)='00')
      or ((Changes[myI].gen=3) and (j=Changes[myI].oldte)) then continue;
   inc(freetotal); tepoint[freetotal]:=j;
   if Emax[j]>0.1 then perc:=WtPerc*(Emax[j]-Etaken[j])/Emax[j]
    else perc:=0;
   teload1:=teload[j];
   if (j=alreadyOn) then teload1:=teload1-getEallot(1,Changes[myI].year,ttday,p);
   if teload1<0 then teload1:=0;

   tfree[freetotal]:=WtFrees*(allotmax-teload1)+WtAvail*(Emax[j]-
     Etaken[j])+WtWeek*Eweek[j]+perc;

   TestReplace(j,alreadyOn);
   if ShouldDoReplace then tfree[freetotal]:=WtReplace;
   if ShouldDoLieu then tfree[freetotal]:=WtLieu;

   doing1:=doingextra[j];
   if (j=alreadyOn) then if (Changes[myI].kind=4) then doing1:=doing1-getEallot(1,Changes[myI].year,ttday,p);

   W1:=WtToday*doing1;
   if (prefer[j] and (1 shl p))<>0 then W1:=W1+WtPrefer;
   if (Eten[j] and lastDays)<>0 then W1:=W1+WtLast;
   if (facultyIn>0) and ((Tfaculty[j,1]=facultyIn) or (Tfaculty[j,2]=facultyIn)
     or (Tfaculty[j,3]=facultyIn)  or (Tfaculty[j,4]=facultyIn) )
      then W1:=W1+Wtfac;
   spare:=false;
   if Puse>1 then if ((teon[j] and teabsent[j] and (1 shl (orderUse[Puse-1])))<>0) then
    spare:=true;
   if Puse<orderHi then if ((teon[j] and teabsent[j] and (1 shl orderUse[Puse+1]))<>0)
     then spare:=true;
   if spare then W1:=W1+WtSpare;
   tfree[freetotal]:=tfree[freetotal]+W1;
  end; {for j}
 SortFreeStaff;
end;

procedure FindCoverFaculty;
var
 j,k,sub:  integer;
 found:    bool;
begin
 facultyIn:=0;  found:=false;
 if Facnum=0 then exit;
 for j:=1 to Facnum do
  begin
  for k:=1 to facCount[j] do
   begin
   sub:=Facsubs[j,k];
   if sub<0 then
    begin
     if copy(SubCode[abs(sub)],1,lencodes[0]-1)=copy(SubCode[Changes[myI].sub],1,lencodes[0]-1)
      then begin facultyIn:=j; found:=true; break; end;
    end
   else
    if sub=Changes[myI].sub then begin facultyIn:=j; found:=true; break; end;
   end; {k}
   if found then break;
  end; {j}
end;

Procedure AddStaffCover(te: integer);
var
 alreadyOn:  integer;

  Procedure ReplacementCover;
  begin
   teavail[te]:=teavail[te]-getEallot(1,Changes[myI].year,ttday,p);
   tereplace[te]:=tereplace[te] and (not(1 shl p));
   if teavail[te]<0 then teavail[te]:=0;
   Changes[myI].kind:=2;
  end;

  Procedure InLieuCover;
  begin
   telieudbl[te]:=telieudbl[te]-getEallot(1,Changes[myI].year,ttday,p);
   telieu[te]:=telieu[te] and (not(1 shl p));
   if telieudbl[te]<0 then telieudbl[te]:=0;
   Changes[myI].kind:=3;
  end;

begin
 if autocover=1 then
  begin
   alreadyOn:=0;
   if Changes[myI].kind<>1 then alreadyOn:=Changes[myI].newte;
   TestReplace(te,alreadyOn);
   autokind:=4;
   if ShouldDoReplace then autokind:=2;
   if ShouldDoLieu then autokind:=3;
  end;

 if autokind=0 then exit;
 teon[te]:=teon[te] and (not(1 shl p)); Changes[myI].newte:=te;
 case autokind of
  2: ReplacementCover;
  3: InLieuCover;
  4: begin
      doingextra[te]:=doingextra[te]+getEallot(1,Changes[myI].year,ttday,p);
      tecover[te]:=tecover[te] and (not(1 shl p));
      Changes[myI].kind:=4;
     end;
  5: // Merge #75 - added this whole section for case 5
     // This will keep the status 'Shared' but i dont think it keeps all the relevant history
     begin
       tecover[te]:=tecover[te] and (not(1 shl p));
       Changes[myI].kind := 5;
     end;
 end; {case}
end;

Procedure AddETcover(te: integer);
begin
 Changes[myI].newte:=te;
 Ettaught[te]:=Ettaught[te]+getEallot(1,Changes[myI].year,ttday,p);
 Eton[te]:=Eton[te] and (not(1 shl p));
 Changes[myI].kind:=1;
end;

Procedure AddTeacherCover(replacete: integer);
var
 te:  integer;
begin
 te:=tepoint[replacete];
 if te>1000 then AddETcover(te-1000) else AddStaffCover(te);
 Changes[myI].needte:=0;
end;

Procedure AutoTeacherCover(i: smallint);
begin
 if Changes[i].newte<>0 then exit;
 if not(coverYear[Changes[i].year]) then
  begin
   SetIgnore;
   exit;
  end;
 findCoverFaculty;
 GetFreeStaff;
 if freetotal=0 then exit;
 inc(Covercount);
 if Changes[i].newte>0 then RemoveTeacherCover2;
 AddTeacherCover(1);
 ResetLoads;
 updateteacherMap;
 CoverFlag:=true;
end;

Procedure GetFreeRooms;
var
 j,k,alreadyOn:  integer;
begin
 freetotal:=0;
 alreadyOn:=0;
 if (Changes[myI].newroom>0) then alreadyOn:=Changes[myI].newroom;
 for j:=1 to codenum[2] do
  begin
   k:=codepoint[j,2];
   if (k=alreadyOn) or ((roomon[k] and roabsent[k] and (1 shl p))<>0) then
    begin
     inc(freetotal);tepoint[freetotal]:=k;
    end;
  end;
end;

Procedure AddRoomCover(ro: integer);
begin
 Changes[myI].newroom:=ro;
 if ro>0 then Changes[myI].needroom:=2 else Changes[myI].needroom:=1;
 roomon[ro]:=roomon[ro] and (not(1 shl p));
 rocover[ro]:=rocover[ro] and (not(1 shl p));
end;

Procedure AutoRoomCover(i:smallint);
begin
 if Changes[i].newroom>0 then exit;
 if not(coverYear[Changes[i].year]) then
  begin
   SetIgnore;
   exit;
  end;
 GetFreeRooms;
 if freetotal=0 then exit;
 inc(Covercount);
 if Changes[i].newroom>0 then RemoveRoomCover;
 AddRoomCover(tepoint[1]);
 CoverFlag:=true;
end;

procedure DoAutoCover;
var
 i,j: smallint;
begin
 screen.cursor:=crHourglass;

 if not(ToolBarAuto) then
 begin
  CoverDlg.label2.caption:='Covering changes...';   CoverDlg.label2.update;
 end;
 Covercount:=0;
 for j:=orderLo to orderHi do
  begin
   Puse:=j;
   p:=orderUse[Puse];
   for i:=1 to numchanges do
    begin
     myI:=i;
     if (Changes[myI].timeslot<>p) or (Changes[myI].gen=4) or (Changes[myI].kind>=10) then continue;
     if Changes[myI].needte<>0 then AutoTeacherCover(myI);
     if Changes[myI].needroom=1 then AutoRoomCover(myI);
    end;
  end;

 if Coverflag then
  begin
   UpdateExtrasWins;
   SaveExtras;
   Coverflag:=false;
  end;
 if not(ToolBarAuto) then
  begin
   CoverDlg.label2.caption:='Changes covered: '+inttostr(CoverCount);
   CoverDlg.label2.update;
  end;
 screen.cursor:=crDefault;
end;

function GetNext(dir: integer): bool;
var
  CoverEvery,found: bool;
  oldP: integer;
begin
  found := False;
  oldP := p;
  CoverEvery := (coverall=1) and (autocover=0);
  if (dir=1) and (myI>0) and DoingTeacherCover then
    if (CoverEvery and (Changes[myI].needroom<>0)) or (Changes[myI].needroom=1) then
    begin  {step to room change}
      DoingTeacherCover := False;
      Result := True;
      Exit;
    end;
  if (dir=-1) and (myI>0) and not(DoingTeacherCover) then
    if (CoverEvery and (Changes[myI].gen>0) and (Changes[myI].kind<>10)) or (Changes[myI].needte<>0) then
    begin {step to teacher change}
      DoingTeacherCover:=true;
      Result := True;
      Exit;
    end;
  repeat
    myI := myI + dir;
    if dir = 1 then if myI > numchanges then
    begin
      Inc(Puse);
      p := orderUse[Puse];
      myI := 1;
    end;
    if dir=-1 then if myI<1 then
    begin
      myI := numchanges;
      dec(Puse);
      p := orderUse[Puse];
    end;
    if (Puse < orderLo) or (Puse > orderHi) then
      Break;
    if (Changes[myI].timeslot <> p) or (Changes[myI].gen = 4) then
      Continue;
    if (CoverEvery = false) and (Changes[myI].needte = 0) and (Changes[myI].needroom <> 1) then
      Continue;
    if (CoverEvery=false) and (Changes[myI].kind>=10) then
      Continue;
    if (dir=1) then
    begin
      if (CoverEvery and (Changes[myI].gen>0) and (Changes[myI].kind<>10)) or (Changes[myI].needte<>0) then
      begin  {GetTeacherCover;}
        found := true;
        DoingTeacherCover := true;
        Break;
       end;
      if (CoverEvery and (Changes[myI].needroom<>0)) or (Changes[myI].needroom=1) then
      begin  {GetRoomCover;}
        found := True;
        DoingTeacherCover := False;
        Break;
      end;
    end;
    if (dir = -1) then
    begin
      if (CoverEvery and (Changes[myI].needroom<>0)) or (Changes[myI].needroom=1) then
      begin  {GetRoomCover;}
        found:=true;
        DoingTeacherCover:=false;
        break;
      end;
      if (CoverEvery and (Changes[myI].gen>0) and (Changes[myI].kind<>10)) or (Changes[myI].needte<>0) then
      begin  {GetTeacherCover;}
        found:=true;
        DoingTeacherCover:=true;
        break;
      end;
    end;
  until found or (Puse < orderlo) or (Puse > orderHi);
  if not(found) then
    p := OldP;
  Result := found;
end;

procedure TCoverDlg.DoManualCover;
begin
 p:=coverstart; myI:=0; Puse:=torder[coverstart,ttday];
 if not(GetNext(1)) then
  begin
   messagedlg('No changes to cover',mtError,[mbOK],0);
   exit;
  end;
 Self.Hide;
 ManCoverdlg:=TManCoverdlg.create(CoverDlg);  {allocate dlg}
 ManCoverdlg.showmodal;
 ManCoverdlg.free;   {release dlg}
end;

procedure TCoverDlg.OKBtnClick(Sender: TObject);
var
  a: Integer;
  msg: string;
begin
  msg := '';
  Label2.Caption := '';
  Label2.Update;
  //a := StrToIntDef(Edit1.Text, 0);
  a := Integer(cmbTimeSlots.Items.Objects[cmbTimeSlots.ItemIndex]);
  if (a < 1) or (a > Tlimit[ttday]) then
    msg := 'Check time slot'
  else if torder[a,ttday]=0 then
    msg := 'Not in time slot order';
  if (msg > '') and (RadioGroup1.ItemIndex = 0) then
  begin
    MessageDlg(msg, mtError, [mbOK], 0);
    cmbTimeSlots.SetFocus;
    Exit;
  end;

  coverstart := a;
  autocover := RadioGroup1.ItemIndex;
  coverall := RadioGroup2.ItemIndex;
  if autocover=1 then DoAutoCover else DoManualCover;
  Close;
end;

procedure TCoverDlg.FormActivate(Sender: TObject);
begin
 //edit1.enabled:=(radiogroup1.itemindex=0);
 cmbTimeSlots.enabled:=(radiogroup1.itemindex=0);
 if (ExcoverTop>=0) and ((ExcoverTop+Height)<=screen.Height) then
     Top:=ExcoverTop;
 if (ExcoverLeft>=0) and ((ExcoverLeft+Width)<=screen.Width) then
     Left:=ExcoverLeft;

end;

procedure TCoverDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ExcoverTop:=top;
  ExcoverLeft:=Left;
  UpdateWindow(wnCurrentExtras);
end;

procedure TCoverDlg.FormDeactivate(Sender: TObject);
begin
 ExcoverTop:=top;
 ExcoverLeft:=Left;
end;

end.
