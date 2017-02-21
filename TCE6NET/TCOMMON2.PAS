unit Tcommon2;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, SysUtils,Messages,grids
  ,TCEglobals,Ttable, XML.UTILS, XML.REASON, XML.EXTRAS, GlobalToTcAndTcextra;

 procedure saveWinDisplay;
 procedure saveWinDisplayDo;
 procedure findstudentWinSelect;
 procedure absreasonswinselect;
 procedure TimesWinSelect;
 function findaddedstaff(c: string):integer;
 function findaddedstaffsel(c: string):integer;
 procedure covernoteswinselect;
 function FNycSHARED(d,p,te,b: smallint):string;
 procedure clearStudListBoxSelections;
 procedure AddedStaffWinSelect;
 procedure rangeCheckStudSels(var aa: tpstudentdata);
 procedure rangeCheckCodeSels(var aa: tpTeData; code: smallint);
 procedure rangeCheckSubSels(var aa: tpSubData{; code: integer});
 function readFileLine(var f:file): string;
 function ReloadUseFile: boolean;
 function GroupCaption: string;
 procedure checkInLieus;
 procedure SetSubGroup(methodSel:integer);
procedure SetTagGroup(methodSel:integer);
procedure SetRoomGroup(methodSel:integer);
procedure SetTutorGroup(methodSel:integer);
procedure SetIDGroup(grType,methodSel:integer);
procedure SetHouseGroup(methodSel:integer);
procedure SetClassGroup(methodSel:integer);
procedure SetYearGroup(methodSel:integer);
 procedure UpdateGroupSubs;
 procedure UpdateCustomMenus;
 procedure CountGroupSubs;

 procedure checkReplace;
 procedure saveReasons;
 procedure ETout;
 procedure AbsentteWinSelect;
 procedure updateteachermap;
 procedure extrasIn;
 function INTtoBINstr(a: integer): string;
 function BINstrtoINT(a: string): integer;
 function SetNewDay(newdaykind: Integer): Boolean;
 procedure UpdatePastExtras(Aday,Amonth,Attday: integer);
 procedure SaveUseName;
 procedure addabsent(place,p: integer);
 Procedure GetTTsub(myte,ttperiod: integer);
 procedure removeabsent(place,p: integer);
 procedure saveCoverData;
 procedure checkLinks;
 procedure teacherMap;
 function IsTeachingInPeriod(Te, p, mergeNum: Integer): Boolean;
 function isOccupiedInPeriod(ro,p: integer):bool;
 function FNgetBlockNumber(d,p,y,l: smallint): Byte;
 function LoadCustom: wordbool;
 function clearcustom:wordbool;
 procedure SaveCustom;
 function GenType3(k: integer):string;
 function GetStatusNote(i: integer): string;
 procedure parseCustomInfo;
 procedure calculateTeach;
 Procedure GetShares(myChange: integer);
 function IncludeStud(j,myset:integer):boolean;
 procedure FillComboRollClass(myCombo:TcomboBox;DefClass:integer;myRadio:TRadioButton);
  procedure REselectgroup;
  procedure SetRecipeFromGOS(nm: integer);
  procedure CookCustomGroup(GI: smallint);
  function FindHouse(enteredTxt: string; msgLabel: Tlabel): smallint;
  function CalculateLoads: Double;

var
  GroupIndexDisplay: Smallint;

implementation

uses     Tcgetdir,tcommon,tcommon3,
         main,TimesWnd,vwcoddlg,tcinfo,newday,
         subbysub,subbyslt,studlist,printers,
         studttab,teachtt,roomtt,subjcttt,edcustom,EdETmail,
         findstud,absrsn,covnotes,addstaff,abtes,clipbrd,tcommon4,
         tcommon5;


procedure FillComboRollClass(myCombo:TcomboBox;DefClass:integer;myRadio:TRadioButton);
var
 i,j,k,c: integer;
 VerifyClass:array of boolean;
begin
 SetLength(VerifyClass,classnum+10);
 myCombo.Clear;
 for i:=0 to classnum do VerifyClass[i]:=false;
 for i:=1 to numstud do
  begin
   j:=Stud[i].tcClass;
   if (j>0) and (j<=classnum) then VerifyClass[j]:=true;
  end;

 myCombo.items.add('All classes');
 j:=0;   k:=0;
 if classnum>0 then
  for i:=1 to classnum do
   begin
    c:=RollClasspoint[i];
    if VerifyClass[c] then
     begin
      myCombo.items.add(ClassCode[c]);
      inc(j);
      if c=DefClass then k:=j;
     end;
   end;
 if j>0 then
  begin
   MyCombo.itemindex:=k;
   MyCombo.update;
  end
 else myRadio.Enabled:=false;
end;


function IncludeStud(j,myset:integer):boolean;
var
 includefirst,includesecond: boolean;
begin
 includefirst:=false; includesecond:=false;
 if CheckStudInSub(StPointer[j],Changes[myset].sub) then
   if MatchAllYears or (Stud[StPointer[j]].TcYear=Changes[myset].year) then
    includefirst:=true;
 if SubShareFlag then if CheckStudInSub(StPointer[j],Sharesub) then
   if MatchAllYears or (Stud[StPointer[j]].TcYear=ShareYear) then
     includesecond:=true;
 result:=includefirst or includesecond;
end;


Procedure GetShares(myChange: integer);
var
 y,l,myte,mysub,myroom,ttperiod:  integer;
 afnt,bfnt:      tpintpoint;
begin
 SubShareFlag:=false; ShareSub:=0;ShareYear:=-1;
 if not(IncludeShareFlag) then exit;  {user sets checkbox}
 myte:=Changes[myChange].oldte;   myroom:=Changes[myChange].oldroom;
 ttperiod:=Changes[MyChange].timeslot;  mysub:=Changes[MyChange].sub;
 ttyear:=Changes[MyChange].year;  ttlevel:=Changes[Mychange].level;
 {only do for absent teacher with shared class}
 if (myte<=0) or (myte>NumCodes[1]) or ((Changes[myChange].gen)<>1) then exit;
 ttshare:=FNTbyte(ttday,ttperiod-1,ttyear,ttlevel,6)^ and 2;
 if ttshare=0 then exit; {not shared}
 
 for y:=years_minus_1 downto 0 do
  begin
   afnt:=FNT(ttday,ttperiod-1,y,0,2);
   for l:=1 to level[y] do
    begin
     inc(afnt,4); bfnt:=afnt;
     if (l=ttlevel) and (y=ttyear) then continue;
     if myte=afnt^ then
      begin
       dec(bfnt); ttsub:=bfnt^;
       inc(bfnt,2); ttroom:=bfnt^;
       ttshare:=FNTbyte(ttday,ttperiod-1,y,l,6)^ and 2;
       if (bool(ttshare)) and (ttsub>0)and (ttroom=myroom) and
        ((ttsub<>mysub) or (y<>ttyear)) then
        begin  {same teacher and room, share flag set, subject>0}
          sharesub:=ttsub;
          shareYear:=y;
          SubShareFlag:=true;
          break;
        end;
      end;
    end; {l}
  end; {y}
end;


function ConvertInt(a: word):integer;
var
 mytime: integer;
begin
 a:=not(a);
 mytime:=a;
 result:=not(mytime);
end;

function GenType3(k: integer):string;
begin
 result:='';
 case Changes[k].gen of
   0: result:='Room change';
   1: result:=tecode[Changes[k].oldte,0]+' absent';
   2: result:='New class';
   3: result:='Merge';
   5: result:='Consequent';
   6: result:=tecode[Changes[k].oldte,0]+' swap';
  end; {case}
end;

function GetStatusNote(i: integer): string;
var
 n1: integer;
 astr: string;
begin
 astr:='';
 n1:=Changes[i].notes;
 if (n1>0) and (n1<=nmbrreasons) then astr:=Cover[n1];
 if n1>1000 then begin dec(n1,1000); astr:=ExNote[n1] end;
 result:=astr;
end;

function LoadCustom:wordbool;
var
 F:       textfile;
 S:       string;
 i:  integer;
 Fname:   string;
begin
 result:=false;
 mainform.opendialog.title:='Load Custom Information';
 mainform.opendialog.defaultext:='CUS';
 mainform.opendialog.filename:=custom;
 mainform.opendialog.filter:='Custom Files | *.CUS';
 mainform.opendialog.initialdir:=Directories.datadir;

 if mainform.opendialog.execute then
 begin
  Fname:=mainform.opendialog.filename;
  gotCustom:=false;
  doAssignFile(F,Fname);
  if FileExists(Fname) then
  begin
   try
    try
     filemode:=fmOpenRead+fmShareDenyNone;
     reset(F);
     Readln(F,S);
     S:=trim(S);
     Addnum:=strToIntdef(S,0);   IntRange(Addnum,0,nmbrCustom);
     if (AddNum>0) then
      for i:=1 to AddNum do
      begin
       readln(F,S);
       S:=trim(S);
       customTab[i]:=strToInt(S);
       readln(F,add[i]);
      end;
     gotCustom:=true;
    finally
     closefile(F);
    end;
   except

   end;
  end;
  s:=Extractfilename(fname);
  i:=pos('.',s);
  if bool(i) then s:=copy(s,1,i-1);
  custom:=s;
  UpdateWindow(wnInfo);
  result:=true;
 end;  {if execute}
end;

function ClearCustom:wordbool;
var
 i:   integer;
 msg:     string;
begin
 ClearCustom:=false;
 msg:='Are you sure you want to clear the current Custom Information?';
 if ((addnum=0) or (messagedlg(msg,mtWarning,[mbyes, mbno],0)=mrYes)) then
 begin
  clearCustom:=true;
  addnum:=0;
  for i:=0 to nmbrCustom do
  begin
   customTab[i]:=0;
   add[i]:='';
  end;
  UpdateWindow(wnInfo);
 end;
end;

procedure SaveCustom;
var
 F:       textfile;
 S:       string;
 i:  integer;
 Fname:   string;
begin
 mainform.savedialog.title:='Save Custom Information';
 mainform.SaveDialog.HelpContext:=24;
 mainform.savedialog.defaultext:='CUS';
 mainform.savedialog.filename:=custom;
 mainform.savedialog.filter:='Custom Files | *.CUS';
 mainform.savedialog.initialdir:=Directories.datadir;

 if mainform.savedialog.execute then
 begin
  Fname:=mainform.savedialog.filename;
  doAssignFile(F,Fname);
  filemode:=fmOpenReadWrite+fmShareDenyWrite;
  rewrite(F);
  str(Addnum,S);
  Writeln(F,S);
  if (AddNum>0) then
   for i:=1 to AddNum do
   begin
    str(customTab[i],S);
    Writeln(F,S);
    Writeln(F,add[i]);
   end;
  closefile(F);
  s:=Extractfilename(fname);
  i:=pos('.',s);
  if bool(i) then s:=copy(s,1,i-1);
  custom:=s;
  UpdateWindow(wnInfo);
 end;
end;

procedure parseCustomInfo;
 var
  i,j,k:     integer;
  a:   string;
 begin
  for i:=0 to nmbrCustom do CustomArr[i]:='';
  j:=1; a:='';  CustomCnt:=0;
  if addnum=0 then exit;
  for i:=1 to addnum do
  begin
   if customTab[i]=1000 then
   begin  {continue from previous line}
    CustomArr[j]:=CustomArr[j]+add[i];
   end
   else
    if customTab[i]<0 then
    begin  {no of blank lines}
     for k:=1 to abs(customTab[i]) do
      inc(j); {next line}
    end
    else
     begin   {chars in from left}
      if ((j>1) and (length(CustomArr[j-1])<customtab[i])) then
      begin {continue on after line}
       a:=copy(stringpadchr(250,' '),1,(customtab[i]-length(CustomArr[j-1])));
       CustomArr[j-1]:=CustomArr[j-1]+a+add[i];
      end
      else {new line}
       begin
        a:=stringpadchr(customTab[i],' ');
        a:=a+add[i];
        CustomArr[j]:=a;
        inc(j); {next line}
       end;
     end;
   CustomArr[i]:=TrimRight(CustomArr[i]);
  end;   {for i}
  CustomCnt:=j-1;
 end;

function FNgetBlockNumber(d,p,y,l: smallint): Byte;
var
 Byte7,Byte8,BlockNum: byte;
begin
 Byte7:=FNTByte(d,p,y,l,6)^;
 Byte8:=FNTByte(d,p,y,l,7)^;
 Byte7:=Byte7 shr 3;  //previous block num
 Byte8:=Byte8 and 7;
 Byte8:=Byte8 shl 5;
 BlockNum:=Byte7 or Byte8;
 result:=BlockNum;
end;

procedure CountGroupSubs;
var
 i,j,k:       smallint;
begin
 try
  for i:=1 to NumCodes[0] do GroupSubCount[i]:=0;
  for i:=1 to groupnum do
  begin
   k:=StGroup[i];
    for j:=1 to chmax do
    if Stud[k].choices[j]>0 then
     inc(GroupSubCount[GsubXref[Stud[k].choices[j]]]);
  end; {for i}
 except
 end;
end;

function IsTeachingInPeriod(Te, p, mergeNum: Integer): Boolean;
var
  lFound: Boolean;
