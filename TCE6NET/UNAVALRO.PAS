unit Unavalro;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  Tunavailablerooms = class(TSelectCodeWin)
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N6: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    N1: TMenuItem;
    View1: TMenuItem;
    Copy1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Change2Click(Sender: TObject);
    procedure View1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
    function ItemIsSelected(k:integer):boolean; override;
    function BasicPoint(k:integer):integer; override;
  end;


var
  unavailablerooms: Tunavailablerooms;

procedure unavailableroomsprint;
procedure unavailableroomsOut;

implementation
uses tcommon,tcommon2,edunvlro,main,tcommon3,printers,vwunavro,tcommon5;
{$R *.DFM}
const mycode=2;

 type TPrintRoomUnavailWin=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutRoomUnavailWin=class(TOutCodeWin)
  public
   procedure head; override;
   function CodeToPrint(i:integer):string; override;
 end;

var
 PrintRoomUnavailWin:    TPrintRoomUnavailWin;
 OutRoomUnavailWin:      TOutRoomUnavailWin;

function Tunavailablerooms.ItemIsSelected(k:integer):boolean;
begin
 result:=(roAbsent[k]<>-1);
end;

function Tunavailablerooms.BasicPoint(k:integer):integer;
begin
 result:=codepoint[k,mycode];
end;

procedure Tunavailablerooms.SetTabs;
begin
 setlength(Tabs,4); updateRoomMap;
 updateUnavailableClassesCnt;
 MaxItemPoint:=codenum[mycode];
 CalcItemPoint;
 headwidth:=canvas.textwidth('Room Codes: 999    Unavailable Rooms: 999 ');
 CodeWidth:=fwCode[mycode]+blankWidth;
 CalcScreenCodeFit;
 maxTab(1,Codewidth,'Code');
 maxTab(2,fwCodename[mycode],'Name ');
 case winView[wnUnavailRooms] of
   0: maxW:=CodeWidth*CodeFit;  {codes}
  1,2: begin  {code + name}
        maxTab(3,periods*canvas.textwidth('W'),'Load');
        maxW:=Tabs[3];
       end;
 end; {case}
end;

procedure Tunavailablerooms.PaintHead;
begin
 codeColor:=cpRoom; {room} codeColor2:=cpAbsentSel; {red on white}
 {Headings}
 fcolor(cpNormal);
 printw2('Rooms: ',inttostr(codenum[mycode]));
 printw2('    Unavailable Rooms:',inttostr(UnavailableClassesCnt));
 newline;
 if TotalCodes>0 then
  if winView[wnUnavailRooms]>=1 then
   begin
    fcolor(cpNormal);  printw('Code ');
    x:=Tabs[1]; printw('Name');
    x:=Tabs[2]; printw('Load');
    newline;
   end;
end;

procedure Tunavailablerooms.PaintItem(i:integer;SelFlag:boolean);
var
 k:    integer;
begin
 k:=ItemPoint[i];
 case winView[wnUnavailRooms] of
   0: printw(tecode[k,1]);  {codes only}
   1,2: begin  {code + name}
         printw(tecode[k,1]);
         x:=Tabs[1]; printw(tename[k,1]);
         x:=Tabs[2]; printMap(romap[k]);
      end;
  end;
 fcolor(codecolor);
end;

procedure Tunavailablerooms.FormCreate(Sender: TObject);
begin
 doubleclick:=false;
 setWindowDefaults(self,wnUnavailRooms);
end;

procedure Tunavailablerooms.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure Tunavailablerooms.Change2Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  edunavailablerooms:=Tedunavailablerooms.create(self);   {allocate dlg}
  edunavailablerooms.showmodal;
  edunavailablerooms.free;
  CheckAccessRights(4,9,false);
 end;
end;

procedure Tunavailablerooms.FormResize(Sender: TObject);
begin
  Self.SetTabs;
  Refresh;
end;

