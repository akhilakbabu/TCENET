unit DlgCommon;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, SysUtils,Messages,grids,TCEglobals,classDefs, GlobalToTcAndTcextra;

 procedure allowNumericInputOnly(var key: char);
 procedure allowdecimalInputOnly(var key: char);
 function findChoice(enteredTxt: string; msgLabel: Tlabel; useMsg: bool): smallint;
 function findRoom(enteredTxt: string; msgLabel: Tlabel): smallint;
 function findTutor(enteredTxt: string; msgLabel: Tlabel): smallint;
 function findDayMsg(s: string;msgLabel: Tlabel): smallint;
 function findFaculty(enteredTxt: string; msgLabel: Tlabel): smallint;
 procedure insertfaculty(ebox: Tedit);
 function checkWildCode(var codeStr: string; msgLabel: Tlabel; useMsg: bool): smallint;
 function checkwildYearSub(codeStr: string; msgLabel: Tlabel; useMsg: bool): smallint;
 function NoCode(var codeStr: string; myEdit: Tedit):boolean;
 function BlankEntry(S: string; myEdit: Tedit):boolean;
 function CodeUsed(var codePlace:integer;code:smallint;var codeStr:string;myEdit:Tedit):boolean;
 function CodeZero(codeStr: string;myEdit:Tedit):boolean;
 function NoNewCode(var codeStr: string; myEdit: Tedit):boolean;
 function NoCodesAvail(num:integer;CodeType:string):boolean;
 function NoCodesAvail1(mycode:integer):boolean;
 function CodeNotFound(var myCode:integer;code:integer;codeStr:string;myEdit:Tedit):boolean;
 function ChoiceNotFound(var su:integer;i:integer;s:string; myEdit:Tedit):boolean;
 function NAused(su,i:integer;myEdit:Tedit):boolean;
 function CodeAlreadyUsed(var CodeStrNew:string;myCode,code:integer;myEdit:Tedit):boolean;
 procedure ComboMsg(msg: string;myCombo: TcomboBox);
 procedure ShowMsg(msg: string;myEdit: Tedit);
 function BadComboYear(var myYear:smallint; myCombo: TcomboBox):boolean;
 function BadLevel(var myLevel,myYear:smallint;myEdit:Tedit):boolean;
 function BadDayCombo(var myDay:smallint;myCombo:TcomboBox):boolean;
 function BadTimeSlot(var myTime,myDay:smallint;myEdit:Tedit):boolean;
 function BadLength(var Mylen:smallint;min,max:integer;MyEdit:Tedit):boolean;
 function InvalidEntry(var Mylen:smallint;min,max:integer;s:string;MyEdit:Tedit):boolean;
 procedure ReductionMsg(s:string;MyEdit:Tedit);
 function OpCheck(location,target,optype:string):boolean;
 procedure FillComboYears(AddAll:boolean; myCombo:TcomboBox);
 procedure FillComboTimeSlots(AddAll:boolean; myDay:smallint; myCombo:TcomboBox);
 procedure FillComboDays(AddAll:boolean; myCombo:TcomboBox);
 procedure FillComboFaculty(AddAll:boolean; myCombo:TcomboBox);
 procedure FillComboRollClass(myCombo:TcomboBox;DefClass:integer;myRadio:TRadioButton);
 procedure HiLiteEdit(MyEdit:Tedit);
 procedure HiLiteCombo(MyCombo:TcomboBox);
 procedure HiLiteCombo1(MyCombo:TcomboBox);
 procedure HiLiteList(MyList:TlistBox);
 procedure MoveUpList(var TmpArr: array of smallint;MyList:TlistBox);
 procedure MoveDownList(var TmpArr: array of smallint;MyList:TlistBox);
 procedure MoveOffList(var TmpArr: array of smallint;MyList:TlistBox;Mylab:Tlabel);
 procedure ClearList(var TmpArr: array of smallint;MyList:TlistBox;Mylab:Tlabel);
 procedure MoveOnSubList(var TmpArr: array of smallint;List1,List2:TlistBox;
    Mylab:Tlabel;code:integer);
 procedure FillSubList(var TmpArr: array of smallint;List1,List2:TlistBox;
    Mylab:Tlabel;code:integer);
 procedure MoveOnStudList(var TmpArr: array of smallint;List1,List2:TlistBox;
    Mylab:Tlabel);
 procedure FillStudList(var TmpArr: array of smallint;List1,List2:TlistBox;
    Mylab:Tlabel);

