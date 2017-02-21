unit Studlist;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, StdCtrls,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TStudentListWin = class(TStudListWin)
    PopupMenu1: TPopupMenu;
    Selection1: TMenuItem;
    N1: TMenuItem;
    Group1: TMenuItem;
    Select1: TMenuItem;
    N3: TMenuItem;
    PrintSetup1: TMenuItem;
    Print1: TMenuItem;
    ShowStudentTimetable1: TMenuItem;
    Exportastextfile1: TMenuItem;
    Sort1: TMenuItem;
    N2: TMenuItem;
    grp11: TMenuItem;
    grp21: TMenuItem;
    grp31: TMenuItem;
    grp41: TMenuItem;
    grp51: TMenuItem;
    grp61: TMenuItem;
    grp71: TMenuItem;
    grp81: TMenuItem;
    grp91: TMenuItem;
    grp01: TMenuItem;
    grp101: TMenuItem;
    grp111: TMenuItem;
    grp121: TMenuItem;
    grp131: TMenuItem;
    grp141: TMenuItem;
    grp151: TMenuItem;
    procedure Selection1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ShowStudentTimetable1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Select1Click(Sender: TObject);
    procedure Sort1Click(Sender: TObject);
    procedure grp01Click(Sender: TObject);
    procedure SetupGroupCheck(Sender: TObject);
  protected
    procedure SetTabs; override;
    procedure GetLists; override;
    procedure GetListContents(i: integer); override;
    procedure PaintHead;  override;
    procedure ListHead(i:integer);  override;
  private
    procedure updateStudGroupMenu;
  end;

var
  StudentListWin: TStudentListWin;

procedure Studentlistprint;
procedure StudentlistOut;

implementation

uses
  tcommon, stulidlg, groupsel, main, printers, tcommon2, sortgrp, clipbrd, stcommon;

{$R *.DFM}


type TPrintStudList=class(TPrintStudListWin)
  public
   procedure head; override;
   procedure SetTabs; override;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i:integer); override;
 end;

type TOutStudList=class(TOutStudListWin)
  public
   procedure head; override;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i:integer); override;
   procedure SetTabs;
 end;

var
 PrintStudList:    TPrintStudList;
 OutStudList:     TOutStudList;
  maleCount,femaleCount:   array[0..nmbrSubjects] of integer;
  teach:          array[0..nmbrSubYear] of smallint;
  Tmale,Tfemale:  integer;


function CalcCountMax(max: integer):integer;
var
 i,j: integer;
begin
 j:=0;
 for i:=1 to max do
  if ((maleCount[i]+femaleCount[i])>0) then inc(j);
 result:=j;
end;

procedure CountClasses;
var
 i,i9,a:       integer;
begin
 for i:=0 to nmbrClass do
 begin
  maleCount[i]:=0; femaleCount[i]:=0;
 end; {for i}
 Tmale:=0; Tfemale:=0;
 for i9:=1 to groupnum do
 begin
  i:=StGroup[i9];
  a:=Stud[i].TcClass;
  if (trim(ClassCode[a])='') then a:=0;
  if Stud[i].sex='M' then
  begin
   inc(maleCount[a]);
   inc(Tmale);
  end
  else
   begin
    inc(femaleCount[a]);
    inc(Tfemale);
   end;
 end; {for i9}
end;

procedure CountSubjects;
var
 i,j,i9,su,a:  integer;
begin
 for i:=0 to nmbrSubYear do
 begin
  maleCount[i]:=0;  femaleCount[i]:=0;
 end;  {for i}
 Tmale:=0;  Tfemale:=0;
 for i9:=1 to groupnum do
 begin
  i:=StGroup[i9];
  for j:=1 to chmax do
   begin
    su:=Stud[i].Choices[j];
    if su<>0 then
     begin
      a:=GsubXref[su];
      if Stud[i].sex='M' then
       inc(maleCount[a])
      else
        inc(femaleCount[a]);
     end;
   end;
 end; {for i9}
end;

procedure CountRooms;
var
 i,i9,a:  integer;
 aStr:    string;
begin
 for i:=0 to nmbrRooms do
 begin
  maleCount[i]:=0;  femaleCount[i]:=0;
 end; {for i}
 Tmale:=0;   Tfemale:=0;
 for i9:=1 to groupnum do
 begin
  i:=StGroup[i9];
  a:=Stud[i].Home;
  aStr:=copy(Tecode[a,1],1,2);
  if aStr='00' then a:=0;
  if Stud[i].Sex='M' then
  begin
   inc(maleCount[a]);
   inc(Tmale);
  end
  else
   begin
    inc(femaleCount[a]);
    inc(Tfemale);
   end;
 end; {for i9}
end;

procedure CountTutors;
var
 i,i9,a:  integer;
 aStr:    string;
