unit Exdatent;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,TCEglobals, GlobalToTcAndTcextra;

type
  TExDataEntryDlg = class(TForm)
    Label14: TLabel;
    Label15: TLabel;
    update: TBitBtn;
    finish: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit13: TEdit;
    lblMonth: TLabel;
    Edit19: TEdit;
    Label24: TLabel;
    Edit20: TEdit;
    previous: TBitBtn;
    next: TBitBtn;
    ReplaceEdit: TLabeledEdit;
    lblExtrasByOthers: TLabel;
    GroupBox2: TGroupBox;
    ComboBox1: TComboBox;
    Label8: TLabel;
    ComboBox3: TComboBox;
    Label9: TLabel;
    ComboBox5: TComboBox;
    Label10: TLabel;
    ComboBox7: TComboBox;
    Label11: TLabel;
    ComboBox9: TComboBox;
    Label12: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    ComboBox2: TComboBox;
    ComboBox4: TComboBox;
    ComboBox6: TComboBox;
    ComboBox8: TComboBox;
    ComboBox10: TComboBox;
    btnRefreshPreferred: TBitBtn;
    cmbCode: TComboBox;
    procedure Edit1Change(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure previousClick(Sender: TObject);
    procedure nextClick(Sender: TObject);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit13KeyPress(Sender: TObject; var Key: Char);
    procedure Edit19KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Change(Sender: TObject);
    procedure ReplaceEditKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure ComboBox9Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RefreshPreferredTimes(Sender: TObject);
    procedure cmbCodeChange(Sender: TObject);
  private
    Procedure ButtonStatus;
    procedure TeShow;
    procedure Restore;
    procedure ShowTeacher(dataNum: integer);
    function GetExtrasCountByOthers(const pTeacherNo: Integer): Integer;
  end;

var
  ExDataEntryDlg: TExDataEntryDlg;


implementation

uses
  tcommon, DlgCommon, tcommon2, TeWnd, tcommon3, uAMGCommon;

{$R *.DFM}

var
 myte,TePos: smallint;

procedure TExDataEntryDlg.TeShow;
begin
 //edit1.text:=TrimRight(tecode[myte,0]);
 //cmbCode.Text := TrimRight(tecode[myte,0]);
 cmbCode.ItemIndex := cmbCode.Items.IndexOf(TrimRight(tecode[myte,0]));
 cmbCodeChange(cmbCode);
 ButtonStatus;
end;

procedure TExDataEntryDlg.RefreshPreferredTimes(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to nmbrTeachers do
  begin
    for j := 1 to nmbrLikePreferences do
    begin
      likEday[i,j] := -1;
      liketime[i,j] := -1;
    end;
  end;
  TeacherMap;
  UpdateTallies;
end;

Procedure TExDataEntryDlg.ButtonStatus;
begin
 previous.enabled:=(TePos>1);
 next.enabled:=(TePos<codenum[1]);
end;

procedure TExDataEntryDlg.Restore;
begin
 label17.caption:='';
 edit2.text:=''; edit3.text:=''; edit4.text:=''; edit5.text:=''; edit6.text:='';
 edit7.text:=''; edit13.text:='';  edit19.text:=''; edit20.text:='';
 ReplaceEdit.Text:='';
 combobox1.itemindex:=0; combobox2.itemindex:=0; combobox3.itemindex:=0;
 combobox4.itemindex:=0; combobox5.itemindex:=0; combobox6.itemindex:=0;
 combobox7.itemindex:=0; combobox8.itemindex:=0; combobox9.itemindex:=0;
 combobox10.itemindex:=0;
 cmbCode.setfocus;
end;

procedure TExDataEntryDlg.ShowTeacher(dataNum: integer);
var
  s: string;
begin
  label17.caption:=tename[dataNum,0];
  str(Emax[dataNum]:4:2,s); edit3.text:=s;
  str(Etaken[dataNum]:4:2,s); edit2.text:=s;
  str(Elieu[dataNum]:4:2,s); edit7.text:=s;
  str(Elieutaken[dataNum]:4:2,s); edit4.text:=s;
  str(Eweek[dataNum]:4:2,s); edit5.text:=s;
  str(Ereplace[dataNum]:4:2,s);replaceEdit.Text:=s;
  s:=InttoBINstr(Eten[dataNum]); edit6.text:=copy(s,Length(s)-9,10); {last ten chars}
  edit13.text:=inttostr(Eday[dataNum]);
  edit19.text:=inttostr(Emonth[dataNum]);
  if likEday[dataNum,1]>=-1 then combobox1.itemindex:=likEday[dataNum,1]+1
  else combobox1.itemindex:=-1;
  if liketime[dataNum,1]>0 then combobox2.itemindex:=liketime[dataNum,1]
  else combobox2.itemindex:=0;
  if likEday[dataNum,2]>=-1 then combobox3.itemindex:=likEday[dataNum,2]+1
  else combobox3.itemindex:=-1;
  if liketime[dataNum,2]>0 then combobox4.itemindex:=liketime[dataNum,2]
  else combobox4.itemindex:=0;
  if likEday[dataNum,3]>=-1 then combobox5.itemindex:=likEday[dataNum,3]+1
  else combobox5.itemindex:=-1;
  if liketime[dataNum,3]>0 then combobox6.itemindex:=liketime[dataNum,3]
  else combobox6.itemindex:=0;
  if likEday[dataNum,4]>=-1 then combobox7.itemindex:=likEday[dataNum,4]+1
  else combobox7.itemindex:=-1;
  if liketime[dataNum,4]>0 then combobox8.itemindex:=liketime[dataNum,4]
  else combobox8.itemindex:=0;
  if likEday[dataNum,5]>=-1 then combobox9.itemindex:=likEday[dataNum,5]+1
  else combobox9.itemindex:=-1;
  if liketime[dataNum,5]>0 then combobox10.itemindex:=liketime[dataNum,5]
  else combobox10.itemindex:=0;
  edit20.text:=Ecomment[dataNum];

  lblExtrasByOthers.Caption := 'Class Cover by Others  ' + IntToStr(GetTeacherCoverTally(TeCode[DataNum, 0]));
end;

procedure TExDataEntryDlg.Edit1Change(Sender: TObject);
var
 codeStr: string;
begin
 //codeStr:=edit1.text;
 codeStr:=TrimRight(codeStr);
 myte:=checkCode(1,codeStr);
 if myte>0 then showteacher(myte) else restore;
 TePos:=GetTePoint(myte);
 ButtonStatus;
end;

procedure CheckLike(i,j:integer);
begin
 if (likEday[i,j]<0) or (liketime[i,j]=0) then
  begin likEday[i,j]:=-1; liketime[i,j]:=0; end;
end;

procedure TExDataEntryDlg.updateClick(Sender: TObject);
var
 i,ercode:   integer;
 idbl:       double;
 tmpday,tmpmonth: integer;
 s,msg:          string;
 myedit:  Tedit;
begin
 //s:=Edit1.text;
 s:=cmbCode.Text;
 i:=checkcode(1,s);
 if i=0 then
  begin
   msg:='Teacher code not found.'+endline;
   messagedlg(msg,mtError,[mbOK],0);
   //edit1.setfocus;
   cmbCode.SetFocus;
   exit;
  end;
 msg:='';  myedit:=Edit13;
 tmpday:=strtointdef(Edit13.text,0);
 tmpmonth:=strtointdef(Edit19.text,0);
 if (tmpday<0) or (tmpday>31) then msg:='Check day!';
 if (tmpmonth<0) or (tmpmonth>12) then
  begin msg:='Check month!'; myedit:=Edit19; end;
 if ((tmpday>30) and ((tmpmonth=9) or (tmpmonth=4) or (tmpmonth=6) or (tmpmonth=11))) or
    ((tmpmonth=2) and (tmpday>29)) then
  begin msg:='Check day and month!'; myedit:=Edit13; end;
 if msg>'' then
  begin
   messagedlg(msg,mtError,[mbOK],0);
   myedit.setfocus; myedit.SelectAll;
   exit;
  end;

 Val(Edit3.Text, Idbl, ercode); Emax[i]:=Idbl;
 Val(Edit2.Text, Idbl, ercode); Etaken[i]:=Idbl;
 Val(Edit7.Text, Idbl, ercode); Elieu[i]:=Idbl;
 Val(Edit4.Text, Idbl, ercode); Elieutaken[i]:=Idbl;
 Val(Edit5.Text, Idbl, ercode); Eweek[i]:=Idbl;
 Val(ReplaceEdit.Text, Idbl, ercode); Ereplace[i]:=Idbl;
 Eten[i]:=BINstrtoINT(Edit6.text);
 Eday[i]:=tmpday;
 Emonth[i]:=tmpmonth;

 likEday[i,1]:=combobox1.itemindex-1;
 liketime[i,1]:=combobox2.itemindex;  CheckLike(i,1);

 likEday[i,2]:=combobox3.itemindex-1;
 liketime[i,2]:=combobox4.itemindex; CheckLike(i,2);

 likEday[i,3]:=combobox5.itemindex-1;
 liketime[i,3]:=combobox6.itemindex; CheckLike(i,3);

 likEday[i,4]:=combobox7.itemindex-1;
 liketime[i,4]:=combobox8.itemindex; CheckLike(i,4);

 likEday[i,5]:=combobox9.itemindex-1;
 liketime[i,5]:=combobox10.itemindex; CheckLike(i,5);

 Ecomment[i]:=edit20.text;
 teacherMap;
 UpdateWindow(wnCurrentExtras);
 TeWindow.UpdateWin;
 updateTallies;
 if next.enabled then nextclick(self);
end;

procedure AddDays(Mycombo:Tcombobox);
var
 i: integer;
begin
 Mycombo.Clear;
 Mycombo.items.add('none');
 Mycombo.DropDownCount:=days+1;
 for i:=0 to days-1 do Mycombo.items.add(day[i]);
end;

procedure AddTeCodes(Mycombo:TComboBox);
var
  i:integer;
begin
  MyCombo.Clear;
  for i:=1 to codenum[1] do begin
    MyCombo.items.add(TECode[codepoint[i,1],0]);
  end;
end;

procedure AddTsNames(Mycombo:Tcombobox; MyDay: integer);
var
 i: integer;
begin
 Mycombo.Clear;
 Mycombo.items.add('none');
 if tsNumDayGroups=1 then MyDay:=0;
 if (MyDay>=0) and (MyDay<days) then
  begin
   Mycombo.DropDownCount:=Tlimit[MyDay]+1;
   Mycombo.Tag:=MyDay;
   for i:=0 to Tlimit[Myday]-1 do Mycombo.items.add(TimeSlotName[MyDay,i]);
  end;
end;

procedure TExDataEntryDlg.FormCreate(Sender: TObject);
begin
 AddDays(combobox1); AddDays(combobox3); AddDays(combobox5);
 AddDays(combobox7); AddDays(combobox9);
 AddTsNames(combobox2,0); AddTsNames(combobox4,0);
 AddTsNames(combobox6,0); AddTsNames(combobox8,0);
 AddTsNames(combobox10,0);
 AddTeCodes(cmbCode);
end;

procedure TExDataEntryDlg.FormShow(Sender: TObject);
begin
  lblExtrasByOthers.Caption := '';
  //edit1.maxlength:=lencodes[1];
  edit3.maxlength:=8; edit2.maxlength:=8; ReplaceEdit.maxlength:=8;
  edit7.maxlength:=8; edit4.maxlength:=8;
  edit5.maxlength:=8; edit6.maxlength:=10;
  edit13.maxlength:=2; edit19.maxlength:=2;
  edit20.maxlength:=szEcomment;
  label15.caption:=inttostr(codenum[1]);
  myte := 0;
  TePos := TeWindow.selcode;
  if TePos>0 then
  begin
    myte := codepoint[TePos,1];
    teshow;
  end
  else
  begin
    restore;
    //edit1.text:='';
    cmbCode.Text:='';
  end;
  ButtonStatus;
  //edit1.setfocus;
  cmbCode.SetFocus;
end;

function TExDataEntryDlg.GetExtrasCountByOthers(const pTeacherNo: Integer): Integer;
{var
 tmpstr: string;
 i,j,p1,count:          integer;}
begin
(* count:=0;
{ headings}
 case pedetail of
  4: begin
      for j:=1 to abcodenum do
       begin
        printw(Abcode[j]);
       end;
     end;
 end; {case}

 for j:=1 to num do
 begin
  te:=free2[j]; if InUse[te]=0 then continue;
  for i:=0 to nmbrreasons do codecount2[i]:=0;
  found:=false; daycount:=0; old_day:=0; old_month:=0;
  for i:=1 to numabsences do
  begin
   GetPastRecord(i);
   if (agen<>1) and (agen<>4) then continue;
   if (agen=1) and ((pedetail<>1) or (anewte=0) or (TsOn[attday,atimeslot-1]=false) ) then continue;
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   if aoldte<>te then continue;

   if not(found) then
   begin
    printwl(tename[aoldte,0]); found:=true;
   end;

   if (agen=1) and (anewte>0) and (TsOn[attday,atimeslot-1]) and (pedetail=1) then
   begin
    if akind=1 then printwl(ETname[anewte]) else printwl(tename[anewte,0]);
    printwl(tsName[attDay,atimeslot-1]);
    printwl(PastKind(akind,anewte)); printwl(' ');
   end;
  if agen=4 then
   begin
    daycount1:=0; daytotal:=0;
    for p1:=1 to periods do
     begin
      if not(TsOn[attday,p1-1]) then continue;
      myallot:=getEallot(2,te,attday,p1);
      a:=atimeslot and (1 shl p1);
      if a=0 then daycount1:=daycount1+myallot;
      daytotal:=daytotal+myallot;
     end; {for p1}
    temp:=0;
    if daycount1>0 then temp:=0.5;
    if daycount1>(daytotal/2) then temp:=1.0;
    daycount:=daycount+temp;
    codecount2[areason]:=codecount2[areason]+temp;
    case pedetail of
       1,2: begin
             if (old_day<>aday) or (old_month<>amonth) then
               printwl(inttostr(aday)+' '+month[amonth]);
             for p1:=1 to periods do
              begin
               if not(TsOn[attday,p1-1]) then continue;
               a:=atimeslot and (1 shl p1);
               if a=0 then
                begin printw(tslotcode[p1,attday]); inc(x,letterW); end
                else begin printw('-'); inc(x,letterW); end;
              end; {for p1}
            end;
    end; {case}
   end; {if agen=4}
  end; {for i }
  if found then
  begin
   inc(count);
   if pedetail<4 then
   begin
    if x>0 then newline;
    str(daycount:3:1,tmpstr); printwl('Days absent: '+tmpstr); newline; newline;
    drawmyline(0,y-(txtheight div 2),MaxW,y-(txtheight div 2));
   end;
   if (pedetail=4) then
   begin
    for i:=1 to abcodenum do
    begin
     x:=Tabs[1]+((i-1)*Tabs[9]);
     if codecount2[i]>0 then fcolor(cpCurrent)
      else fcolor(codecolor);
     str(codecount2[i]:3:1,tmpstr);
     printwl(tmpstr+' ');
    end; {for i}
    str(daycount:3:1,tmpstr);
   end;
  end;
 end; //for j *)
end;

procedure TExDataEntryDlg.previousClick(Sender: TObject);
begin
  if TePos>1 then
  begin
   dec(TePos);
   myte:=codepoint[TePos,1];
   teshow;
  end;
end;

procedure TExDataEntryDlg.nextClick(Sender: TObject);
begin
 if TePos<codenum[1] then
  begin
   inc(TePos);
   myte:=codepoint[TePos,1];
   teshow;
  end;
end;

procedure TExDataEntryDlg.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
 allowBinaryInputOnly(key);
end;

procedure TExDataEntryDlg.Edit13KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TExDataEntryDlg.Edit19KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TExDataEntryDlg.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  allowdecimalInputOnly(key);
  //if ELieu[MyTe] <> StrToFloat(Trim(Edit7.Text)) then
    //EUserChanged[MyTe] := True;
end;

procedure TExDataEntryDlg.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
 allowdecimalInputOnly(key);
end;

procedure TExDataEntryDlg.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
 allowdecimalInputOnly(key);
end;

procedure TExDataEntryDlg.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
 allowdecimalInputOnly(key);
end;

procedure TExDataEntryDlg.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
 allowdecimalInputOnly(key);
end;

procedure NewTsNames(MyCombo1,MyCombo2: Tcombobox);
var
 MyDay,PrevDay: integer;
begin
 MyDay:=(MyCombo1.ItemIndex)-1;
 PrevDay:=MyCombo2.Tag;
 if (MyDay>=0)
  then if (tsDayGroup[MyDay]<>tsDayGroup[PrevDay])
   then AddTsNames(MyCombo2,MyDay);
end;

procedure TExDataEntryDlg.cmbCodeChange(Sender: TObject);
var
  codeStr: string;
begin
 codeStr:=cmbCode.text;
 codeStr:=TrimRight(codeStr);
 myte:=checkCode(1,codeStr);
 if myte>0 then showteacher(myte) else restore;
 TePos:=GetTePoint(myte);
 ButtonStatus;
end;

procedure TExDataEntryDlg.ComboBox1Change(Sender: TObject);
begin
 NewTsNames(combobox1,combobox2);
end;

procedure TExDataEntryDlg.ReplaceEditKeyPress(Sender: TObject;
  var Key: Char);
begin
 allowdecimalInputOnly(key);
end;

procedure TExDataEntryDlg.ComboBox3Change(Sender: TObject);
begin
 NewTsNames(combobox3,combobox4);
end;

procedure TExDataEntryDlg.ComboBox5Change(Sender: TObject);
begin
 NewTsNames(combobox5,combobox6);
end;

procedure TExDataEntryDlg.ComboBox7Change(Sender: TObject);
begin
 NewTsNames(combobox7,combobox8);
end;

procedure TExDataEntryDlg.ComboBox9Change(Sender: TObject);
begin
 NewTsNames(combobox9,combobox10);
end;

end.
