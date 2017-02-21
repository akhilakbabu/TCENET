unit Gtsprpss;

interface
{$WARN UNIT_PLATFORM OFF}
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, FileCtrl,XML.UTILS,
  GlobalToTcAndTcextra, XML.USERS;

type
  TgetSuperPasswordDlg = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    Label4: TLabel;
    Label1: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    Bevel2: TBevel;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure OKbuttonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FDefaultDir: string;
  end;

var
  getSuperPasswordDlg: TgetSuperPasswordDlg;

implementation

uses
  tceload,tcommon,tcommon2,tcommon3,tcommon4,tceglobals,tcommon5;

{$R *.DFM}

procedure TgetSuperPasswordDlg.FormCreate(Sender: TObject);
begin
  edit1.maxlength := szPassword;
  edit2.maxlength := szPassword;
  edit3.maxlength := szPassID;
  FDefaultDir := Directories.ProgDir + '\Users\Supervisor';
  if not DirectoryExists(FDefaultDir) then
    ForceDirectories(FDefaultDir);
  directoryListBox1.Directory := Directories.ProgDir;
  MouldyDataCheckTime := 30;
end;

procedure TgetSuperPasswordDlg.FormShow(Sender: TObject);
begin
  edit3.SetFocus;
  if DirectoryExists(FDefaultDir) then
    DirectoryListBox1.Directory := FDefaultDir;
  Label20.Caption := FDefaultDir;
end;

procedure TgetSuperPasswordDlg.OKbuttonClick(Sender: TObject);
var
 m: smallint;
 msg:  shortstring;
 pass1,passID2: shortstring;
begin
 if trim(edit3.text)='' then
 begin
  msg:='Supervisor ID is required!';
  messagedlg(msg,mtError,[mbOK],0);
  edit3.selectall;
  edit3.setfocus;
  exit;
 end;
 if trim(edit1.text)='' then
 begin
  msg:='Password is required!';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.selectall;
  edit1.setfocus;
  exit;
 end;
 if trim(uppercase(edit1.text))<>trim(uppercase(edit2.text)) then
 begin
  msg:='Confirm word does not match password.';
  msg:=msg+endline+'Please Re-enter';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.text:=''; edit2.text:='';
  edit1.selectall;
  edit1.setfocus;
  exit;
 end;

  if not(ForceDirectories(FDefaultDir)) then
  begin
    msg := 'Could not create default display directory. Please select Supervisor directory.';
    MessageDlg(msg, mtError, [mbOK], 0);
    DirectoryListBox1.SetFocus;
    Exit;
  end;

 m:=verifyUserDirectory(DirectoryListBox1.Directory);
 if m<>0 then
 begin
  msg:='Directory for storing display file'+endline;
  case m of
   1: msg:=msg+'should NOT be the same as the program directory.';
   2: msg:=msg+'should NOT be the same as the data directory.';
   3: msg:=msg+'must ALREADY exist.';
   4: msg:=msg+'must be set to allow read and write access.';
  end; {case}
  msg := msg + endline +' Please Re-select the directory.';
  messagedlg(msg, mtError, [mbOK], 0);
  directoryListBox1.setfocus;
  exit;
 end;

 usrPasslevel:=6; {supervisor}
 usrPassyear:=-1; {all years}
 usrPassID:=trim(uppercase(edit3.text));
 usrPassuse:=1;
 usrPassword:=trim(uppercase(edit1.text));
 pass1:=FNencrypt(RpadString(usrPassword,szPassword));
 passID2:=FNencrypt(RpadString(usrPassID,szPassID));

 usrPassDir:=directoryListBox1.directory;
 usrPassRecord:=1;
 UserRecordsCount:=1;

 passLevel[1]:=usrPasslevel;
 passYear[1]:=usrPassyear;
 passID[1]:=usrPassID;
 password[1]:=usrPassword;

 passUserDir[1]:=usrPassDir;
 {for convenience, check for old TCP2.DAT and load if there}
 chdir(Directories.progdir);

/// if fileexists('TCP2.DAT') then loadOLDUsers;
 if SaveUsers then
   Close;
end;

end.


