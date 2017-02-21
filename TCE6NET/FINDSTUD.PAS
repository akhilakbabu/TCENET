unit Findstud;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TFindStudent = class(TDrawWin)
    PopupMenu1: TPopupMenu;
    Selection2: TMenuItem;
    N2: TMenuItem;
    PrintSetup1: TMenuItem;
    Print1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure Selection2Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  protected
    procedure SetTabs; override;
  end;

var
  FindStudent: TFindStudent;

procedure findstudentprint;
procedure findstudentOut;

implementation
uses tcommon,fndstdlg,main,printers,tcommon2;

{$R *.DFM}

 type TPrintFindStudWin=class(TPrintDrawWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutFindStudWin=class(TOutputWin)
  public
   procedure head; override;
 end;

var
 PrintFindStudWin:    TPrintFindStudWin;
 OutFindStudWin:   TOutFindStudWin;

procedure TFindStudent.SetTabs;
var
 star,j: integer;
begin
 SetLength(Tabs,5);
 star:=canvas.textwidth('*');
 MaxTab(1,fwperiodname,'Time ');
 MaxTab(2,fwcode[0],'Subject ');
 MaxTab(3,fwcode[1]+star,'Teacher ');
 MaxTab(4,fwcode[2]+star,'Room ');
 { if including student absence then
  MaxTab(5,0,'Late ');
  MaxTab(6,0,'Absent ');
 }
 headwidth:=canvas.TextWidth('Date: 29 May  Timetable day: ')+fwDayname;
 j:=fwStName+3*blankwidth;
 if sTyear then inc(j,canvas.textwidth(yearShort)+fwYearName+2*blankwidth);
 if stSex then inc(j,fwSex+blankwidth);
 if stID then inc(j,fwID+blankwidth);
 if stClass then inc(j,fwClass+blankwidth);
 if stHouse then inc(j,fwHouse+blankwidth);
 if stTutor then inc(j,fwcode[1]+blankwidth);
 if stHome then inc(j,fwcode[2]+blankwidth);
 if j>headwidth then headwidth:=j;
 MaxW:=Tabs[4];
 MaxH:=txtheight*(7+periods)
end;


procedure TFindStudent.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnFindStud);
end;

procedure TFindStudent.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;





procedure checkStudentExtras(var ro,te: integer; var tecoverstr: string;
               var rochange,techange,extras_change: bool;sfyear,p:integer);
var
 i3,te1,ro1,kind1:      integer;
begin
 rochange:=false; techange:=false; te1:=te; ro1:=ro; kind1:=0;
 if (numchanges=0) then exit;
 for i3:=1 to numchanges do
 begin
  if ((Changes[i3].timeslot=p) and (Changes[i3].year=sfyear) and (Changes[i3].oldte=te)) then
  begin
   te1:=Changes[i3].newte; ro1:=Changes[i3].newroom; kind1:=Changes[i3].kind; break;
  end;
 end; {for i3}
 if ((kind1<>1) and (te1>0) and (te1<=numcodes[1]) and (te1<>te)) then
 begin
  te:=te1; techange:=true; extras_change:=true; tecoverstr:=tecode[te1,0];
 end;
 if ((kind1=1) and (te1>0) and (te1<=Etnum)) then
 begin
  te:=te1; techange:=true; extras_change:=true; tecoverstr:=etsub[te1];
 end;
 if ((ro1>0) and (ro1<numcodes[2]) and (ro1<>ro)) then
 begin
  ro:=ro1; rochange:=true; extras_change:=true;
 end;
end;


procedure TFindStudent.FormPaint(Sender: TObject);
var
 p:           integer;
 sfyear,sflevel:     integer;
 tecoverstr:                  string;
 rochange,techange:       bool;
 te,ro,sc:           integer;
 extras_change:                 bool;
begin      
 fcolor(cpNormal);
 extras_change:=false;   
 printw2('Date: ',inttostr(exday)+' '+month[exmonth]);
 printw2('  Timetable day: ',dayname[ttday]);
 newline;  fcolor(cpStList); {same as student list}
 printwl(GetStudentName(studfindnum));
 newline;  fcolor(cpNormal);
 printw('Time'); x:=tabs[1];
 printw('Subject'); x:=tabs[2];
 printw('Teacher'); x:=tabs[3];
 printw('Room');  newline;
 for p:=1 to periods do
  begin
   fcolor(cpStList);
   printw(TimeSlotName[ttday,p-1]);
   GetStudentTtItem(te,sc,ro,sfyear,sflevel,studfindnum,ttday,p-1,MatchAllYears);
   if sc>0 then
     begin
      tecoverStr:=tecode[te,0];
      checkStudentExtras(ro,te,tecoverstr,rochange,techange,extras_change,sfyear,p);
      x:=tabs[1]; printw(Subcode[sc]);
      x:=tabs[2]; printwl(tecoverStr);
      if techange then begin fcolor(cpDouble); printw('*'); fcolor(cpStList); end;
      x:=tabs[3]; printwl(tecode[ro,1]);
      if rochange then begin fcolor(cpDouble); printw('*'); fcolor(cpStList); end;
     end;
    newline;
  end; {for p}
  if extras_change then
   begin
    newline;  fcolor(cpDouble);
    printwl('* '); fcolor(cpNormal);
    printw('indicates teacher or room change');
    newline;
   end;
