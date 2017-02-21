unit Fndrodlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals;

type
  Tfindroomdlg = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    ComboBox1: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OKbuttonClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  findroomdlg: Tfindroomdlg;

implementation
uses tcommon,tcommon2,tcommon3,findro;
{$R *.DFM}
var
 tmpint:  integer;


procedure Tfindroomdlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure Tfindroomdlg.FormCreate(Sender: TObject);
var
 i,j: integer;
begin
 tmpint:=0;
 combobox1.clear;
 if codenum[2]>0 then
  for i:=1 to codenum[2] do
  begin
   j:=codepoint[i,2];
   combobox1.items.add(tecode[j,1]+' '+tename[j,1]);
  end;
 
end;

procedure Tfindroomdlg.OKbuttonClick(Sender: TObject);
var
 msg: string;
begin
 if tmpint>0 then
 begin
  rofindnum:=tmpint;  {selection}
 
  if not(wnFlag[wnFindRoom]) then
   FindroWinSelect;
  FindRoomWin.UpdateWin;
  close;
  FindroomWin.setfocus;
 end
 else
  begin  {none selected}
   msg:='No Room selected';
   messagedlg(msg,mtError,[mbOK],0);
  end; 
end;

procedure Tfindroomdlg.ComboBox1Change(Sender: TObject);
var
 astr: string;
begin
 astr:=combobox1.text;
 tmpInt:=CheckCode(2,astr);
 if tmpInt>0 then
  Label2.caption:=TeCode[tmpInt,1]+' '+TeName[tmpInt,1]
 else
  Label2.caption:='Enter room code';
end;

procedure Tfindroomdlg.FormActivate(Sender: TObject);
begin
 combobox1.setfocus;
end;

end.
