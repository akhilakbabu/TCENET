unit Roomswap;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, StdCtrls,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  Troomswaps = class(TSelectCodeWin)
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N6: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    N1: TMenuItem;
    View1: TMenuItem;
    Copy1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Change2Click(Sender: TObject);
    procedure View1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
    function ItemIsSelected(k:integer):boolean; override;
    function BasicPoint(k:integer):integer; override;
  end;

var
  roomswaps: Troomswaps;
  TotalCodes:   integer;

procedure roomswapsprint;
procedure roomswapsOut;

implementation
uses tcommon,tcommon2,edroswap,main,tcommon3,printers,vwroswap,tcommon5;
{$R *.DFM}

const
 mycode=2;

 type TPrintRoomSwapWin=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutRoomSwapWin=class(TOutCodeWin)
  public
   procedure head; override;
   function CodeToPrint(i:integer):string; override;
 end;

var
 PrintRoomSwapWin:    TPrintRoomSwapWin;
 OutRoomSwapWin:     TOutRoomSwapWin;

function Troomswaps.ItemIsSelected(k:integer):boolean;
begin
 result:=(roswap[k]<>-1);
end;

function Troomswaps.BasicPoint(k:integer):integer;
begin
 result:=codepoint[k,mycode];
end;

procedure Troomswaps.SetTabs;
begin
 setlength(Tabs,4); updateRoomMap;
 updateSwappedClassesCnt;
 MaxItemPoint:=codenum[mycode];
 CalcItemPoint;
 headwidth:=canvas.textwidth('Room Codes: 999    Rooms Swapped: 999 ');
 CodeWidth:=fwCode[mycode]+blankWidth;
 CalcScreenCodeFit;
 maxTab(1,Codewidth,'Code');
 maxTab(2,fwCodename[mycode],'Name ');
 case winView[wnRoomSwap] of
   0: maxW:=CodeWidth*CodeFit;  {codes}
  1,2: begin  {code + name}
        maxTab(3,periods*canvas.textwidth('W'),'Load');
        maxW:=Tabs[3];
       end;
 end; {case}
end;

procedure Troomswaps.PaintHead;
begin
 codeColor:=cpRoom; {room} codeColor2:=cpAbsentSel; {red on white}
 {Headings}
 fcolor(cpNormal);
 printw2('Rooms: ',inttostr(codenum[mycode]));
 printw2('    Swapped Rooms:',inttostr(roomSwapsCnt));
 newline;
 if TotalCodes>0 then
  if winView[wnRoomSwap]>=1 then
   begin
    fcolor(cpNormal);  printw('Code ');
    x:=Tabs[1]; printw('Name');
    x:=Tabs[2]; printw('Load');
    newline;
   end;
end;

procedure Troomswaps.PaintItem(i:integer;SelFlag:boolean);
var
 k:    integer;
begin
 k:=ItemPoint[i];
 case winView[wnRoomSwap] of
   0: printw(tecode[k,1]);  {codes only}
   1,2: begin  {code + name}
         printw(tecode[k,1]);
         x:=Tabs[1]; printw(tename[k,1]);
         x:=Tabs[2]; printMap(romap[k]);
      end;
  end;
 fcolor(codecolor);
end;

procedure Troomswaps.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure Troomswaps.FormCreate(Sender: TObject);
begin
 doubleclick:=false;
 setWindowDefaults(self,wnRoomSwap);
end;

procedure Troomswaps.Change2Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  edroomswaps:=Tedroomswaps.create(self);   {allocate dlg}
  edroomswaps.showmodal;
  edroomswaps.free;
  CheckAccessRights(4,9,false);
 end;
end;

{
-------------------- print procs follow -----------------
}

procedure TPrintRoomSwapWin.SetTabs;
begin   {start of setprntTabs}
 setlength(PrntTabs,4);
 TotalCodes:=codenum[mycode];
 CodeWidth:=fwPrntCode[mycode]+prntBlankwidth;
 maxTab(1,Codewidth,'Code');
 maxTab(2,fwPrntCodename[mycode],'Name ');
 case winView[wnRoomSwap] of
   0: CalcPrintCodeFit;  {codes}
  1,2: begin  {code + name}
        maxTab(3,periods*PrintCanvas.textwidth('W'),'Load');
       end;
 end; {case}
