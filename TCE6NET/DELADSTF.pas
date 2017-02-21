unit Deladstf;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, GlobalToTcAndTcextra;

type
  Tdeleteaddedstaff = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    finish: TBitBtn;
    update: TBitBtn;
    BitBtn3: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    next: TBitBtn;
    previous: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure previousClick(Sender: TObject);
    procedure nextClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  deleteaddedstaff: Tdeleteaddedstaff;

implementation

uses
  tcommon, tcommon2, addstaff, tcommon3, tcommon4;

{$R *.DFM}

var
 needupdate:                          boolean;

procedure Tdeleteaddedstaff.FormCreate(Sender: TObject);
var
 i: integer;
begin
 TopCentre(self);
 edit1.maxlength:=lencodes[1];
 if addedstaffwin.selcode>0 then
 begin
  i:=Etpointer[addedstaffwin.selcode];
  edit1.text:=Trim(etsub[i]);
  label7.caption:=ETname[i];
  label8.caption:=Etcomment[i];
  if ETfaculty[i]=-1 then label9.caption:='All faculties'
   else label9.caption:=facname[ETfaculty[i]];
 end
 else
  begin
   edit1.text:='';
   label7.caption:=''; label8.caption:=''; label9.caption:='';
  end;
 label6.caption:=inttostr(ETnum1);
 needupdate:=false;
end;

procedure Tdeleteaddedstaff.Edit1Change(Sender: TObject);
var
 i,j: integer;
begin
 j:=findaddedstaff(edit1.text);
 i:=Etpointer[j];
 if i>0 then
 begin
  label7.caption:=ETname[i];
  label8.caption:=Etcomment[i];
  if ETfaculty[i]=-1 then label9.caption:='All faculties'
   else label9.caption:=facname[ETfaculty[i]];
 end
 else
  begin
   label7.caption:=''; label8.caption:=''; label9.caption:='';
  end;

 previous.enabled:=(j>1);
 next.enabled:=(j<etnum1);
end;

procedure Tdeleteaddedstaff.updateClick(Sender: TObject);
var
 msg,b:   string;
 i,j:     integer;
begin
 j:=findaddedstaff(edit1.text);
 i:=Etpointer[j];
 if i=0 then
 begin
  msg:='Code not found+'+endline;
  msg:=msg+'Please try another code.';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.selectall;
  edit1.setfocus;
  exit
 end;
 b:=copy(Trim(edit1.text),1,2);
 if b='00' then
 begin
  msg:='00 codes are already deleted'+endline;
  msg:=msg+'Please try another code.';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.selectall;
  edit1.setfocus;
  exit
 end;
 if bool(etavail[i]) then
 begin
  msg:='This teacher is selected - remove selection before deleting';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.selectall;
  edit1.setfocus;
  exit
 end;
 etsub[i]:=stringpadchr(ETLencodes,'0');
 ETname[i]:=Space(szecomment);
 Etcomment[i]:='     ';
 ETfaculty[i]:=0;  ETmail[i]:='';

 if i=ETnum then dec(ETnum);
{ sortascodes; }
 etsort2;      etsort3;    updateTelink;
 label6.caption:=inttostr(ETnum1);
 getAddedStaffFontWidths;
 UpdateExtrasWins;
 needupdate:=true;
 if j<etnum1 then edit1.text:=etsub[Etpointer[j]]
  else edit1.text:='';
 edit1.selectall;
 edit1.setfocus;
end;

procedure Tdeleteaddedstaff.previousClick(Sender: TObject);
var
 i:     integer;
begin
 i:=findaddedstaff(edit1.text);
 edit1.text:=etsub[Etpointer[i-1]];
end;

procedure Tdeleteaddedstaff.nextClick(Sender: TObject);
var
 i:     integer;
begin
 i:=findaddedstaff(edit1.text);
 edit1.text:=etsub[Etpointer[i+1]];
end;

procedure Tdeleteaddedstaff.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if needupdate then etout;
end;

end.
