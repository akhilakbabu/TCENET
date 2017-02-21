unit Manteach;

interface

uses WinTypes,SysUtils,WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Dialogs,TCEglobals;

type
  TAlreadyTeachingDlg = class(TForm)
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    GroupBox1: TGroupBox;
    CoverBtn: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MergeBtn: TBitBtn;
    Label6: TLabel;
    Edit1: TEdit;
    procedure MergeBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AlreadyTeachingDlg: TAlreadyTeachingDlg;

implementation

{$R *.DFM}
uses tcommon,tcommon2,tcommon3,excover;

procedure TAlreadyTeachingDlg.MergeBtnClick(Sender: TObject);
var
 room1,room2,room3:  integer;
 s,msg:              string;
begin
 room1:=Changes[myI].oldroom;
 if Changes[myI].newroom>0 then room1:=Changes[myI].newroom;
 room2:=AlreadyTeachingDlg.tag;
 s:=trim(edit1.text);
 if s='' then room3:=room2 else room3:=checkCode(2,s);
 msg:='';
 if (room3=0) then msg:='Check room code'
  else if (room3<>room1) and (room3<>room2) and ((roomon[room3] and (1 shl p))=0)
   then msg:='Room '+tecode[room3,1]+' is not available in '+TimeSlotName[ttDay,p-1];
 if msg>'' then
  begin
   messagedlg(msg,mtError,[mbOK],0);
   edit1.setfocus;
   edit1.SelectAll;
   exit;
  end;
  modalresult:=mrYes;
  edit1.tag:=room3;
end;

end.
