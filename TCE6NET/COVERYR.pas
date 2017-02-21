unit Coveryr;

interface

uses WinTypes,SysUtils, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls,TCEglobals, GlobalToTcAndTcextra;

type
  TCoverYearsDlg = class(TForm)
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    update: TBitBtn;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure updateClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  end;

var
  CoverYearsDlg: TCoverYearsDlg;

implementation

uses tcommon,tcommon2,tcommon3;

var
 yearCheckBox:    array[1..nmbrYears] of TCheckBox;
 UsingResources:  boolean;

{$R *.DFM}

procedure TCoverYearsDlg.FormCreate(Sender: TObject);
var
 j: integer;
begin
 Caption:='Auto Cover - '+yeartitle;
 Groupbox1.Caption:='Set '+yeartitle+'s to automatically cover';
 Update.hint:='Set '+yeartitle+'s to include in auto cover';

 edit1.maxlength:=szIgnoreStatusMsg;
 for j:=1 to years do
 begin
  yearCheckBox[j]:=tCheckBox.create(application);
  yearCheckBox[j].parent:=Groupbox1;
  yearCheckBox[j].hint:='Check to auto cover '+yeartitle+' '+yearname[j-1];
  yearCheckBox[j].showhint:=true;
  yearCheckBox[j].caption:=yearname[j-1];
  yearCheckBox[j].enabled:=true;
  yearCheckBox[j].width:=140;  yearCheckBox[j].height:=13;
  yearCheckBox[j].left:=14+((j-1) mod 3)*170;;
  yearCheckBox[j].top:=22+((j-1) div 3)*27;
  yearCheckBox[j].checked:=coverYear[j-1];
 end;
 edit1.text:=Trim(IgnoreStatusMsg);
 checkbox1.checked:=IgnoreStatusMsgFlag;

 UsingResources:=true;
end;

procedure TCoverYearsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
 j: integer;
begin
action:=caFree;
if usingResources then
 begin
  usingResources:=false;
  CoverYearsDlg.hide; {prevent seeing controls beeing removed -slows things down a lot}
  for j:=1 to years do yearCheckBox[j].free;
 end;
end;

procedure TCoverYearsDlg.updateClick(Sender: TObject);
var
 j: integer;
begin
 for j:=1 to years do
  coverYear[j-1]:=YearCheckBox[j].checked;

 IgnoreStatusMsg:=Trim(edit1.text);
 IgnoreStatusMsgFlag:=checkbox1.checked;

 UpdateWindow(wnCurrentExtras);
end;

procedure TCoverYearsDlg.BitBtn1Click(Sender: TObject);
var
 i: integer;
begin
{clear Ignores for all changes}
 for i:=1 to numchanges do
  if Changes[i].kind>=10 then Changes[i].kind:=Changes[i].kind-10;
 UpdateAllWins;
end;

end.