begin
  lFound := True;

  //if (teAbsent[te] and (1 shl p))=0 then lFound:=false;  {absent}     //if absent not a problem they still have a class at that time
  if (tena[te] and (1 shl p))=0 then  lFound := False; {not available}
  if bool(teach[te] and (1 shl p)) then lFound := False; {not teaching}
  if (mergeNum > 0) and (mergeNum <= mergedclasses) then
  if (Te <> moldte[mergeNum]) and ((telost[te] and (1 shl p)) = 0) then
    lFound := False; //lost class

  Result := lFound;
end;

procedure UpdateCustomMenus;
var
 j,i: smallint;
begin
  j := GOSmenu[0];
  {update menu}
  try
    mainform.n15.visible:=(j>0);
    mainform.grp01.visible:=(j>0); mainform.grp11.visible:=(j>1);
    mainform.grp21.visible:=(j>2); mainform.grp31.visible:=(j>3);
    mainform.grp41.visible:=(j>4); mainform.grp51.visible:=(j>5);
    mainform.grp61.visible:=(j>6); mainform.grp71.visible:=(j>7);
    mainform.grp81.visible:=(j>8); mainform.grp91.visible:=(j>9);
    mainform.grp101.visible:=(j>10); mainform.grp111.visible:=(j>11);
    mainform.grp121.visible:=(j>12); mainform.grp131.visible:=(j>13);
    mainform.grp141.visible:=(j>14); mainform.grp151.visible:=(j>15);

    MainForm.N15N.Visible := (j>0);
    MainForm.grp0S.Visible := (j>0);
    MainForm.grp1S.visible:=(j>1);
    MainForm.grp2S.Visible := (j>2);
    MainForm.grp3S.visible:=(j>3);
    MainForm.grp4S.Visible := (j>4);
    MainForm.grp5S.visible:=(j>5);
    MainForm.grp6S.Visible := (j>6);
    MainForm.grp7S.visible:=(j>7);
    MainForm.grp8S.Visible := (j>8);
    MainForm.grp9S.visible:=(j>9);
    MainForm.grp10S.Visible := (j>10);
    MainForm.grp11S.visible:=(j>11);
    MainForm.grp12S.Visible := (j>12);
    MainForm.grp13S.visible:=(j>13);
    MainForm.grp14S.Visible := (j>14);
    MainForm.grp15S.visible:=(j>15);
  except
  end;

  try
  if j>0 then
    for i:=1 to j do
    begin
      case i of
         1: mainform.grp01.caption:=GOSname[GOSmenu[i]];
         2: mainform.grp11.caption:=GOSname[GOSmenu[i]];
         3: mainform.grp21.caption:=GOSname[GOSmenu[i]];
         4: mainform.grp31.caption:=GOSname[GOSmenu[i]];
         5: mainform.grp41.caption:=GOSname[GOSmenu[i]];
         6: mainform.grp51.caption:=GOSname[GOSmenu[i]];
         7: mainform.grp61.caption:=GOSname[GOSmenu[i]];
         8: mainform.grp71.caption:=GOSname[GOSmenu[i]];
         9: mainform.grp81.caption:=GOSname[GOSmenu[i]];
        10: mainform.grp91.caption:=GOSname[GOSmenu[i]];
        11: mainform.grp101.caption:=GOSname[GOSmenu[i]];
        12: mainform.grp111.caption:=GOSname[GOSmenu[i]];
        13: mainform.grp121.caption:=GOSname[GOSmenu[i]];
        14: mainform.grp131.caption:=GOSname[GOSmenu[i]];
        15: mainform.grp141.caption:=GOSname[GOSmenu[i]];
      end; {case}
      case i of
         1: MainForm.grp0S.Caption := GOSname[GOSmenu[i]];
         2: MainForm.grp1S.Caption := GOSname[GOSmenu[i]];
         3: MainForm.grp2S.Caption := GOSname[GOSmenu[i]];
         4: MainForm.grp3S.Caption := GOSname[GOSmenu[i]];
         5: MainForm.grp4S.Caption := GOSname[GOSmenu[i]];
         6: MainForm.grp5S.Caption := GOSname[GOSmenu[i]];
         7: MainForm.grp6S.Caption := GOSname[GOSmenu[i]];
         8: MainForm.grp7S.Caption := GOSname[GOSmenu[i]];
         9: MainForm.grp8S.Caption := GOSname[GOSmenu[i]];
        10: MainForm.grp9S.Caption := GOSname[GOSmenu[i]];
        11: MainForm.grp10S.Caption := GOSname[GOSmenu[i]];
        12: MainForm.grp11S.Caption := GOSname[GOSmenu[i]];
        13: MainForm.grp12S.Caption := GOSname[GOSmenu[i]];
        14: MainForm.grp13S.Caption := GOSname[GOSmenu[i]];
        15: MainForm.grp14S.Caption := GOSname[GOSmenu[i]];
      end; {case}
    end;
  except
  end;
end;

function GroupCaption: string;
begin
  if grouptype<>myGRPALL then
   result:='    USING GROUP: '+groupname
     +' ('+groupsortname[groupsort]+')'
   else result:='  All Students';
end;


function isOccupiedInPeriod(ro,p: integer):bool;
begin
 result:=bool((roomon[ro] and (1 shl p))=0);
end;

procedure UpdateGroupSubs;
var
 i,j,k,nm: smallint;
 xi,xgroupinsert: smallint;
 xxxv:        array of smallint;
 xxxv2:        array of String;
 string1,sub1,sub2: string;
 count,subnum:      smallint;

  procedure sortGroupSubCodesbyCode;
  var
    D,H,i:         smallint;
    J,L,A,B:           smallint;
    tmpStr1,tmpStr2: string;
    label label1,label2;
  begin
    D:=1;
    while D<codenum[0] do D:=D+D;
    label1:
    D:=(D-1) div 2;
    if D=0 then exit;
    H:=codenum[0]-D;
    for i:=1 to H do
      begin
       J:=i;
       Label2:
       L:=J+D;
       A:=xxxv[L];
       B:=xxxv[J];

       tmpStr1:=uppercase(subcode[A]);
       tmpStr2:=uppercase(subcode[B]);

       if tmpStr1<tmpStr2 then
         begin
          xxxv[J]:=A;
          xxxv[L]:=B;
          dec(J,D);
         end;
       if (tmpStr1<tmpStr2) and (J>0) then goto Label2;
     end; {for}
     goto label1;
   end;

begin
  for j:=0 to NumCodes[0] do
  begin
   GroupSubs[j]:=0;
   GroupSubCount[j]:=0;
   GsubXref[j]:=0;
  end;

  {check stud choices}
  if groupnum>0 then
  begin
   for i:=1 to groupnum do
   begin
    nm:=StGroup[i];
    for j:=1 to chmax do
    begin
     k:=Stud[nm].Choices[j];
     if ((k>0) and (k<=numCodes[0])) then
     begin
      GsubXref[k]:=-1;   //just mark flag to include it
     end;
    end; {for j}
   end; {for i}
  end;


{check for parent split sub, i.e. if ENA & ENB then add EN  }

 setlength(xxxv,nmbrsubjects+1); // xxxvI:=0;
 setlength(xxxv2,nmbrsubjects+1);

 for xi:=1 to nmbrsubjects do
 begin
  xxxv[xi]:=0;{'';}
  xxxv2[xi]:='';
 end;

 for i:=1 to codenum[0] do
  xxxv[i]:=codepoint[i,0];   //sorted (by code) copy of subject codes

 if sorttype[0]<>1 then //not sorted on code allready
  sortGroupSubCodesbyCode;

 for i:=1 to numcodes[0] do
 begin
  xxxv2[i]:=copy(subcode[i],1,lencodes[0]-1); //second copy minus last char
 end;

 string1:=''; count:=0;
 for i:=codenum[0] downto 1 do
 begin
  subnum:=xxxv[i];
  sub1:=subcode[subnum];
  sub2:=xxxv2[subnum];
  if string1=sub2 then
  begin
   if (GsubXref[subnum]=-1) then inc(count)
   else
    if ((count>1) and (sub1=sub2+' ')) then GsubXref[subnum]:=-1;
  end
  else
   begin
    if GsubXref[subnum]=-1 then
    begin
     count:=1; string1:=sub2;
    end;
   end;
 end; {for i}

  GroupSubs[0]:=0;
  for i:=1 to codenum[0] do
  begin
   j:=xxxv[i];
   if GsubXref[j]=-1 then //add to group subs
   begin
    inc(GroupSubs[0]);
    xgroupInsert:=GroupSubs[0];
    GroupSubs[xgroupInsert]:=j;
    GroupSubCount[xgroupInsert]:=0;
    GsubXref[j]:=xgroupInsert;
   end;
  end;
 XrefGroupSubs;
 CountGroupSubs;
end;

function StudInSub(st_i,asub:integer):boolean;
var
 a,j:      integer;
 strB,strC:   string;
begin
 result:=false;
 strB:=copy(Subcode[abs(asub)],1,lencodes[0]-1);
 for j:=1 to chmax do begin
   a:=Stud[st_i].choices[j];
   if ((asub>0) and (a=asub)) then
     begin
      result:=true;
      break;
     end;
   if ((asub<0) and (a>0)) then
     begin
      strC:=copy(Subcode[a],1,lencodes[0]-1);
      if strC=strB then
       begin
        result:=true;
        break;
       end;
     end;
  end; {for j}
end;

procedure SetSubGroup(methodSel:integer);
var
 st_i,i,j,tmpNum:    integer;
 codeStr:            string;
 matchArr:           array of integer;
begin
 if Numcodes[0]=0 then exit; {no subjects to select}
 codeStr:=uppercase(trim(groupSelStr[1]));
 tmpNum:=checkWildSub(codeStr);
 if methodSel<>3 then if tmpNum=0 then exit;
 setlength(matchArr,nmbrSubjects+1);
 case methodSel of
   0:begin {new}
       for i:=1 to numstud do
        begin
         st_i:=i;
         if StudInSub(st_i,tmpNum) then StudGrpFlg[st_i]:=1
              else StudGrpFlg[st_i]:=0;
        end; {for i}
       end; {methodSel=0}
    1: begin {add to}
        for i:=1 to numstud do
         begin
          st_i:=i;
          if StudInSub(st_i,tmpNum) then StudGrpFlg[st_i]:=1;
         end; {for i}
       end; {methodSel=1}
    2: begin {select from}
        for i:=1 to groupnum do
         begin
          st_i:=StGroup[i];
          if StudInSub(st_i,tmpNum) then StudGrpFlg[st_i]:=1
           else StudGrpFlg[st_i]:=0;
         end; {for i}
       end; {methodSel=2}
    3: begin {match to}
        for i:=0 to numCodes[0] do matchArr[i]:=0; {init MatchArray}
        for i:=1 to groupnum do
         begin
          st_i:=StGroup[i];
          for j:=1 to chmax do
               matchArr[Stud[st_i].choices[j]]:=1;
         end;
        for i:=1 to numstud do
          for j:=1 to chmax do
            if matchArr[Stud[i].choices[j]]=1 then
              if (Stud[i].choices[j]>0) then
                  StudGrpFlg[i]:=1;
       end;
 end; {case methodsel}
end;

function StudHasTag(atag,st_i:integer):boolean;
begin
 result:=false;
 if atag<0 then {all}
   begin
     if Stud[st_i].tctag<>0 then result:=true;
   end
 else  {only one tag}
   begin
     if bool(Stud[st_i].tctag and (1 shl (atag-1))) then result:=true;
   end;
end;


procedure SetTagGroup(methodSel:integer);
var
 i,j,st_i,tmpNum:      integer;
 codeStr:         string;
 matchArr:        array of integer;
begin
 codestr:=trim(groupSelStr[1]);
 tmpNum:=strtointdef(codestr,0);
 if codestr='*' then tmpNum:=-1;
 if ((tmpNum=0) and (methodSel<>3)) then exit;
 setlength(matchArr,10);
 case methodSel of
   0:begin {new}
       for i:=1 to numstud do
        begin
         st_i:=i;
         if StudHasTag(tmpNum,st_i) then StudGrpFlg[st_i]:=1
              else StudGrpFlg[st_i]:=0;
        end; {for i}
     end; {methodSel=0}
   1: begin {add to}
        for i:=1 to numstud do
         begin
          st_i:=i;
          if StudHasTag(tmpNum,st_i) then StudGrpFlg[st_i]:=1;
         end; {for i}
      end; {methodSel=1}
   2: begin {select from}
        for i:=1 to groupnum do
         begin
          st_i:=StGroup[i];
          if StudHasTag(tmpNum,st_i) then StudGrpFlg[st_i]:=1
           else StudGrpFlg[st_i]:=0;
         end; {for i}
      end; {methodSel=2}
   3: begin {match to}
        for i:=0 to 8 do matchArr[i]:=0; {init MatchArray}
        for i:=1 to groupNum do  {scan group}
          begin
            st_i:=StGroup[i];
            for j:=1 to 8 do
              if bool(Stud[st_i].tctag and (1 shl (j-1))) then
                 matchArr[j]:=1;
          end;{for i}
        for i:=1 to numstud do
          for j:=1 to 8 do
            begin
               if bool(Stud[i].tctag and (1 shl (j-1))) then
                 if matchArr[j]=1 then
                   begin
                    StudGrpFlg[i]:=1;
                    break;
                   end;
            end; {j}
      end; {match to}
 end; {case methodsel}
