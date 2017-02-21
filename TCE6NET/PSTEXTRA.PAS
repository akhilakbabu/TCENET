unit Pstextra;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, XML.UTILS, GlobalToTcAndTcextra;

type
  TpastExtrasWin = class(TDrawWin)
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N6: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    Copy1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Change2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ModifyData(Sender: TObject);
  protected
    procedure SetTabs; override;
  end;

type
 pastAbsenceRec= record
                  aday:        smallint;
                  amonth:      smallint;
                  atimeslot:   longword;
                  ayear:       smallint;
                  asub:        smallint;
                  aoldte:      smallint;
                  anewte:      smallint;
                  akind:       smallint;
                  areason:     smallint;
                  agen:        smallint;
                  attday:      smallint;
                 end;
var
  pastExtrasWin: TpastExtrasWin;

  maxEndDate:                   integer;
  Past: array of pastAbsenceRec;

procedure pastExtrasWinprint;
procedure pastExtrasWinOut;
procedure ReadPastExtras;
procedure WritePastExtras;

implementation

uses
  tcommon, tcommon2, tcommon3, printers, vwptextr, main, uAMGCommon(*,pexwtdlg*);

{$R *.DFM}


const
 nmbrPastAbsencesInBuffer=10000;

type TPrintPastWin=class(TPrintDrawWin)
  private
   procedure ImplementPrint;
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

type TOutPastWin=class(TOutPutWin)
  private
   procedure ImplementPrint;
  public
   procedure head; override;
 end;


var
 PrintPastWin:  TPrintPastWin;
 OutPastWin:    TOutPastWin;
 free2,InUse:         array[0..nmbrteachers] of integer;
 free3,InUse2:   array[0..nmbrSubjects] of integer;
 num,MyTecount:           integer;
 abcodenum:             smallint;
 ETprint: bool;
 daytotal: double;
// codecount2: array[0..nmbrreasons] of double;

procedure ReadPastExtras;
var
 abFile:  file;
 astr:    string;
 i,maxUse:       integer;
 temp:      smallint;
 datecheck: integer;
 tmpRec:      pastAbsenceRec;
begin
 NeedPastExtrasINITflag:=false; {set to true by dlg on date change}
 maxUse:=nmbrPastAbsencesInBuffer;
 enddate:=100*PEmonth2+PEday2;  startdate:=100*PEmonth1+PEday1;
 chdir(Directories.datadir);
 numabsences:=0;
 try
  SetLength(astr,4);
   doAssignFile(abFile,'ABSENT.DAT');
   try
    try
     filemode:=fmOpenRead+fmShareDenyNone;
     reset(abFile,1);
     blockread(abfile,astr[1],4);
     blockread(abfile,AbsentTotal,2);
     if AbsentTotal<maxUse then maxUse:=AbsentTotal;
     SetLength(Past,1+maxUse);
     firstday:=0; firstmonth:=0; lastday:=0; lastmonth:=0;
     if AbsentTotal=0 then exit;
     screen.cursor:=crHourglass;
     maxEndDate:=0;
     for i:=1 to AbsentTotal do
     begin
      seek(abfile,longint(i)*sizeof(tmpRec));
      if numabsences>=maxUse then break;
      blockread(abfile,tmpRec,sizeof(tmprec));
      IntRange(tmpRec.Aoldte,0,nmbrTeachers);
      IntRange(tmpRec.Anewte,0,nmbrTeachers);
      if (tmpRec.Agen<>4) and (tmpRec.Agen<>7) then
        begin temp:=tmpRec.Atimeslot;
         IntRange(temp,1,nmbrperiods);
         tmpRec.Atimeslot:=temp;
        end;
      IntRange(tmpRec.Asub,0,nmbrsubjects);
      IntRange(tmpRec.amonth,1,12);
      IntRange(tmpRec.aday,1,31);
      IntRange(tmpRec.attday,0,days-1);
      IntRange(tmpRec.aReason,0,nmbrReasons);
      datecheck:=100*tmpRec.amonth+tmpRec.aday;
      if (datecheck>=startdate) and (datecheck<=enddate) then
      begin
       inc(numabsences);
       Past[numabsences]:=tmpRec;
       if datecheck>maxEndDate then maxEndDate:=datecheck;
      end;

     end; {for i}
     seek(abfile,1*sizeof(tmpRec));
     blockread(abfile,firstday,2);
     blockread(abfile,firstmonth,2);
     if numabsences>0 then
      begin
       lastday:=Past[numabsences].aday;
       lastmonth:=Past[numabsences].amonth;
      end;
    finally
     closefile(abFile);
    end;
   except
   end;
 finally
   screen.cursor:=crDefault;
 end;
end;

procedure WritePastExtras;
var
  abFile:  file;
  astr:    string;
  i,maxUse:       integer;
  temp:      smallint;
  datecheck: integer;
  tmpRec:      pastAbsenceRec;
  lIgnore: Boolean;
  IgnoreCount: Integer;
begin
  NeedPastExtrasINITflag:=false; {set to true by dlg on date change}
  maxUse:=nmbrPastAbsencesInBuffer;
  enddate:=100*PEmonth2+PEday2;  startdate:=100*PEmonth1+PEday1;
  chdir(Directories.datadir);

  IgnoreCount := 0;
  SetLength(astr,4);
  doAssignFile(abFile,'ABSENT.DAT');
  try
    try
     FileMode := fmOpenReadWrite + fmShareDenyWrite;
     Rewrite(abFile, 1);
     if AbsentTotal<maxUse then maxUse:=AbsentTotal;
     SetLength(Past, 1 + maxUse);
     for i:=1 to AbsentTotal do
     begin
       tmpRec := Past[i];     //numabsences
       lIgnore := False;
       if (tmpRec.aDay = 1) and (tmpRec.aMonth = 5) and (tmpRec.aNewTe = 17) and (tmpRec.aTimeSlot = 6) then
         tmpRec.aDay := 23
       else if (tmpRec.aDay = 1) and (tmpRec.aMonth = 5) and (tmpRec.aNewTe = 17) and ((tmpRec.aTimeSlot = 10) or (tmpRec.aTimeSlot = 9)) then
         lIgnore := True;

       if not lIgnore then
       begin
         Seek(abfile,longint(i) * sizeof(tmpRec));
         //if numabsences >= maxUse then break;
         if numabsences>0 then
         begin
           lastday := Past[i].aday;
          lastmonth := Past[i].amonth;
         end;

         BlockWrite(abfile, tmpRec, sizeof(tmprec));
         if (tmpRec.Agen <> 4) and (tmpRec.Agen <> 7) then
         begin temp := tmpRec.Atimeslot;
           IntRange(temp, 1, nmbrperiods);
           tmpRec.Atimeslot := temp;
         end;
        {IntRange(tmpRec.Asub,0,nmbrsubjects);
        IntRange(tmpRec.amonth,1,12);
        IntRange(tmpRec.aday,1,31);
        IntRange(tmpRec.attday,0,days-1);
        IntRange(tmpRec.aReason,0,nmbrReasons);
        datecheck:=100*tmpRec.amonth+tmpRec.aday;
        if (datecheck>=startdate) and (datecheck<=enddate) then
        begin
         inc(numabsences);
         //Past[numabsences]:=tmpRec;
         datecheck>maxEndDate then maxEndDate:=datecheck;
        end;}
         if datecheck>maxEndDate then maxEndDate := datecheck;
       end
       else
         Inc(IgnoreCount);
     end; {for i}
     Seek(abfile,1*sizeof(tmpRec));
     BlockWrite(abfile, firstday,2);
     BlockWrite(abfile, firstmonth,2);
     AbsentTotal := AbsentTotal - IgnoreCount;
     Seek(abfile, 0);
     astr := 'TCE5';
     BlockWrite(abFile, aStr[1],4);
     BlockWrite(abFile, AbsentTotal, 2);
    finally
      CloseFile(abFile);
    end;
   except
   end;
end;


function PastKind(i,anewte: integer): string;
begin
 result:='';
 case i of
  1: if anewte>0 then result:='Add';
  2: result:='Replace';
  3: result:='In Lieu';
  4: result:='Extra';
  5: result:='Share';
  6: result:='Swap';
 end; {case}
end;

function ChangeGen(agen,aoldte: integer): string;
var
 astr: string;
begin
 astr:='';
 case agen of
  0: astr:='Room change';
  1: astr:=tecode[aoldte,0]+' absent';
  2: astr:='New class';
  3: astr:='Merged class';
  5,6: astr:='Conseq. change';
 end; {case}
 result:=astr;
end;


function LostMap(atimeslot,attday:integer):string;
var
 astr: string;
 p1,a: integer;
begin
 astr:='';
 for p1:=1 to periods do
  begin
   if not(TsOn[attday,p1-1]) then continue;
   a:=atimeslot and (1 shl p1);
   if a=0 then astr:=astr+tslotcode[p1,attday]
     else astr:=astr+'-';
  end; {for p1}
 result:=astr;
end;

function CoverKind(agen,akind,atimeslot,attday: integer):string;
var
 astr: string;
begin
 astr:='';
 if agen=7 then astr:=' '+LostMap(atimeslot,attday)+'(L) '
 else
  begin
   case akind of
    2: astr:='(R) ';
    3: astr:='(I) ';
    4: astr:='(C) ';
    5: astr:='(T) ';
    6: astr:='(S) ';
   end; {case}
   astr:=' '+TimeSlotName[attDay,atimeslot-1]+astr;
  end;
 result:=astr;
end;


procedure clearFree;
var
 v: integer;
begin
 for v:=0 to nmbrteachers do free2[v]:=0;
 for v := 0 to nmbrSubjects do free3[v] := 0;
end;

procedure selectSub;
var i,kk:integer;
begin
 kk:=winView[wnPastExtras];
 if kk = 6 then
   for i:=1 to winpastextrasSelectionCount[kk] do
     free3[i]:=winpastextrasSelection[kk,i]
 else
   for i:=1 to winpastextrasSelectionCount[kk] do
     free2[i]:=winpastextrasSelection[kk,i];

 num:=winpastextrasSelectionCount[kk];
end;

procedure allWeekly;
var
 i,kk: integer;
begin
 kk:=winView[wnPastExtras];
 if kk = 6 then
 begin
   for i:=1 to codenum[0] do
     free3[i]:=codepoint[i,0];
   num:=codenum[0];
 end
 else
 begin
   for i:=1 to codenum[1] do
     free2[i]:=codepoint[i,1];
   num:=codenum[1];
 end;

end;

procedure allFaculty;
var
 i,j5: integer;
begin
 for i:=1 to codenum[1] do
  begin
   j5:=codepoint[i,1];
   if TeachInAnyFac(j5,winpastextrasCode) then
    begin
     inc(num); free2[num]:=j5;
    end;
  end; {for i}
end;



procedure weeklyInsub;
begin
 num:=0; clearFree;
 case winpastextrasBrief2 of
  1: allweekly;
  2: selectSub;
  3: allfaculty;
 end;
end;

procedure ETweeklyInsub;

    procedure allWeekly;
    var
     i: integer;
    begin
     for i:=1 to etnum1 do
      free2[i]:=Etpointer[i];
     num:=etnum1;
    end;

    procedure selectSub;
    var i,kk:integer;
    begin
     kk:=winView[wnPastExtras];
     if kk = 6 then
       for i:=1 to winpastExtrasSelectionCount[kk] do
         free3[i]:=winpastExtrasSelection[kk,i]
     else
       for i:=1 to winpastExtrasSelectionCount[kk] do
         free2[i]:=winpastExtrasSelection[kk,i];
     num:=winpastExtrasSelectionCount[kk];
    end;

begin
 num:=0; clearFree;
 case winpastExtrasBrief2 of
  1: allweekly;
  2: selectSub;
 end;
end;


procedure TpastExtrasWin.SetTabs;
var
 i,j,lcount,yy:   integer;
 found:  boolean;
 itemcount,abcount: integer;
 fwTeach,fwAbCode: integer;
 start,finish,datecheck: integer;
 aday,amonth,ayear,agen: integer;
 tmax:  integer;
 teSelect:  tpTeData;