implementation

uses    tcommon,StCommon,Ttable;


procedure MoveUpList(var TmpArr: array of smallint;MyList:TlistBox);
var
 i: integer;
begin
 if MyList.Count>1 then
  for i:=1 to MyList.Count-1 do
   if (MyList.Selected[i] and not(MyList.Selected[i-1])) then
    begin
     MyList.Items.Move(i,i-1);  swapint(TmpArr[i+1],TmpArr[i]);
     MyList.Selected[i-1]:=true;
    end;
end;

procedure MoveDownList(var TmpArr: array of smallint;MyList:TlistBox);
var
 i: integer;
begin
 if MyList.Count>1 then
  for i:=MyList.Count-2 downto 0 do
   if (MyList.Selected[i] and not(MyList.Selected[i+1])) then
   begin
    MyList.Items.Move(i,i+1);  swapint(TmpArr[i+1],TmpArr[i+2]);
    MyList.Selected[i+1]:=true;
   end;
end;

procedure MoveOffList(var TmpArr: array of smallint;MyList:TlistBox;Mylab:Tlabel);
var
 i,j: integer;
begin
 if MyList.items.count>0 then
  for i:=(MyList.items.count-1) downto 0 do
   if MyList.selected[i] then
    begin
     MyList.items.delete(i);
     if (i+1)<TmpArr[0] then
      for j:=i+1 to TmpArr[0]-1 do TmpArr[j]:=TmpArr[j+1];
     dec(TmpArr[0]);
    end;
 Mylab.caption:=inttostr(MyList.items.count);
end;

procedure MoveOnStudList(var TmpArr: array of smallint;List1,List2:TlistBox;
    Mylab:Tlabel);
var
 i:       integer;

 function alreadyInlist(s:smallint): wordbool;
 var
  i: smallint;
 begin
  result:=false;
  if TmpArr[0]<=0 then exit;
  for i:=1 to TmpArr[0] do
   if TmpArr[i]=s then
    begin
     result:=true; break;
    end;
 end;

begin
 if List1.items.count>0 then
  for i:=0 to (List1.items.count-1) do
   if List1.selected[i] then
    if not(alreadyInlist(i+1)) then
    if List2.items.indexof(List1.items[i])=-1 then {not already in list}
     begin
      List2.items.add(List1.items[i]);
      inc(TmpArr[0]); TmpArr[TmpArr[0]]:=i+1;
     end;
 Mylab.caption:=inttostr(List2.items.count);
end;


procedure MoveOnSubList(var TmpArr: array of smallint;List1,List2:TlistBox;
    Mylab:Tlabel;code:integer);
var
 i:       integer;
begin
 if List1.items.count>0 then
  for i:=0 to (List1.items.count-1) do
   if List1.selected[i] then
    if List2.items.indexof(List1.items[i])=-1 then {not already in list}
     begin
      List2.items.add(List1.items[i]);
      inc(TmpArr[0]); TmpArr[TmpArr[0]]:=codepoint[i+1,code];
     end;
 Mylab.caption:=inttostr(List2.items.count);
end;

procedure FillSubList(var TmpArr: array of smallint;List1,List2:TlistBox;
    Mylab:Tlabel;code:integer);
var
 i:       integer;
begin
 List2.items:=List1.items;
 Mylab.caption:=inttostr(List2.items.count);
 for i:=1 to codenum[code] do TmpArr[i]:=codepoint[i,code];
 TmpArr[0]:=codenum[code];
