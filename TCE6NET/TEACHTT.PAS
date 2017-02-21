unit Teachtt;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TTeTtable = class(TListTtWin)
    PopupMenu1: TPopupMenu;
    Selection2: TMenuItem;
    N2: TMenuItem;
    PrintSetup1: TMenuItem;
    Print1: TMenuItem;
    Copy1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Selection2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
  protected
    procedure SetTabs; override;
    procedure GetLists; override;
    procedure GetListContents(i: integer); override;
    procedure ShowTtItems(i,d,p,x1: integer); override;
    procedure ListHead(i,d:integer);  override;
    procedure ShowName(i:integer);  override;
    procedure WeeklyFooter(i:integer); override;
  end;

var
  TeTtable: TTeTtable;

procedure teacherTtableprint;
procedure teacherTtableOut;

implementation
uses tcommon,main,tettdlg,printers,tcommon2;

{$R *.DFM}

type TPrintTeTtWin=class(TPrintListTtWin)
  public
   procedure head; override;
   procedure SetTabs; override;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i,d:integer); override;
   procedure ShowName(i:integer);  override;
   procedure WeeklyFooter(i:integer); override;
   procedure ShowTtItems(i,d,p,x1: integer);  override;
 end;

type TOutTeTtWin=class(TOutListTtWin)
  public
   procedure head; override;
   procedure SetTabs; override;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i,d:integer); override;
   procedure ShowName(i:integer);  override;
   procedure WeeklyFooter(i:integer); override;
   procedure ShowTtItems(i,d,p: integer);  override;
 end;

var
 PrintTeTtWin:    TPrintTeTtWin;
 OutTeTtWin:     TOutTeTtWin;
 tscount:                       integer;
 ldcount:                       double;



Procedure GeneralListContents(i,size,myset:integer;var Contents: array of integer);
var
 j,count,countfrom,t: integer;
begin
 count:=0;
 if Size=0 then exit;
 if tettseltype=1 then countfrom:=codenum[1]
  else countfrom:=tettselection[0];
 for j:=1 to countfrom do
  begin
   if tettseltype=2 then t:=tettselection[j] else t:=codepoint[j,1];
   if TeachInAnyFac(t,myset) then begin inc(count); Contents[count]:=t; end;
  end;
end;


