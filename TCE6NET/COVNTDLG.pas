unit Covntdlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, GlobalToTcAndTcextra;

type
  Tcovernotesdlg = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    update: TBitBtn;
    finish: TBitBtn;
    BitBtn3: TBitBtn;
    mmNote: TMemo;
    cmbNo: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure mmNoteEnter(Sender: TObject);
    procedure cmbNoChange(Sender: TObject);
    procedure cmbNoKeyPress(Sender: TObject; var Key: Char);
  end;

var
  covernotesdlg: Tcovernotesdlg;

implementation
uses tcommon,DlgCommon,tcommon2,covnotes,tcommon3;
{$R *.DFM}
var
 needupdate: boolean;

procedure Tcovernotesdlg.FormCreate(Sender: TObject);

  procedure PopulateNoCombo;
  var
    i: integer;
  begin
    for i := 1 to nmbrreasons do
      cmbNo.AddItem(IntToStr(i),TObject(i));  
  end;

begin
 PopulateNoCombo;
 needupdate:=false;
 mmNote.maxlength:=500; //szCovNotes;
 if covernoteswin.selCode>0 then
 begin
  cmbNo.text:=inttostr(covernoteswin.selCode);
  mmNote.text:=Cover[covernoteswin.selCode];
 end
 else
  begin
   cmbNo.text:='';
   mmNote.text:='';
  end;
end;

procedure Tcovernotesdlg.mmNoteEnter(Sender: TObject);
begin
  mmNote.SelectAll;
end;

procedure Tcovernotesdlg.cmbNoKeyPress(Sender: TObject; var Key: Char);
begin
  allowNumericInputOnly(key);
end;

procedure Tcovernotesdlg.Edit3Change(Sender: TObject);
var
 nm:  integer;
begin
 nm:=strtointdef(edit3.text,0);
 if ((nm=0) or (nm>nmbrreasons)) then
 begin
  mmNote.text:='';
  exit;
 end;
 mmNote.text:=Cover[nm];

 if mmNote=activecontrol then mmNote.selectall;
end;

procedure Tcovernotesdlg.updateClick(Sender: TObject);
var
 nm:  integer;
 msg: string;
begin
 nm:=strtointdef(cmbNo.text,0);
 if ((nm=0) or (nm>nmbrreasons)) then
 begin
  msg:='Invalid Cover Note number.'+endline;
  msg:=msg+'Valid range is ('+inttostr(1)+'-'+inttostr(nmbrreasons)+')';
  messagedlg(msg,mtError,[mbOK],0);
  //edit3.setfocus; edit3.selectall;
  exit;
 end;
 Cover[nm]:=mmNote.text;

 calcCoverInUse;

 fwCoverNote:=getCoverNoteFontWidths(CoverNotesWin.canvas);
 CoverNotesWin.UpdateWin;
 needupdate:=true;
 {step up to next one}
 inc(nm);
 if nm<=nmbrreasons then
 begin
  cmbNo.ItemIndex := cmbNo.ItemIndex + 1;
  mmNote.Clear;
  mmNote.SetFocus;
 end;
end;

procedure Tcovernotesdlg.Edit3Enter(Sender: TObject);
begin
 edit3.selectall;
end;

procedure Tcovernotesdlg.cmbNoChange(Sender: TObject);
var
 nm:  integer;
begin
 nm:=strtointdef(cmbNo.text,0);
 if ((nm=0) or (nm>nmbrreasons)) then
 begin
  mmNote.text:='';
  exit;
 end;
 mmNote.text:=Cover[nm];

 if mmNote=activecontrol then mmNote.selectall;
end;

procedure Tcovernotesdlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if needupdate then savereasons;
end;

procedure Tcovernotesdlg.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

end.
