unit Edtcode;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, GlobalToTcAndTcextra;

type
  Tedtcodedlg = class(TForm)
    update: TBitBtn;
    finish: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    CodeEdit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    FacEdit1: TEdit;
    FacEdit2: TEdit;
    FacEdit3: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    previous: TBitBtn;
    next: TBitBtn;
    Label18: TLabel;
    FacEdit4: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure updateClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CodeEdit1Change(Sender: TObject);
    procedure FacEdit1Change(Sender: TObject);
    procedure FacEdit2Change(Sender: TObject);
    procedure FacEdit3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure nextClick(Sender: TObject);
    procedure previousClick(Sender: TObject);
    procedure FacEdit4Change(Sender: TObject);

  private
    Procedure ButtonStatus;
    procedure ShowTeacher;
    procedure Restore;
    procedure TeShow;
  end;

var
  edtcodedlg: Tedtcodedlg;

implementation
uses TeWnd,tcommon,DlgCommon,main;
{$R *.DFM}

var
 myte,TePos: smallint;
 needUpdate:   boolean;

procedure Tedtcodedlg.TeShow;
begin
 CodeEdit1.text:=TrimRight(tecode[myte,0]);
 ButtonStatus;
end;


Procedure Tedtcodedlg.ButtonStatus;
begin
 previous.enabled:=(TePos>1);
 next.enabled:=(TePos<codenum[1]);
end;


procedure Tedtcodedlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
 if needUpdate then updateSub(1); {update teacher data files}
end;

procedure Tedtcodedlg.restore;
begin
 label17.caption:=''; CodeEdit1.text:='';
 edit2.text:=''; edit3.text:='';
 FacEdit1.text:=''; FacEdit2.text:=''; FacEdit3.text:='';  FacEdit4.text:='';
 edit7.text:=''; edit8.text:=''; edit9.text:=''; edit10.text:=''; edit11.text:='';
 edit12.text:=''; edit13.text:='';
 CodeEdit1.setfocus;
end;

procedure Tedtcodedlg.ShowTeacher;
var
 s: string;
begin
 label17.caption:=TeName[myTe,0];
 edit2.text:=TeName[myTe,0];
 s:=tecode[myTe,0];
 edit3.text:=TrimRight(s);
 checkTeFaculty(Tfaculty[myTe,1],Tfaculty[myTe,2],Tfaculty[myTe,3],Tfaculty[myTe,4]);
 if Tfaculty[myTe,1]=-1 then FacEdit1.text:='*' else FacEdit1.text:=facName[Tfaculty[myTe,1]];
 FacEdit2.text:=facName[Tfaculty[myTe,2]];
 FacEdit3.text:=facName[Tfaculty[myTe,3]];
 FacEdit4.text:=facName[Tfaculty[myTe,4]];
 if Load[myTe]=-1 then edit7.text:=inttostr(days*periods)
  else
   begin
    if Load[myTe]<>0 then edit7.text:=inttostr(Load[myTe])
     else edit7.text:='';
   end;

 edit8.text:=trim(DutyCode[myTe,0]);
 edit10.text:=trim(DutyCode[myTe,1]);
 edit12.text:=trim(DutyCode[myTe,2]);
 if DutyLoad[myTe,0]<>0 then
  begin
   str(DutyLoad[myTe,0]:4:2,s);  edit9.text:=s;
  end
   else edit9.text:='';
 if DutyLoad[myTe,1]<>0 then
  begin
   str(DutyLoad[myTe,1]:4:2,s);  edit11.text:=s;
  end
   else edit11.text:='';
 if DutyLoad[myTe,2]<>0 then
  begin
   str(DutyLoad[myTe,2]:4:2,s);  edit13.text:=s;
  end
   else edit13.text:='';
end;

procedure Tedtcodedlg.updateClick(Sender: TObject);
var
 codeStr:       string;
 codePlace:     integer;
 codeStrNEW:    string;
 codePlaceNEW:  integer;
 msg:           string;
 tmpStr:        string;
 i:             integer;
 tmpLoad:       array[1..3] of double;
 tmpCode:       array[1..3] of string[szDutyCode];
 tmpFacName:    array[1..nmbrTeFacs] of string[szFacName];
 tmpFac:        array[1..nmbrTeFacs] of smallint;
 tmpInt:        integer;
 erCode:        integer;
 needSelChk:    boolean;
