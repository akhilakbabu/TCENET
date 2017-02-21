unit Fndtedlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals;

type
  Tfindteacherdlg = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    ComboBox1: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKbuttonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  findteacherdlg: Tfindteacherdlg;

implementation
uses tcommon,tcommon2,tcommon3,findte;
{$R *.DFM}
var
 tmpint:  integer;

procedure Tfindteacherdlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure Tfindteacherdlg.OKbuttonClick(Sender: TObject);
var
 msg: string;
begin
 if tmpint>0 then
 begin
  tefindnum:=tmpint;  {selection}
 
  if not(wnFlag[wnFindTeach]) then FindTeWinSelect;
  FindTeacherWin.UpdateWin;
  close;
  FindTeacherWin.setfocus;
 end
 else
  begin  {none selected}
   msg:='No Teacher selected';
   messagedlg(msg,mtError,[mbOK],0);
  end;
end;

procedure Tfindteacherdlg.FormCreate(Sender: TObject);
var
 i,j: integer;
begin
 tmpint:=0;
 combobox1.clear;
 if codenum[1]>0 then
  for i:=1 to codenum[1] do
  begin
   j:=codepoint[i,1];
   combobox1.items.add(tecode[j,0]+' '+tename[j,0]);
  end;

end;

procedure Tfindteacherdlg.ComboBox1Change(Sender: TObject);
 var
  astr: string;
  j:    integer;
begin
 astr:=combobox1.text;
 j:=findaddedstaff(astr);
 if j>0 then tmpInt:=1000+ETpointer[j]
    else tmpInt:=checkCode(1,astr);
   if tmpInt=0 then label2.caption:='Enter teacher code'
    else if tmpInt>1000 then label2.caption:=ETname[tmpInt-1000]
     else label2.caption:=TeName[tmpInt,0];
end;

procedure Tfindteacherdlg.FormActivate(Sender: TObject);
begin
 combobox1.setfocus;
end;

end.
