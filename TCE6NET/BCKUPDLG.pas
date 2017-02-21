unit Bckupdlg;
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, FileCtrl, Buttons,TCEglobals, ComCtrls, Grids,
  DirOutln, XML.UTILS, GlobalToTcAndTcextra;

type
  TBackupDataDlg = class(TForm)
    finish: TBitBtn;
    help: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Animate1: TAnimate;
    Button1: TButton;
    Label4: TLabel;
    Update: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
   function SpaceToCopy:boolean;
   procedure CopyMyFiles;
  public
    { Public declarations }
  end;

var
  BackupDataDlg: TBackupDataDlg;

implementation

uses tcommon,tceload,tcommon2,Addstaff;
{$R *.DFM}

const
 NumToCopy=11;
 FilesToCopy: array[1..NumToCopy] of string=('COVERSET.DAT','EXFILE.DAT',
    'EMTEACH.DAT','TEAVAIL.DAT','REASON.DAT','EXALLOT.DAT','ABSENT.DAT',
    'EMAILSETUP.DAT','TEMAIL.DAT','ETMAIL.DAT', 'ABSNHIST.DAT');
 CopyDesc: array[1..NumToCopy] of string=('cover weights','extras file in use',
    'Added Staff','Teacher Tallies','Absence Reasons','Time Allotments','Past Extras',
    'Email Setup','Teacher Email addresses','Added Staff Email addresses', 'Teachers Absence History');
 NumOfExt=2;
 ExtToCopy: array[1..NumOfExt] of string=('XTR','CUS');
 ExtDesc: array[1..NumOfExt] of string=('Extras file','Custom file');

var
 DsksizeGOT,DsksizeNEED: int64;
 TOdir,FROMdir:   string;
 TOdir1,FROMdir1: string;
 msg:             string;
 CopyComplete:    boolean;
 instRslt:      bool;


procedure checkFsize(fileToChck: ansistring);
var
 ff: file;
begin
 if fileexists(fileToChck) then
  try
   try
    doAssignFile(ff,fileToChck);
    reset(ff,1);
    inc(DsksizeNEED,filesize(ff));
   finally
    closefile(ff);
   end;
  except
  end;
end;

procedure allowForExistingFsize(fileToChck: ansistring);
var
 ff: file;
begin
 fileToChck:=TOdir1+fileToChck;
 if fileexists(fileToChck) then
  try
   try
    doAssignFile(ff,fileToChck);
    reset(ff,1);
    dec(DsksizeNEED,filesize(ff));
   finally
    closefile(ff);
   end;
  except
  end;
end;


procedure TBackupDataDlg.FormCreate(Sender: TObject);
var
 myBack: integer;
begin
 myBack:=backup_number;
 case backup_action of
  1: begin
      Caption:='Backup Data';
      label2.caption:='Backup Data disk number '+inttostr(backup_number);
      HelpContext:=118;
     end;
  2: begin
      Caption:='Restore Data from Backup';
      dec(myBack);
      if myBack<1 then myBack:=nmbrBackupDisks;
      label2.caption:='Last Backup disk number '+inttostr(myBack);
      HelpContext:=119;
     end;
 end;
 label1.caption:='';
 label4.caption:=backupDir;
end;


procedure doMyCopy(fileToBkup:ansistring);
begin
 instRslt:=copyfile(Pchar(FROMdir1+fileToBkup),Pchar(TOdir1+fileToBkup),false);
end;


procedure TBackupDataDlg.CopyMyFiles;
var
 i: integer;
 fsRec:         Tsearchrec;
 kkk:           longword;
 a:             string;
begin
 animate1.commonAVI:=aviCopyFiles;
 animate1.visible:=true; animate1.active:=true;
 if backup_action=1 then a:='Backup' else a:='Restore';
 instRslt:=true;
 chdir(FROMdir);
 for i:=1 to NumToCopy do
  if fileexists(FilesToCopy[i])then
   begin
    label1.caption:='Copying '+CopyDesc[i]+' ...';
    repaint;
    doMyCopy(FilesToCopy[i]);
    if not(instRslt) then break;
   end;

 if instRslt then
  for i:=1 to NumOfExt do
   begin
    fsrec.name:='';
    findfirst(FROMdir1+'*.'+ExtToCopy[i],faArchive,fsRec);
    while (fsRec.name>'') do
     begin
      label1.caption:='Copying '+ExtDesc[i]+' ... ['+fsRec.name+']';
      repaint;
      doMyCopy(fsRec.name);
      if not(instRslt) then break;
      if findnext(fsRec)<>0 then fsrec.name:='';
     end; {while}
    SysUtils.findclose(fsRec);
    if not(instRslt) then break;
   end;

 if not(instRslt) then
   begin
    kkk:=GetLastError();
    animate1.visible:=false; animate1.active:=false;
    msg:=space(250);
    FormatMessage((FORMAT_MESSAGE_FROM_SYSTEM),Nil,kkk,0,pchar(msg),250,Nil);
    msg:=trim(msg);
    messagedlg(msg,mtInformation,[mbOK],0);

    msg:=a+' encountered errors.'+endline;
    msg:=msg+a+' of Time Chart Extra Data is NOT COMPLETE.';
    messagedlg(msg,mtInformation,[mbOK],0);
   end;

 CopyComplete:=instRslt;

