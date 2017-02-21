unit TimesWnd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TTimesWindow = class(TDrawWin)
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N7: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    MainMenu1: TMainMenu;
    Codes1: TMenuItem;
    SelectCode1: TMenuItem;
    Teacher1: TMenuItem;
    AddedStaff1: TMenuItem;
    Times1: TMenuItem;
    AbsenceReason1: TMenuItem;
    CoverNote1: TMenuItem;
    N1: TMenuItem;
    Change1: TMenuItem;
    Copy1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Change1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Teacher1Click(Sender: TObject);
    procedure AddedStaff1Click(Sender: TObject);
    procedure Times1Click(Sender: TObject);
    procedure AbsenceReason1Click(Sender: TObject);
    procedure CoverNote1Click(Sender: TObject);
    procedure SelectCode1Click(Sender: TObject);
  protected
    procedure SetTabs; override;
  end;
  procedure TimesWinPrint;
  procedure TimesWinOut;
var
  TimesWindow: TTimesWindow;

implementation
uses tcommon,tcommon2,EditTime,main,printers,tcommon5;
{$R *.dfm}

 type TPrintTimesWin=class(TPrintDrawWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutTimesWin=class(TOutputWin)
  public
   procedure head; override;
 end;

var
 PrintTimesWin:    TPrintTimesWin;
 OutTimesWin:      TOutTimesWin;
 dayuse: smallint;

procedure TTimesWindow.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnTimes);
end;

procedure TTimesWindow.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:= caFree;
end;

procedure TTimesWindow.Change1Click(Sender: TObject);
begin
 if CheckAccessRights(4,5,true) then
 begin
  NewAllotDlg:=TNewAllotDlg.create(self);   {allocate dlg}
  NewAllotDlg.showmodal;
  NewAllotDlg.free;
  CheckAccessRights(4,5,false);
 end;
end;


procedure TTimesWindow.setTabs;
var
 TabTimes,maxTab1,tab1:   smallint;

begin
 SetLength(Tabs,8);
 GroupArrayCalc;  MaxTab1:=0;
 MaxTab(1,canvas.textwidth('Slot '),inttostr(periods));
 MaxTab(2,fwPeriodname,'Name ');
 TabTimes:=canvas.textwidth(stringPadchr(8,'0'));
 tab1:=canvas.textwidth('Time Chart ');
 if TabTimes>tab1 then tab1:=tabTimes;
 MaxTab(3,tab1,'Allotment ');
 MaxTab(4,0,'Code ');
 MaxTab(5,0,'Order  ');
 if numYearGroups=1 then
  begin
   maxTab1:=canvas.textwidth('Extras Allotment ');
   if tab1>maxTab1 then maxTab1:=tab1;
   maxH:=2;
  end;
 if numYearGroups=years then
  begin
   tab1:=fwyearname+3*blankwidth+ canvas.textwidth(yearShort);
   if TabTimes>tab1 then tab1:=TabTimes;
   maxTab1:=years*tab1; maxH:=2;
  end;
 if (numYearGroups<years) and (numYearGroups>1) then
  begin
   tab1:=canvas.textwidth(yearShort+' Group 10 ');
   if TabTimes>tab1 then tab1:=TabTimes;
   maxTab1:=numYearGroups*tab1;
   maxH:=2+numYearGroups;
  end;
 Tabs[6]:=tab1;
 Tabs[7]:=Tabs[5]+maxTab1;
 maxW:=Hmargin+Tabs[7];
 maxH:=txtheight*(2+maxH+numDayGroups*(6+periods));
end;



procedure TPrintTimesWin.SetTabs;
var
 TabTimes,maxTab1,tab1:   smallint;

