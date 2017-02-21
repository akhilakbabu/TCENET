unit Absrsn;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TAbsReasonWin = class(TLineCodewin)
    MainMenu1: TMainMenu;
    Codes1: TMenuItem;
    Change1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N7: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    SelectCode1: TMenuItem;
    Teacher1: TMenuItem;
    AddedStaff1: TMenuItem;
    Times1: TMenuItem;
    AbsenceReason1: TMenuItem;
    CoverNote1: TMenuItem;
    N1: TMenuItem;
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
  AbsReasonWin: TAbsReasonWin;

procedure AbsReasonWinprint;
procedure AbsReasonWinOut;

implementation
uses tcommon,tcommon2,abrsdlg,main,printers,tcommon5;
{$R *.DFM}

 type TPrintAbsReasonWin=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutAbsReasonWin=class(TOutPutWin)
  public
   procedure head; override;
 end;


var
 PrintAbsReasonWin:    TPrintAbsReasonWin;
 OutAbsReasonWin:    TOutAbsReasonWin;

procedure TAbsReasonWin.setTabs;
begin
 SetLength(Tabs,4);
 TotalCodes:=nmbrreasonsinuse;
 if selcode>nmbrreasonsinuse then selcode:=0;
 codeColor:=cpClass;
 headwidth:=canvas.textwidth(caption+': 99');
 MaxTab(1,0,'WWW');
 MaxTab(2,canvas.textwidth('Code '),'AAAAAAAAAA ');      
 MaxTab(3,fwAbsence,'Reason ');
 maxW:=Tabs[3];
 maxH:=txtheight*(Totalcodes+4);
end;

procedure TAbsReasonWin.PaintItem(i:integer;SelFlag:boolean);
begin
 printw(inttostr(i)+':');
 x:=Tabs[1]; printw(Abcode[i]);
 x:=Tabs[2]; printw(Absent[i]);
 fcolor(codecolor);
end;

procedure TAbsReasonWin.PaintHead;
begin
 printw2(caption+': ',inttostr(TotalCodes));
 newline;  fcolor(cpNormal);
 printw('No.');
 x:=Tabs[1]; printw('Code');
 x:=Tabs[2];  printwl('Reason');
 newline;
end;




procedure TAbsReasonWin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:= caFree;
end;

procedure TAbsReasonWin.Change1Click(Sender: TObject);
begin
 if CheckAccessRights(4,4,true) then
 begin
  AbsReasondlg:=TAbsReasondlg.create(self);   {allocate dlg}
  AbsReasondlg.showmodal;
  AbsReasondlg.free;
  CheckAccessRights(4,4,false);
 end;
end;

procedure TAbsReasonWin.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnAbsReason);
end;



{
----------- printer procs follow ---------------------
}



procedure TPrintAbsReasonWin.setTabs;
begin
 SetLength(PrntTabs,4);
 TotalCodes:=nmbrreasonsinuse;
 codeColor:=cpClass;
 MaxTab(1,0,'WWW');
 MaxTab(2,PrintCanvas.textwidth('Code '),'WWW ');
 MaxTab(3,fwAbsence,'Reason ');
end;

procedure TPrintAbsReasonWin.head;
begin
 UnderlineOn;
 printw2('Teacher Absence Reasons: ',inttostr(TotalCodes));
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(cpNormal);
 printw('No.');
 x:=PrntTabs[1]; printw('Code');
 x:=PrntTabs[2]; printw('Reason');
 fcolor(codecolor);
 x:=0; y:=y+2*PrnttxtHeight;
end;

procedure AbsReasonWinprint;
var
 i: integer;

begin
 PrintAbsReasonWin:=TPrintAbsReasonWin.Create;
 with PrintAbsReasonWin do
  try
   PrintHead;
   if TotalCodes<=0 then exit;
   for i:=1 to TotalCodes do
    begin
     printw(inttostr(i)+':');
     x:=PrntTabs[1]; printw(Abcode[i]);
     x:=PrntTabs[2]; printw(Absent[i]);
     newline
    end;  {for i  to totalcodes}
   printCustomAddon;
  finally
   PrintAbsReasonWin.Free;
  end;
end;


procedure TOutAbsReasonWin.head;
begin
 printLine(['Teacher Absence Reasons: ',inttostr(nmbrreasonsinuse)]);
 printLine(['No.','Code','Reason']);
 newline;
end;

procedure AbsReasonWinOut;
var
 i: integer;

begin
 OutAbsReasonWin:=TOutAbsReasonWin.Create;
 with OutAbsReasonWin do
  try
   Header;
   if nmbrreasonsinuse<=0 then exit;
   for i:=1 to nmbrreasonsinuse do printLine([inttostr(i)+':',Abcode[i],Absent[i]]);
   printCustomAddon;
  finally
   OutAbsReasonWin.Free;
  end;
end;

procedure TAbsReasonWin.Teacher1Click(Sender: TObject);
begin
 TeWinSelect;
end;

procedure TAbsReasonWin.AddedStaff1Click(Sender: TObject);
begin
  AddedStaffWinSelect;
end;

procedure TAbsReasonWin.Times1Click(Sender: TObject);
begin
 TimesWinSelect;
end;

procedure TAbsReasonWin.AbsenceReason1Click(Sender: TObject);
begin
 absreasonswinselect;
end;

procedure TAbsReasonWin.CoverNote1Click(Sender: TObject);
begin
 covernoteswinselect;
end;

procedure TAbsReasonWin.FormDblClick(Sender: TObject);
begin
 doubleclick:=true;
 Change1Click(self);
end;

procedure TAbsReasonWin.SelectCode1Click(Sender: TObject);
begin
 TickCodeSubMenu(SelectCode1);
end;

end.
