unit Edlstcls;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Buttons, StdCtrls, ExtCtrls,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TEdLostClasses = class(TForm)
    Label8: TLabel;
    Label9: TLabel;
    grbChangeLostClasses: TGroupBox;
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
    Label10: TLabel;
    Label11: TLabel;
    ComboBox1: TComboBox;
    cboSubject: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    rgpLostClassBy: TRadioGroup;
    CheckBox1: TCheckBox;
    ComboBox6: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure rgpLostClassByClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure cboSubjectChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox4KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox5KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox6Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FSelectedTeCode: Integer;
    FIsDirect: Boolean;
    procedure UpdateControls;
    procedure SetMyControls;
    procedure GetControlValues;
    procedure updateMyMaps;
    procedure Edlost;
    procedure SetDefaultPeriod;
  public
    property SelectedTeCode: Integer read FSelectedTeCode write FSelectedTeCode;
    property IsDirect: Boolean read FIsDirect write FIsDirect;
  end;

var
  EdLostClasses: TEdLostClasses;

implementation

uses
  tcommon,DlgCommon,tcommon2,lostclss,tcommon3;

{$R *.DFM}

var
  LostTime:    TTimeSet;
  needupdate:        boolean;
  oldyear:           integer;
  myte:              integer;
  subfound:          bool;
  Lost:              integer;
  L1,L2:             smallint;
  ro,subplace:       integer;
  msg: string;
  roplace,teplace,smap:                   integer;
  loading:                                boolean;

procedure TEdLostClasses.GetControlValues;
var
 t:       string;
begin
 edLostClassBy := rgpLostClassBy.itemindex;
 if combobox1.enabled then edLostClassyear:=findyear(combobox1.text);
 if combobox3.enabled then  {class}
  begin
   edLostClassClass:=findClass2(combobox3.text);
   if (edLostClassyear>=0) and (edLostClassyear<years) then
    begin
     if (edLostClassClass=0) or (combobox3.text='Whole year') then
       begin
        L1:=1; combobox4.text:='1';
        L2:=level[edLostClassyear]; combobox5.text:=inttostr(L2);
       end
       else
        begin
         L1:=GetLevelttClass(edLostClassyear,edLostClassClass); L2:=L1;
         combobox4.text:=inttostr(L1);
         combobox5.text:=inttostr(L2);
        end;
     end;
  end;
 edLostClassLevfrom:=strtointdef(combobox4.text,1); L1:=edLostClassLevfrom;
 edLostClassLevto:=strtointdef(combobox5.text,1); l2:= edLostClassLevto;
 if cboSubject.Enabled then
  begin
   t := cboSubject.Text;
   edLostClassSub:=checkwildcode(t,label9,false);
  end;
end;

procedure makeroomfree(p,ro: integer);
var
 y,l:  integer;
 afnt,bfnt:      tpintpoint;
 ttroomsharecount: integer;

begin
 // Add in a check here for the room shares / exit if shared
  ttroomsharecount := 0;
  for y:=0 to years_minus_1 do
  begin
   afnt:=FNT(ttday,p-1,y,0,4);
   for l:=1 to level[y] do
    begin
     inc(afnt,4); //bfnt:=afnt;
     if ro=afnt^ then
      begin
       //dec(bfnt); ttsub:=bfnt^;
       //inc(bfnt,2); ttroom:=bfnt^;
       ttshare:=FNTbyte(ttday,p-1,y,l,6)^ and 2;
       //ttyear:=y; ttlevel:=l; ttfound:=true;
       if bool(ttshare) then inc(ttroomsharecount);
      end;
    end; {l}
  end; {y}
  if (ttroomsharecount > 0) then exit;
  
 if bool(ro) then  {Make avail if teaching, not covering and not swapped}
  begin
   if bool((not(roomteach[ro])) and rocover[ro] and
     roswap[ro] and (1 shl p)) then
       roomon[ro]:=roomon[ro] or (1 shl p);
   //TODO : Need to check for Shares ?
   // didnt seem to make any difference
   //if tsharecount < 1 then
   //begin
     rolost[ro]:=rolost[ro] and (not(1 shl p));
   //end;
  end;
end;

procedure checkRestoreSwap(p: integer);
var
 swapchange,swaproom,swappos,i,a: integer;
