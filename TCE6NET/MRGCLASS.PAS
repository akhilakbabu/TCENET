unit Mrgclass;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, tcommon3,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TMergedClasseswin = class(TLineCodewin)
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N6: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    Copy1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Change2Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDblClick(Sender: TObject);
  protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;

  end;

var
  MergedClasseswin: TMergedClasseswin;

procedure MergedClasseswinprint;
procedure MergedClasseswinOut;

implementation
uses tcommon,tcommon2,edmrgcls,main,printers,tcommon5;
{$R *.DFM}


 type TPrintMergeClass=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutMergeClass=class(TOutPutWin)
  public
   procedure head; override;
 end;

var
 PrintMergeClass:    TPrintMergeClass;
 OutMergeClass:  TOutMergeClass;

Procedure CalcMergeClass;
var
 j,a: integer;
begin
 mergedclasses:=0;
 for j:=1 to nmbrmergedclasses do
  begin
   mtime[j]:=0; msub[j]:=0; myear[j]:=0; mlevel[j]:=0;
   moldte[j]:=0; mnewte[j]:=0; moldroom[j]:=0; mnewroom[j]:=0; mflag[j]:=0;
  end;
 for j:=1 to nmbrChanges do
  begin
   if (Changes[j].gen<>3) and (Changes[j].gen<>5) then continue;
   a:=Changes[j].reason;
   mtime[a]:=Changes[j].timeslot;
   if (Changes[j].gen=3) and (Changes[j].oldte<>Changes[j].newte) then
     begin
      msub[a]:=Changes[j].sub; myear[a]:=Changes[j].year; mlevel[a]:=Changes[j].level;
      moldte[a]:=Changes[j].oldte; mnewte[a]:=Changes[j].newte; moldroom[a]:=Changes[j].oldroom;
      mnewroom[a]:=Changes[j].newroom; mkind[a]:=Changes[j].kind;
     end;
   if (Changes[j].gen=5) and (Changes[j].oldte=Changes[j].newte) and (Changes[j].oldroom<>Changes[j].newroom) then
    mflag[a]:=-1;
   if a>mergedclasses then mergedclasses:=a;
  end;
end;


procedure TMergedClasseswin.setTabs;
begin
 SetLength(Tabs,10); CalcMergeClass;
 TotalCodes:=mergedclasses;
 if selcode>mergedclasses then selcode:=0;
 codeColor:=cpClass;
 headwidth:=canvas.textwidth('Merged Classes: 100');
 MaxTab(1,canvas.textwidth('100'),'No.:');
 MaxTab(2,canvas.textwidth('W ()')+fwperiodname,'Time Slots ');
 MaxTab(3,fwcode[0],'Subject');
 MaxTab(4,fwyearname,yearTitle);
 MaxTab(5,fwcode[1],'Old Teacher');
 MaxTab(6,fwcode[1],'New Teacher');
 MaxTab(7,fwcode[2],'Old Room');
 MaxTab(8,fwcode[2],'New Room');
 MaxTab(9,0,' *');
 maxW:=Tabs[9];
 maxH:=txtheight*(Totalcodes+4);
end;

procedure TMergedClasseswin.PaintItem(i:integer;SelFlag:boolean);
begin
 printw(inttostr(i));
 x:=Tabs[1];
 if (mtime[i]=0) and (mnewte[i]=0) and (moldte[i]=0) then
  begin
   printw('Not used');  newline;  exit;
  end;
 printw(inttostr(mtime[i])+' ('+tslotcode[mtime[i],ttday]+')');
 x:=Tabs[2]; printw(SubCode[msub[i]]);
 x:=Tabs[3]; printw(yearname[myear[i]]);
 x:=Tabs[4]; printw(tecode[moldte[i],0]);
 x:=Tabs[5]; printw(tecode[mnewte[i],0]);
 x:=Tabs[6]; printw(tecode[moldroom[i],1]);
 x:=Tabs[7]; printwl(tecode[mnewroom[i],1]);
 if bool(mflag[i]) then printw(' *');
 fcolor(codecolor);
end;

procedure TMergedClasseswin.PaintHead;
begin
 printw2('Merged Classes: ',inttostr(totalcodes));
 newline;
 if TotalCodes<=0 then exit;
 fcolor(cpNormal);  printw('No.');
 x:=Tabs[1]; printw('Time Slot');
 x:=Tabs[2]; printw('Subject');
 x:=Tabs[3]; printw(Yeartitle);
 x:=Tabs[4]; printw('Old Teacher');
 x:=Tabs[5]; printw('New Teacher');
 x:=Tabs[6]; printw('Old Room');
 x:=Tabs[7]; printw('New Room');
 newline;
end;



procedure TMergedClasseswin.FormCreate(Sender: TObject);
begin
 doubleclick:=false;
 setWindowDefaults(self,wnMergeClass)
