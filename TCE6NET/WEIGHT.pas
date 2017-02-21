unit Weight;

interface

uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Forms,
     Controls, Dialogs, Buttons, StdCtrls,TCEglobals;

type
  TWeightDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Edit3: TEdit;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Edit4: TEdit;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    Label8: TLabel;
    Edit8: TEdit;
    Label9: TLabel;
    Edit9: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    Label12: TLabel;
    Edit12: TEdit;
    Label13: TLabel;
    Edit13: TEdit;
    Label14: TLabel;
    Edit14: TEdit;
    Label15: TLabel;
    KeepReplace: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit14KeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
  end;

var
  WeightDlg: TWeightDlg;

implementation

uses tcommon,DlgCommon,tcommon2;

{$R *.DFM}

procedure TWeightDlg.FormCreate(Sender: TObject);
begin
 edit1.text:=inttostr(WtET);
 edit2.text:=inttostr(WtETfac);
 edit3.text:=inttostr(WtReplace);
 edit4.text:=inttostr(WtLieu);
 edit5.text:=inttostr(WtAvail);
 edit6.text:=inttostr(WtPerc);
 edit7.text:=inttostr(WtFrees);
 edit8.text:=inttostr(WtSpare);
 edit9.text:=inttostr(Wtfac);
 edit10.text:=inttostr(WtPrefer);
 edit11.text:=inttostr(WtToday);
 edit12.text:=inttostr(WtWeek);
 edit13.text:=inttostr(WtLast);
 edit14.text:=inttostr(WtLastNum);
 KeepReplace.Checked:=KeepReplaceFlag;
end;

procedure TWeightDlg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if (key<'0') or (key>'9') then if (ord(key)>32) and (key<>'-') then key:=chr(0);
end;

procedure TWeightDlg.Edit14KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TWeightDlg.OKBtnClick(Sender: TObject);
var
 a: smallint;
begin
 if InvalidEntry(a,0,10,'number of days',edit14) then exit;
 WtET:=strtointdef(edit1.text,0);
 WtETfac:=strtointdef(edit2.text,0);
 WtReplace:=strtointdef(edit3.text,0);
 WtLieu:=strtointdef(edit4.text,0);
 WtAvail:=strtointdef(edit5.text,0);
 WtPerc:=strtointdef(edit6.text,0);
 WtFrees:=strtointdef(edit7.text,0);
 WtSpare:=strtointdef(edit8.text,0);
 Wtfac:=strtointdef(edit9.text,0);
 WtPrefer:=strtointdef(edit10.text,0);
 WtToday:=strtointdef(edit11.text,0);
 WtWeek:=strtointdef(edit12.text,0);
 WtLast:=strtointdef(edit13.text,0);
 WtLastNum:=a;
 KeepReplaceFlag:=KeepReplace.Checked;
 saveCoverData;

 modalResult:=mrOK;
end;

end.
