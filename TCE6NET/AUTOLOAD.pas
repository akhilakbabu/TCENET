unit Autoload;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, GlobalToTcAndTcextra;

type
  Tautoloaddlg = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    procedure OKbuttonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  end;

var
  autoloaddlg: Tautoloaddlg;

implementation
uses tceload,tcommon,DlgCommon,tcommon2,tcommon3,main,tcommon5,tceglobals;
{$R *.DFM}

procedure Tautoloaddlg.OKbuttonClick(Sender: TObject);
var
 i:       smallint;
 msg:     shortstring;
begin
 i:=strtointdef(edit2.text,0);
 if ((i<1) or (i>600)) then
 begin
  msg:='Range for autoload time is 1 to 600 minutes.'+endline;
  msg:=msg+'Please check your entry.';
  messagedlg(msg,mtError,[mbOK],0);
  edit2.setfocus;
  edit2.selectall;
  exit;
 end;
 MouldyDataCheckTime:=i;
 mainform.timer1.interval:=(60*1000);
 saveUsers;
 close;
end;

procedure Tautoloaddlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure Tautoloaddlg.FormCreate(Sender: TObject);
begin
 edit2.text:=inttostr(MouldyDataCheckTime);
end;

end.
