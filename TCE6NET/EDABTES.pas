unit Edabtes;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TEditAbsTeacherss = class(TForm)
    GroupBox1: TGroupBox;
    update: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    cboReason: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    ComboBox2: TComboBox;
    Label2: TLabel;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    Label13: TLabel;
    finish: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox2Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FSelectedTeCode: Integer;
    FIsDirect: Boolean;
  public
    property SelectedTeCode: Integer read FSelectedTeCode write FSelectedTeCode;
    property IsDirect: Boolean read FIsDirect write FIsDirect;
  end;

var
  EditAbsTeacherss: TEditAbsTeacherss;

implementation

uses
  tcommon, tcommon2, abtes, tcommon3, uAMGTeacherAbsence, DateUtils;

{$R *.DFM}

 type TAbsentTime=class(TTimeSet)
  protected
   function SmallCase(i:integer): boolean; override;
 end;

var
 AbsentTime:    TAbsentTime;
  needupdate:        boolean;
  myte:     integer;

function TAbsentTime.SmallCase(i:integer): boolean;
begin
result:= (((teach[myte] and (1 shl i))<>0) or
       ((telost[myte] and (1 shl i))=0) or
        ((tena[myte] and (1 shl i))=0));
end;

function findSharedTeachersPartner(te: integer):integer;
var
 p,y,l,y2,l2,s1,s2:  integer;
 afnt,bfnt,cfnt:      tpintpoint;
 te2,pa,ro,count,tcount,ro2:          integer;
begin
 pa:=0; tcount:=0;  ttyear:=0; ttlevel:=0; ttroom:=0; ttsub:=0;
 for p:=1 to tlimit[ttday] do
 begin
  count:=0;
  for y:=0 to years_minus_1 do
  begin
   for l:=1 to level[y] do
   begin
    afnt:=FNT(ttday,p-1,y,l,2);
    cfnt:=afnt; inc(cfnt,2);
    s1:=(cfnt^ and 2);
    if (afnt^=te) and bool(s1) then
    begin
     ttyear:=y; ttlevel:=l;
     inc(afnt); ro:=afnt^; ttroom:=ro;
     dec(afnt,2); ttsub:=afnt^;
      for y2:=0 to years_minus_1 do
      begin
       for l2:=1 to level[y] do
       begin
        bfnt:=FNT(ttday,p-1,y2,l2,2);
        te2:=bfnt^;
        if te2<>te then
        begin
         inc(bfnt); ro2:=bfnt^;
         inc(bfnt); s2:=(bfnt^ and 2);
         if (ro2=ro) and bool(s2) then
         begin
          if (pa>0) and (pa<>te2) then count:=2; {cause break on ambiguiety}
          pa:=te2; inc(count);
         end
        end;
        if count>1 then break;
       end; {for l2}
       if count>1 then break;
      end; {for y2}
    end; {if (afnt^=te)}
    if count>1 then break;
   end; {for l}
   if count>1 then break;
  end; {for y}
  if count>tcount then tcount:=count;
  if tcount>1 then break;
 end; {for p}

 if tcount>1 then pa:=-1;
 result:=pa;
end;

procedure TEditAbsTeacherss.FormCreate(Sender: TObject);
var
 i: Integer;
begin
 //RescanTimetable(True);
 combobox2.maxlength:=lencodes[1];
 cboReason.MaxLength:=szAbReason;
 checkbox1.checked:=teamexclude;
 label5.caption:='';
 label4.caption:=''; label11.caption:='';
 label9.caption:='';
 needupdate:=false;

 combobox2.clear;
 if codenum[1]>0 then
  for i:=1 to codenum[1] do
   combobox2.items.add(tecode[abcodepoint[i],0]);
 label9.caption:=inttostr(countAbsTes);
 cboReason.Items.Clear;
 cboReason.Items.Add('    - none -');
 for i:=1 to nmbrreasonsinuse do
  cboReason.Items.Add(Abcode[i]+' - '+Absent[i]);

 AbsentTime:=TAbsentTime.create(GroupBox1);
 With AbsentTime do
  begin
   ButtonChar:='A';
   AbsentTime.Left:=10;
   AbsentTime.Top:=166;
   ButtonHint:='Toggles absence for time slot';
   BaseGroup:=GroupBox1;
   makebuttons;
  end;
end;

procedure TEditAbsTeacherss.updateClick(Sender: TObject);
var
  i: integer;
  msg:          string;
  lTeacherAbsence: TAMGTeacherAbsence;
  lAbsence: string;
  lIdx: Integer;
  lIsAbsent: Boolean;
  lDateToday: string;
