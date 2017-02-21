unit Newday;

interface

uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Forms,
     Controls, Dialogs, Buttons, StdCtrls,TCEglobals, GlobalToTcAndTcextra;

type
  TNewDayDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox4: TComboBox;
    procedure ComboBox4Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  end;

var
  NewDayDlg: TNewDayDlg;

implementation

uses tcommon,DlgCommon,tcommon2;

{$R *.DFM}
var
 tmpday,tmpmonth,tmpyear: word;
 tmpttday:  integer;

procedure TNewDayDlg.ComboBox4Change(Sender: TObject);
begin
 tmpttday:=findday(combobox4.text);
end;

procedure TNewDayDlg.FormCreate(Sender: TObject);
var
 i:   integer;
begin
 combobox4.clear;
 ComboBox4.DropDownCount:=days;
 for i:=1 to days do
   combobox4.items.add(day[i-1]);
end;

procedure TNewDayDlg.FormActivate(Sender: TObject);
begin
 decodeDate(Now,tmpyear,tmpmonth,tmpday);
 edit3.text:=inttostr(tmpyear);
 if tag<3 then
  begin
   edit1.text:=inttostr(tmpday); edit2.text:=inttostr(tmpmonth);
   caption:='Start New Day';
  end
 else
  begin
   edit1.text:=''; edit2.text:=''; tmpday:=0; tmpmonth:=0;
   caption:='New Work Ahead Day';
  end;
 if tag=2 then
  begin
   tmpttday:=ttday+1; if tmpttday>=days then tmpttday:=0;
   combobox4.itemindex:=tmpttday;
  end
 else
  begin
   tmpttday:=-1; combobox4.text:='';
  end;
 if tag=1 then
  begin
   CancelBtn.Enabled:=False;{ BorderIcons:=BorderIcons-[biSystemMenu];}
  end;
end;

procedure TNewDayDlg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TNewDayDlg.Edit1Change(Sender: TObject);
begin
 tmpday:=strtointdef(edit1.text,0);
end;

procedure TNewDayDlg.Edit3Change(Sender: TObject);
begin
 tmpyear:=strtointdef(edit3.text,0);
end;

procedure TNewDayDlg.Edit2Change(Sender: TObject);
begin
 tmpmonth:=strtointdef(edit2.text,0);
end;

procedure TNewDayDlg.OKBtnClick(Sender: TObject);
var
 msg:     string;
 myedit:  Tedit;
begin
 msg:='';  myedit:=Edit1;
 if (tmpday<1) or (tmpday>31) then msg:='Check day!';
 if (tmpmonth<1) or (tmpmonth>12) then
  begin msg:='Check month!'; myedit:=Edit2; end;
 if ((tmpday>30) and ((tmpmonth=9) or (tmpmonth=4) or (tmpmonth=6) or (tmpmonth=11))) or
    ((tmpmonth=2) and (tmpday>29)) then
  begin msg:='Check day and month!'; myedit:=Edit1; end;
 if msg>'' then
  begin
   messagedlg(msg,mtError,[mbOK],0);
   myedit.setfocus; myedit.SelectAll;
   exit;
  end;
 if (tmpttday<0) or (tmpttday>=days) then
  begin
   msg:='Check timetable day!';
   messagedlg(msg,mtError,[mbOK],0);
   Combobox4.setfocus; Combobox4.SelectAll;
   exit;
  end;
 exday:=tmpday; exmonth:=tmpmonth; exyear:=tmpyear; ttday:=tmpttday;
 modalResult:=mrOK;
end;

end.


