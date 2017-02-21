unit EdTeEmail;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms,  Dialogs, Buttons,TCEglobals, XML.UTILS, GlobalToTcAndTcextra;

type
  TEdTemail = class(TForm)
    finish: TBitBtn;
    previous: TBitBtn;
    next: TBitBtn;
    update: TBitBtn;
    BitBtn3: TBitBtn;
    Label14: TLabel;
    Label15: TLabel;
    GroupBox1: TGroupBox;
    Tcode: TLabeledEdit;
    Tmail: TLabeledEdit;
    Label1: TLabel;
    Tname: TLabel;
    procedure nextClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TcodeChange(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure previousClick(Sender: TObject);
  private
    Procedure ButtonStatus;
    procedure TeShow;
    procedure Restore;
    procedure ShowTeacher;
  end;

  Procedure SaveTemail;

var
  EdTemail: TEdTemail;

implementation

uses TeWnd,Tcommon,tcommon5;


{$R *.DFM}

var
 myte,TePos: smallint;
 needUpdate:   boolean;

procedure TEdTemail.TeShow;
begin
 Tcode.text:=TrimRight(tecode[myte,0]);
 ButtonStatus;
end;


Procedure TEdTemail.ButtonStatus;
begin
 previous.enabled:=(TePos>1);
 next.enabled:=(TePos<codenum[1]);
end;

procedure TEdTemail.Restore;
begin
 Tname.Caption:='';
 Tmail.text:='';
 Tcode.setfocus;
end;

procedure TEdTemail.ShowTeacher;
begin
 Tname.caption:=tename[myte,0];
 Tmail.Text:=Temail[myte];
end;


procedure TEdTemail.nextClick(Sender: TObject);
begin
 if TePos<codenum[1] then
  begin
   inc(TePos);
   myte:=codepoint[TePos,1];
   teshow;
  end;
end;

procedure TEdTemail.FormActivate(Sender: TObject);
begin
 Tcode.maxlength:=lencodes[1];
 needUpdate:=false;
 label15.caption:=inttostr(codenum[1]);
 myte:=0;
 TePos:=TeWindow.selcode;
 if TePos>0 then
  begin
   myte:=codepoint[TePos,1];
   teshow;
  end
 else begin restore; Tcode.text:=''; end;
 ButtonStatus;
 Tcode.setfocus;
end;

procedure TEdTemail.TcodeChange(Sender: TObject);
var
 codeStr: string;
begin
 {change check here}
 codeStr:=Tcode.text;
 codeStr:=TrimRight(codeStr);
 myte:=checkCode(1,codeStr);
 if myte>0 then showteacher else restore;
 TePos:=GetTePoint(myte);
 ButtonStatus;
end;


Procedure SaveTemail;
var
 fname,tname: string;
 i:       integer;
 s,crt: string;
begin
 chdir(Directories.datadir);
 try
  crt:=endline;
  fname:='TEMAIL.DAT';
  tname:='TEMAIL.TMP';
  ourSafetyMemStreamStr:='';
  ourSafetyMemStream:=TStringStream.Create(ourSafetyMemStreamStr);

  try
   with ourSafetyMemStream do
    begin
     str(NumCodes[1],S); Write(Pchar(@s[1])^,length(s));
     Write(Pchar(@crt[1])^,2);    //newline
     if NumCodes[1]>0 then
      for i:=1 to NumCodes[1] do
       begin
        s:=Temail[i];
        if length(s)>0 then Write(Pchar(@s[1])^,length(s));
        Write(Pchar(@crt[1])^,2);    //newline
      end;
    end;
   SafelyStreamToFile(tname,fname);
  finally
   ourSafetyMemStream.Free;
   fwTemail:=getTemailFontWidths(TeWindow.canvas);
  end;
 except
 end;
end;

procedure TEdTemail.updateClick(Sender: TObject);
var
 msg: string;
begin
 if myte=0 then
  begin
   msg:='Teacher code not found.'+endline;
   messagedlg(msg,mtError,[mbOK],0);
   Tcode.setfocus;
   exit;
  end;
 Temail[myte]:=Tmail.text;
 NeedUpdate:=true;
 TeWindow.UpdateWin;
 if next.enabled then nextclick(self);
end;

procedure TEdTemail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if NeedUpdate then SaveTEmail;
end;

procedure TEdTemail.previousClick(Sender: TObject);
begin
 if TePos>1 then
  begin
   dec(TePos);
   myte:=codepoint[TePos,1];
   teshow;
  end;
end;

end.
