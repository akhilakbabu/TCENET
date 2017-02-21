unit Lostclss;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TLostClasseswin = class(TSelectCodeWin)
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N6: TMenuItem;
    View2: TMenuItem;
    N7: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    Copy1: TMenuItem;
    procedure Change2Click(Sender: TObject);
    procedure View2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
  LostClasseswin: TLostClasseswin;


procedure LostClasseswinprint;
procedure LostClasseswinOut;

implementation
uses tcommon,tcommon2,main,
     tcommon3,edlstcls,vwlstcls,printers,tcommon5;
{$R *.DFM}

const
 mycode=1;

 type TPrintLostClass=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutLostClass=class(TOutCodeWin)
  public
   procedure head; override;
   function CodeToPrint(i:integer):string; override;
 end;

var
 PrintLostClass:    TPrintLostClass;
 OutLostClass:      TOutLostClass;
 TeUseAvail:        tpexdata;

procedure CalcUseAvail;
var
 i: integer;
begin
 for i:= 0 to nmbrTeachers do TeUseAvail[i]:=0;
 if numchanges>0 then
  for i:=1 to numchanges do
   begin
    if Changes[i].kind=2
     then TeUseAvail[Changes[i].newte]:=TeUseAvail[Changes[i].newte]+
       getEallot(1,Changes[i].year,ttday,Changes[i].timeslot)
   end;

end;

function TLostClasseswin.ItemIsSelected(k:integer):boolean;
begin
 result:=(teLost[k]<>-1);
end;

function TLostClasseswin.BasicPoint(k:integer):integer;
begin
 result:=lccodepoint[k];
end;



procedure TLostClasseswin.SetTabs;
begin
 setlength(Tabs,8); 
 MaxItemPoint:=codenum[mycode];  CalcItemPoint;  CalcUseAvail;
 headwidth:=canvas.textwidth('Teachers with Lost Classes: 99    Shared Classes Excluded');
 CodeWidth:=fwCode[mycode]+blankWidth;
 CalcScreenCodeFit;
 maxTab(1,Codewidth,'Code');
 maxTab(2,fwCodename[mycode],'Name ');
 case winView[wnLostClass] of
   0: maxW:=CodeWidth*CodeFit;  {codes}
  1,2: begin  {code + name}
        maxTab(3,periods*canvas.textwidth('W'),'Load');
        maxTab(4,fwTeComment,'Comment');
        maxTab(5,canvas.textwidth('Lost'),'22.22 ');
        maxTab(6,canvas.textwidth('Replace'),'22.22 ');
        maxTab(7,canvas.textwidth('Available'),'22.22 ');
        maxW:=Tabs[7];
       end;
 end; {case}
end;

procedure TLostClasseswin.PaintHead;
begin
 codeColor:=cpTeach; {teacher} codeColor2:=cpAbsentSel; {red on white}
 {Headings}
 fcolor(cpNormal);
 printw2('Teachers with Lost Classes: ',inttostr(lostclasses));
 if shareExclude then printw('    Shared Classes excluded')
     else printw('    Shared Classes included');
 newline;
 if TotalCodes>0 then
  if winView[wnLostClass]>=1 then
   begin
    fcolor(cpNormal);  printw('Code ');
    x:=Tabs[1]; printw('Name');
    x:=Tabs[2]; printw('Load');
    x:=Tabs[3]; printw('Comment');
    x:=Tabs[4]; printw('Lost');
    x:=Tabs[5]; printw('Replace');
    x:=Tabs[6]; printw('Available');
    newline;
   end;
end;

procedure TLostClasseswin.PaintItem(i:integer;SelFlag:boolean);
var
 k:    integer;
 s: string;
begin
 k:=ItemPoint[i];
 case winView[wnLostClass] of
   0: printw(tecode[k,0]);  {codes only}
   1,2: begin  {code + name}
         printw(tecode[k,0]);
         x:=Tabs[1]; printw(tename[k,0]);
         x:=Tabs[2]; printMap(temap[k]);
         x:=Tabs[3];  printw(Ecomment[k]);
         x:=Tabs[4]; str(teAvail[k]+TeUseAvail[k]:4:2,s); printw(s);
         x:=Tabs[5]; str(TeUseAvail[k]:4:2,s); printw(s);
         x:=Tabs[6]; str(teAvail[k]:4:2,s); printw(s);
      end;
  end;
 fcolor(codecolor);
end;



procedure TLostClasseswin.Change2Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  EdLostClasses:=TEdLostClasses.create(self);   {allocate dlg}
  EdLostClasses.showmodal;
  EdLostClasses.free;
  CheckAccessRights(4,9,false);
 end;
end;

procedure TLostClasseswin.View2Click(Sender: TObject);
begin
 if selCode>0 then selCode2:=itemPoint[selCode];
 viewlostclasses:=Tviewlostclasses.create(self);   {allocate dlg}
 viewlostclasses.Show.ItemIndex:=winView[wnLostClass];
 viewlostclasses.Sort.ItemIndex:=lcsorttype;
 viewlostclasses.showmodal;
 viewlostclasses.free;
end;

procedure TLostClasseswin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TLostClasseswin.FormCreate(Sender: TObject);
begin
 doubleclick:=false;
 setWindowDefaults(self,wnLostClass);
 updatelostclassesCount;
