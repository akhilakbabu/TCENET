unit Groupsel;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus,TCEglobals, GlobalToTcAndTcextra;

type
  Tgroupseldlg = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    save: TBitBtn;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    Edit2: TEdit;
    Cancel: TBitBtn;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    RadioGroup2: TRadioGroup;
    Label5: TLabel;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure saveClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
  end;

var
  groupseldlg: Tgroupseldlg;

implementation
uses tcommon,DlgCommon,main,studlist,tcommon2;
{$R *.DFM}

function GroupRadioGet: smallint;
var
 radioGroupINDEX: smallint;
begin
 with groupseldlg do
 begin
   radioGroupINDEX:=0; {init it}
   if radiobutton1.checked then radioGroupINDEX:=0
    else if radiobutton2.checked then radioGroupINDEX:=1
     else if radiobutton3.checked then radioGroupINDEX:=2
      else if radiobutton4.checked then radioGroupINDEX:=3
       else if radiobutton5.checked then radioGroupINDEX:=4
        else if radiobutton6.checked then radioGroupINDEX:=5
         else if radiobutton7.checked then radioGroupINDEX:=6
          else if radiobutton8.checked then radioGroupINDEX:=7
           else if radiobutton9.checked then radioGroupINDEX:=8;
 result:=radioGroupINDEX;
 end;
end;

function findClass(enteredTxt: string; msgLabel: Tlabel): smallint;
var
 j:       smallint;
begin
 j:=findClass2(enteredTxt);
 if j>0 then
  msgLabel.caption:=ClassCode[j]
 else
  msgLabel.caption:='Enter class name';
 result:=j;
end;


procedure GroupRecipeUpdate(xs,xm: smallint; xe1,xe2: string);
var
 i: smallint;
begin
 i:=GOSrecipe.NumSteps;
 if xm=0 then {new}
 begin
  GOSrecipe.NumSteps:=1; i:=1;
  setlength(GOSrecipe.steps,2+1); {re-dim}
 end
 else
  begin
   inc(i); GOSrecipe.NumSteps:=i;
   setlength(GOSrecipe.steps,i+1); {re-dim}
  end;
 GOSrecipe.steps[i].slct:=xs; GOSrecipe.steps[i].meth:=xm;
 GOSrecipe.steps[i].e1:=xe1; GOSrecipe.steps[i].e2:=xe2;
end;

function findYearname(enteredTxt: string; msgLabel: Tlabel): smallint;
var
 aStr,bStr:   string;
 i,j,aLen,bLen,mLen:       smallint;
begin
 aStr:=UpperCase(trim(enteredTxt));
 aLen:=Length(aStr);   j:=-1;   mLen:=99;
 if aLen>0 then
  for i:=0 to years_minus_1 do
  begin
   bStr:=UpperCase(trim(yearname[i]));
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
 if j>-1 then
  msgLabel.caption:=yearname[j]
 else
  msgLabel.caption:='Enter a '+yeartitle;
 result:=j;
end;


procedure updateThisDLG;
var
 radioGroupINDEX: smallint;
