unit Tcgetdir;

interface
{$WARN UNIT_PLATFORM OFF}

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
   StdCtrls,dialogs,sysutils,TCEglobals,FileCtrl, XML.UTILS, GlobalToTcAndTcextra;

type
  TGetDirDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DataDirLabel: TLabel;
    DataDirEdit: TEdit;
    BitBtn1: TBitBtn;
    edtProgramDir: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure DataDirLabelDblClick(Sender: TObject);
    procedure BrowseForDirectory(Sender: TObject);
  end;

var
  GetDirDlg: TGetDirDlg;

implementation

uses
  tcommon, main, uAMGConst;

{$R *.DFM}

procedure TGetDirDlg.FormActivate(Sender: TObject);
begin
  try
    edtProgramDir.Text := Directories.progdir;
    {datadirlabel.caption:=progdir+'\DATA';   }
    if (Directories.progdir[length(Directories.progdir)]='\') then
      datadirlabel.Caption := Directories.progdir + 'DATA'
    else
      datadirlabel.Caption := Directories.progdir + '\DATA';
    datadiredit.text := Directories.datadir;
    datadiredit.selectAll;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure setDirectories;  {write out DIR.SYS }
var
 F:       textfile;
 S:       string;
begin
 if (usrPassLevel=0) then exit;
 try
  try
   chdir(usrPassDir);
   doAssignFile(F,'DIR.SYS');
   filemode:=fmOpenReadWrite+fmShareDenyWrite;
   rewrite(F);
   Writeln(F,Directories.progdir);
   Writeln(F,Directories.datadir);
   Writeln(F,DOSscreenmem);
  finally
   closefile(F);
   s:='The current data directory is set to:'+endline;
   s:=s+uppercase(Directories.datadir);
  end;
 except
 end;
end;

procedure TGetDirDlg.OKBtnClick(Sender: TObject);
var
  tmpStr,tempDir: string;
  helpContext: longint;
  ok: boolean;

  procedure ForceDirFile;
  var
    F: File;
  begin
    if Trim(usrPassDir) = '' then
    begin
      MessageDlg(AMG_MISSING_DISPLAY_DIR_MSG, mtError, [mbOk], 0);
    end
    else
    begin
      ChDir(usrPassDir);
      doAssignFile(F,'DIR.SYS');
      try
        FileMode := fmOpenReadWrite;
        Rewrite(F);
      finally
        CloseFile(F);
      end;
    end;
 end;

begin
 newdataloadcancel := False;
 ForceDirFile;
 tempDir := DataDirEdit.text;
 tempDir := Trim(tempDir);
 helpContext:=0;
   {$I-}
   chdir(tempDir);
   {$I+}
   if IOResult=0 then ok:=true else ok:=false;

{ If DirectoryExists(tempDir) then   }
 if ok then
   begin
     Directories.datadir:=tempDir;
     modalresult:=mrOK;
     setDirectories;
   end
 else
  begin
   {try to create , if can't - go back with msg.}
   {$I-}
 {  mkdir(tempDir); }
   {$I+}
   try
    ForceDirectories(tempDir);
   except

   end;
  { if IOResult=0 then     }
 { If DirectoryExists(tempDir) then }

   {$I-}
   chdir(tempDir);
   {$I+}

   if IOResult=0 then
   begin
    Directories.datadir:=tempDir;
    modalresult:=mrOK;
    setDirectories;
   end
   else
    begin
     {message box}
     tmpStr:='Could not create the directory:'+endline;
     tmpStr:=tmpStr+'<'+tempDir+'>.' +endline;
     tmpStr:=tmpStr+'Please select a different directory.';
     messagedlg(tmpStr,mtError,[mbOK],helpContext);
    end;
  end;
end;

procedure TGetDirDlg.CancelBtnClick(Sender: TObject);
begin
  newdataloadcancel:=true;
  getdirdlg.close;
end;

procedure TGetDirDlg.DataDirLabelDblClick(Sender: TObject);
begin
 DataDirEdit.text:=DataDirLabel.caption;
 DataDirEdit.selectall;
 DataDirEdit.setfocus;
end;

procedure TGetDirDlg.BrowseForDirectory(Sender: TObject);
//var
//  s: string;
//begin
//  s := datadir;
//  if not(SelectDirectory('Select New Data Directory', '', s, [sdNewFolder, sdShowEdit, sdNewUI])) then Exit;
//  if s > '' then  datadiredit.Text := s;
begin
  with TFileOpenDialog.Create(nil) do
  try
    Options := [fdoPickFolders];
    if Execute then
      datadiredit.text := FileName;
  finally
    Free;
  end;
end;

end.