begin
 for i:=0 to nmbrTeachers do
 begin
  maleCount[i]:=0;  femaleCount[i]:=0;
 end; {for i}
 Tmale:=0;  Tfemale:=0;
 for i9:=1 to groupnum do
 begin
  i:=StGroup[i9];
  a:=Stud[i].Tutor;
  aStr:=copy(TeCode[a,0],1,2);
  if aStr='00' then a:=0;
  if Stud[i].Sex='M' then
  begin
   inc(maleCount[a]);
   inc(Tmale);
  end
  else
   begin
    inc(femaleCount[a]);
    inc(Tfemale);
   end;
 end;  {for i9}
end;

procedure CountHouses;
var
 i,i9,a:       integer;
begin
 for i:=0 to nmbrHouse do
 begin
  maleCount[i]:=0;  femaleCount[i]:=0;
 end; {for i}
 Tmale:=0;  Tfemale:=0;
 for i9:=1 to groupnum do
 begin
  i:=StGroup[i9];
  a:=Stud[i].House;
  if trim(HouseName[a])='' then a:=0;
  if Stud[i].sex='M' then
  begin
   inc(maleCount[a]);
   inc(Tmale);
  end
  else
   begin
    inc(femaleCount[a]);
    inc(Tfemale);
   end;
 end; {for i9}
end;

procedure StudentNumberTeach;
var
 d,p,l,i,i2,y:       integer;
 su,te:         integer;
 yrAR:    array[0..nmbryears] of wordbool; //only check year if true
 doneTeach:   array[0..nmbrSubYear] of boolean;
begin
 for i:=0 to nmbryears do yrAR[i]:=false;
 for i:=1 to groupnum do
 begin
  i2:=StPointer[i];
  yrAR[Stud[i2].TcYear]:=true; //add year to search
 end;

 for i:=1 to nmbrSubYear do teach[i]:=0;
 for y:=years_minus_1 downto 0 do
 begin
  if yrAR[y] then //only for years of students selected
  for d:=0 to days-1 do
   for p:=0 to periods-1 do
    for l:=1 to level[y] do
     begin
      su:=FNT(d,p,y,l,0)^;
      te:=FNT(d,p,y,l,2)^;
      i:=0;
      if (su>0) and (su<=numcodes[0]) then i:=GsubXref[su];
      if (i>0) and (te>0) and (te<=numcodes[1]) then
       begin
        if teach[i]=0 then teach[i]:=te;
        if (teach[i]>0) and (teach[i]<>te) then teach[i]:=-1;
       end;
     end;
 end; {for y}

 for i:=1 to nmbrSubYear do DoneTeach[i]:=(Teach[i]<>0);
 if MatchAllYears then  {check other years for subjects with no teacher}
  for y:=years_minus_1 downto 0 do
   if not(yrAR[y]) then //only for years not covered
   begin
    for d:=0 to days-1 do
     for p:=0 to periods-1 do
      for l:=1 to level[y] do
       begin
        su:=FNT(d,p,y,l,0)^;
        te:=FNT(d,p,y,l,2)^;
        i:=0;
        if (su>0) and (su<=numcodes[0]) then i:=GsubXref[su];
        if (i>0) and (te>0) and (te<=numcodes[1]) then
         begin
          if DoneTeach[i]=false then
           begin
            if teach[i]=0 then teach[i]:=te;
            if (teach[i]>0) and (teach[i]<>te) then teach[i]:=-1;
           end;
         end;
       end;
   end; {for y}
end;

procedure TStudentListWin.SetTabs;
var
 tabT: integer;
begin
 SetLength(Tabs,8);
 studentPointerSet;
 if StudListType<7 then ListType:=1 else ListType:=2;
 {1 - student list  2- numbers}
 codeColor:=cpStList; EnrolFlag:=listEnrolment; ShowZeroList:=true;
 ListHeadLines:=1;
 tabT:=canvas.textwidth('123Total  ');
 if StudListType<>7 then
  begin
   GetLists;
   CalcArrayTops;
  end
 else {numbers}
  begin
   case listnumbertype of
    1: begin
        MaxTab(1,fwClass,'Not Allocated  ');
        countClasses;
        TotalCount:=7+CalcCountMax(Classnum);
       end;
    2: begin
        MaxTab(1,fwHouse,'Not Allocated  ');
        countHouses;
        TotalCount:=7+CalcCountMax(Housecount);
       end;
    3: begin
        MaxTab(1,fwCode[0],'Subject ');
        MaxTab(2,fwCodename[0],'Subject Name ');
        MaxTab(3,fwCode[1],'Teacher ');
        MaxTab(4,fwCodename[1],'Teacher Name ');
        MaxTab(5,0,'123Male');
        MaxTab(6,0,'123Female');
        Tabs[7]:=Tabs[6]+tabT;
        countSubjects;
        StudentNumberTeach;
        TotalCount:=7+CalcCountMax(NumCodes[0]);
       end;
    4: begin
        MaxTab(1,fwCode[1]+fwCodename[1]+blankwidth,'Not Allocated  ');
        countTutors;
        TotalCount:=7+CalcCountMax(numcodes[1]);
       end;
    5: begin
        MaxTab(1,fwCode[2]+fwCodename[2]+blankwidth,'Not Allocated  ');
        countRooms;
        TotalCount:=7+CalcCountMax(numcodes[2]);
       end;
   end; {case}
   if listnumbertype<>3 then
    begin
      MaxTab(2,0,'123Male');
      MaxTab(3,0,'123Female');
      Tabs[7]:=Tabs[3]+tabT;
    end;
   maxH:=double_print*TxtHeight*TotalCount;
   maxW:=Tabs[7];
   Selcode:=0;
  end;
 RedoSelection;
