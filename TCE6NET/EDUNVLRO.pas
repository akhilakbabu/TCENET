unit Edunvlro;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Buttons, StdCtrls,ClassDefs,TCEglobals;

type
  Tedunavailablerooms = class(TForm)
    Label8: TLabel;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    update: TBitBtn;
    finish: TBitBtn;
    BitBtn3: TBitBtn;
    ComboBox6: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox6Change(Sender: TObject);
  end;

var
  edunavailablerooms: Tedunavailablerooms;

implementation
uses tcommon,tcommon2,tcommon3,unavalro;
{$R *.DFM}

 type TUnavailRoomTime=class(TTimeSet)
  protected
   function SmallCase(i:integer): boolean; override;
 end;

var
  UnavailRoomTime:    TUnavailRoomTime;
  needupdate:        boolean;
  myroom:       integer;

function TUnavailRoomTime.SmallCase(i:integer): boolean;
begin
 result:=(((roomteach[myroom] and (1 shl i))<>0) or ((rolost[myroom] and (1 shl i))=0))
end;


procedure Tedunavailablerooms.FormCreate(Sender: TObject);
var
 i,j:   integer;
begin
 label5.caption:='';
 combobox6.maxlength:=lencodes[2];
 needupdate:=false;
 updateUnavailableClassesCnt;
 label9.caption:=inttostr(UnavailableClassesCnt);

 combobox6.clear;
 for i:=1 to codenum[2] do
  combobox6.items.add(tecode[codepoint[i,2],1]);

 UnavailRoomTime:=TUnavailRoomTime.create(GroupBox1);
 With UnavailRoomTime do
  begin
   ButtonChar:='U';
   UnavailRoomTime.Left:=10;
   UnavailRoomTime.Top:=84;
   ButtonHint:='Toggles unavailable for time slot';
   BaseGroup:=GroupBox1;
   makebuttons;
  end;

 combobox6.text:='';

 j:=unavailablerooms.selcode;
 if j>0 then j:=unavailablerooms.ItemPoint[j];
 if j>0 then
  begin
   combobox6.text:=tecode[j,1];
   combobox6change(self);
  end;
end;

procedure Tedunavailablerooms.updateClick(Sender: TObject);
var
 p,i,unavail:   integer;
 msg: string;

begin
 unavail:=-1;
 place:=codepoint[findroomstr(combobox6.text),2];
 if place=0 then
 begin
  msg:='Check Room Code';
  messagedlg(msg,mtError,[mbOK],0);
  combobox6.selectall; combobox6.setfocus;
  exit;
 end;
 for i:=1 to tlimit[ttday] do
  if uppercase(UnavailRoomTime.button1[i].caption)='U' then unavail:=unavail and (not(1 shl i));
 msg:='';
 for p:=1 to tlimit[ttday] do
  if (unavail and (1 shl p))=0 then
   if (roswap[place] and (1 shl p))=0 then
    msg:='Room '+tecode[place,1]+' swapped in time '+tslotcode[p,ttday];
 if msg>'' then
 begin
  messagedlg(msg,mtError,[mbOK],0);
  combobox6.setfocus; combobox6.selectall;
  exit;
 end;
 roabsent[place]:=unavail;
 UpdateRoomAbsence(place);
 updateroommap;
 updateUnavailableClassesCnt;
 label9.caption:=inttostr(UnavailableClassesCnt);
 UpdateExtrasWins;  needupdate:=true;
 combobox6.setfocus;
 combobox6change(self);
end;

procedure Tedunavailablerooms.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if needupdate then SaveExtras;
end;

procedure Tedunavailablerooms.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_return then updateclick(self);
end;

procedure Tedunavailablerooms.ComboBox6Change(Sender: TObject);
var
 i: integer;
 codeStr: string;
 show: boolean;
begin
 codeStr:=Trim(Combobox6.text);
 myroom:=checkCode(2,codeStr);
 if myroom>0 then
  begin
   label5.caption:=tename[myroom,1];
   for i:=1 to tlimit[ttday] do
    begin
     show:=((roabsent[myroom] and (1 shl i))=0);
     UnavailRoomTime.ButtonShow(i,show);
     UnavailRoomTime.perlab2[i].caption:=' '+romap[myroom][i];
    end;
  end
 else
  begin
   label5.caption:='';
   for i:=1 to tlimit[ttday] do
    begin
     UnavailRoomTime.Button1[i].Caption:='';
     UnavailRoomTime.perlab2[i].caption:='';
   end;
  end;
end;

initialization
 myroom:=0;

end.
