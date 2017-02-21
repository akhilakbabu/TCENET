unit Deltcode;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, GlobalToTcAndTcextra;

type
  Tdeltcodedlg = class(TForm)
    finish: TBitBtn;
    delete: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Edit1: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label6: TLabel;
    FacLabel1: TLabel;
    FacLabel3: TLabel;
    Label10: TLabel;
    Label26: TLabel;
    Label8: TLabel;
    FacLabel2: TLabel;
    FacLabel4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure deleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ShowTeacher;
    procedure Restore;
    procedure Restore1;
  end;

var
  deltcodedlg: Tdeltcodedlg;
  needUpdate:   boolean;

implementation
uses TeWnd,tcommon,tcommon2;
{$R *.DFM}

var
 myTe: integer;

procedure Tdeltcodedlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
 if needUpdate then updateSub(1);  {update teacher data files}
end;

procedure Tdeltcodedlg.restore;
begin
 label13.caption:=inttostr(codenum[1]);
 edit1.text:='';
 restore1;
 edit1.setfocus;
end;

procedure Tdeltcodedlg.restore1;
begin
 label3.caption:=''; label5.caption:=''; FacLabel1.caption:='';
 FacLabel2.caption:='';  FacLabel3.caption:=''; FacLabel4.caption:='';
 label20.caption:='';  label21.caption:=''; label22.caption:='';
 label23.caption:='';  label24.caption:=''; label25.caption:='';
end;



procedure Tdeltcodedlg.deleteClick(Sender: TObject);
var
 codeStr:       string;
 msg:           string;
begin
 msg:='';
 if codenum[1]<=0 then
  begin
   msg:='No Teacher Codes available for deletion.';
   messagedlg(msg,mtError,[mbOK],0);
   edit1.setfocus;
   exit;
  end;
 codeStr:=edit1.text;
 codeStr:=TrimRight(codestr);
 if codeStr='' then
  begin
   messagedlg('No code entered.',mtError,[mbOK],0);
   edit1.setFocus;
   exit;  {return to editing}
  end;
 myTe:=checkCode(1,codeStr);
 if myTe<=0 then     {code not found}
 begin
  msg:='The code '+codeStr+' could not be found.'+endline;
  msg:=msg+'Please enter a different code.';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.setfocus; edit1.SelectAll;
  exit;  {return to editing}
 end;
 if (copy(codeStr,1,2)='00') then
 begin
  messagedlg(zeromessage,mtError,[mbOK],0);
  edit1.setfocus; edit1.SelectAll;
  exit; {return to editing}
 end;

 if teAbsent[myTe]<>-1 then
  begin
  msg:='Teacher '+codeStr+' is absent.'+endline;
  msg:=msg+'Please remove teacher absence before deleting.';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.setfocus; edit1.SelectAll;
  exit;  {return to editing}
 end;

if telost[myTe]<>-1 then
  begin
  msg:='Teacher '+codeStr+' has lost classes.'+endline;
  msg:=msg+'Please remove lost classes from this teacher before deleting.';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.setfocus; edit1.SelectAll;
  exit;  {return to editing}
 end;

 if (tecover[myTe]<>-1) or (teReplace[myTe]<>-1) or (telieu[myTe]<>-1) then
  begin
  msg:='Teacher '+codeStr+' is covering a class.'+endline;
  msg:=msg+'Please remove covers from this teacher before deleting.';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.setfocus; edit1.SelectAll;
  exit;  {return to editing}
 end;

 needUpdate:=true;
 TeCode[myTe,0]:=StringPad(lenCodes[1],48);
 TeName[myTe,0]:='';
 Temail[myTe]:='';
 if (TeWindow.selcode=myTe) then TeWindow.selcode:=-1; {cancel selection}
 Load[myTe]:=days*periods;;
 Tfaculty[myTe,1]:=-1;  Tfaculty[myTe,2]:=0;
 Tfaculty[myTe,3]:=0;   Tfaculty[myTe,4]:=0;
 if myTe=Numcodes[1] then dec(NumCodes[1]);

 sortCodes(1);

 {update font widths if necessary}
 getCodeFontWidths(1);
 getTeDutyCodeFontWidths;
 TeWindow.UpdateWin;
 UpdateWindow(wnInfo);

 rangeCheckCodeSels(tettselection,1);
 rangeCheckCodeSels(ttprntselteachg,1);
 UpdateTimeTableWins;
 restore;
end;

procedure Tdeltcodedlg.showteacher;
var
 s:  string;
begin
 label3.caption:=TeName[myTe,0];
 checkTeFaculty(Tfaculty[myTe,1],Tfaculty[myTe,2],Tfaculty[myTe,3],Tfaculty[myTe,4]);
 if Tfaculty[myTe,1]=-1 then FacLabel1.caption:='*' else FacLabel1.caption:=facName[Tfaculty[myTe,1]];
 FacLabel2.caption:=facName[Tfaculty[myTe,2]];
 FacLabel3.caption:=facName[Tfaculty[myTe,3]];
 FacLabel4.caption:=facName[Tfaculty[myTe,4]];

 s:='';  if Load[myTe]<0 then s:=inttostr(periods*days);
 if Load[myTe]>0 then s:=inttostr(Load[myTe]);
 label5.caption:=s;
 label20.caption:=trim(DutyCode[myTe,0]);
 label22.caption:=trim(DutyCode[myTe,1]);
 label24.caption:=trim(DutyCode[myTe,2]);
 if DutyLoad[myTe,0]<>0 then
  begin
   str(DutyLoad[myTe,0]:4:2,s);  label21.caption:=s;
  end
   else label21.caption:='';
 if DutyLoad[myTe,1]<>0 then
  begin
   str(DutyLoad[myTe,1]:4:2,s);  label23.caption:=s;
  end
   else label23.caption:='';
 if DutyLoad[myTe,2]<>0 then
  begin
   str(DutyLoad[myTe,2]:4:2,s);  label25.caption:=s;
  end else label25.caption:='';
end;



procedure Tdeltcodedlg.FormActivate(Sender: TObject);
begin
 {init here}
 ensureSizeForFont(tform(deltcodedlg));
 edit1.maxlength:=lencodes[1];
 needUpdate:=false;
 label13.caption:=inttostr(codenum[1]);
 if TeWindow.selcode>0 then
  begin
   myTe:=codepoint[TeWindow.selcode,1];
   edit1.Text:=TrimRight(tecode[myTe,0]);
   showteacher;
  end
 else restore;
 edit1.setfocus;
end;

procedure Tdeltcodedlg.Edit1Change(Sender: TObject);
var
 codeStr:       string;
begin
 codeStr:=TrimRight(edit1.text);
 myTe:=checkCode(1,codeStr);
 if myTe>0 then showteacher else restore1;
end;

procedure Tdeltcodedlg.FormCreate(Sender: TObject);
begin
 TopCentre(self);
end;

end.
