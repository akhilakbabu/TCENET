unit Addtcode;

interface
{checked}
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, GlobalToTcAndTcextra;

type
  Taddtcodedlg = class(TForm)
    btnClose: TBitBtn;
    add: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
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
    Label6: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    FacEdit4: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure addClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FacEdit1Change(Sender: TObject);
    procedure FacEdit2Change(Sender: TObject);
    procedure FacEdit3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit9KeyPress(Sender: TObject; var Key: Char);
    procedure Edit11KeyPress(Sender: TObject; var Key: Char);
    procedure Edit13KeyPress(Sender: TObject; var Key: Char);
    procedure FacEdit4Change(Sender: TObject);

  private
    procedure restore;
  end;

var
  addtcodedlg: Taddtcodedlg;
  needUpdate:   boolean;

implementation
uses TeWnd,tcommon,DlgCommon,main;
{$R *.DFM}

procedure Taddtcodedlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
 if needUpdate then updateSub(1); {update teacher data files}
end;

function FindNextCode: integer;
var
 codeplace,i: integer;
begin
 codePlace:=NumCodes[1]+1;
 for i:=1 to numCodes[1] do {search for available deleted code}
 if (copy(tecode[i,0],1,2)='00') then
 begin
  codePlace:=i;
  break;
 end;
 if codePlace>numCodes[1] then
  begin
   numCodes[1]:=codePlace;
   SetLength(Temail,numCodes[1]+1);
  end; 
 result:=codePlace;
end;


procedure Taddtcodedlg.restore;
begin
 label14.caption:=inttostr(codenum[1]);
 edit1.text:=''; edit2.text:=''; FacEdit1.text:=''; FacEdit2.text:='';
 FacEdit3.text:=''; FacEdit4.text:=''; edit7.text:=''; edit8.text:='';
 edit9.text:=''; edit10.text:=''; edit11.text:=''; edit12.text:='';
 edit13.text:=''; edit1.setfocus;
end;


procedure Taddtcodedlg.addClick(Sender: TObject);
var
 codeStr:       string;
 codePlace:     integer;
 msg:   string;
 tmpStr:        string;
 i:             integer;
 tmpLoad:       array[1..3] of double;
 tmpCode:       array[1..3] of string[szDutyCode];
 tmpFacName:    array[1..nmbrTeFacs] of string[szFacName];
 tmpFac:        array[1..nmbrTeFacs] of smallint;
 tmpInt:        integer;
 erCode:        integer;