begin
 swaproom:=0;
 if numchanges=0 then
  begin roswap[roplace]:=roswap[roplace] or (1 shl p); exit; end;
 swapchange:=0; swappos:=0;
 for i:=1 to numchanges do
  begin
   if (Changes[i].gen<2) and (Changes[i].timeslot=p) and (Changes[i].newroom=roplace)
    and (Changes[i].oldroom<>roplace) then
     begin swaproom:=Changes[i].oldroom; swapchange:=i; end;
   if (Changes[i].oldroom=roplace) and (Changes[i].gen<2) and (Changes[i].timeslot=p)
     and ((Changes[i].newroom=roplace) or (Changes[i].newroom=0)) then swappos:=i;
  end;
 if swapchange=0 then
  begin roswap[roplace]:=roswap[roplace] or (1 shl p); exit; end;
 if bool(swappos) then
  begin
   a:=swappos; Changes[a].newroom:=swaproom; Changes[a].needroom:=2;
  end
 else
  begin
   inc(numchanges); a:=numchanges;
   Changes[a].timeslot:=p; Changes[a].year:=ttyear; Changes[a].level:=ttlevel; Changes[a].sub:=ttsub;
   Changes[a].oldte:=place; Changes[a].newte:=place; Changes[a].oldroom:=roplace; Changes[a].newroom:=swaproom;
   Changes[a].kind:=0; Changes[a].needte:=0; Changes[a].needroom:=2; Changes[a].notes:=0;
   Changes[a].reason:=0; Changes[a].gen:=0;
  end;
 roomon[swaproom]:=roomon[swaproom] and (not(1 shl p));
 roswap[swaproom]:=roswap[swaproom] and (not(1 shl p));
end;

procedure checkremoveswap(p,roplace: integer);
var
 i,a,swapfound,swaproom: integer;
begin
 if numchanges=0 then exit;
 swapfound:=0;  swaproom:=0;
 for i:=1 to numchanges do
  if (Changes[i].gen=0) and (Changes[i].timeslot=p) and (Changes[i].oldroom=roplace) then
   begin
    swapfound:=i; swaproom:=Changes[i].newroom; break;
   end;
 if swapfound=0 then
  begin
   roswap[roplace]:=roswap[roplace] or (1 shl p);
   exit;
  end;
 a:=swapfound;
 deletechange(a);
 if numchanges=0 then
  begin
   roswap[roplace]:=roswap[roplace] or (1 shl p);
   roswap[swaproom]:=roswap[swaproom] or (1 shl p);
   exit;
  end;
 swapfound:=0;
 for i:=1 to numchanges do
  if (Changes[i].gen=0) and (Changes[i].timeslot=p) and (Changes[i].oldroom=swaproom) and
   (Changes[i].newroom=roplace) then
     begin
      swapfound:=i;
      break;
     end;
 if swapfound=0 then
  begin
   roswap[roplace]:=roswap[roplace] or (1 shl p);
   roswap[swaproom]:=roswap[swaproom] or (1 shl p);
   exit;
  end;
end;

procedure clearclasseslost(p: integer);
var
 aon,i: integer;