begin
 SetLength(Tabs,11);
 enddate:=100*PEmonth2+PEday2;  startdate:=100*PEmonth1+PEday1;
 if NeedPastExtrasINITflag then ReadPastExtras;
 lcount:=0; itemcount:=0;MyTecount:=0;abcount:=0;
 for i:=0 to nmbrTeachers do  begin InUse[i]:=0; teSelect[i]:=0; end;
 fwTeach:=fwcodename[1];
 if fwAddedStaffname>fwTeach then fwTeach:=fwAddedStaffname;
 fwAbCode:=canvas.textwidth('Oth');
 for i:=1 to nmbrreasonsinuse do
  begin
   j:=canvas.textwidth(Abcode[i]);
   if j>fwAbCode then fwAbCode:=j;
  end;
 case winView[wnPastExtras] of
  0: begin {year Extras}
      MaxTab(1,fwyearname,YearTitle);
      MaxTab(2,0,'99 WWW');
      MaxTab(3,fwperiodname,'Time');
      MaxTab(4,fwcode[0],'Subject');
      MaxTab(5,fwTeach,'Replacement Teacher');
      Tabs[6]:=Tabs[5]+fwabsence+blankwidth;
      maxW:=Tabs[6];
      if winpastExtrasyear=-1 then
        begin start:=years_minus_1; finish:=0; end
       else
        begin start:=winpastExtrasyear; finish:=winpastExtrasyear; end;
      if numabsences>0 then
       begin
        lcount:=2;
        for yy:=start downto finish do
        begin
         found:=false;
         for i:=1 to numabsences do
         begin
          aday:=Past[i].aday; amonth:=Past[i].amonth; ayear:=Past[i].ayear;
          agen:=Past[i].agen;
          if (agen=4) or (agen=7) or (ayear<>yy)
            or (aday<1) or (aday>31) or (amonth<1) or (amonth>12) then continue;
          datecheck:=100*amonth+aday;
          if (datecheck<startdate) or (datecheck>enddate) then continue;
          found:=true; inc(lcount);
         end; {for i}
         if not(found) then inc(lcount);
         inc(lcount);
        end; {for yy}
       end;
     end;
  1: begin {absent Teacher Extras}
      MaxTab(1,fwcodename[1],'Absent Teacher');
      MaxTab(2,0,'99 WWW');
      MaxTab(3,periods*letterW,'Times');
      MaxTab(4,0,'Reason  ');
      MaxTab(5,fwTeach+blankwidth+fwperiodname,'Replacement Teacher');
      Tabs[6]:=Tabs[5];
      MaxTab(5,fwTeach,'');
      MaxTab(7,0,'In Lieu  ');
      WeeklyInsub;
      if num>0 then for i:=1 to num do teSelect[free2[i]]:=-1;
      Tabs[9]:=canvas.textwidth('W.W')+blankwidth;
      for i:=1 to numabsences do
       begin
        datecheck:=100*Past[i].amonth+Past[i].aday;
        if (datecheck<startdate) or (datecheck>enddate)
                or (teSelect[Past[i].aoldte]=0) then continue;
        if ((Past[i].agen=1) and (Past[i].anewte>0)) then inc(itemcount);
        if (Past[i].agen=4) then
              begin inc(abcount); inc(InUse[Past[i].aoldte]); end;
       end;
      for i:=1 to num do if InUse[free2[i]]>0 then inc(MyTecount);
      lcount:=4;
      case pedetail of
       1: begin
           maxW:=Tabs[7];
           lcount:=4+itemcount+abcount+MyTecount*2;
          end;
       2: begin
           MaxTab(4,fwabsence,'Reason  ');
           maxW:=Tabs[4];
           lcount:=4+abcount+2*MyTecount;
          end;
       3: begin
           maxW:=Tabs[7];
           Tabs[8]:=canvas.textwidth('Oth:88/12  ');
           j:= (Tabs[7]-Tabs[1]) div Tabs[8]; if j<1 then j:=1;
           for i:=1 to num do if InUse[free2[i]]>0 then inc(lcount,3+((InUse[free2[i]]-1) div j));
          end;
       4: begin
           maxW:=Tabs[1]+((abcodenum+1)*Tabs[9])+canvas.textwidth('Total')+blankwidth;
           lcount:=5+MyTecount;
          end;
       end; {case}
     end;
  2,3: begin {coveringteacherExtras}
      etprint:=(winView[wnPastExtras]=3);
      MaxTab(1,fwTeach,'Cover');
      MaxTab(2,0,'WW WWW');
      MaxTab(3,fwperiodname,'Time');
      MaxTab(4,fwcode[0],'Subject');
      MaxTab(5,fwyearname,YearTitle);
      i:=fwcode[0]+canvas.textwidth(' absent');
      j:=canvas.textwidth('Conseq. change');
      if j>i then i:=j;
      MaxTab(6,i,'Reason');
      MaxTab(7,fwabsence,'In Lieu ');
      if ETprint then tmax:=ETnum else tmax:=numcodes[1];
      if ETprint then ETweeklyinsub else weeklyinsub;
      if num>0 then for i:=1 to num do teSelect[free2[i]]:=-1;
      for i:=1 to numabsences do
       begin
        datecheck:=100*Past[i].amonth+Past[i].aday;
        if (datecheck<startdate) or (datecheck>enddate)
                or (teSelect[Past[i].anewte]=0) then continue;
        if (ETprint xor (Past[i].akind=1)) then continue;
        if (Past[i].agen=4) or (Past[i].agen=7) then continue;
        if not(ETprint) then
        if (not(TsOn[Past[i].attday,(Past[i].atimeslot)-1])) or ((pecover=2) and (Past[i].akind<>4))
            or ((pecover=3) and (Past[i].akind<>2))
            or ((pecover=4) and (Past[i].akind<>3)) then continue;
        if ETprint then
          if (not(TsOn[Past[i].attday,(Past[i].atimeslot)-1])) then continue;

        if ((Past[i].anewte>0) and (Past[i].anewte<=tmax)) then
           begin inc(itemcount); inc(InUse[Past[i].anewte]); end;
       end;
      for i:=1 to num do if InUse[free2[i]]>0 then inc(MyTecount);
      lcount:=4;
      Tabs[9]:=canvas.textwidth('W.W')+blankwidth;
      case pedetail of
       1: begin
           maxW:=Tabs[7];
           lcount:=4+itemcount+MyTecount*2;
          end;
       2,3: begin
           maxW:=Tabs[7];
           if pedetail=2 then
            begin
             Tabs[8]:=fwAbCode+fwperiodname+canvas.textwidth(':88/12 (C) ');
             j:=canvas.textwidth(':88/12 (L) ')+periods*LetterW;
             if j>Tabs[8] then Tabs[8]:=j;
            end
           else Tabs[8]:=fwAbCode+canvas.textwidth(':88/12 ');
           j:= (Tabs[7]-Tabs[1]) div Tabs[8]; if j<1 then j:=1;
           for i:=1 to num do if InUse[free2[i]]>0 then inc(lcount,3+((InUse[free2[i]]-1) div j));
          end;
       4: begin
           maxW:=Tabs[1]+((abcodenum+1)*Tabs[9])+canvas.textwidth('Total')+blankwidth;
           lcount:=5+MyTecount;
          end;
       end; {case}
     end;
  4: begin {Lost Class Teacher Extras}
      MaxTab(1,fwcodename[1],'Lost Teacher');
      MaxTab(2,0,'99 WWW');
      MaxTab(3,periods*letterW,'Times');
      WeeklyInsub;
      if num>0 then for i:=1 to num do teSelect[free2[i]]:=-1;
      for i:=1 to numabsences do
       begin
        datecheck:=100*Past[i].amonth+Past[i].aday;
        if (datecheck<startdate) or (datecheck>enddate)
                or (teSelect[Past[i].aoldte]=0) then continue;
        if (Past[i].agen=7) then
              begin inc(abcount); inc(InUse[Past[i].aoldte]); end;
       end;
      for i:=1 to num do if InUse[free2[i]]>0 then inc(MyTecount);
      maxW:=Tabs[3];
      lcount:=4+abcount+2*MyTecount;
     end;
  5: begin {summary extras}
      MaxTab(1,0,'WWW'); {indent 3 chars}
      MaxTab(2,0,'WW WWW');
      MaxTab(3,0,'In Lieu ');
      i:=periods*letterW; if fwperiodname>i then i:=fwperiodname;
      MaxTab(4,i,'Time');
      MaxTab(5,fwcode[0],'Subject');
      MaxTab(6,fwyearname,YearTitle);
      i:=fwcode[1]+canvas.textwidth(' absent');
      j:=canvas.textwidth('Conseq. change');
      if j>i then i:=j;
      if fwabsence>i then i:=fwabsence;
      MaxTab(7,i,'Reason'); MaxW:=Tabs[7];
      WeeklyInsub;
      if num>0 then for i:=1 to num do teSelect[free2[i]]:=-1;
      for i:=1 to numabsences do
       begin
        datecheck:=100*Past[i].amonth+Past[i].aday;
        if (datecheck<startdate) or (datecheck>enddate)
                or (teSelect[Past[i].aoldte]=0) then continue;
        if (Past[i].agen=7) or (Past[i].agen=4)then
              begin inc(itemcount); inc(InUse[Past[i].aoldte]); continue end;
        if ((Past[i].anewte>0) and (Past[i].anewte<=numcodes[1])) then
           begin inc(itemcount); inc(InUse[Past[i].anewte]); end;

       end;
      for i:=1 to num do if InUse[free2[i]]>0 then inc(MyTecount);
      lcount:=4+itemcount+MyTecount*5;
     end;
  6: begin {subjects}
      MaxTab(1,fwyearname,YearTitle);
      MaxTab(2,0,'99 WWW');
      MaxTab(3,fwperiodname,'Time');
      MaxTab(4,fwcode[0],'Subject');
      MaxTab(5,fwTeach,'Replacement Teacher');
      Tabs[6]:=Tabs[5]+fwabsence+blankwidth;
      maxW:=Tabs[6];
      WeeklyInsub;
      if winpastExtrasyear=-1 then
        begin start:=years_minus_1; finish:=0; end
       else
        begin start:=winpastExtrasyear; finish:=winpastExtrasyear; end;
      if numabsences>0 then
       begin
        lcount:=2;
        for yy:=start downto finish do
        begin
         found:=false;
         for i:=1 to numabsences do
         begin
          aday:=Past[i].aday; amonth:=Past[i].amonth; ayear:=Past[i].ayear;
          agen:=Past[i].agen;
          if (agen=4) or (agen=7) or (ayear<>yy)
            or (aday<1) or (aday>31) or (amonth<1) or (amonth>12) then continue;
          datecheck:=100*amonth+aday;
          if (datecheck<startdate) or (datecheck>enddate) then continue;
          found:=true; inc(lcount);
         end; {for i}
         if not(found) then inc(lcount);
         inc(lcount);
        end; {for yy}
       end;
     end;
 end; {case}
 inc(maxW,hmargin+blankwidth);
 inc(lcount,3);
 maxH:=lcount*txtheight;
end;


procedure TpastExtrasWin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TpastExtrasWin.Change2Click(Sender: TObject);
begin
 ViewPastExtrasDlg:=TViewPastExtrasDlg.create(self);   {allocate dlg}
 ViewPastExtrasDlg.showmodal;
 ViewPastExtrasDlg.free;
 if NeedPastExtrasINITflag then UpdateWin;
end;

procedure TpastExtrasWin.FormCreate(Sender: TObject);
var
 i: integer;
begin
 setWindowDefaults(self,wnPastExtras);
 abcodenum:=0;
 for i:=1 to nmbrreasons do
  if ((Trim(Absent[i])>'') or (Trim(Abcode[i])>'')) then inc(abcodenum);
 ReadPastExtras;
end;

procedure TpastExtrasWin.FormPaint(Sender: TObject);
var
 codecount2: array[0..nmbrreasons] of double;
 etreason,count,te,a:          integer;
 found:   boolean;
 temp: double;
 atimeslot: longword;
 aday,amonth,ayear,asub,aoldte,anewte,akind,areason,agen,attday: integer;
 old_day,old_month,datecheck: integer;
 daycount,daycount1,myallot,lostAllot: double;
 lostcount: integer;

  procedure GetPastRecord(i:integer);
  begin
   aday:=Past[i].aday;   amonth:=Past[i].amonth;
   atimeslot:=Past[i].atimeslot;
   ayear:=Past[i].ayear; asub:=Past[i].asub;
   aoldte:=Past[i].aoldte;  anewte:=Past[i].anewte;
   akind:=Past[i].akind;    areason:=Past[i].areason;
   agen:=Past[i].agen;  attday:=Past[i].attday;
   datecheck:=100*amonth+aday;
  end;

  procedure print2(a,b:string);
  begin
    fcolor(cpNormal);
    printwl(a);
    fcolor(codeColor);
    printwl(b);
  end;

procedure absentTeacherExtras;
var
  tmpstr: string;
  i, j, p1, count: Integer;