begin
 if myte<=0 then
 begin
  msg:='Teacher Code not found';
  messagedlg(msg,mtError,[mbOK],0);
  combobox2.setfocus;
  exit;
 end;

 if cboReason.ItemIndex = 0 then
 begin
   msg:='Please select a reason for the absence';
   messagedlg(msg,mtError,[mbOK],0);
   cboReason.SetFocus;
   exit;
 end;
 needupdate:=true;
 tabsreason[myte]:= cboReason.itemindex;

 teAbsent[myte]:=-1;
 lAbsence := '';
 lIsAbsent := False;
 for i:=1 to tlimit[ttDay] do
 begin
  if UpperCase(AbsentTime.button1[i].caption)='A' then
   teAbsent[myte] := (teAbsent[myte] and (not(1 shl i)));
   if UpperCase(AbsentTime.button1[i].caption)='A' then
   begin
     lIsAbsent := True;
     lAbsence := lAbsence + 'A';
   end
   else
     lAbsence := lAbsence + 'P';
 end;
  lDateToday := DateToStr(EncodeDate(ExYear, ExMonth, ExDay));
  //IntToStr(exday) + ' ' + month[exmonth] + ' ' + formatdatetime('yyyy',now);
  lIdx := TeacherAbsences.GetIndex(Trim(TeCode[myte, 0]), lDateToday);
  if lIdx > -1 then
    TeacherAbsences.Delete(lIdx);

  if lIsAbsent then
  begin
    lTeacherAbsence := TAMGTeacherAbsence.Create;
    lTeacherAbsence.TeacherID := MyTe;
    lTeacherAbsence.TeacherCode := Trim(TeCode[myte, 0]);
    lTeacherAbsence.TeacherName := Trim(TeName[myte, 0]);
    lTeacherAbsence.AbsenceDateStr := lDateToday;
    lTeacherAbsence.Absence := Trim(lAbsence); // ??? stringlist to include absence code against each slot ???
    lTeacherAbsence.AbsenceReasonCode := Trim(cboReason.Text); // ToDo this needs to be the code of the reason once the code is made compulsory
    TeacherAbsences.Add(lTeacherAbsence);
  end;
  TeacherAbsences.SaveToFile;

 updateteachermap;
 updateAbsence(myte);
 sortabcodes;
 label9.caption:=inttostr(countAbsTes);
 UpdateExtrasWins;
 combobox2.setfocus;
 combobox2change(self);
end;

procedure TEditAbsTeacherss.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if needupdate then saveExtras;
end;

procedure TEditAbsTeacherss.ComboBox2Change(Sender: TObject);
var
 ct,i:integer;
 codeStr:  string;
 show: boolean;
begin
 codeStr:=Trim(Combobox2.text);
 myte:=checkCode(1,codeStr);
 if myte>0 then
 begin
  ct:=findSharedTeachersPartner(myte);
  if ct>0 then
   label13.caption:='Team teaching with '+tecode[ct,0]+' '+tename[ct,0]
  else
   begin
    if ct=-1 then label13.caption:='Team teaching with several teachers'
    else
     label13.caption:='NOT Team teaching';
   end;
 end {if myte>0}
 else label13.caption:='';

 if myte>0 then
 begin
  label5.caption:=tename[myte,0];
  label4.caption:=Ecomment[myte];
  cboReason.itemindex:=tabsreason[myte]{-1};
   for i:=1 to tlimit[ttDay] do
   begin
    AbsentTime.perlab2[i].caption:=' '+temap[myte][i];
    show:= bool((NOT(teAbsent[myte])) AND (1 shl i)); // teAbsent[myte] - returns -1 when nothing is found
    AbsentTime.ButtonShow(i,show);
   end;
  label11.caption:=etsub[abs(telink[myte])];
  if telink[myte]<0 then label11.caption:=label11.caption+' *';
 end
  else
   begin
    label5.caption:=''; label4.caption:='';
    cboReason.ItemIndex := -1;
    for i:=1 to tlimit[ttDay] do
    begin
     AbsentTime.perlab2[i].caption:=' ';
     AbsentTime.button1[i].caption:='';
    end;
    label11.caption:='';
   end;
  label9.caption:=inttostr(countAbsTes);

end;

procedure TEditAbsTeacherss.CheckBox1Click(Sender: TObject);
begin
 teamexclude:=checkbox1.checked;
end;

procedure TEditAbsTeacherss.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_return then updateclick(self);
end;

procedure TEditAbsTeacherss.FormShow(Sender: TObject);
var
  j: Integer;
begin
  cboReason.ItemIndex := 0;  {none}
  ComboBox2.ItemIndex := -1;
  ComboBox2.Text := '';

  if not FIsDirect then
  begin
    j := Absentte.SelCode;
    if j > 0 then j:=Absentte.ItemPoint[j];
  end
  else
  begin
    j := CodePoint[FSelectedTeCode, 1];
  end;
  if j > 0 then
  begin
    combobox2.Text := TeCode[j, 0];
    ComboBox2Change(Self);
  end;
end;

end.