{
---------------- print procs follow ----------------------------
}

procedure TPrintRoomUnavailWin.SetTabs;
begin   {start of setprntTabs}
 setlength(PrntTabs,4);
 TotalCodes:=codenum[mycode];
 CodeWidth:=fwPrntCode[mycode]+prntBlankwidth;
 maxTab(1,Codewidth,'Code');
 maxTab(2,fwPrntCodename[mycode],'Name ');
 case winView[wnUnavailRooms] of
   0: CalcPrintCodeFit;  {codes}
  1,2: begin  {code + name}
        maxTab(3,periods*PrintCanvas.textwidth('W'),'Load');
       end;
 end; {case}
end;

procedure TPrintRoomUnavailWin.head;
begin
 UnderlineOn;
 codeColor:=cpRoom; fcolor(codeColor);
 printw2('Rooms: ',inttostr(codenum[mycode]));
 printw2('    Unavailable Rooms:',inttostr(UnavailableClassesCnt));
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(cpNormal);
 if TotalCodes>0 then
  if winView[wnUnavailRooms]>=1 then
   begin
    printw('Code ');
    x:=prntTabs[1]; printw('Name');
    x:=prntTabs[2]; printw('Load');
    x:=0; y:=y+PrnttxtHeight;;
   end;
end;

procedure unavailableroomsprint;
var
 i,k,codeColor2: integer;

begin
 codeColor2:=cpAbsentSel;
 PrintRoomUnavailWin:=TPrintRoomUnavailWin.Create;
 with PrintRoomUnavailWin do
  try
   PrintHead;
   if TotalCodes>0 then
   for i:=1 to TotalCodes do
    begin
     k:=codepoint[i,mycode];
     if roAbsent[k]=-1 then fcolor(codeColor) else fcolor(codeColor2);
     if winView[wnUnavailRooms]=2 then  {only show swapped ones}
        if roAbsent[k]=-1 then continue;
     case winView[wnUnavailRooms] of
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
   PrintRoomUnavailWin.Free;
  end;
end; {formpaint}

procedure TOutRoomUnavailWin.head;
begin
 printLine(['Rooms: ',inttostr(codenum[mycode]),'Unavailable Rooms:',inttostr(UnavailableClassesCnt)]);
 if TotalCodes>0 then
  if winView[wnUnavailRooms]>=1 then
    printLine(['Code','Name','Load']);
end;

function TOutRoomUnavailWin.CodeToPrint(i:integer):string;
begin
 result:=tecode[codepoint[i,mycode],1];
end;

procedure unavailableroomsOut;
var
 i,k: integer;

begin
 OutRoomUnavailWin:=TOutRoomUnavailWin.Create;
 with OutRoomUnavailWin do
  try
   Setup(codenum[mycode]);
   if TotalCodes>0 then
   for i:=1 to TotalCodes do
    begin
     k:=codepoint[i,mycode];
     if winView[wnUnavailRooms]=2 then  {only show swapped ones}
        if roAbsent[k]=-1 then continue;
     case winView[wnUnavailRooms] of
      0: PrintCode(i);
      1,2: begin  {code + name}
            printLine([tecode[k,1],tename[k,1],romap[k]]);
           end;
     end;  {case}
    end;  {for i  to totalcodes}
   newline;
   printCustomAddon;
  finally; {with OutRoomUnavailWin}
   OutRoomUnavailWin.Free;
  end;
end;

procedure Tunavailablerooms.View1Click(Sender: TObject);
begin
  viewUnavailRoomsdlg:=TviewUnavailRoomsdlg.create(self);    {allocate dlg}
  viewUnavailRoomsdlg.showmodal;
  viewUnavailRoomsdlg.free;     {release dlg}
end;

procedure Tunavailablerooms.FormDblClick(Sender: TObject);
begin
 doubleclick:=true;
 unavailablerooms.Change2Click(self);
end;

end.