begin
 SetLength(PrntTabs,8);
 GroupArrayCalc;   MaxTab1:=0;
 MaxTab(1,PrintCanvas.textwidth('Slot '),inttostr(periods));
 MaxTab(2,fwPrntPeriodname,'Name ');
 TabTimes:=PrintCanvas.textwidth(stringPadchr(8,'0'));
 tab1:=PrintCanvas.textwidth('Time Chart ');
 if TabTimes>tab1 then tab1:=tabTimes;
 MaxTab(3,tab1,'Allotment ');
 MaxTab(4,0,'Code ');
 MaxTab(5,0,'Order  ');
 if numYearGroups=1 then
  begin
   maxTab1:=PrintCanvas.textwidth('Extras Allotment ');
   if tab1>maxTab1 then maxTab1:=tab1;
  end;
 if numYearGroups=years then
  begin
   tab1:=fwprntyearname+3*prntblankwidth+ PrintCanvas.textwidth(yearShort);
   if TabTimes>tab1 then tab1:=TabTimes;
   maxTab1:=years*tab1;
  end;
 if (numYearGroups<years) and (numYearGroups>1) then
  begin
   tab1:=PrintCanvas.textwidth(yearShort+' Group 10 ');
   if TabTimes>tab1 then tab1:=TabTimes;
   maxTab1:=numYearGroups*tab1;
  end;
 prntTabs[6]:=tab1;
 prntTabs[7]:=PrntTabs[5]+maxTab1;
end;



procedure TTimesWindow.FormPaint(Sender: TObject);
var
 i,j,k: integer;
 tmpAllot:             string;
 tmpstr:               string;

begin
 codeColor:=cpClass;
 {Headings}
 tmpstr:='';
 if (numYearGroups=1) or (numYearGroups=years) then tmpstr:='All '+Yeartitle+'s';
 printw2('Times for: ',tmpstr); newline;
 if (numYearGroups>1) and (numYearGroups<years) then
  begin
   for i:=1 to numYearGroups do
    begin
      tmpstr:=yearshort+' ';
       for j:= 1 to yg[i,0] do
        begin
          tmpstr:=tmpstr+yearname[yg[i,j]];
          if (yg[i,0]>1) and (j<yg[i,0]) then tmpstr:=tmpstr+', ';
        end;
      printw2(yearShort+' Group '+inttostr(i)+':  ',tmpstr); newline;
    end; {for i}
  end;
 newline;  fcolor(cpNormal);
 for i:=1 to NumDayGroups do
  begin
   dayuse:=dg[i,1];
   if NumDayGroups=1 then printw('All Days');
   if NumDayGroups=days then printw(dayname[i-1]);
   if (NumDayGroups>1) and (NumDayGroups<days) then
    begin
     tmpstr:='';
     for j:=1 to dg[i,0] do
       begin
          tmpstr:=tmpstr+dayname[dg[i,j]];
          if (dg[i,0]>1) and (j<dg[i,0]) then tmpstr:=tmpstr+', ';
        end;
     printw2('Day Group '+inttostr(i)+': ',tmpstr);
    end;
   newline;  newline;   fcolor(cpNormal);
   x:=Tabs[2];  printw('Time Chart');
   x:=Tabs[5];  printw('Extras Allotment');
   newline;  fcolor(cpNormal);
   printw('Slot');
   x:=Tabs[1];  printw('Name');
   x:=Tabs[2];  printw(TslotUnitName[TslotUnit]);
   x:=Tabs[3];  printw('Code');
   x:=Tabs[4];  printw('Order');
   if numYearGroups=1 then
    begin
     x:=Tabs[5];  printw('All '+yeartitle+'s');
    end;
   if numYearGroups=years then
    for j:= 1 to numYearGroups do
     begin
       x:=Tabs[5]+(j-1)*Tabs[6];
       printw(yearshort+' '+yearname[j-1]);
     end;
   if (numYearGroups>1) and (numYearGroups<years) then
    for j:= 1 to numYearGroups do
     begin
       x:=Tabs[5]+(j-1)*Tabs[6];
       printw(yearshort+' Group '+inttostr(j));
     end;
   newline;
   fcolor(codecolor);

   for j:=1 to tlimit[dayuse] do
   begin
    if y>bottomCutoff then exit; {no printing past range}
    x:=canvas.textwidth(inttostr(periods))
                         -canvas.textwidth(inttostr(j));
    printw(inttostr(j)+':');
    x:=Tabs[1]; printw(TimeSlotName[dayuse,j-1]);
    x:=Tabs[2]; str(tsAllot[dayuse,j-1]:4:2,tmpAllot); printw(tmpAllot);
    x:=Tabs[3]; printw(tslotcode[j,dayuse]);
    x:=Tabs[4]; printw(inttostr(torder[j,dayuse]));
    for k:=1 to numYearGroups do
     begin
      x:=Tabs[5]+(k-1)*Tabs[6];
      str(Eallot[yg[k,1],dayuse,j]:4:2,tmpAllot);
      printw(tmpAllot);
     end;
    newline;
   end;  {for j:= 1 to periods}
   newline;newline;
  end; {for i}
