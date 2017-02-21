unit Studttab;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TSTtable = class(TListTtWin)
    PopupMenu1: TPopupMenu;
    Selection2: TMenuItem;
    N2: TMenuItem;
    PrintSetup1: TMenuItem;
    Print1: TMenuItem;
    Copy1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Selection2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  STtable: TSTtable;

procedure studTtableprint;
procedure studTtableOut;

implementation
uses tcommon,main,stuttdlg,printers,tcommon2;
{$R *.DFM}

type TPrintStudTtWin=class(TPrintListTtWin)
  public
   procedure head; override;
   procedure SetTabs; override;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i,d:integer); override;
   procedure ShowName(i:integer);  override;
   procedure WeeklyFooter(i:integer); override;
   procedure ShowTtItems(i,d,p,x1: integer); override;
 end;

type TOutStudTtWin=class(TOutListTtWin)
  public
   procedure head; override;
   procedure SetTabs; override;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i,d:integer); override;
   procedure ShowName(i:integer);  override;
   procedure WeeklyFooter(i:integer); override;
   procedure ShowTtItems(i,d,p: integer); override;
 end;


var
 PrintStudTtWin:    TPrintStudTtWin;
 OutStudTtWin:    TOutStudTtWin;
 
procedure TSTtable.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure TSTtable.Selection2Click(Sender: TObject);
begin
 Studttabledlg:=TStudttabledlg.create(self);   {allocate dlg}
 Studttabledlg.showmodal;
 Studttabledlg.free;
end;



Procedure GeneralListContents(i,size,myset:integer;var Contents: array of integer);
var
 j,count: integer;
begin
 count:=0;
 if Size=0 then exit;
 case stuttlistselection of
  1: for j:=1 to size do Contents[j]:=studentttselection[j];
  2: for j:=1 to size do Contents[j]:=StPointer[j];
  3: for j:=1 to GroupNum do
       if Stud[StPointer[j]].TcClass=myset then
          begin inc(count); Contents[count]:=StPointer[j]; end;
  4: for j:=1 to GroupNum do
       if Stud[StPointer[j]].house=myset then
          begin inc(count); Contents[count]:=StPointer[j]; end;
  5: for j:=1 to GroupNum do
       if Stud[StPointer[j]].tutor=myset then
          begin inc(count); Contents[count]:=StPointer[j]; end;
  6: for j:=1 to GroupNum do
       if Stud[StPointer[j]].home=myset then
          begin inc(count); Contents[count]:=StPointer[j]; end;
 end;{case}
end;