end;

procedure TLostClasseswin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_insert then LostClasseswin.Change2Click(self);
end;


procedure TLostClasseswin.FormResize(Sender: TObject);
begin
  Self.SetTabs;
  Refresh;
end;

{
---------------------- print procs follow -----------------------
}

procedure TPrintLostClass.SetTabs;
begin   {start of setprntTabs}
 setlength(PrntTabs,8);
 TotalCodes:=codenum[mycode];
 CodeWidth:=fwPrntCode[mycode]+prntBlankwidth;
 maxTab(1,Codewidth,'Code');
 maxTab(2,fwPrntCodename[mycode],'Name ');
 case winView[wnLostClass] of
 0: CalcPrintCodeFit;  {codes}
 1,2: begin  {code + name}
        maxTab(3,periods*PrintCanvas.textwidth('W'),'Load');
        maxTab(4,fwPrntTeComment,'Comment');
        maxTab(5,PrintCanvas.textwidth('Lost'),'22.22 ');
        maxTab(6,PrintCanvas.textwidth('Replace'),'22.22 ');
        maxTab(7,PrintCanvas.textwidth('Available'),'22.22 ');
       end;
 end; {case}
end;


procedure TPrintLostClass.head;
begin
 UnderlineOn;
 codeColor:=cpTeach;
 printw2('Teachers with Lost Classes: ',inttostr(lostclasses));
 if shareExclude then printwl('    Shared Classes excluded')
     else printwl('    Shared Classes included');
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(cpNormal);
 if TotalCodes>0 then
  if winView[wnLostClass]>=1 then
   begin
    printw('Code ');
    x:=prntTabs[1]; printw('Name');
    x:=prntTabs[2]; printw('Load');
    x:=prntTabs[3]; printw('Comment');
    x:=prntTabs[4]; printw('Lost');
    x:=prntTabs[5]; printw('Replace');
    x:=prntTabs[6]; printw('Available');
    x:=0; y:=y+PrnttxtHeight;;
   end;
end;




procedure LostClasseswinprint;
var
 i,k,codeColor2: integer;
 s: string;
begin
 codeColor2:=cpAbsentSel;
 PrintLostClass:=TPrintLostClass.Create;
 with PrintLostClass do
  try
   PrintHead;
   code:=1;
   if TotalCodes>0 then
   for i:=1 to TotalCodes do
    begin
     k:=lccodepoint[i];
     if teLost[k]=-1 then fcolor(codecolor) else fcolor(codecolor2);
     if winView[wnLostClass]=2 then  {only show absent ones}
        if teLost[k]=-1 then continue;
     case winView[wnLostClass] of
      0: begin
          printw(tecode[k,0]);
          x:=(i mod codefit)*CodeWidth;
          if (i mod codefit)=0 then newline;
         end;
      1,2: begin  {code + name}
            printw(tecode[k,0]);
            x:=prntTabs[1]; printw(tename[k,0]);
            x:=prntTabs[2]; printMap(temap[k]);
            x:=prntTabs[3];  printw(Ecomment[k]);
            x:=prntTabs[4]; str(teAvail[k]+TeUseAvail[k]:4:2,s); printw(s);
            x:=prntTabs[5]; str(TeUseAvail[k]:4:2,s); printw(s);
            x:=prntTabs[6]; str(teAvail[k]:4:2,s); printw(s);
            newline;
           end;
     end;  {case}
    end;  {for i  to totalcodes}
    newline;
   printCustomAddon;
  finally; {with PrintLostClass}
   PrintLostClass.Free;
  end;
end;

procedure TOutLostClass.head;
begin
 printw('Teachers with Lost Classes:');
 printc(inttostr(lostclasses));
 if shareExclude then printc(' Shared Classes excluded')
     else printc(' Shared Classes included');
 newline;
 if TotalCodes>0 then
  if winView[wnLostClass]>=1 then
    printLine(['Code ','Name','Load','Comment','Lost','Replace','Available']);
end;

function TOutLostClass.CodeToPrint(i:integer):string;
begin
 result:=tecode[lccodepoint[i],0];
end;


procedure LostClasseswinOut;
var
 i,k: integer;
 s1,s2,s3: string;
begin
 OutLostClass:=TOutLostClass.Create;
 with OutLostClass do
  try
   Setup(codenum[mycode]);
   if TotalCodes>0 then
   for i:=1 to TotalCodes do
    begin
     k:=lccodepoint[i];
     if winView[wnLostClass]=2 then  {only show absent ones}
        if teLost[k]=-1 then continue;
     case winView[wnLostClass] of
      0: PrintCode(i);
      1,2: begin  {code + name}
            str(teAvail[k]+TeUseAvail[k]:4:2,s1);
            str(TeUseAvail[k]:4:2,s2);
            str(teAvail[k]:4:2,s3);
            printLine([tecode[k,0],tename[k,0],temap[k],Ecomment[k],s1,s2,s3]);
           end;
     end;  {case}
    end;  {for i  to totalcodes}
    newline;
   printCustomAddon;
  finally; {with OutLostClass}
   OutLostClass.Free;
  end;
end;


procedure TLostClasseswin.FormDblClick(Sender: TObject);
begin
 doubleclick:=true;
 LostClasseswin.change2click(self);
end;

end.

