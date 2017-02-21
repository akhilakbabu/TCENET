unit Eduser;
{$WARN UNIT_PLATFORM OFF}
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, FileCtrl,
  GlobalToTcAndTcextra, XML.USERS;

type
  TEditUserDlg = class(TForm)
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Label2: TLabel;
    Label4: TLabel;
    Label18: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    update: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    ComboBox2: TComboBox;
    Label14: TLabel;
    Edit3: TEdit;
    Label15: TLabel;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    Bevel2: TBevel;
    Label17: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
  private
    procedure UpdateCounts;

  end;

var
  EditUserDlg: TEditUserDlg;

implementation
uses tceload,tcommon,tcommon2,tcommon3,showuser,tcommon5,tceglobals;
{$R *.DFM}

procedure TEditUserDlg.UpdateCounts;
var
 i,j:       smallint;
begin
 checkcount;
 j:=0;
 for i:=1 to 6 do inc(j,passCount[i]);
 label5.caption:=inttostr(j);
 label7.caption:=inttostr(passCount[6]);
 label11.caption:=inttostr(passCount[4]);
end;



procedure TEditUserDlg.FormCreate(Sender: TObject);
var
 i:       smallint;
begin
 combobox2.clear;
 for i:=1 to UserRecordsCount do
  combobox2.items.add(passID[i]);
 {init to selection if needed}
 if wnFlag[wnShowUsers] then
 begin
  if ShowUsersWin.selcode>0 then
  begin
   combobox2.itemindex:=ShowUsersWin.selcode-1;
   ComboBox2Change(self);
  end;
 end;

end;



procedure TEditUserDlg.FormActivate(Sender: TObject);
begin
 updateCounts;
end;

procedure TEditUserDlg.updateClick(Sender: TObject);
var
 m: smallint;
 msg,a,b: shortstring;
 i,j,k:  smallint;
begin
 if uppercase(trim(edit1.text))<>uppercase(trim(edit2.text)) then
 begin
  msg:='Confirm word doesn''t match'+endline+'Please Re-enter';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.text:=''; edit2.text:='';
  edit1.selectall; edit1.setfocus; exit;
 end;
 j:=combobox2.itemindex+1;

 if j<1 then
 begin
  msg:='No user selected';
  messagedlg(msg,mtError,[mbOK],0);
  combobox2.selectall; combobox2.setfocus; exit;
 end;

 {prevent duplicate ID/Password combination}
 a:=uppercase(trim(edit3.text));
 if a='' then a:=passId[j];
 b:=uppercase(trim(edit1.text));
 if b='' then b:=password[j]; {allowing password to be unchanged while changing id etc.}
 k:=0;
 for i:=1 to UserRecordsCount do
  if ((passId[i]=a) and (password[i]=b)) then
   if i<>j then {looking for other besides current one}
    begin
     k:=i; break;
    end;
 if k>0 then
  begin
   msg:='Password/User ID combination already used for'
        +endline+'access type '+accessType[passlevel[k]];
   messagedlg(msg,mtError,[mbOK],0);
   edit1.text:=''; edit2.text:='';
   edit1.selectall; edit1.setfocus; exit;
  end;

 m:=verifyUserDirectory(directoryListBox1.directory);
 if m<>0 then
  begin
   msg:='Directory for storing display file'+endline;
   case m of
    1: msg:=msg+'should NOT be the same as the program directory.';
    2: msg:=msg+'should NOT be the same as the data directory.';
    3: msg:=msg+'must ALREADY exist.';
    4: msg:=msg+'must be set to allow read and write access.';
   end; {case}
   msg:=msg+endline+'Please Re-select the directory.';
   messagedlg(msg,mtError,[mbOK],0);
   directoryListBox1.setfocus;
   exit;
  end;

 {update user}
 passUserDir[j]:=directoryListBox1.directory;
 passID[j]:=a;
 passBKUP[j]:=checkbox1.checked;
 usrPassBKUP:=checkbox1.checked;

 if trim(edit1.text)>'' then
  password[j]:=RpadString(uppercase(trim(edit1.text)),szPassword);
 updateCounts;
 saveUsers;
 UpdateWindow(wnShowUsers);
 edit1.text:=''; edit2.text:='';

 combobox2.clear;
 for i:=1 to UserRecordsCount do combobox2.items.add(passID[i]);
 combobox2.itemindex:=j-1;
 combobox2.setfocus;
end;

procedure TEditUserDlg.ComboBox2Change(Sender: TObject);
var
 i:       smallint;
begin
 i:=combobox2.itemindex+1;
 edit3.text:=trim(combobox2.text);
 directoryListbox1.directory:=passUserDir[i];
 checkbox1.checked:=passBKUP[i] = True;
 if i<1 then exit;
 if passLevel[i]=6 then label15.visible:=true
  else label15.visible:=false;
end;

procedure TEditUserDlg.Edit3Enter(Sender: TObject);
begin
 edit3.selectall;
end;

end.
