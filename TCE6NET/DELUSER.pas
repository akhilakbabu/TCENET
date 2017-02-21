unit Deluser;
{$WARN UNIT_PLATFORM OFF}
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, GlobalToTcAndTcextra, XML.USERS;

type
  TDeleteUserDlg = class(TForm)
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Label4: TLabel;
    ComboBox2: TComboBox;
    delete: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    Label15: TLabel;
    Label16: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure deleteClick(Sender: TObject);
  end;

var
  DeleteUserDlg: TDeleteUserDlg;

implementation
uses tceload,tcommon,tcommon2,tcommon3,showuser,tcommon5,tceglobals;
{$R *.DFM}

procedure updateCounts;
var
 i,j:       smallint;
begin
 checkcount;
 with DeleteUserDlg do
 begin
  j:=0;
  for i:=1 to 6 do
   inc(j,passCount[i]);
  label5.caption:=inttostr(j);
  label7.caption:=inttostr(passCount[6]);
  label11.caption:=inttostr(passCount[4]);
 end;
end;

procedure TDeleteUserDlg.FormCreate(Sender: TObject);
var
 i:       smallint;
begin
 combobox2.clear;
 label16.caption:='';
 for i:=1 to UserRecordsCount do
  combobox2.items.add(passID[i]);

 if wnFlag[wnShowUsers] then
 begin
  if ShowUsersWin.selcode>0 then
  begin
   combobox2.itemindex:=ShowUsersWin.selcode-1;
   ComboBox2Change(self);
  end;
 end;

end;

procedure TDeleteUserDlg.FormActivate(Sender: TObject);
begin
 updateCounts;
end;

procedure TDeleteUserDlg.ComboBox2Change(Sender: TObject);
var
 i:       smallint;
begin
 i:=combobox2.itemindex+1;
 if i<1 then exit;
 if passLevel[i]=6 then
 begin
  delete.enabled:=false;
  label16.font.color:=clred;
 end
 else
  begin
   delete.enabled:=true;
   label16.font.color:=clWindowText;
  end;
 label16.caption:=accessType[passLevel[i]];
end;

procedure TDeleteUserDlg.deleteClick(Sender: TObject);
var
 i,j,k: smallint;
 msg: shortstring;
begin
 i:=combobox2.itemindex+1;
 if i<1 then
 begin
   msg:='No user selected.';
   messagedlg(msg,mtInformation,[mbOK],0);
   combobox2.setfocus;
   exit;
 end;
 msg:='Delete'+endline+'User ID: '+passID[i]+
  endline+'Access level: '+accessType[passLevel[i]];
 if messagedlg(msg,mtConfirmation,[mbYes,mbNo,mbCancel],0)<>mryes then exit;
 {delete user}
 k:=i;
 dec(UserRecordsCount);
 if UserRecordsCount+1<>i then
  for j:=i to UserRecordsCount do
  begin
   passID[j]:=passID[j+1];
   password[j]:=password[j+1];
   passlevel[j]:=passlevel[j+1];
   passyear[j]:=passyear[j+1];
   if usrpassrecord=(i+1) then dec(usrpassrecord);
  end;
 updateCounts;
 saveUsers;
 UpdateWindow(wnShowUsers);

 combobox2.clear;
 for i:=1 to UserRecordsCount do
  combobox2.items.add(passID[i]);
 if k>UserRecordsCount then k:=UserRecordsCount;
 combobox2.itemindex:=k-1;
 ComboBox2Change(self);
 combobox2.setfocus;
end;


end.