begin
 with groupseldlg do
 begin
   radioGroupINDEX:=GroupRadioGet;
   label4.caption:='';
   radiogroup2.enabled:=(radioGroupINDEX<>0);
  if radiogroup2.itemindex<>3 then
   case radioGroupINDEX of
    0,9: begin
          edit1.visible:=false; label1.visible:=false;
          edit2.visible:=false; label3.visible:=false;
          checkbox1.visible:=false; label4.visible:=false;
          label2.visible:=false;
         end;
    1..3,5..8,10:
         begin
          edit1.visible:=true; label1.visible:=true;
          edit2.visible:=false; label3.visible:=false;
          checkbox1.visible:=false; label4.visible:=true;
          label2.visible:=true;
         end;
    4:   begin
          edit1.visible:=true; label1.visible:=true;
          edit2.visible:=true; label3.visible:=true;
          checkbox1.visible:=true; label4.visible:=true;
          label2.visible:=true;
         end;
   end; {case}

   edit1.text:=''; edit2.text:='';
   if edit1.visible then //cannot focus invisible control
    if radioGroupINDEX>0 then edit1.setfocus;
   label6.caption:=inttostr(GroupNum)+'/'+inttostr(numstud)+' '+GroupName;

   case radioGroupINDEX of
    1: begin   {year}
        label1.caption:='&Year Code ';
        edit1.hint:='Enter year code for selection';
        label2.visible:=false;
        HelpContext:=34;
       end;
    2: begin   {class}
        label1.caption:='&Class Code ';
        edit1.hint:='Enter class code for selection';
        label2.caption:='(* for All Classes)';
        edit1.text:='*'; edit1.selectall;
        HelpContext:=34;
       end;
    3: begin   {house}
        label1.caption:='&House Code ';
        edit1.hint:='Enter house code for selection';
        label2.caption:='(* for All Houses)';
        edit1.text:='*'; edit1.selectall;
        HelpContext:=35;
       end;
    4: begin   {id}
        label1.caption:='&From ';
        edit1.hint:='Enter lowest student ID';
        label2.caption:='';
        edit2.hint:='Enter highest student ID';
        HelpContext:=36;
       end;
    5: begin   {tutor}
        label1.caption:='&Teacher Code ';
        edit1.hint:='Enter tutor for selection';
        label2.visible:=false;
        HelpContext:=37;
       end;
    6: begin   {room}
        label1.caption:='&Room Code ';
        edit1.hint:='Enter home room for selection';
        label2.visible:=false;
        HelpContext:=38;
       end;
    7: begin   {tag}
        label1.caption:='&Tag number ';
        edit1.hint:='Enter tag number for selection';
        label2.caption:='(* for All Tags)';
        edit1.text:='*'; edit1.selectall;
        HelpContext:=39;
       end;
    8: begin   {subject}
        label1.caption:='&Subject Code ';
        edit1.hint:='Enter subject choice for selection';
        label2.visible:=false;
        HelpContext:=40;
       end;
    10: begin   {free block}
        label1.caption:='&Block Number ';
        edit1.hint:='Enter block number to select student free';
        label2.visible:=false;
        HelpContext:=42;
        end;
   end; {case}
  
  if radiogroup2.itemindex=3 then
  begin
   edit1.visible:=false; edit2.visible:=false;
   label1.visible:=false; label2.visible:=false;
   label3.visible:=false; label4.visible:=false;
   checkbox1.visible:=false;
  end;
 end;
end;

procedure Tgroupseldlg.FormActivate(Sender: TObject);
begin
   if grouptype=0 then radiobutton1.checked:=true
    else if grouptype=1 then radiobutton2.checked:=true
     else if grouptype=2 then radiobutton3.checked:=true
      else if grouptype=3 then radiobutton4.checked:=true
       else if (grouptype=4) or (grouptype=11) then radiobutton5.checked:=true
        else if grouptype=5 then radiobutton6.checked:=true
         else if grouptype=6 then radiobutton7.checked:=true
          else if grouptype=7 then radiobutton8.checked:=true
           else if grouptype=8 then radiobutton9.checked:=true;
 edit1.text:='';  edit2.text:='';
 label6.caption:=inttostr(GroupNum)+'/'+inttostr(numstud)+' '+GroupName;
 if grouptype=11 then checkbox1.Checked:=true;
 updateThisDLG;
end;

procedure Tgroupseldlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure Tgroupseldlg.saveClick(Sender: TObject);
var
 msg:     string;
 codeStr:      string;
 i,j,k,tmpNum,m:     integer;
 tmpGroup:     integer;
 wcPos,num:        integer;
 oldStudSelcode:      integer;
 methodSel:           integer;
 matchArr:         array of integer;
 radioGroupINDEX: smallint;