begin
 Self.Caption := 'Past Extras - by Absent Teachers';
 fcolor(cpNormal);
 count:=0;
 printw('Past Extras by Absent Teacher'); newline;
 if num=0 then
 begin
  printw('No past extras selected.');
  exit;
 end;
 printw('Absent teachers from '+inttostr(peday1)+' '+month[pemonth1]+
 ' to '+inttostr(peday2)+' '+month[pemonth2]); newline;
{ headings}
 printw('Absent');  x:=Tabs[1];
 if pedetail<3 then
  begin
   printw('Date');
   x:=Tabs[2]; printw('Times');
   x:=Tabs[3]; printw('Reason');
  end;
 case pedetail of
  1: begin
      x:=Tabs[4]; printw('Replacement Teacher');
      x:=Tabs[6]; printw('Status');
     end;
  3: printw('Reason and Date');
  4: begin
      printw('Reason Codes');
      newline;
      printw('Teacher');
      for j:=1 to abcodenum do
       begin
        x:=Tabs[1]+((j-1)*Tabs[9]); printw(Abcode[j]);
       end;
      x:=Tabs[1]+(abcodenum*Tabs[9]); printw('Other');
      x:=Tabs[1]+((abcodenum+1)*Tabs[9]); printw('Total');
     end;
 end; {case}
 newline;

 fcolor(codecolor);
 for j:=1 to num do
 begin
  te:=free2[j]; if InUse[te]=0 then continue;
  for i:=0 to nmbrreasons do codecount2[i]:=0;
  found:=false; daycount:=0; old_day:=0; old_month:=0;
  for i:=1 to numabsences do
  begin
   GetPastRecord(i);
   //Allow Merge to display #75
   if (agen<>1) and (agen<>4) and (agen<>3) then continue;
   if (agen=1) and ((pedetail<>1) or (anewte=0) or (TsOn[attday,atimeslot-1]=false) ) then continue;
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   if aoldte<>te then continue;  // Check that we are looking for current teacher records

   if not(found) then
   begin
    printwl(tename[aoldte,0]); found:=true; x:=Tabs[1];
   end;

   // Absent Teacher
   if (agen=1) and (anewte>0) and (TsOn[attday,atimeslot-1]) and (pedetail=1) then
   begin
    x:=Tabs[4];
    if akind=1 then printwl(ETname[anewte]) else printwl(tename[anewte,0]);
    x:=Tabs[5]; printwl(TimeSlotName[attDay,atimeslot-1]);
    x:=Tabs[6]; printwl(PastKind(akind,anewte)); printwl(' ');
    newline; continue;
   end;


  // #75 allow merge 
  // Merge
  if (agen=3) and (TsOn[attday,atimeslot-1]) and (pedetail=1) then begin
    x:=Tabs[4];
    if akind=1 then printwl(ETname[anewte]) else printwl(tename[anewte,0]);
    x:=Tabs[5]; printwl(TimeSlotName[attDay,atimeslot-1]);
    x:=Tabs[6]; printwl(PastKind(akind,anewte)); printwl(' ');
    newline; continue;
  end;

  // Absent Teacher Map
  if agen=4 then
   begin
    daycount1:=0; daytotal:=0;
    for p1:=1 to periods do
     begin
      if not(TsOn[attday,p1-1]) then continue;
      myallot:=getEallot(2,te,attday,p1);
      a:=atimeslot and (1 shl p1);
      if a=0 then daycount1:=daycount1+myallot;
      daytotal:=daytotal+myallot;
     end; {for p1}
    temp:=0;
    if daycount1>0 then temp:=0.5;
    if daycount1>(daytotal/2) then temp:=1.0;
    daycount:=daycount+temp;
    codecount2[areason]:=codecount2[areason]+temp;
    case pedetail of
       1,2: begin
             x := Tabs[1];
             //if (old_day<>aday) or (old_month<>amonth) then
               printwl(inttostr(aday)+' '+month[amonth]);
             x:=Tabs[2];
             for p1:=1 to periods do
              begin
               if not(TsOn[attday,p1-1]) then continue;
               a:=atimeslot and (1 shl p1);
               if a=0 then
                begin printw(tslotcode[p1,attday]); inc(x,letterW); end
                else begin printw('-'); inc(x,letterW); end;
              end; {for p1}
             x:=Tabs[3];  printwl(Abcode[areason]+' '+Absent[areason]);
             newline;
            end;
       3: begin
           if x>(Tabs[7]-Tabs[8]) then begin newline; x:=Tabs[1]; end;
           printw(Abcode[areason]+':'+inttostr(aday)+'/'+inttostr(amonth));
           inc(x,Tabs[8]);
          end;
    end; {case}
   end; {if agen=4}
  end; {for i }
  if found then
  begin
   inc(count);
   if pedetail<4 then
   begin
    if x>0 then newline;
    fcolor(cpNormal);
    str(daycount:3:1,tmpstr); printwl('Days absent: '+tmpstr); newline; newline;
    drawmyline(0,y-(txtheight div 2),MaxW,y-(txtheight div 2));
    fcolor(codecolor);
   end;
   if (pedetail=4) then
   begin
    for i:=1 to abcodenum do
    begin
     x:=Tabs[1]+((i-1)*Tabs[9]);
     if codecount2[i]>0 then fcolor(cpCurrent)
      else fcolor(codecolor);
     str(codecount2[i]:3:1,tmpstr);
     printwl(tmpstr+' ');
    end; {for i}

    str(codecount2[0]:3:1,tmpstr);
    x:=Tabs[1]+(abcodenum*Tabs[9]);
    if codecount2[0]>0 then fcolor(cpCurrent)
     else fcolor(codecolor);
    printwl(tmpstr+' ');
    str(daycount:3:1,tmpstr);
    x:=Tabs[1]+((abcodenum+1)*Tabs[9]);
    if daycount>0 then fcolor(cpCurrent) else fcolor(codecolor);
    printwl(tmpstr+' ');  newline;
    fcolor(codecolor);
   end;
  end;
 end; {for j}
 newline; fcolor(cpNormal);
 printwl('Absent teachers shown: '+inttostr(count)); newline;
end;

procedure coveringTeacherExtras;
var
 i,j,i2,p1:  integer;
 tmpstr: string;
 tmax,old_reason: integer;
 excount,recount,incount,etcount,totalcount: double;
begin
 fcolor(cpNormal);
 if ETprint then
 begin
   Self.Caption := 'Past Extras - by Added Saff';
   printw('Classes for Added Teacher');
 end
 else
 begin
   Self.Caption := 'Past Extras - by Cover Teachers';
   printw('Changes by Covering Teacher');
 end;
 newline;
 if num=0 then
 begin
  printw('No past extras selected.');
  exit;
 end;
 if ETprint then printwl('Changes for added') else printwl('Changes for');
 printwl(' teachers from '+inttostr(peday1)+' '+month[pemonth1]+' to '
   +inttostr(peday2)+' '+month[pemonth2]);

 if not(ETprint) then printwl(' - cover type: '+covershow[pecover]);

 newline; count:=0;
 {headings}
 case pedetail of
  1: begin
      printw('Cover'); x:=Tabs[1];
      printw('Date'); x:=Tabs[2];
      printw('Time'); x:=Tabs[3];
      printw('Subject'); x:=Tabs[4];
      printw(Yeartitle); x:=Tabs[5];
      printw('Reason'); x:=Tabs[6];
      if not(ETprint) then printw('Status');
     end;
  2: begin
      printw('Cover'); x:=Tabs[1];
      printwl('Code:Date ');
      printwl('Time');
      printwl('(Kind)');
     end;
  3: begin
      printw('Cover'); x:=Tabs[1];
      printw('Code:Date');
     end;
  4: begin
      printw('Cover'); x:=Tabs[1];
      printw('Reason Codes'); newline;
      printw('Teacher');
      for i:=1 to abcodenum do
      begin
       x:=Tabs[1]+((i-1)*Tabs[9]);
       printw(Abcode[i]);
      end;
      x:=Tabs[1]+(abcodenum*Tabs[9]);
      printw('Other');
      x:=Tabs[1]+((abcodenum+1)*Tabs[9]);
      printw('Total');
     end;
 end; {case}

 newline;
 for j:=1 to num do
 begin
  te:=free2[j];  if InUse[te]=0 then continue;
  for i2:=0 to nmbrreasons do codecount2[i2]:=0;
  if ETprint then tmax:=ETnum else tmax:=numcodes[1];
  if (te<1) or (te>tmax) then continue;
  found:=false;old_day:=0;old_month:=0;excount:=0;recount:=0;incount:=0;
  ETreason:=0; ETcount:=0; old_reason:=0; totalcount:=0;
  for i:=1 to numabsences do
  begin
   GetPastRecord(i);
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   if anewte<>te then continue;
   if (ETprint xor (akind=1)) then continue;
   if (aGen=4) or (Agen=7) then continue;
   if not(ETprint) then
    if (not(TsOn[attday,atimeslot-1])) or ((pecover=2) and (akind<>4))
     or ((pecover=3) and (akind<>2)) or ((pecover=4) and (akind<>3)) then continue;
   if ETprint then
    if (not(TsOn[attday,atimeslot-1])) then continue;
   fcolor(codecolor);
   if not(found) then
   begin
    if etprint then printw(ETname[te]) else printw(tename[te,0]);
    x:=Tabs[1];
   end;

   found:=true;
   if (akind=4) and ((pecover=1) or (pecover=2)) then
    excount:=excount+getEallot(1,ayear,attday,atimeslot);
   if (akind=2) and ((pecover=1) or (pecover=3)) then
    recount:=recount+getEallot(1,ayear,attday,atimeslot);
   if (akind=3) and ((pecover=1) or (pecover=4)) then
    incount:=incount+getEallot(1,ayear,attday,atimeslot);

   etcount:=etcount+getEallot(1,ayear,attday,atimeslot);
   codecount2[areason]:=codecount2[areason]+getEallot(1,ayear,attday,atimeslot);
   totalcount:=totalcount+getEallot(1,ayear,attday,atimeslot);

   case pedetail of
    1: begin
        x:=Tabs[1];
        //if (old_day<>aday) or (old_month<>amonth) then
        begin
         printw(inttostr(aday)+' '+month[amonth]);
         old_day:=aday; old_month:=amonth; etreason:=0;
        end;
        x:=Tabs[2];
        printw(TimeSlotName[attDay,atimeslot-1]);
        x:=Tabs[3]; printw(SubCode[asub]);
        x:=Tabs[4]; printw(yearname[ayear]);
        x:=Tabs[5]; printw(ChangeGen(agen,aoldte));
        x:=Tabs[6];
        if etprint and (agen=1) and (etreason<>aoldte) then
        begin
         printwl(Abcode[areason]+' '+Absent[areason]+' ');
         etreason:=aoldte;
        end;
        if not(ETprint) then printwl(PastKind(akind,anewte));

        newline;
       end; {pedetail=1 }
    2,3: begin
          if (old_day<>aday) or (old_month<>amonth) or ((old_reason<>areason) and (agen=1)) then
           begin
            if x>(Tabs[7]-Tabs[8]) then begin newline; x:=Tabs[1]; end;
            if agen=1 then printwl(Abcode[areason]+':');
            printwl(inttostr(aday)+'/'+inttostr(amonth));
            old_day:=aday; old_month:=amonth; old_reason:=areason;
           end;
          if (pedetail=2) then printwl(CoverKind(agen,akind,atimeslot,attday));
          printwl(' '); {gap between them}
         end;
   end; {case}
  end; {for i}
  if found and (pedetail<4) then
  begin
   if (pedetail<>1) then newline;
   fcolor(cpNormal);
   if (etprint=false) then
   begin
    printwl('Time Allotment  ');
    if (pecover=1) or (pecover=2) then
    begin
     str(excount:4:1,tmpstr);
     printwl('  Extras:'+tmpstr);
    end;
    if (pecover=1) or (pecover=3) then
    begin
     str(recount:4:1,tmpstr);
     printwl('  Replacements:'+tmpstr);
    end;
    if (pecover=1) or (pecover=4) then
    begin
     str(incount:4:1,tmpstr);
     printwl('  In-lieus:'+tmpstr);
    end;

    newline;
   end
   else
    begin
     str(etcount:5:1,tmpstr);
     printw('Time Allotment '+tmpstr);
     newline;
    end;
   newline;
   {divider line here}
    drawmyline(0,y-(txtheight div 2),Tabs[7],y-(txtheight div 2));

  end;  {if found and (pedetail<4) then}
  if found and (pedetail=4) then
  begin
   fcolor(codecolor);
   for i:=1 to abcodenum do
   begin
    x:=Tabs[1]+((i-1)*Tabs[9]);
    if codecount2[i]>0 then fcolor(cpCurrent)
     else fcolor(codecolor);
    str(codecount2[i]:3:1,tmpstr);
    printw(tmpstr);
   end; {for i}

   x:=Tabs[1]+(abcodenum*Tabs[9]);
   str(codecount2[0]:3:1,tmpstr);
   if codecount2[0]>0 then fcolor(cpCurrent)
    else fcolor(codecolor);
   printw(tmpstr);
   x:=Tabs[1]+((abcodenum+1)*Tabs[9]);
   str(totalcount:3:1,tmpstr);
   if totalcount>0 then fcolor(cpCurrent)
    else fcolor(codecolor);
   printw(tmpstr);
   newline;
   fcolor(codecolor);
  end;
 end; {for j}
end;

procedure yearExtras;
var
 i,yy,start,finish: integer;
begin
 Self.Caption := 'Past Extras - by Year';
 if numabsences=0 then
 begin
  printw('No past extras selected.');
  exit;
 end;
 if winpastExtrasyear=-1 then
  begin start:=years_minus_1; finish:=0; end
 else
   begin start:=winpastExtrasyear; finish:=winpastExtrasyear; end;
 count:=0;   fcolor(cpNormal);
 printw('Changes from '+inttostr(PEday1)+' '+month[pemonth1]+' to '+
   inttostr(peday2)+' '+month[pemonth2]);
 newline;

 printw(yeartitle); x:=Tabs[1];
 printw('Date'); x:=Tabs[2];
 printw('Time'); x:=Tabs[3];
 printw('Subject'); x:=Tabs[4];
 printw('Replacement Teacher'); x:=Tabs[5];
 printw('Reason');  newline;

 drawmyline(0,y+(txtheight div 2),Tabs[6],y+(txtheight div 2));
 newline;
 for yy:=start downto finish do
 begin
  fcolor(codecolor);
  printw(yearname[yy]); count:=0;
  found:=false; old_day:=0; old_month:=0;
  for i:=1 to numabsences do
  begin
   GetPastRecord(i);
   if (agen=4) or (agen=7) or (ayear<>yy) or
        (aday<1) or (aday>31) or (amonth<1) or (amonth>12) then continue;
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   found:=true;  x:=Tabs[1];
   //if (old_day<>aday) or (old_month<>amonth) then
   begin printw(inttostr(aday)+' '+month[amonth]); old_month:=amonth; old_day:=aday; end;
   x:=Tabs[2]; printw(TimeSlotName[attDay,atimeslot-1]);
   x:=Tabs[3]; printw(SubCode[asub]); x:=Tabs[4];
   if (akind=1) then printw(ETname[Anewte]) else printw(tename[Anewte,0]);
   x:=Tabs[5]; printw(ChangeGen(agen,aoldte));
   newline;
  end; {for i}
  if not(found) then
  begin
   x:=Tabs[2];
   printw('(no changes)'); newline;
  end;
  fcolor(cpNormal);
  drawmyline(0,y+(txtheight div 2),Tabs[6],y+(txtheight div 2));
  newline;
 end; {for yy}