procedure TSTtable.GetListContents(i:integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TSTtable.GetLists;
var
 i,i2,kk: integer;
 verify,InUse:  tpTeData;

  procedure AddInUse(j:integer);
  begin
    if bool(verify[j]) then
      begin
       inc(kk);
       InUse[kk]:=j;
      end;
  end;

begin
 for i:=0 to nmbrTeachers do begin verify[i]:=0; InUse[i]:=0; end;
 kk:=0;
 if stuttlistselection>2 then
   begin
    for i:=1 to groupnum do
    begin
     i2:=StPointer[i];
     case stuttlistselection of
      3: inc(verify[Stud[i2].Tcclass]);
      4: inc(verify[Stud[i2].house]);
      5: inc(verify[Stud[i2].tutor]);
      6: inc(verify[Stud[i2].home]);
     end; {case}
    end; {for i}
    case stuttlistselection of
     3: for i:=1 to classnum do AddInUse(RollClassPoint[i]);
     4: for i:=1 to HouseCount do AddInUse(i);
     5: for i:=1 to codenum[1] do AddInUse(codepoint[i,1]);
     6: for i:=1 to codenum[2] do AddInUse(codepoint[i,2]);
    end; {case}

 end; {if stuttlistselection>2 }
 NumOfLists:=1; SetArraySizes;
 case stuttlistselection of
  1: ListSize[1]:=studentttselection[0];
  2: ListSize[1]:=GroupNum;
  3..6: if stuttlistvals[stuttlistselection]=0 then
      begin
       NumOfLists:=kk; SetArraySizes;
       if kk>0 then for i:=1 to kk do
         begin
           ListSize[i]:=verify[InUse[i]];
           ListSet[i]:=InUse[i];
         end;
      end
       else
        begin
         ListSet[1]:=stuttlistvals[stuttlistselection];
         ListSize[1]:=verify[stuttlistvals[stuttlistselection]];
        end;
 end;{case}
end;

procedure TSTtable.ShowName(i:integer);
begin
 if listtype=1 then showstudentname(i)
  else printw(GetStudentName(i));
end;


procedure TSTtable.ListHead(i,d:integer);
var
 s:string;
 j: integer;
begin
 if listtype=1 then s:=dayname[d]+' for ' else s:='For ';
 j:=ListSet[i];
  case stuttlistselection of
   1: s:=s+'Student selection';
   2: s:=s+'Group '+groupname;
   3: s:=s+'Class '+ClassCode[j];
   4: s:=s+'House '+HouseName[j];
   5: begin
       s:=s+'Tutor '+tecode[j,0];
       if trim(tename[j,0])>'' then s:=s+' ('+tename[j,0]+')';
      end;
   6: begin
       s:=s+'Room '+tecode[j,1];
       if trim(tename[j,1])>'' then s:=s+' ('+tename[j,1]+')';
      end;
  end; {case}
  printw(s);   newline;
end;

procedure TSTtable.ShowTtItems(i,d,p,x1: integer);
var
 te,sc,ro,gotyear,lev,offset: integer;
 itemTt1,itemTt2,itemTt3: string;
begin
 sc:=0;
 GetStudentTtItem(te,sc,ro,gotyear,lev,i,d,p,MatchAllYears);
 if sc>0 then
  begin
   itemTt1:=trim(SubCode[sc]);
   itemTt2:=trim(tecode[te,0]);
   itemTt3:=trim(tecode[ro,1]);
   offset:=(dx-3-canvas.textwidth(ItemTt1)) div 2;
   x:=x1+offset; fcolor(cpSub); printw(ItemTt1); {subject}
   inc(y,txtHeight);
   offset:=(dx-3-canvas.textwidth(ItemTt2+' '+ItemTt3)) div 2;
   x:=x1+offset;
   fcolor(cpTeach);  printwl(ItemTt2+' '); {teacher}
   fcolor(cpRoom);  printw(ItemTt3);  {room}
   dec(y,txtHeight);
  end;
end;


procedure TSTtable.SetTabs;
var
 A1: integer;
begin
 caption:='Student Timetable'+GroupCaption;
 studentPointerSet;
 listtype:=winView[wnStudentTt]+1;  CodeColor:=cpStList; {student}
 day1:=stuttlistvals[7]; day2:=stuttlistvals[8];
 yFooter:=0; 
 dx:=8+fwCode[1]+fwCode[2]+(blankwidth div 2);
 A1:=8+fwCode[0];
 if A1>dx then dx:=A1;
 case listtype of
   1: {daily}
     begin
      A1:=8+fwperiodname;
      if A1>dx then dx:=A1;
      tab1:=fwstname+blankwidth;
      CalcTabStField;
      inc(tab1,TabStField);
     end;
   2: {weekly}
     begin
      A1:=8+fwDayname;
      if A1>dx then dx:=A1;
      tab1:=fwPeriodname+blankwidth;
     end;
 end;
 GetLists;
 CalcArrayTops;
end;

procedure TSTtable.WeeklyFooter(i:integer);
begin
 if listtype=1 then {daily}
  begin
   printw('Students: '+inttostr(ListSize[i]));
  end;
end;

procedure TSTtable.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnStudentTt);
end;


{-------=======--------========= printing procs follow -------=======--------=========}


procedure TPrintStudTtWin.head;
begin
 UnderlineOn;
 printwl('Student Timetable ');
 if winView[wnStudentTt]=0 then printwl(GroupCaption);
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
end;

procedure TPrintStudTtWin.WeeklyFooter(i:integer);
begin
 if listtype=1 then {daily}
  begin
   printw('Students: '+inttostr(ListSize[i]));
  end;
end;

procedure TPrintStudTtWin.SetTabs;
var
 A1: integer;
begin
 listtype:=winView[wnStudentTt]+1;  CodeColor:=cpStList; {student}
 day1:=stuttlistvals[7]; day2:=stuttlistvals[8];
 yFooter:=0; 
 dx:=8+fwPrntCode[1]+fwPrntCode[2]+Prntblankwidth;
 A1:=8+fwPrntCode[0];
 if A1>dx then dx:=A1;
 case listtype of
   1: {daily}
     begin
      A1:=8+fwPrntperiodname;
      if A1>dx then dx:=A1;
      tab1:=fwPrntstname+Prntblankwidth;
      CalcTabStField;
      inc(tab1,TabStField);
     end;
   2: {weekly}
     begin
      A1:=8+fwPrntDayname;
      if A1>dx then dx:=A1;
     end;
 end;
 GetLists;
end;


procedure TPrintStudTtWin.GetLists;
var
 i: integer;
begin
 NumOfLists:=STtable.NumOfLists;
 SetArraySizes;
 if NumOfLists>0 then
  for i:=1 to NumOfLists do
   begin
    ListSize[i]:=STtable.ListSize[i];
    ListSet[i]:=STtable.ListSet[i];
   end;
end;