end;

procedure TStudentListWin.SetupGroupCheck(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to Main.MainForm.Student1.Count - 1 do
    Group1.Items[i].Checked := Main.MainForm.Student1.Items[i].Checked;
end;

Procedure GeneralListContents(i,size,myset:integer;var Contents: array of integer);
var
 j,count: integer;
begin
 count:=0;
 if Size=0 then exit;
 case StudListType of
  1: for j:=1 to size do Contents[j]:=liststudentselection[j];
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

procedure TStudentListWin.GetListContents(i:integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TStudentListWin.GetLists;
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
 if StudListType>2 then
   begin
    for i:=1 to groupnum do
    begin
     i2:=StPointer[i];
     case StudListType of
      3: inc(verify[Stud[i2].Tcclass]);
      4: inc(verify[Stud[i2].house]);
      5: inc(verify[Stud[i2].tutor]);
      6: inc(verify[Stud[i2].home]);
     end; {case}
    end; {for i}
    case StudListType of
     3: for i:=1 to classnum do AddInUse(RollClassPoint[i]);
     4: for i:=1 to HouseCount do AddInUse(i);
     5: for i:=1 to codenum[1] do AddInUse(codepoint[i,1]);
     6: for i:=1 to codenum[2] do AddInUse(codepoint[i,2]);
    end; {case}

 end; {if stuttlistselection>2 }
 NumOfLists:=1; SetArraySizes;
 case StudListType of
  1: ListSize[1]:=liststudentselection[0];
  2: ListSize[1]:=GroupNum;
  3..6: if listranges[StudListType-2,1]=0 then
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
         ListSet[1]:=listranges[StudListType-2,1];
         ListSize[1]:=verify[listranges[StudListType-2,1]];
        end;
 end;{case}
end;

procedure TStudentListWin.PaintHead;
begin
 fcolor(cpNormal);
 printWl('Student');
 case StudListType of
  1:  if liststudentselection[0]>0 then printWl(' Selection');
  2:  printWl('s '+' Group: '+groupname+' sorted by '+groupsortname[groupsort]);
  3:  begin
       if listRanges[1,1]>0 then
        printWl('s in '+ClassCode[listRanges[1,1]])
       else printWl('s in All Classes');
       printWl(' sorted by '+groupsortname[groupsort]);
      end;
  4:  begin
       if listRanges[2,1]>0 then
        printWl('s in '+HouseName[listRanges[2,1]])
       else printWl('s in All Houses');
       printWl(' sorted by '+groupsortname[groupsort]);
      end;
  5:  begin
       if listRanges[3,1]>0 then
        printWl('s in '+TeCode[listRanges[3,1],0])
       else printWl('s in All Tutors');
       printWl(' sorted by '+groupsortname[groupsort]);
      end;
  6:  begin
       if listRanges[4,1]>0 then
        printWl('s in '+TeCode[listRanges[4,1],1])
       else printWl('s in All Home Rooms');
       printWl(' sorted by '+groupsortname[groupsort]);
      end;
  7:  begin
       case listnumbertype of
       1: begin
           printWl(' Numbers for Classes');
           newline; newline;
           printWl('Class');
          end;
       2: begin
           printWl(' Numbers for Houses');
           newline; newline;
           printWl('House');
          end;
       3:  begin
           printWl(' Numbers for Subjects');
           newline; newline;
           printWl('Subject');
           x:=Tabs[1]; printwl('Subject name');
           x:=Tabs[2]; printWl('Teacher');
           x:=Tabs[3]; printWl('Teacher name');
           x:=Tabs[4]; printWl('Male');
           x:=Tabs[5]; printWl('Female');
           x:=Tabs[6]; printWl('Total');
          end;
       4:  begin
           printWl(' Numbers for Tutors');
           newline; newline;
           printWl('Tutor');
          end;
       5: begin
           printWl(' Numbers for Rooms');
           newline; newline;
           printWl('Room');
          end;
       end; {case}
       if listnumbertype<>3 then
        begin
         x:=Tabs[1]; printWl('Male');
         x:=Tabs[2]; printWl('Female');
         x:=Tabs[3]; printWl('Total');
        end;
      end;
 end; {case}
 newline;
end;

procedure TStudentListWin.ListHead(i:integer);
begin
 fcolor(cpNormal);
 case StudListType of
  3: printw('Class '+ClassCode[ListSet[i]]);
  4:printw('House '+HouseName[ListSet[i]]);
  5:printw('Tutor '+TeCode[ListSet[i],0]+' '+TeName[ListSet[i],0]);
  6:printw('Room '+TeCode[ListSet[i],1]+' '+TeName[ListSet[i],1]);
 end;
 newline;
 fcolor(codecolor);
end;

Procedure UpdateStudCalcs;
begin
 CountChmax;
 REselectgroup;
 getStudentFontWidths;
 studentPointerSet;
 UpdateStudListFlg:=true;
 UpdateStudWins;
end;

procedure TStudentListWin.Selection1Click(Sender: TObject);
var
  i: Integer;
begin
  DoubleClick:=true;
  StudListDlg := TStudListDlg.Create(Application);
  try
    if StudListDlg.ShowModal = mrOK then
    begin
      for i := 0 to MainForm.Student1.Count - 1 do
        MainForm.Student1.Items[i].Checked := False;
      GroupIndexDisplay := 0;
    end;
  finally
    FreeAndNil(StudListDlg);
  end;
end;

procedure TStudentListWin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TStudentListWin.FormPaint(Sender: TObject);

  procedure printNumbers(max: integer);
  var
   tabN,i,a,te,ro: integer;
   teStr: string;

     procedure AdjustPrint(n:integer);
      begin
       x:=x+tabN-canvas.textwidth(inttostr(n));
       printw(inttostr(n));
      end;

  begin
   tabN:=canvas.textwidth('9999');
   for i:=1 to max do
    if ((maleCount[i]+femaleCount[i])>0) then
    begin
     if double_space then newline;
     case listnumbertype of
      1: printw(ClassCode[i]);  {classes}
      2: printw(HouseName[i]); {houses}
      3: begin {subjects}
          a:=GroupSubs[i];
          printw(SubCode[a]); x:=Tabs[1]; printw(Subname[a]);
          x:=Tabs[2];
          te:=teach[i]; if teach[i]=-1 then findSubTeacher(te,ro,a);
          testr:='';
          if te>0 then
           begin
            testr:=tecode[te,0];
            if teach[i]=-1 then testr:=testr+'*';
            fcolor(cpTeach);
            printw(testr);
            x:=Tabs[3]; printw(Tename[te,0]);
            fcolor(codecolor);
           end;
          x:=Tabs[4]; AdjustPrint(maleCount[i]);
          x:=Tabs[5]; AdjustPrint(femaleCount[i]);
          x:=Tabs[6]; AdjustPrint(maleCount[i]+femaleCount[i]);
          newline;
         end;
      4: begin  {tutors}
          printw(TeCode[i,0]);
          x:=fwCode[1]+blankwidth; printw(TeName[i,0]);
         end;
      5: begin {rooms}
          printw(teCode[i,1]);
          x:=fwCode[2]+blankwidth;
          printw(TeName[i,1]);
         end;
     end; {case}

    if (listnumbertype<>3) then
    begin
     x:=Tabs[1]; AdjustPrint(maleCount[i]);
     x:=Tabs[2]; AdjustPrint(femaleCount[i]);
     x:=Tabs[3]; AdjustPrint(maleCount[i]+femaleCount[i]);
     newline;
    end;
    end; {for i}
   if ((maleCount[0]+femaleCount[0])>0) then
   begin
    if double_space then newline;
    printw('Not allocated:');
    x:=Tabs[1]; AdjustPrint(maleCount[0]);
    x:=Tabs[2]; AdjustPrint(femaleCount[0]);
    x:=Tabs[3]; AdjustPrint(maleCount[0]+femaleCount[0]);
    newline;
   end;
   if (listnumbertype<>3) then
   begin
    fcolor(cpNormal);
    if double_space then newline;
    printw('Totals:');
    x:=Tabs[1]; AdjustPrint(Tmale);
    x:=Tabs[2]; AdjustPrint(Tfemale);
    x:=Tabs[3]; AdjustPrint(Tmale+Tfemale);
    newline
   end;
  end; {---------------- local procedure printnumbers ---------------}


begin    { START  of main paint proc}
 if StudListType=7 then
  begin
   PaintHead;
   fcolor(codecolor);
   case listnumbertype of
      1: printNumbers(nmbrClass);
      2: printNumbers(nmbrHouse);
      3: printNumbers(GroupSubs[0]);
      4: printNumbers(nmbrTeachers);
      5: printNumbers(nmbrRooms);
   end; {case}
  end;
end;

procedure TStudentListWin.updateStudGroupMenu;
var
 j,i: smallint;
begin
 j:=GOSmenu[0];
 try
  n2.visible:=(j>0);
  grp01.visible:=(j>0); grp11.visible:=(j>1);
  grp21.visible:=(j>2); grp31.visible:=(j>3);
  grp41.visible:=(j>4); grp51.visible:=(j>5);
  grp61.visible:=(j>6); grp71.visible:=(j>7);
  grp81.visible:=(j>8); grp91.visible:=(j>9);
  grp101.visible:=(j>10); grp111.visible:=(j>11);
  grp121.visible:=(j>12); grp131.visible:=(j>13);
  grp141.visible:=(j>14); grp151.visible:=(j>15);

  if j>0 then
   for i:=1 to j do
   begin
    case i of
     1: grp01.caption:=GOSname[GOSmenu[i]];
     2: grp11.caption:=GOSname[GOSmenu[i]];
     3: grp21.caption:=GOSname[GOSmenu[i]];
     4: grp31.caption:=GOSname[GOSmenu[i]];
     5: grp41.caption:=GOSname[GOSmenu[i]];
     6: grp51.caption:=GOSname[GOSmenu[i]];
     7: grp61.caption:=GOSname[GOSmenu[i]];
     8: grp71.caption:=GOSname[GOSmenu[i]];
     9: grp81.caption:=GOSname[GOSmenu[i]];
    10: grp91.caption:=GOSname[GOSmenu[i]];
    11: grp101.caption:=GOSname[GOSmenu[i]];
    12: grp111.caption:=GOSname[GOSmenu[i]];
    13: grp121.caption:=GOSname[GOSmenu[i]];
    14: grp131.caption:=GOSname[GOSmenu[i]];
    15: grp141.caption:=GOSname[GOSmenu[i]];
    end; {case}
   end;
 except
 end;
end;

procedure TStudentListWin.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnStudentList);
 updateStudGroupMenu;
 rangeCheckStudSels(liststudentselection);
 BarcodeMake;
end;

procedure TStudentListWin.FormActivate(Sender: TObject);
begin
 doubleclick:=false;
 inherited;
end;

{---------------------- print procs follow -----------------------------------------}

procedure TPrintStudList.head;
begin
 UnderlineOn;
 printwl('Student List '+GroupCaption);
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(cpNormal);
 printWl('Student');
 case StudListType of
  1:  if liststudentselection[0]>0 then printWl(' Selection');
  2:  printWl('s '+' Group: '+groupname+' sorted by '+groupsortname[groupsort]);
  3:  begin
       if listRanges[1,1]>0 then
        printWl('s in '+ClassCode[listRanges[1,1]])
       else printWl('s in All Classes');
       printWl(' sorted by '+groupsortname[groupsort]);
      end;
  4:  begin
       if listRanges[2,1]>0 then
        printWl('s in '+HouseName[listRanges[2,1]])
       else printWl('s in All Houses');
       printWl(' sorted by '+groupsortname[groupsort]);
      end;
  5:  begin
       if listRanges[3,1]>0 then
        printWl('s in '+TeCode[listRanges[3,1],0])
       else printWl('s in All Tutors');
       printWl(' sorted by '+groupsortname[groupsort]);
      end;
  6:  begin
       if listRanges[4,1]>0 then
        printWl('s in '+TeCode[listRanges[4,1],1])
       else printWl('s in All Home Rooms');
       printWl(' sorted by '+groupsortname[groupsort]);
      end;
  7:  begin
       case listnumbertype of
       1: begin
           printWl(' Numbers for Classes');
           x:=0; y:=y+2*PrnttxtHeight;
           printWl('Class');
          end;
       2: begin
           printWl(' Numbers for Houses');
           x:=0; y:=y+2*PrnttxtHeight;
           printWl('House');
          end;
       3:  begin
           printWl(' Numbers for Subjects');
           x:=0; y:=y+2*PrnttxtHeight;
           printWl('Subject');
           x:=PrntTabs[1]; printwl('Subject name');
           x:=PrntTabs[2]; printWl('Teacher');
           x:=PrntTabs[3]; printWl('Teacher name');
           x:=PrntTabs[4]; printWl('Male');
           x:=PrntTabs[5]; printWl('Female');
           x:=PrntTabs[6]; printWl('Total');
          end;
       4:  begin
           printWl(' Numbers for Tutors');
           x:=0; y:=y+2*PrnttxtHeight;
           printWl('Tutor');
          end;
       5: begin
           printWl(' Numbers for Rooms');
           x:=0; y:=y+2*PrnttxtHeight;
           printWl('Room');
          end;
       end; {case}
       if listnumbertype<>3 then
        begin
         x:=PrntTabs[1]; printWl('Male');
         x:=PrntTabs[2]; printWl('Female');
         x:=PrntTabs[3]; printWl('Total');
        end;
      end;
 end; {case}
  x:=0; y:=y+PrnttxtHeight;
end;

procedure TPrintStudList.ListHead(i:integer);
begin
 fcolor(cpNormal);
 case StudListType of
  3: printw('Class '+ClassCode[ListSet[i]]);
  4:printw('House '+HouseName[ListSet[i]]);
  5:printw('Tutor '+TeCode[ListSet[i],0]+' '+TeName[ListSet[i],0]);
  6:printw('Room '+TeCode[ListSet[i],1]+' '+TeName[ListSet[i],1]);
 end;
 newline;
 fcolor(codecolor);
end;

procedure TPrintStudList.GetLists;
var
 i: integer;
begin
 NumOfLists:=StudentListWin.NumOfLists;
 SetArraySizes;
 if NumOfLists>0 then
  for i:=1 to NumOfLists do
   begin
    ListSize[i]:=StudentListWin.ListSize[i];
    ListSet[i]:=StudentListWin.ListSet[i];
   end;
end;

procedure TPrintStudList.GetListContents(i: integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TPrintStudList.SetTabs;
var
 tabT: integer;
begin
 SetLength(PrntTabs,8);
 if StudListType<7 then ListType:=1 else ListType:=2;
 {1 - student list  2- numbers}
 codeColor:=cpStList; EnrolFlag:=listEnrolment;
 ShowZeroList:=true;
 tabT:=PrintCanvas.textwidth('123Total  ');
 if StudListType<>7 then
  begin
   GetLists;
   CalcHeights;
  end
 else {numbers}
  begin
   case listnumbertype of
    1: begin
        MaxTab(1,fwPrntClass,'Not Allocated  ');
        countClasses;
        TotalCount:=7+CalcCountMax(Classnum);
       end;
    2: begin
        MaxTab(1,fwPrntHouse,'Not Allocated  ');
        countHouses;
        TotalCount:=7+CalcCountMax(Housecount);
       end;
    3: begin
        MaxTab(1,fwPrntCode[0],'Subject ');
        MaxTab(2,fwPrntCodename[0],'Subject Name ');
        MaxTab(3,fwPrntCode[1],'Teacher ');
        MaxTab(4,fwPrntCodename[1],'Teacher Name ');
        MaxTab(5,0,'123Male');
        MaxTab(6,0,'123Female');
        PrntTabs[7]:=PrntTabs[6]+tabT;
        countSubjects;
        StudentNumberTeach;
        TotalCount:=7+CalcCountMax(NumCodes[0]);
       end;
    4: begin
        MaxTab(1,fwPrntCode[1]+fwPrntCodename[1]+PrntBlankwidth,'Not Allocated  ');
        countTutors;
        TotalCount:=7+CalcCountMax(numcodes[1]);
       end;
    5: begin
        MaxTab(1,fwPrntCode[2]+fwPrntCodename[2]+PrntBlankwidth,'Not Allocated  ');
        countRooms;
        TotalCount:=7+CalcCountMax(numcodes[2]);
       end;
   end; {case}
   if listnumbertype<>3 then
    begin
      MaxTab(2,0,'123Male');
      MaxTab(3,0,'123Female');
      PrntTabs[7]:=PrntTabs[3]+tabT;
    end;
  end;
end;

procedure Studentlistprint;

 procedure printNumbers(max: integer);
 var
  tabN,i,a: integer;

     procedure AdjustPrint(n:integer);
      begin
       with PrintStudList do
        begin
         x:=x+tabN-PrintCanvas.textwidth(inttostr(n));
         printw(inttostr(n));
        end;
      end;

 begin
  with PrintStudList do
  begin
   tabN:=PrintCanvas.textwidth('9999');
   for i:=1 to max do
    if ((maleCount[i]+femaleCount[i])>0) then
    begin
     if double_space then newline;
     case listnumbertype of
      1: printw(ClassCode[i]);  {classes}
      2: printw(HouseName[i]); {houses}
      3: begin {subjects}
          a:=GroupSubs[i];
          printw(SubCode[a]); x:=PrntTabs[1]; printw(Subname[a]);
          x:=PrntTabs[2];
          if teach[i]<>-1 then
          begin
           printw(TeCode[teach[i],0]);
           x:=PrntTabs[3]; printw(Tename[teach[i],0]);
          end
          else
           printw('*');
          x:=PrntTabs[4]; AdjustPrint(maleCount[i]);
          x:=PrntTabs[5]; AdjustPrint(femaleCount[i]);
          x:=PrntTabs[6]; AdjustPrint(maleCount[i]+femaleCount[i]);
          newline;
         end;
      4: begin  {tutors}
          printw(TeCode[i,0]);
          x:=fwPrntCode[1]+PrntBlankwidth; printw(TeName[i,0]);
         end;
      5: begin {rooms}
          printw(teCode[i,1]);
          x:=fwPrntCode[2]+PrntBlankwidth;
          printw(TeName[i,1]);
         end;
     end; {case}

    if (listnumbertype<>3) then
    begin
     x:=PrntTabs[1]; AdjustPrint(maleCount[i]);
     x:=PrntTabs[2]; AdjustPrint(femaleCount[i]);
     x:=PrntTabs[3]; AdjustPrint(maleCount[i]+femaleCount[i]);
     newline;
    end;
    end; {for i}
   if ((maleCount[0]+femaleCount[0])>0) then
   begin
    if double_space then newline;
    printw('Not allocated:');
    x:=PrntTabs[1]; AdjustPrint(maleCount[0]);
    x:=PrntTabs[2]; AdjustPrint(femaleCount[0]);
    x:=PrntTabs[3]; AdjustPrint(maleCount[0]+femaleCount[0]);
    newline;
   end;
   if (listnumbertype<>3) then
   begin
    fcolor(cpNormal);
    if double_space then newline;
    printw('Totals:');
    x:=PrntTabs[1]; AdjustPrint(Tmale);
    x:=PrntTabs[2]; AdjustPrint(Tfemale);
    x:=PrntTabs[3]; AdjustPrint(Tmale+Tfemale);
    newline
   end;
  end; {with PrintStudList}
 end; {---------------- local procedure printnumbers ---------------}

begin    { START  of main paint proc}
 PrintStudList:=TPrintStudList.Create;
 with PrintStudList do
  try
   BarcodeMake;
   SetTabs;
   if StudListType=7 then
      begin
       header;
       fcolor(codecolor);
       case listnumbertype of
          1: printNumbers(nmbrClass);
          2: printNumbers(nmbrHouse);
          3: printNumbers(GroupSubs[0]);
          4: printNumbers(nmbrTeachers);
          5: printNumbers(nmbrRooms);
       end; {case}
       printCustomAddon;
      end
   else ShowLists;
  finally
   PrintStudList.free;
  end;
end;

procedure TOutStudList.head;
begin
 printLine(['Student List ',GroupCaption]);
 printw('Student');
 case StudListType of
  1:  if liststudentselection[0]>0 then printw(' Selection');
  2:  printw('s '+' Group: '+groupname+' sorted by '+groupsortname[groupsort]);
  3:  begin
       if listRanges[1,1]>0 then
        printw('s in '+ClassCode[listRanges[1,1]])
       else printw('s in All Classes');
       printw(' sorted by '+groupsortname[groupsort]);
      end;
  4:  begin
       if listRanges[2,1]>0 then
        printw('s in '+HouseName[listRanges[2,1]])
       else printw('s in All Houses');
       printw(' sorted by '+groupsortname[groupsort]);
      end;
  5:  begin
       if listRanges[3,1]>0 then
        printw('s in '+TeCode[listRanges[3,1],0])
       else printW('s in All Tutors');
       printW(' sorted by '+groupsortname[groupsort]);
      end;
  6:  begin
       if listRanges[4,1]>0 then
        printW('s in '+TeCode[listRanges[4,1],1])
       else printW('s in All Home Rooms');
       printW(' sorted by '+groupsortname[groupsort]);
      end;
  7:  begin
       case listnumbertype of
       1: begin
           printW(' Numbers for Classes');
           newline; newline;
           printW('Class');
          end;
       2: begin
           printW(' Numbers for Houses');
           newline; newline;
           printW('House');
          end;
       3:  begin
           printW(' Numbers for Subjects');
           newline; newline;
           printW('Subject');
           printc('Subject name');
           printc('Teacher');
           printc('Teacher name');
           printc('Male');
           printc('Female');
           printc('Total');
          end;
       4:  begin
           printW(' Numbers for Tutors');
           newline; newline;
           printW('Tutor');
          end;
       5: begin
           printW(' Numbers for Rooms');
           newline; newline;
           printW('Room');
          end;
       end; {case}
       if listnumbertype<>3 then
        begin
         printc('Male');
         printc('Female');
         printc('Total');
        end;
      end;
 end; {case}
  newline; newline;
end;

procedure TOutStudList.ListHead(i:integer);
begin
 case StudListType of
  3:printw('Class '+ClassCode[ListSet[i]]);
  4:printw('House '+HouseName[ListSet[i]]);
  5:printw('Tutor '+TeCode[ListSet[i],0]+' '+TeName[ListSet[i],0]);
  6:printw('Room '+TeCode[ListSet[i],1]+' '+TeName[ListSet[i],1]);
 end;
 newline;
end;

procedure TOutStudList.GetLists;
var
 i: integer;
begin
 NumOfLists:=StudentListWin.NumOfLists;
 SetArraySizes;
 if NumOfLists>0 then
  for i:=1 to NumOfLists do
   begin
    ListSize[i]:=StudentListWin.ListSize[i];
    ListSet[i]:=StudentListWin.ListSet[i];
   end;
end;

procedure TOutStudList.GetListContents(i: integer);
begin
 SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents);
end;

procedure TOutStudList.SetTabs;
begin
 if StudListType<7 then ListType:=1 else ListType:=2;
 {1 - student list  2- numbers}
 EnrolFlag:=listEnrolment;
 ShowZeroList:=true;
 if StudListType<>7 then
  begin
   GetLists;
   CalcTotalCount;
  end
 else {numbers}
  begin
   case listnumbertype of
    1: begin
        countClasses;
        TotalCount:=7+CalcCountMax(Classnum);
       end;
    2: begin
        countHouses;
        TotalCount:=7+CalcCountMax(Housecount);
       end;
    3: begin
        countSubjects;
        StudentNumberTeach;
        TotalCount:=7+CalcCountMax(NumCodes[0]);
       end;
    4: begin
        countTutors;
        TotalCount:=7+CalcCountMax(numcodes[1]);
       end;
    5: begin
        countRooms;
        TotalCount:=7+CalcCountMax(numcodes[2]);
       end;
   end; {case}
  end;
end;

procedure StudentlistOut;

 procedure printNumbers(max: integer);
 var
  i,a: integer;

     procedure Printn(n:integer);
      begin
       OutStudList.printc(inttostr(n));
      end;

 begin
  with OutStudList do
  begin
   for i:=1 to max do
    if ((maleCount[i]+femaleCount[i])>0) then
    begin
     if double_space then newline;
     case listnumbertype of
      1: printw(ClassCode[i]);  {classes}
      2: printw(HouseName[i]); {houses}
      3: begin {subjects}
          a:=GroupSubs[i];
          printw(SubCode[a]); printc(Subname[a]);
          if teach[i]<>-1 then
          begin
           printc(TeCode[teach[i],0]);
           printc(Tename[teach[i],0]);
          end
          else
           printc('*');
           printn(maleCount[i]);
           printn(femaleCount[i]);
           printn(maleCount[i]+femaleCount[i]);
          newline;
         end;
      4: begin  {tutors}
          printw(TeCode[i,0]);
          printc(TeName[i,0]);
         end;
      5: begin {rooms}
          printw(teCode[i,1]);
          printc(TeName[i,1]);
         end;
     end; {case}

    if (listnumbertype<>3) then
    begin
     printn(maleCount[i]);
     printn(femaleCount[i]);
     printn(maleCount[i]+femaleCount[i]);
     newline;
    end;
    end; {for i}
   if ((maleCount[0]+femaleCount[0])>0) then
   begin
    if double_space then newline;
    printw('Not allocated:');
    if listnumbertype>3 then printc('');
    printn(maleCount[0]);
    printn(femaleCount[0]);
    printn(maleCount[0]+femaleCount[0]);
    newline;
   end;
   if (listnumbertype<>3) then
   begin
    if double_space then newline;
    printw('Totals:');
    if listnumbertype>3 then printc('');
    printn(Tmale);
    printn(Tfemale);
    printn(Tmale+Tfemale);
    newline
   end;
  end; {with PrintStudList}
 end; {---------------- local procedure printnumbers ---------------}

begin    { START  of main paint proc}
 OutStudList:=TOutStudList.Create;
 with OutStudList do
  try
   SetTabs;
   if StudListType=7 then
      begin
       header;
       case listnumbertype of
          1: printNumbers(nmbrClass);
          2: printNumbers(nmbrHouse);
          3: printNumbers(GroupSubs[0]);
          4: printNumbers(nmbrTeachers);
          5: printNumbers(nmbrRooms);
       end; {case}
       printCustomAddon;
      end
   else ShowLists;
  finally
   OutStudList.free;
  end;
end;

procedure TStudentListWin.PopupMenu1Popup(Sender: TObject);
begin
 if numstud=0 then group1.enabled:=false else group1.enabled:=true;
 selection1.enabled:=(numstud>0);
 ShowStudentTimetable1.visible:=(selcode>0);
end;

procedure TStudentListWin.ShowStudentTimetable1Click(Sender: TObject);
begin
 ShowStudTt;
end;

procedure TStudentListWin.FormKeyPress(Sender: TObject; var Key: Char);
var
 winnum: integer;
begin
 winnum:=mainform.activemdichild.tag;
 if uppercase(key)='V' then
  case winnum of
   wnStudentList: begin
        listEnrolment:=not(listEnrolment);
        UpdateWin;
       end;
  end; {case}
end;

procedure TStudentListWin.Select1Click(Sender: TObject);
begin
 MainForm.Select1Click(Self);
end;

procedure TStudentListWin.Sort1Click(Sender: TObject);
begin
 MainForm.Sort1Click(Self);
end;

procedure TStudentListWin.grp01Click(Sender: TObject);
var
  i: Integer;
begin
  CookCustomGroup(GOSmenu[(sender as TMenuItem).Tag]);
  GroupIndexDisplay := GOSmenu[(sender as TMenuItem).tag];
  for i := 0 to (Sender as TMenuItem).Parent.Count - 1 do
  begin
    //Keep the tags of group menu in Main in synch with group menu here
    if Main.MainForm.Student1.Items[i].Tag = (Sender as TMenuItem).Tag then
       Main.MainForm.Student1.Items[i].Checked := True
    else
      Main.MainForm.Student1.Items[i].Checked := False;
  end;
end;

function getMinYearWithStuds: smallint;
var
 i,j: smallint;
begin
 j:=0;
 for i:=0 to years_minus_1 do
  if yearStat[i].numStud>0 then
  begin
   j:=i; break;
  end;
 result:=j;
end;

end.
