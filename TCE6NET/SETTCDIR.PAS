unit Settcdir;

interface
{$WARN UNIT_PLATFORM OFF}
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, FileCtrl, ExtCtrls;

type
  TsetTc4wnetDirDlg = class(TForm)
    GroupBox1: TGroupBox;
    Bevel2: TBevel;
    Label17: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    CheckBox1: TCheckBox;
    procedure CheckBox1Click(Sender: TObject);
    procedure OKbuttonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelbuttonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  setTc4wnetDirDlg: TsetTc4wnetDirDlg;

implementation
uses tceload,tcommon,tcommon2,tcommon3,tceglobals,tcommon5;
{$R *.DFM}

procedure TsetTc4wnetDirDlg.CheckBox1Click(Sender: TObject);
begin
 directorylistbox1.enabled:=checkbox1.checked;
 drivecombobox1.enabled:=checkbox1.checked;
{ okbutton.enabled:=checkbox1.checked;}
end;

procedure TsetTc4wnetDirDlg.OKbuttonClick(Sender: TObject);
var
 tmpStr: shortstring;
begin
 usingTCnet:=checkbox1.checked;
 tmpStr:=directoryListBox1.directory;
 if validateNetTcProgDir(tmpStr) then
 begin
  tcNETprogdir:=tmpStr;
  close;
 end;
 {changed to conditional close - must have valid dir}
end;

procedure TsetTc4wnetDirDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 saveUsers;
end;

procedure TsetTc4wnetDirDlg.CancelbuttonClick(Sender: TObject);
begin
 close;
end;

procedure TsetTc4wnetDirDlg.FormCreate(Sender: TObject);
begin
 try  {incase invalid dir}
  directoryListBox1.directory:=tcNETprogdir;
 except

 end;
 checkbox1.checked:=usingTCnet;
end;

end.