end;

procedure TPrintRoomSwapWin.head;
begin
 UnderlineOn;
  codeColor:=cpRoom; fcolor(CodeColor);
 printw2('Rooms: ',inttostr(codenum[mycode]));
 printw2('    Swapped Rooms:',inttostr(roomSwapsCnt));
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(cpNormal);
 if TotalCodes>0 then
  if winView[wnRoomSwap]>=1 then
   begin
    printw('Code ');
    x:=prntTabs[1]; printw('Name');
    x:=prntTabs[2]; printw('Load');
    x:=0; y:=y+PrnttxtHeight;;
   end;
end;

procedure roomswapsprint;
var
 i,k,codeColor2: integer;

begin
 codeColor2:=cpAbsentSel;
 PrintRoomSwapWin:=TPrintRoomSwapWin.Create;
 with PrintRoomSwapWin do
  try
   PrintHead;
   if TotalCodes>0 then
   for i:=1 to TotalCodes do
    begin
     k:=codepoint[i,mycode];
     if roswap[k]=-1 then fcolor(codecolor) else fcolor(codecolor2);
     if winView[wnRoomSwap]=2 then  {only show swapped ones}
        if roswap[k]=-1 then continue;
     case winView[wnRoomSwap] of
      0: begin
          printw(tecode[k,1]);
          x:=(i mod codefit)*CodeWidth;
          if (i mod codefit)=0 then newline;
         end;
      1,2: begin  {code + name}
            printw(tecode[k,1]);
            x:=prntTabs[1]; printw(tename[k,1]);
            x:=prntTabs[2]; printMap(romap[k]);
            newline;
           end;
     end;  {case}
    end;  {for i  to totalcodes}
   newline;
   printCustomAddon;
  finally; {with PrintAbsentTeWin}
   PrintRoomSwapWin.Free;
  end;

end; {formpaint}

procedure TOutRoomSwapWin.head;
begin
 printLine(['Rooms:',inttostr(codenum[mycode]),'Swapped Rooms:',inttostr(roomSwapsCnt)]);
 if TotalCodes>0 then
  if winView[wnRoomSwap]>=1 then
    printLine(['Code','Name','Load']);
end;

function TOutRoomSwapWin.CodeToPrint(i:integer):string;
begin
 result:=tecode[codepoint[i,mycode],1];
end;

procedure roomswapsOut;
var
 i,k: integer;
begin
 OutRoomSwapWin:=TOutRoomSwapWin.Create;
 with OutRoomSwapWin do
  try
   Setup(codenum[mycode]);
   if TotalCodes>0 then
   for i:=1 to TotalCodes do
    begin
     k:=codepoint[i,mycode];
     if winView[wnRoomSwap]=2 then  {only show swapped ones}
        if roswap[k]=-1 then continue;
     case winView[wnRoomSwap] of
      0: PrintCode(i);
      1,2: begin  {code + name}
            printLine([tecode[k,1],tename[k,1],romap[k]]);
           end;
     end;  {case}
    end;  {for i  to totalcodes}
   newline;
   printCustomAddon;
  finally; {with OutRoomSwapWin}
   OutRoomSwapWin.Free;
  end;

end;

procedure Troomswaps.View1Click(Sender: TObject);
begin
  viewRoomSwapsdlg:=TviewRoomSwapsdlg.create(self);    {allocate dlg}
  viewRoomSwapsdlg.showmodal;
  viewRoomSwapsdlg.free;     {release dlg}
end;

procedure Troomswaps.FormDblClick(Sender: TObject);
begin
 doubleclick:=true;
 roomswaps.Change2Click(self);
end;

procedure Troomswaps.FormResize(Sender: TObject);
begin
  Self.SetTabs;
  Refresh;
end;

end.