end;

procedure lostTeacherExtras;
var
 tmpstr: string;
 i,j,p1,count:          integer;
begin
 Self.Caption := 'Past Extras - by Lost Classes';

 fcolor(cpNormal);
 count:=0;
 printw('Past Extras by Teachers with Lost Classes'); newline;
 if num=0 then
 begin
  printw('No past extras selected.');
  exit;
 end;
 printw('Lost Class teachers from '+inttostr(peday1)+' '+month[pemonth1]+
 ' to '+inttostr(peday2)+' '+month[pemonth2]); newline;
{ headings}
 printw('Lost Teacher');  x:=Tabs[1];
 printw('Date');
 x:=Tabs[2]; printw('Times');
 newline;

 fcolor(codecolor);
 for j:=1 to num do
 begin
  te:=free2[j]; if InUse[te]=0 then continue;
  found:=false; Lostcount:=0;LostAllot:=0; old_day:=0; old_month:=0;
  for i:=1 to numabsences do
  begin
   GetPastRecord(i);
   if (agen<>7) then continue;
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   if aoldte<>te then continue;

   if not(found) then
   begin
    printwl(tename[aoldte,0]); found:=true; x:=Tabs[1];
   end;

  if agen=7 then
   begin
    for p1:=1 to periods do
     begin
      if not(TsOn[attday,p1-1]) then continue;
      myallot:=getEallot(2,te,attday,p1);
      a:=atimeslot and (1 shl p1);
      if a=0 then
       begin
        inc(lostcount); LostAllot:=LostAllot+myallot;
       end;
     end; {for p1}
    //if (old_day<>aday) or (old_month<>amonth) then
     printwl(inttostr(aday)+' '+month[amonth]);
    x:=Tabs[2];
    for p1:=1 to periods do
     begin
      if not(TsOn[attday,p1-1]) then continue;
      a:=atimeslot and (1 shl p1);
      if a=0 then
       begin printw(tslotcode[p1,attday]); inc(x,letterW); end
       else begin printw('-'); inc(x,letterW); end;
     end; {for p1}
    newline;
   end; {if agen=4}
  end; {for i }
  if found then
  begin
   inc(count);
   if x>0 then newline;
   fcolor(cpNormal);
   str(lostAllot:3:1,tmpstr);
   printwl('Lost classes: '+inttostr(lostcount)+'  Allot: '+tmpstr); newline; newline;
   drawmyline(0,y-(txtheight div 2),Tabs[3],y-(txtheight div 2));
   fcolor(codecolor);
  end;
 end; {for j}
 newline; fcolor(cpNormal);
 printwl('Lost Class teachers shown: '+inttostr(count)); newline;
end;

procedure SummaryExtras;
var
 tmpstr: string;
 i,j,p1,count:          integer;
 excount,recount,incount,totalcount: double;
begin
 Self.Caption := 'Past Extras Summary';
 fcolor(cpNormal);
 count:=0;
 printw('Past Extras Summary'); newline;
 if num=0 then
 begin
  printw('No past extras selected.');
  exit;
 end;

 fcolor(codecolor);
 for j:=1 to num do
 begin
  te:=free2[j]; if InUse[te]=0 then continue;
  printwl(tename[te,0]+' changes from '+inttostr(peday1)+' '+month[pemonth1]+
 ' to '+inttostr(peday2)+' '+month[pemonth2]); newline;
  x:=Tabs[1];  printw('Date'); x:=Tabs[2]; printw('Status');
  x:=Tabs[3];  printw('Time'); x:=Tabs[4]; printw('Details'); newline;

  for i:=0 to nmbrreasons do codecount2[i]:=0;
  found:=false; Lostcount:=0;LostAllot:=0; old_day:=0; old_month:=0;
  daycount:=0; excount:=0;recount:=0;incount:=0; totalcount:=0;
  for i:=1 to numabsences do
  begin
   GetPastRecord(i);
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   if ((agen=7) or (agen=4)) and (aoldte<>te) then continue;
   if (agen<>7) and (agen<>4) and ((anewte<>te) or (akind=1)) then continue;
   if (agen<>7) and (agen<>4) then if (not(TsOn[attday,atimeslot-1])) then continue;
   //if (old_day<>aday) or (old_month<>amonth) then
      begin
       x:=Tabs[1]; printwl(inttostr(aday)+' '+month[amonth]);
       old_day:=aday; old_month:=amonth;
      end;
   if (agen=7) and (aoldte=te) then
    begin
     found:=true;
     for p1:=1 to periods do
      begin
       if not(TsOn[attday,p1-1]) then continue;
       myallot:=getEallot(2,te,attday,p1);
       a:=atimeslot and (1 shl p1);
       if a=0 then
        begin
         inc(lostcount); LostAllot:=LostAllot+myallot;
        end;
      end; {for p1}
     x:=Tabs[2]; printw('Lost');
     x:=Tabs[3];
     for p1:=1 to periods do
      begin
       if not(TsOn[attday,p1-1]) then continue;
       a:=atimeslot and (1 shl p1);
       if a=0 then
        begin printw(tslotcode[p1,attday]); inc(x,letterW); end
       else begin printw('-'); inc(x,letterW); end;
      end; {for p1}
     newline;
    end; {if agen=7}

   if (agen=4) and (aoldte=te) then
    begin
     daycount1:=0; daytotal:=0; found:=true;
     for p1:=1 to periods do
      begin
       if not(TsOn[attday,p1-1]) then continue;
       myallot:=getEallot(2,te,attday,p1);
       a:=atimeslot and (1 shl p1);
       if a=0 then daycount1:=daycount1+myallot;
       daytotal:=daytotal+myallot;
      end; {for p1}
     temp:=0;
     if daycount1>0 then temp:=0.5;
     if daycount1>(daytotal/2) then temp:=1.0;
     daycount:=daycount+temp;
     x:=Tabs[2]; printw('Absent');
     x:=Tabs[3];
     for p1:=1 to periods do
      begin
       if not(TsOn[attday,p1-1]) then continue;
       a:=atimeslot and (1 shl p1);
       if a=0 then
        begin printw(tslotcode[p1,attday]); inc(x,letterW); end
       else begin printw('-'); inc(x,letterW); end;
      end; {for p1}
     x:=Tabs[4];  printwl(Abcode[areason]+' '+Absent[areason]);
     newline;
    end; {if agen=4}

   if (agen<>7) and (agen<>4) and (anewte=te) and (akind<>1) then
    begin
     x:=Tabs[2];  printw(PastKind(akind,anewte));
     x:=Tabs[3];  printw(TimeSlotName[attDay,atimeslot-1]);
     x:=Tabs[4];  printw(SubCode[asub]);
     x:=Tabs[5];  printw(yearname[ayear]);
     x:=Tabs[6];  printw(ChangeGen(agen,aoldte));
     newline;  found:=true;
     myallot:=getEallot(1,ayear,attday,atimeslot);
     if (akind=4) then excount:=excount+myallot;
     if (akind=2) then recount:=recount+myallot;
     if (akind=3) then incount:=incount+myallot;
     totalcount:=totalcount+myallot;
    end;

  end; {for i }
  if found then
  begin
   inc(count);
   fcolor(cpNormal);
   str(daycount:3:1,tmpstr); printwl('Days absent: '+tmpstr);
   str(lostAllot:3:1,tmpstr);
   printwl('  Lost classes: '+inttostr(lostcount)+'  Allot: '+tmpstr); newline;
   printwl('Time Allotment  ');
   str(excount:4:1,tmpstr); printwl('  Extras:'+tmpstr);
   str(recount:4:1,tmpstr); printwl('  Replacements:'+tmpstr);
   str(incount:4:1,tmpstr); printwl('  In-lieus:'+tmpstr);
   newline; newline;
   drawmyline(0,y-(txtheight div 2),Tabs[7],y-(txtheight div 2));
   fcolor(codecolor);
  end;
 end; {for j}
 newline; fcolor(cpNormal);
 printwl('Teachers shown: '+inttostr(count)); newline;
end;

procedure subjectExtras;
var
 i,j,yy,start,finish: integer;
 subSel: integer;
begin
 Self.Caption := 'Past Extras - by Subject';
 if numabsences=0 then
 begin
  printw('No past extras selected.');
  exit;
 end;
 if winpastExtrasyear=-1 then
  begin start:=years_minus_1; finish:=0; end
 else
   begin start:=winpastExtrasyear; finish:=winpastExtrasyear; end;
 count:=0;   fcolor(cpNormal);
 printw('Changes to subjects from '+inttostr(PEday1)+' '+month[pemonth1]+' to '+
   inttostr(peday2)+' '+month[pemonth2]);
 newline;

 printw(yeartitle); x:=Tabs[1];
 printw('Date'); x:=Tabs[2];
 printw('Time'); x:=Tabs[3];
 printw('Subject'); x:=Tabs[4];
 printw('Replacement Teacher'); x:=Tabs[5];
 printw('Reason');  newline;

 drawmyline(0,y+(txtheight div 2),Tabs[6],y+(txtheight div 2));
 newline;
 for yy:=start downto finish do
 begin
  fcolor(codecolor);
  printw(yearname[yy]); count:=0;
  found:=false; old_day:=0; old_month:=0;
  for j := 1 to num do
  begin
    subSel := free3[j];
    for i:=1 to numabsences do
    begin
     GetPastRecord(i);
     if (agen=4) or (agen=7) or (ayear<>yy) or
          (aday<1) or (aday>31) or (amonth<1) or (amonth>12) then continue;
     if (datecheck<startdate) or (datecheck>enddate) then continue;
     if asub<>subSel then continue;

     found:=true;  x:=Tabs[1];
     //if (old_day<>aday) or (old_month<>amonth) then
     begin printw(inttostr(aday)+' '+month[amonth]); old_month:=amonth; old_day:=aday; end;
     x:=Tabs[2]; printw(TimeSlotName[attDay,atimeslot-1]);
     x:=Tabs[3]; printw(SubCode[asub]); x:=Tabs[4];
     if (akind=1) then printw(ETname[Anewte]) else printw(tename[Anewte,0]);
     x:=Tabs[5]; printw(ChangeGen(agen,aoldte));
     newline;
    end; {for i}
  end; {for j}
  if not(found) then
  begin
   x:=Tabs[2];
   printw('(no changes)'); newline;
  end;
  fcolor(cpNormal);
  drawmyline(0,y+(txtheight div 2),Tabs[6],y+(txtheight div 2));
  newline;
 end; {for yy}
end;

begin
 if NeedPastExtrasINITflag then ReadPastExtras;
 codeColor:=cpClass;
 case winView[wnPastExtras] of
  0: yearExtras;
  1: absentTeacherExtras;
  2,3: coveringteacherExtras;
  4: lostTeacherExtras;
  5: SummaryExtras;
  6: subjectExtras;
 end; {case}
end;

procedure TpastExtrasWin.ModifyData(Sender: TObject);
begin
  WritePastExtras;
end;

{--------------------}
{                     print procs follow -------------------}
{------------------------}

procedure TPrintPastWin.SetTabs;
var
 i,j,fwTeach,fwAbCode:   integer;
