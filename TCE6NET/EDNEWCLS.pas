unit Ednewcls;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,ClassDefs,TCEglobals,GlobalToTcAndTcextra ;

type
  TEdNewClass = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    ComboBox2: TComboBox;
    Label5: TLabel;
    ComboBox4: TComboBox;
    Edit2: TEdit;
    Label6: TLabel;
    Edit3: TEdit;
    Label7: TLabel;
    Label4: TLabel;
    ComboBox3: TComboBox;
    update: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Edit4: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
  end;

var
  EdNewClass: TEdNewClass;


implementation
uses tcommon,DlgCommon,tcommon2,tcommon3,newclass;

var
  NewClassTime:    TTimeSet;
  needupdate:        boolean;
{$R *.DFM}

procedure TEdNewClass.FormCreate(Sender: TObject);
var
 i,j:       integer;
begin
 needupdate:=false;
 combobox2.maxlength:=szSubCode;
 combobox3.maxlength:=szYearname;
 combobox4.maxlength:=szClassName;
 label9.caption:=inttostr(newclasses);
 combobox2.clear;
 for i:=1 to codenum[0] do
  combobox2.items.add(subcode[codepoint[i,0]]);

 combobox3.clear;
 for i:=0 to years-1 do
  combobox3.items.add(yearname[i]);

 combobox4.clear;
 j:=findyear(combobox3.text);
 if j>=0 then
  for i:=1 to level[j] do
   if ClassShown[i,j]>0 then
    combobox4.items.add(ClassCode[ClassShown[i,j]]);

 NewClassTime:=TTimeSet.create(GroupBox1);
 With NewClassTime do
  begin
   ButtonChar:='M';
   NewClassTime.Left:=10;
   NewClassTime.Top:=76;
   ButtonHint:='Toggles new class for time slot';
   BaseGroup:=GroupBox1;
   makebuttons;
  end;

 if NewClasseswin.selcode>0 then edit1.text:=inttostr(NewClasseswin.selcode)
  else edit1.text:='';
end;

procedure TEdNewClass.Edit1Change(Sender: TObject);
var
 i,j,k:   integer;
begin
 i:=strtointdef(edit1.text,0);
 if i>0 then
 begin
  k:=0;
  for j:=1 to codenum[0] do
   if codepoint[j,0]=nsub[i] then
    begin k:=j; break; end;
  combobox2.itemindex:=k-1;
  if (nstaff[i]=0) and (nrooms[i]=0) then
   combobox3.itemindex:=0 {-1}
  else
   combobox3.itemindex:=nyear[i];
  ComboBox3Change(self);   {ensure update}

  if combobox3.itemindex<>-1 then combobox4.itemindex:=nlevel[i]-1
   else combobox4.itemindex:=-1;

  edit2.text:=inttostr(nstaff[i]);
  edit3.text:=inttostr(nrooms[i]);
  for j:=1 to tlimit[ttday] do
  begin
   if bool(ntime[i] and (1 shl j)) then
   begin
    NewClassTime.button1[j].caption:='M';
    NewClassTime.perlab2[j].caption:=' M';
   end
   else
    begin
      NewClassTime.button1[j].caption:='';
      NewClassTime.perlab2[j].caption:=' -';
    end;
  end;
 end
 else
  begin
   combobox2.itemindex:=-1;
   combobox3.itemindex:=0 {-1};
   combobox4.itemindex:=-1;
   ComboBox3Change(self); {ensure update}
   edit2.text:='';
   edit3.text:='';
   for j:=1 to tlimit[ttday] do NewClassTime.button1[j].caption:='';
  end;
end;

procedure TEdNewClass.ComboBox3Change(Sender: TObject);
var
 i,j :    integer;
begin
 combobox4.clear;
 j:=findyear(combobox3.text);
 if j>=0 then
  for i:=1 to level[j] do
   if ClassShown[i,j]>0 then
    combobox4.items.add(ClassCode[ClassShown[i,j]]);
end;

