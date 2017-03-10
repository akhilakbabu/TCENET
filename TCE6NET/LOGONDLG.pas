unit Logondlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, Menus, XML.UTILS, GlobalToTcAndTcextra, XML.USERS;

type
  TLoggingonDlg = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    Label2: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure OKbuttonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject);
  end;

var
  LoggingonDlg: TLoggingonDlg;

implementation
uses tceload,tcommon,tcommon2,tcommon3,tceglobals,tcommon5,Main;
{$R *.DFM}
var
 passWordTries:     smallint;

procedure TLoggingonDlg.FormClose(Sender: TObject);
var
msgret: word;
msg: string;
begin

If MessageDlg('Invalid Login - Exit Time Chart Extra?', mtError,[mbOK],0) = mrOK then
   Application.Terminate;
   OKquitcheck :=True;
   MainForm.Close;    //mantis-1621


end;

procedure TLoggingonDlg.FormActivate(Sender: TObject);
begin
  {$IFDEF DEBUG}
  edit1.text := 'bg';
  edit3.text := 'bg';
  {$ENDIF}
end;

procedure TLoggingonDlg.FormCreate(Sender: TObject);
begin
 passWordTries:=0;
 edit1.maxlength:=szPassword;
 edit3.maxlength:=szPassID;
end;

procedure TLoggingonDlg.OKbuttonClick(Sender: TObject);
var
 found,passfound: bool;
 f:               file;
 i, _UserIndex:           smallint;
 a,b,vcheck:             smallint;
 astr,bstr,cstr,dstr,msg:       shortstring;
begin
 if ((trim(edit1.text)='') or (trim(edit3.text)='')) then begin
  close;
  exit;
 end;
 found:=false; passfound:=false;
 usrPassword:=trim(uppercase(edit1.text));
 usrPassID:=trim(uppercase(edit3.text));          
 passfound  := XML_USERS.FindIdexPassword(usrPassword) >= 0;
 _UserIndex := XML_USERS.FindIdexUserPassword(usrPassID, usrPassword);
 if _UserIndex >=0 then  begin
   usrPassLevel := passlevel[_UserIndex];
   usrPassyear  := passYear[_UserIndex];
   found:=true;
   usrPassrecord:=_UserIndex;
   passfound:=true;
   usrPassDir   := passUserDir[_UserIndex];
   usrpassBKUP    := passBKUP[_UserIndex];

   vcheck:=verifyUserDirectory(usrPassDir);
   if (vcheck<>0) then begin // 1-progdir, 2-datadir, 3-dir not exist, 4-w/r access problem
       usrPassDir:=Directories.datadir; //same as general users
       msg:='Directory for storing your display file is not correct.'+endline;
       msg:=msg+'Your display preferences will not be saved on exit.'+endline+endline;
       msg:=msg+'Contact your Time Chart Extra Supervisor to correctly'+endline;
       msg:=msg+'set your display directory with read/write access.'+endline;
       messagedlg(msg,mtWarning,[mbOK],0);
   end; {vcheck<>0}
 end;
 if (passfound and not(found)) then
 begin
  msg:='User ID not found.'+endline+'Please Re-enter.';
  messagedlg(msg,mtError,[mbOK],0);
  edit3.selectall;
  edit3.setfocus;
  inc(passWordTries);
  if passWordTries>2 then
  begin
   msg:='Closing Time Chart Extra.'+endline+'Attempted password access has failed.';
   messagedlg(msg,mtWarning,[mbOK],0);
   application.terminate;
  end;
  exit;
 end;
 if not(passfound) then
 begin
  msg:='Password not found.'+endline+'Please Re-enter.';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.selectall;
  edit1.setfocus;
  inc(passWordTries);
  if passWordTries>2 then
  begin
   msg:='Closing Time Chart Extra.'+endline+'Attempted password access has failed.';
   messagedlg(msg,mtWarning,[mbOK],0);
   application.terminate;
  end;
  exit;
 end;

 close;
end;


end.




