unit Subbsdlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, GlobalToTcAndTcextra;

type
  TSubjectBySubjectDlg = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label5: TLabel;
    GroupBox3: TGroupBox;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    finish: TBitBtn;
    add: TBitBtn;
    BitBtn3: TBitBtn;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    ComboBox3: TComboBox;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure finishClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RadioButton8Click(Sender: TObject);
    procedure RadioButton7Click(Sender: TObject);
    procedure addClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure myEdit3Change(Sender: TObject);
    procedure myEdit3Enter(Sender: TObject);
    procedure myEdit3Exit(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox3Enter(Sender: TObject);
    procedure ComboBox3Exit(Sender: TObject);
  end;


var
  SubjectBySubjectDlg: TSubjectBySubjectDlg;
  usingResources:                boolean;

implementation
uses
 tcommon,DlgCommon,Subbysub;
var
 edit3:           array[1..nmbrOfGroupSubjects] of tedit;
 suberror: smallint;
{$R *.DFM}

procedure TSubjectBySubjectDlg.myEdit3Change(Sender: TObject);
var
 j:       integer;
 tmp:       string;
begin
 j:=activecontrol.tag;
 if j=0 then exit;
 tmp:=edit3[j].text;
 checkwildyearsub(uppercase(Trim(edit3[j].text)),label2,true);
end;

function checkYearSub(codeStr: string): smallint;
var
 foundpos,foundyearpos:     smallint;
begin
  suberror:=2;  foundyearpos:=0;
 codeStr:=trim(codeStr); 
 foundpos:=checkcode(0,codestr);
 result:=foundpos;
 if foundpos>0 then suberror:=1;
 if (foundpos>0) and (GroupSubs[0]>0) then foundyearpos:=findsubyear(foundpos);
 if foundyearpos<>0 then suberror:=0;
end;


procedure TSubjectBySubjectDlg.myEdit3Enter(Sender: TObject);
var
 ot: string;
 i:  integer;
begin
 i:=activecontrol.tag;
 if i=0 then exit;
 ot:=edit3[i].text;    {just to trigger change and update label}
 edit3[i].text:=edit3[i].text+'  ';
 edit3[i].text:=ot;
 SubjectBySubjectDlg.label2.visible:=true;
 edit3[i].selectall;
end;

procedure TSubjectBySubjectDlg.myEdit3Exit(Sender: TObject);
begin
 SubjectBySubjectDlg.label2.visible:=false;
end;

procedure updateEnabledRadioButton;
var
 i:       integer;
begin
 with SubjectBySubjectDlg do
 begin
  for i:=1 to nmbrOFgroupsubjects do
   edit3[i].color:=clwindow;
  edit1.color:=clwindow;
  edit2.color:=clwindow;
  combobox3.color:=clwindow;
  SubjectBySubjectDlg.radiobutton4.enabled:=SubjectBySubjectDlg.radiobutton3.checked;
  SubjectBySubjectDlg.radiobutton5.enabled:=SubjectBySubjectDlg.radiobutton3.checked;
  SubjectBySubjectDlg.radiobutton6.enabled:=SubjectBySubjectDlg.radiobutton3.checked;
  for i:=1 to nmbrOfgroupSubjects do
  begin
   if radiobutton3.checked then edit3[i].color:=clRelevantControlOnDlg;
  end;
  if radiobutton1.checked  then
  begin
   edit1.color:=clRelevantControlOnDlg;  edit2.color:=clRelevantControlOnDlg;
  end;
  if radiobutton2.checked then
   edit1.color:=clRelevantControlOnDlg;
  if radiobutton8.checked then combobox3.color:=clRelevantControlOnDlg;
 end; {with}
end;

procedure TSubjectBySubjectDlg.FormCreate(Sender: TObject);
var
 i,v1,v2:       integer;
const
 xgap=6;
 ygap=5;
begin
 self.caption:='Subject List Selection - '+GroupName;
 for i:=1 to nmbrOfGroupSubjects do
 begin
  edit3[i]:=tedit.create(application);
  edit3[i].tag:=i;
  edit3[i].maxlength:=Lencodes[0];
  edit3[i].width:=95;
  edit3[i].parent:=groupbox1;
  edit3[i].text:='';
  if i=1 then
  begin
   edit3[1].left:=label5.left+label5.width+xgap{+xgap*2};
   edit3[1].top:=label5.top+ygap{+ygap*2};
  end
  else
   begin
    v1:=i mod 3;  v2:=(i-1) div 3;
    if v1=0 then v1:=2 else v1:=v1-1;

    edit3[i].left:=edit3[1].left+v1*(edit3[1].width+xgap){+xgap};
    edit3[i].top:=edit3[1].top+v2*(edit3[1].height+ygap){+ygap};
   end;
  edit3[i].onChange:=myEdit3Change;
  edit3[i].onEnter:=myEdit3Enter;
  edit3[i].onExit:=myEdit3Exit;
 end;    {for i}
 usingResources:=true;

 combobox3.clear;
 for i:=1 to (facnum) do
  combobox3.items.add(facName[i]);
end;

procedure TSubjectBySubjectDlg.finishClick(Sender: TObject);
begin
 close;
end;

procedure TSubjectBySubjectDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
 i:       integer;
begin
 action:=caFree;
 if usingResources then   {can call close even after closeed it seems}
 begin
  usingResources:=false;
  SubjectBySubjectdlg.hide; {prevent seeing controls beeing removed -slows things down a lot}
  for i:=1 to nmbrOfGroupSubjects do
   edit3[i].free;
 end;

 end;

procedure TSubjectBySubjectDlg.RadioButton1Click(Sender: TObject);
begin
updateEnabledRadioButton;
end;

procedure TSubjectBySubjectDlg.RadioButton2Click(Sender: TObject);
begin
updateEnabledRadioButton;
end;

procedure TSubjectBySubjectDlg.RadioButton3Click(Sender: TObject);
begin
updateEnabledRadioButton;
end;

procedure TSubjectBySubjectDlg.FormActivate(Sender: TObject);
var
 i:       integer;
begin
 checkbox1.checked:=fgsubBySubListZeroSkip;
 case subbysublisttype of
  1: radiobutton7.checked:=true;
  2: radiobutton1.checked:=true;
  3: radiobutton2.checked:=true;
  4: radiobutton8.checked:=true;
  5: radiobutton3.checked:=true;
 end; {case}
 case subbysublisttypegroupnum of
  1: radiobutton4.checked:=true;
  2: radiobutton5.checked:=true;
  3: radiobutton6.checked:=true;
 end; {case}

 if sublistRanges[-2]>0 then edit1.text:=trim(SubCode[sublistRanges[-2]])
  else edit1.text:='';
 if copy(edit1.text,1,2)='00' then edit1.text:='';
 if sublistRanges[-1]>0 then edit2.text:=trim(SubCode[sublistRanges[-1]])
  else edit2.text:='';
 if copy(edit2.text,1,2)='00' then edit2.text:='';
  for i:=1 to nmbrofgroupsubjects do
   if sublistranges[i]<0 then {no subyear[] if neg}
    edit3[i].text:=copy(SubCode[abs(sublistRanges[i])],1,lencodes[0]-1)+'*'
   else begin
         if sublistRanges[i]>0 then
          edit3[i].text:=Trim(SubCode[sublistRanges[i]])
         else edit3[i].text:='';
        end;

 for i:=1 to nmbrofgroupsubjects do
  if copy(edit3[i].text,1,2)='00' then edit3[i].text:='';
 if sublistfacnum>0 then combobox3.text:=facname[sublistfacnum] else combobox3.text:='';

 updateEnabledRadioButton;
end;

procedure TSubjectBySubjectDlg.RadioButton8Click(Sender: TObject);
begin
 updateEnabledRadioButton;
end;

procedure TSubjectBySubjectDlg.RadioButton7Click(Sender: TObject);
begin
updateEnabledRadioButton;
end;

procedure TSubjectBySubjectDlg.addClick(Sender: TObject);
var
 i,j:        integer;
 msg:          string;
 tmpR:         array[-2..nmbrofgroupsubjects] of integer;
 tmpF,tmpT,tmpG,suberror1:         integer;
begin
 fgsubBySubListZeroSkip:=checkbox1.checked;
 tmpT:=1; tmpG:=1;
 if radiobutton7.checked then tmpT:=1
  else if radiobutton1.checked then tmpT:=2
   else if radiobutton2.checked then tmpT:=3
    else if radiobutton8.checked then tmpT:=4
     else if radiobutton3.checked then
          begin
           tmpT:=5;
           if radiobutton4.checked then tmpG:=1
            else if radiobutton5.checked then tmpG:=2
             else if radiobutton6.checked then tmpG:=3;
          end;
 {check sub codes entered}
 for i:=-2 to nmbrofGroupSubjects do tmpR[i]:=0;

 suberror:=0;
 if trim(edit1.text)='' then suberror:=3
  else tmpR[-2]:=checkyearsub(uppercase(trim(edit1.text)));
 suberror1:=suberror;

  if trim(edit2.text)='' then tmpR[-1]:=0
  else tmpR[-1]:=checkyearsub(uppercase(trim(edit2.text)));
 if (suberror>0) and (suberror1=0) then tmpR[-1]:=tmpR[-2];

 if trim(combobox3.text)='' then tmpF:=0
  else tmpF:=checkfaculty(uppercase(trim(combobox3.text)));
 for j:=1 to nmbrOfGroupSubjects do
  if trim(edit3[j].text)<>'' then
   tmpR[j]:=checkwildyearsub(uppercase(trim(edit3[j].text)),label2,false);

 case tmpT of
  1: ;  {none needed}
  2,3: begin
        msg:='';
        if suberror1>0 then
         begin
          case suberror1 of
           1: msg:='No students in '+subcode[tmpR[-2]];
           2: msg:='Not a valid Subject Code';
           3: msg:='Please enter a Subject Code';
          end;
          messagedlg(msg,mtError,[mbOK],0);
          edit1.selectall; edit1.setfocus;
          exit;
         end;
       end;
  4: begin
      if tmpF=0 then
      begin
       msg:='Check Faculty.';
       messagedlg(msg,mtError,[mbOK],0);
       combobox3.selectall; combobox3.setfocus;
       exit;
      end;
     end;
  5: begin
      for j:=1 to nmbrOfGroupSubjects do
      begin
       if trim(edit3[j].text)<>'' then
       begin
        if tmpR[j]=0 then
        begin
         msg:='Not a valid Subject Code.';
         messagedlg(msg,mtError,[mbOK],0);
         edit3[j].selectall; edit3[j].setfocus;
         exit;
        end;
       end;
      end;
     end;

 end; {case}
 if (tmpT=5) then
 begin
  j:=0;
  for i:=1 to nmbrofGroupSubjects do
   if tmpR[i]<>0 then inc(j);
  if j=0 then
  begin
   msg:='No subjects entered.';
   messagedlg(msg,mtError,[mbOK],0);
   edit3[1].selectall; edit3[1].setfocus;
   exit;
  end;
 end;

 {still here -so entered codes ok}
 subBySubListType:=tmpT;
 subBySubListTypeGroupnum:=tmpG;
 for i:=-2 to -1 do
  sublistRanges[i]:=tmpR[i];
 if subbysublisttype=2 then
 begin
  if sublistranges[-1]=0 then sublistranges[-1]:=sublistranges[-2];
  if GsubXref[sublistranges[-2]]>GsubXref[sublistranges[-1]] then swapint(sublistranges[-2],sublistranges[-1]);
 end;
 sublistRanges[0]:=0;
 for i:=1 to nmbrofGroupSubjects do
  if tmpR[i]<>0 then
  begin
  inc(sublistRanges[0]);
  if tmpR[i]<0 then sublistRanges[sublistRanges[0]]:=tmpR[i]
   else sublistRanges[sublistRanges[0]]:=tmpR[i];
  end;
 if sublistranges[0]<nmbrofGroupSubjects then
  for i:=sublistranges[0]+1 to nmbrofGroupSubjects do
   sublistranges[i]:=0;
 sublistfacnum:=tmpF;
 close;
 SubBySubjectWin.updatewin;
end;

procedure TSubjectBySubjectDlg.Edit1Change(Sender: TObject);
begin
 findChoice(edit1.text,label2,true);
end;

procedure TSubjectBySubjectDlg.Edit2Change(Sender: TObject);
begin
 findChoice(edit2.text,label2,true);
end;




procedure TSubjectBySubjectDlg.Edit1Enter(Sender: TObject);
var
 ot: string;
begin
 ot:=edit1.text;    {just to trigger change and update label}
 edit1.text:=edit1.text+'  ';
 edit1.text:=ot;
 SubjectBySubjectDlg.label2.visible:=true;
 edit1.selectall;

end;

procedure TSubjectBySubjectDlg.Edit2Enter(Sender: TObject);
var
 ot: string;
begin
 ot:=edit2.text;    {just to trigger change and update label}
 edit2.text:=edit2.text+'  ';
 edit2.text:=ot;
 SubjectBySubjectDlg.label2.visible:=true;
 edit2.selectall;

end;

procedure TSubjectBySubjectDlg.Edit1Exit(Sender: TObject);
begin
 SubjectBySubjectDlg.label2.visible:=false;
end;

procedure TSubjectBySubjectDlg.Edit2Exit(Sender: TObject);
begin
 SubjectBySubjectDlg.label2.visible:=false;
end;

procedure TSubjectBySubjectDlg.ComboBox3Change(Sender: TObject);
var
 i,j,k:       integer;
 t:         string;
begin
 i:=findFaculty(combobox3.text,label2);
 if i>0 then
 begin
  t:='';
  for j:=1 to facCount[i] do
  begin
   k:=facsubs[i,j];
   if k>0 then t:=t+SubCode[k]+' '
    else t:=t+copy(SubCode[abs(k)],1,lencodes[0]-1)+'* ';
  end;
  label6.caption:=t;
 end
 else
  label6.caption:='';

end;

procedure TSubjectBySubjectDlg.ComboBox3Enter(Sender: TObject);
begin
 SubjectBySubjectDlg.ComboBox3Change(Sender);
 label2.visible:=true;
 label6.visible:=true;
 combobox3.selectall;

end;

procedure TSubjectBySubjectDlg.ComboBox3Exit(Sender: TObject);
begin
 label2.visible:=false;
 label6.visible:=false;
end;

end.