end;

procedure TMergedClasseswin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TMergedClasseswin.Change2Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  EdMergedClasses:=TEdMergedClasses.create(self);   {allocate dlg}
  EdMergedClasses.showmodal;
  EdMergedClasses.free;
  CheckAccessRights(4,9,false);
 end;
end;

procedure TMergedClasseswin.FormMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

{
------------------- print procs follow --------------
}


procedure TPrintMergeClass.SetTabs;
begin   {start of setprntTabs}
 setlength(PrntTabs,10);
 TotalCodes:=mergedclasses;
 codeColor:=cpClass;
 MaxTab(1,PrintCanvas.textwidth('100'),'No.:');
 MaxTab(2,PrintCanvas.textwidth('W ()')+fwPrntperiodname,'Time Slots ');
 MaxTab(3,fwPrntcode[0],'Subject');
 MaxTab(4,fwPrntyearname,yearTitle);
 MaxTab(5,fwPrntcode[1],'Old Teacher');
 MaxTab(6,fwPrntcode[1],'New Teacher');
 MaxTab(7,fwPrntcode[2],'Old Room');
 MaxTab(8,fwPrntcode[2],'New Room');
 MaxTab(9,0,' *');
end;


procedure TPrintMergeClass.head;
begin
 UnderlineOn;
 printw2('Merged Classes: ',inttostr(totalcodes));
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(cpNormal);
 if TotalCodes>0 then
   begin
     printw('No.');
     x:=PrntTabs[1]; printw('Time Slot');
     x:=PrntTabs[2]; printw('Subject');
     x:=PrntTabs[3]; printw(Yeartitle);
     x:=PrntTabs[4]; printw('Old Teacher');
     x:=PrntTabs[5]; printw('New Teacher');
     x:=PrntTabs[6]; printw('Old Room');
     x:=PrntTabs[7]; printw('New Room');
    x:=0; y:=y+PrnttxtHeight;;
   end;
end;

procedure MergedClasseswinprint;
var
 i: integer;

begin
 PrintMergeClass:=TPrintMergeClass.Create;
 with PrintMergeClass do
  try
   PrintHead;
   fcolor(codecolor);
   if TotalCodes>0 then
    for i:=1 to TotalCodes do
    begin
     printw(inttostr(i));
     x:=Prnttabs[1];
     if (mtime[i]=0) and (mnewte[i]=0) and (moldte[i]=0) then
      begin
       printw('Not used');  newline;  continue;
      end;
     printw(inttostr(mtime[i])+' ('+tslotcode[mtime[i],ttday]+')');
     x:=Prnttabs[2]; printw(SubCode[msub[i]]);
     x:=Prnttabs[3]; printw(yearname[myear[i]]);
     x:=Prnttabs[4]; printw(tecode[moldte[i],0]);
     x:=Prnttabs[5]; printw(tecode[mnewte[i],0]);
     x:=Prnttabs[6]; printw(tecode[moldroom[i],1]);
     x:=Prnttabs[7]; printwl(tecode[mnewroom[i],1]);
     if bool(mflag[i]) then printw(' *');
     newline;
    end;  {for i  to totalcodes}
   printCustomAddon;
  finally; {with PrintLostClass}
   PrintMergeClass.Free;
  end;
end;


procedure TOutMergeClass.head;
begin
 printLine(['Merged Classes: ',inttostr(mergedclasses)]);
 if mergedclasses>0 then
     printLine(['No.','Time Slot','Subject',Yeartitle,'Old Teacher','New Teacher',
       'Old Room','New Room']);
end;

procedure MergedClasseswinOut;
var
 i: integer;
begin
 OutMergeClass:=TOutMergeClass.Create;
 with OutMergeClass do
  try
   Header;
   if mergedclasses>0 then
    for i:=1 to mergedclasses do
    begin
     printw(inttostr(i));
     if (mtime[i]=0) and (mnewte[i]=0) and (moldte[i]=0) then
      begin
       printc('Not used');  newline;  continue;
      end;
     printc(inttostr(mtime[i])+' ('+tslotcode[mtime[i],ttday]+')');
     printc(SubCode[msub[i]]);
     printc(yearname[myear[i]]);
     printc(tecode[moldte[i],0]);
     printc(tecode[mnewte[i],0]);
     printc(tecode[moldroom[i],1]);
     printc(tecode[mnewroom[i],1]);
     if bool(mflag[i]) then printc(' *');
     newline;
    end;  {for i  to mergedclasses}
   printCustomAddon;
  finally; {with OutMergeClass}
   OutMergeClass.Free;
  end;
end;

procedure TMergedClasseswin.FormDblClick(Sender: TObject);
begin
 doubleclick:=true;
 MergedClasseswin.Change2Click(self);
end;

end.
