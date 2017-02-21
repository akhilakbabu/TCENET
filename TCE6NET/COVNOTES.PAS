unit Covnotes;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  Tcovernoteswin = class(TLineCodewin)
    MainMenu1: TMainMenu;
    Codes1: TMenuItem;
    Change1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N7: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    N1: TMenuItem;
    SelectCode1: TMenuItem;
    Teacher1: TMenuItem;
    AddedStaff1: TMenuItem;
    Times1: TMenuItem;
    AbsenceReason1: TMenuItem;
    CoverNote1: TMenuItem;
    Copy1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Change1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Teacher1Click(Sender: TObject);
    procedure AddedStaff1Click(Sender: TObject);
    procedure Times1Click(Sender: TObject);
    procedure AbsenceReason1Click(Sender: TObject);
    procedure CoverNote1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure SelectCode1Click(Sender: TObject);
  protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
  end;

var
  covernoteswin: Tcovernoteswin;

procedure covernoteswinprint;
procedure CoverNotesWinOut;

implementation
uses tcommon,tcommon2,covntdlg,main,tcommon5;
{$R *.DFM}

 type TPrintCoverNoteWin=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutCoverNoteWin=class(TOutPutWin)
  public
   procedure head; override;
 end;

var
 PrintCoverNoteWin:    TPrintCoverNoteWin;
 OutCoverNoteWin:      TOutCoverNoteWin;

procedure Tcovernoteswin.setTabs;
begin
 SetLength(Tabs,3);
 TotalCodes:=nmbrcoverinuse;
 if selcode>nmbrcoverinuse then selcode:=0;
 codeColor:=cpClass;
 headwidth:=canvas.textwidth(caption+': 99');
 MaxTab(1,0,'WWW');
 MaxTab(2,fwCoverNote,'Note ');
 maxW:=Tabs[2];
 if maxW<Headwidth then maxW:=Headwidth;
 maxH:=txtheight*(Totalcodes+4);
end;

procedure Tcovernoteswin.PaintItem(i:integer;SelFlag:boolean);
begin
 printw(inttostr(i)+':');
 x:=Tabs[1]; printw(Cover[i]);
 fcolor(codecolor);
end;

procedure Tcovernoteswin.PaintHead;
begin
 printw2(caption+': ',inttostr(TotalCodes));
 newline;  fcolor(cpNormal);
 printw('No.');
 x:=Tabs[1]; printw('Note');
 newline;
end;


procedure Tcovernoteswin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:= caFree;
end;

procedure Tcovernoteswin.Change1Click(Sender: TObject);
begin
 if CheckAccessRights(4,4,true) then
 begin
  covernotesdlg:=Tcovernotesdlg.create(self);   {allocate dlg}
  covernotesdlg.showmodal;
  covernotesdlg.free;
  CheckAccessRights(4,4,false);
 end;
end;

procedure Tcovernoteswin.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnCoverNote);
end;


{
-------------- print procs follow --------------------
}

procedure TPrintCoverNoteWin.SetTabs;
begin
 SetLength(PrntTabs,3);
 TotalCodes:=nmbrcoverinuse;
 codeColor:=cpClass;
 MaxTab(1,0,'WWW');
 MaxTab(2,fwCoverNote,'Note ');
end;

procedure TPrintCoverNoteWin.head;
begin
 UnderlineOn;
 printw2('Extras Cover Notes: ',inttostr(TotalCodes));
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(cpNormal);
 printw('No.');
 x:=PrntTabs[1]; printw('Note');
 x:=0; y:=y+2*PrnttxtHeight;
end;

procedure covernoteswinprint;
var
 i: integer;
begin
 PrintCoverNoteWin:=TPrintCoverNoteWin.Create;
 with PrintCoverNoteWin do
  try
   PrintHead;
   if TotalCodes<=0 then exit;
   fcolor(codecolor);
   for i:=1 to TotalCodes do
   begin
    printw(inttostr(i)+':');
    x:=PrntTabs[1]; printw(Cover[i]);
    newline;
   end;  {for i  to totalcodes}
   printCustomAddon;
 finally
  PrintCoverNoteWin.free;
 end;
end;

procedure TOutCoverNoteWin.head;
begin
 printLine(['Extras Cover Notes: ',inttostr(nmbrcoverinuse)]);
 printLine(['No.','Note']);
 newline;
end;

procedure CoverNotesWinOut;
var
 i: integer;
begin
 OutCoverNoteWin:=TOutCoverNoteWin.Create;
 with OutCoverNoteWin do
  try
   Header;
   if nmbrcoverinuse<=0 then exit;
   for i:=1 to nmbrcoverinuse do printLine([inttostr(i),Cover[i]]);
   printCustomAddon;
 finally
  OutCoverNoteWin.free;
 end;
end;

procedure Tcovernoteswin.Teacher1Click(Sender: TObject);
begin
 TeWinSelect;
end;

procedure Tcovernoteswin.AddedStaff1Click(Sender: TObject);
begin
  AddedStaffWinSelect;
end;

procedure Tcovernoteswin.Times1Click(Sender: TObject);
begin
 TimesWinSelect;
end;

procedure Tcovernoteswin.AbsenceReason1Click(Sender: TObject);
begin
 absreasonswinselect;
end;

procedure Tcovernoteswin.CoverNote1Click(Sender: TObject);
begin
 covernoteswinselect;
end;

procedure Tcovernoteswin.FormDblClick(Sender: TObject);
begin
 doubleclick:=true;
 Change1Click(self);
end;

procedure Tcovernoteswin.SelectCode1Click(Sender: TObject);
begin
 TickCodeSubMenu(SelectCode1);
end;

end.
