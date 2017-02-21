unit Edmrgcls;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, GlobalToTcAndTcextra;

type
  TEdMergedClasses = class(TForm)
    Label8: TLabel;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    cboOldTeacher: TComboBox;
    ComboBox3: TComboBox;
    update: TBitBtn;
    BitBtn3: TBitBtn;
    Label7: TLabel;
    ComboBox4: TComboBox;
    Remove: TBitBtn;
    finish: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Change(Sender: TObject);
    procedure RemoveClick(Sender: TObject);
    procedure cboOldTeacherChange(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure finishClick(Sender: TObject);
    procedure ComboBox4Enter(Sender: TObject);
  private
    procedure InitRoCombo;
    procedure CheckRemoveEnabled;

  end;

var
  EdMergedClasses: TEdMergedClasses;

implementation
uses tcommon,DlgCommon,tcommon2,tcommon3,mrgclass;
{$R *.DFM}
var loading,needupdate: boolean;


procedure TEdMergedClasses.InitRoCombo;
var
 p,i,j,teach1: integer;
 s1,tmpstr:  string;
 found: bool;
begin
 if loading then exit;
 s1:=combobox4.text;
 combobox4.clear;
 p:=findperiodstring(combobox1.text);
 if (p<1) or (p>tlimit[ttday]) then
  begin combobox4.text:=s1; exit; end;

 for i:=1 to codenum[2] do
  if not(isOccupiedInPeriod(codepoint[i,2],p)) then
    combobox4.items.add(tecode[codepoint[i,2],1]);

 tmpstr:=uppercase(cboOldTeacher.Text);   {add old te's room}
 teach1:=checkcode(1,tmpstr);
 if bool(teach1) then
  begin
   i:=isTeachingInROOM(teach1,p);
   if bool(i) then
    begin
     found:=false;
     if combobox4.items.count>0 then
     for j:=0 to combobox4.items.count-1 do
      if combobox4.items[j]=tecode[i,1] then found:=true;
     if not(found) then
      combobox4.items.add(tecode[i,1]);
    end;
  end;

 tmpstr:=uppercase(combobox3.text);   {add new te's room}
 teach1:=checkcode(1,tmpstr);
 if bool(teach1) then
  begin
   i:=isTeachingInROOM(teach1,p);
   if bool(i) then
    begin
     found:=false;
     if combobox4.items.count>0 then
       for j:=0 to combobox4.items.count-1 do
        if combobox4.items[j]=tecode[i,1] then found:=true;
     if not(found) then combobox4.items.add(tecode[i,1]);
    end;
   end;
 combobox4.text:=s1;
end;


procedure TEdMergedClasses.CheckRemoveEnabled;
var
 an,time,room,teach1,teach2:  integer;
 tmpstr: string;
 yes:     bool;
begin
 if loading then exit;
 refresh;
 remove.enabled:=false; yes:=true;
 an:=strtointdef(edit1.text,0);
 if (an<1) or (an>mergedClasses) then yes:=false;
 time:=findperiodstring(combobox1.text);
 if (time<1) or (time>tlimit[ttday]) then yes:=false;
 tmpstr:=uppercase(cboOldTeacher.Text);
 teach1:=checkcode(1,tmpstr);
 tmpstr:=uppercase(combobox3.text);
 teach2:=checkcode(1,tmpstr);
 room:=codepoint[findroomstr(combobox4.text){+1},2];
 if mtime[an]<>time then yes:=false;
 if mnewte[an]<>teach2 then yes:=false;
 if moldte[an]<>teach1 then yes:=false;
 if mnewroom[an]<>room then yes:=false;
 if yes then remove.enabled:=true;
end;

procedure TEdMergedClasses.FormCreate(Sender: TObject);
var
 i: integer;
begin
 loading:=true; needupdate:=false;
 combobox1.maxlength:=szPeriodName;
 cboOldTeacher.MaxLength := lencodes[1];
 combobox3.maxlength:=lencodes[1];
 combobox4.maxlength:=lencodes[2];

 combobox1.clear;
 for i:=1 to tlimit[ttday] do combobox1.items.add(TimeSlotName[ttday,i-1]);
 cboOldTeacher.Clear;
 combobox3.clear;
 for i:=1 to codenum[1] do
  begin
   cboOldTeacher.Items.Add(tecode[codepoint[i,1],0]);
   ComboBox3.Items.Add(tecode[codepoint[i,1],0]);
  end;

 combobox4.clear;
 for i:=1 to codenum[2] do
  combobox4.items.add(tecode[codepoint[i,2],1]);

 if MergedClasseswin.selcode>0 then edit1.text:=inttostr(MergedClasseswin.selcode)
  else edit1.text:='';

 label9.caption:=inttostr(mergedclasses);
 loading:=false;
end;

procedure TEdMergedClasses.Edit1Change(Sender: TObject);
var
 i,k:   integer;
begin
 i:=strtointdef(edit1.text,0);
 if (i>0) and (i<=mergedclasses) then
  begin
   combobox1.itemindex:=mtime[i]-1;
   combobox1change(self);
   if (mtime[i]>0) then
    begin
     k:=-1;
     if (moldte[i]>0) then k:= cboOldTeacher.Items.IndexOf(tecode[moldte[i],0]);
     cboOldTeacher.ItemIndex := k;
     k:=-1;
     if (mnewte[i]>0) then k:=combobox3.items.indexof(tecode[mnewte[i],0]);
     combobox3.itemindex:=k;
     k:=-1;
     if (mnewroom[i]>0) then k:=combobox4.items.indexof(tecode[mnewroom[i],1]);
     combobox4.itemindex:=k;
    end;
  end
 else
  begin
   combobox1.itemindex:=-1;
   cboOldTeacher.ItemIndex := -1;
   combobox3.itemindex:=-1;
   combobox4.itemindex:=-1;
  end;
 checkRemoveEnabled;
end;

procedure TEdMergedClasses.updateClick(Sender: TObject);
label
 errorMerge;
var
 afnt,bfnt: tpintpoint;
 needAdd,needDelete,needAlter:  integer;
 oldmkind,newmerge,time1,oldmtime,teach1,oldteSS,newteSS:         integer;
 teach2,room1,room2,room3,newroomSS,year2,level2,sub2:            integer;
 deletemerge,an,i,te,ro,su,p,oldroomSS:                           integer;
 mpos1,mpos2,mpos3,year1,level1{,oldflag}:                        smallint;
 concount,oldroom2,sub1,y,L,a:       integer;
 msg,errtime,tmpstr:                          string;

   procedure setMergeAction;
   begin
    needAdd:=0; needDelete:=0; needAlter:=0;
    if (oldmkind<>1) and (newmerge=0) and (time1=oldMtime) and (teach1=oldteSS)
     and (teach2=newteSS) and (newteSS>0) and (room3=newroomSS) then exit;
    if bool(newmerge) then begin needAdd:=-1; exit; end;
    if bool(deleteMerge) then begin needDelete:=-1; exit; end;
    if (time1<>oldMtime) or (teach1<>oldteSS) then
    begin
     needDelete:=-1; needAdd:=-1; exit;
    end;
    needAlter:=-1;
   end;


    procedure mergePositions;
    var
     i: integer;
    begin
     Mpos1:=0; Mpos2:=0; Mpos3:=0;
     if (newmerge=0) and (numchanges>0) then
     begin
      for i:=1 to numChanges do
      begin
       if (Changes[i].gen=3) and (Changes[i].reason=an) then Mpos1:=i;
       if (Changes[i].gen=5) and (Changes[i].reason=an) then Mpos2:=i;
       if (Changes[i].gen=6) and (Changes[i].reason=an) then Mpos3:=i;
      end;
     end;
    end;


     procedure alterMergeChange;
     var
      a: integer;
     begin
      if (teach2<>newteSS) and (newteSS>0) then
      begin
       consequentnum:=0; i:=Mpos1; te:=newteSS; p:=oldMtime;
       removeTeacherCover(i,p);
       if consequentNum>0 then
       begin
        ConCount:=1; removeConsequents;
       end;
       Mpos2:=0; Mpos3:=0;
      end;
      Changes[mpos1].newte:=teach2; Changes[mpos1].newroom:=room3; Changes[mpos1].kind:=5;
      if room3=room1 then Changes[mpos1].needroom:=0 else Changes[mpos1].needroom:=2;
      if (room3=room2) then
      begin
       if mpos2>0 then begin a:=mpos2; deletechange(a); end;
      end
      else
       begin
        if mpos3<=0 then
        begin
         if mpos2=0 then
         begin
          inc(numchanges); mpos2:=numchanges; Changes[mpos2].timeslot:=time1;
          Changes[mpos2].year:=year2; Changes[mpos2].level:=level2; Changes[mpos2].oldte:=teach2;
          Changes[mpos2].sub:=sub2; Changes[mpos2].newte:=teach2; Changes[mpos2].oldroom:=room2;
          Changes[mpos2].newroom:=room3; Changes[mpos2].kind:=0; Changes[mpos2].needte:=0;
          Changes[mpos2].needroom:=0;
         end;
         Changes[mpos2].notes:=0; Changes[mpos2].reason:=an; Changes[mpos2].gen:=5;
        end;
       end;
      if newroomSS<>room3 then
      begin
       if ((rolost[room3] and (1 shl time1))=0)
        and ((room3=room2) or (room3=room1)) then
         rolost[room3]:=rolost[room3] or (1 shl time1);
       roomon[room3]:=roomon[room3] and (not(1 shl time1));
       if (room3<>room1) and (room3<>room2) then
        rocover[room3]:=rocover[room3] and (not(1 shl p));
       if (newroomSS=room2) or (newroomSS=room1) then
        rolost[newroomSS]:=rolost[newroomSS] and (not(1 shl time1));
       roomon[newroomSS]:=roomon[newroomSS] or (1 shl time1);
       rocover[newroomSS]:=rocover[newroomSS] or (1 shl time1);
      end;
     end;



      procedure deletemergechange;
      var
       i,a: integer;
      begin
       consequentnum:=0;
       oldroom2:=0;
       if bool(mpos2) then oldroom2:=Changes[mpos2].oldroom;
       if mpos1>mpos2 then swapint(mpos1,mpos2);
       if mpos2>0 then
        begin a:=mpos2; deletechange(a); end;
       if mpos1>0 then
        begin a:=mpos1; deletechange(a); end;
       telost[oldteSS]:=telost[oldteSS] or (1 shl oldMtime);
       for i:=1 to numchanges do
       begin
        if (Changes[i].gen<>4) and (Changes[i].timeslot=oldMtime) and (Changes[i].oldte<>Changes[i].newte)
         and (Changes[i].newte=oldteSS) then
          begin te:=oldteSS; p:=oldMtime; removeteachercover(i,p); end;
       end; {for i}
       if consequentnum>0 then begin concount:=1; removeconsequents; end;
       place:=oldteSS;
       resetavail(place);
       rolost[oldroomSS]:=rolost[oldroomSS] or (1 shl oldMtime);
       roomon[oldroomSS]:=roomon[oldroomSS] and (not(1 shl oldMtime));
       if bool(oldroom2) then
       begin
        rolost[oldroom2]:=rolost[oldroom2] or (1 shl oldMtime);
        roomon[oldroom2]:=roomon[oldroom2] and (not(1 shl oldMtime));
       end;
       if (newroomSS<>oldroomSS) and (newroomSS<>oldroom2) then
       begin
        roomon[newroomSS]:=roomon[newroomSS] or (1 shl oldMtime);
        rocover[newroomSS]:=rocover[newroomSS] or (1 shl oldMtime);
       end;
       for i:=1 to numchanges do
       begin
        if (Changes[i].gen<>4) and (Changes[i].timeslot=oldMtime) and (Changes[i].newroom<>Changes[i].oldroom)
         and (Changes[i].needroom=2) and (Changes[i].newroom>0) then
          if (Changes[i].newroom=oldroomSS) or (Changes[i].newroom=oldroom2) then
           begin Changes[i].newroom:=0; Changes[i].needroom:=1; end;
       end;
      end;


    procedure addmergeChange;
    var
     a:     integer;
    begin
     inc(numchanges); a:=numchanges;
     Changes[a].timeslot:=time1; Changes[a].year:=year1; Changes[a].level:=level1; Changes[a].sub:=sub1;
     Changes[a].oldte:=teach1; Changes[a].newte:=teach2; Changes[a].oldroom:=room1; Changes[a].newroom:=room3;
     Changes[a].kind:=5; Changes[a].needte:=0; Changes[a].needroom:=0; Changes[a].notes:=0; Changes[a].reason:=an;
     Changes[a].gen:=3;
     if room1=room3 then Changes[a].needroom:=0;
     telost[teach1]:=telost[teach1] and (not(1 shl time1));
     place:=teach1; resetavail(place);
     teon[teach1]:=teon[teach1] or (1 shl time1);
     if room1<>room3 then
     begin
      roomon[room1]:=roomon[room1] or (1 shl time1);
      rolost[room1]:=rolost[room1] and (not(1 shl time1));
     end;
     if room3=room2 then exit;
     inc(numchanges);  a:=numchanges;
     Changes[a].timeslot:=time1; Changes[a].year:=year2; Changes[a].level:=level2; Changes[a].sub:=sub2;
     Changes[a].oldte:=teach2; Changes[a].newte:=teach2; Changes[a].oldroom:=room2; Changes[a].newroom:=room3;
     Changes[a].kind:=0; Changes[a].needte:=0; Changes[a].needroom:=0; Changes[a].notes:=0; Changes[a].reason:=an;
     Changes[a].gen:=5;
     if room2<>room3 then
     begin
      roomon[room2]:=roomon[room2] or (1 shl time1);
      rolost[room2]:=rolost[room2] and (not(1 shl time1));
     end;
     if (room3<>room1) and (room3<>room2) then
     begin
      roomon[room3]:=roomon[room3] and (not(1 shl time1));
      rocover[room3]:=rocover[room3] and (not(1 shl time1));
     end;
    end;


   procedure addMergeClasses;
   begin
    setmergeaction;
    mergepositions;
    if bool(needAlter) then altermergechange;
    if bool(needdelete) then deletemergechange;
    if bool(needadd) then addmergechange;
   end;


begin   {main proc for update_click}
 an:=strtointdef(edit1.text,0);
 if (an<1) or (an>nmbrmergedClasses) then
 begin
  msg:='Check merge number';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.setfocus; edit1.selectall;
  exit;
 end;

 msg:=''; deletemerge:=0; errtime:=''; teach1:=0; teach2:=0; room1:=0; room2:=0;
 room3:=0; {time1:=combobox1.itemindex+1;} a:=0;
 time1:=findperiodstring(combobox1.text){+1};
 if (time1<1) or (time1>tlimit[ttday]) then
  begin msg:='Check Time Slot'; a:=1; goto errorMerge; end;
 errtime:=' in time slot '+inttostr(time1);

 tmpstr := UpperCase(cboOldTeacher.Text);
 teach1:=checkcode(1,tmpstr);
 if teach1=0 then
  begin msg:='Check Old Teacher!'; a:=2; goto errorMerge; end;
 //if (teabsent[teach1] and (1 shl time1))=0 then
  //begin msg:=tecode[teach1,0]+' is absent'+errtime; a:=2; goto errorMerge; end;
 if (tena[teach1] and (1 shl time1))=0 then
  begin msg:=tecode[teach1,0]+' is not available'+errtime; a:=2; goto errorMerge; end;
 if bool(teach[teach1] and (1 shl time1)) then
  begin msg:=tecode[teach1,0]+' is not teaching'+errtime; a:=2; goto errorMerge; end;
 if (teach1<>moldte[an]) and ((telost[teach1] and (1 shl time1))=0) then
  begin msg:=tecode[teach1,0]+' has lost class'+errtime; a:=2; goto errorMerge; end;
 if (Trim(combobox3.text)='') and (moldte[an]>0) then
  begin deletemerge:=-1; goto errorMerge; end;

 tmpstr:=uppercase(combobox3.text);
 teach2:=checkcode(1,tmpstr);
 if teach2=0 then
  begin msg:='Check New Teacher!'; a:=3; goto errorMerge; end;
 if (teabsent[teach2] and (1 shl time1))=0 then
  begin msg:=tecode[teach2,0]+' is absent'+errtime; a:=3; goto errorMerge; end;
 if (teach2=teach1) then
  begin msg:='Teacher codes are the same!'; a:=3; goto errorMerge; end;
 if (tena[teach2] and (1 shl time1))=0 then
  begin msg:=tecode[teach2,0]+' is not available'+errtime; a:=3; goto errorMerge; end;
 if bool(teach[teach2] and (1 shl time1)) then
  begin msg:=tecode[teach2,0]+' is not teaching'+errtime; a:=3; goto errorMerge; end;
 if ((telost[teach2] and (1 shl time1))=0) then
  begin msg:=tecode[teach2,0]+' has lost class'+errtime; a:=3; goto errorMerge; end;
 room1:=0; room2:=0; room3:=0;

 for y:=0 to years_minus_1 do
 begin
  afnt:=FNT(ttday,(time1-1),y,0,0);
  for l:=1 to level[y] do
  begin
   inc(aFnt,4);
   bfnt:=afnt; inc(bfnt);
   te:=bfnt^; inc(bfnt); ro:=bfnt^; su:=afnt^;
   if te=teach1 then
    begin year1:=y; room1:=ro; sub1:=su; level1:=l; end;
   if te=teach2 then
    begin room2:=ro; year2:=y; sub2:=su; level2:=l; end;
  end; {for l}
 end; {for y}
 if Trim(combobox4.text)='' then
  begin room3:=room2; goto errorMerge; end;
 room3:=codepoint[findroomstr(combobox4.text){+1},2];
 if (room3<>room1) and (room3<>room2) and ((roomon[room3] and (1 shl time1))=0) then
  begin msg:='Room '+tecode[room3,1]+' not available'+errtime; a:=4; end;
errorMerge:
 if msg>'' then
  begin
   messagedlg(msg,mtError,[mbOK],0);
   case a of
    1: combobox1.setfocus;
    2: cboOldTeacher.SetFocus;
    3: combobox3.setfocus;
    4: combobox4.setfocus;
   end;
   exit;
  end;

 if bool(moldte[an]) then newmerge:=0 else newmerge:=-1;
 if newmerge=0 then
  begin
   oldmtime:=mtime[an]; oldteSS:=moldte[an]; oldroomSS:=moldroom[an]; newteSS:=mnewte[an];
   newroomSS:=mnewroom[an]; {oldflag:=mflag[an];} oldmkind:=mkind[an];
  end;
 a:=an; mtime[a]:=time1; myear[a]:=year1; msub[a]:=sub1; mlevel[a]:=level1;
 moldte[a]:=teach1; mnewte[a]:=teach2; moldroom[a]:=room1; mnewroom[a]:=room3;
 if room3<>room2 then mflag[a]:=-1 else mflag[a]:=0;
 addMergeClasses;
 if bool(deletemerge) then
  begin
   mtime[an]:=0; mnewte[an]:=0; moldte[an]:=0; mnewroom[an]:=0;
  end;

  //what if we update the teachermap here? - didnt seem to do anything
  //UpdateTeacherMap;
  //try updateAbsence   -- Yay this seems to fix the issue where the Teacher is made Absent before the Merge (#65)
  UpdateAbsence(teach1);

 MergedClasseswin.UpdateWin;
 label9.caption:=inttostr(mergedclasses);
 if bool(deletemerge) then
  begin
   if an<mergedClasses then edit1.text:=inttostr(an+1) {move to next}
   else begin
        if a>1 then edit1.text:=inttostr(an-1)
         else edit1.text:='';
       end;
  end;
 UpdateExtrasWins; needupdate:=true;
 edit1.setfocus;
 edit1change(self);   {remove butt update}
end;

procedure TEdMergedClasses.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if needupdate then SaveExtras;
end;

procedure TEdMergedClasses.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TEdMergedClasses.ComboBox1Change(Sender: TObject);
var
 p,i,ii: integer;
 s1,s2,s3:       string;
begin
 s1 := Trim(cboOldTeacher.Text);
 s2:=Trim(combobox3.text);
 s3:=Trim(combobox4.text);
 combobox3.clear;
  if cboOldTeacher.Items.Count >0 then
   for i:= cboOldTeacher.Items.Count -1 downto 0 do
    cboOldTeacher.Items.Delete(i);
 p:=findperiodstring(combobox1.text);
 if (p<1) or (p>tlimit[ttday]) then
 begin
  checkRemoveEnabled;
  cboOldTeacher.Text := s1; combobox3.text:=s2;  combobox4.text:=s3;
  exit;
 end;

 ii:=strtointdef(edit1.text,0);
 for i:=1 to codenum[1] do
  if IsTeachingInPeriod(codepoint[i, 1], p, ii) then
  begin
   cboOldTeacher.items.add(tecode[codepoint[i,1],0]);
   combobox3.items.add(tecode[codepoint[i,1],0]);
  end;

 InitRoCombo;
 self.repaint;
 cboOldTeacher.Text := s1;
 combobox3.text:=s2;
 combobox4.text:=s3;
 checkRemoveEnabled;
end;

procedure TEdMergedClasses.RemoveClick(Sender: TObject);
begin
 combobox3.text:='';
 EdMergedClasses.refresh;
 updateclick(self);
 edit1.setfocus;
end;

procedure TEdMergedClasses.cboOldTeacherChange(Sender: TObject);
begin
 checkRemoveEnabled;
 InitRoCombo;
end;

procedure TEdMergedClasses.ComboBox4Change(Sender: TObject);
begin
 checkRemoveEnabled;
end;

procedure TEdMergedClasses.ComboBox3Change(Sender: TObject);
begin
 checkRemoveEnabled;
 InitRoCombo;
end;

procedure TEdMergedClasses.FormActivate(Sender: TObject);
begin
 checkRemoveEnabled;
end;

procedure TEdMergedClasses.finishClick(Sender: TObject);
begin
 close;
end;

procedure TEdMergedClasses.ComboBox4Enter(Sender: TObject);
begin
 if loading then exit;
 InitRoCombo;
end;

end.
