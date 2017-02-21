unit Subttdlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, GlobalToTcAndTcextra;

type
  TSubjectTTdlg = class(TForm)
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Edit5: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    RadioButton4: TRadioButton;
    CheckBox1: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelbuttonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OKbuttonClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
  end;

var
  SubjectTTdlg: TSubjectTTdlg;

implementation
uses
 tcommon,DlgCommon,ttable,tcommon2;
var
 typeofTT:        integer;
 myttday,ttlevel,ttyear,tttime:  integer;
{$R *.DFM}


procedure updatehighlights;
begin
 with SubjectTTdlg do
 begin
  combobox1.color:=clwindow; combobox2.color:=clwindow;
  edit3.color:=clwindow; edit5.color:=clwindow;
  checkbox1.enabled:=false;
  case typeofTT of
   1: begin
       combobox1.color:=clRelevantControlOnDlg; combobox2.color:=clRelevantControlOnDlg;
       edit3.color:=clRelevantControlOnDlg; edit5.color:=clRelevantControlOnDlg;
       combobox1.enabled:=true; combobox2.enabled:=true;
       edit3.enabled:=true; edit5.enabled:=true;
      end;
   2: begin
       combobox1.color:=clRelevantControlOnDlg; combobox2.color:=clRelevantControlOnDlg;
       edit5.color:=clRelevantControlOnDlg;
       combobox1.enabled:=true; combobox2.enabled:=true;
       edit3.enabled:=false; edit5.enabled:=true;
      end;
   3: begin
       combobox1.color:=clRelevantControlOnDlg;
       edit3.color:=clRelevantControlOnDlg;
       combobox1.enabled:=true; combobox2.enabled:=false;
       edit3.enabled:=true; edit5.enabled:=false;
       checkbox1.enabled:=true;
      end;
   4: begin           {block}
       combobox1.color:=clRelevantControlOnDlg; combobox2.color:=clRelevantControlOnDlg;
       edit5.color:=clRelevantControlOnDlg;     edit3.color:=clRelevantControlOnDlg;
       combobox1.enabled:=true; combobox2.enabled:=true;
       edit3.enabled:=true;   edit5.enabled:=true;
      end;
  end; {case}
 end; {with}
end;

procedure displaysubselection;
var
 tmpStr:  string;
 aStr:    string;
 i,j,l1,l2:     integer;
 aFnt:    tpIntpoint;
begin
 with SubjectTTdlg do
 begin
  if typeofTT<>2 then
  begin
   label13.caption:='';
   if ((ttlevel<1) or (ttlevel>level[ttyear])) then
   begin
    label13.Caption:='Enter level in range 1-'+inttostr(level[ttyear]);
    edit3.Setfocus; Edit3.SelectAll;
    exit;
   end;
  end;
  if typeofTT<>3 then
  begin
   if ((TTtime<0) or
   ((myttday>=0) and (TTtime>tlimit[myttday]))) then
   begin
    label13.Caption:='Enter time slot in range 1-'+inttostr(Tlimit[myttday]);
    edit5.Setfocus; Edit5.SelectAll;
    exit;
   end;
  end;
 end;

 tmpStr:='';   subttGroupcnt:=0;
 if ttyear<>-1 then {year found}
  case typeofTT of
   1: begin
       aFnt:=FNT(myttday,TTtime,ttyear,ttlevel,0);
       j:=aFnt^;
       if ((j>0) and (j<LabelBase)) then
       begin
        tmpStr:=subCode[j];
        subttGroupcnt:=1;
        subttgroup[1]:=j;
       end
        else
         begin
          tmpStr:='No subject at selection.';
          subttgroupcnt:=0;
         end;
      end;
   2: begin
       subttgroupcnt:=0;
       for i:=0 to level[ttyear] do
       begin
        aFnt:=FNT(myttday,TTtime,ttyear,i,0);
        j:=aFnt^;
        if ((j>0) and (j<LabelBase)) then
        begin
         tmpStr:=tmpStr+subCode[j]+' ';
         inc(subttgroupcnt);
         subttgroup[subttgroupcnt]:=j;
        end;
       end; {for i}
       tmpStr:=trim(tmpStr);
       if tmpStr='' then tmpStr:='No subjects at selection.';
      end;
   3: begin
       tmpStr:=yeartitle+' '+yearname[ttyear]+' ';
       aStr:=trim(ClassCode[ClassShown[ttlevel,ttyear]]);
       if aStr>'' then tmpStr:=tmpStr+aStr
        else tmpStr:=tmpStr+'Level '+inttostr(ttlevel);
      end;
   4: begin       {block}
       subttgroupcnt:=0;   l1:=0; l2:=0;
       getBlockLevels(myttday,TTtime,ttyear,ttlevel,l1,l2);
       if l1>0 then
        for i:=l1 to l2 do
        begin
         aFnt:=FNT(myttday,TTtime,ttyear,i,0);
         j:=aFnt^;
         if ((j>0) and (j<LabelBase)) then
         begin
          tmpStr:=tmpStr+subCode[j]+' ';
          inc(subttgroupcnt);
          subttgroup[subttgroupcnt]:=j;
         end;
        end; {for i}
       tmpStr:=trim(tmpStr);
       if tmpStr='' then tmpStr:='No block number at selection.';
      end;
  end; {case}
 SubjectTTdlg.label3.caption:=tmpStr;
end;

