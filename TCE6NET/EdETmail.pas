unit EdETmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,TCEglobals, XML.UTILS, GlobalToTcAndTcextra;

type
  TEdETemail = class(TForm)
    Label14: TLabel;
    Label15: TLabel;
    finish: TBitBtn;
    previous: TBitBtn;
    next: TBitBtn;
    update: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Tname: TLabel;
    Tcode: TLabeledEdit;
    Tmail: TLabeledEdit;
    procedure nextClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TcodeChange(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure previousClick(Sender: TObject);
  private
    Procedure ButtonStatus;
    procedure ETshow;
    procedure restore;
    procedure ShowTeacher;
  end;

  Procedure SaveETmail;

var
  EdETemail: TEdETemail;

implementation

uses Addstaff,Tcommon,tcommon2;

{$R *.dfm}

var
 myte,ETpoint: smallint;
 needUpdate:   boolean;


procedure TEdETemail.ETshow;
begin
 Tcode.text:=TrimRight(ETsub[myte]);
 ButtonStatus;
end;


Procedure TEdETemail.ButtonStatus;
begin
 previous.enabled:=(ETpoint>1);
 next.enabled:=(ETpoint<ETnum1);
end;

procedure TEdETemail.restore;
begin
 Tname.Caption:='';
 Tmail.text:='';
 Tcode.setfocus;
end;

procedure TEdETemail.ShowTeacher;
begin
 Tname.caption:=ETname[myte];
 Tmail.Text:=ETmail[myte];
end;


procedure TEdETemail.nextClick(Sender: TObject);
begin
 if ETpoint<ETnum1 then
  begin
   inc(ETpoint);
   myte:=etpointer[ETpoint];
   ETshow;
  end;
end;

procedure TEdETemail.FormActivate(Sender: TObject);
begin
 Tcode.maxlength:=ETLencodes;
 needUpdate:=false;
 label15.caption:=inttostr(ETnum1);
 myte:=0;
 ETpoint:=AddedStaffWin.selcode;
 if ETpoint>0 then
  begin
   myte:=etpointer[ETpoint];
   ETshow;
  end
 else begin restore; Tcode.text:=''; end;
 ButtonStatus;
 Tcode.setfocus;
end;

procedure TEdETemail.TcodeChange(Sender: TObject);
var
 codeStr: string;
begin
 codeStr:=Tcode.text;
 codeStr:=TrimRight(codeStr);
 ETpoint:=findaddedstaff(codeStr);
 myte:=Etpointer[ETpoint];
 if myte>0 then showteacher else restore;
 ButtonStatus;
end;

Procedure SaveETmail;
var
 f:       textfile;
 i:       integer;
 s: string;
begin
 try
  chdir(Directories.datadir);
  doAssignFile(f,'ETMAIL.DAT');
  try
   filemode:=fmOpenReadWrite+fmShareDenyWrite;
   rewrite(f);
   str(ETnum,S);
   writeln(f,s);
   if ETnum>0 then
    for i:=1 to ETnum do writeln(f,ETmail[i]);
  finally
   closefile(f);
   fwETmail:=getETmailFontWidths(AddedStaffWin.canvas);
  end;
 except
 end;
end;




procedure TEdETemail.updateClick(Sender: TObject);
var
 msg: string;
begin
 if myte=0 then
  begin
   msg:='Added Staff code not found.'+endline;
   messagedlg(msg,mtError,[mbOK],0);
   Tcode.setfocus;
   exit;
  end;
 ETmail[myte]:=Tmail.text;
 NeedUpdate:=true;
 AddedStaffWin.UpdateWin;
 if next.enabled then nextclick(self);
end;

procedure TEdETemail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if NeedUpdate then SaveETmail;
end;

procedure TEdETemail.previousClick(Sender: TObject);
begin
 if ETpoint>1 then
  begin
   dec(ETpoint);
   myte:=Etpointer[ETpoint];
   ETshow;
  end;
end;

end.
