unit Adduser;
{$WARN UNIT_PLATFORM OFF}
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, FileCtrl, XML.UTILS,
  GlobalToTcAndTcextra, XML.USERS;

type
  TAddNewUserDlg = class(TForm)
    GroupBox1: TGroupBox;
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label17: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label18: TLabel;
    Label14: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    procedure OKbuttonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function GetDefaultUserDir(const pUserNum, pUserLevel: Integer): string;
    procedure ResetData;
  end;

var
  AddNewUserDlg: TAddNewUserDlg;

implementation

uses
  tceload, tcommon, tcommon2, tcommon3, tcommon5, tceglobals, Showuser, uAMGCommon;

{$R *.DFM}

procedure updateCounts;
var
 i,j:       smallint;
begin
 checkcount;
 with AddNewUserDlg do
 begin
  j:=0;
  for i:=1 to 6 do
   inc(j,passCount[i]);
  label5.caption:=inttostr(j);
  label7.caption:=inttostr(passCount[6]);
  label11.caption:=inttostr(passCount[4]);
 end;
end;

procedure TAddNewUserDlg.FormShow(Sender: TObject);
begin
  ResetData;
end;

function TAddNewUserDlg.GetDefaultUserDir(const pUserNum, pUserLevel: Integer): string;
var
  s, s1, firstpart, lastpart: string;
  addendPos, i, dirlen, addendVal: Integer;
  addendUsed: array of Boolean;
begin
  s := GetUsersDir;
  if pUserLevel <> 6 then
    s := s + '\User';
  dirLen := Length(s);
  addendPos := 0;
  if (UserRecordsCount > 0) and (pUserLevel <> 6) then
  begin
    SetLength(addendUsed, UserRecordsCount + 2);
    for i:=1 to UserRecordsCount do addendUsed[i] := False;
    for i:=1 to UserRecordsCount do
      if (passlevel[i] = pUserLevel) and (i <> pUserNum) then
      begin
       s1 := passUserDir[i];
       if Length(s1) <= dirLen then Continue;
       firstpart := Copy(s1, 1, dirLen);
       lastpart := copy(s1, 1 + dirLen, Length(s1));
       addendVal := StrToIntDef(lastpart, 0);
       if (uppercase(firstpart) = UpperCase(s)) and (addendVal > 0) and
          (addendVal <= UserRecordsCount) then addendUsed[addendVal] := True;
      end;
    for i:=1 to UserRecordsCount do
     if addendUsed[i] = False then
     begin
       addendPos := i;
       Break;
     end;
   end;
  if addendPos = 0 then addendPos := 1;
  if (pUserLevel <> 6) then s := s + IntToStr(addendPos);
  Result := s;
end;

procedure TAddNewUserDlg.OKbuttonClick(Sender: TObject);
var
  m: smallint;
  msg,a,b: shortstring;
  i,j:  smallint;
begin
 if trim(edit3.text)='' then
 begin
  msg:='User ID is required';
  messagedlg(msg,mtError,[mbOK],0);
  edit3.selectall; edit3.setfocus; exit;
 end;
 if trim(edit1.text)='' then
 begin
  msg:='Password is required!';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.selectall; edit1.setfocus; exit;
 end;
 if uppercase(trim(edit1.text))<>uppercase(trim(edit2.text)) then
 begin
  msg:='Confirm word doesn''t match'+endline+'Please Re-enter';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.text:=''; edit2.text:='';
  edit1.selectall; edit1.setfocus; exit;
 end;
 {prevent duplicate ID/Password combination}
 a:=uppercase(trim(edit3.text));
 b:=uppercase(trim(edit1.text));
 j:=0;
 for i:=1 to UserRecordsCount do
 begin
  if ((passId[i]=a) and (password[i]=b)) then
  begin
   j:=i; break;
  end;
 end;
 if j>0 then
 begin
  msg:='Password/User ID combination already used for'
        +endline+'access type '+accessType[passlevel[j]];
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

 {add user}
 inc(UserRecordsCount);

 passID[UserRecordsCount]:=RpadString(uppercase(trim(edit3.text)),szPassID);
 password[UserRecordsCount]:=RpadString(uppercase(trim(edit1.text)),szPassword);
 passlevel[UserRecordsCount]:=4; {can only make type extras}
 passUserDir[UserRecordsCount]:=directoryListBox1.directory;
 passBKUP[UserRecordsCount]:=checkbox1.checked;
 usrPassBKUP:=checkbox1.checked;

 updateCounts;
 saveUsers;
 UpdateWindow(wnShowUsers);
 ResetData;
end;

procedure TAddNewUserDlg.ResetData;
var
  lDir: string;
begin
  directoryListBox1.directory:=Directories.progdir;
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit3.SetFocus;
  lDir := GetDefaultUserDir(UserRecordsCount + 1, 4);
  ForceDirectories(lDir);
  if DirectoryExists(lDir) then
    DirectoryListBox1.Directory := lDir;
end;

procedure TAddNewUserDlg.FormActivate(Sender: TObject);
begin
 updateCounts;
 edit3.SetFocus;
end;

end.