begin
 SetLength(PrntTabs,11);
 fwTeach:=fwPrntcodename[1];
 if fwPrntAddedStaffname>fwTeach then fwTeach:=fwPrntAddedStaffname;
  fwAbCode:=PrintCanvas.textwidth('Oth');
 for i:=1 to nmbrreasonsinuse do
  begin
   j:=PrintCanvas.textwidth(Abcode[i]);
   if j>fwAbCode then fwAbCode:=j;
  end;
 case winView[wnPastExtras] of
  0: begin {year Extras}
      MaxTab(1,fwPrntyearname,YearTitle);
      MaxTab(2,0,'99 WWW');
      MaxTab(3,fwPrntperiodname,'Time');
      MaxTab(4,fwPrntcode[0],'Subject');
      MaxTab(5,fwTeach,'Replacement Teacher');
      PrntTabs[6]:=PrntTabs[5]+fwPrntabsence+PrntBlankwidth;
     end;
  1: begin {absent Teacher Extras}
      MaxTab(1,fwPrntcodename[1],'Absent Teacher');
      MaxTab(2,0,'99 WWW');
      MaxTab(3,periods*letterWprnt,'Times');
      MaxTab(4,0,'Reason  ');
      MaxTab(5,fwTeach+PrntBlankwidth+fwPrntperiodname,'Replacement Teacher');
      PrntTabs[6]:=PrntTabs[5];
      MaxTab(5,fwTeach,'');
      MaxTab(7,0,'In Lieu  ');
      PrntTabs[8]:=PrintCanvas.textwidth('Oth:88/12  ');
      PrntTabs[9]:=PrintCanvas.textwidth('W.W')+PrntBlankwidth;
     end;
  2,3:begin {coveringteacherExtras}
       MaxTab(1,fwTeach,'Cover');
       MaxTab(2,0,'WW WWW');
       MaxTab(3,fwPrntperiodname,'Time');
       MaxTab(4,fwPrntcode[0],'Subject');
       MaxTab(5,fwPrntyearname,YearTitle);
       i:=fwPrntcode[0]+PrintCanvas.textwidth(' absent');
       j:=PrintCanvas.textwidth('Conseq. change');
       if j>i then i:=j;
       MaxTab(6,i,'Reason');
       MaxTab(7,fwPrntabsence,'In Lieu ');
       PrntTabs[9]:=PrintCanvas.textwidth('W.W')+Prntblankwidth;
       case pedetail of
        2: begin
            PrntTabs[8]:=fwAbCode+fwperiodname+PrintCanvas.textwidth(':88/12 (C) ');
            j:=PrintCanvas.textwidth(':88/12 (L) ')+periods*LetterWprnt;
            if j>PrntTabs[8] then PrntTabs[8]:=j;
           end;
        3: PrntTabs[8]:=fwAbCode+PrintCanvas.textwidth(':88/12 ');
       end; {case}
      end;
  4: begin {Lost Class Teacher Extras}
      MaxTab(1,fwPrntcodename[1],'Lost Teacher');
      MaxTab(2,0,'99 WWW');
      MaxTab(3,periods*letterWprnt,'Times');
     end;
  5: begin  {summary extras}
      MaxTab(1,0,'WWW'); {indent 3 chars}
      MaxTab(2,0,'WW WWW');
      MaxTab(3,0,'In Lieu ');
      i:=periods*letterWprnt; if fwPrntperiodname>i then i:=fwPrntperiodname;
      MaxTab(4,i,'Time');
      MaxTab(5,fwPrntcode[0],'Subject');
      MaxTab(6,fwPrntyearname,YearTitle);
      i:=fwPrntcode[1]+PrintCanvas.textwidth(' absent');
      j:=PrintCanvas.textwidth('Conseq. change');
      if j>i then i:=j;
      if fwPrntabsence>i then i:=fwPrntabsence;
      MaxTab(7,i,'Reason');
     end;
   6: begin {subject Extras}
      MaxTab(1,fwPrntyearname,YearTitle);
      MaxTab(2,0,'99 WWW');
      MaxTab(3,fwPrntperiodname,'Time');
      MaxTab(4,fwPrntcode[0],'Subject');
      MaxTab(5,fwTeach,'Replacement Teacher');
      PrntTabs[6]:=PrntTabs[5]+fwPrntabsence+PrntBlankwidth;
     end;
 end; {case}
end;

procedure TPrintPastWin.head;
var
 i,j: integer;
begin
 UnderlineOn;  fcolor(cpNormal);
 printwl('Past Extras');
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
  case winView[wnPastExtras] of
  0: begin
      printw('Changes from '+inttostr(PEday1)+' '+month[pemonth1]+' to '+
      inttostr(peday2)+' '+month[pemonth2]);
      x:=0; y:=y+prnttxtheight;
      printw(yeartitle); x:=prntTabs[1];
      printw('Date'); x:=prntTabs[2];
      printw('Time'); x:=prntTabs[3];
      printw('Subject'); x:=prntTabs[4];
      printw('Replacement Teacher'); x:=prntTabs[5];
      printw('Reason');
      x:=0; y:=y+prnttxtheight;
     end;
  1: begin
      printw('Absent teachers from '+inttostr(peday1)+' '+month[pemonth1]+
      ' to '+inttostr(peday2)+' '+month[pemonth2]); x:=0; y:=y+prnttxtheight;
      printw('Absent');  x:=PrntTabs[1];
      if pedetail<3 then
        begin
         printw('Date');
         x:=PrntTabs[2]; printw('Times');
         x:=PrntTabs[3]; printw('Reason');
        end;
       case pedetail of
        1: begin
            x:=PrntTabs[4]; printw('Replacement Teacher');
            x:=PrntTabs[6]; printw('Status');
           end;
        3: printw('Reason and Date');
        4: begin
            printw('Reason Codes');
            newline;
            printw('Teacher');
            for j:=1 to abcodenum do
             begin
              x:=PrntTabs[1]+((j-1)*PrntTabs[9]); printw(Abcode[j]);
             end;
            x:=PrntTabs[1]+(abcodenum*PrntTabs[9]); printw('Other');
            x:=PrntTabs[1]+((abcodenum+1)*PrntTabs[9]); printw('Total');
           end;
       end; {case}
      x:=0; y:=y+prnttxtheight;
     end;
  2,3: begin
      if winView[wnPastExtras]=3 then printw('Classes for Added Teacher')
       else printw('Changes by Covering Teacher');
      x:=0; y:=y+prnttxtheight;
      if winView[wnPastExtras]=3 then ETweeklyinsub else weeklyinsub;
      if winView[wnPastExtras]=5 then printwl('Changes for added')
       else printwl('Changes for');
      printwl(' teachers from '+inttostr(peday1)+' '+month[pemonth1]+' to '
        +inttostr(peday2)+' '+month[pemonth2]);
      if winView[wnPastExtras]<>3 then printwl(' - cover type: '+covershow[pecover]);
      x:=0; y:=y+prnttxtheight; {count:=0;}
      case pedetail of
       1: begin
           printw('Cover'); x:=prntTabs[1];
           printw('Date'); x:=prntTabs[2];
           printw('Time'); x:=prntTabs[3];
           printw('Subject'); x:=prntTabs[4];
           printw(Yeartitle); x:=prntTabs[5];
           printw('Reason'); x:=prntTabs[6];
           if winView[wnPastExtras]<>3 then printw('Status'); {not for added staff}
          end;
       2: begin
           printw('Cover'); x:=prntTabs[1];
           printwl('Code:Date ');
           printwl('Time');
           printwl('(Kind)');
          end;
       3: begin
           printw('Cover'); x:=prntTabs[1];
           printw('Code:Date');
          end;
       4: begin
           printw('Cover'); x:=prntTabs[1];
           printw('Reason Codes'); x:=0; y:=y+prnttxtheight;
           printw('Teacher');
           for i:=1 to abcodenum do
           begin
            x:=prntTabs[1]+((i-1)*prntTabs[9]);
            printw(Abcode[i]);
           end;
           x:=prntTabs[1]+(abcodenum*prntTabs[9]);
           printw('Other');
           x:=prntTabs[1]+((abcodenum+1)*prntTabs[9]);
           printw('Total');
          end;
      end; {case}
      x:=0; y:=y+2*prnttxtheight;
     end;
  4: begin
      printw('Lost Class teachers from '+inttostr(peday1)+' '+month[pemonth1]+
       ' to '+inttostr(peday2)+' '+month[pemonth2]); newline;
       printw('Lost Teacher');  x:=PrntTabs[1];
       printw('Date');
       x:=PrntTabs[2]; printw('Times');
       x:=0; y:=y+2*prnttxtheight;
      end;
  5: begin
       printw('Past Extras Summary');
       x:=0; y:=y+2*prnttxtheight;
     end;
  6: begin
      printw('Changes to subjects from '+inttostr(PEday1)+' '+month[pemonth1]+' to '+
      inttostr(peday2)+' '+month[pemonth2]);
      x:=0; y:=y+prnttxtheight;
      printw(yeartitle); x:=prntTabs[1];
      printw('Date'); x:=prntTabs[2];
      printw('Time'); x:=prntTabs[3];
      printw('Subject'); x:=prntTabs[4];
      printw('Replacement Teacher'); x:=prntTabs[5];
      printw('Reason');
      x:=0; y:=y+prnttxtheight;
     end;
 end; {case}
end;

procedure TPrintPastWin.ImplementPrint;
var
 codecount: array[0..nmbrreasons] of double;
 etreason,count,te,a:          integer;
 found:   boolean;
 temp: double;
 atimeslot: longword;
 aday,amonth,ayear,asub,aoldte,anewte,akind,areason,agen,attday: integer;
 old_day,old_month,datecheck: integer;
 daycount,daycount1,myallot,lostAllot: double;
 lostcount: integer;
 sw:          integer;

 procedure checkNewPage;
 var
  lastone: boolean;
 begin
  if (MyTeCount>1) and (count<MyTecount)then lastone:=false else lastone:=true;
  if Formfeed then
    begin
     printCustomAddon;
     if not(lastone) then  begin StartNewPage; header; end;
    end;
 end;

 procedure GetPastRecord(i:integer);
  begin
   aday:=Past[i].aday;   amonth:=Past[i].amonth;
   atimeslot:=Past[i].atimeslot;
   ayear:=Past[i].ayear; asub:=Past[i].asub;
   aoldte:=Past[i].aoldte;  anewte:=Past[i].anewte;
   akind:=Past[i].akind;    areason:=Past[i].areason;
   agen:=Past[i].agen;  attday:=Past[i].attday;
   datecheck:=100*amonth+aday;
  end;

procedure absentTeacherExtras;
var
 tmpstr: string;
 i,i2,j,p1:      integer;

begin
 fcolor(cpNormal);
 count:=0;
 if num=0 then
 begin
  printw('No past extras selected.');
  exit;
 end;
 sw:=trunc(PrintPageWidth*0.9)-prntHmargin;
 for j:=1 to num do
 begin
  te:=free2[j]; if InUse[te]=0 then continue;
  for i:=0 to nmbrreasons do codecount[i]:=0;
  found:=false; daycount:=0; old_day:=0; old_month:=0;
  for i:=1 to numabsences do
  begin
   fcolor(codecolor);
   GetPastRecord(i);
   if (agen<>1) and (agen<>4) then continue;
   if (agen=1) and ((pedetail<>1) or (anewte=0) or (TsOn[attday,atimeslot-1]=false) ) then continue;
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   if aoldte<>te then continue;

   if not(found) then
   begin
    printwl(tename[aoldte,0]); found:=true; x:=PrntTabs[1];
   end;

   if (agen=1) and (anewte>0) and (TsOn[attday,atimeslot-1]) and (pedetail=1) then
   begin
    x:=PrntTabs[4];
    if akind=1 then printwl(ETname[anewte]) else printwl(tename[anewte,0]);
    x:=PrntTabs[5]; printwl(TimeSlotName[attDay,atimeslot-1]);
    x:=PrntTabs[6]; printwl(PastKind(akind,anewte)); printwl(' ');
    newline; continue;
   end;
  if agen=4 then
   begin
    daycount1:=0; daytotal:=0;
    for p1:=1 to periods do
     begin
      if not(TsOn[attday,p1-1]) then continue;
      myallot:=getEallot(2,te,attday,p1);
      a:=atimeslot and (1 shl p1);
      if a=0 then daycount1:=daycount1+myallot;
      daytotal:=daytotal+myallot;
     end; {for p1}
    temp:=0;
    if daycount1>0 then temp:=0.5;
    if daycount1>(daytotal/2) then temp:=1.0;
    daycount:=daycount+temp;
    codecount[areason]:=codecount[areason]+temp;
    case pedetail of
       1,2: begin
             //if (old_day<>aday) or (old_month<>amonth) then
               printwl(inttostr(aday)+' '+month[amonth]);
             x:=PrntTabs[2];
             for p1:=1 to periods do
              begin
               if not(TsOn[attday,p1-1]) then continue;
               a:=atimeslot and (1 shl p1);
               if a=0 then
                begin printw(tslotcode[p1,attday]); inc(x,letterWprnt); end
                else begin printw('-'); inc(x,letterWprnt); end;
              end; {for p1}
             x:=PrntTabs[3];  printwl(Abcode[areason]+' '+Absent[areason]);
             newline;
            end;
       3: begin
           if x>(sw-PrntTabs[8]) then begin newline; x:=PrntTabs[1]; end;
           printw(Abcode[areason]+':'+inttostr(aday)+'/'+inttostr(amonth));
           inc(x,PrntTabs[8]);
          end;
    end; {case}
   end; {if agen=4}
  end; {for i }

  if found then
  begin
   inc(count);

   if pedetail<4 then
   begin
    if x>0 then newline;
    fcolor(cpNormal);
    str(daycount:3:1,tmpstr); printwl('Days absent: '+tmpstr);
    x:=0; y:=y+prnttxtheight; newline;
    drawmyline(0,y-(prnttxtheight div 2),sw,y-(prnttxtheight div 2));
    fcolor(codecolor);
   end;
   if (pedetail=4) then
   begin
    for i:=1 to abcodenum do
    begin
     x:=prntTabs[1]+((i-1)*prntTabs[9]);
     if codecount[i]>0 then fcolor(cpCurrent)
       else fcolor(codecolor);
     str(codecount[i]:3:1,tmpstr);
     printwl(tmpstr+' ');
    end; {for i}

    str(codecount[0]:3:1,tmpstr);
    x:=prntTabs[1]+(abcodenum*prntTabs[9]);
    if codecount[0]>0 then fcolor(cpCurrent) else fcolor(codecolor);
    printwl(tmpstr+' ');
    str(daycount:3:1,tmpstr);
    x:=prntTabs[1]+((abcodenum+1)*prntTabs[9]);
    if daycount>0 then fcolor(cpCurrent) else fcolor(codecolor);
    printwl(tmpstr+' ');  newline;
    fcolor(codecolor);
   end;
  end;
  if pedetail<4 then CheckNewPage;
 end; {for j}
 newline; fcolor(cpNormal);
 if not(formfeed) or (pedetail=4) then
  begin
   printwl('Absent teachers shown: '+inttostr(count)); newline;
   printCustomAddon;
  end;
end;