end;


procedure SetRoomGroup(methodSel:integer);
var
 i,st_i,tmpNum:      integer;
 codeStr:         string;
 matchArr:        array of integer;
begin
 if Numcodes[2]=0 then exit;
 codeStr:=uppercase(trim(groupSelStr[1]));
 tmpNum:=checkcode(2,codeStr);
 if ((tmpNum=0) and (methodSel<>3)) then exit;
 setlength(matchArr,numCodes[2]+1);
 case methodSel of
   0:begin {new}
      for i:=1 to numstud do
        if Stud[i].home=tmpNum then StudGrpFlg[i]:=1
          else StudGrpFlg[i]:=0;
     end; {new}
   1:begin {add to}
       for i:=1 to numstud do
         if Stud[i].home=tmpNum then StudGrpFlg[i]:=1;
     end; {methodSel=1}
   2:begin {select from}
       for i:=1 to groupnum do
        begin
         st_i:=StGroup[i];
         if Stud[st_i].home=tmpNum then StudGrpFlg[st_i]:=1
          else StudGrpFlg[st_i]:=0;
        end; {for i}
     end; {methodSel=2}
   3:begin {match to}
      for i:=0 to numCodes[2] do matchArr[i]:=0; {init MatchArray}
      for i:=1 to groupNum do  {scan group}
       begin
         st_i:=StGroup[i];
         matchArr[Stud[st_i].home]:=1;
       end;
      for i:=1 to numstud do
       if matchArr[Stud[i].home]=1 then
        if (Stud[i].home>0) then StudGrpFlg[i]:=1;
     end; {match to}
 end; {case methodsel}
end;

procedure SetTutorGroup(methodSel:integer);
var
 i,st_i,tmpNum:      integer;
 codeStr:         string;
 matchArr:        array of integer;
begin
 if Numcodes[1]=0 then exit;
 codeStr:=uppercase(trim(groupSelStr[1]));
 tmpNum:=checkcode(1,codeStr);
 if ((tmpNum=0) and (methodSel<>3)) then exit;
 setlength(matchArr,numCodes[1]+1);
 case methodSel of
   0:begin {new}
      for i:=1 to numstud do
        if Stud[i].tutor=tmpNum then StudGrpFlg[i]:=1
          else StudGrpFlg[i]:=0;
     end; {new}
   1:begin {add to}
       for i:=1 to numstud do
         if Stud[i].tutor=tmpNum then StudGrpFlg[i]:=1;
     end; {methodSel=1}
   2:begin {select from}
       for i:=1 to groupnum do
        begin
         st_i:=StGroup[i];
         if Stud[st_i].tutor=tmpNum then StudGrpFlg[st_i]:=1
          else StudGrpFlg[st_i]:=0;
        end; {for i}
     end; {methodSel=2}
   3:begin {match to}
      for i:=0 to numCodes[1] do matchArr[i]:=0; {init MatchArray}
      for i:=1 to groupNum do  {scan group}
       begin
         st_i:=StGroup[i];
         matchArr[Stud[st_i].tutor]:=1;
       end;
      for i:=1 to numstud do
       if matchArr[Stud[i].tutor]=1 then
       if (Stud[i].tutor>0) then StudGrpFlg[i]:=1;
     end; {match to}
 end; {case methodsel}
end;


procedure SetIDGroup(grType,methodSel:integer);
var
 i,st_i:               integer;
 codeStr,codeStr2:      string;
 byval:                 boolean;
 IDval1,IDval2:         longint;

   function StudInID(st:integer):boolean;
   var
    IDval3: longint;
    tmpStr: string;
   begin
    result:=false;
    if byval then
      begin
        IDval3:=strtointdef(Stud[st].ID,0);
        if ((IDval3>=IDval1) and (IDval3<=IDval2)) then result:=true;
      end
    else
      begin
        tmpStr:=trim(Uppercase(Stud[i].ID));
        if ((tmpStr>=codeStr) and (tmpStr<=codeStr2)) then result:=true;
      end;
   end;

begin
 codeStr:=uppercase(trim(groupSelStr[1]));
 codeStr2:=uppercase(trim(groupSelStr[2]));
 if codestr2<codeStr then codeStr2:=codestr;
 if grType=11 then byval:=true else byval:=false;
 IDval1:=strtointdef(codeStr,0); IDval2:=strtointdef(codestr2,0);
     {Groupname:='ID range'; }

 case methodSel of
   0:begin {new}
       for i:=1 to numstud do
        begin
         st_i:=i;
         if StudInID(st_i) then StudGrpFlg[st_i]:=1
              else StudGrpFlg[st_i]:=0;
        end; {for i}
       end; {methodSel=0}
    1: begin {add to}
        for i:=1 to numstud do
         begin
          st_i:=i;
          if StudInID(st_i) then StudGrpFlg[st_i]:=1;
         end; {for i}
       end; {methodSel=1}
    2: begin {select from}
        for i:=1 to groupnum do
         begin
          st_i:=StGroup[i];
          if StudInID(st_i) then StudGrpFlg[st_i]:=1
           else StudGrpFlg[st_i]:=0;
         end; {for i}
       end; {methodSel=2}
 end;  {case}
end;

procedure SetHouseGroup(methodSel:integer);
var
 a,i,st_i,tmpNum:      integer;
 codeStr:         string;
 matchArr:        array of integer;

  function StudInHouse(st:integer):boolean;
   begin
    result:=false;
    a:=Stud[st].House;
    if (a>0) and ((a=tmpNum) or (tmpNum=-1)) then result:=true;
   end;

begin
 if HouseCount=0 then exit;
 codeStr:=uppercase(trim(groupSelStr[1]));
 tmpNum:=findHouse2(codeStr);
 if codeStr='*' then tmpNum:=-1;
 if ((tmpNum=0) and (methodSel<>3)) then exit;
 setlength(matchArr,housecount+1);
 case methodSel of
   0:begin {new}
      for i:=1 to numstud do
       begin
        st_i:=i;
        if StudInHouse(st_i) then StudGrpFlg[i]:=1
          else StudGrpFlg[i]:=0;
       end;
     end; {new}
   1:begin {add to}
       for i:=1 to numstud do
        begin
         st_i:=i;
         if StudInHouse(st_i) then StudGrpFlg[i]:=1;
        end; 
     end; {methodSel=1}
   2:begin {select from}
       for i:=1 to groupnum do
        begin
         st_i:=StGroup[i];
         if StudInHouse(st_i) then StudGrpFlg[st_i]:=1
          else StudGrpFlg[st_i]:=0;
        end; {for i}
     end; {methodSel=2}
   3:begin {match to}
      for i:=0 to HouseCount do matchArr[i]:=0; {init MatchArray}
      for i:=1 to groupNum do  {scan group}
       begin
         st_i:=StGroup[i];
         matchArr[Stud[st_i].house]:=1;
       end;
      for i:=1 to numstud do
       if matchArr[Stud[i].house]=1 then
       if (Stud[i].house>0) then StudGrpFlg[i]:=1;
     end; {match to}
 end; {case methodsel}
end;

procedure SetClassGroup(methodSel:integer);
var
 a,i,st_i,tmpNum:      integer;
 tmpGroup,wcPos:       integer;
 codeStr:         string;
 matchArr:        array of integer;

  function StudInClass(st:integer):boolean;
   begin
    result:=false;
    a:=Stud[st].tcClass;
    if (a>0) then
     begin
      if (a=tmpNum) or (tmpNum=-1) then result:=true;
      if tmpGroup<>0 then if codeStr=uppercase(copy(trim(ClassCode[a]),1,wcPos-1))
        then result:=true;
     end;
   end;
begin
 if classnum=0 then exit;
 codeStr:=uppercase(trim(groupSelStr[1]));
 tmpNum:=findClass2(codeStr);tmpGroup:=0;
 if codeStr='*' then tmpNum:=-1;
 wcPos:=pos('*',codeStr);
 if wcPos>1 then
   begin
    codeStr:=copy(codeStr,1,wcPos-1);
    tmpGroup:= findClass2(codeStr);
   end;
 if ((tmpNum=0) and (tmpGroup=0) and (methodSel<>3)) then exit;
 setlength(matchArr,classnum+1);
 case methodSel of
   0:begin {new}
      for i:=1 to numstud do
       begin
        st_i:=i;
        if StudInClass(st_i) then StudGrpFlg[i]:=1
          else StudGrpFlg[i]:=0;
       end;
     end; {new}
   1:begin {add to}
       for i:=1 to numstud do
        begin
         st_i:=i;
         if StudInClass(st_i) then StudGrpFlg[i]:=1;
        end; 
     end; {methodSel=1}
   2:begin {select from}
       for i:=1 to groupnum do
        begin
         st_i:=StGroup[i];
         if StudInClass(st_i) then StudGrpFlg[st_i]:=1
          else StudGrpFlg[st_i]:=0;
        end; {for i}
     end; {methodSel=2}
   3:begin {match to}
      for i:=0 to Classnum do matchArr[i]:=0; {init MatchArray}
      for i:=1 to groupNum do  {scan group}
       begin
         st_i:=StGroup[i];
         matchArr[Stud[st_i].tcClass]:=1;
       end;
      for i:=1 to numstud do
       if matchArr[Stud[i].tcClass]=1 then
       if (Stud[i].tcClass>0) then StudGrpFlg[i]:=1;
     end; {match to}
 end; {case methodsel}
end;

procedure SetYearGroup(methodSel:integer);
var
 i,st_i,tmpNum:      integer;
 codeStr:         string;
 matchArr:        array of integer;
begin
 codeStr:=uppercase(trim(groupSelStr[1]));
 tmpNum:=findyear(codeStr);
 if ((tmpNum=-1) and (methodSel<>3)) then exit;
 setlength(matchArr,nmbrYears+1);
 case methodSel of
   0:begin {new}
      for i:=1 to numstud do
        if Stud[i].TcYear=tmpNum then StudGrpFlg[i]:=1
          else StudGrpFlg[i]:=0;
     end; {new}
   1:begin {add to}
       for i:=1 to numstud do
         if Stud[i].TcYear=tmpNum then StudGrpFlg[i]:=1;
     end; {methodSel=1}
   2:begin {select from}
       for i:=1 to groupnum do
        begin
         st_i:=StGroup[i];
         if Stud[st_i].TcYear=tmpNum then StudGrpFlg[st_i]:=1
          else StudGrpFlg[st_i]:=0;
        end; {for i}
     end; {methodSel=2}
   3:begin {match to}
      for i:=0 to nmbrYears do matchArr[i]:=0; {init MatchArray}
      for i:=1 to groupNum do  {scan group}
       begin
         st_i:=StGroup[i];
         matchArr[Stud[st_i].TcYear]:=1;
       end;
      for i:=1 to numstud do
       if matchArr[Stud[i].TcYear]=1 then
       if (Stud[i].TcYear>0) then StudGrpFlg[i]:=1;
     end; {match to}
 end; {case methodsel}
end;





procedure removeabsent(place,p: integer);
var
 found,i,a: integer;
begin
 a:=0;
 if numchanges=0 then exit;
 found:=0;
 for i:=1 to numchanges do
 begin
  if (Changes[i].timeslot=p) then
   if (Changes[i].oldte=place) then
   begin
    found:=-1; a:=i; break;
   end;
 end; {for i}
 if not(bool(found)) then exit;
 if (Changes[a].gen=1) and bool(Changes[a].needroom) then
  begin removeteacher1(a); Changes[a].newte:=place; Changes[a].kind:=0;
     Changes[a].gen:=0; Changes[a].needte:=0; exit; end;
 if (Changes[a].gen<>1) and (Changes[a].gen<>4) then exit;
 deletechange(a);
end;


Procedure GetTTsub(myte,ttperiod: integer);
var
 y,l:  integer;
 afnt,bfnt:      tpintpoint;
begin
 ttroom:=0; ttsub:=0; ttlevel:=0; ttyear:=0; ttshare:=0; tsharecount:=0;
 ttfound:=false;
 for y:=0 to years_minus_1 do
  begin
   afnt:=FNT(ttday,ttperiod-1,y,0,2);
   for l:=1 to level[y] do
    begin
     inc(afnt,4); bfnt:=afnt;
     if myte=afnt^ then
      begin
       dec(bfnt); ttsub:=bfnt^;
       inc(bfnt,2); ttroom:=bfnt^;
       ttshare:=FNTbyte(ttday,ttperiod-1,y,l,6)^ and 2;
       ttyear:=y; ttlevel:=l; ttfound:=true;
       if bool(ttshare) then inc(tsharecount);
      end;
    end; {l}
  end; {y}
end;

procedure addabsent(place,p: integer);
  var
   found,i,a: integer;

