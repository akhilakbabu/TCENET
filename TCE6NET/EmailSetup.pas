unit EmailSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,TCEglobals;

type
  TEmailSetupDlg = class(TForm)
    OKbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    lblHostID: TLabel;
    edtHostID: TEdit;
    lblUserID: TLabel;
    edtUserID: TEdit;
    edtPassword: TEdit;
    lblPassword: TLabel;
    edtSender: TEdit;
    lblSender: TLabel;
    edtDisplayName: TEdit;
    lblDisplayName: TLabel;
    edtPort: TEdit;
    lblPort: TLabel;
    chkPlainSMTP: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure OKbuttonClick(Sender: TObject);
    procedure AcceptNumericOnly(Sender: TObject; var Key: Char);
  end;

var
  EmailSetupDlg: TEmailSetupDlg;

implementation
uses Tcommon;
{$R *.dfm}

procedure TEmailSetupDlg.AcceptNumericOnly(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TEmailSetupDlg.FormCreate(Sender: TObject);
begin
  edtHostID.Text := EmailHost;
  edtPort.Text := IntToStr(EmailPort);
  edtUserID.Text := EmailUserID;
  edtPassword.Text := EmailPassword;
  edtSender.Text := EmailSend;
  edtDisplayName.Text := EmailDisplayName;
  CheckBox1.Checked := EmailCoverFlag;
  CheckBox2.Checked := EmailAbsentFlag;
  CheckBox3.Checked := EmailAddedFlag;
  chkPlainSMTP.Checked := EmailPlainSMTP;
end;

procedure TEmailSetupDlg.OKbuttonClick(Sender: TObject);
begin
  EmailHost := edtHostID.Text;
  EmailPort := StrToInt(Trim(edtPort.Text));
  EmailUserID := edtUserID.Text;
  EmailPassword := edtPassword.Text;
  EmailSend := edtSender.Text;
  EmailDisplayName := edtDisplayName.Text;
  EmailCoverFlag := CheckBox1.Checked;
  EmailAbsentFlag := CheckBox2.Checked;
  EmailAddedFlag := CheckBox3.Checked;
  EmailPlainSMTP := chkPlainSMTP.Checked;
  EmailSetupWrite;
end;

end.
