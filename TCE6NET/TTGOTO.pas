unit Ttgoto;

interface

uses SysUtils, WinTypes, WinProcs, Classes, Graphics, Forms, Controls,
  Buttons, StdCtrls, ExtCtrls, Dialogs, Grids,TCEglobals, GlobalToTcAndTcextra;

type
  TGotoDlg = class(TForm)
    GotoBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Edit4: TEdit;
    HomeBox: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure GotoBtnClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GotoDlg: TGotoDlg;

implementation

{$R *.DFM}
uses tcommon,DlgCommon,ttable;

var
 fd, fp, fy, fl:       integer;


procedure TGotoDlg.FormCreate(Sender: TObject);
var
 i:  integer;
begin
 topcentre(self);
 HomeBox.checked:=false;
 ComboBox1.Maxlength:=szYearname;
 Combobox1.Hint:='Select '+Yeartitle+' of timetable';
 ComboBox1.DropDownCount:=nmbrYears; ComboBox2.DropDownCount:=nmbrDays;
 combobox2.clear;
 for i:=0 to (days-1) do
   combobox2.items.add(day[i]);
 combobox1.clear;
 for i:=0 to years_minus_1 do
   combobox1.items.add(yearname[i]);
end;

procedure TGotoDlg.FormActivate(Sender: TObject);
begin
 label1.caption:='&'+Yeartitle;
 Combobox1.text:=yearname[ny];
 Edit2.text:=inttostr(nl);
 combobox2.text:=Day[nd];
 Edit4.text:=inttostr(np+1);
 fd:=nd; fp:=np; fy:=ny; fl:=nl;
 combobox2.Setfocus;
 combobox2.SelectAll;
end;

procedure TGotoDlg.Edit4Change(Sender: TObject);
var
 s:  string;
 p:  integer;
begin
 s:=trim(edit4.text);
 fp:=strtointdef(s,0)-1;
 if fd>=0 then p:=Tlimit[fd] else p:=Tlimit[nd];
 if (fp<0) or (fp>(p-1)) then
  label12.Caption:='Enter Time Slot'
 else
  label12.Caption:=TimeSlotName[fd,fp];
end;

procedure TGotoDlg.Edit2Change(Sender: TObject);
var
 s:  string;
 lev:  integer;
begin
 s:=trim(edit2.text);
 fl:=strtointdef(s,0);
 if fy>=0 then lev:=level[fy] else lev:=level[ny];
 if (fl<1) or (fl>lev) then
  label12.Caption:='Enter Level (1-'+inttostr(lev)+')'
 else
  label12.Caption:='Level '+s;
end;

procedure TGotoDlg.GotoBtnClick(Sender: TObject);
var
 msg:  string;
 CurRow,CurCol: integer;
 Srect: TGridRect;
begin
 if fd<0 then
  begin
   msg:='Check Day';
   messagedlg(msg,mtError,[mbOK],0);
   combobox2.setfocus;
   combobox2.SelectAll;
   exit;
  end;
 if (fp<0) or (fp>=Tlimit[fd]) then
  begin
   msg:='Check Time Slot';
   messagedlg(msg,mtError,[mbOK],0);
   edit4.setfocus;
   edit4.SelectAll;
   exit;
  end;
 if fy<0 then
  begin
   msg:='Check '+Yeartitle;
   messagedlg(msg,mtError,[mbOK],0);
   combobox1.setfocus;
   combobox1.SelectAll;
   exit;
  end;
 if (fl<1) or (fl>level[fy]) then
  begin
   msg:='Check Level';
   messagedlg(msg,mtError,[mbOK],0);
   edit2.setfocus;
   edit2.SelectAll;
   exit;
  end;
 ny:=fy; nl:=fl; nd:=fd; np:=fp;
 if Homebox.checked then
  begin
   hy:=ny; hl:=nl; hd:=nd; hp:=np;
  end;
 CurRow:=FindRow(ny,nl);
 CurCol:=FindCol(nd,np);
 Srect.top:=CurRow; Srect.bottom:=CurRow;
 Srect.left:=CurCol; Srect.right:=CurCol;
 Ttablewin.StringGrid1.selection:=Srect;
 BringintoView;
 close;
end;

procedure TGotoDlg.ComboBox1Change(Sender: TObject);
begin
 fy:=findYear(combobox1.text);
 if fy=-1 then
  label12.Caption:='Enter '+yeartitle
 else
  label12.Caption:=Yeartitle+' '+Yearname[fy];

end;

procedure TGotoDlg.ComboBox2Change(Sender: TObject);
begin
 fd:=findDay(combobox2.text);
 if fd=-1 then
  label12.Caption:='Enter Day'
 else
  label12.Caption:=Dayname[fd];
end;

procedure TGotoDlg.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TGotoDlg.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

end.