procedure TPrintStudTtWin.GetListContents(i: integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TPrintStudTtWin.ShowName(i:integer);
begin
  if listtype=1 then showstudentname(i)
  else printw(GetStudentName(i));
end;


procedure TPrintStudTtWin.ListHead(i,d:integer);
var
 s:string;
 j: integer;
begin
 if listtype=1 then s:=dayname[d]+' for ' else s:='For ';
 j:=ListSet[i];
  case stuttlistselection of
   1: s:=s+'Student selection';
   2: s:=s+'Group '+groupname;
   3: s:=s+'Class '+ClassCode[j];
   4: s:=s+'House '+HouseName[j];
   5: begin
       s:=s+'Tutor '+tecode[j,0];
       if trim(tename[j,0])>'' then s:=s+' ('+tename[j,0]+')';
      end;
   6: begin
       s:=s+'Room '+tecode[j,1];
       if trim(tename[j,1])>'' then s:=s+' ('+tename[j,1]+')';
      end;
  end; {case}
  printw(s);   newline;
end;

procedure TPrintStudTtWin.ShowTtItems(i,d,p,x1: integer);
var
 te,sc,ro,gotyear,lev,offset: integer;
 itemTt1,itemTt2,itemTt3: string;
begin
 sc:=0;
 GetStudentTtItem(te,sc,ro,gotyear,lev,i,d,p,MatchAllYears);
 if sc>0 then
  begin
   itemTt1:=trim(SubCode[sc]);
   itemTt2:=trim(tecode[te,0]);
   itemTt3:=trim(tecode[ro,1]);
   offset:=(dx-3-PrintCanvas.textwidth(ItemTt1)) div 2;
   x:=x1+offset; fcolor(cpSub); printw(ItemTt1); {subject}
   inc(y,PrntTxtHeight);
   offset:=(dx-3-PrintCanvas.textwidth(ItemTt2+' '+ItemTt3)) div 2;
   x:=x1+offset;
   fcolor(cpTeach);  printwl(ItemTt2+' '); {teacher}
   fcolor(cpRoom);  printw(ItemTt3);  {room}
   dec(y,PrntTxtHeight);
  end;
end;


procedure studTtableprint;
begin
 PrintStudTtWin:=TPrintStudTtWin.Create;
 with PrintStudTtWin do
  try
   PaintOnPrinter;
  finally
   PrintStudTtWin.free;
  end;
end;



{-------=======-------- Text Output procs follow -------=======--------=========}


procedure TOutStudTtWin.head;
begin
 printw('Student Timetable ');
 if winView[wnStudentTt]=0 then printc(GroupCaption);
 newline;
end;

procedure TOutStudTtWin.WeeklyFooter(i:integer);
begin
 if listtype=1 then {daily}
  begin
   printLine(['Students: ',inttostr(ListSize[i])]);
   newline;
  end;
end;

procedure TOutStudTtWin.SetTabs;
begin
 listtype:=winView[wnStudentTt]+1;
 day1:=stuttlistvals[7]; day2:=stuttlistvals[8];
 GetLists;
 TabCount:=0;
 if listtype=1 then CalcTabCount;
end;


procedure TOutStudTtWin.GetLists;
var
 i: integer;
begin
 NumOfLists:=STtable.NumOfLists;
 SetArraySizes;
 if NumOfLists>0 then
  for i:=1 to NumOfLists do
   begin
    ListSize[i]:=STtable.ListSize[i];
    ListSet[i]:=STtable.ListSet[i];
   end;
end;


procedure TOutStudTtWin.GetListContents(i: integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TOutStudTtWin.ShowName(i:integer);
begin
 showstudentname(i);
end;


procedure TOutStudTtWin.ListHead(i,d:integer);
var
 s:string;
 j: integer;
begin
 if listtype=1 then s:=dayname[d]+' for ' else s:='For ';
 j:=ListSet[i];
  case stuttlistselection of
   1: s:=s+'Student selection';
   2: s:=s+'Group '+groupname;
   3: s:=s+'Class '+ClassCode[j];
   4: s:=s+'House '+HouseName[j];
   5: begin
       s:=s+'Tutor '+tecode[j,0];
       if trim(tename[j,0])>'' then s:=s+' ('+tename[j,0]+')';
      end;
   6: begin
       s:=s+'Room '+tecode[j,1];
       if trim(tename[j,1])>'' then s:=s+' ('+tename[j,1]+')';
      end;
  end; {case}
  printw(s);   newline;
end;

procedure TOutStudTtWin.ShowTtItems(i,d,p: integer);
var
 te,sc,ro,gotyear,lev: integer;
 itemTt1,itemTt2,itemTt3: string;
begin
 sc:=0;
 GetStudentTtItem(te,sc,ro,gotyear,lev,i,d,p,MatchAllYears);
 if sc>0 then
  begin
   itemTt1:=trim(SubCode[sc]);
   itemTt2:=trim(tecode[te,0]);
   itemTt3:=trim(tecode[ro,1]);
   printc(ItemTt1); {subject}
   printc(ItemTt2); {teacher}
   printc(ItemTt3);  {room}
  end
 else
  begin
   printc(''); printc(''); printc('');
  end;
end;


procedure studTtableOut;
begin
 OutStudTtWin:=TOutStudTtWin.Create;
 with OutStudTtWin do
  try
   PaintOnOutput;
  finally
   OutStudTtWin.free;
  end;
end;

procedure TSTtable.PopupMenu1Popup(Sender: TObject);
begin
 selection2.enabled:=(numstud>0);
end;

procedure TSTtable.FormDblClick(Sender: TObject);
begin
 selection2click(self);
end;

end.


