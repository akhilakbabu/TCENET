unit Prefer;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  Buttons, ExtCtrls, Dialogs, TabNotBk,sysutils, Mask, ComCtrls,TCEglobals, GlobalToTcAndTcextra;

type
  TFrmOptions = class(TForm)
    ButtonPanel: TPanel;
    TabSet: TTabSet;
    Notebook: TNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    grbTimetable: TGroupBox;
    grbStudent: TGroupBox;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    GroupBox6: TGroupBox;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    CheckBox8: TCheckBox;
    grbPrintTimetable: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    MaskEdit1: TMaskEdit;
    Label5: TLabel;
    GroupBox4: TGroupBox;
    GroupBox10: TGroupBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    Edit1: TEdit;
    Label8: TLabel;
    CheckBox11: TCheckBox;
    CheckBox7: TCheckBox;
    grbGeneral: TGroupBox;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    CheckBox35: TCheckBox;
    CheckBox36: TCheckBox;
    GroupBox15: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    RadioGeneric: TRadioGroup;
    EnableAuto: TCheckBox;
    CheckBox26: TCheckBox;
    ListStyle1: TRadioGroup;
    Label6: TLabel;
    ComboBox2: TComboBox;
    DayLabel1: TLabel;
    Label4: TLabel;
    YearClass1: TRadioGroup;
    CheckBox12: TCheckBox;
    Label9: TLabel;
    Label7: TLabel;
    chkBarcode: TCheckBox;
    CheckBox27: TCheckBox;
    chbSelectAll: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure myEditsKeyPress(Sender: TObject; var Key: Char);
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2Change(Sender: TObject);
    procedure chbSelectAllClick(Sender: TObject);
  private
    procedure ShowTsNames;
    procedure periodCheckBoxClick(Sender: TObject);
  end;

var
  FrmOptions: TFrmOptions;
  periodCheckBox:  array[1..nmbrPeriods] of TCheckBox;
  dayCheckBox:     array[1..nmbrDays] of TCheckBox;
  yearCheckBox:    array[1..nmbrYears] of TCheckBox;
  usingResources:  boolean;

implementation

uses
  tcinfo, tcommon, main, DlgCommon, studlist, tcommon3;

{$R *.DFM}

var
 actcheckboxsz:         integer;
 MyDayGroup:   smallint;
 tmpTsOn: array  [0..nmbrDays,0..nmbrPeriods] of boolean;  {base on daygroup}


procedure TFrmOptions.ShowTsNames;
var
 str: string;
 i,dayuse: integer;
begin
 str:=''; dayuse:=tsDg[MyDayGroup,1];
 if (tsNumDayGroups>1) and (tsNumDayGroups<days) then
  begin
   for i:=1 to tsDg[MyDayGroup,0] do str:=str+dayname[tsDg[MyDayGroup,i]]+' ';
  end;
 DayLabel1.Caption:=str;
 for i:=1 to periods do
  begin
   periodCheckBox[i].Hint:='Check to show '+TimeSlotName[dayuse,i-1];
   if i<=Tlimit[dayuse] then
    begin
     periodCheckBox[i].caption:=TimeSlotName[dayuse,i-1];
     periodCheckBox[i].Visible:=true;
     periodCheckBox[i].checked:=tmpTsOn[MyDayGroup,i-1];
    end
   else
    begin
     periodCheckBox[i].caption:='';
     periodCheckBox[i].Visible:=false;
    end;
  end;
end;

procedure TFrmOptions.periodCheckBoxClick(Sender: TObject);
var
 i: integer;
begin
 i:=activecontrol.tag;
 if ((i<1) or (i>periods)) then exit;  {during load causes problems otherwise}
 tmpTsOn[MyDayGroup,i-1]:=periodCheckBox[i].Checked;
end;

procedure TFrmOptions.myEditsKeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TFrmOptions.FormCreate(Sender: TObject);
var
 i,j,d:       integer;
 v1,v2:   integer;
 maxtab,curtab,mintab:   integer;
 mxdayname,mxyearname,mxperiodname:    integer;

const
 xgap=20;
 ygap=5;
