unit Newclass;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,tcommon3, Menus, Grids,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TNewClasseswin = class(TLineCodewin)
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N7: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    Copy1: TMenuItem;
    procedure Change2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDblClick(Sender: TObject);
  protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
  end;

var
  NewClasseswin: TNewClasseswin;


procedure NewClasseswinprint;
procedure NewClasseswinOut;

implementation
uses tcommon,tcommon2,ednewcls,main,printers,tcommon5;
{$R *.DFM}

 type TPrintNewClass=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutNewClass=class(TOutPutWin)
  public
   procedure head; override;
 end;

var
 PrintNewClass:    TPrintNewClass;
 OutNewClass:      TOutNewClass;

procedure CalcNewClasses;
var
 j,A: integer;
begin
 newclasses:=0;
 for j:=1 to nmbrnewclasses do
  begin
   ntime[j]:=0; nsub[j]:=0; nyear[j]:=0; nlevel[j]:=0;
   nstaff[j]:=0; nrooms[j]:=0; nflag[j]:=0;
  end;
 for j:=1 to nmbrChanges do
  begin
   if Changes[j].gen=2 then
   begin
    A:=Changes[j].reason;
    ntime[a]:=(ntime[a] or (1 shl Changes[j].timeslot));
    if nflag[a]=0 then nflag[a]:=Changes[j].timeslot;
    if nflag[a]=Changes[j].timeslot then
    begin
     nsub[a]:=Changes[j].sub; nyear[a]:=Changes[j].year; nlevel[a]:=Changes[j].level;
     if bool(Changes[j].needte) or bool(Changes[j].newte) then inc(nstaff[a]);
     if bool(Changes[j].needroom) then inc(nrooms[a]);
     if a>newclasses then newclasses:=a;
    end;
   end;
  end;
end;

procedure TNewClasseswin.setTabs;
begin
 SetLength(Tabs,8); CalcNewClasses;
 TotalCodes:=newclasses;
 if selcode>newclasses then selcode:=0;
 codeColor:=cpClass;
 headwidth:=canvas.textwidth('New Classes: 100');
 MaxTab(1,canvas.textwidth('100'),'No.:');
 MaxTab(2,periods*canvas.textwidth('W'),'Time Slots ');
 MaxTab(3,fwyearname,yearTitle);
 MaxTab(4,fwclass,'Class');
 MaxTab(5,fwcode[0],'Subject');
 MaxTab(6,0,'Teachers');
 MaxTab(7,0,'Rooms');
 maxW:=Tabs[7];
 maxH:=txtheight*(Totalcodes+4);
end;

procedure TNewClasseswin.PaintItem(i:integer;SelFlag:boolean);
var
 j,a: integer;
 astr: string;
begin
 printw(inttostr(i)+':');
 x:=Tabs[1];
  if (nstaff[i]=0) and (nrooms[i]=0) then
  begin
   printw('Not used');  fcolor(codecolor); exit;
  end;
 for j:=1 to tlimit[ttday] do
  begin
   if bool(ntime[i] and (1 shl j)) then astr:=tslotcode[j,ttday] else astr:='-';
   x:=Tabs[1]+((j-1)*letterW);  printwl(astr);
  end;
 if nyear[i]<>-1 then
  begin
   x:=Tabs[2]; printw(yearname[nyear[i]]);
  end;
 if (nlevel[i]>0) and (nyear[i]<>-1) then
  begin
   x:=Tabs[3];  a:=ClassShown[nlevel[i],nyear[i]];
   if a>0 then printw(ClassCode[a]);
  end;
  x:=Tabs[4]; printw(subcode[nsub[i]]);
  x:=Tabs[5]; printw(inttostr(nstaff[i]));
  x:=Tabs[6]; printw(inttostr(nrooms[i]));
  fcolor(codecolor);
end;

procedure TNewClasseswin.PaintHead;
begin
 printw2('New Classes: ',inttostr(totalcodes));
 newline;
 if TotalCodes<=0 then exit;
 fcolor(cpNormal);  printw('No.');
 x:=Tabs[1]; printw('Time Slots');
 x:=Tabs[2]; printw(Yeartitle);
 x:=Tabs[3]; printw('Class');
 x:=Tabs[4]; printw('Subject');
 x:=Tabs[5]; printw('Teachers');
 x:=Tabs[6]; printw('Rooms');
 newline;
end;





procedure TNewClasseswin.Change2Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  EdNewClass:=TEdNewClass.create(self);    {allocate dlg}
  EdNewClass.showmodal;
  EdNewClass.free;     {release dlg}
  CheckAccessRights(4,9,false);
 end;
end;

procedure TNewClasseswin.FormCreate(Sender: TObject);
begin
 doubleclick:=false;
 setWindowDefaults(self,wnNewClass)