procedure coveringTeacherExtras;
var
 i,j,i2,p1:  integer;
 tmpstr: string;
 tmax,old_reason: integer;
 excount,recount,incount,etcount,totalcount: double;
begin
 fcolor(cpNormal);
 if num=0 then
 begin
  printw('No past extras selected.');
  exit;
 end;
 count:=0;
 sw:=trunc(PrintPageWidth*0.9)-prntHmargin;
 for j:=1 to num do
 begin
  te:=free2[j]; if InUse[te]=0 then continue;
  for i2:=0 to nmbrreasons do codecount[i2]:=0;
  if ETprint then tmax:=ETnum else tmax:=numcodes[1];
  if (te<1) or (te>tmax) then continue;
  found:=false;old_day:=0;old_month:=0;excount:=0;recount:=0;incount:=0;
  ETreason:=0; ETcount:=0; old_reason:=0; totalcount:=0;
  for i:=1 to numabsences do
  begin
   GetPastRecord(i);
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   if anewte<>te then continue;
   if (ETprint xor (akind=1)) then continue;
   if (Agen=4) or (Agen=7) then continue;
   if not(ETprint) then
    if (not(TsOn[attday,atimeslot-1])) or ((pecover=2) and (akind<>4))
     or ((pecover=3) and (akind<>2)) or ((pecover=4) and (akind<>3)) then continue;
   if ETprint then
    if (not(TsOn[attday,atimeslot-1])) then continue;

   fcolor(codecolor);
   if not(found) then
   begin
    if etprint then printw(ETname[te]) else printw(tename[te,0]);
    x:=prntTabs[1];
   end;
   found:=true;
   if (akind=4) and ((pecover=1) or (pecover=2)) then
    excount:=excount+getEallot(1,ayear,attday,atimeslot);
   if (akind=2) and ((pecover=1) or (pecover=3)) then
    recount:=recount+getEallot(1,ayear,attday,atimeslot);
   if (akind=3) and ((pecover=1) or (pecover=4)) then
    incount:=incount+getEallot(1,ayear,attday,atimeslot);

   etcount:=etcount+getEallot(1,ayear,attday,atimeslot);
   codecount[areason]:=codecount[areason]+getEallot(1,ayear,attday,atimeslot);
   totalcount:=totalcount+getEallot(1,ayear,attday,atimeslot);

   case pedetail of
   1: begin
       x:=prntTabs[1];
       //if (old_day<>aday) or (old_month<>amonth) then
        begin
         printw(inttostr(aday)+' '+month[amonth]);
         old_day:=aday; old_month:=amonth; etreason:=0;
        end;
        x:=prntTabs[2];
        printw(TimeSlotName[attDay,atimeslot-1]);
        x:=prntTabs[3]; printw(SubCode[asub]);
        x:=prntTabs[4]; printw(yearname[ayear]);
        x:=prntTabs[5]; printw(ChangeGen(agen,aoldte));
        x:=prntTabs[6];
        if etprint and (agen=1) and (etreason<>aoldte) then
         begin
          printwl(Abcode[areason]+' '+Absent[areason]);
          etreason:=aoldte;
         end;
        if not(ETprint) then printwl(PastKind(akind,anewte));
        newline;
       end; {pedetail=1}
    2,3: begin
          if (old_day<>aday) or (old_month<>amonth) or ((old_reason<>areason) and (agen=1)) then
           begin
            if x>(sw-PrntTabs[8]) then begin newline; x:=prntTabs[1]; end;
            if agen=1 then printwl(Abcode[areason]+':');
            printwl(inttostr(aday)+'/'+inttostr(amonth));
            old_day:=aday; old_month:=amonth; old_reason:=areason;
           end;
          if (pedetail=2) then printwl(CoverKind(agen,akind,atimeslot,attday));
          printwl(' '); {gap between them}
         end;
   end {case}
  end; {for i}
  if found and (pedetail<4) then
  begin
   if (pedetail<>1) then newline;
   fcolor(cpNormal);
   if (etprint=false) then
   begin
    printwl('Time Allotment  ');
    if (pecover=1) or (pecover=2) then
    begin
     str(excount:4:1,tmpstr);
     printwl('  Extras:'+tmpstr);
    end;
    if (pecover=1) or (pecover=3) then
    begin
     str(recount:4:1,tmpstr);
     printwl('  Replacements:'+tmpstr);
    end;
    if (pecover=1) or (pecover=4) then
    begin
     str(incount:4:1,tmpstr);
     printwl('  In-lieus:'+tmpstr);
    end;
    newline;
   end
   else
    begin
     str(etcount:5:1,tmpstr);
     printw('Time Allotment '+tmpstr);
     newline;
    end;
   newline;
   {divider line here}
   drawmyline(0,y-(prnttxtheight div 2),sw,y-(prnttxtheight div 2));
   inc(count);
   CheckNewPage;
  end;  {if found and (pedetail<4) then}
  if found and (pedetail=4) then
  begin
   fcolor(codecolor);
   for i:=1 to abcodenum do
   begin
    x:=prntTabs[1]+((i-1)*prntTabs[9]);
    if codecount[i]>0 then fcolor(cpCurrent)
      else fcolor(codecolor);
    str(codecount[i]:3:1,tmpstr);
    printw(tmpstr);
   end; {for i}

   x:=prntTabs[1]+(abcodenum*prntTabs[9]);
   str(codecount[0]:3:1,tmpstr);
   if codecount[0]>0 then fcolor(cpCurrent)
      else fcolor(codecolor);
   printw(tmpstr);
   x:=prntTabs[1]+((abcodenum+1)*prntTabs[9]);
   str(totalcount:3:1,tmpstr);
   if totalcount>0 then fcolor(cpCurrent)
      else fcolor(codecolor);
   printw(tmpstr);
   newline;
   fcolor(codecolor);
  end;
 end; {for j}
 if not(formfeed) or (pedetail=4) then printCustomAddon;
end;

procedure yearExtras;
var
 i,yy,start,finish: integer;
begin
 if numabsences=0 then
 begin
  printw('No past extras selected.');
  exit;
 end;
 if winpastExtrasyear=-1 then
  begin start:=years_minus_1; finish:=0; end
 else
   begin start:=winpastExtrasyear; finish:=winpastExtrasyear; end;
 count:=0;   fcolor(cpNormal);

 drawmyline(0,y+(prnttxtheight div 2),prntTabs[6],y+(prnttxtheight div 2));
 newline;
 for yy:=start downto finish do
 begin
  printw(yearname[yy]); count:=0;
  found:=false; old_day:=0; old_month:=0;
  for i:=1 to numabsences do
  begin
   fcolor(codecolor);
   GetPastRecord(i);
   if (agen=4) or (agen=7) or (ayear<>yy) or (aday<1) or (aday>31)
      or (amonth<1) or (amonth>12) then continue;
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   found:=true;  x:=prntTabs[1];
   //if (old_day<>aday) or (old_month<>amonth) then
   begin printw(inttostr(aday)+' '+month[amonth]); old_month:=amonth; old_day:=aday; end;
   x:=prntTabs[2]; printw(TimeSlotName[attDay,atimeslot-1]);
   x:=prntTabs[3]; printw(SubCode[asub]); x:=prntTabs[4];
   if (akind=1) then printw(ETname[Anewte]) else printw(tename[Anewte,0]);
   x:=prntTabs[5]; printw(ChangeGen(agen,aoldte));
   newline;
  end; {for i}
  if not(found) then
  begin
   x:=prntTabs[2];
   printw('(no changes)'); newline;
  end;
  fcolor(cpNormal);
  drawmyline(0,y+(prnttxtheight div 2),prntTabs[6],y+(prnttxtheight div 2));
  newline;
 end; {for yy}
 printCustomAddon;
end;

procedure lostTeacherExtras;
var
 tmpstr: string;
 i,j,p1:          integer;
begin
 fcolor(cpNormal);
 count:=0;
 if num>0 then
  begin
   fcolor(codecolor);
   for j:=1 to num do
   begin
    te:=free2[j]; if InUse[te]=0 then continue;
    found:=false; Lostcount:=0;LostAllot:=0; old_day:=0; old_month:=0;
    for i:=1 to numabsences do
    begin
     GetPastRecord(i);
     if (agen<>7) then continue;
     if (datecheck<startdate) or (datecheck>enddate) then continue;
     if aoldte<>te then continue;

     if not(found) then
     begin
      printwl(tename[aoldte,0]); found:=true; x:=prntTabs[1];
     end;

    if agen=7 then
     begin
      for p1:=1 to periods do
       begin
        if not(TsOn[attday,p1-1]) then continue;
        myallot:=getEallot(2,te,attday,p1);
        a:=atimeslot and (1 shl p1);
        if a=0 then
         begin
          inc(lostcount); LostAllot:=LostAllot+myallot;
         end;
       end; {for p1}
      //if (old_day<>aday) or (old_month<>amonth) then
       printwl(inttostr(aday)+' '+month[amonth]);
      x:=prntTabs[2];
      for p1:=1 to periods do
       begin
        if not(TsOn[attday,p1-1]) then continue;
        a:=atimeslot and (1 shl p1);
        if a=0 then
         begin printw(tslotcode[p1,attday]); inc(x,letterWprnt); end
         else begin printw('-'); inc(x,letterWprnt); end;
       end; {for p1}
      newline;
     end; {if agen=4}
    end; {for i }
    if found then
    begin
     inc(count);
     if x>0 then newline;
     fcolor(cpNormal);
     str(lostAllot:3:1,tmpstr);
     printw('Lost classes: '+inttostr(lostcount)+'  Allot: '+tmpstr); newline; newline;
     drawmyline(0,y-(txtheight div 2),PrntTabs[3],y-(txtheight div 2));
     fcolor(codecolor);
    end;
    CheckNewPage;
   end; {for j}
  if not(formfeed) then
   begin
    newline; fcolor(cpNormal);
    printwl('Lost Class teachers shown: '+inttostr(count)); newline;
    printCustomAddon;
   end;
  end;
end;

procedure SummaryExtras;
var
 tmpstr: string;
 i,j,p1:          integer;
 excount,recount,incount,totalcount: double;
begin
 fcolor(cpNormal);
 sw:=trunc(PrintPageWidth*0.9)-prntHmargin;
 count:=0;
 if num>0 then
  begin
   for j:=1 to num do
   begin
    fcolor(codecolor);
    te:=free2[j]; if InUse[te]=0 then continue;
    printw(tename[te,0]+' changes from '+inttostr(peday1)+' '+month[pemonth1]+
   ' to '+inttostr(peday2)+' '+month[pemonth2]); newline;
    x:=PrntTabs[1];  printw('Date'); x:=PrntTabs[2]; printw('Status');
    x:=PrntTabs[3];  printw('Time'); x:=PrntTabs[4]; printw('Details'); newline;

    for i:=0 to nmbrreasons do codecount[i]:=0;
    found:=false; Lostcount:=0;LostAllot:=0; old_day:=0; old_month:=0;
    daycount:=0; excount:=0;recount:=0;incount:=0; totalcount:=0;
    for i:=1 to numabsences do
    begin
     GetPastRecord(i);
     fcolor(codecolor);
     if (datecheck<startdate) or (datecheck>enddate) then continue;
     if ((agen=7) or (agen=4)) and (aoldte<>te) then continue;
     if (agen<>7) and (agen<>4) and ((anewte<>te) or (akind=1)) then continue;
     if (agen<>7) and (agen<>4) then if (not(TsOn[attday,atimeslot-1])) then continue;
     //if (old_day<>aday) or (old_month<>amonth) then
        begin
         x:=PrntTabs[1]; printwl(inttostr(aday)+' '+month[amonth]);
         old_day:=aday; old_month:=amonth;
        end;
     if (agen=7) and (aoldte=te) then
      begin
       found:=true;
       for p1:=1 to periods do
        begin
         if not(TsOn[attday,p1-1]) then continue;
         myallot:=getEallot(2,te,attday,p1);
         a:=atimeslot and (1 shl p1);
         if a=0 then
          begin
           inc(lostcount); LostAllot:=LostAllot+myallot;
          end;
        end; {for p1}
       x:=PrntTabs[2]; printw('Lost');
       x:=PrntTabs[3];
       for p1:=1 to periods do
        begin
         if not(TsOn[attday,p1-1]) then continue;
         a:=atimeslot and (1 shl p1);
         if a=0 then printw(tslotcode[p1,attday]) else printw('-');
         inc(x,letterWprnt);
        end; {for p1}
       newline;
      end; {if agen=7}

     if (agen=4) and (aoldte=te) then
      begin
       daycount1:=0; daytotal:=0; found:=true;
       for p1:=1 to periods do
        begin
         if not(TsOn[attday,p1-1]) then continue;
         myallot:=getEallot(2,te,attday,p1);
         a:=atimeslot and (1 shl p1);
         if a=0 then daycount1:=daycount1+myallot;
         daytotal:=daytotal+myallot;
        end; {for p1}
       temp:=0;
       if daycount1>0 then temp:=0.5;
       if daycount1>(daytotal/2) then temp:=1.0;
       daycount:=daycount+temp;
       x:=PrntTabs[2]; printw('Absent');
       x:=PrntTabs[3];
       for p1:=1 to periods do
        begin
         if not(TsOn[attday,p1-1]) then continue;
         a:=atimeslot and (1 shl p1);
         if a=0 then  printw(tslotcode[p1,attday]) else printw('-');
         inc(x,letterWprnt);
        end; {for p1}
       x:=PrntTabs[4];  printwl(Abcode[areason]+' '+Absent[areason]);
       newline;
      end; {if agen=4}

     if (agen<>7) and (agen<>4) and (anewte=te) and (akind<>1) then
      begin
       x:=PrntTabs[2];  printw(PastKind(akind,anewte));
       x:=PrntTabs[3];  printw(TimeSlotName[attDay,atimeslot-1]);
       x:=PrntTabs[4];  printw(SubCode[asub]);
       x:=PrntTabs[5];  printw(yearname[ayear]);
       x:=PrntTabs[6];  printw(ChangeGen(agen,aoldte));
       newline;  found:=true;
       myallot:=getEallot(1,ayear,attday,atimeslot);
       if (akind=4) then excount:=excount+myallot;
       if (akind=2) then recount:=recount+myallot;
       if (akind=3) then incount:=incount+myallot;
       totalcount:=totalcount+myallot;
      end;

    end; {for i }
    if found then
    begin
     inc(count);
     fcolor(cpNormal);
     str(daycount:3:1,tmpstr); printwl('Days absent: '+tmpstr);
     str(lostAllot:3:1,tmpstr);
     printwl('  Lost classes: '+inttostr(lostcount)+'  Allot: '+tmpstr); newline;
     printwl('Time Allotment  ');
     str(excount:4:1,tmpstr); printwl('  Extras:'+tmpstr);
     str(recount:4:1,tmpstr); printwl('  Replacements:'+tmpstr);
     str(incount:4:1,tmpstr); printwl('  In-lieus:'+tmpstr);
     newline; newline;
     drawmyline(0,y-(Prnttxtheight div 2),sw,y-(Prnttxtheight div 2));
     fcolor(codecolor);
    end;
    CheckNewPage;
   end; {for j}
  if not(formfeed) then
   begin
    newline; fcolor(cpNormal);
    printwl('Teachers shown: '+inttostr(count)); newline;
    printCustomAddon;
   end;
  end;