begin
 if bool(((teach[place] or telost[place]) and (1 shl p)))
    or ((tena[place] and (1 shl p))=0) then exit;
 if bool(teon[place] and (not(teach[place]))
   and (not(teabsent[place])) and tena[place] and (1 shl p)) then
     addabsent(place,p);
 aon:=teon[place] and (1 shl p);
 ro:=0; roplace:=0;
 if bool(aon) then
  begin
   getttsub(place,p);
   roplace:=ttroom;
   if bool(ttfound) then teon[place]:=teon[place] and not(1 shl p)
     else teon[place]:=teon[place] or (1 shl p);
   if bool(roplace) then
    begin
     teplace:=place; place:=roplace;
     if bool(roomon[place] and (not(roomteach[place])) and
      (not(roabsent[place])) and (1 shl p)) then addAbsentRoom(p,place);
     place:=teplace;  ro:=roplace;
     rolost[ro]:=rolost[ro] or (1 shl p);
     roomon[ro]:=roomon[ro] and (not(1 shl p));
     if (roswap[roplace] and (1 shl p))=0 then checkRestoreSwap(p);
    end;
  end;
 for i:=1 to numchanges do
  begin
   if (Changes[i].gen=4) or (Changes[i].timeslot<>p) then continue;
   if Changes[i].newte=place then
    begin
     if Changes[i].kind=2 then
      begin Changes[i].newte:=0; Changes[i].needte:=-1; teon[place]:=teon[place] or (1 shl p);
       tereplace[place]:=tereplace[place] or (1 shl p);
      end;
     if Changes[i].kind=3 then
      begin
       Changes[i].newte:=0; Changes[i].needte:=-1; teon[place]:=teon[place] or (1 shl p);
       telieu[place]:=telieu[place] or (1 shl p);
       telieudbl[place]:=telieudbl[place]+getEallot(1,Changes[i].year,ttday,p);
      end;
     if Changes[i].kind=4 then
      begin
       Changes[i].newte:=0; Changes[i].needte:=-1; teon[place]:=teon[place] or (1 shl p);
       tecover[place]:=tecover[place] or (1 shl p);
       doingextra[place]:=doingextra[place]-getEallot(1,Changes[i].year,ttday,p);
       if doingextra[place]<0 then doingextra[place]:=0;
      end;
     if bool(ro) then if (((rocover[ro] and (1 shl p))=0) and ((Changes[i].newroom=ro)
      and (Changes[i].needroom=2))) then
      begin
       Changes[i].needroom:=1; Changes[i].newroom:=0; rocover[ro]:=rocover[ro] or (1 shl p);
      end;
    end;  {if Changes[i].newte=place}
  end; {for i}
end;

procedure addtoclasseslost(p: integer);
var
 a,a4,a5:    integer;
begin
 if ((tena[place] and telost[place] and (1 shl p))=0) or
   bool(teach[place] and (1 shl p)) then exit;
 getttsub(place,p);
 roplace:=ttroom; ro:=roplace;
 a4:=(not(teon[place]) and (1 shl p) and (teabsent[place]));
 a5:=(not(roomon[roplace]) and (1 shl p) and (roabsent[roplace]));
 a:=(not(teon[place]) and (1 shl p) and (not(teabsent[place])));
 if bool(a) then
  begin
   removeabsent(place,p);
   teon[place]:=teon[place] or (1 shl p);
  end;
 teplace:=place; place:=roplace;
 if place>0 then
  begin
   a:=(not(roomon[place])) and (1 shl p) and (not(roabsent[place]));
   if bool(a) then
    begin
     removeAbsentroom(p,place);
     roomon[place]:=roomon[place] or (1 shl p);
    end;
  end;

 place:=teplace; ro:=roplace;
 if bool(a4) then teon[place]:=teon[place] or (1 shl p);
 if bool(a5) then makeroomfree(p,roplace);
 if ((roswap[roplace]) and (1 shl p))=0 then checkremoveswap(p,roplace);
end;