begin
 msg:='';

 if codenum[1]>=nmbrTeachers then
 begin
  msg:='The maximum number of teacher codes is '+inttostr(nmbrTeachers)+'.'+endline;
  msg:=msg+'You cannot add another Teacher.';
  messagedlg(msg,mtError,[mbOK],0);
  edit1.setfocus;
  exit;
 end;
 codeStr:=edit1.text;
 codeStr:=TrimRight(codestr);
 if codeStr='' then
  begin
   msg:='No code entered.';
   messagedlg(msg,mtError,[mbOK],0);
   edit1.setFocus;
   exit;  {return to editing}
  end;
 codePlace:=checkCode(1,codeStr);
 if codePlace>0 then     {code already in use}
 begin
  tmpStr:=tename[codePlace,0];
  msg:='The code '+tecode[codePlace,0]+' is already being used';
  if tmpStr<>'' then msg:=msg+' for '+tmpStr;
  msg:=msg+'.'+endline;
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

 val(edit9.text,tmpLoad[1],erCode);
 val(edit11.text,tmpLoad[2],erCode);
 val(edit13.text,tmpLoad[3],erCode);
 tmpCode[1]:=edit8.text;  tmpCode[1]:=trim(tmpCode[1]);
 tmpCode[2]:=edit10.text; tmpCode[2]:=trim(tmpCode[2]);
 tmpCode[3]:=edit12.text; tmpCode[3]:=trim(tmpCode[3]);
 for i:=1 to 3 do
 begin
  if tmpLoad[i]<0 then
  begin
   msg:='Duty Loads cannot be less than 0.';
   msg:=msg+endline+'Check the value for the '+nth[i]+ ' Duty Load.';
   messagedlg(msg,mtError,[mbOK],0);
   case i of
    1:edit9.setfocus;
    2:edit11.setfocus;
    3:edit13.setfocus;
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
      1:edit8.setfocus;
      2:edit10.setfocus;
      3:edit12.setfocus;
     end;
     exit;
    end;
   end  {if}
 end; {for}
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
    1:FacEdit1.setfocus;
    2:FacEdit2.setfocus;
    3:FacEdit3.setfocus;
    4:FacEdit4.setfocus;
   end;
   exit;
  end;
 end;
 checkTeFaculty(tmpFac[1],tmpFac[2],tmpFac[3],tmpFac[4]);

 tmpStr:=edit7.text;  tmpStr:=trim(tmpStr);
 tmpInt:=strtointdef(tmpStr,0);
 if tmpInt<0 then
 begin
  msg:='Teachers Load cannot be less than 0.';
  messagedlg(msg,mtError,[mbOK],0);
  edit7.setfocus;
  exit;
 end;

 {still here? then assign the new teacher to vars.}
 codePlace:=FindNextCode;

 tecode[codePlace,0]:=codeStr;
 tename[codePlace,0]:=trim(edit2.text);
 temail[codePlace]:='';

 for i:=1 to 3 do
 begin
  Dutyload[codePlace,(i-1)]:=tmpLoad[i];
  Dutycode[codePlace,(i-1)]:=tmpCode[i];
 end;
 for i:=1 to nmbrTeFacs do Tfaculty[codePlace,i]:=tmpFac[i];
 Load[codePlace]:=tmpInt;
 needUpdate:=true;
 sortCodes(1);

{update font widths if necessary}
 tmpint:=mainform.canvas.textwidth(codestr);
 if tmpint>fwCode[1] then fwCode[1]:=tmpint;
 tmpint:=mainform.canvas.textwidth(tmpStr);
 if tmpint>fwCodename[1] then fwCodename[1]:=tmpint;
 getFontWidths;
 TeWindow.UpdateWin;
 UpdateWindow(wnInfo);
 UpdateTimeTableWins;
 restore;
end;

procedure Taddtcodedlg.btnCloseClick(Sender: TObject);
begin
 close;
end;

procedure Taddtcodedlg.FormActivate(Sender: TObject);
begin
 edit1.maxlength:=lencodes[1]; edit2.maxlength:=szTeName;
 FacEdit1.maxlength:=szFacName; FacEdit2.maxlength:=szFacName; FacEdit3.maxlength:=szFacName;
 FacEdit4.maxlength:=szFacName; edit7.maxlength:=6; {9999??}
 edit8.maxlength:=szDutyCode; edit10.maxlength:=szDutyCode; edit12.maxlength:=szDutyCode;
 edit9.maxlength:=5; edit11.maxlength:=5; edit13.maxlength:=5;
 needUpdate:=false;
 restore;
end;

procedure Taddtcodedlg.FacEdit1Change(Sender: TObject);
begin
 insertfaculty(FacEdit1);
end;

procedure Taddtcodedlg.FacEdit2Change(Sender: TObject);
begin
 insertfaculty(FacEdit2);
end;

procedure Taddtcodedlg.FacEdit3Change(Sender: TObject);
begin
 insertfaculty(FacEdit3);
end;



procedure Taddtcodedlg.FormCreate(Sender: TObject);
begin
 TopCentre(self);
end;

procedure Taddtcodedlg.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure Taddtcodedlg.Edit9KeyPress(Sender: TObject; var Key: Char);
begin
 allowDecimalInputOnly(key);
end;

procedure Taddtcodedlg.Edit11KeyPress(Sender: TObject; var Key: Char);
begin
 allowDecimalInputOnly(key);
end;

procedure Taddtcodedlg.Edit13KeyPress(Sender: TObject; var Key: Char);
begin
 allowDecimalInputOnly(key);
end;

procedure Taddtcodedlg.FacEdit4Change(Sender: TObject);
begin
 insertfaculty(FacEdit4);
end;

end.