end;

procedure TPrintTimesWin.Head;
begin
 UnderlineOn;
 printwl('Time Allotments');
 printw(PageCount);
 x:=0; y:=y+prnttxtheight;
 UnderlineOff;
end;

procedure TimesWinPrint;
var
 i,j,k: integer;
 tmpAllot:             string;
 tmpstr:               string;

begin
 PrintTimesWin:=TPrintTimesWin.Create;
 with PrintTimesWin do
  try
   PrintHead;
   codeColor:=cpClass;   fcolor(cpNormal);
   x:=0;  y:=prntVmargin;
   header;
   newline;
   {Headings}
   tmpstr:='';
   if (numYearGroups=1) or (numYearGroups=years) then tmpstr:='All '+Yeartitle+'s';
   printw2('Times for: ',tmpstr); newline;
   if (numYearGroups>1) and (numYearGroups<years) then
    begin
     for i:=1 to numYearGroups do
      begin
        tmpstr:=yearshort+' ';
         for j:= 1 to yg[i,0] do
          begin
            tmpstr:=tmpstr+yearname[yg[i,j]];
            if (yg[i,0]>1) and (j<yg[i,0]) then tmpstr:=tmpstr+', ';
          end;
        printw2(yearShort+' Group '+inttostr(i)+':  ',tmpstr); newline;
      end; {for i}
    end;
   newline; fcolor(cpNormal);
   for i:=1 to NumDayGroups do
    begin
     dayuse:=dg[i,1];
     if NumDayGroups=1 then printw('All Days');
     if NumDayGroups=days then printw(dayname[i-1]);
     if (NumDayGroups>1) and (NumDayGroups<days) then
      begin
       tmpstr:='';
       for j:=1 to dg[i,0] do
         begin
            tmpstr:=tmpstr+dayname[dg[i,j]];
            if (dg[i,0]>1) and (j<dg[i,0]) then tmpstr:=tmpstr+', ';
          end;
       printw2('Day Group '+inttostr(i)+': ',tmpstr);
      end;
     newline;  newline;   fcolor(cpNormal);
     x:=PrntTabs[2];  printw('Time Chart');
     x:=PrntTabs[5];  printw('Extras Allotment');
     newline; fcolor(cpNormal);
     printw('Slot');
     x:=PrntTabs[1];  printw('Name');
     x:=PrntTabs[2];  printw(TslotUnitName[TslotUnit]);
     x:=PrntTabs[3];  printw('Code');
     x:=PrntTabs[4];  printw('Order');
     if numYearGroups=1 then
      begin
       x:=PrntTabs[5];  printw('All '+yeartitle+'s');
      end;
     if numYearGroups=years then
      for j:= 1 to numYearGroups do
       begin
         x:=PrntTabs[5]+(j-1)*PrntTabs[6];
         printw(yearshort+' '+yearname[j-1]);
       end;
     if (numYearGroups>1) and (numYearGroups<years) then
      for j:= 1 to numYearGroups do
       begin
         x:=PrntTabs[5]+(j-1)*PrntTabs[6];
         printw(yearshort+' Group '+inttostr(j));
       end;
     newline;
     fcolor(codecolor);

     for j:=1 to tlimit[dayuse] do
     begin
      x:=PrintCanvas.textwidth(inttostr(periods))
                           -PrintCanvas.textwidth(inttostr(j));
      printw(inttostr(j)+':');
      x:=PrntTabs[1]; printw(TimeSlotName[dayuse,j-1]);
      x:=PrntTabs[2]; str(tsAllot[dayuse,j-1]:4:2,tmpAllot); printw(tmpAllot);
      x:=PrntTabs[3]; printw(tslotcode[j,dayuse]);
      x:=PrntTabs[4]; printw(inttostr(torder[j,dayuse]));
      for k:=1 to numYearGroups do
       begin
        x:=PrntTabs[5]+(k-1)*PrntTabs[6];
        str(Eallot[yg[k,1],dayuse,j]:4:2,tmpAllot);
        printw(tmpAllot);
       end;
      newline;
     end;  {for j:= 1 to periods}
     newline;newline;
    end; {for i}

  printCustomAddon;
 finally
  PrintTimesWin.Free;
 end;