//   function GetReason: integer;
//   var
//     sl: TStringList;
//   begin
//     try
//       sl := TStringList.Create;
//       sl.Delimiter := ';';
//       sl.DelimitedText := tabsreasons[place];
//       Result := StrToInt(sl[p]);
//     finally
//       sl.Free;
//     end;
//   end;

  begin
   GetTTsub(place,p);
   if not(ttfound) then exit;
   if place=0 then exit;
   found:=0;
   if numchanges>0 then
   begin
    for i:=1 to numchanges do
    begin
     if (Changes[i].gen<4) and (Changes[i].timeslot=p) and (Changes[i].oldte=place) then
     begin
      found:=-1;
      a:=i;
      if (Changes[a].gen=0) and (Changes[a].newte=place) then
      begin
       Changes[a].newte:=0; Changes[a].needte:=-1; Changes[a].gen:=1;
      end;
      break;
     end;
    end; {for i}
    if bool(found) or (numchanges=nmbrchanges) then exit;
   end;
   inc(numchanges); a:=numchanges;
   Changes[a].timeslot:=p; Changes[a].year:=ttyear; Changes[a].level:=ttlevel; Changes[a].sub:=ttsub;
   Changes[a].oldte:=place; Changes[a].newte:=0; Changes[a].oldroom:=ttroom; Changes[a].newroom:=ttroom;
   Changes[a].kind:=0; Changes[a].needte:=-1; Changes[a].needroom:=0; Changes[a].notes:=0;
   Changes[a].gen:=1; Changes[a].reason:=tabsreason[place];

   { Previously, only one reason has been attached to all changes in the timeslot }
   { Later versions already support multiple reasons with each timeslot
     having a reason recorded against it }
   // Changes[a].reasons := tabsreasons[place];
 end;

procedure updateteacherMap;
var
 i,p,slot:       integer;
 a:         string;
 lostflag,emptyflag,NAflag: boolean;
begin
 for i:=1 to numcodes[1] do
 begin
  temap[i]:='';
  for p:=1 to tlimit[ttday] do
  begin
   lostflag:=false; NAflag:=false; emptyflag:=true; a:='-'; slot:=(1 shl p);
   if (teach[i] and slot)=0 then begin a:='T'; emptyflag:=false; end;
   if (tena[i] and slot)=0 then begin a:='N'; NAflag:=true; end;
   if (telost[i] and slot)=0 then begin a:='L'; lostflag:=true; end;
   if (teCover[i] and slot)=0 then a:='C';
   if (tereplace[i] and slot)=0 then a:='R';
   if (tElieu[i] and slot)=0 then a:='I';
   if (teAbsent[i] and slot)=0 then
   begin
    a:='A';
    if emptyflag or lostflag or NAflag then a:='a';
   end;
   temap[i]:=temap[i]+a;
  end;  {for p}
 end; {for i}
end;

function INTtoBINstr(a: integer): string;
var
 s:      string;
 i:      integer;
begin
 s:='';
 for i:=15 downto 0 do
  if bool(a and (1 shl i)) then s:=s+'1'
   else s:=s+'0';
 result:=s;
end;

function BINstrtoINT(a: string): integer;
var
 i,j: integer;
begin
 j:=0;
 for i:=1 to 10 do
  if a[i]='1' then j:=j+(1 shl (10-i));
 result:=j;
end;

function readFileLine(var f:file): string;
var
 s: ShortString;
 ch:  char;
begin
 s:='';
  try
   while not eof(f) do
    begin
     blockread(f,ch,1);
     s:=s+ch;
     if copy(s,Length(s)-1,2)=endline then break;
    end;
  except

  end;
 if copy(s,Length(s)-1,2)=endline then dec(s[0],2);
 result:=s;
end;

function findaddedstaff(c: string):integer;
var
 i,j:      integer;
begin
 j:=0; c:=uppercase(trim(c));
 if ETnum1>0 then for i:=1 to ETnum1 do
  if uppercase(trim(etsub[ETpointer[i]]))=c then
   begin
    j:=i; break;
   end;
 result:=j;
end;

function findaddedstaffsel(c: string):integer;
var
 i,j:      integer;
begin
 j:=0;  c:=uppercase(trim(c));
 if ETnum1>0 then
  for i:=1 to ETnum1 do
   if uppercase(trim(etsub[ETpointer2[i]]))=c then
    begin
     j:=i; break;
    end;
 result:=j;
end;


procedure clearStudListBoxSelections;
begin
 studentttselection[0]:=0;
 liststudentselection[0]:=0;
end;



procedure rangeCheckCodeSels(var aa: tpTeData; code: smallint);
var
 i,j,k:     smallint;
 tmp:     tpTeData;
begin
 fillchar(tmp,sizeof(tmp),chr(0));

 if aa[0]>0 then
 begin
  for i:=1 to aa[0] do
  begin
   j:=aa[i];
   if ((j>0) and (j<=numcodes[code])) then {range}
   begin
    if (copy(tecode[j,code-1],1,2)<>'00') then   {deletion}
    begin
     inc(tmp[0]);
     tmp[tmp[0]]:=aa[i];
    end;
   end;
  end; {for i}

  if tmp[0]>0 then for i:=1 to tmp[0] do aa[i]:=tmp[i];
  aa[0]:=tmp[0];
  fillchar(tmp,sizeof(tmp),chr(0));  
  j:=0;
  if aa[0]>0 then {remove duplicates}
   for i:=1 to aa[0] do
    begin
     k:=aa[i];
     if tmp[k]=0 then begin inc(j); aa[j]:=k; tmp[k]:=1; end;
    end;
  aa[0]:=j;
 end;
end;

procedure rangeCheckSubSels(var aa: tpSubData{; code: integer});
var
 i,j:     integer;
 tmp:     ^tpSubData;
begin
 new(tmp);           fillchar(tmp^,sizeof(tmp^),chr(0));

 if aa[0]>0 then
 begin
  for i:=1 to aa[0] do
  begin
   j:=aa[i];
   if ((j>0) and (j<=numcodes[0{code}])) then {range}
   begin
    if (copy(subcode[j],1,2)<>'00') then   {deletion}
    begin
     inc(tmp^[0]);
     tmp^[tmp^[0]]:=j;
    end;
   end;
  end; {for i}

  if tmp^[0]>0 then
  begin
   for i:=1 to tmp^[0] do
    aa[i]:=tmp^[i];
  end;
   aa[0]:=tmp^[0];
 end;

 Dispose(tmp);
end;


procedure rangeCheckStudSels(var aa: tpstudentdata);
var
 i:     integer;
 tmp:     ^tpstudentdata;
begin
 new(tmp);           fillchar(tmp^,sizeof(tmp^),chr(0));

 if aa[0]>0 then
 begin
  for i:=1 to aa[0] do
  begin
   if ((aa[i]>0) and (aa[i]<=numstud)) then
   begin
    inc(tmp^[0]);
    tmp^[tmp^[0]]:=aa[i];
   end;
  end; {for i}

  if tmp^[0]>0 then
  begin
   for i:=1 to tmp^[0] do
    aa[i]:=tmp^[i];
  end;
  aa[0]:=tmp^[0];
 end;

 Dispose(tmp);
end;





procedure saveWinDisplayDo;
var
  len:        byte;
  i,j,cI,cJ,kk,dummysmall:          smallint;
  fname,tname: string;
  tmpStr:     string;
  tmpFs:      tFontStyles;