begin
 setlength(matchArr,nmbrSubjects+1);

 setlength(StGroup,numStud+1);
   radioGroupINDEX:=GroupRadioGet;

 oldStudSelcode:=-1;   tmpNum:=0;
 if wnFlag[wnStudentList] then
 begin
 if studentlistwin.selcode>0 then
  oldStudSelcode:=StPointer[studentlistwin.selcode];  {protect stud selcode}
 end;
 GroupType:=radioGroupINDEX;
 methodSel:=radiogroup2.itemindex;
 groupSelStr[1]:=edit1.text; groupselstr[2]:=edit2.text;
 if GroupType=4 then if checkbox1.checked then GroupType:=11;

case GroupType of
 0: begin  {all}
     for i:=1 to numstud do
      StudGrpFlg[i]:=1;
     GroupName:='All';
    end;
 1: begin  {year}
     if methodSel<>3 then
     begin
      codeStr:=uppercase(trim(groupSelStr[1]));
      if codeStr='' then
      begin
       msg:='No year selected'+endline;
       messagedlg(msg,mtError,[mbOK],0);
       exit;  {return to editing}
      end;
      tmpNum:=findyear(codeStr);
      if (tmpNum=-1) then
      begin
       msg:='Check year entered.'+endline;
       messagedlg(msg,mtError,[mbOK],0);
       edit1.setfocus;
       exit;  {return to editing}
      end;
     end; {methodsel<>3}
     SetYearGroup(methodSel);
     if methodSel=0 then groupname:=Yeartitle+' '+yearname[tmpnum]
        else groupname:='Custom';
    end;
 2: begin  {class}
     if classnum=0 then
     begin
      msg:='No class codes!'+endline;
      messagedlg(msg,mtError,[mbOK],0);
      exit;  {return to editing}
     end;
     codeStr:=uppercase(trim(groupSelStr[1]));
     tmpNum:=findClass2(codeStr);tmpGroup:=0;
     if codeStr='*' then tmpNum:=-1;
     wcPos:=pos('*',codeStr);
     if wcPos>1 then
       begin
        codeStr:=copy(codeStr,1,wcPos-1);
        tmpGroup:= findClass2(codeStr);
       end;
     if methodSel<>3 then
      begin
       if codeStr='' then
       begin
        msg:='No class selected'+endline;
        messagedlg(msg,mtError,[mbOK],0);
        exit;  {return to editing}
       end;
       if ((tmpNum=0) and (tmpGroup=0)) then
        begin
         msg:='Check class entered.'+endline;
         messagedlg(msg,mtError,[mbOK],0);
         edit1.setfocus;
         exit;  {return to editing}
        end;
      end;  {if methodSel<>3}
     SetClassGroup(methodSel);
     if methodSel<>0 then groupname:='Custom'
      else
       begin
         if tmpNum<0 then GroupName:='All classes'
          else if tmpGroup=0 then
            GroupName:='Class '+ClassCode[tmpnum]
             else GroupName:='Class '+codeStr+'*';
       end;
    end;
 3: begin  {house}
     if HouseCount=0 then
     begin
      msg:='No house codes!'+endline;
      messagedlg(msg,mtError,[mbOK],0);
      exit;  {return to editing}
     end;
     codeStr:=uppercase(trim(groupSelStr[1]));
     tmpNum:=findHouse2(codeStr);
     if codeStr='*' then tmpNum:=-1;
     if methodSel<>3 then
     begin
       if codeStr='' then
       begin
        msg:='No house selected'+endline;
        messagedlg(msg,mtError,[mbOK],0);
        exit;  {return to editing}
       end;
       if (tmpNum=0) then
        begin
         msg:='Check house entered.'+endline;
         messagedlg(msg,mtError,[mbOK],0);
         edit1.setfocus;
         exit;  {return to editing}
        end;
     end;
     SetHouseGroup(methodSel);
     if methodSel<>0 then groupname:='Custom'
      else
       begin
         if tmpNum<0 then GroupName:='All houses'
          else GroupName:='House '+HouseName[tmpnum];
       end;
    end;
 4,11: SetIDGroup(GroupType,methodSel);
 5: begin  {tutor}
     if Numcodes[1]=0 then
     begin
      msg:='No teacher codes!'+endline;
      messagedlg(msg,mtError,[mbOK],0);
      exit;  {return to editing}
     end;
     if methodSel<>3 then
     begin
       codeStr:=uppercase(trim(groupSelStr[1]));
       if codeStr='' then
       begin
        msg:='No teacher selected'+endline;
        messagedlg(msg,mtError,[mbOK],0);
        exit;  {return to editing}
       end;
       tmpNum:=findtutor(codeStr,label4);
       if tmpNum=0 then
       begin
        msg:='Check teacher!'+endline;
        messagedlg(msg,mtError,[mbOK],0);
        edit1.setfocus; edit1.SelectAll;
        exit;  {return to editing}
       end;
     end;{methodsel<>3}
     SetTutorGroup(methodSel);
     if methodSel=0 then groupname:='Tutor '+TeCode[tmpnum,0]
        else groupname:='Custom';
    end;
 6:begin  {room}
    if Numcodes[2]=0 then
     begin
      msg:='No room codes!'+endline;
      messagedlg(msg,mtError,[mbOK],0);
      exit;  {return to editing}
     end;
    codeStr:=uppercase(trim(groupSelStr[1]));
    if methodSel<>3 then
     begin
       if codeStr='' then
       begin
        msg:='No room selected'+endline;
        messagedlg(msg,mtError,[mbOK],0);
        exit;  {return to editing}
       end;
       tmpNum:=findroom(codeStr,label4);
       if tmpNum=0 then
       begin
        msg:='Check room!'+endline;
        messagedlg(msg,mtError,[mbOK],0);
        edit1.setfocus; edit1.SelectAll;
        exit;  {return to editing}
       end;
     end;
    SetRoomGroup(methodSel);
    if methodSel=0 then groupname:='Room '+TeCode[tmpnum,1]
        else groupname:='Custom';
   end; {room}
 7: begin  {tag}
     codestr:=trim(groupSelStr[1]);
     tmpNum:=strtointdef(codestr,0);
     if codestr='*' then tmpNum:=-1;
     if (tmpNum=0) then
      begin
       msg:='Check tag number entered.'+endline;
       messagedlg(msg,mtError,[mbOK],0);
       edit1.setfocus;
       exit;  {return to editing}
      end;
     SetTagGroup(methodSel);
     if methodSel<>0 then groupname:='Custom'
      else
       begin
         if tmpNum<1 then GroupName:='All tags'
          else GroupName:='Tag '+inttostr(tmpNum);
       end;
    end;  {tag}
 8: begin  {subject}
     if Numcodes[0]=0 then
     begin
      msg:='No subject codes!'+endline;
      messagedlg(msg,mtError,[mbOK],0);
      exit;  {return to editing}
     end;
     if methodSel<>3 then
     begin
       codeStr:=uppercase(trim(groupSelStr[1]));
       if codeStr='' then
       begin
        msg:='No subject selected'+endline;
        messagedlg(msg,mtError,[mbOK],0);
        exit;  {return to editing}
       end;
       tmpNum:=checkWildSub(codeStr);
       if tmpNum=0 then
       begin
        msg:='Check subject!'+endline;
        messagedlg(msg,mtError,[mbOK],0);
        edit1.setfocus;
        exit;  {return to editing}
       end;
     end; {methodSel<>3}
     SetSubGroup(methodSel);
     if methodSel=0 then groupname:='Subject '+codestr
        else groupname:='Custom';
    end;
 
   end; {case}

 num:=0;
 for i:=1 to numstud do
 begin
  j:=StudSort[i];
  if StudGrpFlg[j]>0 then
  begin
   inc(num); StGroup[num]:=j;
  end;
 end; {for i}
 groupnum:=num;

 if wnFlag[wnStudentList] then
 begin
  if ((StudListType<>7) and (studentlistwin.selcode>0)) then   {restore stud selcode}
  begin
   studentpointerset;
   m:=0;
   for k:=1 to groupnum do
   begin
    if StPointer[k]=oldStudSelcode then
    begin
     m:=k;
     break;
    end;
   end; {for k}
   studentlistwin.selcode:=m;
  end;
 end;  {if wnFlag[wnStudentList]}

 updateGroupSubs;
 GroupRecipeUpdate(grouptype,radiogroup2.itemindex,edit1.text,edit2.text);

 UpdateStudWins;

 if radiogroup2.itemindex=0 then  {set to new if new group - so can press save straight away}
  combobox1.itemindex:=0;

 label6.caption:=inttostr(GroupNum)+'/'+inttostr(numstud)+' '+GroupName;