end;

procedure TOutTimesWin.Head;
begin
 printLine(['Time Allotments']);
end;

procedure TimesWinOut;
var
 i,j,k: integer;
 tmpAllot:             string;
 tmpstr:               string;

begin
 OutTimesWin:=TOutTimesWin.Create;
 with OutTimesWin do
  try
   Header;
   newline;
   {Headings}
   tmpstr:='';
   if (numYearGroups=1) or (numYearGroups=years) then tmpstr:='All '+Yeartitle+'s';
   printLine(['Times for: ',tmpstr]);
   if (numYearGroups>1) and (numYearGroups<years) then
    begin
     for i:=1 to numYearGroups do
      begin
        tmpstr:=yearshort+' ';
         for j:= 1 to yg[i,0] do
          begin
            tmpstr:=tmpstr+yearname[yg[i,j]];
            if (yg[i,0]>1) and (j<yg[i,0]) then tmpstr:=tmpstr+', ';
          end;
        printLine([yearShort+' Group '+inttostr(i)+':  ',tmpstr]);
      end; {for i}
    end;
   newline;
   for i:=1 to NumDayGroups do
    begin
     dayuse:=dg[i,1];
     if NumDayGroups=1 then printLine(['All Days']);
     if NumDayGroups=days then printLine([dayname[i-1]]);
     if (NumDayGroups>1) and (NumDayGroups<days) then
      begin
       tmpstr:='';
       for j:=1 to dg[i,0] do
         begin
            tmpstr:=tmpstr+dayname[dg[i,j]];
            if (dg[i,0]>1) and (j<dg[i,0]) then tmpstr:=tmpstr+', ';
          end;
       printLine(['Day Group '+inttostr(i)+': ',tmpstr]);
      end;
     newline;
     PrintLine(['','','Time Chart','','','Extras Allotment']);
     printw('Slot');
     printc('Name');
     printc(TslotUnitName[TslotUnit]);
     printc('Code');
     printc('Order');
     if numYearGroups=1 then printc('All '+yeartitle+'s');
     if numYearGroups=years then
      for j:= 1 to numYearGroups do printc(yearshort+' '+yearname[j-1]);
     if (numYearGroups>1) and (numYearGroups<years) then
      for j:= 1 to numYearGroups do printc(yearshort+' Group '+inttostr(j));
     newline;

     for j:=1 to tlimit[dayuse] do
     begin
      printw(inttostr(j)+':');
      printc(TimeSlotName[dayuse,j-1]);
      str(tsAllot[dayuse,j-1]:4:2,tmpAllot); printc(tmpAllot);
      printc(tslotcode[j,dayuse]);
      printc(inttostr(torder[j,dayuse]));
      for k:=1 to numYearGroups do
       begin
        str(Eallot[yg[k,1],dayuse,j]:4:2,tmpAllot);
        printc(tmpAllot);
       end;
      newline;
     end;  {for j:= 1 to periods}
     newline;newline;
    end; {for i}
                     
  printCustomAddon;
 finally
  OutTimesWin.Free;
 end;
end;


procedure TTimesWindow.Teacher1Click(Sender: TObject);
begin
 TeWinSelect;
end;

procedure TTimesWindow.AddedStaff1Click(Sender: TObject);
begin
 AddedStaffWinSelect
end;

procedure TTimesWindow.Times1Click(Sender: TObject);
begin
 TimesWinSelect
end;

procedure TTimesWindow.AbsenceReason1Click(Sender: TObject);
begin
 absreasonswinselect;
end;

procedure TTimesWindow.CoverNote1Click(Sender: TObject);
begin
 covernoteswinselect;
end;

procedure TTimesWindow.SelectCode1Click(Sender: TObject);
begin
 TickCodeSubMenu(SelectCode1);
end;

end.