begin
 try
  try
   fname:='EXDISPLAY5.DAT';
   tname:='EXDISPLAY5.TMP';
   ourSafetyMemStreamStr:='';
   ourSafetyMemStream:=TStringStream.Create(ourSafetyMemStreamStr);
   {start}
   with ourSafetyMemStream do
    begin
     {time chart's font}
     tmpStr:=TcFont.name; len:=Length(tmpStr); Write(len,1);
     Write(Pchar(@tmpStr[1])^,len);
     tmpFs:=tcFont.style; Write(Pchar(@tmpFs)^,sizeof(TFontstyles));
     i:=Tcfont.size; Write(i,2);
    {window pos}
     Write(winOrderNum,2);
     if winOrderNum>0 then for i:=1 to winOrderNum do Write(winOrder[i],2);
     i:=nmbrWindows; Write(i,2);
     for i:=0 to nmbrWindows do Write(Pchar(@winPos[i])^,sizeof(winPos[i]));

     for i:=0 to 2 do Write(sorttype[i],2);
     i:=nmbrWindows; Write(i,2);
     for i:=1 to nmbrWindows do Write(winView[i],2);

     Write(MatchAllYears,sizeof(boolean));
     {stud list win}
     Write(StudListType,2); Write(listnumbertype,2);
     {stud list dialog}
     for i:=1 to 4 do
      for j:=1 to 2 do Write(listRanges[i,j],2);
     cI:=liststudentselection[0]; Write(cI,2);
     if cI>0 then for i:=1 to cI do Write(liststudentselection[i],2);
     {sub list dialog}
     Write(subbysublisttype,2); Write(subbysublisttypegroupnum,2);
     cI:=nmbrOfgroupsubjects; Write(cI,2);
     for i:=-2 to nmbrOfgroupsubjects do Write(sublistRanges[i],2);
     Write(sublistfacnum,2); Write(sublistday,2); Write(sublistyear,2);
     Write(sublisttime1,2); Write(sublisttime2,2); Write(sublistfree,2);
     {stud ttable}
     cI:=studentttselection[0]; Write(cI,2);
     if cI>0 then for i:=1 to cI do Write(studentttselection[i],2);
     Write(stuttlistselection,2);  Write(dummysmall,2);
     for i:=1 to 8 do Write(stuttlistvals[i],2);
     {teach ttable}
     cI:=tettselection[0]; Write(cI,2);
     if cI>0 then for i:=1 to cI do Write(tettselection[i],2);
     Write(tettseltype,2); Write(dummysmall,2);
     for i:=1 to 5 do Write(tettlistVals[i],2);
     {room ttable}
     cI:=rottselection[0];  Write(cI,2);
     if cI>0 then for i:=1 to cI do Write(rottselection[i],2);
     Write(rottseltype,2);  Write(dummysmall,2);
     for i:=1 to 5 do Write(rottlistVals[i],2);
     {sub ttable}
     Write(subttlistSelection,2);
     for i:=1 to 4 do Write(subttlistVals[i],2);
     Write(subttgroupcnt,2);  cI:=subttgroupcnt;
     if cI>0 then for i:=1 to cI do Write(subttgroup[i],2);
     {tt prnt seldlg}
     cI:=ttprntselsubg[0]; Write(cI,2);
     if cI>0 then for i:=1 to cI do Write(ttprntselsubg[i],2);
     cI:=ttprntselteachg[0]; Write(cI,2);
     if cI>0 then for i:=1 to cI do Write(ttprntselteachg[i],2);
     cI:=ttprntselroomg[0]; Write(cI,2);
     if cI>0 then for i:=1 to cI do Write(ttprntselroomg[i],2);
     Write(ttprntseltype,2);   Write(ttPrntFac,2);
     Write(ttprntselday,2);    Write(ttprntselyear,2);
     Write(ttPrntType,2);
     {margins etc}
     Write(prntLeftMargin,4); Write(prntTopMargin,4);{single so 4 bytes}
     Write(datestamp,sizeof(boolean));
     {preferences}  {general}
     Write(prefNotebookPageIndex,2);
     Write(GroupIndexDisplay, 2);   //Write(dummysmall,2);
     Write(colorPrinterFlag,sizeof(colorPrinterFlag));
     {student section}
     Write(sTsex,sizeof(boolean));    Write(sTClass,sizeof(boolean));
     Write(sTHouse,sizeof(boolean));  Write(sTID,sizeof(boolean));
     Write(sTyear,sizeof(boolean));   Write(sTTutor,sizeof(boolean));
     Write(sTHome,sizeof(boolean));   Write(double_space,2);
     Write(sTselect,2);  Write(Sexselect,2); Write(listEnrolment,2);
     {timetable section}
     cI:=periods; write(cI,2);
     for i:=0 to periods-1 do write(tsOn[1,i],sizeof(boolean));
     cI:=nmbryears;    Write(cI,2);
     for i:=0 to nmbryears do  Write(Pyear[i],sizeof(boolean));
    cI:=0;      Write(cI,2);  {was nmbrdays for write of tlimit}
    cI:=nmbrdays;      Write(cI,2);
     for i:=1 to nmbrdays do  Write(Dprint[i],sizeof(boolean));
     Write(Tfreeshow,sizeof(boolean));  Write(Rfreeshow,sizeof(boolean));
     Write(Pweek,2);                    Write(Tyr,2);
     Write(Pchar(@yearTitle[0])^,5);    Write(Pchar(@yearShort[0])^,3);
     {extras list settings}
     Write(ESprint,sizeof(ESprint));    Write(ESteach,sizeof(ESteach));
     Write(ESreason,sizeof(ESreason));  Write(EStlost,sizeof(EStlost));
     Write(ESroom,sizeof(ESroom));      Write(ESrlost,sizeof(ESrlost));
     Write(ESadd,sizeof(ESadd));        Write(ESnew,sizeof(ESnew));
     Write(ESmerge,sizeof(ESmerge));    Write(EPteach,sizeof(boolean));
     Write(EProom,sizeof(boolean));     Write(EPblank,2);
     Write(EPreason,sizeof(boolean));   Write(EPlist,sizeof(boolean));
     Write(coverall,2);                 Write(autocover,2);
     Write(coverstart,2);               Write(ShowcoverTimetable,sizeof(boolean));
     Write(ExcoverTop,sizeof(ExcoverTop));
     Write(ExcoverLeft,sizeof(ExcoverLeft));
     Write(ManCoverTop,sizeof(ManCoverTop));
     Write(ManCoverLeft,sizeof(ManCoverLeft));
     cI:=nmbryears;     Write(cI,2);
     if cI>0 then  for i:=0 to cI do  Write(CoverYear[i],sizeof(boolean));
     {ignore changes -exclude years and pref}
     cI:=szIgnoreStatusMsg; Write(cI,2);
     tmpstr:=RpadString(IgnoreStatusMsg,szIgnoreStatusMsg);
     Write(tmpstr[1],szIgnoreStatusMsg);
     Write(IgnoreStatusMsgFlag,sizeof(IgnoreStatusMsgFlag));
     {absent teacher views}
     Write(absorttype,2);   Write(teamexclude,sizeof(teamexclude));
     {added staff view}
     Write(assorttype,2);
    {added staff sel view}
     Write(UseGroupFindStud,2);   Write(asSelsorttype,2);
     {lost class view}
     Write(lcsorttype,2);   Write(shareExclude,sizeof(shareExclude));
     Write(edLostClassYear,2);       Write(edLostClassSub,2);
     Write(edLostClassClass,2);      Write(edLostClassLevto,2);
     Write(edLostClassLevfrom,2);    Write(edLostClassBy,2);
     {current extras view}
     Write(winCurrentExtrasBrief2,2);  Write(winCurrentExtrasyear,2);
     Write(winCurrentExtrasCode,2);
     Write(IncludeShareFlag,sizeof(IncludeShareFlag));
     for kk:=1 to 3 do
     begin
      Write(winCurrentExtrasSelectionCount[kk],2);
      if winCurrentExtrasSelectionCount[kk]>0 then
       for i:=1 to winCurrentExtrasSelectionCount[kk] do
        Write(winCurrentExtrasSelection[kk][i],2);
     end; {for kk}
     {past extras view}
     Write(winpastExtrasBrief2,2);  Write(winpastExtrasyear,2);
     Write(winpastExtrasCode,2);    Write(peday1,2);
     Write(pemonth1,2);             Write(peday2,2);
     Write(pemonth2,2);             Write(pedetail,2);
     Write(pecover,2);
     for kk:=1 to 5 do
     begin
      Write(winPastExtrasSelectionCount[kk],2);
      if winPastExtrasSelectionCount[kk]>0 then
       for i:=1 to winPastExtrasSelectionCount[kk] do
        Write(winPastExtrasSelection[kk,i],2);
     end; {for kk}
     Write(Formfeed,2);   Write(globalHints,2);
     Write(OKbackup,2);   Write(OKquitcheck,2);
     Write(EnableAutoFlag,2);    Write(ToolBarFlag,sizeof(ToolBarFlag));
     Write(txtsep,2);            Write(txtlim,2);
     Write(FAsubnum,2);          Write(CusEallotYear,2);
     Write(CusEallotDay,2);      cI:=years; Write(cI,2);
     for i:=0 to years_minus_1 do   Write(level[i],2);
     Write(GenericTtableFlag,2);  Write(customFileLoadFlag,2);
     if customFileLoadFlag then
     begin
      tmpstr:=custom+'.cus';
      cI:=length(tmpstr);
      Write(cI,2);
      Write(Pchar(@tmpstr[1])^,cI);
     end;
     Write(EmailCoverFlag,2);    Write(EmailAbsentFlag,2);
     Write(EmailAddedFlag,2);
     cI:=days; write(cI,2);
     cJ:=periods; write(cJ,2);
     if cI>1 then
      for i:= 2 to cI do
       for j:=0 to cJ-1 do
         write(tsOn[i,j],sizeof(boolean));

     // Barcode on Student Lists
     Write(stBarcode,sizeof(boolean));

     //Extras Pref Start/End Times
     Write(EPTimes,sizeof(boolean));

     // Plain SMTP Flag
     Write(EmailPlainSMTP,2);

     {teachers free dlg}
     cI:=TeFreeSelect[0];
     Write(cI,2);
     if cI>0 then
      for i:=1 to cI do
        Write(TeFreeSelect[i],2);
      Write(teachersfreeday,2);
      Write(TeFreePeriod,2);
      Write(teachersfreefac,2);
      Write(teachersfreeshow1,2);
      Write(teachersfreeshow2,2);
      Write(teFreeYear,2);

    end;
   SafelyStreamToFile(tname,fname);
  finally
   ourSafetyMemStream.free;
  end;
 except
 end;
end;


procedure saveWinDisplay;
var
  msg:     string;

begin
 if (usrPassLevel=0) then exit;
 if verifyUserDirectory(usrPassDir)>0 then exit;
 try
  chdir(usrPassDir);
  saveWinDisplayDo;
 except
  screen.cursor:=crDefault;
  msg:='Your preferences could not be saved';
  msg:=msg+endline+'to EXDISPLAY5.DAT'+endline;
  msg:=msg+'in '+usrPassDir;
  messagedlg(msg,mtError,[mbOK],183);
 end;
end;

function FNycSHARED(d,p,te,b: smallint):string;
var
 block1,year1,level1,year2,level2: smallint;
 found,found2:              bool;
 share,sbyte:              smallint;
 yi,li:              smallint;
 aFnt,bFnt,cFnt:               tpintpoint;
 astr,cstr,bstr,dstr:          string;
begin     {b=1 te  b=2 ro}
 bFnt:=nil;
 year2:=-1; year1:=-1;
 level1:=0; level2:=0; block1:=0;
 found:=false; share:=0; found2:=false;
 for yi:=0 to years_minus_1 do
 begin
  for li:=1 to level[yi] do
  begin
   aFnt:=FNT(d,p,yi,li,0); bFnt:=aFnt; inc(bFnt,b);
   if (found and (share>0) and (bFnt^=te)) then
   begin
    year2:=yi; level2:=li; found2:=true; break;
   end;
   if ((share=0) and (bFnt^=te)) then
   begin
    found:=true;
    cFnt:=afnt; inc(cFnt,3); sbyte:=cFnt^;
    block1:=FNgetBlockNumber(d,p,yi,li);
    year1:=yi; level1:=li; share:=(sbyte and 2);
    if share=0 then break;
   end;
  end; {for li}
  if (found and (share>0) and (bFnt^=te)) then break;
  if ((share=0) and (bFnt^=te)) or found2 then break;
 end; {for yi}
 astr:='';   cstr:='';
 if year1>-1 then astr:=trim(ClassCode[ClassShown[level1,year1]]);
 if (year2>-1) then cstr:=trim(ClassCode[ClassShown[level2,year2]]);
 bstr:='';  dstr:='';

 if year1>-1 then bstr:=yearshort+trim(copy(yearname[year1],1,5));
 if (year2>-1) then dstr:=trim(copy(yearname[year2],1,5));
 if tyr=1 then
 begin
  astr:=bstr;  cstr:=dstr;
 end;
 if tyr=0 then
  if (boolean(block1) or (astr='')) then
  begin
   astr:=bstr;  cstr:=dstr;
  end;
 if ((tyr=3) or (level1=0)) then
 begin
  astr:=''; cstr:='';
 end;
 astr:=trim(astr); cstr:=trim(cstr);

 if (year2>-1) then astr:=astr+'/'+cstr;
 FNycSHARED:=astr;
end;




procedure findstudentWinSelect;
begin
if wnFlag[wnFindStud] then findstudent.show
 else findstudent:=tfindstudent.create(application);
end;


procedure AbsReasonsWinSelect;
begin
if wnFlag[wnAbsReason] then AbsReasonWin.show
 else AbsReasonWin:=tAbsReasonWin.create(application);
end;

procedure TimesWinSelect;
begin
if wnFlag[wnTimes] then TimesWindow.show
 else TimesWindow:=tTimesWindow.create(application);
end;


procedure CoverNotesWinSelect;
begin
if wnFlag[wnCoverNote] then CoverNotesWin.show
  else CoverNotesWin:=tCoverNotesWin.create(application);
end;


procedure AddedStaffWinSelect;
begin
if wnFlag[wnAddedStaff] then Addedstaffwin.show
 else Addedstaffwin:=tAddedstaffwin.create(application);
end;



procedure AbsentteWinSelect;
begin
if wnFlag[wnAbsentTe] then Absentte.show
  else Absentte:=tAbsentte.create(application);
end;


procedure saveReasons;
var
 i:   integer;
 aStr:    string;
 fname,tname: string;
begin
 chdir(Directories.datadir);
 if FileExists(REASONS_XML_FILE) then begin
   saveReasons_xml;
   exit;
 end;

 try
  try
   fname:='REASON.DAT';
   tname:='REASON.TMP';
   ourSafetyMemStreamStr:='';
   ourSafetyMemStream:=TStringStream.Create(ourSafetyMemStreamStr);
   with ourSafetyMemStream do
    begin
     aStr:='TCV6';    Write(Pchar(@aStr[1])^,4);
     for i:=1 to nmbrReasons do
     begin
      astr:=RpadString(Abcode[i],szAbcode);  Write(Pchar(@astr[1])^,szAbcode );
      astr:=RpadString(Absent[i],szAbReason);
      Write(Pchar(@astr[1])^,szAbReason);
     end; {for i}
     for i:=1 to nmbrReasons do
     begin
      astr:=RpadString(Cover[i],szCovNotes); // szEcomment
      Write(Pchar(@astr[1])^,szCovNotes);  // szEcomment
     end; {for i}
    end;
   SafelyStreamToFile(tname,fname);
  finally
   ourSafetyMemStream.Free;
   NEW_DateChecks[4]:=FileDateToDateTime(fileage(fname));
   fwAbsence:=getAbsenceFontWidths(mainform.canvas);
  end;
 except
 end;
end;

procedure ETout;
var
 astr:    string;
 fname,tname,s: string;
 i:       integer;
 l:       integer;
begin
 chdir(Directories.datadir);
 try
  fname:='EMTEACH.DAT';
  tname:='EMTEACH.TMP';
  ourSafetyMemStreamStr:='';
  ourSafetyMemStream:=TStringStream.Create(ourSafetyMemStreamStr);
  with ourSafetyMemStream do
   begin
    astr:='TCV5';  Write(Pchar(@astr[1])^,4);
    Write(Etnum,2); Write(Etlencodes,2);
    if Etnum>0 then
     for i:=1 to Etnum do
      begin
       etsub[i]:=RpadString(etsub[i],Etlencodes);
       s:=etsub[i];
       Write(Pchar(@s[1])^,Etlencodes);
       etsub[i]:=trim(etsub[i]);
       ETname[i]:=RpadString(ETname[i],szTename);
       s:=ETname[i];
       Write(Pchar(@s[1])^,szTename);
       ETname[i]:=trim(ETname[i]);
       // #171
       //Etcomment[i]:=RpadString(Etcomment[i],szEcomment);
       //s:=Etcomment[i];
       //Write(Pchar(@s[1])^,szEcomment);
       l:=Length(ETComment[i]);
       s:=Etcomment[i];
       Write(l,2);  // Size of Comment
       Write(Pchar(@s[1])^,l); // Comment
       Etcomment[i]:=trim(Etcomment[i]);
       Write(ETfaculty[i],2);
       Write(ETfaculty2[i],2);
       Write(ETfaculty3[i],2);
       Write(ETfaculty4[i],2);
       // #173
       ETPhone[i] := RPadString(ETPhone[i],15);
       s:=ETPhone[i];
       Write(PChar(@s[1])^,15);
       Write(ETPriority[i],2);
       Write(ETMon[i],2);
       Write(ETTue[i],2);
       Write(ETWed[i],2);
       Write(ETThu[i],2);
       Write(ETFri[i],2);
       Write(ETSat[i],2);
       Write(ETSun[i],2);
      end; {for i}
   end;
  SafelyStreamToFile(tname,fname);
 finally
  ourSafetyMemStream.Free;
  NEW_DateChecks[2]:=FileDateToDateTime(fileage(fname));
 end;
 Etsort2;   etsort3;
 SaveETmail;
end;


procedure saveCoverData;
var
 astr:   string;
 fname,tname: string;
begin
 astr:='TCE5';
 chdir(Directories.datadir);
 try
  try
   fname:='COVERSET.DAT';
   tname:='COVERSET.TMP';
   ourSafetyMemStreamStr:='';
   ourSafetyMemStream:=TStringStream.Create(ourSafetyMemStreamStr);
   with ourSafetyMemStream do
    begin
     Write(Pchar(@astr[1])^,4);
     Write(WtET,2);    Write(WtFrees,2);  Write(WtToday,2);
     Write(WtAvail,2); Write(WtPerc,2);   Write(WtETfac,2);
     Write(WtWeek,2);  Write(WtLastNum,2); Write(WtLast,2);
     Write(Wtfac,2);   Write(WtSpare,2);   Write(WtLieu,2);
     Write(WtReplace,2);   Write(WtPrefer,2);  Write(KeepReplaceFlag,2);
    end;
   SafelyStreamToFile(tname,fname);
  finally
   ourSafetyMemStream.Free;
   NEW_DateChecks[6]:=FileDateToDateTime(fileage(fname));
  end;
 except
 end;
end;


procedure calculateTeach;
var
 i,p,y,L,te,sub,ro:   integer;
 aFnt,bFnt:      tpintpoint;
begin
 for i:=1 to numcodes[1] do begin teach[i]:=-1; tena[i]:=-1; end;
 for i:=1 to numcodes[2] do begin roomteach[i]:=-1;rolost[i]:=-1; end;
 for p:=1 to Tlimit[ttDay] do
  for y:=0 to years_minus_1 do
  begin
   aFnt:=FNT(ttDay,(p-1),y,0,0);
   for L:=1 to level[y] do
   begin
    inc(aFnt,4);
    sub:=aFnt^; bFnt:=aFnt; inc(bFnt);
    te:=bFnt^;
    if ((te>0) and (te<=numcodes[1]) and (sub > 0)) then
    begin
     teach[te]:=teach[te] and (not(1 shl p));
     if (subNA>0) and (sub=subNA) then tena[te]:=tena[te] and (not(1 shl p));
    end;
    inc(bFnt);     ro:=bFnt^;
    if ((ro>0) and (ro<=numcodes[2])) then
     begin
      roomteach[ro]:=roomteach[ro] and (not(1 shl p));
      if (te>0) then if (telost[te] and (1 shl p))=0 then
            rolost[ro]:=rolost[ro] and (not(1 shl p));
     end;
   end; {for L}
  end; {for y}
end;

procedure teacherAbsence(ETplace,place: integer);
var
 p:       integer;

  procedure addAbsent;
  var
   i,y,L,year1,level1,a:       integer;
   found:                      bool;
   te,sub,ro:                  integer;
   aFnt,bFnt:                  tpintpoint;

     procedure ETflags;
     begin
       Eton[ETplace]:=Eton[ETplace] and (not(1 shl p));
       Ettaught[ETplace]:=Ettaught[ETplace]+getEallot(1,year1,ttday,p);
     end;
  begin
   found:=false; ro:=0; level1:=0;  sub:=0;
   for y:=0 to years_minus_1 do
   begin
    aFnt:=FNT(ttday,p-1,y,0,0);
    for L:=1 to level[y] do
    begin
     inc(aFnt,4); bFnt:=aFnt; inc(bFnt);
     te:=bFnt^;
     if te=place then
     begin
      sub:=aFnt^; inc(bFnt);
      ro:=bFnt^; found:=true; year1:=y; level1:=L; break;
     end;
    end; {for L}
    if found then break;
   end; {for y}
   if not(found) then exit;
   found:=false;
   if numchanges>0 then
   begin
    for i:=1 to numchanges do {REM IF already there as room change only, add flags for teacher change}
     if Changes[i].timeslot=p then
      if Changes[i].oldte=place then if (ETon[ETplace] and (1 shl p))<>0 then
      begin
       found:=true; Changes[i].kind:=1; Changes[i].gen:=1; Changes[i].needte:=0; Changes[i].newte:=etplace;
       Changes[i].reason:=tabsreason[place];
       ETflags;
       break;
      end;
    if found or (numchanges=nmbrChanges) then exit;
   end;
   inc(numchanges); a:=numchanges;
   Changes[a].timeslot:=p; Changes[a].year:=year1;  Changes[a].level:=level1;
   Changes[a].sub:=sub;  Changes[a].oldte:=place;   Changes[a].oldroom:=ro;
   Changes[a].newroom:=ro; Changes[a].gen:=1;  Changes[a].needroom:=0;
   Changes[a].notes:=0;  Changes[a].reason:=tabsreason[place];
   if (Eton[ETplace] and (1 shl p))<>0 then  //if added staff avail
   begin
    Changes[a].needte:=0; Changes[a].newte:=etplace;
    Changes[a].kind:=1;
    ETflags;
   end
    else
   begin
    Changes[a].newte:=0; Changes[a].needte:=-1;
    Changes[a].kind:=0;
   end;
  end;


begin {teacher absence}
 ETavail[ETplace]:=-1;
 for p:=1 to tlimit[ttDay] do
 begin
  if bool(tena[place] and (not(teon[place]))) then
   if ((teAbsent[place] and (1 shl p))=(1 shl p))  then  //only if not already absent
    begin
     teAbsent[place]:=teAbsent[place] and (not(1 shl p));  //set it for that tslot
     addAbsent;
    end;
 end; {for p}
end;

procedure checkLinks;
var
 i,te:       integer;
begin
 for i:=1 to ETnum do
  begin
   if ETlink[i]<0 then
    begin
     te:=ABS(ETlink[i]);
     if ((te>0) and (te<=numcodes[1])) then
      teacherAbsence(i,te);
    end;
  end; {for i}
end;


procedure checkLost;
var
 i:       integer;
begin     {REM Can only have a lost room if teaching}
 for i:=1 to numcodes[2] do rolost[i]:=rolost[i] or roomteach[i];
end;


procedure checkInLieus;
var
 i,p,te:       integer;
begin
 for i:=1 to numcodes[1] do
  telieudbl[i]:=Elieu[i]-Elieutaken[i];
 if numchanges=0 then exit;
 for i:=1 to numchanges do
 begin
  if Changes[i].kind=3 then
  begin
   p:=Changes[i].timeslot; te:=Changes[i].newte;
   if getEallot(1,Changes[i].year,ttday,p)>(telieudbl[te]+0.00001) then
   begin
    Changes[i].newte:=0; Changes[i].kind:=0; Changes[i].needte:=-1;
    tElieu[te]:=tElieu[te] or (1 shl p);
    teon[te]:=teon[te] or (1 shl p);
   end
   else
    telieudbl[te]:=telieudbl[te]-getEallot(1,Changes[i].year,ttday,p);
  end;
 end; {for i}
end;


procedure checkReplace;
var  i,p,te:    integer;
begin
 for i:=1 to numcodes[1] do
 begin
  if KeepReplaceFlag then teavail[i]:=Ereplace[i] else teavail[i]:=0;
  tereplace[i]:=-1;
  for p:=1 to tlimit[ttDay] do
   if bool((not(telost[i])) and (not(teach[i])) and teAbsent[i]
    and (1 shl p)) then teavail[i]:=teavail[i]+getEallot(2,i,ttday,p);
 end; {for i}
 if numChanges=0 then exit;
 for i:=1 to numchanges do
  if ((Changes[i].kind=2) and (Changes[i].gen<>4) and (Changes[i].newte>0)) then
  begin
   p:=Changes[i].timeslot; te:=Changes[i].newte;
   if getEallot(1,Changes[i].year,ttday,p)>(teavail[te]+0.00001) then
   begin
    Changes[i].newte:=0; Changes[i].kind:=0; Changes[i].needte:=-1; teon[te]:=teon[te] or (1 shl p);
   end
   else
    begin
     tereplace[te]:=tereplace[te] and (not(1 shl p));
     teavail[te]:=teavail[te]-getEallot(1,Changes[i].year,ttday,p);
    end;
  end;
end;


procedure teacherMap;
var
 i,p,slot:       integer;
 a:         string;
 lostflag,emptyflag,NAflag: bool;

begin
 checkLost;
 checkInLieus;
 checkReplace;
 for i:=1 to numcodes[1] do
 begin
  temap[i]:='';
  for p:=1 to tlimit[ttDay] do
  begin
   lostflag:=false; NAflag:=false; emptyflag:=true; a:='-'; slot:=(1 shl p);
   if (teach[i] and slot)=0 then begin a:='T'; emptyflag:=false; end;
   if (tena[i] and slot)=0 then begin a:='N'; NAflag:=true; end;
   if (telost[i] and slot)=0 then begin a:='L'; lostflag:=true; end;
   if (teCover[i] and slot)=0 then a:='C';
   if (tereplace[i] and slot)=0 then a:='R';
   if (tElieu[i] and slot)=0 then a:='I';
   if (teAbsent[i] and slot)=0 then
   begin
    a:='A';
    if emptyflag or lostflag or NAflag then a:='a';
   end;
   temap[i]:=temap[i]+a;
  end;  {for p}
 end; {for i}
end;

procedure ClearChanges;
var
 i,te:   integer;
 tempreason:                 tptedata;
begin
 numchanges:=0; notenum:=0;
 for i:=1 to nmbrChanges do
  begin
   Changes[i].timeslot:=0;  Changes[i].year:=0;   Changes[i].level:=0;
   Changes[i].sub:=0;       Changes[i].oldte:=0;   Changes[i].newte:=0;
   Changes[i].oldroom:=0;    Changes[i].newroom:=0; Changes[i].kind:=0;
   Changes[i].needte:=0;     Changes[i].needroom:=0;
   Changes[i].notes:=0;      Changes[i].reason:=0;  Changes[i].gen:=0;
  end;
 for i:=1 to numcodes[1] do tempreason[i]:=Tabsreason[i];
 for i:=1 to nmbrTeachers do
   begin
    teach[i]:=-1;   telost[i]:=-1; teCover[i]:=-1;   tereplace[i]:=-1;
    tElieu[i]:=-1;  tena[i]:=-1;   telieudbl[i]:=Elieu[i]-Elieutaken[i];
    Tabsreason[i]:=0; teon[i]:=0;  teAbsent[i]:=-1;
    teavail[i]:=0;    doingextra[i]:=0;
    roAbsent[i]:=-1;  roomon[i]:=0; roomteach[i]:=-1; roswap[i]:=-1;
    roCover[i]:=-1;   rolost[i]:=-1;
   end;
 if ETnum>0 then
  for i:=1 to ETnum do
   if ETlink[i]<0 then
    begin
     te:=ABS(ETlink[i]);
     if ((te>0) and (te<=numcodes[1])) then TabsReason[te]:=tempreason[te];
    end;
end;


procedure extrasin;
var
 i:       integer;
 fname,astr:   string;
 f:            file;
 te,sub,ro:      smallint;
 CtimeslotI,CyearI,ClevelI,CsubI,oldteI,newteI,oldroomI,newroomI,kindI,
 needteI,needroomI,NotesI,ReasonI: smallint;

procedure roomsLost;
var
 i,p,y,L,share: integer;
 aFnt,bFnt:       tpintpoint;
begin
 for i:=1 to numcodes[2] do rolost[i]:=-1;
 for p:=1 to tlimit[ttDay] do
  for y:=0 to years_minus_1 do
  begin
   aFnt:=FNT(ttDay,p-1,y,0,0);
   for L:=1 to level[y] do
   begin
    inc(aFnt,4);
    sub:=aFnt^; bFnt:=aFnt; inc(bFnt);
    te:=bFnt^; inc(bFnt);
    ro:=bFnt^; inc(bFnt);
    share:=(2 and (bFnt^));
    if ((te>0) and (te<=numcodes[1]) and (ro>0) and (ro<=numcodes[2])
     and ((sub=0) or (sub<>subNA)) and (share=0)) then
      if (telost[te] and (1 shl p))=0 then
      begin
       rolost[ro]:=rolost[ro] and (not(1 shl p));
       roomon[ro]:=roomon[ro] and (not(1 shl p));
      end;
   end; {for L}
  end; {for y}
end;

  procedure resetTaughtNew;
  var
   i:       integer;
  begin
   for i:=1 to numcodes[1] do doingextra[i]:=0;
   for i:=1 to ETnum do Ettaught[i]:=0;
   for i:=1 to numchanges do
   begin
    if Changes[i].kind=4 then doingextra[Changes[i].newte]:=doingextra[Changes[i].newte]
                                  +getEallot(1,Changes[i].year,ttday,Changes[i].timeslot);
    if Changes[i].kind=1 then Ettaught[Changes[i].newte]:=Ettaught[Changes[i].newte]
                                 +getEallot(1,Changes[i].year,ttday,Changes[i].timeslot);
   end;
   IntRange(ttday,0,nmbrDays-1);
   calculateTeach;
  end;

  procedure resetTaughtOld;
  var
   i:       integer;
  begin
   for i:=1 to numcodes[1] do doingextra[i]:=0;
   for i:=1 to ETnum do Ettaught[i]:=0;
   for i:=1 to numchanges do
   begin
    if (Changes[i].kind=3) or (Changes[i].kind=6) then
     doingextra[Changes[i].newte]:=doingextra[Changes[i].newte]
            +getEallot(1,Changes[i].year,ttday,Changes[i].timeslot);
    if (Changes[i].kind=1) or (Changes[i].kind=4) then
     Ettaught[Changes[i].newte]:=Ettaught[Changes[i].newte]
            +getEallot(1,Changes[i].year,ttday,Changes[i].timeslot);
    if Changes[i].oldte>0 then
     if Changes[i].reason>0 then Tabsreason[Changes[i].oldte]:=Changes[i].reason;
   end; {for i}
   calculateTeach;
  end;

 procedure ExtrasFormat3;
 var
  i,j,p,newkind: smallint;
  A:               word;
 begin
  try
    seek(f,0);
    blockread(f,ExDay,2); blockread(f,ExMonth,2);
    blockread(f,ExYear,2); blockread(f,ttDay,2);
    for i:=1 to 400 do begin blockread(f,A,2); teon[i]:=ConvertInt(A); end;
    for i:=1 to 200 do blockread(f,j,2); {was up to 600 teachers}
    for i:=1 to 400 do begin blockread(f,A,2); teAbsent[i]:=ConvertInt(A); end;
    for i:=1 to 200 do blockread(f,j,2);
    for i:=1 to 400 do begin blockread(f,A,2); roAbsent[i]:=ConvertInt(A); end;
    for i:=1 to 200 do blockread(f,j,2);
    for i:=1 to 200 do begin blockread(f,A,2);Eton[i]:=A; ETlink[i]:=0; end;
    for i:=1 to 400 do begin blockread(f,A,2); roomon[i]:=ConvertInt(A); end;
    for i:=1 to 200 do blockread(f,j,2);
    for i:=1 to 400 do begin blockread(f,A,2); teavail[i]:=A; end;
    for i:=1 to 200 do blockread(f,j,2);
    for i:=1 to 200 do begin blockread(f,A,2); ETavail[i]:=A; end;
    blockread(f,numchanges,2);
    if numchanges>0 then
    begin
     A:=0;
     for i:=1 to numchanges do
     begin
      blockread(f,CtimeslotI,2); blockread(f,CyearI,2);
      blockread(f,ClevelI,2); blockread(f,CsubI,2);
      blockread(f,oldteI,2); blockread(f,newteI,2);
      blockread(f,oldroomI,2); blockread(f,newroomI,2);
      blockread(f,kindI,2); blockread(f,needteI,2);
      blockread(f,needroomI,2); blockread(f,NotesI,2);
      blockread(f,ReasonI,2);
      if kindI<>10 then
      begin
       inc(A);
       Changes[A].timeslot:=CtimeslotI;   Changes[A].year:=CyearI;
       Changes[A].level:=ClevelI;         Changes[A].sub:=CsubI;
       Changes[A].oldte:=oldteI;          Changes[A].newte:=newteI;
       Changes[A].oldroom:=oldroomI;      Changes[A].newroom:=newroomI;
       Changes[A].kind:=kindI;            Changes[A].needte:=needteI;
       Changes[A].needroom:=needroomI;    Changes[A].notes:=NotesI;
       Changes[A].reason:=ReasonI;
      end;
     end; {for i}
     numchanges:=A;
    end;
    blockread(f,notenum,2);
    if notenum>0 then
     for i:=1 to notenum do
     begin
      SetLength(ExNote[i],szNote);
      blockread(f,ExNote[i][1],szNote);
      ExNote[i]:=trim(ExNote[i]);
     end;
  except

  end;
  for i:=1 to ETnum do
  begin
   Etmax[i]:=0;
   for p:=1 to tlimit[ttDay] do
    if bool(ETavail[i] and (1 shl p)) then
     Etmax[i]:=Etmax[i]+1;
  end;
  resetTaughtOld;
  for i:=1 to numcodes[1] do
  begin
   for p:=1 to tlimit[ttDay] do
   begin
    if ((tena[i] and (1 shl p))<>0)
     and ((teon[i] and (1 shl p))<>0)
      and ((teach[i] and (1 shl p))=0) then
      begin
       telost[i]:=telost[i] and (not(1 shl p));
       teavail[i]:=teavail[i]+getEallot(2,i,ttday,p);
      end;
    if ((teon[i] and (1 shl p))=0)
     and bool(teach[i] and (1 shl p)) then
     teCover[i]:=teCover[i] and (not(1 shl p));
   end;
  end;
  for i:=1 to numcodes[2] do
   for p:=1 to tlimit[ttDay] do
   begin
    if ((roomon[i] and (1 shl p))<>0) and ((roomteach[i] and (1 shl p))=0) then
     rolost[i]:=rolost[i] and (not(1 shl p));
    if ((roomon[i] and (1 shl p))=0) and bool(roomteach[i] and (1 shl p)) then
     roCover[i]:=roCover[i] and (not(1 shl p));
   end;

  if numchanges>0 then
   for i:=1 to numchanges do
   begin
    p:=Changes[i].timeslot; te:=Changes[i].newte;
    if ((Changes[i].kind=3) or (Changes[i].kind=6)) and (p>0) and (p<=periods)
     and (te>0) and (te<=numcodes[1]) and ((teach[te] and (1 shl p))=0) then
     begin
      telost[te]:=telost[te] and (not(1 shl p));
      teavail[te]:=teavail[te]+getEallot(1,Changes[i].year,ttday,p);  {REM doing extra in teaching time - must be lost}
     end;
    if ((Changes[i].kind=2) or (Changes[i].kind=5)) and (p>0) and (p<=periods)
     and (te>0) and (te<=numcodes[1]) then {REM replacement class}
     begin
      tereplace[te]:=tereplace[te] and (not(1 shl p));
      if ((teach[te] and (1 shl p))=0) then telost[te]:=telost[te] and (not(1 shl p))
       else  begin
              teavail[te]:=teavail[te]-getEallot(1,Changes[i].year,ttday,p);
              if teavail[te]<0 then teavail[te]:=0;
             end;   {REM IF Lost in same time slot as cover, set lost flag else reduce teAvail#}
     end;
    ro:=Changes[i].newroom;
    if (Changes[i].oldroom<>ro) and (ro>0) then
    begin
     if ((roomteach[ro] and (1 shl p))=0) then roswap[ro]:=roswap[ro] and (not(1 shl p))
      else roCover[ro]:=roCover[ro] and (not(1 shl p));
    end;

    Changes[i].gen:=0; newkind:=0; kindI:=Changes[I].kind;
    IF kindI=1 THEN begin Changes[i].gen:=1; newkind:=1; end;
    IF kindI=2 THEN begin Changes[i].gen:=1; newkind:=2; end;
    IF kindI=3 THEN begin Changes[i].gen:=1; newkind:=4; end;
    IF kindI=4 THEN begin Changes[i].gen:=2; newkind:=1; end;
    IF kindI=5 THEN begin Changes[i].gen:=2; newkind:=2; end;
    IF kindI=6 THEN begin Changes[i].gen:=2; newkind:=4; end;
    IF kindI=10 THEN begin Changes[i].gen:=4; newkind:=0; end;
    Changes[I].kind:=newkind;

   end;
   teachermap;
   roomslost;
 end;


   procedure extrasformat4;
   var
    i,tenum,ETnumTemp,ronum:       smallint;
    A:                             word;
   begin
    try
      blockread(f,exday,2); blockread(f,exmonth,2); blockread(f,exyear,2);
      blockread(f,ttDay,2); blockread(f,tenum,2);
      if tenum>0 then
      begin
       for i:=1 to teNum do
       begin
        blockread(f,A,2); teon[i]:=ConvertInt(A);
        blockread(f,A,2); teAbsent[i]:=ConvertInt(A);
        blockread(f,A,2); telost[i]:=ConvertInt(A);
        blockread(f,A,2); teCover[i]:=ConvertInt(A);
        blockread(f,A,2); tereplace[i]:=ConvertInt(A);
        blockread(f,A,2); tElieu[i]:=ConvertInt(A);
        blockread(f,teavail[i],8); MinCheckDoubleVal(teavail[i]);
        blockread(f,telieudbl[i],8); MinCheckDoubleVal(telieudbl[i]);
        blockread(f,tabsreason[i],2);
       end;
      end;
      blockread(f,ETnumTemp,2);
      if ETnumTemp>0 then
      begin
       for i:=1 to ETnumTemp do
       begin
        blockread(f,ETlink[i],2);
        blockread(f,A,2);   Eton[i]:=A;
        blockread(f,A,2); ETavail[i]:=A;
        blockread(f,Etmax[i],8);
       end;
      end;
      blockread(f,roNum,2);
      if roNum>0 then
      begin
       for i:=1 to roNum do
       begin
        blockread(f,A,2);  roomon[i]:=ConvertInt(A);
        blockread(f,A,2); roAbsent[i]:=ConvertInt(A);
        blockread(f,A,2);  roswap[i]:=ConvertInt(A);
        blockread(f,A,2); roCover[i]:=ConvertInt(A);
        blockread(f,A,2);  rolost[i]:=ConvertInt(A);
       end;
      end;
      blockread(f,numchanges,2);
      if numchanges>0 then
      begin
       for i:=1 to numchanges do
       begin
        blockread(f,A,2);
        blockread(f,Changes[i].year,2);
        blockread(f,Changes[i].level,2);
        blockread(f,Changes[i].sub,2);
        blockread(f,Changes[i].gen,2);
        blockread(f,Changes[i].oldte,2);
        blockread(f,Changes[i].newte,2);
        blockread(f,Changes[i].oldroom,2);
        blockread(f,Changes[i].newroom,2);
        blockread(f,Changes[i].kind,2);
        blockread(f,Changes[i].needte,2);
        blockread(f,Changes[i].needroom,2);
        blockread(f,Changes[i].notes,2);
        blockread(f,Changes[i].reason,2);
        if Changes[i].gen=4 then Changes[i].timeslot:=ConvertInt(A)
          else Changes[i].timeslot:=A;
       end;
      end;
      blockread(f,notenum,2);
      if notenum>0 then
      begin
       for i:=1 to notenum do
       begin
        SetLength(ExNote[i],szNote);
        blockread(f,ExNote[i][1],szNote);
        ExNote[i]:=trim(ExNote[i]);
       end;
      end;
    except

    end;
    resetTaughtNew;
    teacherMap;
   end;

   procedure extrasformat5;
   var
    i,tenum,ETnumTemp,ronum:       smallint;
   begin
    try
      blockread(f,exday,2); blockread(f,exmonth,2); blockread(f,exyear,2);
      blockread(f,ttDay,2); blockread(f,tenum,2);
      if tenum>0 then
      begin
       for i:=1 to teNum do
       begin
        blockread(f,teon[i],4);
        blockread(f,teAbsent[i],4);
        blockread(f,telost[i],4);
        blockread(f,teCover[i],4);
        blockread(f,tereplace[i],4);
        blockread(f,tElieu[i],4);
        blockread(f,teavail[i],8);  MinCheckDoubleVal(teavail[i]);
        blockread(f,telieudbl[i],8); MinCheckDoubleVal(telieudbl[i]);
        blockread(f,tabsreason[i],2);
       end;
      end;
      blockread(f,ETnumTemp,2);
      if ETnumTemp>0 then
      begin
       for i:=1 to ETnumTemp do
       begin
        blockread(f,ETlink[i],2);
        blockread(f,Eton[i],4);
        blockread(f,ETavail[i],4);
        blockread(f,Etmax[i],8);
       end;
      end;
      if ETnumTemp<ETnum then for i:=ETnumTemp+1 to ETnum do
       begin ETavail[i]:=0; ETon[i]:=-1; end;
      blockread(f,roNum,2);
      if roNum>0 then
      begin
       for i:=1 to roNum do
       begin
        blockread(f,roomon[i],4);
        blockread(f,roAbsent[i],4);
        blockread(f,roswap[i],4);
        blockread(f,roCover[i],4);
        blockread(f,rolost[i],4);
       end;
      end;
      blockread(f,numchanges,2);
      if numchanges>0 then
       for i:=1 to numchanges do blockread(f,Changes[i],Change5RecSize);
      blockread(f,notenum,2);
      if notenum>0 then
      begin
       for i:=1 to notenum do
       begin
        SetLength(ExNote[i],szNote);
        blockread(f,ExNote[i][1],szNote);
        ExNote[i]:=trim(ExNote[i]);
       end;
      end;
    except

    end;
    resetTaughtNew;
    teacherMap;
   end;


begin
 ClearChanges;
 fname:=exfile+'.XTR';
 chdir(Directories.datadir); {try data directory first}
 if fileexists(EXTRAS_XML_FILE) then
 begin
   getExtras_xml;
   resetTaughtNew;
   teacherMap;
   IntRange(exday,1,31);
   IntRange(exmonth,1,12);
   case exmonth of
    2: IntRange(exday,1,29);
    4,6,9,11: IntRange(exday,1,30);
   end; {case}
   IntRange(ttday,0,nmbrDays-1);
   for i:=1 to numcodes[1] do
    teon[i]:=(teach[i] or not(telost[i])) and teCover[i] and tereplace[i] and tElieu[i];
  exit;
 end;
 if not(fileexists(fname)) then
  begin  {try other directory}
  {$I-}
   chdir(exdir);
  {$I+}
  if IOresult<>0 then
   begin
    exdir:=Directories.datadir; usedir:=exdir; chdir(exdir);
   end;
  end;
 if not(fileexists(fname)) then
 begin
  setnewday(1);
  exit;
 end;
 doAssignFile(f,fname);
 try
  try
   filemode:=fmOpenRead+fmShareDenyNone;
   reset(f,1);
   SetLength(astr,4);
   NEW_DateChecks[9]:=FileDateToDateTime(fileage(fname));   
   blockread(f,astr[1],4);
   if (astr<>'TCV4') and (astr<>'TCE5') then ExtrasFormat3;
   if (astr='TCV4') then ExtrasFormat4;
   if (astr='TCE5') then ExtrasFormat5;
  finally
   closefile(f);
  end;
 except

 end;

 {range check exday,year,month & ttday}
 IntRange(exday,1,31);
 IntRange(exmonth,1,12);
 case exmonth of
  2: IntRange(exday,1,29);
  4,6,9,11: IntRange(exday,1,30);
 end; {case}
 IntRange(ttday,0,nmbrDays-1);
 for i:=1 to numcodes[1] do
  teon[i]:=(teach[i] or not(telost[i])) and teCover[i] and tereplace[i] and tElieu[i];
end;


procedure UpdatePastExtras(Aday,Amonth,Attday: integer);
var
 i,i1,p:  integer;
 f:   file;
 add:  integer;
 astr,msg:   string;
 Agen,Ayear,Asub,Akind:        integer;
 Anewte:                       integer;
 msgret:         word;
 fpos:           longint;
begin
 chdir(Directories.datadir);
 NeedPastExtrasINITflag:=true; {request reload of data}
 doAssignFile(f,'ABSENT.DAT');
 try
  if aDay > 31 then aDay := 0;
  if aMonth > 12 then aMonth := 0;
  filemode:=fmOpenReadWrite+fmShareDenyWrite;
  reset(f,1);
  SetLength(astr,4);
  blockread(f,astr[1],4);
  blockread(f,AbsentTotal,2);
  fpos:=AbsentTotal+1;  add:=0;
  seek(f,fpos*24);

  Ayear:=0; Asub:=0; Anewte:=0; Akind:=0;
  for i1:=1 to codenum[1] do
   begin
    i:=codepoint[i1,1];
    if teAbsent[i]<>-1 then
     begin
      Agen:=4;
      blockwrite(f,Aday,2);            blockwrite(f,Amonth,2);
      blockwrite(f,teAbsent[i],4);    blockwrite(f,Ayear,2);
      blockwrite(f,Asub,2);            blockwrite(f,i,2);
      blockwrite(f,Anewte,2);          blockwrite(f,Akind,2);
      blockwrite(f,Tabsreason[i],2);  blockwrite(f,Agen,2);
      blockwrite(f,Attday{ttday},2);
      inc(add);
     end;
    if teLost[i]<>-1 then
     begin
      Agen:=7;
      blockwrite(f,Aday,2);            blockwrite(f,Amonth,2);
      blockwrite(f,teLost[i],4);    blockwrite(f,Ayear,2);
      blockwrite(f,Asub,2);            blockwrite(f,i,2);
      blockwrite(f,i,2);          blockwrite(f,Akind,2);
      blockwrite(f,Tabsreason[i],2);  blockwrite(f,Agen,2);
      blockwrite(f,Attday{ttday},2);
      inc(add);
     end;
   end;
  if numchanges>0 then
   for i:=1 to numchanges do
    if (Changes[i].gen<>0) and (Changes[i].gen<>4) and (Changes[i].gen<>6)
     and (Changes[i].gen<>7)  then
     begin
      blockwrite(f,Aday,2);            blockwrite(f,Amonth,2);
      blockwrite(f,Changes[i].timeslot,4);   blockwrite(f,Changes[i].year,2);
      blockwrite(f,Changes[i].sub,2);        blockwrite(f,Changes[i].oldte,2);
      blockwrite(f,Changes[i].newte,2);       blockwrite(f,Changes[i].kind,2);
      blockwrite(f,Changes[i].reason,2);      blockwrite(f,Changes[i].gen,2);
      blockwrite(f,Attday{ttday},2);
      inc(add);
     end;
  seek(f,0);
  astr:='TCE5';
  blockwrite(f,astr[1],4);
  inc(AbsentTotal,add);
  blockwrite(f,AbsentTotal,2);
  closefile(f);
 except

 end;
 if numchanges=0 then
  begin
   msg:='Move extras for last ten days?';
   msgret:=messagedlg(msg,mtConfirmation,[mbYes,mbNo],0);
   if msgret<>mrYes then exit;
  end;
 for i:=1 to numcodes[1] do
  begin
   Eten[i]:=smallint((Eten[i] shl 1));
   IF KeepReplaceFlag then Ereplace[i]:=teAvail[i];
   if doingextra[i]>0 then
    begin
     Etaken[i]:=Etaken[i]+doingextra[i];
     Eweek[i]:=Eweek[i]+doingextra[i];
     Eday[i]:=Aday; Emonth[i]:=Amonth;
     Eten[i]:=Eten[i]+1;
    end;{doingextra>0}
   if tElieu[i]<>-1 then
    for p:=1 to Tlimit[Attday] do
     if (tElieu[i] and (1 shl p))=0 then
      Elieutaken[i]:=Elieutaken[i]+getEallot(7,i,Attday,p);
  end; {i}
 updateTallies;
end;

procedure SaveUseName;
var
 f:       textfile;
begin
 chdir(Directories.datadir);
 doAssignFile(f,'EXFILE.DAT');
 filemode:=fmOpenReadWrite+fmShareDenyWrite;
 rewrite(f);
 writeln(f,usefile);
 writeln(f,usedir);
 closefile(f);
end;

function ReloadUseFile: boolean;
var
 msg,file2:            string;
 msgret:         word;
begin
 result:=false;
 if exfile<>usefile then
  begin
   msg:='Load '+usefile+' to clear?';
    msgret:=messagedlg(msg,mtConfirmation,[mbYes,mbNo],0);
    if msgret<>mrYes then exit;
   end
  else
   begin
    result:=true;
    exit;
   end;
 SaveExtras;
 exdir:=usedir;
 {$I-}
 chdir(exdir);
 {$I+}
 if IOresult<>0 then
  begin
   msg:='Cannot change to '+exdir+' directory';
   messagedlg(msg,mtError,[mbOK],0);
   exit;
  end;
 file2:=usefile+'.XTR';
 if not(fileexists(file2)) then
  begin
   msg:='Cannot load '+usefile;
   messagedlg(msg,mtError,[mbOK],0);
   exit;
  end;
 exfile:=usefile;
 ExtrasIn;
 exload:=usedir;
 result:=true;
end;

function SetNewDay(newdaykind: Integer): Boolean;  {newdaykind 1-load, 2-new day 3-work ahead}
var
 exitnew: bool;
 msg:            string;
 msgret:         word;
 old_day,old_month,old_ttday: smallint;
 i:  integer;
 tmpstr:         string;
begin
 Result := False;
 exitnew := False;
 if newdaykind=2 then  {extras file already in use}
  begin
   if not(ReloadUseFile) then exit;
   if numchanges>0 then
    begin
     msg:='Archive changes for '+inttostr(exday)+' '+month[exmonth]+' '+inttostr(exyear)+'?';
     msgret:=messagedlg(msg,mtConfirmation,[mbYes,mbNo],0);
     if msgret<>mrYes then exit;
    end;
  end; {newdaykind=2}
 old_day:=exday; old_month:=exmonth; old_ttday:=ttday;
 NewDaydlg:=TNewDaydlg.create(application);   {allocate dlg}
 NewDaydlg.tag:=newdaykind;
 NewDaydlg.showmodal;
 if NewDaydlg.modalresult<>mrOK then exitnew:=true;
 NewDaydlg.free;
 if exitnew then exit;
 if newdaykind=2 then UpdatePastExtras(old_day,old_month,old_ttday);
 if newdaykind=3 then
  begin
   swapint(exday,old_day); swapint(exmonth,old_month); swapint(ttday,old_ttday);
   SaveExtras;
   swapint(exday,old_day); swapint(exmonth,old_month); swapint(ttday,old_ttday);
   CheckAccessRights(4,9,false);
  end;
 ClearChanges;
 for i:=1 to nmbrAddedTeachers do
   begin
    Eton[i]:=-1; ETavail[i]:=0; Ettaught[i]:=0;
    if ETlink[i]>0 then
    begin
     telink[ETlink[i]]:=0;
     ETlink[i]:=0;
    end;
   end;
 calculateTeach;
 for i:=1 to numcodes[1] do teon[i]:=teach[i];
 for i:=1 to numcodes[2] do roomon[i]:=roomteach[i];
 CheckLinks;
 TeacherMap;
 if (newdaykind=2) and (uppercase(exfile)<>'EXTRAS') then
  begin
   deletefile(exfile+'.XTR');
   AccessFileMaintenance(exfile);
   exload:=Directories.datadir;  usedir:=Directories.datadir;
   exfile:='EXTRAS'; usefile:=exfile;
  end;
 if (newdaykind=3) then
  begin
   tmpStr:=ExtractFileName(Mainform.OpenDialog.Filename);
   i:=pos('.',tmpStr);
   tmpStr:=copy(tmpStr,1,i-1);
   exfile:=tmpStr;
   tmpStr:=Mainform.OpenDialog.Filename;
   exdir:=GetDirName(tmpStr);  exload:=exdir;
  end;
 if newdaykind=2 then SaveExtras; {force file update - for autoload trigger of other users}
 SaveUseName;
 UpdateAllWins;
 updateStatusPanel;
 RescanTimetable(True);
 Result := True;
end;

procedure REselectgroup;
var
 i,j,k:     integer;
 num:        integer;
 methodSel:           integer;
 matchArr:         array of integer;
begin
 setlength(StGroup,(numStud+1)); {zero based so +1}
 setlength(matchArr,nmbrSubjects+1);
 StudListType := 2;  //Group

// clear StudGrpFlg
 for i:=1 to numStud do StudGrpFlg[i]:=0;

 for i:=1 to GOSrecipe.NumSteps do
 begin
  GroupType:=GOSrecipe.steps[i].slct;
  methodSel:=GOSrecipe.steps[i].meth;
  groupSelStr[1]:=GOSrecipe.steps[i].e1;
  groupselstr[2]:=GOSrecipe.steps[i].e2;
  case GroupType of
   0: for j:=1 to numstud do StudGrpFlg[j]:=1;  {all}
   1: SetYearGroup(methodSel);  {year}
   2:SetClassGroup(methodSel);  {class}
   3:SetHouseGroup(methodSel);  {house}
   4,11: SetIDGroup(GroupType,methodSel);   {ID}
   5: SetTutorGroup(methodSel); {tutor}
   6: SetRoomGroup(methodSel); {room}
   7: SetTagGroup(methodSel); {tag}
   8: SetSubGroup(methodSel); {subject}
  end; {case}

  num:=0;
  for k:=1 to numstud do
  begin
   j:=StudSort[k];
   if StudGrpFlg[j]>0 then
      begin inc(num); StGroup[num]:=j; end;
  end; {for k}
  groupnum:=num;
 end;

 if loadFinished then updateGroupSubs;
 if wnFlag[wnStudentList] then studentlistwin.UpdateWin;
end;

procedure SetRecipeFromGOS(nm: integer);
var
 cnt,i: smallint;
begin
  if GOSNum >= nm then
  begin
    cnt := GOS[nm].NumSteps;
    setlength(GOSrecipe.steps,cnt+1);
    GOSrecipe.NumSteps := cnt;
    for i := 1 to cnt do
      GOSrecipe.steps[i] := GOS[nm].steps[i];
    GOSrecipe.SubOfferName := GOS[nm].SubOfferName;
  end;
end;

function findHouse(enteredTxt: string; msgLabel: Tlabel): smallint;
var
 aStr,bStr:   string;
 i,j,aLen,bLen,mLen:       smallint;
begin
 aStr:=UpperCase(trim(enteredTxt));
 aLen:=Length(aStr);   j:=0;  mLen:=99;
 if aLen>0 then
  for i:=1 to housecount do
  begin
   bStr:=UpperCase(trim(HouseName[i]));
   bLen:=length(bStr);
   bStr:=copy(bStr,1,aLen);
   if aStr=bStr then
   begin
    if bLen<=mLen then
    begin
     mLen:=bLen;  //keep only minimum match
     j:=i;
     if aLen=bLen then break;  //continue search unless perfect match found
    end;
   end;
  end; {for i}
 if j>0 then
  msgLabel.caption:=HouseName[j]
 else
  msgLabel.caption:='Enter house name';

 result:=j;
end;

procedure CookCustomGroup(GI: smallint);
begin
  GroupIndexDisplay := GI;
  SetRecipeFromGOS(GI);
  GroupName:=GOSname[GI];
  REselectgroup;
  UpdateStudWins;
end;

function CalculateLoads: Double;
var
  p, y, l: Integer;
  afnt, bfnt: TPIntPoint;
  lTeNo, su: Integer;
  TeFound: array of Boolean;
  lTotalLoad: Double;
begin
  lTotalLoad := 0;
  try
    SetLength(TeActualLoad, NumCodes[1] + 2);
    SetLength(TeFound, NumCodes[1] + 2);
    for p := 0 to tlimit[ttDay] - 1 do
      lTotalLoad := lTotalLoad + tsAllot[ttDay, p];

    for lTeNo := 0 to NumCodes[1] do
    begin
      TeLoad[lTeNo] := 0;
      //ELieu[lTeNo] := lTotalLoad;
    end;

    for p := 0 to tlimit[ttDay] - 1 do
    begin
      for lTeNo := 0 to NumCodes[1] do TeFound[lTeNo] := False;
      for y := 0 to years_minus_1 do
      begin
        //ClassInYear[y]:=false;
        afnt := FNT(ttDay, p, y, 0, 2);
        for l := 1 to level[y] do
        begin
          //if trim(ClassCode[ClassShown[l,y]])>'' then classInYear[y]:=true;
          Inc(afnt, 4);
          lTeNo := afnt^;
          if (lTeNo > 0) and (lTeNo <= NumCodes[1]) then
          begin
            bfnt:=afnt;
            dec(bfnt);
            su := bfnt^;
            if ((su <> subNA) and (TeFound[lTeNo] = False)) then
            begin
              TeActualLoad[CodePoint[lTeNo, 1]] := TeActualLoad[CodePoint[lTeNo, 1]] + tsAllot[ttDay, p];
              TeFound[lTeNo] := True;
            end;
          end;
        end; {for l}
      end; {for y}
    end; {for p}
  finally
    Result := lTotalLoad;
  end;
end;

end.



