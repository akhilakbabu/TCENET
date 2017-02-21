unit Rottdlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,TCEglobals, GlobalToTcAndTcextra;

type
  TRoomTTdlg = class(TForm)
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    Panel1: TPanel;
    RadioButton6: TRadioButton;
    RadioButton5: TRadioButton;
    Label8: TLabel;
    YearClass: TRadioGroup;
    DayOrWeek: TRadioGroup;
    Label4: TLabel;
    ListBox1: TListBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label5: TLabel;
    ListBox2: TListBox;
    Label3: TLabel;
    UpBtn: TBitBtn;
    DnBtn: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure OKbuttonClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure ComboBox2Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox3Enter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure DayOrWeekClick(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DnBtnClick(Sender: TObject);
  private
    procedure checkRadiobuttons;
  end;


var
  RoomTTdlg: TRoomTTdlg;

implementation
uses
 tcommon,DlgCommon,tcommon2,tcommon3, Roomtt;
var
 tmpsel:  tpTeData;
 duringload:    boolean;

{$R *.DFM}

procedure TRoomTTdlg.checkRadiobuttons;
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





procedure TRoomTTdlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure TRoomTTdlg.FormActivate(Sender: TObject);
begin
 case rottseltype of
  1: radiobutton6.checked:=true;
  2: radiobutton5.checked:=true;
 end;

 yearclass.ItemIndex:=tyr;
 DayOrWeek.ItemIndex:=winView[wnRoomTt];
 checkRadiobuttons;
end;

procedure TRoomTTdlg.OKbuttonClick(Sender: TObject);
var
 i:        integer;
begin
 tyr:=yearclass.ItemIndex;
 winView[wnRoomTt]:=DayOrWeek.ItemIndex;
{verify input if needed}
 if winView[wnRoomTt]=0 then {daily}
  begin
   if BadDayCombo(rottlistvals[4],combobox1) then exit;
   if BadDayCombo(rottlistvals[5],combobox2) then exit;
   if rottlistvals[5]<rottlistvals[4] then swapint(rottlistvals[5],rottlistvals[4]);
   if rottlistvals[5]>days-1 then rottlistvals[5]:=days-1;
  end;
 for i:=0 to nmbrteachers do rottselection[i]:=tmpsel[i];
 close;
 RoTtable.UpdateWin;
end;




procedure TRoomTTdlg.ComboBox1Change(Sender: TObject);
begin
 if duringload then exit;
 rottlistvals[4]:=finddayMsg(combobox1.text,label12);
end;

procedure TRoomTTdlg.ComboBox2Change(Sender: TObject);
begin
 if duringload then exit;
 rottlistvals[5]:=finddayMsg(combobox2.text,label12);
end;

procedure TRoomTTdlg.ComboBox1Enter(Sender: TObject);
begin
 ComboBox1Change(Sender);
 ComboBox1.selectall;
end;

procedure TRoomTTdlg.ComboBox2Enter(Sender: TObject);
begin
 RoomTTdlg.ComboBox2Change(Sender);
 ComboBox2.selectall;
end;

procedure TRoomTTdlg.FormCreate(Sender: TObject);
var
 i:       integer;
begin
 duringload:=true;
 fillchar(tmpsel,sizeof(tmpsel),chr(0));
 FillComboDays(false,ComboBox1);
 if rottlistvals[4]>-1 then combobox1.text:=day[rottlistvals[4]]
  else combobox1.text:='';

 FillComboDays(false,ComboBox2);
 if rottlistvals[5]>-1 then combobox2.text:=day[rottlistvals[5]]
  else combobox2.text:='';

 FillComboFaculty(false,combobox3);
 if rottlistvals[3]>0 then combobox3.text:=facName[rottlistvals[3]]
   else combobox3.text:='';

 listbox1.clear;
 for i:=1 to codenum[2] do listbox1.items.add(tecode[codepoint[i,2],1]);
 label1.caption:=inttostr(listbox1.items.count);
 listbox2.clear;
 rangeCheckCodeSels(rottselection,2);
 if rottselection[0]>0 then
  for i:=0 to rottselection[0] do
   begin
    tmpsel[i]:=rottselection[i];
    if i>0 then listbox2.items.add(tecode[tmpsel[i],1]);
   end;
 label3.caption:=inttostr(listbox2.items.count);

 duringload:=false;
end;

procedure TRoomTTdlg.ComboBox3Change(Sender: TObject);
begin
 if duringload then exit;
 rottlistvals[3]:=findFaculty(combobox3.text,label12);
end;

procedure TRoomTTdlg.ComboBox3Enter(Sender: TObject);
begin
 ComboBox3Change(Sender);
 combobox3.selectall;
end;

procedure TRoomTTdlg.BitBtn1Click(Sender: TObject);
begin
 MoveOffList(tmpSel,listbox2,label3);
end;

procedure TRoomTTdlg.BitBtn2Click(Sender: TObject);
begin
 ClearList(tmpSel,listbox2,label3);
end;

procedure TRoomTTdlg.BitBtn3Click(Sender: TObject);
begin
 MoveOnSubList(tmpSel,listbox1,listbox2,label3,2);
end;

procedure TRoomTTdlg.BitBtn4Click(Sender: TObject);
begin
 FillSubList(tmpSel,listbox1,listbox2,label3,2);
end;

procedure TRoomTTdlg.RadioButton6Click(Sender: TObject);
begin
 rottseltype:=1;
 checkRadiobuttons;
end;

procedure TRoomTTdlg.DayOrWeekClick(Sender: TObject);
begin
 checkRadiobuttons;
end;

procedure TRoomTTdlg.RadioButton5Click(Sender: TObject);
begin
 rottseltype:=2;
 checkRadiobuttons;
end;

procedure TRoomTTdlg.UpBtnClick(Sender: TObject);
begin
 MoveUpList(tmpSel,ListBox2);
end;

procedure TRoomTTdlg.DnBtnClick(Sender: TObject);
begin
 MoveDownList(tmpSel,ListBox2);
end;

end.