end;

function TBackupDataDlg.SpaceToCopy:boolean;
var
 i: integer;
 a1,a2:         double;
 fsRec:         Tsearchrec;
begin
 result:=false;
 finish.enabled:=false; update.enabled:=false; help.enabled:=false;
 FROMdir1:=FROMdir; TOdir1:=TOdir;
 if TOdir1[length(TOdir1)]<>'\' then TOdir1:=TOdir1+'\';
 if FROMdir1[length(FROMdir1)]<>'\' then FROMdir1:=FROMdir1+'\';

 chdir(TODir);
 {$I-}
 DsksizeGOT:=diskfree(0);
 {$I+}

 if DsksizeGOT=-1 then exit; {invalid drive specified}

 if DsksizeGOT=0 then
 begin
  msg:='There is no free space available on '+TODir+endline;
  if backup_action=1 then
       msg:=msg+'Please insert another disk or select a different Drive.';
  exit;
 end; {**** disk full ****}

 {check how much disk space is needed}
 animate1.commonAVI:=aviFindFolder;
 animate1.visible:=true; animate1.active:=true;
 label1.caption:='Checking disk space required ...';
 repaint;
 chdir(FROMdir);
 DsksizeNEED:=0;
 for i:=1 to NumToCopy do
   checkFsize(FilesToCopy[i]);

 for i:=1 to NumOfExt do
  begin
   fsrec.name:='';
   findfirst(FROMdir1+'*.'+ExtToCopy[i],faArchive,fsRec);
   while (fsRec.name>'') do
    begin
     checkFsize(fsRec.name);
     allowForExistingFsize(fsRec.name);
     if findnext(fsRec)<>0 then fsrec.name:='';
    end; {while}
   SysUtils.findclose(fsRec);
  end;

 {check how much disk space we've got}
  animate1.commonAVI:=aviFindComputer;
 animate1.visible:=true; animate1.active:=true;
 label1.caption:='Checking disk space available ...';
 repaint;

 for i:=1 to NumToCopy do
   allowForExistingFsize(FilesToCopy[i]);

 if DsksizeGOT<DsksizeNEED then
   begin
    a1:=DsksizeNEED; a2:=DsksizeGOT;
    msg:='Insufficient disk space available on the destination drive.'+endline;
    msg:=msg+Format('The data requires %9.0n bytes and only %9.0n bytes are available',
               [a1,a2]);
    msg:=msg+' on '+TODir;
    exit;
   end;
 result:=true;
end;

procedure updatebackupfile;
var
  TempList: Tstrings;
begin
 chdir(Directories.progdir);
 TempList := TStringList.Create;	{ construct the list object }
 try
  TempList.Add(inttostr(backup_number));
  TempList.Add(BackupDir);
  TempList.SaveToFile('EXBACK.DAT');
 finally
  TempList.Free;
 end;
end;


procedure TBackupDataDlg.updateClick(Sender: TObject);
var
 nextNum: smallint;
begin
 msg:='';  CopyComplete:=false;
 nextNum:=backup_number;
 screen.cursor:=crhourglass;
 try
  case backup_action of
   1: begin
       FROMdir:=Directories.datadir; TOdir:=BackupDir;
       inc(nextNum);
       if nextNum<1 then nextNum:=1;
       if nextNum>nmbrBackupDisks then nextNum:=1;
      end;
   2: begin
       FROMdir:=BackupDir; TOdir:=Directories.datadir;
      end;
  end;

 if SpaceToCopy then CopyMyFiles;

 if msg>'' then messagedlg(msg,mtError,[mbok],0);

 if not(CopyComplete) then
  begin
   label1.caption:='';
   BackupDataDlg.animate1.commonAVI:=aviCopyFiles;
   BackupDataDlg.animate1.active:=false; BackupDataDlg.animate1.visible:=false;
   finish.enabled:=true; update.enabled:=true; help.enabled:=true;
   exit;
  end; {**** unsuccessful ****}


 if backup_action=2 then {restore}
  begin
   saveWinDisplay;
   Directories.textdir:=Directories.datadir;
   Directories.timedir:=Directories.datadir;
   chdir(Directories.datadir);
   About.firstLoad;
   CheckWinSelections;
   UpdateAllWins;
  end;
 finally
  screen.cursor:=crDefault;
 end; {try}

 backup_number:=nextNum;
 updatebackupfile;
 close;
end;

procedure TBackupDataDlg.Button1Click(Sender: TObject);
var
 s,msg: string;
begin
  msg:='';
  if not(SelectDirectory('Select Backup Directory','',s, [sdNewFolder, sdShowEdit, sdNewUI])) then
    Exit;
  if s = Directories.datadir then
    msg := 'Cannot backup to data folder ';
  if s = Directories.progdir then
    msg:='Cannot backup to program folder ';
  if msg > '' then
  begin
    messagedlg(msg,mtError,[mbok],0);
    exit;
  end;
  if directoryexists(s) then
  begin
    label4.Caption := s;
    BackupDir := s;
   end;
end;

end.
