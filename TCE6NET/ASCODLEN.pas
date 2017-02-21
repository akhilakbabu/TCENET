unit Ascodlen;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, GlobalToTcAndTcextra;

type
  TEtcodelengthdlg = class(TForm)
    btnClose: TBitBtn;
    update: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  end;

var
  Etcodelengthdlg: TEtcodelengthdlg;

implementation

uses tcommon,DlgCommon,addstaff,tcommon2,tcommon3, Adstfsel;

procedure checkCodelengths; forward;

{$R *.DFM}
type
 tpTsub=array[0..nmbrAddedTeachers] of string[szSubCode];

var
 old_lenCodes:  integer;
 Tsub:   array[0..nmbrAddedTeachers] of string[szSubCode];
 codeDouble:    bool;
 szCode:   integer;

function codelengths:bool;
var
 i: integer;
 cl: integer;
 msg: string;
begin
 result:=false;
 old_lencodes:=ETLencodes;
 cl:=strtointdef(Etcodelengthdlg.edit1.text,0);
 if ((cl<2) or (cl>szCode)) then
 begin
  msg:='Invalid code length. ';
  msg:=msg+endline+'Enter a value in the range '+inttostr(2)+' to ' +inttostr(szCode)+'.';
  messagedlg(msg,mtError,[mbOK],0);
  Etcodelengthdlg.edit1.setfocus;
  exit;
 end;
 ETLencodes:=cl;
 checkcodelengths;
 if codeDouble then ETLencodes:=old_lencodes;
 if old_lencodes=ETLencodes then exit;
 result:=true;
 if etnum1>0 then
 begin
  if old_lencodes<ETLencodes then
  begin
    for i:=1 to etnum1 do
     etsub[Etpointer[i]]:=etsub[Etpointer[i]]+space(ETLencodes-old_lencodes);
  end
   else
    begin
      for i:=1 to etnum1 do
       etsub[Etpointer[i]]:=copy(etsub[Etpointer[i]],1,ETLencodes);
    end; {else}
 end; {if etnum1>0}

 if etnum1>0 then
  for i:=1 to etnum1 do
   etsub[Etpointer[i]]:=RpadString(etsub[Etpointer[i]],ETLencodes);
 etout;
end;


procedure sortcodes;
var
 D,H,I,J,L:     integer;
 astr:    string;
label lab1,lab2,lab3;
begin
 D:=1;
 lab1:
 D:=D+D;
 if D<ETnum1 then goto lab1;
 lab3:
 D:=(D-1) div 2;
 if D=0 then exit;
 H:=ETnum1-D;
 for I:=1 to H do
 begin
  J:=I;
  lab2:
  L:=J+D;
  if (Tsub[L]<Tsub[j]) then
  begin
   astr:=Tsub[L]; Tsub[L]:=Tsub[J]; Tsub[J]:=astr;
   J:=J-D;
   if J>0 then goto lab2;
  end;
 end; {next}
 goto lab3;
end;


procedure checkCodelengths;
var
 i,j,x,y:     integer;
 msg:   string;
begin
 codeDouble:=false;
 if ETLencodes>=old_lencodes then exit;
 for i:=1 to etnum1 do
  begin
   Tsub[i]:=copy(etsub[Etpointer[i]],1,ETLencodes);
  end;
 sortcodes;
 for i:=1 to (etnum1-1) do
  for j:=(i+1) to etnum1 do
  begin
   if ((i<>j) and (Tsub[i]=Tsub[j])) then
   begin
    codedouble:=true;
    break;
   end;
   if (Tsub[j]>Tsub[i]) then break;
  end; {for j}
 if codedouble then
 begin
  x:=Etcodelengthdlg.left;y:=Etcodelengthdlg.top+Etcodelengthdlg.height;
  if Etcodelengthdlg.top>(screen.height div 2) then y:=y-2*Etcodelengthdlg.height;
  msg:='Reduction of Added Staff codes will create identical codes.';
  msg:=msg+endline+'Please enter a different value.';
  messagedlgPos(msg,mtError,[mbOK],0,x,y);
  Etcodelengthdlg.edit1.setfocus;
  exit;
 end;
end;

procedure TEtcodelengthdlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure TEtcodelengthdlg.FormActivate(Sender: TObject);
begin
 szCode:=szTeCode;
 edit1.text:=inttostr(ETLencodes);
 label2.caption:=inttostr(ETLencodes);
 Etcodelengthdlg.caption:='Added Staff Code Lengths';
 edit1.setfocus;
end;

procedure TEtcodelengthdlg.updateClick(Sender: TObject);
begin
 if codelengths then
 begin
   getAddedStaffFontWidths;
   AddedStaffWin.UpdateWin;
   if wnFlag[wnAddedSel] then AddedStaffSelWin.UpdateWin;
   close;
 end {if ok}
 else if ((old_lencodes=ETLencodes) and not(codedouble)) then close;

end;

procedure TEtcodelengthdlg.btnCloseClick(Sender: TObject);
begin
 close;
end;

procedure TEtcodelengthdlg.FormCreate(Sender: TObject);
begin
 topcentre(self);
end;

procedure TEtcodelengthdlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TEtcodelengthdlg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

end.