begin
 tsDayGroupCalc;
 for j:=1 to numDayGroups do
  if TsDg[j,0]>0 then
   begin
    d:=TsDg[j,1];
    for i:=0 to periods do tmpTsOn[j,i]:=tsOn[d,i];
   end
  else for i:=0 to periods do tmpTsOn[j,i]:=true;

 checkbox11.hint:='If checked then colour data will be sent to the printer during printing.'+
    endline+'Otherwise colour data will be converted for black and white printers' ;

 maxTab:=0; mintab:=canvas.textwidth('Minstr ');
 for i:=1 to years do
 begin
  curTab:=canvas.textwidth(Yearname[i-1]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 mxyearname:=maxTab;
 if mxyearname<mintab then mxyearname:=mintab;

 maxTab:=0;
 for d:=0 to days-1 do
  for i:=0 to Tlimit[d]-1 do
  begin
    curTab:=canvas.textwidth(TimeSlotName[d,i]+'  ');
    if (curTab>maxTab) then maxTab:=curTab;
  end;
 mxperiodname:=maxTab;
 if mxperiodname<mintab then mxperiodname:=mintab;

 maxTab:=0;
 for i:=1 to days do
 begin
  curTab:=self.canvas.textwidth(Dayname[i-1]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 mxdayname:=maxTab;
 if mxdayname<mintab then mxdayname:=mintab;

 actcheckboxsz:=self.canvas.textwidth('WW'); {width includes size of actual box}

 combobox2.clear; MyDayGroup:=1;
 if tsNumDayGroups=1 then
  begin
   label6.Visible:=false; combobox2.Visible:=false; Daylabel1.Visible:=false;
  end
 else
  begin {set day groups}
   if (tsNumDayGroups>1) and (tsNumDayGroups<days) then
    for i:=1 to tsNumDayGroups do combobox2.Items.add('Day Group '+inttostr(i));
   if (tsNumDayGroups=days) then
    begin
     for i:=1 to tsNumDayGroups do combobox2.Items.add(dayname[i-1]);
     Daylabel1.Visible:=false;
    end;
   combobox2.itemindex:=MyDayGroup-1;
  end;

 for i:=1 to periods do
  begin
   periodCheckBox[i]:=tCheckBox.create(application);
   periodCheckBox[i].parent:=label4.parent;
   periodCheckBox[i].OnClick:=periodCheckBoxClick;
   periodCheckBox[i].Tag:=i;
   v1:=(i-1) div 5;  v2:=(i) mod 5;
   if v2=0 then v2:=4 else v2:=v2-1;
   periodCheckbox[i].width:=mxperiodname+actcheckboxsz;
   periodCheckBox[i].left:=label4.left+v1*(mxperiodname+xgap);
   periodCheckBox[i].top:=label4.top+label4.height+ygap+v2*(periodCheckBox[1].height+ygap);
  end;

 for i:=1 to days do
  begin
   dayCheckBox[i]:=tCheckBox.create(application);
   dayCheckBox[i].parent:=label2.parent;
   dayCheckBox[i].hint:='Check to print '+dayname[i-1];
   dayCheckBox[i].caption:=dayname[i-1];
   dayCheckBox[i].enabled:=true;
    v2:=(i-1) div 3;  v1:=(i) mod 3;
   if v1=0 then v1:=2 else v1:=v1-1;
   dayCheckBox[i].width:=mxdayname+actcheckboxsz;
   dayCheckBox[i].left:=label2.left+v1*(mxdayname+xgap);
   dayCheckBox[i].top:=label2.top+label2.height+ygap+v2*(dayCheckBox[1].height+ygap);
  end;

 for i:=1 to years do
  begin
   yearCheckBox[i]:=tCheckBox.create(application);
   yearCheckBox[i].parent:=label3.parent;
   yearCheckBox[i].hint:='Check to print '+yeartitle+' '+yearname[i-1];
   yearCheckBox[i].caption:=yearname[i-1];
   yearCheckBox[i].enabled:=true;
   v2:=(i-1) div 3;  v1:=(i) mod 3;
   if v1=0 then v1:=2 else v1:=v1-1;
   yearCheckBox[i].width:=mxyearname+actcheckboxsz;
   yearCheckBox[i].left:=label3.left+v1*(mxyearname+xgap);
   yearCheckBox[i].top:=label3.top+label3.height+ygap+v2*(yearCheckBox[1].height+ygap);
  end;

 CheckBox33.Checked:=GlobalHints;
 CheckBox34.Checked:=OKbackup;
 CheckBox35.Checked:=OKquitcheck;
 EnableAuto.Checked:=EnableAutoFlag;
 CheckBox36.Checked:=CustomFileLoadFlag;
 if GenericTtableFlag then RadioGeneric.ItemIndex:=1 else RadioGeneric.ItemIndex:=0;
 Edit9.Text:=inttostr(txtsep);
 Edit10.Text:=inttostr(txtlim);
 Edit8.Text:=inttostr(FAsubnum);
 checkbox11.checked:=colorPrinterFlag;

 usingResources:=true;
  { make the number of Tabs = number of Pages,
    and have the same names }
 TabSet.Tabs := Notebook.Pages;

 // hide or unhide backup option
 CheckBox34.Visible:= usrPassBKUP = True;
end;

procedure TFrmOptions.TabSetClick(Sender: TObject);
begin
  { set visible Page to which Tab was clicked }
  Notebook.PageIndex := TabSet.TabIndex;
end;

procedure TFrmOptions.FormActivate(Sender: TObject);
var
 i:     integer;
begin
 {general}
 self.NoteBook.pageindex:=prefNotebookPageIndex;
 self.tabset.tabindex:=prefNotebookPageIndex;

 {student section}
 checkbox1.checked:=stSex;
 checkbox2.checked:=stClass;
 checkbox3.checked:=stHouse;
 checkbox4.checked:=stID;
 chkBarcode.checked:=stBarcode;
 checkbox5.checked:=stTutor;
 checkbox6.checked:=stHome;
 checkbox26.checked:=sTyear;
 checkbox8.checked:=double_space;
 checkbox12.checked:=formfeed;
 CheckBox7.Checked:=MatchAllYears;
 liststyle1.ItemIndex:=sTselect;
 case sexselect of
  0: radiobutton5.checked:=true;
  1: radiobutton6.checked:=true;
  2: radiobutton7.checked:=true;
 end; {case}
 {timetable section}
 ShowTsNames;
 for i:=1 to years do yearCheckBox[i].checked:=Pyear[i-1];
 for i:=1 to days do dayCheckBox[i].checked:=Dprint[i];
 checkbox9.checked:=Tfreeshow;
 checkbox10.checked:=Rfreeshow;
 maskedit1.text:=inttostr(Pweek);
 YearClass1.ItemIndex:=Tyr;

 checkbox13.checked:=epreason;
 checkbox14.checked:=eplist;
 checkbox15.checked:=epteach;
 checkbox16.checked:=eproom;
 checkbox17.checked:=esteach;
 checkbox18.checked:=esreason;
 checkbox19.checked:=estlost;
 checkbox20.checked:=esnew;
 checkbox21.checked:=esroom;
 checkbox22.checked:=esrlost;
 checkbox23.checked:=esmerge;
 checkbox24.checked:=esadd;
 checkbox25.checked:=esprint;

 checkbox27.checked := eptimes;

 edit1.text:=inttostr(abs(epBlank));
end;

procedure TFrmOptions.CancelBtnClick(Sender: TObject);
begin
 close;
end;

procedure TFrmOptions.OKBtnClick(Sender: TObject);
var
  i,j,k,m,d:       integer;
  msg,t:       string;
  oldStudSelcode:   integer;
  oldAutoCover: boolean;
begin
 {validate data first}
   oldStudSelcode:=0;
    j:=strtointdef(trim(maskedit1.text),1);
  if ((j<1) or (j>9)) then
  begin
    notebook.pageindex:=1; {return to relevant page}
    maskedit1.setfocus;

    msg:='Weekly Timetables per page has an invalid entry.'+endline;
    msg:=msg+'Please enter a number between 1 and 9.';
    messagedlg(msg,mtError,[mbOK],0);
    exit;
  end;

 screen.cursor:=crHourglass;
 try
  {proceed}
  Self.Hide;
  {color section}
  colorPrinterFlag:=checkbox11.checked;

  {student section}
  stSex:=checkbox1.checked;
  stClass:=checkbox2.checked;
  stHouse:=checkbox3.checked;
  stID:=checkbox4.checked;
  stTutor:=checkbox5.checked;
  stHome:=checkbox6.checked;
  sTyear:=checkbox26.checked;
  stBarcode:=chkBarcode.checked;

  MatchAllYears:=CheckBox7.Checked;
  double_space:=checkbox8.checked;
  double_print:=1; if double_space then double_print:=2;
  formfeed:=checkbox12.checked;
  GlobalHints:=CheckBox33.Checked;
  application.ShowHint:=GlobalHints;
  GenericTtableFlag:=(RadioGeneric.ItemIndex=1);
  FAsubnum:=strtointdef(trim(Edit8.text),0);
  IntRange(FAsubnum,0,nmbrChoices);
  OKbackup:=Checkbox34.Checked;
  OKquitcheck:=CheckBox35.Checked;

  oldAutoCover:=EnableAutoFlag;
  EnableAutoFlag:=Enableauto.Checked;
  if oldAutoCover<>EnableAutoFlag then
  begin
    mainform.MyAutoCover.Enabled:=EnableAutoFlag;
    mainform.MyAutoCover.Update;
  end;
  CustomFileLoadFlag:=CheckBox36.Checked;
  t:=trim(edit9.text);
  txtsep:=strtointdef(t,-99);
  if txtsep=-99 then txtsep:=ord(t[1]);
  if t='' then txtsep:=0;

  t:=trim(edit10.text);
  txtlim:=strtointdef(t,-99);
  if txtlim=-99 then txtlim:=ord(t[1]);
  if t='' then txtlim:=0;

  if wnFlag[wnStudentList] then if studentlistwin.selcode>0 then
    oldStudSelcode:=StPointer[studentlistwin.selcode]; {protect stud selection}

  if radiobutton5.checked then sexselect:=0
   else if radiobutton6.checked then sexselect:=1
    else if radiobutton7.checked then sexselect:=2;

  sTselect:=liststyle1.ItemIndex;

  case sexSelect of
   0: studentpointerset;
   1: studentpointerfemale;
   2: studentpointermale;
  end; {case}

  if wnFlag[wnStudentList] then
  begin
   if ((StudListType<>7) and (studentlistwin.selcode>0)) then   {restore stud selcode}
   begin
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
  end;  {if studentlistwinflag}

  {timetable section}
 for i:=0 to days-1 do
 begin
   d:=tsDayGroup[i];
   for j:=0 to periods do TsOn[i,j]:=tmpTsOn[d,j];
 end;
 for i:=1 to years do Pyear[i-1]:=yearCheckBox[i].checked;
 SetPshowMax;

 for i:=1 to days do Dprint[i]:=dayCheckBox[i].checked;

 Tfreeshow:=checkbox9.checked;
 Rfreeshow:=checkbox10.checked;

 Pweek:=strtointdef(trim(maskedit1.text),1);
 Tyr:=YearClass1.ItemIndex;

 {----------extras lists section----------}
 epreason:=checkbox13.checked;
 eplist:=checkbox14.checked;
 epteach:=checkbox15.checked;
 eproom:=checkbox16.checked;
 esteach:=checkbox17.checked;
 esreason:=checkbox18.checked;
 estlost:=checkbox19.checked;
 esnew:=checkbox20.checked;
 esroom:=checkbox21.checked;
 esrlost:=checkbox22.checked;
 esmerge:=checkbox23.checked;
 esadd:=checkbox24.checked;
 esprint:=checkbox25.checked;

 eptimes := checkbox27.checked;

 epBlank:=strtointdef(edit1.text,0);

 Self.ModalResult := mrOK;   {without this it freezes and with modal result
                       set at design time it closes the dialog along with any error msg}

  updateAllwins;
 finally
   screen.cursor:=crDefault;
 end; {try}

end;

procedure TFrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
 action:=caFree;
 prefNotebookPageIndex:=NoteBook.pageIndex;

 if usingResources then   {can call close even after closeed it seems}
 begin
  usingResources:=false;
  Self.Hide; {prevent seeing controls beeing removed -slows things down a lot}
  for i:=1 to periods do periodCheckBox[i].free;
  for i:=1 to days do dayCheckBox[i].free;
  for i:=1 to years do yearCheckBox[i].free;
 end;
end;

procedure TFrmOptions.MaskEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  allowNumericInputOnly(key);
end;

procedure TFrmOptions.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  allowNumericInputOnly(key);
end;

procedure TFrmOptions.chbSelectAllClick(Sender: TObject);
var
  i: integer;
begin
  i := 0;
  with GroupBox10 do
  begin
    while i < ControlCount do
    begin
      if Controls[i] is TCheckBox then
        (Controls[i] as TCheckBox).Checked := (Sender as TCheckBox).Checked;
          
      Inc(i);
    end;
  end;
end;

procedure TFrmOptions.ComboBox2Change(Sender: TObject);
var
  oldDayGroup: Integer;
begin
  oldDayGroup:=MyDayGroup;
  MyDayGroup:=ComboBox2.ItemIndex+1;
  if (oldDayGroup<>MyDayGroup) and (MyDayGroup>0) then ShowTsNames;
end;

end.