begin
 msg:='';
 codeStr:=CodeEdit1.text;
 codeStr:=TrimRight(codestr);
 if codeStr='' then
 begin
  msg:='No code entered.';
  messagedlg(msg,mtError,[mbOK],0);
  CodeEdit1.setFocus;
  exit;  {return to editing}
 end;

 codePlace:=checkCode(1,codeStr);
 if codePlace<=0 then     {code not found}
 begin
  msg:='The code '+codeStr+' could not be found.'+endline;
  msg:=msg+'Please enter a different code.';
  messagedlg(msg,mtError,[mbOK],0);
  CodeEdit1.setfocus; CodeEdit1.SelectAll;
  exit;  {return to editing}
 end;
 codeStrNEW:=edit3.text;
 codestrnew:=TrimRight(codestrnew);
 if codeStrNEW='' then
 begin
  messagedlg('No new code entered.',mtError,[mbOK],0);
  edit3.setFocus;
  exit;  {return to editing}
 end;
 codePlaceNEW:=checkCode(1,codeStrNEW);
 if ((codePlaceNEW>0) and (codePlace<>codePlaceNEW)) then     {code already in use}
 begin
  tmpStr:=tename[codePlaceNEW,0];
  msg:='The code '+tecode[codePlaceNEW,0]+' is already used';
  if tmpStr<>'' then msg:=msg+' for '+tmpStr;
  msg:=msg+'.'+endline+'Please enter a different code.';
  messagedlg(msg,mtError,[mbOK],0);
  edit3.setfocus; edit3.selectall;
  exit;  {return to editing}
 end;

 if (copy(codeStrNEW,1,2)='00') or (copy(codeStr,1,2)='00') then
 begin
  messagedlg(zeromessage,mtError,[mbOK],0);
  if (copy(codeStrNEW,1,2)='00') then edit3.setfocus else CodeEdit1.setfocus;
  exit; {return to editing}
 end;

 val(edit9.text,tmpLoad[1],erCode);
 val(edit11.text,tmpLoad[2],erCode);
 val(edit13.text,tmpLoad[3],erCode);
 tmpCode[1]:=trim(edit8.text);
 tmpCode[2]:=trim(edit10.text);
 tmpCode[3]:=trim(edit12.text);
 for i:=1 to 3 do
 begin
  if tmpLoad[i]<0 then
  begin
   msg:='Duty Loads cannot be less than 0.';
   msg:=msg+endline+'Check the value for the '+nth[i]+ ' Duty Load.';
   messagedlg(msg,mtError,[mbOK],0);
   case i of
    1: edit8.setfocus;
    2: edit10.setfocus;
    3: edit12.setfocus;
   end;
   exit;
  end
  else
   begin
    if ((tmpCode[i]='') and (tmpLoad[i]>0)) then
    begin
     msg:='A Duty Load must have an accompanying Duty Code.';
     msg:=msg+endline+'Enter a code for the '+nth[i]+' Duty Code.';
     messagedlg(msg,mtError,[mbOK],0);
     case i of
      1: edit9.setfocus;
      2: edit11.setfocus;
      3: edit13.setfocus;
     end;
     exit;
    end;
   end  {if}
 end; {for}

 tmpStr:=trim(edit7.text);
 tmpInt:=strtointdef(tmpStr,0);
 if tmpInt<0 then
 begin
  msg:='Load cannot be less than 0.';
  messagedlg(msg,mtError,[mbOK],0);
  edit7.setfocus;
  exit;
 end;

 tmpFacName[1]:=trim(FacEdit1.text);
 tmpFacName[2]:=trim(FacEdit2.text);
 tmpFacName[3]:=trim(FacEdit3.text);
 tmpFacName[4]:=trim(FacEdit4.text);
 for i:=1 to nmbrTeFacs do
 begin
  tmpFac[i]:=CheckFaculty(tmpFacName[i]);
  if ((tmpFac[i]=0) and (tmpFacName[i]<>'')) then
  begin
   msg:='Check the name entered for the '+nth[i]+' faculty.';
   messagedlg(msg,mtError,[mbOK],0);
   case i of
    1: FacEdit1.setfocus;
    2: FacEdit2.setfocus;
    3: FacEdit3.setfocus;
    4: FacEdit4.setfocus;
   end;
   exit;
  end;
 end;
 checkTeFaculty(tmpFac[1],tmpFac[2],tmpFac[3],tmpFac[4]);

 {still here? then assign the new teacher to vars.}
 tecode[codePlace,0]:=codestrNEW;  {set new code}
 Tename[codePlace,0]:=trim(edit2.text);  {update name}
 for i:=1 to 3 do
 begin
  dutyload[codePlace,(i-1)]:=tmpLoad[i];
  dutycode[codePlace,(i-1)]:=tmpCode[i];