end;

procedure Tgroupseldlg.Edit1Change(Sender: TObject);
var
 s: string;
 radioGroupINDEX: smallint;
begin
 radioGroupINDEX:=GroupRadioGet;

 case radioGroupINDEX of
  1: findYearname(edit1.text,label4); {year}
  2: findclass(edit1.text,label4);   {class}
  3: findhouse(edit1.text,label4);   {house}
  5: findtutor(edit1.text,label4);   {tutor}
  6: findroom(edit1.text,label4);   {room}
  8: begin  {subject}
      s:=trim(edit1.text);
      CheckWildYearSub(s,label4,true);
     end;
 end; {case}
end;

procedure Tgroupseldlg.Edit1Enter(Sender: TObject);
var
 ot: string;
 radioGroupINDEX: smallint;
begin
 radioGroupINDEX:=GroupRadioGet;

 case radioGroupINDEX of
  2,3,5,6,8:
   begin
    ot:=edit1.text;    {just to trigger change and update label}
    edit1.text:=edit1.text+'  ';
    edit1.text:=ot;
    label4.visible:=true;
    edit1.selectall;
   end;
 end;
end;

procedure Tgroupseldlg.Edit1Exit(Sender: TObject);
begin
 label4.visible:=false;
end;


procedure Tgroupseldlg.FormCreate(Sender: TObject);
var
 i: smallint;