end;

procedure TFindStudent.Selection2Click(Sender: TObject);
begin
 findstudentdlg:=Tfindstudentdlg.create(self);   {allocate dlg}
 findstudentdlg.showmodal;
 findstudentdlg.free;
end;

procedure TFindStudent.FormDblClick(Sender: TObject);
begin
 findstudentdlg:=Tfindstudentdlg.create(self);   {allocate dlg}
 findstudentdlg.showmodal;
 findstudentdlg.free;
end;

procedure TFindStudent.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
end;



{==========================================================================}
     {-------------- printing procs follow -------------------------}
{==========================================================================}

procedure TPrintFindStudWin.head;
begin
 UnderlineOn;
 printwl('Find Student');
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
end;

procedure TPrintFindStudWin.SetTabs;
var
 star: integer;
begin
 SetLength(PrntTabs,5);
 star:=PrintCanvas.textwidth('*');
 MaxTab(1,fwprntperiodname,'Time ');
 MaxTab(2,fwprntcode[0],'Subject ');
 MaxTab(3,fwprntcode[1]+star,'Teacher ');
 MaxTab(4,fwprntcode[2]+star,'Room ');
end;



procedure FindStudentprint;
var
 p:           integer;
 sfyear,sflevel:     integer;
 tecoverstr:                  string;
 rochange,techange:       bool;
 te,ro,sc:           integer;
 extras_change:                 bool;

begin
 PrintFindStudWin:=TPrintFindStudWin.Create;
 with PrintFindStudWin do
  try
   PrintHead;
   fcolor(cpNormal);
   extras_change:=false;
   printw2('Date: ',inttostr(exday)+' '+month[exmonth]);
   printw2('  Timetable day: ',dayname[ttday]);
   newline;  fcolor(cpStList); {same as student list}
   printwl(GetStudentName(studfindnum));
   newline;  fcolor(cpNormal);
   printw('Time'); x:=Prnttabs[1];
   printw('Subject'); x:=Prnttabs[2];
   printw('Teacher'); x:=Prnttabs[3];
   printw('Room');  newline;
   for p:=1 to periods do
    begin
     fcolor(cpStList);
     printw(TimeSlotName[ttday,p-1]);
     GetStudentTtItem(te,sc,ro,sfyear,sflevel,studfindnum,ttday,p-1,MatchAllYears);
     if sc>0 then
       begin
        tecoverStr:=tecode[te,0];
        checkStudentExtras(ro,te,tecoverstr,rochange,techange,extras_change,sfyear,p);
        x:=Prnttabs[1]; printw(Subcode[sc]);
        x:=Prnttabs[2]; printwl(tecoverStr);
        if techange then begin fcolor(cpDouble); printw('*'); fcolor(cpStList); end;
        x:=Prnttabs[3]; printwl(tecode[ro,1]);
        if rochange then begin fcolor(cpDouble); printw('*'); fcolor(cpStList); end;
       end;
      newline;
    end; {for p}
    if extras_change then
     begin
      newline;  fcolor(cpDouble);
      printwl('* '); fcolor(cpNormal);
      printw('indicates teacher or room change');
      newline;
     end;
   printCustomAddon;
 finally
  PrintFindStudWin.free;
 end;
end;

{ --------- TEXT OUTPUT PROCEDURES -------------------------}

procedure ToUTFindStudWin.head;
begin
 printLine(['Find Student']);
end;


procedure FindStudentOut;
var
 p:           integer;
 sfyear,sflevel:     integer;
 s,tecoverstr:                  string;
 rochange,techange:       bool;
 te,ro,sc:           integer;
 extras_change:                 bool;

begin
 OutFindStudWin:=TOutFindStudWin.Create;
 with OutFindStudWin do
  try
   Header;
   extras_change:=false;
   printw('Date:'); printc(inttostr(exday)+' '+month[exmonth]);
   printc('Timetable day:'); printc(dayname[ttday]);
   newline;
   printw(GetStudentName(studfindnum));
   newline;
   printLine(['Time','Subject','Teacher','Room']);
   for p:=1 to periods do
    begin
     printw(TimeSlotName[ttday,p-1]);
     GetStudentTtItem(te,sc,ro,sfyear,sflevel,studfindnum,ttday,p-1,MatchAllYears);
     if sc>0 then
       begin
        tecoverStr:=tecode[te,0];
        checkStudentExtras(ro,te,tecoverstr,rochange,techange,extras_change,sfyear,p);
        printc(Subcode[sc]);
        s:=tecoverStr; if techange then s:=s+'*';
        printc(s);
        s:=tecode[ro,1]; if rochange then  s:=s+'*';
        printc(s);
       end;
      newline;
    end; {for p}
    if extras_change then
     begin
      newline;
      printw('* indicates teacher or room change');
      newline;
     end;
   printCustomAddon;
 finally
  OutFindStudWin.free;
 end;
end;

end.
