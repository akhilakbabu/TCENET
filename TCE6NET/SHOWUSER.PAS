unit Showuser;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs, GlobalToTcAndTcextra, XML.USERS;

type
  TShowUsersWin = class(TCodeWin)
    PopupMenu1: TPopupMenu;
    add2: TMenuItem;
    Change2: TMenuItem;
    Delete2: TMenuItem;
    N6: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    Copy1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure add2Click(Sender: TObject);
    procedure Change2Click(Sender: TObject);
    procedure Delete2Click(Sender: TObject);
  protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
  end;

 procedure ShowUsersWinPrint;
 procedure ShowUsersWinOut;

var
  ShowUsersWin: TShowUsersWin;



implementation
uses tceload,tcommon,tcommon2,tcommon3,main,printers,tceglobals,tcommon5;
{$R *.DFM}

 type TPrintShowUsersWin=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutShowUsersWin=class(TOutCodeWin)
  public
   procedure head; override;
   function CodeToPrint(i:integer):string; override;
 end;

var
 PrintShowUsersWin: TPrintShowUsersWin;
 OutShowUsersWin: TOutShowUsersWin;

procedure TShowUsersWin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:= caFree;
end;

procedure TShowUsersWin.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnShowUsers)
end;


procedure TShowUsersWin.PaintHead;
begin
 codeColor:=cpTeach; {teacher}
 {Headings}
  printw2('Users: ',inttostr(UserRecordsCount));
  newline;
  if TotalCodes>0 then
    case winView[wnShowUsers] of
     1: begin  {code + name}
          fcolor(cpNormal); printwl('User ID');
          x:=Tabs[1]; printw('Access level');
          x:=Tabs[2]; printw('User display directory');
        end;
    end;
  newline;
end;

function getUsernameMaxWidths(mycanvas:Tcanvas):smallint;
var
 mw,i,a: smallint;
begin
 mw:=10;
 if UserRecordsCount>0 then
  for i:=1 to UserRecordsCount do
  begin
   a:=mycanvas.textwidth(passID[i]);
   if a>mw then mw:=a;
  end;
 result:=mw;
end;

function getUserDirMaxWidths(mycanvas:Tcanvas):smallint;
var
 mw,i,a: smallint;
begin
 mw:=10;
 if UserRecordsCount>0 then
  for i:=1 to UserRecordsCount do
  begin
   a:=mycanvas.textwidth(passUserDir[i]);
   if a>mw then mw:=a;
  end;
 result:=mw;
end;

procedure TShowUsersWin.setTabs;
begin
 codecolor:=cpTeach;
 setlength(Tabs,4);
 TotalCodes:=UserRecordsCount;
 headwidth:=canvas.textwidth('User ID    Access level   User display directory');
 CodeWidth:=getUsernameMaxWidths(canvas)+blankWidth;
 CalcScreenCodeFit;
 maxTab(1,Codewidth,'User ID ');
 maxTab(2,1,'Access level ');
 case winView[wnShowUsers] of
  0: maxW:=CodeWidth*CodeFit;  {codes}
  1: begin  {code + dir}
      maxW:=Tabs[2]+getUserDirMaxWidths(canvas)+blankwidth;
      Tabs[3]:=maxW;
     end;
 end; {case}
end;

procedure TShowUsersWin.PaintItem(i:integer;SelFlag:boolean);
begin
 case winView[wnShowUsers] of
   0: printw(passID[i]);  {codes only}
   1: begin  {code + dir}
        printw(passID[i]);
        x:=Tabs[1]; printw(accessType[passLevel[i]]);
        x:=Tabs[2]; printw(passUserDir[i]);
      end;
  end;
 fcolor(codecolor);
end;


procedure TShowUsersWin.add2Click(Sender: TObject);
begin
 MainForm.adduser1Click(self)
end;

procedure TShowUsersWin.Change2Click(Sender: TObject);
begin
 MainForm.edituser1Click(self)
end;

procedure TShowUsersWin.Delete2Click(Sender: TObject);
begin
 MainForm.deleteuser1Click(self)
end;





{------------- print procs follow -----------------------}


procedure TPrintShowUsersWin.setTabs;
begin
 codecolor:=cpTeach;
 setlength(PrntTabs,4);
 TotalCodes:=UserRecordsCount;
 CodeWidth:=getUsernameMaxWidths(PrintCanvas)+PrntBlankWidth;
 CalcPrintCodeFit;
 maxTab(1,Codewidth,'User ID ');
 maxTab(2,1,'Access level ');
end;

procedure TPrintShowUsersWin.head;
begin
 fcolor(cpNormal);
 UnderlineOn;
 printw2('Users: ',inttostr(UserRecordsCount));
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 if winView[wnShowUsers]=1 then
  begin  {code + name}
   printwl('User ID');
   x:=PrntTabs[1]; printw('Access level');
   x:=PrntTabs[2]; printw('User display directory');
  end;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(codeColor);
end;


procedure ShowUsersWinPrint;
var
 i: integer;
begin
 PrintShowUsersWin:=TPrintShowUsersWin.Create;
 with PrintShowUsersWin do
  try
   PrintHead;
   code:=1;
   if TotalCodes>0 then
    for i:=1 to TotalCodes do
     case winView[wnShowUsers] of
      0: begin   {codes only}
          printw(passID[i]);
          x:=(i mod codefit)*CodeWidth;
          if (i mod codefit)=0 then newline;
         end;
      1: begin  {code + dir}
          printw(passID[i]);
          x:=prntTabs[1]; printw(accessType[passLevel[i]]);
          x:=prntTabs[2]; printw(passUserDir[i]);
          newline;
         end;
     end;
    newline; fcolor(cpNormal);
   printCustomAddon;
  finally;
   PrintShowUsersWin.Free;
  end;
end;




procedure TOutShowUsersWin.head;
begin
 printLine(['Users: ',inttostr(UserRecordsCount)]);
 if winView[wnShowUsers]=1 then
   PrintLine(['User ID','Access level','User display directory'])
  else newline;
end;

function TOutShowUsersWin.CodeToPrint(i:integer):string;
begin
 result:=passID[i];
end;

procedure ShowUsersWinOut;
var
 i: integer;
begin
 OutShowUsersWin:=TOutShowUsersWin.Create;
 with OutShowUsersWin do
  try
   Setup(UserRecordsCount);
   if TotalCodes>0 then
   for i:=1 to TotalCodes do
    begin
     case winView[wnShowUsers] of
      0: PrintCode(i);
      1: printLine([passID[i],accessType[passLevel[i]],passUserDir[i]]);
     end;  {case}
    end;  {for i  to totalcodes}
    newline;
   printCustomAddon;
  finally; {with OutShowUsersWin}
   OutShowUsersWin.Free;
  end;
end;


end.