procedure TSubjectTTdlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure TSubjectTTdlg.CancelbuttonClick(Sender: TObject);
begin
 close;
end;

procedure TSubjectTTdlg.FormActivate(Sender: TObject);
var
 i: integer;
begin
 label3.caption:='';
 label13.caption:='';

 case subttlistselection of   {used as default}
  1: radiobutton1.checked:=true;
  2: radiobutton2.checked:=true;
  3: radiobutton3.checked:=true;
  4: radiobutton4.checked:=true;
 end; {case}
 typeofTT:=subttlistselection;

 with SubjectTTdlg do
 begin

  ComboBox1.Maxlength:=szYearname;
  combobox2.clear;  combobox1.clear;
  ComboBox1.DropDownCount:=nmbrYears; ComboBox2.DropDownCount:=nmbrDays;
  for i:=0 to (days-1) do
    combobox2.items.add(day[i]);
  for i:=0 to years_minus_1 do
    combobox1.items.add(yearname[i]);
  combobox1.hint:='Select '+yeartitle;
  ttyear:=subttlistvals[1];
  ttlevel:=subttlistvals[2];
  myttday:=subttlistvals[3];
  TTtime:=subttlistvals[4];

  combobox2.itemindex:=myttday;
  combobox1.itemindex:=ttyear;
  edit5.text:=inttostr(TTtime+1);
  edit3.text:=inttostr(ttlevel);
  checkbox1.checked:=not(subttWide);
 end;

{ restore;}
end;

procedure TSubjectTTdlg.OKbuttonClick(Sender: TObject);
var
 msg:      String;
begin
{verify input if needed}
 ttyear:=findYear(ComboBox1.text);
  if ttyear<0 then ttyear:=0;
 ttlevel:=strtointdef(edit3.text,0);
 myttday:=findDay(ComboBox2.text);
  if myttday<0 then myttday:=0;
 TTtime:=(strtointdef(edit5.text,1)-1);


 if ttyear=-1 then {not found}
 begin
  msg:=yeartitle+' not Found!'+endline;
  msg:=msg+'Please enter a '+yeartitle;
  messagedlg(msg,mtError,[mbOK],0);
  ComboBox1.setfocus;
  exit;
 end;

 if ((ttlevel<0) or (ttlevel>level[ttyear])) then
 begin
  if typeofTT<>2 then
  begin
   msg:='Invalid Level number.'+endline;
   msg:=msg+'Enter a value in the range (0-'+inttostr(level[ttyear])+').';
   messagedlg(msg,mtError,[mbOK],0);
   edit3.selectall;
   edit3.setfocus;
   exit;
  end;
 end;
 if ((myttday<0) or (myttday>=days)) then
 begin
  if typeofTT<>3 then
  begin
   msg:='Invalid Day number.'+endline;
   msg:=msg+'Enter a value in the range (1-'+inttostr(days)+').';
   messagedlg(msg,mtError,[mbOK],0);
   ComboBox2.setfocus;
   exit;
  end;
 end;
 if ((TTtime<0) or (TTtime>=tlimit[myttday])) then
 begin
  if typeofTT<>3 then
  begin
   msg:='Invalid Time Slot number.'+endline;
   msg:=msg+'Enter a value in the range (1-'+inttostr(periods)+').';
   messagedlg(msg,mtError,[mbOK],0);
   edit5.selectall;
   edit5.setfocus;
   exit;
  end;
 end;
 subttlistvals[1]:=ttyear;
 subttlistvals[2]:=ttlevel;
 subttlistvals[3]:=myttday;
 subttlistvals[4]:=TTtime;
 subttlistselection:=typeofTT;
 subttWide:=not(checkbox1.checked);
 close;
 try
  screen.cursor:=crHourglass;
  UpdateWindow(wnSubjectTt);
 finally
  screen.cursor:=crDefault;
 end;
end;

procedure TSubjectTTdlg.RadioButton1Click(Sender: TObject);
begin
 typeofTT:=1;
 updatehighlights;
 displaysubselection;
end;

procedure TSubjectTTdlg.RadioButton2Click(Sender: TObject);
begin
 typeofTT:=2;
 updatehighlights;
 displaysubselection;
end;

procedure TSubjectTTdlg.RadioButton3Click(Sender: TObject);
begin
 typeofTT:=3;
 updatehighlights;
 displaysubselection;
end;

procedure TSubjectTTdlg.ComboBox1Change(Sender: TObject);
begin
  ttyear:=findYear(ComboBox1.text);
  if ttyear<0 then ttyear:=0;
 displaysubselection;
end;

procedure TSubjectTTdlg.ComboBox2Change(Sender: TObject);
begin
  myttday:=findDay(ComboBox2.text);
  if myttday<0 then myttday:=0;
 displaysubselection;
end;

procedure TSubjectTTdlg.Edit5Change(Sender: TObject);
begin
 TTtime:=(strtointdef(edit5.text,1)-1);
 displaysubselection;
end;

procedure TSubjectTTdlg.Edit3Change(Sender: TObject);
begin
 ttlevel:=strtointdef(edit3.text,0);
 displaysubselection;
end;

procedure TSubjectTTdlg.RadioButton4Click(Sender: TObject);
begin
 typeofTT:=4;
 updatehighlights;
 displaysubselection;
end;

procedure TSubjectTTdlg.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TSubjectTTdlg.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

end.



