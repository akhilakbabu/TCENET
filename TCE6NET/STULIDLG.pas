unit Stulidlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,TCEglobals, GlobalToTcAndTcextra;

type
  TStudListDlg = class(TForm)
    GroupBox2: TGroupBox;
    Label5: TLabel;
    CheckBox2: TCheckBox;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    RadioButton5: TRadioButton;

    RadioButton13: TRadioButton;
    RadioButton14: TRadioButton;
    RadioButton15: TRadioButton;
    RadioButton16: TRadioButton;
    RadioButton17: TRadioButton;
    RadioButton18: TRadioButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    ListBox1: TListBox;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label4: TLabel;
    ListBox2: TListBox;
    Label7: TLabel;
    UpBtn: TBitBtn;
    DnBtn: TBitBtn;
    procedure OKbuttonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure RadioButton13Click(Sender: TObject);
    procedure RadioButton14Click(Sender: TObject);
    procedure RadioButton15Click(Sender: TObject);
    procedure RadioButton16Click(Sender: TObject);
    procedure RadioButton17Click(Sender: TObject);
    procedure RadioButton18Click(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DnBtnClick(Sender: TObject);
  private
    procedure InitLists;
    procedure UpdateThisDlg;
  end;

var
  StudListDlg: TStudListDlg;
  

implementation
uses tcommon,DlgCommon,studlist,tcommon2;
{$R *.DFM}

var
 tmpStug:       tpstudentdata;
 tmpshow1,tmpshow2:            integer;
 tmpclass,tmphouse:            integer;
 tmptutor,tmproom:             integer;

procedure TStudListDlg.InitLists;
var
 i,j,k:integer;
 i2:     integer;
 tmpList:       tpTeData;
begin
 label6.caption:=''; label7.caption:='';
 listbox1.clear; listbox2.clear;  combobox1.clear;
 combobox2.clear;  combobox3.clear;  combobox4.clear;

 for i:=1 to numstud do
  listbox1.items.add(Stud[i].stname+' '+Stud[i].first);

 FillComboRollClass(combobox1,tmpclass,radiobutton15);

 combobox2.items.add('All houses');
 j:=0;
 for i:=1 to housecount do
  if trim(HouseName[i])>'' then
   begin
    combobox2.items.add(HouseName[i]);
    inc(j);
   end;
 if bool(j) then
  begin
   combobox2.itemindex:=tmphouse;
   combobox2.update;
  end
 else
  radiobutton16.enabled:=false;

 fillchar(tmpList,sizeof(tmpList),chr(0));
 for i:=1 to numstud do
  if Stud[i].tutor>0 then tmpList[Stud[i].tutor]:=1;

 combobox3.items.add('All tutors');
 if codenum[1]>0 then
  begin
   i2:=0;
   for i:=1 to codenum[1] do
    begin
     k:=codepoint[i,1];
     if bool(tmpList[k]) then
      begin
       combobox3.items.add(tecode[k,0]+'   '+tename[k,0]);
       inc(i2);
      end;
     if k=tmptutor then j:=i2;
    end;
   if tmptutor=0 then combobox3.itemindex:=0
    else combobox3.itemindex:=j;
   combobox3.update;
  end
 else
  radiobutton17.enabled:=false;

 fillchar(tmpList,sizeof(tmpList),chr(0));
 for i:=1 to numstud do
   if Stud[i].home>0 then tmpList[Stud[i].home]:=1;

 combobox4.items.add('All home rooms');
 if codenum[2]>0 then
  begin
   i2:=0;
   for i:=1 to codenum[2] do
    begin
     k:=codepoint[i,2];
     if bool(tmpList[k]) then
      begin
       combobox4.items.add(tecode[k,1]+'   '+tename[k,1]);
       inc(i2);
      end;
     if k=tmproom then j:=i2;
    end;
   if tmproom=0 then combobox4.itemindex:=0
    else combobox4.itemindex:=j;
   combobox4.update;
  end
 else
   radiobutton18.enabled:=false;
 if tmpStug[0]>0 then
  for i:=1 to tmpStug[0] do
   listbox2.items.add(Stud[tmpStug[i]].stname+' '+Stud[tmpStug[i]].first);

 label6.caption:=inttostr(listbox1.items.count);
 label7.caption:=inttostr(listbox2.items.count);
end;

procedure TStudListDlg.UpdateThisDlg;
begin
 listbox1.color:=clwindow; listbox2.color:=clwindow;
 listbox1.enabled:=false;  listbox2.enabled:=false;
 combobox1.color:=clwindow; combobox1.enabled:=false;
 combobox2.color:=clwindow; combobox2.enabled:=false;
 combobox3.color:=clwindow; combobox3.enabled:=false;
 combobox4.color:=clwindow; combobox4.enabled:=false;
 bitbtn1.enabled:=false; bitbtn2.enabled:=false;
 bitbtn3.enabled:=false; bitbtn4.enabled:=false;

 case tmpshow2 of
  1: begin  {selection}
      radiobutton13.checked:=true;
      HiLiteList(listbox1); HiLiteList(listbox2);
      bitbtn1.enabled:=true; bitbtn2.enabled:=true;
      bitbtn3.enabled:=true; bitbtn4.enabled:=true;
     end;
  2: begin  {group}
      radiobutton14.checked:=true;
     end;
  3: begin  {class}
      radiobutton15.checked:=true;
      HiLiteCombo(combobox1);
     end;
  4: begin  {house}
      radiobutton16.checked:=true;
      HiLiteCombo(combobox2);
     end;
  5: begin  {tutor}
      radiobutton17.checked:=true;
      HiLiteCombo(combobox3);
     end;
  6: begin   {home room}
      radiobutton18.checked:=true;
      HiLiteCombo(combobox4);
     end;
 end; {case}
 radiobutton6.enabled:=radiobutton5.checked;
 radiobutton7.enabled:=radiobutton5.checked;
 radiobutton8.enabled:=radiobutton5.checked;
 radiobutton9.enabled:=radiobutton5.checked;
 radiobutton10.enabled:=radiobutton5.checked;
end;





procedure TStudListDlg.OKbuttonClick(Sender: TObject);
var
 i:              integer;
 lt,lnt:             integer;
begin
 lt:=1;   lnt:=1;
 if radiobutton13.checked then lt:=1
  else if radiobutton14.checked then lt:=2
   else if radiobutton15.checked then lt:=3
    else if radiobutton16.checked then lt:=4
     else if radiobutton17.checked then lt:=5
      else if radiobutton18.checked then lt:=6
       else if radiobutton5.checked then
       begin
        lt:=7;
        if radiobutton6.checked then lnt:=1
         else if radiobutton7.checked then lnt:=2
          else if radiobutton8.checked then lnt:=3
           else if radiobutton9.checked then lnt:=4
            else if radiobutton10.checked then lnt:=5;
       end;


 {ok to update vars  - only after verify}
 StudListType:=lt;    listnumbertype:=lnt;

 listEnrolment:=checkbox2.checked;
 MatchAllYears:=checkbox1.checked;

 //close;
 try
  screen.cursor:=crHourglass;
 for i:=0 to nmbrstudents do
  liststudentselection[i]:=tmpStug[i];

 tmpclass:=findclass2(combobox1.text);
 tmphouse:=findhouse2(combobox2.text);
 if combobox3.text='All tutors' then
  tmptutor:=0
 else
  tmptutor:=findtutor2(copy(combobox3.text,1,lencodes[1]));
 if combobox4.text='All home rooms' then
  tmproom:=0
 else
  tmproom:=findroom2(copy(combobox4.text,1,lencodes[2]));

 listRanges[1,1]:=tmpclass;
 listRanges[2,1]:=tmphouse;
 listRanges[3,1]:=tmptutor;
 listRanges[4,1]:=tmproom;
 UpdateStudWins;
 finally
  screen.cursor:=crDefault;
 end;

end;

procedure TStudListDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TStudListDlg.FormCreate(Sender: TObject);
var
 i:       integer;
begin
 fillchar(tmpStug,sizeof(tmpStug),chr(0));
 for i:=0 to nmbrstudents do tmpStug[i]:=liststudentselection[i];
 tmpclass:=listRanges[1,1];
 tmphouse:=listRanges[2,1];
 tmptutor:=listRanges[3,1];
 tmproom:=listRanges[4,1];
 tmpshow2:=StudListType;
 tmpshow1:=listnumbertype;
end;

procedure TStudListDlg.FormActivate(Sender: TObject);
begin
 case StudListType of
  1: radiobutton13.checked:=true;
  2: radiobutton14.checked:=true;
  3: radiobutton15.checked:=true;
  4: radiobutton16.checked:=true;
  5: radiobutton17.checked:=true;
  6: radiobutton18.checked:=true;
  7: begin
      radiobutton5.checked:=true;
      case listnumbertype of
       1: radiobutton6.checked:=true;
       2: radiobutton7.checked:=true;
       3: radiobutton8.checked:=true;
       4: radiobutton9.checked:=true;
       5: radiobutton10.checked:=true;
      end; {case}
     end;
 end; {case}
 if radiobutton5.checked then
 begin
  radiobutton6.enabled:=true;
  radiobutton7.enabled:=true;
  radiobutton8.enabled:=true;
  radiobutton9.enabled:=true;
  radiobutton10.enabled:=true;
 end
 else
 begin
  radiobutton6.enabled:=false;
  radiobutton7.enabled:=false;
  radiobutton8.enabled:=false;
  radiobutton9.enabled:=false;
  radiobutton10.enabled:=false;
 end;
 checkbox2.checked:=listEnrolment;
 checkbox1.checked:=MatchAllYears;
 initlists;
 updatethisdlg;
end;

procedure TStudListDlg.RadioButton5Click(Sender: TObject);
begin
 tmpshow2:=7;
 updatethisdlg;
end;

procedure TStudListDlg.BitBtn1Click(Sender: TObject);
begin
 MoveOffList(tmpStug,listbox2,label7);
end;

procedure TStudListDlg.BitBtn2Click(Sender: TObject);
begin
 ClearList(tmpStug,listbox2,label7);
end;

procedure TStudListDlg.BitBtn3Click(Sender: TObject);
begin
 MoveOnStudList(tmpStug,listbox1,listbox2,label7);
end;

procedure TStudListDlg.BitBtn4Click(Sender: TObject);
begin
 FillStudList(tmpStug,listbox1,listbox2,label7);
end;

procedure TStudListDlg.ComboBox1Change(Sender: TObject);
begin
 tmpclass:=findclass2(combobox1.text);
end;

procedure TStudListDlg.ComboBox2Change(Sender: TObject);
begin
 tmphouse:=findhouse2(combobox2.text);
end;

procedure TStudListDlg.ComboBox3Change(Sender: TObject);
begin
 if combobox3.text='All tutors' then
  tmptutor:=0
 else
  tmptutor:=findtutor2(copy(combobox3.text,1,lencodes[1]));
end;

procedure TStudListDlg.ComboBox4Change(Sender: TObject);
begin
 if combobox4.text='All home rooms' then
  tmproom:=0
 else
  tmproom:=findroom2(copy(combobox4.text,1,lencodes[2]));
end;

procedure TStudListDlg.RadioButton13Click(Sender: TObject);
begin
 tmpshow2:=1;
 updatethisdlg;
end;

procedure TStudListDlg.RadioButton14Click(Sender: TObject);
begin
 tmpshow2:=2;
 updatethisdlg;
end;

procedure TStudListDlg.RadioButton15Click(Sender: TObject);
begin
 tmpshow2:=3;
 updatethisdlg;
end;

procedure TStudListDlg.RadioButton16Click(Sender: TObject);
begin
 tmpshow2:=4;
 updatethisdlg;
end;

procedure TStudListDlg.RadioButton17Click(Sender: TObject);
begin
 tmpshow2:=5;
 updatethisdlg;
end;

procedure TStudListDlg.RadioButton18Click(Sender: TObject);
begin
 tmpshow2:=6;
 updatethisdlg;
end;

procedure TStudListDlg.UpBtnClick(Sender: TObject);
begin
 MoveUpList(tmpStug,ListBox2);
end;

procedure TStudListDlg.DnBtnClick(Sender: TObject);
begin
 MoveDownList(tmpStug,ListBox2);
end;

end.