procedure TTeTtable.GetListContents(i:integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TTeTtable.GetLists;
var
 i,t,kk,count: integer;
begin
 NumOfLists:=1; SetArraySizes;
 if tettseltype=1 then count:=codenum[1]
  else count:=tettselection[0];
 kk:=0;
 if count>0 then
  for i:=1 to count do
   begin
    if tettseltype=2 then t:=tettselection[i] else t:=codepoint[i,1];
    if TeachInAnyFac(t,tettlistvals[3]) then inc(kk);
   end;
 ListSize[1]:=kk; ListSet[1]:=tettlistvals[3]
end;

procedure TTeTtable.ShowName(i:integer);
begin
 tscount:=0; ldcount:=0;
 if listtype=1 then
  begin
   x:=blankwidth div 3;
   printw(tecode[i,0]);
   inc(y,txtHeight);
   printw(tename[i,0]);
   dec(y,txtHeight);
  end
  else printw(tecode[i,0]+' '+tename[i,0]);
end;


procedure TTeTtable.ListHead(i,d:integer);
var
 s:string;
 j: integer;
begin
 if listtype=1 then s:=dayname[d]+' for ' else s:='For ';
 j:=ListSet[i];
  case tettseltype of
   1: s:=s+'All Teachers';
   2: s:=s+'Teacher Selection';
  end; {case}
  if j>0 then s:=s+' in faculty '+facname[j];
  printw(s);   newline;
end;

procedure TTeTtable.ShowTtItems(i,d,p,x1: integer);
var
 ro,sc,teyear,lev,offset: integer;
 itemTt1,itemTt2,itemTt3: string;
begin
 if GetTeachTtItem(sc,ro,teYear,Lev,i,d,p) then
  begin
   if (sc<>subNA) then
    begin
     inc(tscount); ldcount:=ldCount+tsAllot[d,p];
    end;
   itemTt1:=trim(SubCode[sc]);
   itemTt2:=trim(tecode[ro,1]);
   itemTt3:=FNycSHARED(d,p,i,1);
   //offset:=(dx-3-canvas.textwidth(ItemTt1+' '+itemTt2)) div 2;
   offset:=(dx-3-canvas.textwidth(ItemTt1)) div 2;
   x:=x1+offset; fcolor(cpSub); printwl(ItemTt1+' '); {subject}
   //fcolor(cpRoom); printw(ItemTt2); {room}
   inc(y,txtHeight);
   if itemTt2 <> '' then
   begin
     offset:=(dx-3-canvas.textwidth(itemTt2 + ' ' + ItemTt3)) div 2;
     x := x1 + Offset; fcolor(cpRoom); printw(itemTt2); //Room
     Offset := (canvas.textwidth(' ' + itemTt2));
     x := x + offset;
   end
   else
     x:= X1 + (dx-3-canvas.textwidth(itemTt3)) div 2;
   //inc(y,txtHeight);
   //offset:=(dx-3-canvas.textwidth(itemTt3)) div 2;
   //x:=x1+offset;
   fcolor(cpClass); printw(itemTt3); {class}
   dec(y,txtHeight);
  end;
end;


procedure TTeTtable.SetTabs;
var
 i,A1:       integer;

begin
 listtype:=winView[wnTeacherTt]+1;  CodeColor:=cpTeach; {teacher}
 day1:=tettlistvals[4]; day2:=tettlistvals[5];
 yFooter:=2*txtHeight;
 //dx:=8+fwCode[0]+fwCode[2]+(blankwidth div 2);
 dx := 8 + fwCode[2] + 8 + fwClass + (BlankWidth);
 if tyr>0 then
   begin
    A1:=8+fwyearname;
    if A1>dx then dx:=A1;
    A1:=8+fwClass;
    if A1>dx then dx:=A1;
   end;
 if listtype=2 then
 begin         {weekly}
  A1:=8+fwDayname;
  if A1>dx then dx:=A1;
  tab1:=fwPeriodname+blankwidth;
 end
 else    {daily}
  begin
   A1:=8+fwperiodname;
   if A1>dx then dx:=A1;
   i:=fwcodename[1];
  if fwcode[1]>i then i:=fwcode[1];
  tab1:=i+blankwidth;
  end;
 GetLists;
 CalcArrayTops;
end;

procedure TTeTtable.WeeklyFooter(i:integer);
var
 a: integer;
 astr,bstr: string;
begin
 if listtype=1 then {daily}
  begin
   printw('Teachers: '+inttostr(ListSize[i]));
  end
 else
  begin
   x:=0;  fcolor(cpNormal);
   for a:=0 to 2 do
   begin
    if trim(dutycode[i,a])>'' then
     ldcount:=ldcount+dutyload[i,a];
   end; {for a}

   str(ldcount:4:2,aStr);
   if (Load[i]=-1) then Load[i]:=days*periods;
   printw('Total time slots: '+inttostr(tscount)+'   Load: '+aStr+'/'+inttostr(Load[i]));
   newline;
   for a:=0 to 2 do
   begin
    if dutyload[i,a]=0 then aStr:='0' else str(dutyload[i,a]:4:2,aStr);
    bstr:=Trim(dutycode[i,a]); if bstr='' then bstr:='-';
    if bstr<>'-' then  {do not want duty codes if none assigned}
     printwl('Duty Code'+inttostr(a+1)+': '+bstr+'  Load: '+aStr+'    ');
   end; {for a}
   newline;
  end;
end;

procedure TTeTtable.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure TTeTtable.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnTeacherTt)
end;

procedure TTeTtable.Selection2Click(Sender: TObject);
begin
 TeacherTTdlg:=TTeacherTTdlg.create(self);   {allocate dlg}
 TeacherTTdlg.showmodal;
 TeacherTTdlg.free;
end;


procedure TTeTtable.FormPaint(Sender: TObject);
begin 
end;

{--------------            print procs follow             - ------------------}

procedure TPrintTeTtWin.head;
begin
 UnderlineOn;
 printwl('Teacher Timetable ');
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
end;

procedure TPrintTeTtWin.WeeklyFooter(i:integer);
var
 a: integer;
 astr,bstr: string;
begin
 if listtype=1 then {daily}
   printw('Teachers: '+inttostr(ListSize[i]))
 else
  begin
   for a:=0 to 2 do if Trim(dutycode[i,a])>'' then
       ldcount:=ldcount+dutyload[i,a];
   str(ldcount:4:2,aStr);
   if (Load[i]=-1) then Load[i]:=days*periods;
   printw('Total time slots: '+inttostr(tscount)+'   Load: '+aStr+'/'+inttostr(Load[i]));
   newline;
   for a:=0 to 2 do
     begin
      if dutyload[i,a]=0 then aStr:='0' else str(dutyload[i,a]:4:2,aStr);
      bstr:=Trim(dutycode[i,a]);
      if bstr<>'' then     {do not want duty codes if none assigned}
       printwl('Duty Code'+inttostr(a+1)+': '+bstr+'  Load: '+aStr+'    ');
     end; {for a}
     newline;
  end;