end;

procedure TNewClasseswin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

{
-------------------- print procs follow ----------------------
}

procedure TPrintNewClass.SetTabs;
begin   {start of setprntTabs}
 setlength(PrntTabs,8);
 TotalCodes:=newclasses;
 codeColor:=cpClass;
 MaxTab(1,PrintCanvas.textwidth('100'),'No.:');
 MaxTab(2,periods*PrintCanvas.textwidth('W'),'Time Slots ');
 MaxTab(3,fwPrntyearname,yearTitle);
 MaxTab(4,fwPrntclass,'Class');
 MaxTab(5,fwPrntcode[0],'Subject');
 MaxTab(6,0,'Teachers');
 MaxTab(7,0,'Rooms');
end;


procedure TPrintNewClass.head;
begin
 UnderlineOn;
 printw2('New Classes: ',inttostr(totalcodes));
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(cpNormal);
 if TotalCodes>0 then
   begin
    printw('No.');
    x:=PrntTabs[1]; printw('Time Slots');
    x:=PrntTabs[2]; printw(Yeartitle);
    x:=PrntTabs[3]; printw('Class');
    x:=PrntTabs[4]; printw('Subject');
    x:=PrntTabs[5]; printw('Teachers');
    x:=PrntTabs[6]; printw('Rooms');
    x:=0; y:=y+PrnttxtHeight;;
   end;
end;


procedure NewClasseswinprint;
var
 astr:     string;
 i,j,a: integer;

begin
 PrintNewClass:=TPrintNewClass.Create;
 with PrintNewClass do
  try
   PrintHead;
   if TotalCodes>0 then
    for i:=1 to TotalCodes do
    begin
     printw(inttostr(i));
     x:=prnttabs[1];
     if (nstaff[i]=0) and (nrooms[i]=0) then
      begin
       printw('Not used');  newline;  continue;
      end;
     for j:=1 to tlimit[ttday] do
      begin
       if bool(ntime[i] and (1 shl j)) then astr:=tslotcode[j,ttday] else astr:='-';
       x:=PrntTabs[1]+((j-1)*letterWprnt);  printwl(astr);
      end;
     if nyear[i]<>-1 then
      begin
       x:=prnttabs[2]; printw(yearname[nyear[i]]);
      end;
      if (nlevel[i]>0) and (nyear[i]<>-1) then
      begin
       x:=prnttabs[3];  a:=ClassShown[nlevel[i],nyear[i]];
       if a>0 then
        printw(ClassCode[a]);
      end;
      x:=prnttabs[4]; printw(subcode[nsub[i]]);
      x:=prnttabs[5]; printw(inttostr(nstaff[i]));
      x:=prnttabs[6]; printw(inttostr(nrooms[i]));
      newline;
    end;  {for i  to totalcodes}
   printCustomAddon;
  finally; {with PrintLostClass}
   PrintNewClass.Free;
  end;
end;

procedure TOutNewClass.head;
begin
 printLine(['New Classes: ',inttostr(newclasses)]);
 if newclasses>0 then
    printLine(['No.','Time Slots',Yeartitle,'Class','Subject','Teachers','Rooms']);
end;


procedure NewClasseswinOut;
var
 astr,s:     string;
 i,j,a: integer;

begin
 OutNewClass:=TOutNewClass.Create;
 with OutNewClass do
  try
   Header;
   if newclasses>0 then
    for i:=1 to newclasses do
    begin
     printw(inttostr(i));
     if (nstaff[i]=0) and (nrooms[i]=0) then
      begin
       printc('Not used');  newline;  continue;
      end;
     s:='';
     for j:=1 to tlimit[ttday] do
      begin
       if bool(ntime[i] and (1 shl j)) then astr:=tslotcode[j,ttday] else astr:='-';
       s:=s+astr;
      end;
     printc(s);
     s:=''; if nyear[i]<>-1 then s:=yearname[nyear[i]];
     printc(s);
     s:='';
     if (nlevel[i]>0) and (nyear[i]<>-1) then
      begin
       a:=ClassShown[nlevel[i],nyear[i]];
       if a>0 then s:=ClassCode[a];
      end;
     printc(s);
     printc(subcode[nsub[i]]);
     printc(inttostr(nstaff[i]));
     printc(inttostr(nrooms[i]));
     newline;
    end;  {for i  to totalcodes}
   printCustomAddon;
  finally; {with PrintLostClass}
   OutNewClass.Free;
  end;
end;

procedure TNewClasseswin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_insert then NewClasseswin.Change2Click(self);
end;

procedure TNewClasseswin.FormDblClick(Sender: TObject);
begin
 doubleclick:=true;
 NewClasseswin.Change2Click(self);
end;

end.