procedure TEdNewClass.updateClick(Sender: TObject);
var
 a,j,k,p,
 Rnew,Tnew,Romax,Temax: integer;
 msg,tmpstr:                   string;

       procedure newsubroom(i: integer);
       begin
        inc(rnew);
        if Changes[i].newroom=0 then Changes[i].needroom:=1;
        if Changes[i].NeedRoom=0 then Changes[i].NeedRoom:=2;
       end;


       procedure newsubte(i: integer);
       begin
        inc(tnew);
        if Changes[i].newte=0 then
         begin
          Changes[i].needte:=-1;
          Changes[i].kind:=0;
         end;
       end;


       procedure addnewclasses(p:integer);
       var
        i,a: integer;
       begin
        a:=strtointdef(edit1.text,0);
        if a=0 then exit;
        if bool(ntime[a] and (1 shl p)) then
        begin
         romax:=nrooms[a]; temax:=nstaff[a];
        end
        else
         begin
          romax:=0; temax:=0;
         end;
        rnew:=0; tnew:=0;
        for i:=1 to numchanges do
         if ((Changes[i].gen=2) and (Changes[i].timeslot=p) and (Changes[i].reason=a)) then
          if ((rnew<>romax) or (tnew<>temax)) then
          begin
           Changes[i].year:=nyear[a]; Changes[i].level:=nlevel[a]; Changes[i].sub:=nsub[a];
           if rnew=romax then
           begin
            Changes[i].newroom:=0; Changes[i].NeedRoom:=0;
           end;
           if (rnew<romax) then newsubroom(i);
           if (tnew<temax) then newsubte(i);
          end
          else
           Changes[i].reason:=-1;
          while (((rnew<>romax) or (tnew<>temax))
           and (numchanges<>nmbrChanges)) do
          begin
           inc(numchanges);
           i:=numchanges;
           Changes[i].timeslot:=p; Changes[i].year:=nyear[a]; Changes[i].level:=nlevel[a];
           Changes[i].sub:=nsub[a]; Changes[i].reason:=a; Changes[i].kind:=0; Changes[i].newroom:=0;
           Changes[i].newte:=0; Changes[i].gen:=2;
           if (rnew<romax) then newsubroom(i);
           if (tnew<temax) then newsubte(i);
          end;  {while}
          for a:=numchanges downto 1 do
           if Changes[a].reason=-1 then deletechange(a);
       end;

begin {main ok butt click}
 a:=strtointdef(edit1.text,0);
 j:=strtointdef(edit2.text,0);
 k:=strtointdef(edit3.text,0);
 if a=0 then
 begin
  msg:='Check new class number';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.selectall; edit1.setfocus;
  exit;
 end;
 if (j<0) or (j>nmbrteachers) then
 begin
  msg:='Check number of teachers.'+endline;
  messagedlg(msg,mtError,[mbOK],0);
  edit2.selectall; edit2.setfocus;
  exit;
 end;
 if (k<0) or (k>nmbrrooms) then
 begin
  msg:='Check number of rooms.'+endline;
  messagedlg(msg,mtError,[mbOK],0);
  edit3.selectall; edit3.setfocus;
  exit;
 end;

 ntime[a]:=0;
 for p:=1 to tlimit[ttday] do
   if NewClassTime.button1[p].caption='M' then
     ntime[a]:=ntime[a] or (1 shl p);
 tmpstr:=combobox2.text;
 nsub[a]:=checkcode(0,tmpstr);
 nyear[a]:=findyear(combobox3.text);
 nlevel[a]:=findclass2(combobox4.text);
 nstaff[a]:=j; nrooms[a]:=k;
 for p:=1 to tlimit[ttday] do
  addnewclasses(p);
  needupdate:=true;
 label9.caption:=inttostr(newclasses);
 UpdateExtrasWins;
 edit1.setfocus;
end;

procedure TEdNewClass.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if needupdate then saveExtras;
end;

procedure TEdNewClass.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TEdNewClass.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_return then updateclick(self);
end;

procedure TEdNewClass.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TEdNewClass.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

end.

