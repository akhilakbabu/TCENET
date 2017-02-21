unit Astfsldg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TAddedStaffSelDlg = class(TForm)
    Label8: TLabel;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    update: TBitBtn;
    btnClose: TBitBtn;
    BitBtn3: TBitBtn;
    Label10: TLabel;
    Edit2: TEdit;
    ComboBox2: TComboBox;
    Label11: TLabel;
    CheckBox1: TCheckBox;
    Label12: TLabel;
    Label14: TLabel;
    ComboBox6: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateAvailability(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboBox6Change(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    FIsDirect: Boolean;
    FSelectedStaffCode: Integer;
  public
    property SelectedStaffCode: Integer read FSelectedStaffCode write FSelectedStaffCode;
    property IsDirect: Boolean read FIsDirect write FIsDirect;
  end;

var
  AddedStaffSelDlg: TAddedStaffSelDlg;

implementation

uses
  tcommon, DlgCommon, tcommon2, adstfsel, tcommon3, uAMGTeacherAvailability;

{$R *.DFM}
var
  AddSelectTime:    TTimeSet;
  needupdate:        boolean;
  teplace:           integer;

procedure Taddedstaffseldlg.FormCreate(Sender: TObject);
var
 i: Integer;
begin
 label5.caption:=''; label4.caption:=''; label14.caption:='';
 combobox6.maxlength:=ETLencodes;
 combobox2.maxlength:=lencodes[1];

 needupdate:=false;
 edit2.text:='';
 ETselectedCount;
 label9.caption:=inttostr(ETselected);
 label12.caption:='';

 combobox6.clear;
 for i:=1 to etnum1 do
  combobox6.items.add(etsub[Etpointer2[i]]);

 combobox2.clear;
 combobox2.items.add('none');
 for i:=1 to codenum[1] do
  combobox2.items.add(tecode[codepoint[i,1],0]);


 AddSelectTime:=TTimeSet.create(GroupBox1);
 With AddSelectTime do
  begin
   ButtonChar:='F';
   AddSelectTime.Left:=10;
   AddSelectTime.Top:=188;
   ButtonHint:='Toggles availability for time slot';
   BaseGroup:=GroupBox1;
   makebuttons;
  end;
end;

procedure Taddedstaffseldlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if needupdate then saveExtras;
end;

procedure reestablishTelink;
var
 i: integer;
begin
 for i:=1 to nmbrteachers do telink[i]:=0;
 for i:=1 to nmbrAddedTeachers do
  if ETlink[i]>0 then telink[ETlink[i]]:=i;
end;

procedure Taddedstaffseldlg.UpdateAvailability(Sender: TObject);
var
  k,i,j,p,etavailTemp:  integer;
  msg,codeStr:          string;
  etmaxtemp: Double;
begin
 j:=findaddedstaffsel(combobox6.text);
 k:=Etpointer2[j];
 if k<=0 then
 begin
  msg:='Added teacher code not found';
  messagedlg(msg,mtError,[mbOK],0);
  combobox6.selectall; combobox6.setfocus;
  exit;
 end;
 codeStr:=Trim(Combobox2.text);
 if (uppercase(codeStr)='NONE') then codestr:='';
 teplace:=checkCode(1,codeStr);
 codeStr:=Trim(Combobox2.text);
 if (uppercase(codeStr)='NONE') then codestr:='';
 if (teplace=0) and (codeStr>'') then
 begin
  msg:='Link teacher code not found';
  messagedlg(msg,mtError,[mbOK],0);
  combobox2.selectall; combobox2.setfocus;
  exit;
 end;
 val(Trim(edit2.text),etmaxtemp,i);
 etavailTemp:=0;
 for i:=1 to tlimit[ttDay] do
 begin
  if AddSelectTime.button1[i].caption='F' then
   etavailTemp:=(etavailTemp or (1 shl i));
 end;
 if (ETmaxTemp=0) and (bool(ETavailTemp) or (teplace>0)) then
 begin
  msg:='Enter maximum load required';
  messagedlg(msg,mtError,[mbOK],0);
  edit2.selectall; edit2.setfocus;
  exit;
 end;
 if (teplace>0) then
 begin
   i:=abs(telink[teplace]);
   if (i>0) and (i<>k) then
   begin
     msg:=etsub[i]+' is already linked to '+tecode[teplace,0];
     messagedlg(msg,mtError,[mbOK],0);
     edit2.selectall; edit2.setfocus;
     Exit;
   end;
 end;
 needupdate:=true;
 Etmax[k]:=etmaxTemp;
 ETavail[k]:=etavailTemp;
 AddStaffAvailabilities.Update(etsub[k], ttDay, ETavail[k]);
 ETlink[k]:=teplace;
 if checkbox1.checked then ETlink[k]:=-ETlink[k];

 reestablishTelink;

 Eton[k]:=-1;
 Ettaught[k]:=0;
 if numchanges>0 then
  for i:=1 to numchanges do
   begin
    if (Changes[i].newte<>k) or (Changes[i].kind<>1) then continue;
    p:=Changes[i].timeslot;
    if ((getEallot(1,Changes[i].year,ttday,p)+Ettaught[k])<=Etmax[k])
      and ((ETavail[k] and (1 shl p))<>0) then
     begin
      Eton[k]:=Eton[k] and (not(1 shl p));
      Ettaught[k]:=Ettaught[k]+getEallot(1,Changes[i].year,ttday,p);
     end
    else
     begin Changes[i].newte:=0; Changes[i].needte:=-1; end;
  end; {for i}

 updateTelink;
 if (ETlink[k]>0) then checktemplinks(k);  {temps}
 checklinks;  {perms}

 ETselectedCount;

 label9.caption:=inttostr(ETselected);
  UpdateExtrasWins;
  combobox6change(self);  {force update of maps}
  combobox6.setfocus;
end;

procedure Taddedstaffseldlg.ComboBox2Change(Sender: TObject);
var
 codeStr:  string;
begin
 codeStr:=Trim(Combobox2.text);
 if (uppercase(codeStr)='NONE') then codestr:='';
 teplace:=checkCode(1,codeStr);
 label14.caption:=tename[teplace,0];
end;

procedure Taddedstaffseldlg.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key=vk_return then UpdateAvailability(Self);
end;

procedure Taddedstaffseldlg.FormShow(Sender: TObject);
var
  j: Integer;
begin
  Label12.Caption := '';
  ComboBox6.Text := '';

  if not FIsDirect then
  begin
    j := addedstaffselwin.selcode;
    if j > 0 then j := addedstaffselwin.ItemPoint[j];
  end
  else
  begin
    j := etpointer[SelectedStaffCode];
  end;

  if j > 0 then
  begin
    ComboBox6.Text := etsub[j];
    ComboBox6Change(Self);
  end;
end;

procedure Taddedstaffseldlg.ComboBox6Change(Sender: TObject);
var
 k,i,j:integer;
 s,s2: string;
begin
 label14.caption:=''; edit2.text:=''; teplace:=0; combobox2.text:='';
 j:=findaddedstaffsel(ComboBox6.text);
 k:=Etpointer2[j];
 if k>0 then
 begin
  label5.caption:=etname[k];
  label4.caption:=Etcomment[k];
  if ETfaculty[k]=-1 then label12.caption:='All faculties'
   else label12.caption:=facname[ETfaculty[k]];
  str(Etmax[k]:5:2,s);
  edit2.text:=Trim(s);
  teplace:=abs(ETlink[k]);
  checkbox1.checked:=(ETlink[k]<0);
  j:=-1;
  if teplace>0 then
  begin
   for i:=1 to codenum[1] do
    if codepoint[i,1]=teplace then
    begin j:=i; break; end;
  end;
  if j>0 then
   begin
    label14.caption:=tename[codepoint[j,1],0];
    combobox2.Text:=tecode[codepoint[j,1],0];
   end;
   if ETavail[k] = 0 then
     ETavail[k] := AddStaffAvailabilities.GetAvailable(etsub[k], ttDay);
   for i:=1 to tlimit[ttDay] do
   begin
    s2:=' -';
    if bool(ETavail[k] and (1 shl i)) then
    begin
     s2:=' F';
     if (Eton[k] and (1 shl i))=0 then s2:=' C';
    end;
    AddSelectTime.perlab2[i].caption:=s2;

    IF bool((ETavail[k]) AND (1 shl i)) THEN
     AddSelectTime.button1[i].caption:='F'
    else
     AddSelectTime.button1[i].caption:='';
   end;
 end
  else
   begin
    label5.caption:=''; label4.caption:='';
    label12.caption:='';
    for i:=1 to tlimit[ttDay] do
    begin
     AddSelectTime.perlab2[i].caption:=' ';
     AddSelectTime.button1[i].caption:='';
    end;
   end;
end;

procedure Taddedstaffseldlg.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
 allowdecimalInputOnly(key);
end;

end.


