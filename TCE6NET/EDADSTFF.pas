unit Edadstff;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, ComCtrls, GlobalToTcAndTcextra;

type
  TedAddedstaff = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    finish: TBitBtn;
    update: TBitBtn;
    BitBtn3: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit4: TEdit;
    cboAddedStaffCode: TComboBox;
    previous: TBitBtn;
    next: TBitBtn;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Memo1: TMemo;
    Label8: TLabel;
    edtPhone: TEdit;
    Label9: TLabel;
    chkMon: TCheckBox;
    Label10: TLabel;
    Label11: TLabel;
    chkTue: TCheckBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    chkWed: TCheckBox;
    chkThu: TCheckBox;
    chkFri: TCheckBox;
    chkSat: TCheckBox;
    chkSun: TCheckBox;
    Label17: TLabel;
    edtPriority: TEdit;
    UpDown1: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure nextClick(Sender: TObject);
    procedure previousClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RefreshDetails(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    Procedure ButtonStatus;
    procedure TeShow;
    procedure Restore;
    procedure ShowTeacher;
  end;

var
  edAddedstaff: TedAddedstaff;

implementation

uses
  tcommon, tcommon2, addstaff, tcommon3, tcommon4;

{$R *.DFM}
var
  needupdate: Boolean;
  myte,TePos: Integer;

procedure TedAddedstaff.TeShow;
begin
  cboAddedStaffCode.Text := TrimRight(etsub[myte]);
  RefreshDetails(Self);
  ButtonStatus;
end;

Procedure TedAddedstaff.ButtonStatus;
begin
 previous.enabled:=(TePos>1);
 next.enabled:=(TePos<ETnum1);
end;

procedure TedAddedstaff.Restore;
begin
  edit2.text:=''; memo1.text:='';   edit4.text:='';
  combobox1.ItemIndex := 0;
  cboAddedStaffCode.SetFocus;
end;

procedure TedAddedstaff.ShowTeacher;
begin
 edit2.text:=ETname[myte];
 memo1.text:=Etcomment[myte];
 combobox1.itemindex:=ETfaculty[myte]+1;
 combobox2.itemindex:=ETfaculty2[myte]+1;
 combobox3.itemindex:=ETfaculty3[myte]+1;
 combobox4.itemindex:=ETfaculty4[myte]+1;
 edit4.text:=Trim(etsub[myte]);
 //173
 edtPhone.Text := ETPhone[myte];
 edtPriority.Text := inttostr(ETPriority[myte]);
 chkMon.Checked := (ETMon[myte] = 1);
 chkTue.Checked := (ETTue[myte] = 1);
 chkWed.Checked := (ETWed[myte] = 1);
 chkThu.Checked := (ETThu[myte] = 1);
 chkFri.Checked := (ETFri[myte] = 1);
 chkSat.Checked := (ETSat[myte] = 1);
 chkSun.Checked := (ETSun[myte] = 1);
end;

procedure TedAddedstaff.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  TopCentre(self);
  cboAddedStaffCode.maxlength := ETLencodes;
  cboAddedStaffCode.maxlength := szFacName;
  edit4.maxlength:=ETLencodes;
  edit2.maxlength:=sztename;
  //edit3.maxlength:=szEcomment;
  cboAddedStaffCode.Clear;
  for i:=1 to etnum1 do
  cboAddedStaffCode.Items.Add(etsub[Etpointer[i]]);
  edit4.text:='';
  combobox1.clear;   combobox2.clear; combobox3.clear; combobox4.clear;
  combobox1.items.add('All faculties');
  combobox2.items.add('All faculties');
  combobox3.items.add('All faculties');
  combobox4.items.add('All faculties');
  combobox1.items.add('None');
  combobox2.items.add('None');
  combobox3.items.add('None');
  combobox4.items.add('None');
  if facnum>0 then
  for i:=1 to facnum do begin
   combobox1.items.add(facname[i]);
   combobox2.items.add(facname[i]);
   combobox3.items.add(facname[i]);
   combobox4.items.add(facname[i]);
  end;
  label6.caption:=inttostr(ETnum);
  // #173
  edtPhone.Text := '';
  edtPriority.Text := '1';
  chkMon.Checked := false;
  chkTue.Checked := false;
  chkWed.Checked := false;
  chkThu.Checked := false;
  chkFri.Checked := false;
  chkSat.Checked := false;
  chkSun.Checked := false;

  needupdate:=false;
end;

procedure TedAddedstaff.updateClick(Sender: TObject);
var
 msg,b:   string;
 i,j,k:     integer;
begin
  i := Etpointer[findaddedstaff(cboAddedStaffCode.Text)];
  if i=0 then
  begin
    msg:='Code not found'+endline;
    msg:=msg+'Please try another code.';
    messagedlg(msg,mtError,[mbOK],0);
    cboAddedStaffCode.SelectAll;
    cboAddedStaffCode.SetFocus;
    Exit;
  end;
  if Trim(edit4.text)='' then
  begin
    msg:='No Code entered'+endline;
    msg:=msg+'Please enter a code.';
    messagedlg(msg,mtError,[mbOK],0);
    edit4.selectall; edit4.setfocus;
    Exit;
 end;
 j:=i;
 k:=findaddedstaff(edit4.text);
 i:=Etpointer[k];
 if ((i>0) and (i<>j)) then
 begin
  msg:='Code '+uppercase(Trim(edit4.text))+' already in use by '+ETname[i]+endline;
  msg:=msg+'Please try another code.';
  messagedlg(msg,mtError,[mbOK],0);
  edit4.selectall; edit4.setfocus;
  exit
 end;
 b:=copy(Trim(edit4.text),1,2);
 if b='00' then
 begin
  msg:='00 codes used for deletions'+endline;
  msg:=msg+'Please try another code.';
  messagedlg(msg,mtError,[mbOK],0);
  edit4.selectall; edit4.setfocus;
  exit
 end;
 b:=Trim(edit4.text);
 if b='' then
 begin
  msg:='No code entered.';
  messagedlg(msg,mtError,[mbOK],0);
  edit4.selectall;
  edit4.setfocus;
  exit;
 end;
 etsub[j]:=uppercase(Trim(edit4.text));
 ETname[j]:=Trim(edit2.text);
 Etcomment[j]:=Trim(Memo1.text);
 ETfaculty[j]:=findfac(combobox1.text);
 if (ETfaculty[j]=-1) or (combobox1.itemindex=1) then ETfaculty[j]:=0;
 if ((combobox1.itemindex=0) or
     (uppercase(Trim(combobox1.text))='*') or
     (uppercase(Trim(combobox1.text))='ALL FACULTIES')) then
       ETfaculty[j]:=-1;
 ETfaculty2[j]:=findfac(combobox2.text);
 if (ETfaculty2[j]=-1) or (combobox2.itemindex=1) then ETfaculty2[j]:=0;
 if ((combobox2.itemindex=0) or
     (uppercase(Trim(combobox2.text))='*') or
     (uppercase(Trim(combobox2.text))='ALL FACULTIES')) then
       ETfaculty2[j]:=-1;
 ETfaculty3[j]:=findfac(combobox3.text);
 if (ETfaculty3[j]=-1) or (combobox3.itemindex=1) then ETfaculty3[j]:=0;
 if ((combobox3.itemindex=0) or
     (uppercase(Trim(combobox3.text))='*') or
     (uppercase(Trim(combobox3.text))='ALL FACULTIES')) then
       ETfaculty3[j]:=-1;
 ETfaculty4[j]:=findfac(combobox4.text);
 if (ETfaculty4[j]=-1) or (combobox4.itemindex=1) then ETfaculty4[j]:=0;
 if ((combobox4.itemindex=0) or
     (uppercase(Trim(combobox4.text))='*') or
     (uppercase(Trim(combobox4.text))='ALL FACULTIES')) then
       ETfaculty4[j]:=-1;

 // #173
 ETPhone[i] := edtPhone.Text;
 try
   ETPriority[i] := strtoint(edtPriority.Text);
 except
   ETPriority[i] := 1;
 end;
 if (chkMon.Checked) then begin
   ETMon[i] := 1;
 end else begin
   ETMon[i] := 0;
 end;
 if (chkTue.Checked) then begin
   ETTue[i] := 1;
 end else begin
   ETTue[i] := 0;
 end;
 if (chkWed.Checked) then begin
   ETWed[i] := 1;
 end else begin
   ETWed[i] := 0;
 end;
 if (chkThu.Checked) then begin
   ETThu[i] := 1;
 end else begin
   ETThu[i] := 0;
 end;
 if (chkFri.Checked) then begin
   ETFri[i] := 1;
 end else begin
   ETFri[i] := 0;
 end;
 if (chkSat.Checked) then begin
   ETSat[i] := 1;
 end else begin
   ETSat[i] := 0;
 end;
 if (chkSun.Checked) then begin
   ETSun[i] := 1;
 end else begin
   ETSun[i] := 0;
 end;

 etsort2;    etsort3;
 getAddedStaffFontWidths;
 UpdateExtrasWins;
 needupdate:=true;
 if next.enabled then nextclick(self);
end;

procedure TedAddedstaff.nextClick(Sender: TObject);
begin
  if TePos<ETnum1 then
  begin
   inc(TePos);
   myte:=Etpointer[TePos];
   teshow;
  end;
end;

procedure TedAddedstaff.previousClick(Sender: TObject);
begin
  if TePos>1 then
  begin
   dec(TePos);
   myte:=Etpointer[TePos];
   teshow;
  end;
end;

procedure TedAddedstaff.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if needupdate then etout;
 UpdateWindow(wnInfo);
end;

procedure TedAddedstaff.RefreshDetails(Sender: TObject);
var
 codeStr: string;
begin
 codeStr := cboAddedStaffCode.Text;
 codeStr:=TrimRight(codeStr);
 myte:=0;TePos:=findaddedstaff(codeStr);
 if TePos>0 then myte:=Etpointer[TePos];
 if myte>0 then showteacher else restore;
 ButtonStatus;
end;

procedure TedAddedstaff.FormActivate(Sender: TObject);
begin
  myte := 0;
  TePos := Addedstaffwin.selCode;
  if TePos>0 then
  begin
    myte:=ETpointer[TePos];
    teshow;
  end
  else
  begin
    restore;
    cboAddedStaffCode.text:='';
  end;
  ButtonStatus;
  cboAddedStaffCode.SetFocus;
end;

end.