end;

procedure FillStudList(var TmpArr: array of smallint;List1,List2:TlistBox;
    Mylab:Tlabel);
var
 i:       integer;
begin
 List2.items:=List1.items;
 Mylab.caption:=inttostr(List2.items.count);
 for i:=1 to numstud do TmpArr[i]:=i;
 TmpArr[0]:=numstud;
end;


procedure ClearList(var TmpArr: array of smallint;MyList:TlistBox;Mylab:Tlabel);
begin
 MyList.clear;
 Mylab.caption:=inttostr(MyList.items.count);
 TmpArr[0]:=0;
end;

procedure HiLiteEdit(MyEdit:Tedit);
begin
 MyEdit.Enabled:=true;
 MyEdit.color:=clRelevantControlOnDlg;
 MyEdit.setfocus; MyEdit.selectall;
end;

procedure HiLiteCombo(MyCombo:TcomboBox);
begin
 MyCombo.Enabled:=true;
 MyCombo.color:=clRelevantControlOnDlg;
end;

procedure HiLiteCombo1(MyCombo:TcomboBox);
begin
 HiLiteCombo(MyCombo);
 MyCombo.setfocus; MyCombo.SelectAll;
end;

procedure HiLiteList(MyList:TlistBox);
begin
 MyList.Enabled:=true;
 MyList.Color:=clRelevantControlOnDlg;
end;


procedure FillComboFaculty(AddAll:boolean; myCombo:TcomboBox);
var
 i: integer;
begin
 myCombo.clear;
 myCombo.Hint:='Select Faculty';
 myCombo.Maxlength:=szFacName;
 if AddAll then myCombo.items.add('All faculties');
 if facnum>0 then
  for i:=1 to facnum do myCombo.items.add(facname[i])
 else myCombo.Enabled:=false;
end;

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

procedure FillComboDays(AddAll:boolean; myCombo:TcomboBox);
var
 i: integer;
begin
 myCombo.clear;
 myCombo.Hint:='Select Day';
 myCombo.Maxlength:=szDay;
 myCombo.DropDownCount:=days+1;
 if AddAll then myCombo.items.add('All days');
 for i:=0 to (days-1) do myCombo.items.add(day[i]);
end;


procedure FillComboYears(AddAll:boolean; myCombo:TcomboBox);
var
 i: integer;
begin
 myCombo.clear;
 myCombo.Hint:='Select '+Yeartitle;
 myCombo.Maxlength:=szYearname;
 myCombo.DropDownCount:=years+1;
 if AddAll then myCombo.items.add('All years');
 for i:=0 to years_minus_1 do myCombo.items.add(yearname[i]);
end;

procedure FillComboTimeSlots(AddAll:boolean; myDay:smallint; myCombo:TcomboBox);
var
 i: integer;
begin
 myCombo.clear;
 myCombo.Hint:='Select Time Slot';
 myCombo.Maxlength:=szPeriodName+4;
 if AddAll then myCombo.items.add('All time slots');
 for i:=0 to (Tlimit[myDay]-1) do
  myCombo.items.add(tsCode[myDay,i]+': '+TimeSlotName[myDay,i]);
end;

function OpCheck(location,target,optype:string):boolean;
var
 msg: string;
begin
 msg:='Entry'+location+' is part of a '+target+'.'+endline+Optype+' anyway?';
 result:=(messagedlg(msg,mtWarning,[mbyes,mbno],0)<>mrYes);
end;


function zeromessage: string;
var
 msg: string;
begin
 msg:='Codes starting with "00" are reserved by Time Chart for'+endline;
 msg:=msg+' deleted codes and are unavailable for other uses.'+endline;
 msg:=msg+'Please enter a different code.';
 result:=msg;
end;