begin
 combobox1.clear;
 combobox1.items.add('(new)');
 if GOSnum>0 then
  for i:=1 to GOSnum do
   combobox1.items.add(GOSname[i]);
 combobox1.itemindex:=0;    {new}
end;

procedure Tgroupseldlg.ComboBox1Change(Sender: TObject);
begin
 if combobox1.itemindex>0 then
 begin
  setRecipeFromGOS(combobox1.itemindex);
  REselectgroup;
  UpdateStudWins;
  GroupName:=GOSname[combobox1.itemindex];
  label6.caption:=inttostr(GroupNum)+'/'+inttostr(numstud)+' '+GroupName;
 end;
end;

function groupExistsAlready(ss:string):wordbool;
var
 i: smallint;
 s1,s2: string;
begin
 result:=false;
 for i:=1 to GOSnum do
 begin
  s1:=uppercase(trim(ss));
  s2:=uppercase(trim(GOSname[i]));
  if s1=s2 then begin result:=true; break; end;
 end; {for i}
end;

procedure Tgroupseldlg.RadioButton1Click(Sender: TObject);
begin
 updateThisDLG;
end;

procedure Tgroupseldlg.RadioGroup2Click(Sender: TObject);
var
 a,b: string;
begin
  a:=edit1.text; b:=edit2.text;
  updateThisDLG;
  edit1.text:=a; edit2.text:=b;
end;

end.