end;

procedure subjectExtras;
var
 i,j,yy,start,finish: integer;
 subSel: integer;
begin
 if numabsences=0 then
 begin
  printw('No past extras selected.');
  exit;
 end;
 if winpastExtrasyear=-1 then
  begin start:=years_minus_1; finish:=0; end
 else
   begin start:=winpastExtrasyear; finish:=winpastExtrasyear; end;
 count:=0;   fcolor(cpNormal);

 drawmyline(0,y+(prnttxtheight div 2),prntTabs[6],y+(prnttxtheight div 2));
 newline;
 for yy:=start downto finish do
 begin
  printw(yearname[yy]); count:=0;
  found:=false; old_day:=0; old_month:=0;
  for j := 1 to num do
  begin
    subSel := free3[j];
    for i:=1 to numabsences do
    begin
      fcolor(codecolor);
      GetPastRecord(i);
      if (agen=4) or (agen=7) or (ayear<>yy) or
          (aday<1) or (aday>31) or (amonth<1) or (amonth>12) then continue;
     if (datecheck<startdate) or (datecheck>enddate) then continue;
     if asub<>subSel then continue;
        found:=true;  x:=prntTabs[1];
   //if (old_day<>aday) or (old_month<>amonth) then
      begin printw(inttostr(aday)+' '+month[amonth]); old_month:=amonth; old_day:=aday; end;
       x:=prntTabs[2]; printw(TimeSlotName[attDay,atimeslot-1]);
      x:=prntTabs[3]; printw(SubCode[asub]); x:=prntTabs[4];
      if (akind=1) then printw(ETname[Anewte]) else printw(tename[Anewte,0]);
       x:=prntTabs[5]; printw(ChangeGen(agen,aoldte));
     newline;
    end; {for i}
  end; {for j}
  if not(found) then
  begin
   x:=prntTabs[2];
   printw('(no changes)'); newline;
  end;
  fcolor(cpNormal);
  drawmyline(0,y+(prnttxtheight div 2),prntTabs[6],y+(prnttxtheight div 2));
  newline;
 end; {for yy}
 printCustomAddon;
end;

begin
 codeColor:=cpClass;
 x:=0;  y:=prntVmargin;
 PrintHead;
 case winView[wnPastExtras] of
  0: yearExtras;
  1: absentTeacherExtras;
  2,3: coveringteacherExtras;
  4: lostTeacherExtras;
  5: SummaryExtras;
  6: subjectExtras;
 end; {case}
end;

procedure pastExtrasWinprint;
begin
 PrintPastWin:=TPrintPastWin.Create;
 with PrintPastWin do
  try
   SetTabs;
   ImplementPrint;
  finally
   PrintPastWin.free;
  end;
end;

procedure TOutPastWin.head;
var
 i,j: integer;
 s: string;
begin
 printLine(['Past Extras']);
  case winView[wnPastExtras] of
  0: begin
      printw('Changes from '+inttostr(PEday1)+' '+month[pemonth1]+' to '+
      inttostr(peday2)+' '+month[pemonth2]);
      newline;
      printLine([yeartitle,'Date','Time','Subject','Replacement Teacher','Reason']);
     end;
  1: begin
      printw('Absent teachers from '+inttostr(peday1)+' '+month[pemonth1]+
      ' to '+inttostr(peday2)+' '+month[pemonth2]); newline;
      printw('Absent');
      if pedetail<3 then
        begin
         printc('Date');
         printc('Times');
         printc('Reason');
        end;
       case pedetail of
        1: begin
            printc('Replacement Teacher');
            printc('Status');
           end;
        3: printc('Reason and Date');
        4: begin
            printc('Reason Codes');
            newline;
            printw('Teacher');
            for j:=1 to abcodenum do printc(Abcode[j]);
            printc('Other');
            printc('Total');
           end;
       end; {case}
      newline;
     end;
  2,3: begin
      if winView[wnPastExtras]=3 then printw('Classes for Added Teacher')
       else printw('Changes by Covering Teacher');
      newline;
      if winView[wnPastExtras]=3 then ETweeklyinsub else weeklyinsub;
      if winView[wnPastExtras]=5 then s:='Changes for added'
       else s:='Changes for';
      s:=s+' teachers from '+inttostr(peday1)+' '+month[pemonth1]+' to '
        +inttostr(peday2)+' '+month[pemonth2];
      if winView[wnPastExtras]<>3 then s:=s+' - cover type: '+covershow[pecover];
      PrintLine([s]);
      case pedetail of
       1: begin
           printw('Cover');
           printc('Date');
           printc('Time');
           printc('Subject');
           printc(Yeartitle);
           printc('Reason');
           if winView[wnPastExtras]<>3 then printc('Status'); {not for added staff}
          end;
       2: begin
           printw('Cover');
           printc('Code:Date ');
           printc('Time');
           printc('(Kind)');
          end;
       3: begin
           printw('Cover');
           printc('Code:Date');
          end;
       4: begin
           printw('Cover');
           printc('Reason Codes'); newline;
           printw('Teacher');
           for i:=1 to abcodenum do printc(Abcode[i]);
           printc('Other');
           printc('Total');
          end;
      end; {case}
      newline;
     end;
  4: begin
      printw('Lost Class teachers from '+inttostr(peday1)+' '+month[pemonth1]+
       ' to '+inttostr(peday2)+' '+month[pemonth2]); newline;
      if num=0 then
       begin
        printLine(['No past extras selected.']);
        exit;
       end;
      printLine(['Lost Teacher','Date','Times']);
     end;
  5: begin
    printw('Past Extras Summary'); newline;
  end;
  6: begin
      printw('Changes to subjects from '+inttostr(PEday1)+' '+month[pemonth1]+' to '+
      inttostr(peday2)+' '+month[pemonth2]);
      newline;
      printLine([yeartitle,'Date','Time','Subject','Replacement Teacher','Reason']);
     end;
 end; {case}
end;

procedure TOutPastWin.ImplementPrint;
var
 codecount: array[0..nmbrreasons] of double;
 etreason,count,te,a:          integer;
 found:   boolean;
 temp: double;
 atimeslot:  longword;
 aday,amonth,
 ayear,asub,aoldte,anewte,akind,areason,agen,attday: integer;
 old_day,old_month,datecheck: integer;
 daycount,daycount1,myallot,lostAllot: double;
 lostcount: integer;


 procedure GetPastRecord(i:integer);
  begin
   aday:=Past[i].aday;   amonth:=Past[i].amonth;
   atimeslot:=Past[i].atimeslot;
   ayear:=Past[i].ayear; asub:=Past[i].asub;
   aoldte:=Past[i].aoldte;  anewte:=Past[i].anewte;
   akind:=Past[i].akind;    areason:=Past[i].areason;
   agen:=Past[i].agen;  attday:=Past[i].attday;
   datecheck:=100*amonth+aday;
  end;

procedure absentTeacherExtras;
var
 tmpstr: string;
 i,i2,j,p1:      integer;
 count,sw:          integer;
 s: string;
begin
 count:=0;
 if num=0 then
 begin
  printLine(['No past extras selected.']);
  exit;
 end;
 for j:=1 to num do
 begin
  te:=free2[j]; if InUse[te]=0 then continue;
  for i:=0 to nmbrreasons do codecount[i]:=0;
  found:=false; daycount:=0; old_day:=0; old_month:=0;
  for i:=1 to numabsences do
  begin
   GetPastRecord(i);
   if (agen<>1) and (agen<>4) then continue;
   if (agen=1) and ((pedetail<>1) or (anewte=0) or (TsOn[attday,atimeslot-1]=false) ) then continue;
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   if aoldte<>te then continue;

   if not(found) then
   begin
    printw(tename[aoldte,0]); found:=true;
   end;

   if (agen=1) and (anewte>0) and (TsOn[attday,atimeslot-1]) and (pedetail=1) then
   begin
    printc('');   printc(''); printc('');
    if akind=1 then printc(ETname[anewte]) else printc(tename[anewte,0]);
    printc(TimeSlotName[attDay,atimeslot-1]);
    printc(PastKind(akind,anewte));
    newline; continue;
   end;
  if agen=4 then
   begin
    daycount1:=0; daytotal:=0;
    for p1:=1 to periods do
     begin
      if not(TsOn[attday,p1-1]) then continue;
      myallot:=getEallot(2,te,attday,p1);
      a:=atimeslot and (1 shl p1);
      if a=0 then daycount1:=daycount1+myallot;
      daytotal:=daytotal+myallot;
     end; {for p1}
    temp:=0;
    if daycount1>0 then temp:=0.5;
    if daycount1>(daytotal/2) then temp:=1.0;
    daycount:=daycount+temp;
    codecount[areason]:=codecount[areason]+temp;
    case pedetail of
       1,2: begin
             //if (old_day<>aday) or (old_month<>amonth) then
               printc(inttostr(aday)+' '+month[amonth]);
             s:='';
             for p1:=1 to periods do
              begin
               if not(TsOn[attday,p1-1]) then continue;
               a:=atimeslot and (1 shl p1);
               if a=0 then s:=s+tslotcode[p1,attday] else s:=s+'-';
              end; {for p1}
             printc(s);
             printc(Abcode[areason]);printc(Absent[areason]);
             newline;
            end;
       3: begin
//           if x>(sw-PrntTabs[8]) then begin newline; x:=PrntTabs[1]; end;
           printc(Abcode[areason]+':'+inttostr(aday)+'/'+inttostr(amonth));
          end;
    end; {case}
   end; {if agen=4}
  end; {for i }

  if found then
  begin
   inc(count);
   if pedetail<4 then
   begin
    if (pedetail=3) and (daycount>0) then newline;
    str(daycount:3:1,tmpstr); printLine(['Days absent:',tmpstr]);
    newline;
   end;
   if (pedetail=4) then
   begin
    for i:=1 to abcodenum do
    begin
     str(codecount[i]:3:1,tmpstr);
     printc(tmpstr+' ');
    end; {for i}

    str(codecount[0]:3:1,tmpstr);
    printc(tmpstr+' ');
    str(daycount:3:1,tmpstr);
    printc(tmpstr+' ');  newline;
   end;
  end;
 end; {for j}
 newline;
 printw('Absent teachers shown: '+inttostr(count)); newline;
end;

procedure coveringTeacherExtras;
var
 i,j,i2,p1:  integer;
 tmpstr: string;
 tmax,old_reason: integer;
 excount,recount,incount,etcount,totalcount: double;