procedure ShowMsg(msg: string;myEdit: Tedit);
begin
 messagedlg(msg,mtError,[mbOK],0);
 myEdit.setfocus; myEdit.SelectAll;
end;



function BadLength(var Mylen:smallint;min,max:integer;MyEdit:Tedit):boolean;
begin
 result:=InvalidEntry(Mylen,min,max,'length',MyEdit);
end;

function InvalidEntry(var Mylen:smallint;min,max:integer;s:string;MyEdit:Tedit):boolean;
begin
 result:=false;
 Mylen:=strtointdef(MyEdit.text,0);
 if ((Mylen<min) or (Mylen>max)) then
  begin
   ShowMsg('Invalid '+s+'. '+chr(10)+'Enter a value in the range '
        +inttostr(min)+' to ' +inttostr(max)+'.',MyEdit);
   result:=true;
  end;
end;




procedure ComboMsg(msg: string;myCombo: TcomboBox);
begin
 messagedlg(msg,mtError,[mbOK],0);
 myCombo.setfocus; myCombo.SelectAll;
end;

function BadComboYear(var myYear:smallint; myCombo: TcomboBox):boolean;
begin
 result:=false;
 myYear:=findYear(myCombo.text);
 if myYear=-1 then
  begin
   ComboMsg('Check '+yeartitle,myCombo);
   result:=true;
  end;
end;

function BadLevel(var myLevel,myYear:smallint;myEdit:Tedit):boolean;
var
 s: string;
begin
 result:=false;
 s:=trim(myEdit.text);
 myLevel:=strtointdef(s,0);
 if (myLevel<1) or (myLevel>level[myYear]) then
  begin
   ShowMsg('Check level',myEdit);
   result:=true;
  end;
end;

function BadTimeSlot(var myTime,myDay:smallint;myEdit:Tedit):boolean;
var
 s: string;
begin
 result:=false;
 s:=trim(myEdit.text);
 myTime:=strtointdef(s,0)-1;
 if (myTime<0) or (myTime>=Tlimit[myDay]) then
  begin
   ShowMsg('Check time slot',myEdit);
   result:=true;
  end;
end;

procedure ReductionMsg(s:string;MyEdit:Tedit);
begin
 ShowMsg('Reduction of '+s+' code length would result in duplicate '+s+' codes.'
  +endline+'Duplicate '+s+' codes are not permitted.',MyEdit);
end;

function BadDayCombo(var myDay:smallint;myCombo:TcomboBox):boolean;
begin
 result:=false;
 myDay:=findDay(myCombo.text);
 if myDay=-1 then
  begin
   ComboMsg('Check Day',myCombo);
   result:=true;
  end;
end;

function CodeZero(codeStr: string;myEdit:TEdit):boolean;
begin
 result:=false;
 if (copy(codeStr,1,2)='00') then
  begin
   ShowMsg(zeromessage,myEdit);
   result:=true;
  end;
end;


function NoCode(var codeStr: string; myEdit: Tedit):boolean;
begin
 result:=false;
 codeStr:=TrimRight(myEdit.text);
 if codeStr='' then
  begin
   ShowMsg('No code entered.',myEdit);
   result:=true;
  end;
end;

function BlankEntry(S: string; myEdit: Tedit):boolean;
var
 codeStr: string;
begin
 result:=false;
 codeStr:=Trim(myEdit.text);
 if codeStr='' then
  begin
   ShowMsg(s+' names cannot be left blank.',myEdit);
   result:=true;
  end;
end;



function NoCodesAvail(num:integer;CodeType:string):boolean;
begin
 result:=false;
 if num<=0 then
  begin
   messagedlg('No '+CodeType+' available for deletion',mtError,[mbOK],0);
   result:=true;
  end;
end;

function NoCodesAvail1(mycode:integer):boolean;
begin
 result:=false;
 if codenum[mycode]<=0 then
  begin
   messagedlg('No '+CodeName[mycode]+' codes available to edit',mtError,[mbOK],0);
   result:=true;
  end;
