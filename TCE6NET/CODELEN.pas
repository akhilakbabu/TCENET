unit Codelen;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, XML.UTILS, GlobalToTcAndTcextra;

type
  Tcodelendlg = class(TForm)
    finish: TBitBtn;
    update: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure finishClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  end;

var
  codelendlg: Tcodelendlg;

implementation

uses tcommon,DlgCommon,TeWnd;

procedure checkCodelengths; forward;

{$R *.DFM}

var
 old_lenCodes:  integer;
 Tsub: array[0..nmbrSubjects] of string[szSubCode];
 codeDouble:    boolean;
 Code,szCode:   integer;

function codelengths:boolean;
var
 i: integer;
 cl: integer;
 A:     string;
 tmpfile:       file;
 tmpfilename:   string;
 msg: string;
begin
 result:=false;
 old_lencodes:=lencodes[code];
 cl:=strtointdef(codelendlg.edit1.text,0);
 if ((cl<2) or (cl>szCode)) then
 begin
  msg:='Invalid code length. ';
  msg:=msg+endline+'Enter a value in the range '+inttostr(2)+' to ' +inttostr(szCode)+'.';
  messagedlg(msg,mtError,[mbOK],0);
  codelendlg.edit1.setfocus;
  exit;
 end;
 lencodes[code]:=cl;
 checkcodelengths;
 if codeDouble then lencodes[code]:=old_lencodes;
 if old_lencodes=lencodes[code] then exit;
 result:=true;
 if code=0 then tmpfilename:='SUBCODE.DAT';
 if code=1 then tmpfilename:='TECODE.DAT';
 if code=2 then tmpfilename:='ROOMS.DAT';
 if numCodes[code]>0 then
 begin
  if old_lencodes<lencodes[code] then
  begin
   A:=space(lencodes[code]-old_lencodes);
   if code=0 then
    for i:=1 to numcodes[code] do
     SubCode[i]:=SubCode[i]+A;
   if code>0 then
    for i:=1 to numcodes[code] do
     TeCode[i,code-1]:=TeCode[i,code-1]+A;
  end
   else
    begin
     if code=0 then
      for i:=1 to numcodes[code] do
       SubCode[i]:=copy(SubCode[i],1,lencodes[code]);
     if code>0 then
      for i:=1 to numcodes[code] do
       TeCode[i,code-1]:=copy(TeCode[i,code-1],1,lencodes[code]);
    end; {else}
 end; {if numcodes[code]>0}
 doAssignFile(tmpfile,tmpfilename);
 filemode:=fmOpenReadWrite+fmShareDenyWrite;
 rewrite(tmpfile,1);
 blockwrite(tmpfile,numcodes[code],2);
 blockwrite(tmpfile,lencodes[code],2);
 if numcodes[code]>0 then
  for i:=1 to numcodes[code] do
  begin
   A:=FNsub(i,code);
   A:=RpadString(A,lencodes[code]);
   blockwrite(tmpfile,A[1],lencodes[code]);
  end;
 closefile(tmpfile);
end;

procedure sortcodes(code: integer);
var
 D,H,I,J,L:     integer;
 astr:          string[szSubCode];
label lab1,lab2,lab3;
begin
 D:=1;
 lab1:
 D:=D+D;
 if D<codenum[code] then goto lab1;
 lab3:
 D:=(D-1) div 2;
 if D=0 then exit;
 H:=codenum[code]-D;
 for I:=1 to H do
 begin
  J:=I;
  lab2:
  L:=J+D;
  if (Tsub[L]<Tsub[j]) then
  begin
   astr:=Tsub[L]; Tsub[L]:=Tsub[J];Tsub[J]:=astr;
   J:=J-D;
   if J>0 then goto lab2;
  end;
 end; {next}
 goto lab3;
end;



procedure checkCodelengths;
var
 i,j,x,y:     integer;
 A:     string;
 msg:   string;
begin
 codeDouble:=false;
 if lencodes[code]>=old_lencodes then exit;
 for i:=1 to codenum[code] do
 begin
  A:=FNsub(codepoint[i,code],code);
  Tsub[i]:=copy(A,1,lencodes[code]);
 end;
 sortcodes(code);
 for i:=1 to (codenum[code]-1) do
  for j:=(i+1) to codenum[code] do
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
  x:=codelendlg.left;y:=codelendlg.top+codelendlg.height;
  if codelendlg.top>(screen.height div 2) then y:=y-2*codelendlg.height;
  msg:='Reduction of '+codename[code]+' codes will create identical codes.';
  msg:=msg+endline+'Please enter a different value.';
  messagedlgPos(msg,mtError,[mbOK],0,x,y);
  codelendlg.edit1.setfocus;
  exit;
 end;
end;


procedure Tcodelendlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure Tcodelendlg.FormActivate(Sender: TObject);
begin
 code:=self.tag-1;
 if code=0 then szCode:=szSubCode else szCode:=szTeCode;
 edit1.text:=inttostr(lencodes[code]);
 label2.caption:=inttostr(lencodes[code]);
 codelendlg.caption:=codenameCap[code]+' code lengths';
 edit1.setfocus;
end;

procedure Tcodelendlg.updateClick(Sender: TObject);
begin
 if codelengths then
 begin
   getCodeFontWidths(0);
   if wnFlag[wnTeCode] then TeWindow.UpdateWin;
   close;
 end
 else if old_lencodes=lencodes[code] then close;
end;

procedure Tcodelendlg.finishClick(Sender: TObject);
begin
 close;
end;

procedure Tcodelendlg.FormCreate(Sender: TObject);
begin
 topcentre(self);
end;

procedure Tcodelendlg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;



end.
