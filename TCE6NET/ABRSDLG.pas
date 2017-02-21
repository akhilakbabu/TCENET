unit Abrsdlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, GlobalToTcAndTcextra;

type
  TAbsReasondlg = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    update: TBitBtn;
    btnClose: TBitBtn;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
  end;

var
  AbsReasondlg: TAbsReasondlg;

implementation
uses tcommon,DlgCommon,tcommon2,absrsn,tcommon3;
{$R *.DFM}
var
 needupdate: boolean;

procedure TAbsReasondlg.FormCreate(Sender: TObject);
begin
 needupdate:=false;
 edit1.maxlength:= 10; // not resrestrainged any more since switch to XML szabcode;
 edit2.maxlength:=szAbReason;
 if AbsReasonWin.selCode>0 then
 begin
  edit3.text:=inttostr(AbsReasonWin.selCode);
  edit1.text:=Abcode[AbsReasonWin.selCode];
  edit2.text:=Absent[AbsReasonWin.selCode];
 end
 else
  begin
   edit3.text:='1';
   edit1.text:=Abcode[1];
   edit2.text:=Absent[1];
  end;
end;

procedure TAbsReasondlg.Edit3Change(Sender: TObject);
var
 nm:  integer;
begin
 nm:=strtointdef(edit3.text,0);
 if ((nm=0) or (nm>nmbrreasons)) then
 begin
  edit1.text:=''; edit2.text:='';
  exit;
 end;
 edit1.text:=Abcode[nm];
 edit2.text:=Absent[nm];

 if edit1=activecontrol then edit1.selectall;
 if edit2=activecontrol then edit2.selectall;
end;

procedure TAbsReasondlg.updateClick(Sender: TObject);
var
 nm:  integer;
 msg: string;
begin
 nm:=strtointdef(edit3.text,0);
 if ((nm=0) or (nm>nmbrreasons)) then
 begin
  msg:='Invalid Reason number.'+endline;
  msg:=msg+'Valid range is ('+inttostr(1)+'-'+inttostr(nmbrreasons)+')';
  messagedlg(msg,mtError,[mbOK],0);
  edit3.setfocus; edit3.selectall;
  exit;
 end;
 Abcode[nm]:=edit1.text;
 Absent[nm]:=edit2.text;

 calcReasonsInUse;
 fwAbsence:=getAbsenceFontWidths(AbsReasonWin.canvas);
 AbsReasonWin.UpdateWin;
 UpdateExtrasWins;
 needupdate:=true;
 {step up to next one}
 inc(nm);
 if nm<=nmbrreasons then
  edit3.text:=inttostr(nm);

end;

procedure TAbsReasondlg.Edit1Enter(Sender: TObject);
begin
 edit1.selectall;
end;

procedure TAbsReasondlg.Edit2Enter(Sender: TObject);
begin
 edit2.selectall;
end;

procedure TAbsReasondlg.Edit3Enter(Sender: TObject);
begin
 edit3.selectall;
end;

procedure TAbsReasondlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if needupdate then saveReasons;
end;

procedure TAbsReasondlg.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

end.