end;

function NoNewCode(var codeStr: string; myEdit: Tedit):boolean;
begin
 result:=false;
 codeStr:=TrimRight(myEdit.text);
 if codeStr='' then
  begin
   ShowMsg('No new code entered.',myEdit);
   result:=true;
  end;
end;

function CodeNotFound(var myCode:integer;code:integer;codeStr:string;myEdit:Tedit):boolean;
begin
 result:=false;
 if code>=0 then myCode:=checkCode(code,codeStr);
 if myCode<=0 then     {code not found}
 begin
  ShowMsg('The code '+codeStr+' could not be found.'+endline+
                 'Please enter a different code.',myEdit);
  result:=true;
 end;
end;


function ChoiceNotFound(var su:integer;i:integer;s:string; myEdit:Tedit):boolean;
begin
 result:=false;
 su:=checkcode(0,s);
 if (su=0) then
  begin
   ShowMsg('Student subject choice code number '+inttostr(i)+endline+
     'is NOT A VALID Student Subject Choice.'+endline+
     'Please enter a different subject code.',MyEdit);
   result:=true; {return to editing}
  end;
end;



function NAused(su,i:integer;myEdit:Tedit):boolean;
begin
 result:=false;
 if ((su=subNA) and (subNA>0)) then
  begin
   ShowMsg('Subject choice number '+inttostr(i)+' is entered as "NA".'+endline+
    '"NA" is a reserved code for "Not Available" and is not a valid Student Choice.'
    +endline,myEdit);
   result:=true;
  end;
end;


function CodeAlreadyUsed(var CodeStrNew:string;myCode,code:integer;myEdit:Tedit):boolean;
var
 codePlaceNew: integer;
 msg,tmpStr: string;
begin
 result:=false;
 codePlaceNew:=checkCode(code,codeStrNew);
 if ((codePlaceNew>0) and (myCode<>codePlaceNew)) then  {code already in use}
  begin
   tmpStr:=FNsubname(codePlaceNEW,code);
   msg:='The code '+FNsub(codePlaceNEW,code)+' is already used';
   if tmpStr<>'' then msg:=msg+' for '+tmpStr;
   msg:=msg+'.'+endline+'Please enter a different code.';
   ShowMsg(msg,myEdit);
   result:=true;
  end;
end;


function CodeUsed(var codePlace:integer;code:smallint;var codeStr:string;myEdit:Tedit):boolean;
var
 tmpStr,msg: string;
begin
 result:=false;
 codePlace:=checkCode(code,codeStr);
 if codePlace>0 then     {code already in use}
  begin
   tmpStr:=FNsubname(codePlace,code);
   msg:='The code '+FNsub(codePlace,code)+' is already being used';
   if tmpStr<>'' then msg:=msg+' for '+tmpStr;
   msg:=msg+'.'+endline;
   msg:=msg+'Please enter a different code.';
   ShowMsg(msg,myEdit);
   result:=true;
  end;
end;

function checkWildCode(var codeStr: string; msgLabel: Tlabel; useMsg: bool): smallint;
var
 j:     smallint;
 tmpStr: string;
begin
 j:= checkWildSub(codeStr);
 result:=j;
 if useMsg then begin
  tmpStr:='Enter Subject code';
  if j>0 then tmpStr:=SubCode[j]+' '+Subname[j];
  if j<0 then tmpStr:='All '+uppercase(copy(codeStr,1,lencodes[0]-1))+' Subjects';
  msgLabel.caption:=tmpStr;
 end;
end;

function checkwildYearSub(codeStr: string; msgLabel: Tlabel; useMsg: bool): smallint;
var
 foundpos,foundyearpos:     smallint;