procedure checkshare(p,place: integer);
begin
 getTTsub(place,p);
 if tsharecount<1 then exit;     //#378 This was set to 2 but the share checking now works with it set to 1
                                 //     I had only set one share - the matching entry should also be set to shared
                                 //     Hence the count of 2 - Incorrect - only works with it set to 1

                                 // Add another test for shared rooms only (but we have passed a teacher - not a room)
 if (lost and (1 shl p))=0 then
  begin
   lost:=lost or (1 shl p);
   msg:='Time '+tslotcode[p,ttday]+' not lost as '+tecode[place,0]+'''s class is shared.';
   messagedlg(msg,mtError,[mbOK],0);
  end;
end;

procedure checkcombine(p,place:integer);
var
 i: integer;
begin
 if shareExclude then checkshare(p,place);
 if numchanges=0 then exit;
 for i:=1 to numchanges do
  begin
   if ((Changes[i].gen=3) and (Changes[i].newte=place) and (Changes[i].kind=5) and (Changes[i].timeslot=p)) then
    if (lost and (1 shl p))=0 then
     begin
      lost:=lost or (1 shl p);
      msg:='Time '+tslotcode[p,ttday]+' not lost as '+tecode[Changes[i].oldte,0]+'''s class combined.';
      messagedlg(msg,mtError,[mbOK],0);
     end;
   if ((Changes[i].gen=3) and (Changes[i].oldte=place) and (Changes[i].kind=5) and (Changes[i].timeslot=p)) then
    if bool(lost and (1 shl p)) then
     begin
      lost:=lost and (not(1 shl p));
      msg:='Time '+tslotcode[p,ttday]+' remains lost as '+tecode[Changes[i].oldte,0]+'''s class combined.';
      messagedlg(msg,mtError,[mbOK],0);
     end;
  end; {for i}
end;

procedure checksubject(aFnt: tpintpoint);
var
 sub:       integer;
 t: string;
begin
 if subplace=0 then begin subfound:=true; exit; end;
 sub:=afnt^; subfound:=false;
 if (sub=0) or (sub>numcodes[0]) then exit;
 if sub=subplace then subfound:=true;
 if subplace<0 then t := edlostclasses.cboSubject.Text;
 if (uppercase(copy(SubCode[sub],1,lencodes[0]-1))
      =uppercase(copy(t,1,lencodes[0]-1))) then subfound:=true;
end;

procedure checklost(y: integer);
var
 afnt: tpintpoint;
 y1,p,l3,gotperiod:     integer;
begin
 lost:=0; smap:=0;
 y1:=y;
 for p:=1 to tlimit[ttday] do
  begin
   gotperiod:=0;
   for l3:=l1 to l2 do
    begin
     afnt:=fnt(ttday,p-1,y1,l3,0);
     checksubject(afnt); if subfound then smap:=smap or (1 shl p);
     inc(afnt);
     place:=afnt^;
     if subfound and bool(place) then
      begin
       lost:=lost or (telost[place] and (1 shl p));
       gotperiod:=-1;
      end;
    end;
   if gotperiod=0 then lost:=lost or (1 shl p);
  end;
end;

 procedure classtimes(y: integer);
var
 i,lost1,y1,p,l3:   integer;
 afnt: tpintpoint;
begin
 if ((y<0) or (y>years_minus_1)) then exit;
 lost:=-1;
 for i:=1 to tlimit[ttday] do
  if LostTime.button1[i].caption='L' then lost:=lost and (not(1 shl i))
   else lost:=lost or (1 shl i);
 lost1:=lost; y1:=y;
 for p:=1 to tlimit[ttday] do
  for l3:=l1 to l2 do
   begin
    afnt:=FNT(ttday,p-1,y1,L3,0);
    lost:=lost1;
    checksubject(aFnt); inc(afnt);
    place:=afnt^;
    if (place=0) or (subfound=false) then continue;
    checkcombine(p,place);
    if (lost and (1 shl p))=0 then addtoclasseslost(p)
     else clearclasseslost(p);
    if bool(lost and (1 shl p)) then telost[place]:=telost[place] or (1 shl p)
     else telost[place]:=telost[place] and (not(1 shl p));
    resetavail(place);
   end;
 updateteachermap;
end;

procedure TEdLostClasses.updateMyMaps;
var
 i,j:integer;
 codestr: string;

 procedure ClearLostMap;
 var
  i: integer;
 begin
  for i:=1 to tlimit[ttDay] do
   begin
    LostTime.perlab2[i].caption:=' ';
    LostTime.button1[i].caption:='';
   end;
 end;

begin
 if loading then exit;
 GetControlValues;
 case edLostClassBy of
  0: begin   {teacher}
      codeStr:=Trim(ComboBox6.text);
      myte:=checkCode(1,codeStr);
      if myte>0 then
      begin
       label5.caption:=tename[myte,0];
        for i:=1 to tlimit[ttDay] do
        begin
         LostTime.perlab2[i].caption:=' '+temap[myte][i];
         IF bool(telost[myte] AND (1 shl i)) THEN
          LostTime.button1[i].caption:=''
         else
          LostTime.button1[i].caption:='L';
        end;
      end
       else
        begin
         label5.caption:='';
         ClearLostMap;
        end;
     end; {case 1}
  1,2,3: begin
     if (edLostClassyear<>-1) then
      if (L1>0) and (L1<=level[edLostClassyear]) and (L2>0) and (L2<=level[edLostClassyear]) then
       begin
        subplace:=0;
        if edLostClassBy=3 then subplace:=edLostClassSub;
        checklost(edLostClassyear);
        for j:=1 to tlimit[ttday] do
         if bool(lost and (1 shl j)) then LostTime.perlab2[j].caption:=' -'
          else LostTime.perlab2[j].caption:=' L';
        for j:=1 to tlimit[ttday] do
         if bool(lost and (1 shl j)) then LostTime.button1[j].caption:=''
          else LostTime.button1[j].caption:='L';
       end
      else ClearLostMap;
     end; {case 1,2,3}
  end; {case}
 EdLostClasses.repaint;
end;

procedure TEdLostClasses.SetDefaultPeriod;
var
  p, l3: Integer;
  lSub: Integer;
  lSubCode: string;
  lYear: Integer;
begin
  grbChangeLostClasses.Hint := '';
  if rgpLostClassBy.ItemIndex = 3 then
  begin
    if (cboSubject.Text <> '') and (ComboBox1.Text <> '') and (ComboBox4.Text <> '') and (ComboBox5.Text <> '')then
    begin
      for lYear :=0 to years_minus_1 do
      begin
        if Trim(YearName[lYear]) = Trim(ComboBox1.Text) then
        begin
          lSubCode := cboSubject.Text;
          lSub := CheckWildSub(lSubCode);
          for p := 1 to tlimit[ttday] do
          begin
            for l3 := l1 to l2 do
            begin
              if (l3 >= StrToInt(ComboBox4.Text)) and (l3 <= StrToInt(ComboBox5.Text)) then
                if lSub = fnt(ttDay, p-1, lYear, l3, 0)^ then
                begin
                  grbChangeLostClasses.Hint := 'Suggested lost time slot is ' + tslotcode[p,ttday];
                  //LostTime.button1[p].Caption := LostTime.ButtonChar;
                  Exit;
                end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TEdLostClasses.SetMyControls;
begin
 if loading then exit;
 case rgpLostClassBy.itemindex of
  0: begin  {teacher}
      combobox6.enabled:=true;   combobox6.color:=clRelevantControlOnDlg;
      combobox1.enabled:=false;  combobox1.color:=clwindow;
      cboSubject.enabled:=false;  cboSubject.color:=clwindow;
      combobox3.enabled:=false;  combobox3.color:=clwindow;
      combobox4.enabled:=false;  combobox4.color:=clwindow;
      combobox5.enabled:=false;  combobox5.color:=clwindow;
     end;
  1: begin  {year and class}
      combobox6.enabled:=false;  combobox6.color:=clwindow;
      combobox1.enabled:=true;   combobox1.color:=clRelevantControlOnDlg;
      cboSubject.enabled:=false;  cboSubject.color:=clwindow;
      combobox3.enabled:=true;   combobox3.color:=clRelevantControlOnDlg;
      combobox4.enabled:=false;  combobox4.color:=clwindow;
      combobox5.enabled:=false;  combobox5.color:=clwindow;
     end;
  2: begin  {year and level}
      combobox6.enabled:=false;  combobox6.color:=clwindow;
      combobox1.enabled:=true;   combobox1.color:=clRelevantControlOnDlg;
      cboSubject.enabled:=false;  cboSubject.color:=clwindow;
      combobox3.enabled:=false;  combobox3.color:=clwindow;
      combobox4.enabled:=true;  combobox4.color:=clRelevantControlOnDlg;
      combobox5.enabled:=true;  combobox5.color:=clRelevantControlOnDlg;
     end;
  3: begin
      combobox6.enabled:=false;  combobox6.color:=clwindow;
      combobox1.enabled:=true;   combobox1.color:=clRelevantControlOnDlg;
      cboSubject.enabled:=true;   cboSubject.color:=clRelevantControlOnDlg;
      combobox3.enabled:=false;  combobox3.color:=clwindow;
      combobox4.enabled:=true;   combobox4.color:=clRelevantControlOnDlg;
       combobox5.enabled:=true;  combobox5.color:=clRelevantControlOnDlg;
     end
 end; {case}
end;

procedure TEdLostClasses.FormCreate(Sender: TObject);
var
 i: Integer;
begin
 loading:=true;
 checkbox1.checked:=shareExclude;
 oldyear:=-99;
 combobox6.maxlength:=lencodes[1];
 combobox1.maxlength:=szYearname;
 cboSubject.maxlength:=lencodes[0];
 combobox3.maxlength:=szClassName;
 label5.caption:='';
 needupdate:=false;
 updatelostclassesCount;
 label9.caption:=inttostr(lostclasses);
 combobox6.clear;
 for i:=1 to codenum[1] do
  combobox6.items.add(tecode[codepoint[i,1],0]);

 cboSubject.clear;
 for i:=1 to codenum[0] do
  cboSubject.items.add(SubCode[codepoint[i,0]]);
 combobox1.clear;
 for i:=0 to years-1 do combobox1.items.add(yearname[i]);
 combobox3.clear; combobox4.clear; combobox5.clear;

 LostTime := TTimeSet.create(grbChangeLostClasses);
 With LostTime do
  begin
   ButtonChar:='L';
   LostTime.Left:=10;
   LostTime.Top:=220;
   ButtonHint:='Toggles lost class for time slot';
   BaseGroup := grbChangeLostClasses;
   makebuttons;
  end;
end;

procedure TEdLostClasses.rgpLostClassByClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TEdLostClasses.ComboBox1Change(Sender: TObject);
var
 i,j :integer;
begin
 j:=findyear(combobox1.text);
 if j=oldyear then
 begin
  updateMyMaps;
  exit;
 end;
 oldyear:=j;
 combobox3.clear;
 combobox3.items.add('Whole year');
 combobox4.clear; combobox5.clear;
 if j>=0 then
 begin
  for i:=1 to level[j] do
   if ClassShown[i,j]>0 then
     combobox3.items.add(ClassCode[ClassShown[i,j]]);
  combobox3.itemindex:=0;

  for i:=1 to level[j] do
  begin
   combobox4.items.add(inttostr(i));
   combobox5.items.add(inttostr(i));
  end;
  combobox4.itemindex:=0;
  combobox5.itemindex:=combobox5.items.count-1;
  updateMyMaps;
  SetDefaultPeriod;
 end;

end;

procedure TEdLostClasses.Edlost;

   procedure enterlostclass;
   var
    p:  integer;
   begin
    lost:=-1;
    place:=myte;

    for p:=1 to tlimit[ttday] do
    begin
     if (LostTime.button1[p].caption='L') then lost:=(lost and (not(1 shl p)))
      else lost:=(lost or (1 shl p));
    end;
    for p:=1 to tlimit[ttday] do
    begin
     checkcombine(p,place);
     if (lost and (1 shl p))=0 then addtoclasseslost(p)
      else clearclasseslost(p);
    end;
    //AJG Does this check to see if the teacher has a shared class?
    telost[place]:=lost;
    updateteacherMap; resetavail(place);
    sortLCCodes;
    UpdateExtrasWins; needupdate:=true;
   end;

  procedure lostbyclass;
  var
   a,msg:  string;
   j:integer;
  begin
   if edLostClassYear=-1 then
    begin
      msg:='Check '+yeartitle;
      messagedlg(msg,mtError,[mbOK],0);
      combobox1.setfocus;
      exit;
    end;
   a:=Trim(Combobox3.text);
   if (a<>'') and (a<>'Whole year') and (edLostClassClass=0) then
    begin
     msg:='Check Class';
     messagedlg(msg,mtError,[mbOK],0);
     combobox3.setfocus;
     exit;
    end;

   msg:=''; j:=0;
   if edLostClassClass=0 then
    begin
     if (edLostClassLevfrom<1) or (edLostClassLevfrom>level[edLostClassYear])
      then j:=4;
     if (edLostClassLevto<1) or (edLostClassLevto>level[edLostClassYear])
      then j:=5;
     msg:='Check Level';
     if j>0 then
      begin
       messagedlg(msg,mtError,[mbOK],0);
       case j of
        4: combobox4.setfocus;
        5: combobox5.setfocus;
       end;
       exit;
      end;
    end;
   L1:=edLostClassLevFrom;
   L2:=edLostClassLevTo;
   if L1>L2 then swapint(L1,L2);
   subplace:=0; place:=0;
   classtimes(edLostClassYear);
   sortLCCodes;  needupdate:=true;
   UpdateExtrasWins;
  end;

  procedure lostsubject;
  var
   a,msg:  string;
   j:integer;
  begin
   if findyear(combobox1.text)=-1 then
   begin
    msg:='Check '+yeartitle;
    messagedlg(msg,mtError,[mbOK],0);
    exit;
   end;
   a:=Trim(Combobox3.text);

   msg:=''; j:=0;
   if (edLostClassLevfrom<1) or (edLostClassLevfrom>level[edLostClassYear])
     then j:=4;
   if (edLostClassLevto<1) or (edLostClassLevto>level[edLostClassYear])
     then j:=5;
   msg:='Check Level';
   if j>0 then
    begin
     messagedlg(msg,mtError,[mbOK],0);
     case j of
      4: combobox4.setfocus;
      5: combobox5.setfocus;
     end;
     exit;
    end;
   L1:=edLostClassLevFrom;
   L2:=edLostClassLevTo;
   if L1>L2 then swapint(L1,L2);

   if edLostClassSub=0 then
   begin
    msg:='Check subject';
    messagedlg(msg,mtError,[mbOK],0);
    cboSubject.SetFocus;
    exit;
   end;

   j:=edLostClassSub;
   if j<>0 then
   begin
    subplace:=j;
    place:=subplace;
   end
   else
    begin  subplace:=0; place:=subplace; end;

   classtimes(edLostClassYear);

   sortLCCodes;   needupdate:=true;
   UpdateExtrasWins;
  end;

begin   {----------------main proc of edlost------------------------}
 place:=myte;
 GetControlValues;
 case rgpLostClassBy.ItemIndex of
  0: begin {teacher}
      if myte=0 then
       begin
        msg:='No teacher code entered';
        messagedlg(msg,mtError,[mbOK],0);
        combobox6.selectall; combobox6.setfocus;
        exit;
       end;
      enterlostclass;
     end;
   1,2: lostbyclass;{class /year}
   3:  lostsubject;{subject}
  end;{ case}
end;

procedure TEdLostClasses.updateClick(Sender: TObject);
begin
 edlost;  updateMyMaps;
 updatelostclassesCount;
 label9.caption:=inttostr(lostclasses);
 if combobox6.enabled then combobox6.setfocus
  else combobox1.setfocus;
 if combobox6.enabled then combobox6change(self)
  else combobox1change(self);
 UpdateExtrasWins;
end;

procedure TEdLostClasses.cboSubjectChange(Sender: TObject);
begin
  updateMyMaps;
  SetDefaultPeriod;
end;

procedure TEdLostClasses.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if needupdate then saveExtras;
end;

procedure TEdLostClasses.ComboBox4KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TEdLostClasses.ComboBox5KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TEdLostClasses.UpdateControls;
begin
  SetMyControls;
  updateMyMaps;
  grbChangeLostClasses.Hint := '';
end;

procedure TEdLostClasses.ComboBox3Change(Sender: TObject);
begin
 UpdateMyMaps;
end;

procedure TEdLostClasses.ComboBox4Change(Sender: TObject);
begin
 UpdateMyMaps;
 SetDefaultPeriod;
end;

procedure TEdLostClasses.ComboBox5Change(Sender: TObject);
begin
 if cboSubject.Enabled then cboSubjectChange(self)
  else combobox1change(self);
 UpdateMyMaps;
 SetDefaultPeriod;
end;

procedure TEdLostClasses.CheckBox1Click(Sender: TObject);
begin
 shareExclude:=checkbox1.checked;
end;

procedure TEdLostClasses.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_return then updateclick(self);
end;

procedure TEdLostClasses.FormShow(Sender: TObject);
var
  j: Integer;
begin
  combobox1.itemindex:=-1;
  combobox6.text:='';

  if not FIsDirect then
  begin
    j := LostClasseswin.selcode;
    if j > 0 then j := LostClasseswin.ItemPoint[j];
  end
  else
  begin
    j := CodePoint[FSelectedTeCode, 1];
    edLostClassBy := 0;
  end;

  rgpLostClassBy.itemindex := edLostClassBy;
  case edLostClassBy of
  0: begin  {te}
     if j>0 then
      combobox6.text:=tecode[j,0];
     ComboBox6Change(self);
    end;
  1,2,3: begin   {class/year,levels,sub}
     if edLostClassBy=3 then cboSubject.Text := SubCode[edLostClassSub];
     if edLostClassYear=-1 then
      begin
       combobox1.text:='';
       combobox3.text:='';
      end
     else
      begin
       combobox1.text:=yearname[edLostClassYear];
       combobox3.text:=ClassCode[edLostClassClass];
      end;
     combobox4.text:=inttostr(edLostClassLevfrom);
     combobox5.text:=inttostr(edLostClassLevto);
     combobox1change(self);
    end;
  end; {case}
  loading := False;
  UpdateControls;
end;

procedure TEdLostClasses.ComboBox6Change(Sender: TObject);
begin
 updateMyMaps;
end;


end.