end;

procedure TPrintTeTtWin.SetTabs;
var
 A1,i: integer;
begin
 listtype:=winView[wnTeacherTt]+1;  CodeColor:=cpTeach; {teacher}
 day1:=tettlistvals[4]; day2:=tettlistvals[5];
 yFooter:=2*PrntTxtHeight;
 //dx:=8+fwPrntCode[0]+fwPrntCode[2]+Prntblankwidth;
 dx := 8 + fwPrntCode[2] + 8 + fwprntClass + Prntblankwidth;
  if tyr>0 then
   begin
    A1:=8+fwPrntyearname;
    if A1>dx then dx:=A1;
    A1:=8+fwPrntClass;
    if A1>dx then dx:=A1;
   end;
 if listtype=2 then
 begin         {weekly}
  A1:=8+fwPrntDayname;
  if A1>dx then dx:=A1;
  tab1:=fwPrntPeriodname+Prntblankwidth;
 end
 else    {daily}
  begin
   A1:=8+fwPrntperiodname;
   if A1>dx then dx:=A1;
   i:=fwPrntcodename[1];
  if fwPrntcode[1]>i then i:=fwPrntcode[1];
  tab1:=i+Prntblankwidth;
  end;
 GetLists;
end;


procedure TPrintTeTtWin.GetLists;
var
 i: integer;
begin
 NumOfLists:=TeTtable.NumOfLists;
 SetArraySizes;
 if NumOfLists>0 then
  for i:=1 to NumOfLists do
   begin
    ListSize[i]:=TeTtable.ListSize[i];
    ListSet[i]:=TeTtable.ListSet[i];
   end;
end;