begin
 foundyearpos:=0;
 codeStr:=trim(codeStr);
 validatecode(0,codestr);
 foundpos:=checkWildcode(codestr,msgLabel,useMsg);
 result:=foundpos;
 if (foundpos>0) and (GroupSubs[0]>0) then foundyearpos:=findsubyear(foundpos);
 if useMsg and (foundyearpos>0) then msgLabel.caption:=
   msgLabel.caption+' '+inttostr(GroupSubCount[foundyearpos]);
end;

procedure insertfaculty(ebox: Tedit);
var
 facStr:        string;
 facPlace,pos:  smallint;
begin
 facStr:=ebox.text;   facStr:=trim(facStr);
 if length(facStr)<3 then exit;
 facPlace:=checkFaculty(facStr);
 if facPlace>0 then
 begin
  pos:=ebox.selstart;
  ebox.text:=facName[facPlace];
  ebox.selstart:=pos;
 end;
end;


function findFaculty(enteredTxt: string; msgLabel: Tlabel): smallint;
var
 aStr,bStr:   string;
 i,j,aLen:       smallint;
begin
 aStr:=UpperCase(trim(enteredTxt));
 aLen:=Length(aStr);   j:=0;
 if aLen>0 then
  for i:=1 to facNum do
  begin
   bStr:=UpperCase(copy(facName[i],1,aLen));
   if aStr=bStr then
   begin
    j:=i;
    break;
   end;
  end; {for i}
 if j>0 then
  msgLabel.caption:=facName[j]
 else
  msgLabel.caption:='Enter Faculty name';

 result:=j;
end;



function findRoom(enteredTxt: string; msgLabel: Tlabel): smallint;
var
 aStr:   string;
 j,aLen:       smallint;
begin
 aStr:=UpperCase(trim(enteredTxt));
 aLen:=Length(aStr);   j:=0;
 if aLen>0 then j:=CheckCode(2,aStr);
 if j>0 then
  msgLabel.caption:=TeCode[j,1]+' '+TeName[j,1]
 else
  msgLabel.caption:='Enter room code';
 result:=j;
end;

function findTutor(enteredTxt: string; msgLabel: Tlabel): smallint;
var
 aStr:   string;
 j,aLen:       smallint;
begin
 aStr:=UpperCase(trim(enteredTxt));
 aLen:=Length(aStr);   j:=0;
 if aLen>0 then j:=checkCode(1,aStr);
 if j>0 then
  msgLabel.caption:=TeCode[j,0]+' '+TeName[j,0]
 else
  msgLabel.caption:='Enter teacher code';
 result:=j;
end;

function findDayMsg(s: string;msgLabel: Tlabel): smallint;
var
 i:  smallint;
begin
 i:=FindDay(s);
 if i=-1 then msgLabel.caption:='Enter Day'
  else msgLabel.caption:=Dayname[i];
 result:=i;
end;

function findChoice(enteredTxt: string; msgLabel: Tlabel; useMsg: bool): smallint;
var
 aStr:   string;
 found,yearfound,aLen:       smallint;
begin
 aStr:=trim(enteredTxt);
 aLen:=Length(aStr);
 found:=0; yearfound:=0;
 if aLen>0 then
  begin
   found:=checkCode(0,aStr);
   if found>0 then yearfound:=findsubyear(found);
  end;

 if useMsg then
  begin
   if (found>0) and (found<>subNA) then
    begin
     aStr:=SubCode[found]+' '+Subname[found];
     {only give count if in groupsub}
     if yearfound<>0 then
      aStr:=aStr+' '+inttostr(GroupSubCount[GsubXref[found]])
     else aStr:=aStr+' 0';
    end
   else
    aStr:='Enter Subject code';
   msgLabel.caption:=aStr;
  end;

 result:=found;
end;


procedure allowNumericInputOnly(var key: char);
begin
 if (key<'0') or (key>'9') then if ord(key)>32 then key:=chr(0);
end;


procedure allowdecimalInputOnly(var key: char);
begin
 if ((key<>'.') and ((key<'0') or (key>'9'))) then if ord(key)>32 then key:=chr(0);
end;



end.
