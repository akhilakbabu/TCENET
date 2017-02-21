unit Tettdlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,TCEglobals, GlobalToTcAndTcextra;

type
  TTeacherTTdlg = class(TForm)
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    ComboBox3: TComboBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    Panel1: TPanel;
    RadioButton6: TRadioButton;
    RadioButton5: TRadioButton;
    YearClass: TRadioGroup;
    DayOrWeek: TRadioGroup;
    Label4: TLabel;
    ListBox1: TListBox;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label5: TLabel;
    ListBox2: TListBox;
    Label8: TLabel;
    UpBtn: TBitBtn;
    DnBtn: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure RadioButton7Click(Sender: TObject);
    procedure RadioButton8Click(Sender: TObject);
    procedure OKbuttonClick(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox3Enter(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox2Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure DayOrWeekClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DnBtnClick(Sender: TObject);
  private
    procedure CheckRadioButtons;
  end;

var
  TeacherTTdlg: TTeacherTTdlg;

implementation
uses
 tcommon,DlgCommon,tcommon2,tcommon3, Teachtt;
var
 tmpsel:  tpTeData;
 duringload:    boolean;

{$R *.DFM}

procedure TTeacherTTdlg.CheckRadioButtons;
begin
 combobox1.color:=clWindow;  combobox1.enabled:=false;
 combobox2.color:=clWindow;  combobox2.enabled:=false;
 listbox1.color:=clwindow; listbox2.color:=clwindow;
 listbox1.enabled:=false;  listbox2.enabled:=false;
 bitbtn1.enabled:=false; bitbtn2.enabled:=false;
 bitbtn3.enabled:=false; bitbtn4.enabled:=false;
 if DayOrWeek.ItemIndex=0 then  {daily}
  begin
   HiLiteCombo(combobox1);  HiLiteCombo(combobox2);
  end;
 if radiobutton5.checked then
  begin
   HiLiteList(listbox1); HiLiteList(listbox2);
   bitbtn1.enabled:=true; bitbtn2.enabled:=true;
   bitbtn3.enabled:=true; bitbtn4.enabled:=true;
  end;
end;


procedure TTeacherTTdlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure TTeacherTTdlg.FormActivate(Sender: TObject);
begin
 case tettseltype of
  1: radiobutton6.checked:=true;
  2: radiobutton5.checked:=true;
 end;
 yearclass.ItemIndex:=tyr;
 DayOrWeek.ItemIndex:=winView[wnTeacherTt];
 checkRadiobuttons;
end;

procedure TTeacherTTdlg.RadioButton7Click(Sender: TObject);
begin
 checkRadiobuttons;
end;

procedure TTeacherTTdlg.RadioButton8Click(Sender: TObject);
begin
 checkRadiobuttons;
end;

procedure TTeacherTTdlg.OKbuttonClick(Sender: TObject);
var
 i:        integer;
begin
 tyr:=yearclass.ItemIndex;
 winView[wnTeacherTt]:=DayOrWeek.ItemIndex;
 if winView[wnTeacherTt]=0 then {daily}
  begin
   if BadDayCombo(tettlistvals[4],combobox1) then exit;
   if BadDayCombo(tettlistvals[5],combobox2) then exit;
   if tettlistvals[5]<tettlistvals[4] then swapint(tettlistvals[5],tettlistvals[4]);
  end;
 for i:=0 to nmbrteachers do tettselection[i]:=tmpsel[i];
 close;
 TeTtable.UpdateWin;
end;


procedure TTeacherTTdlg.ComboBox3Change(Sender: TObject);
begin
 if duringload then exit;
 tettlistvals[3]:=findFaculty(combobox3.text,label12);
end;

procedure TTeacherTTdlg.ComboBox3Enter(Sender: TObject);
begin
 ComboBox3Change(Sender);
 label12.visible:=true;
 combobox3.selectall;
end;

procedure TTeacherTTdlg.ComboBox1Change(Sender: TObject);
begin
 if duringload then exit;
 tettlistvals[4]:=finddayMsg(combobox1.text,label12);
end;

procedure TTeacherTTdlg.ComboBox1Enter(Sender: TObject);
begin
 ComboBox1Change(Sender);
 label12.visible:=true;
 ComboBox1.selectall;
end;

procedure TTeacherTTdlg.ComboBox1Exit(Sender: TObject);
begin
 label12.caption:='';
 label12.visible:=false;
end;

procedure TTeacherTTdlg.ComboBox2Change(Sender: TObject);
begin
 if duringload then exit;
 tettlistvals[5]:=finddayMsg(combobox2.text,label12);
end;

procedure TTeacherTTdlg.ComboBox2Enter(Sender: TObject);
begin
 ComboBox2Change(Sender);
 label12.visible:=true;
 ComboBox2.selectall;
end;

procedure TTeacherTTdlg.FormCreate(Sender: TObject);
var
 i:       integer;
begin
 duringload:=true;
 fillchar(tmpsel,sizeof(tmpsel),chr(0));
 FillComboDays(false,ComboBox1);
 if tettlistvals[4]>-1 then combobox1.text:=day[tettlistvals[4]]
  else combobox1.text:='';
 FillComboDays(false,ComboBox2);
 if tettlistvals[5]>-1 then combobox2.text:=day[tettlistvals[5]]
  else combobox2.text:='';
 FillComboFaculty(false,combobox3);
 combobox3.clear;
 for i:=1 to (facnum) do combobox3.items.add(facName[i]);
 if tettlistvals[3]>0 then combobox3.text:=facName[tettlistvals[3]]
   else combobox3.text:='';

 listbox1.clear;
 for i:=1 to codenum[1] do
  listbox1.items.add(tecode[codepoint[i,1],0]);
 label3.caption:=inttostr(listbox1.items.count);

 listbox2.clear;
 {add saved selection here}

 rangeCheckCodeSels(tettselection,1);
 if tettselection[0]>0 then
  for i:=0 to tettselection[0] do
   begin
    tmpsel[i]:=tettselection[i];
    if i>0 then listbox2.items.add(tecode[tmpsel[i],0]);
   end;
 label8.caption:=inttostr(listbox2.items.count);
 duringload:=false;
end;

procedure TTeacherTTdlg.BitBtn1Click(Sender: TObject);
begin
 MoveOffList(tmpSel,listbox2,label8);
end;

procedure TTeacherTTdlg.BitBtn2Click(Sender: TObject);
begin
 ClearList(tmpSel,listbox2,label8);
end;

procedure TTeacherTTdlg.BitBtn3Click(Sender: TObject);
begin
 MoveOnSubList(tmpSel,listbox1,listbox2,label8,1);
end;

procedure TTeacherTTdlg.BitBtn4Click(Sender: TObject);
begin
 FillSubList(tmpSel,listbox1,listbox2,label8,1);
end;

procedure TTeacherTTdlg.RadioButton6Click(Sender: TObject);
begin
 tettseltype:=1;
 checkRadiobuttons;
end;

procedure TTeacherTTdlg.RadioButton5Click(Sender: TObject);
begin
 tettseltype:=2;
 checkRadiobuttons;
end;

procedure TTeacherTTdlg.DayOrWeekClick(Sender: TObject);
begin
 checkRadiobuttons;
end;

procedure TTeacherTTdlg.UpBtnClick(Sender: TObject);
begin
 MoveUpList(tmpSel,ListBox2);
end;

procedure TTeacherTTdlg.DnBtnClick(Sender: TObject);
begin
 MoveDownList(tmpSel,ListBox2);
end;

end.