procedure TPrintTeTtWin.GetListContents(i: integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TPrintTeTtWin.ShowName(i:integer);
begin
 tscount:=0; ldcount:=0;
 if listtype=1 then
  begin
   x:=PrntBlankwidth div 3;
   printw(tecode[i,0]);
   inc(y,PrntTxtHeight);
   printw(tename[i,0]);
   dec(y,PrntTxtHeight);
  end
  else printw(tecode[i,0]+' '+tename[i,0]);
end;


procedure TPrintTeTtWin.ListHead(i,d:integer);
var
 s:string;
 j: integer;
begin
 if listtype=1 then s:=dayname[d]+' for ' else s:='For ';
 j:=ListSet[i];
  case tettseltype of
   1: s:=s+'All Teachers';
   2: s:=s+'Teacher Selection';
  end; {case}
  if j>0 then s:=s+' in faculty '+facname[j];
  printw(s);   newline;
end;

procedure TPrintTeTtWin.ShowTtItems(i,d,p,x1: integer);
var
 ro,sc,teyear,lev,offset: integer;
 itemTt1,itemTt2,itemTt3: string;
begin
 if GetTeachTtItem(sc,ro,teYear,Lev,i,d,p) then
  begin
   if (sc<>subNA) then
    begin
     inc(tscount); ldcount:=ldCount+tsAllot[d,p];
    end;
   itemTt1:=trim(SubCode[sc]);
   itemTt2:=trim(tecode[ro,1]);
   itemTt3:=FNycSHARED(d,p,i,1);
   //offset:=(dx-3-PrintCanvas.textwidth(ItemTt1+' '+itemTt2)) div 2;
    offset := (dx - 3 - PrintCanvas.textwidth(ItemTt1)) div 2;
   //x:=x1+offset; fcolor(cpSub); printwl(ItemTt1+' '); {subject}
    x:=x1+offset; fcolor(cpSub); printwl(ItemTt1); {subject}
    inc(y,PrntTxtHeight);
    if itemTt2 <> '' then
    begin
      offset:=(dx-3-PrintCanvas.Textwidth(itemTt2 + ' ' + ItemTt3)) div 2;
      x := x1 + Offset; fcolor(cpRoom); printw(itemTt2); //Room
      Offset := (PrintCanvas.Textwidth(' ' + itemTt2));
      x := x + offset;
    end
    else
      x:= X1 + (dx-3-PrintCanvas.Textwidth(itemTt3)) div 2;

   //fcolor(cpRoom); printw(ItemTt2); {room}
   //inc(y,PrntTxtHeight);
   //offset:=(dx-3-PrintCanvas.textwidth(itemTt3)) div 2;
   //x:=x1+offset; fcolor(cpClass); printw(itemTt3); {class}
    fcolor(cpClass);
    printw(' ' + ItemTt3); // Class
    dec(y,PrntTxtHeight);
  end;
end;

procedure teacherTtableprint;
begin
 PrintTeTtWin:=TPrintTeTtWin.Create;
 with PrintTeTtWin do
  try
   PaintOnPrinter;
  finally
   PrintTeTtWin.free;
  end;
end;



{--------------      Text Output procs follow             - ------------------}

procedure TOutTeTtWin.head;
begin
 printLine(['Teacher Timetable']);
end;

procedure TOutTeTtWin.WeeklyFooter(i:integer);
var
 a: integer;
 astr,bstr: string;
begin
 if listtype=1 then {daily}
   printw('Teachers: '+inttostr(ListSize[i]))
 else
  begin
   for a:=0 to 2 do if Trim(dutycode[i,a])>'' then
       ldcount:=ldcount+dutyload[i,a];
   str(ldcount:4:2,aStr);
   if (Load[i]=-1) then Load[i]:=days*periods;
   printw('Total time slots: '+inttostr(tscount)+'   Load: '+aStr+'/'+inttostr(Load[i]));
   newline;
   for a:=0 to 2 do
     begin
      if dutyload[i,a]=0 then aStr:='0' else str(dutyload[i,a]:4:2,aStr);
      bstr:=Trim(dutycode[i,a]);
      if bstr<>'' then     {do not want duty codes if none assigned}
       printc('Duty Code'+inttostr(a+1)+': '+bstr+'  Load: '+aStr+'    ');
     end; {for a}
     newline;
  end;
end;

procedure TOutTeTtWin.SetTabs;
begin
 listtype:=winView[wnTeacherTt]+1;
 day1:=tettlistvals[4]; day2:=tettlistvals[5];
 GetLists;
 TabCount:=1;
end;


procedure TOutTeTtWin.GetLists;
var
 i: integer;
begin
 NumOfLists:=TeTtable.NumOfLists;
 SetArraySizes;
 if NumOfLists>0 then
  for i:=1 to NumOfLists do
   begin
    ListSize[i]:=TeTtable.ListSize[i];
    ListSet[i]:=TeTtable.ListSet[i];
   end;
end;


procedure TOutTeTtWin.GetListContents(i: integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TOutTeTtWin.ShowName(i:integer);
begin
 tscount:=0; ldcount:=0;
 if listtype=1 then
  begin
   printw(tecode[i,0]);
   printc(tename[i,0]);
  end
  else printw(tecode[i,0]+' '+tename[i,0]);
end;


procedure TOutTeTtWin.ListHead(i,d:integer);
var
 s:string;
 j: integer;
begin
 if listtype=1 then s:=dayname[d]+' for ' else s:='For ';
 j:=ListSet[i];
  case tettseltype of
   1: s:=s+'All Teachers';
   2: s:=s+'Teacher Selection';
  end; {case}
  if j>0 then s:=s+' in faculty '+facname[j];
  printw(s);   newline;
end;

procedure TOutTeTtWin.ShowTtItems(i,d,p: integer);
var
 ro,sc,teyear,lev: integer;
 itemTt1,itemTt2,itemTt3: string;
begin
 if GetTeachTtItem(sc,ro,teYear,Lev,i,d,p) then
  begin
   if (sc<>subNA) then
    begin
     inc(tscount); ldcount:=ldCount+tsAllot[d,p];
    end;
   itemTt1:=trim(SubCode[sc]);
   itemTt2:=trim(tecode[ro,1]);
   itemTt3:=FNycSHARED(d,p,i,1);
   printc(ItemTt1); {subject}
   printc(ItemTt2); {room}
   printc(itemTt3); {class}
  end
 else
  begin printc(''); printc(''); printc(''); end;
end;

procedure teacherTtableOut;
begin
 OutTeTtWin:=TOutTeTtWin.Create;
 with OutTeTtWin do
  try
   PaintOnOutput;
  finally
   OutTeTtWin.free;
  end;
end;

procedure TTeTtable.PopupMenu1Popup(Sender: TObject);
begin
 selection2.enabled:=(codenum[1]>0);
end;

procedure TTeTtable.FormDblClick(Sender: TObject);
begin
 selection2click(self);
end;

end.


