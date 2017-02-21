unit Sbtsdlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,TCEglobals, GlobalToTcAndTcextra;

type
  TSubjectsByTimeSlotDlg = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    finish: TBitBtn;
    ok: TBitBtn;
    BitBtn3: TBitBtn;
    Edit3: TEdit;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Label6: TLabel;
    ComboBox2: TComboBox;
    Label7: TLabel;
    RadioGroup1: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure finishClick(Sender: TObject);
    procedure okClick(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Enter(Sender: TObject);
    procedure ComboBox2Exit(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  end;

var
  SubjectsByTimeSlotDlg: TSubjectsByTimeSlotDlg;

implementation
uses tcommon, Subbyslt;
{$R *.DFM}
var
 duringload:    bool;
 MyDay: integer;

procedure TSubjectsByTimeSlotDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure TSubjectsByTimeSlotDlg.FormCreate(Sender: TObject);
var
 i: integer;
begin
 duringload:=true;
 self.caption:='Students in Time Slot Selection - '+groupname;
 radiogroup1.itemindex:=sublistfree;
 combobox1.clear;
 for i:=0 to (days-1) do combobox1.items.add(day[i]);
 MyDay:=sublistday;
 if sublistday>-1 then combobox1.text:=day[sublistday]
  else combobox1.text:='';

 combobox2.clear;
 for i:=0 to (years-1) do combobox2.items.add(yearname[i]);
 if sublistYear>-1 then combobox2.text:=yearname[sublistYear]
  else combobox2.text:='';

 edit2.text:=inttostr(sublisttime1+1);
 edit3.text:=inttostr(sublisttime2+1);

 duringload:=false;
end;

procedure TSubjectsByTimeSlotDlg.finishClick(Sender: TObject);
begin
 close;
end;

procedure TSubjectsByTimeSlotDlg.okClick(Sender: TObject);
var
 ty,td,tt1,tt2:       smallint;
 msg:              string;
begin
 {range check input}
{ td:=strtointdef(edit1.text,0);}
 ty:=findyear(combobox2.text);
 if ((ty<0) or (ty>(years-1))) then
 begin
  msg:='Not a valid year.'+endline;
  msg:=msg+'Range is ('+yearname[0]+' to '+yearname[years-1]+').';
  messagedlg(msg,mtError,[mbOK],0);
 { edit1.selectall; edit1.setfocus; }
  combobox2.selectall;
  combobox2.setfocus;
  exit;
 end;
 td:=findday(combobox1.text);
 if (trim(edit2.text)='*') then
 begin
  tt1:=1;
  tt2:=periods;
 end
 else
  begin
   tt1:=strtointdef(edit2.text,0);
   tt2:=strtointdef(edit3.text,0);
  end;
 if ((td<0) or (td>(days-1))) then
 begin
  msg:='Not a valid day.'+endline;
  msg:=msg+'Range is ('+day[0]+' to '+day[days-1]+').';
  messagedlg(msg,mtError,[mbOK],0);
 { edit1.selectall; edit1.setfocus; }
  combobox1.selectall;
   combobox1.setfocus;
  exit;
 end;
 if ((tt1<1) or (tt1>periods)) then
 begin
  msg:='Not a valid time.'+endline;
  msg:=msg+'Range is (1-'+inttostr(periods)+')';
  messagedlg(msg,mtError,[mbOK],0);
  edit2.selectall; edit2.setfocus;
  exit;
 end;
 if tt2=0 then tt2:=tt1;
 if ((tt2<1) or (tt2>periods)) then
 begin
  msg:='Not a valid time.'+endline;
  msg:=msg+'Range is (1-'+inttostr(periods)+')';
  messagedlg(msg,mtError,[mbOK],0);
  edit3.selectall; edit3.setfocus;
  exit;
 end;
 if tt2<tt1 then swapint(tt1,tt2);

 {still here then assign}
 sublistfree:=radiogroup1.itemindex;
 sublistYear:=ty;
 sublistday:=td;
 sublisttime1:=tt1-1;
 sublisttime2:=tt2-1; 
 SubByTimeSlotWin.UpdateWin;
 close;
end;

procedure TSubjectsByTimeSlotDlg.Edit2Exit(Sender: TObject);
begin
 label5.visible:=false;
end;

procedure TSubjectsByTimeSlotDlg.Edit3Exit(Sender: TObject);
begin
 label5.visible:=false;
end;

procedure TSubjectsByTimeSlotDlg.Edit3Enter(Sender: TObject);
var
 ot: string;
 {i:  integer;}
begin
 ot:=edit3.text;    {just to trigger change and update label}
 edit3.text:=edit3.text+'  ';
 edit3.text:=ot;
 SubjectsByTimeSlotDlg.label5.visible:=true;
 edit3.selectall;
end;

procedure TSubjectsByTimeSlotDlg.Edit2Enter(Sender: TObject);
var
 ot: string;
 {i:  integer; }
begin
 ot:=edit2.text;    {just to trigger change and update label}
 edit2.text:=edit2.text+'  ';
 edit2.text:=ot;
 SubjectsByTimeSlotDlg.label5.visible:=true;
 edit2.selectall;

end;

procedure TSubjectsByTimeSlotDlg.Edit1Enter(Sender: TObject);
{var  }
 {ot: string;
 i:  integer; }
begin
(* ot:=edit1.text;    {just to trigger change and update label}
 edit1.text:=edit1.text+'  ';
 edit1.text:=ot;
 SubjectsByTimeSlotDlg.label5.visible:=true;
 edit1.selectall;      *)
end;

procedure TSubjectsByTimeSlotDlg.Edit1Change(Sender: TObject);
begin
{ i:=strtointdef(edit1.text,0);
 if ((i>0) and (i<=days)) then label5.caption:=dayname[i-1]
  else label5.caption:='Enter a day number (1-'+inttostr(days)+')';
  }
{ if duringload then exit;
 i:=findday(combobox1.text);
 label5.caption:='';

 if i>-1 then label5.caption:=day[i]
  else label5.caption:='Enter Day';}
end;

procedure TSubjectsByTimeSlotDlg.Edit2Change(Sender: TObject);
var
 i:       integer;
begin
 i:=strtointdef(edit2.text,0);
 if MyDay>-1 then
  begin
   if ((i>0) and (i<=periods)) then label5.caption:=TimeSlotName[MyDay,i-1]
    else label5.caption:='Enter a Time Slot number (1-'+inttostr(tlimit[MyDay])+')';
  end;
end;

procedure TSubjectsByTimeSlotDlg.Edit3Change(Sender: TObject);
var
 i:       integer;
begin
 i:=strtointdef(edit3.text,0);
 if MyDay>-1 then
  begin
   if ((i>0) and (i<=periods)) then label5.caption:=TimeSlotName[MyDay,i-1]
    else label5.caption:='Enter a Time Slot number (1-'+inttostr(tlimit[MyDay])+')';
  end;
end;

procedure TSubjectsByTimeSlotDlg.ComboBox1Exit(Sender: TObject);
begin
 label5.visible:=false;
end;

procedure TSubjectsByTimeSlotDlg.ComboBox1Enter(Sender: TObject);
begin
 SubjectsByTimeSlotDlg.Edit1Change(Sender);

 label5.visible:=true;
 combobox1.selectall;
end;

procedure TSubjectsByTimeSlotDlg.ComboBox1Change(Sender: TObject);
var
 i: integer;
begin
 if duringload then exit;
 i:=findday(combobox1.text);
 label5.caption:='';

 if i>-1 then label5.caption:=day[i]
  else label5.caption:='Enter Day';
end;

procedure TSubjectsByTimeSlotDlg.ComboBox2Enter(Sender: TObject);
begin
 SubjectsByTimeSlotDlg.Edit1Change(Sender);

 label5.visible:=true;
 combobox2.selectall;
end;

procedure TSubjectsByTimeSlotDlg.ComboBox2Exit(Sender: TObject);
begin
 label5.visible:=false;
end;

procedure TSubjectsByTimeSlotDlg.ComboBox2Change(Sender: TObject);
var
 i: integer;
begin
 if duringload then exit;
 i:=findyear(combobox2.text);
 label5.caption:='';

 if i>-1 then label5.caption:=yearname[i]
  else label5.caption:='Enter year';
end;

end.