//  Tfaculty[codePlace,(i-1)]:=tmpFac[i];
 end;
 for i:=1 to nmbrTeFacs do Tfaculty[codePlace,i]:=tmpFac[i];

 Load[codePlace]:=tmpInt;

 needSelChk:=false;
 if TeWindow.selCode>0 then {only if a selectioin exists}
  if codepoint[TeWindow.selCode,1]=codePlace then {selected code }
   if codeStr<>codeStrNEW then {code altered}
   begin
    TeWindow.selCode:=codepoint[TeWindow.selcode,1];
    needSelChk:=true;
   end;

 needUpdate:=true;
 sortCodes(1);

 if needSelChk then
  for i:=1 to codenum[code] do
   if ((codepoint[i,1])=(TeWindow.selcode)) then
   begin
    TeWindow.selCode:=i;
    break;
   end;

 {update font widths if necessary}
 getFontWidths;
 TeWindow.UpdateWin;
 UpdateTimeTableWins;
 if next.enabled then nextclick(self);
end;


procedure Tedtcodedlg.FormActivate(Sender: TObject);
begin
 {init here}
 CodeEdit1.maxlength:=lencodes[1]; edit3.maxlength:=lencodes[1];
 edit2.maxlength:=szTeName; edit7.maxlength:=6;
 FacEdit1.maxlength:=szFacName; FacEdit2.maxlength:=szFacName;
 FacEdit3.maxlength:=szFacName; FacEdit4.maxlength:=szFacName;
 edit8.maxlength:=szDutyCode; edit9.maxlength:=5;
 edit10.maxlength:=szDutyCode; edit11.maxlength:=5;
 edit12.maxlength:=szDutyCode; edit13.maxlength:=5;
 needUpdate:=false;
 label15.caption:=inttostr(codenum[1]);
 myte:=0;
 TePos:=TeWindow.selcode;
 if TePos>0 then
  begin
   myte:=codepoint[TePos,1];
   teshow;
  end
 else begin restore; CodeEdit1.text:=''; end;
 ButtonStatus;
 CodeEdit1.setfocus;
end;

procedure Tedtcodedlg.CodeEdit1Change(Sender: TObject);
var
 codeStr: string;
begin
 codeStr:=CodeEdit1.text;
 codeStr:=TrimRight(codestr);
 myte:=checkCode(1,codeStr);
 if myte>0 then showteacher else restore;
 TePos:=GetTePoint(myte);
 ButtonStatus;
end;

procedure Tedtcodedlg.FacEdit1Change(Sender: TObject);
begin
 insertfaculty(FacEdit1);
end;

procedure Tedtcodedlg.FacEdit2Change(Sender: TObject);
begin
 insertfaculty(FacEdit2);
end;

procedure Tedtcodedlg.FacEdit3Change(Sender: TObject);
begin
 insertfaculty(FacEdit3);
end;

procedure Tedtcodedlg.FormCreate(Sender: TObject);
begin
 topcentre(self);
end;

procedure Tedtcodedlg.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure Tedtcodedlg.nextClick(Sender: TObject);
begin
 if TePos<codenum[1] then
  begin
   inc(TePos);
   myte:=codepoint[TePos,1];
   teshow;
  end;
end;

procedure Tedtcodedlg.previousClick(Sender: TObject);
begin
 if TePos>1 then
  begin
   dec(TePos);
   myte:=codepoint[TePos,1];
   teshow;
  end;
end;

procedure Tedtcodedlg.FacEdit4Change(Sender: TObject);
begin
 insertfaculty(FacEdit4);
end;

end.