begin
 if num=0 then
 begin
  printLine(['No past extras selected.']);
  exit;
 end;
 count:=0;

 for j:=1 to num do
 begin
  te:=free2[j]; if InUse[te]=0 then continue;
  for i2:=0 to nmbrreasons do codecount[i2]:=0;
  if ETprint then tmax:=ETnum else tmax:=numcodes[1];
  if (te<1) or (te>tmax) then continue;
  found:=false;old_day:=0;old_month:=0;excount:=0;recount:=0;incount:=0;
  ETreason:=0; ETcount:=0; old_reason:=0; totalcount:=0;
  for i:=1 to numabsences do
  begin
   GetPastRecord(i);
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   if anewte<>te then continue;
   if (ETprint xor (akind=1)) then continue;
   if (aGen=4) or (aGen=7) then continue;
   if not(ETprint) then
    if (not(TsOn[attday,atimeslot-1])) or ((pecover=2) and (akind<>4))
     or ((pecover=3) and (akind<>2)) or ((pecover=4) and (akind<>3)) then continue;
   if ETprint then
    if (not(TsOn[attday,atimeslot-1])) then continue;

   if not(found) then
   begin
    if etprint then printw(ETname[te]) else printw(tename[te,0]);
   end;
   found:=true;
   if (akind=4) and ((pecover=1) or (pecover=2)) then
    excount:=excount+getEallot(1,ayear,attday,atimeslot);
   if (akind=2) and ((pecover=1) or (pecover=3)) then
    recount:=recount+getEallot(1,ayear,attday,atimeslot);
   if (akind=3) and ((pecover=1) or (pecover=4)) then
    incount:=incount+getEallot(1,ayear,attday,atimeslot);

   etcount:=etcount+getEallot(1,ayear,attday,atimeslot);
   codecount[areason]:=codecount[areason]+getEallot(1,ayear,attday,atimeslot);
   totalcount:=totalcount+getEallot(1,ayear,attday,atimeslot);

   case pedetail of
   1: begin
       //if (old_day<>aday) or (old_month<>amonth) then
        begin
         printc(inttostr(aday)+' '+month[amonth]);
         old_day:=aday; old_month:=amonth; etreason:=0;
        end;
        printc(TimeSlotName[attDay,atimeslot-1]);
        printc(SubCode[asub]);
        printc(yearname[ayear]);
        printc(ChangeGen(agen,aoldte));
        if etprint and (agen=1) and (etreason<>aoldte) then
         begin
          printc(Abcode[areason]+' '+Absent[areason]);
          etreason:=aoldte;
         end;
        if not(ETprint) then printc(PastKind(akind,anewte));
        newline;
       end; {pedetail=1}
    2,3: begin
          if (old_day<>aday) or (old_month<>amonth) or ((old_reason<>areason) and (agen=1)) then
           begin
            if agen=1 then printc(Abcode[areason]+':');
            printc(inttostr(aday)+'/'+inttostr(amonth));
            old_day:=aday; old_month:=amonth; old_reason:=areason;
           end;
          if (pedetail=2) then printc(CoverKind(agen,akind,atimeslot,attday));
         end;
   end {case}
  end; {for i}
  if found and (pedetail<4) then
  begin
   if (pedetail<>1) then newline;
   if (etprint=false) then
   begin
    printw('Time Allotment');
    if (pecover=1) or (pecover=2) then
    begin
     str(excount:4:1,tmpstr);
     printc('Extras:'+tmpstr);
    end;
    if (pecover=1) or (pecover=3) then
    begin
     str(recount:4:1,tmpstr);
     printc('Replacements:'+tmpstr);
    end;
    if (pecover=1) or (pecover=4) then
    begin
     str(incount:4:1,tmpstr);
     printc('In-lieus:'+tmpstr);
    end;
    newline;
   end
   else
    begin
     str(etcount:5:1,tmpstr);
     printw('Time Allotment '+tmpstr);
     newline;
    end;
   newline;
   {divider line here}
  end;  {if found and (pedetail<4) then}
  if found and (pedetail=4) then
  begin
   for i:=1 to abcodenum do
   begin
    str(codecount[i]:3:1,tmpstr);
    printc(tmpstr);
   end; {for i}

   str(codecount[0]:3:1,tmpstr);
   printc(tmpstr);
   str(totalcount:3:1,tmpstr);
   printc(tmpstr);
   newline;
  end;
 end; {for j}
end;

procedure yearExtras;
var
 i,yy,start,finish: integer;
begin
 if numabsences=0 then
 begin
  printLine(['No past extras selected.']);
  exit;
 end;
 if winpastExtrasyear=-1 then
  begin start:=years_minus_1; finish:=0; end
 else
   begin start:=winpastExtrasyear; finish:=winpastExtrasyear; end;
 count:=0;

 newline;
 for yy:=start downto finish do
 begin
  printw(yearname[yy]); count:=0;
  found:=false; old_day:=0; old_month:=0;
  for i:=1 to numabsences do
  begin
   aday:=Past[i].aday; amonth:=Past[i].amonth;  atimeslot:=Past[i].atimeslot;
   ayear:=Past[i].ayear;
   asub:=Past[i].asub;
   aoldte:=Past[i].aoldte;
   anewte:=Past[i].anewte;
   akind:=Past[i].akind;
   areason:=Past[i].areason;
   agen:=Past[i].agen;
   if (agen=4) or (agen=7) or (ayear<>yy) or (aday<1) or (aday>31)
      or (amonth<1) or (amonth>12) then continue;
   datecheck:=100*amonth+aday;
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   found:=true;
   //if (old_day<>aday) or (old_month<>amonth) then
   begin printc(inttostr(aday)+' '+month[amonth]); old_month:=amonth; old_day:=aday; end;
    //else printc('');
   printc(TimeSlotName[attDay,atimeslot-1]);
   printc(SubCode[asub]);
   if (akind=1) then printc(ETname[Anewte]) else printc(tename[Anewte,0]);
   printc(ChangeGen(agen,aoldte));
   newline;
  end; {for i}
  if not(found) then
  begin
   printc('(no changes)'); newline;
  end;
  newline;
 end; {for yy}
end;

procedure lostTeacherExtras;
var
 tmpstr: string;
 i,j,p1,count:          integer;
begin
 count:=0;
 if num>0 then
  begin
   for j:=1 to num do
   begin
    te:=free2[j]; if InUse[te]=0 then continue;
    found:=false; Lostcount:=0;LostAllot:=0; old_day:=0; old_month:=0;
    for i:=1 to numabsences do
    begin
     GetPastRecord(i);
     if (agen<>7) then continue;
     if (datecheck<startdate) or (datecheck>enddate) then continue;
     if aoldte<>te then continue;

     if not(found) then
     begin
      printw(tename[aoldte,0]); found:=true;
     end;

    if agen=7 then
     begin
      for p1:=1 to periods do
       begin
        if not(TsOn[attday,p1-1]) then continue;
        myallot:=getEallot(2,te,attday,p1);
        a:=atimeslot and (1 shl p1);
        if a=0 then
         begin
          inc(lostcount); LostAllot:=LostAllot+myallot;
         end;
       end; {for p1}
      //if (old_day<>aday) or (old_month<>amonth) then
       printc(inttostr(aday)+' '+month[amonth]);
       printc('');
      for p1:=1 to periods do
       begin
        if not(TsOn[attday,p1-1]) then continue;
        a:=atimeslot and (1 shl p1);
        if a=0 then printw(tslotcode[p1,attday])
         else printw('-');
       end; {for p1}
      newline;
     end; {if agen=4}
    end; {for i }
    if found then
    begin
     inc(count);
     str(lostAllot:3:1,tmpstr);
     printw('Lost classes: '+inttostr(lostcount)+'  Allot: '+tmpstr); newline; newline;
    end;
   end; {for j}
   newline;
   printw('Lost Class teachers shown: '+inttostr(count)); newline;
  end;
end;

procedure SummaryExtras;
var
 tmpstr: string;
 i,j,p1,count:          integer;
 excount,recount,incount,totalcount: double;
begin
 count:=0;
 if num>0 then
  begin
   for j:=1 to num do
   begin
    te:=free2[j]; if InUse[te]=0 then continue;
    printw(tename[te,0]+' changes from '+inttostr(peday1)+' '+month[pemonth1]+
   ' to '+inttostr(peday2)+' '+month[pemonth2]); newline;
    printLine(['Date','Status','Time','Details']);

    for i:=0 to nmbrreasons do codecount[i]:=0;
    found:=false; Lostcount:=0;LostAllot:=0; old_day:=0; old_month:=0;
    daycount:=0; excount:=0;recount:=0;incount:=0; totalcount:=0;
    for i:=1 to numabsences do
    begin
     GetPastRecord(i);
     if (datecheck<startdate) or (datecheck>enddate) then continue;
     if ((agen=7) or (agen=4)) and (aoldte<>te) then continue;
     if (agen<>7) and (agen<>4) and ((anewte<>te) or (akind=1)) then continue;
     if (agen<>7) and (agen<>4) then if (not(TsOn[attday,atimeslot-1])) then continue;
     //if (old_day<>aday) or (old_month<>amonth) then
        begin
         printc(inttostr(aday)+' '+month[amonth]);
         old_day:=aday; old_month:=amonth;
        end;
     if (agen=7) and (aoldte=te) then
      begin
       found:=true;
       for p1:=1 to periods do
        begin
         if not(TsOn[attday,p1-1]) then continue;
         myallot:=getEallot(2,te,attday,p1);
         a:=atimeslot and (1 shl p1);
         if a=0 then
          begin
           inc(lostcount); LostAllot:=LostAllot+myallot;
          end;
        end; {for p1}
       printc('Lost');
       printc('');
       for p1:=1 to periods do
        begin
         if not(TsOn[attday,p1-1]) then continue;
         a:=atimeslot and (1 shl p1);
         if a=0 then printw(tslotcode[p1,attday]) else printw('-');
        end; {for p1}
       newline;
      end; {if agen=7}

     if (agen=4) and (aoldte=te) then
      begin
       daycount1:=0; daytotal:=0; found:=true;
       for p1:=1 to periods do
        begin
         if not(TsOn[attday,p1-1]) then continue;
         myallot:=getEallot(2,te,attday,p1);
         a:=atimeslot and (1 shl p1);
         if a=0 then daycount1:=daycount1+myallot;
         daytotal:=daytotal+myallot;
        end; {for p1}
       temp:=0;
       if daycount1>0 then temp:=0.5;
       if daycount1>(daytotal/2) then temp:=1.0;
       daycount:=daycount+temp;
       printc('Absent');
       printc('');
       for p1:=1 to periods do
        begin
         if not(TsOn[attday,p1-1]) then continue;
         a:=atimeslot and (1 shl p1);
         if a=0 then printw(tslotcode[p1,attday]) else  printw('-');
        end; {for p1}
       printc(Abcode[areason]+' '+Absent[areason]);
       newline;
      end; {if agen=4}

     if (agen<>7) and (agen<>4) and (anewte=te) and (akind<>1) then
      begin
       printc(PastKind(akind,anewte));
       printc(TimeSlotName[attDay,atimeslot-1]);
       printc(SubCode[asub]);
       printc(yearname[ayear]);
       printc(ChangeGen(agen,aoldte));
       newline;  found:=true;
       myallot:=getEallot(1,ayear,attday,atimeslot);
       if (akind=4) then excount:=excount+myallot;
       if (akind=2) then recount:=recount+myallot;
       if (akind=3) then incount:=incount+myallot;
       totalcount:=totalcount+myallot;
      end;

    end; {for i }
    if found then
    begin
     inc(count);
     str(daycount:3:1,tmpstr); printc('Days absent: '+tmpstr);
     str(lostAllot:3:1,tmpstr);
     printc('  Lost classes: '+inttostr(lostcount)+'  Allot: '+tmpstr); newline;
     printc('Time Allotment  ');
     str(excount:4:1,tmpstr); printc('  Extras:'+tmpstr);
     str(recount:4:1,tmpstr); printc('  Replacements:'+tmpstr);
     str(incount:4:1,tmpstr); printc('  In-lieus:'+tmpstr);
     newline; newline;
    end;
   end; {for j}
   newline;
   printw('Teachers shown: '+inttostr(count)); newline;
  end;
end;

procedure subjectExtras;
var
 i,yy,start,finish: integer;
begin
 if numabsences=0 then
 begin
  printLine(['No past extras selected.']);
  exit;
 end;
 if winpastExtrasyear=-1 then
  begin start:=years_minus_1; finish:=0; end
 else
   begin start:=winpastExtrasyear; finish:=winpastExtrasyear; end;
 count:=0;

 newline;
 for yy:=start downto finish do
 begin
  printw(yearname[yy]); count:=0;
  found:=false; old_day:=0; old_month:=0;
  for i:=1 to numabsences do
  begin
   aday:=Past[i].aday; amonth:=Past[i].amonth;  atimeslot:=Past[i].atimeslot;
   ayear:=Past[i].ayear;
   asub:=Past[i].asub;
   aoldte:=Past[i].aoldte;
   anewte:=Past[i].anewte;
   akind:=Past[i].akind;
   areason:=Past[i].areason;
   agen:=Past[i].agen;
   if (agen=4) or (agen=7) or (ayear<>yy) or (aday<1) or (aday>31)
      or (amonth<1) or (amonth>12) then continue;
   datecheck:=100*amonth+aday;
   if (datecheck<startdate) or (datecheck>enddate) then continue;
   found:=true;
   //if (old_day<>aday) or (old_month<>amonth) then
   begin printc(inttostr(aday)+' '+month[amonth]); old_month:=amonth; old_day:=aday; end;
    //else printc('');
   printc(TimeSlotName[attDay,atimeslot-1]);
   printc(SubCode[asub]);
   if (akind=1) then printc(ETname[Anewte]) else printc(tename[Anewte,0]);
   printc(ChangeGen(agen,aoldte));
   newline;
  end; {for i}
  if not(found) then
  begin
   printc('(no changes)'); newline;
  end;
  newline;
 end; {for yy}
end;

begin
 Header;
 case winView[wnPastExtras] of
  0: yearExtras;
  1: absentTeacherExtras;
  2,3: coveringteacherExtras;
  4: LostTeacherExtras;
  5: SummaryExtras;
  6: subjectExtras;
 end; {case}
 printCustomAddon;
end;

procedure pastExtrasWinOut;
begin
 OutPastWin:=TOutPastWin.Create;
 with OutPastWin do
  try
   ImplementPrint;
  finally
   OutPastWin.free;
  end;
end;

end.


