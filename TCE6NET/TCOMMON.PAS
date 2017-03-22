unit tcommon;

interface

uses
  WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Buttons,
  ExtCtrls, Dialogs, SysUtils,Messages, grids, menus, TCEglobals, Ttable, Clipbrd,
  Contnrs, XML.UTILS, GlobalToTcAndTcextra;

  function Space(StringLength: integer):string;
  function StringPad(charcount:integer; charval:integer):string;
  function StringPadChr(charcount:integer; charchr:string):string;
  function FNsub(A9,code9: integer):string;
  function FNsubname(A9,code9: integer):string;
  function Sgn(a:integer):integer;
  function RpadString(S:string; L: integer):string;
  function LpadString(S:string; L: integer):string;
  function checkCode(code: integer; var codeStr: string): integer;
  function checkfaculty(codeStr: string): integer;
  function GetDirName(var a:String):String;
  procedure getAddedStaffFontWidths;

  function findHouse2(enteredTxt: string): smallint;
  function FNupperCase(aStr: String): string;
  function findClass2(enteredTxt: string): smallint;
  function findTutor2(enteredTxt: string): smallint;
  function findRoom2(enteredTxt: string): smallint;

  procedure XrefGroupSubs;
  procedure swapint(var a:smallint; var b: smallint);
  procedure swapstr(var a:string; var b: string);
  procedure saveExtras;

  procedure topcentre(fm: Tform);
  function checkWildSub(var codeStr: string): smallint;
  procedure validateCode(code: integer; var codeStr: string);
  function findDay(s: string): integer;
  function findYear(s: string): integer;
  function byterangecheck(var i: byte; j,k: integer): integer;
  function IntRange(var i: smallint; j,k: smallint): Boolean;
  procedure singlerangecheck(var i: single; j,k: single);
  procedure studentTtablewinSelect;
  procedure restoreAnySelection(aForm: TTtablewin);
  function findFac(enteredTxt: string): integer;
  procedure teachTtablewinSelect;
  procedure TeachersFreewinSelect;
  procedure roomTtablewinSelect;
  procedure subjectTtablewinSelect;
  procedure sortCodes(code: integer);
  procedure infoWinSelect;
  procedure TeWinSelect;
  procedure getAndSetNewFont;
  procedure getPrntFontWidths(mycanvas:Tcanvas);
  procedure editcustominformation;

  procedure SubjectbySubjectListwinSelect;
  procedure SubjectbyTimeSlotwinSelect;

  procedure findTeacher(i,j: smallint; var ftc,frc: smallint; MatchALLFlg:wordbool);
  procedure findSubTeacher(var ftc,frc: integer;snu: integer);

  procedure StudentListwinSelect;
  procedure UpdateExtrasWins;

  procedure getFontWidths;
  procedure getCodeFontWidths(code: integer);
  procedure getStudentFontWidths;
  procedure getTeDutyCodeFontWidths;
  function getCoverNoteFontWidths(mycanvas:Tcanvas):smallint;
  procedure StudentQuickStreamLoad(year:smallint);
  procedure splitName(StudentI:smallint; StudentName:string);
  procedure CountChmax;
  procedure sortStudents;
  procedure ensureSizeForFont(var frm :tform);
  function findSubyear(place: smallint): smallint;
  procedure UpdateWindow(wn:smallint);
  procedure updateTallies;
  procedure setWindowDefaults(aForm: Tform; aVal: integer);
  procedure TextExportWindow(winNum: smallint);
  procedure CopyExportWindow(winNum: smallint);
    
  procedure updateTtableWindow;
  procedure TtableWinSelect;
  procedure InitTtableWin(aForm: TTtablewin);
  procedure ttCalc(ttrow,ttcol:  integer);
  procedure studentpointerset;
  procedure studentpointerfemale;
  procedure studentpointermale;
  procedure allowBinaryInputOnly(var key: char);

  procedure SetDays;
  procedure rangecheckwinpos(i: integer);

 procedure updateStatusPanel;
 procedure UpdateAllWins; {call on code changes}
 procedure UpdateStudWins; {call on student data change}
 procedure UpdateTimeTableWins; {call on timetable change}
 procedure printOurWindow(winNum: integer);
 procedure printOurWindowDetail(winNum: integer);
 procedure saveWinpos(tf: Tform);
 procedure SetTimeCell;
 procedure SetPshowMax;
 function getAbsenceFontWidths(mycanvas:Tcanvas):smallint;
 function getTemailFontWidths(mycanvas: Tcanvas):smallint;
 function getETmailFontWidths(mycanvas: Tcanvas):smallint;
 procedure TickCodeSubMenu(mitem:TMenuItem);
 procedure GetStudentTtItem(var te,su,ro,Sttyear,Sttlevel: integer;st,D,P: integer;MatchAll: boolean);
 Function GetTePoint(myte:integer): integer;
 function GetTeachTtItem(var su,ro,TeYear,TeLevel: integer;te,D,P: integer): boolean;
 function GetStudentName(st:integer):string;
 function GetRoomTtItem(var su,te,RoYear,RoLevel: integer;ro,D,P: integer): boolean;
 Function CheckStudInSub(st,sub: integer): boolean;
 procedure EmailSetupWrite;
 procedure CheckWinSelections;
 function GetLevelTtClass(MyYear,MyrollClass:integer):integer;
 function setprintertitle(winNum: integer): string;
 procedure MinCheckDoubleVal(var myDBLval: double);
 Function TeachInAnyFac(j,MyFac:smallint):boolean;
 procedure tsDaygroupCount;
 procedure tsDayGroupCalc;
  function RescanTimetable(const pStealth: Boolean = False): Boolean;
  function GetStudentHomeRoom(const pStudNo: Integer): string;
  function IsEnoughLevels: Boolean;
  function GetUsersDir: string;

type
  //YearLevel objects
  TYearLevel = class
  private
    FYear: Integer;
    FLevelSize: Integer;
  public
    property Year: Integer read FYear write FYear;
    property LevelSize: Integer read FLevelSize write FLevelSize;
  end;

  TYearLevels = class(TObjectList)
  end;

var
  YearLevels: TYearLevels;

implementation

uses    Tcgetdir, main,vwcoddlg,tcinfo,ClassDefs,
         subbysub,subbyslt,studlist,printers,
         studttab,teachtt,roomtt,subjcttt,edcustom,
         findstud,tcommon2,tcommon3,addstaff,absrsn,covnotes,
         adstfsel,abtes,newclass,lostclss,mrgclass,unavalro,roomswap,
         curextra,pstextra,findte,findro,TeWnd,TimesWnd,DCPrijndael,DCPsha1,
         tcommon5,ShowUser, AdvOfficeStatusBar, Math, TeFree, XML.EXTRAS;

procedure tsDaygroupCount;
var
 gs: array[0..nmbrdays] of smallint;
 i:     smallint;
begin
 tsNumDayGroups:=0;
for i:=1 to days do gs[i]:=0;
 for i:=1 to days do inc(gs[tsDayGroup[i-1]]);
 for i:=1 to days do if gs[i]>0 then inc(tsNumDayGroups);
end;

procedure tsDayGroupCalc;
var
 i,j,k: integer;
begin
 tsDaygroupCount;
// Calculate array
//TsDg[a,0] holds count of days in group a
//TsDg[a,1] first day in group a
 for i:=0 to nmbrdays do
  for j:=0 to nmbrdays do TsDg[i,j]:=0;

 for i:=1 to days do
  begin
   j:=tsDayGroup[i-1];
   inc(TsDg[j,0]);
   TsDg[j,TsDg[j,0]]:=i-1;
  end;

 k:=0; {pack array into lower part of dg array}
 for i:=1 to days do
  if TsDg[i,0]>0 then
   begin
    inc(k);
    for j:=0 to days do TsDg[k,j]:=TsDg[i,j];
   end;

end;

procedure SetPshowMax;
var
 d,p,tmax:      smallint;
begin
 tsShowMax:=0;  DayOfMaxPeriods:=0;
 for d:=0 to nmbrdays-1 do
  begin
   tsShowMaxDay[d]:=0;
   if ((Tlimit[d]>periods) or (Tlimit[d]<1)) then Tlimit[d]:=periods;
   for p:=0 to periods do tsShow[d,p]:=0;
  end;
 for d:=0 to days-1 do
  begin
   tmax:=0;
   for p:=0 to tlimit[d]-1 do
    if tsOn[d,p] then begin inc(tmax); tsShow[d,tmax]:=p; end;
   tsShowMaxDay[d]:=tmax;
   if tmax>tsShowMax then
    begin
     DayOfMaxPeriods:=d;
     tsShowMax:=tmax;
    end;
  end;
end;

Function TeachInAnyFac(j,MyFac:smallint):boolean;
begin
result:=((MyFac<=0) or (Tfaculty[j,1]=MyFac) or (Tfaculty[j,1]=-1)
  or (Tfaculty[j,2]=MyFac) or (Tfaculty[j,3]=MyFac) or (Tfaculty[j,4]=MyFac))
end;

procedure MinCheckDoubleVal(var myDBLval: double);
begin
  try
    if IsNaN(myDBLval) or (myDBLval<1.0e-6) then myDBLval:=0.0;
  except
  end;
end;

procedure CheckWinSelections;
var
 wn: integer;
begin
 for wn:=wnInfo to wnFindRoom do
  if wnFlag[wn] then
   case wn of
    wnTecode: if TeWindow.selcode>Numcodes[1] then TeWindow.selcode:=0;
    wnAddedStaff: if AddedStaffwin.selcode>ETnum then AddedStaffwin.selcode:=0;
    wnAbsentTe: if Absentte.selcode>Numcodes[1] then Absentte.selcode:=0;
    wnLostClass: if LostClasseswin.selcode>Numcodes[1] then LostClasseswin.selcode:=0;
    wnAddedSel: if addedstaffselwin.selcode>ETnum then addedstaffselwin.selcode:=0;
    wnUnavailRooms: if unavailablerooms.selcode>Numcodes[2] then unavailablerooms.selcode:=0;
    wnRoomSwap: if roomswaps.selcode>Numcodes[2] then roomswaps.selcode:=0;
    wnStudentList: if StudentListWin.StudSelect>NumStud then StudentListWin.StudSelect:=0;
    wnSubjectList: if SubBySubjectWin.StudSelect>NumStud then SubBySubjectWin.StudSelect:=0;
    wnTimeList: if SubByTimeSlotWin.StudSelect>NumStud then SubByTimeSlotWin.StudSelect:=0;
   end;
end;

procedure EmailSetupWrite;
var
 TempList: Tstrings;
 Cipher: TDCP_Rijndael;
 KeyStr: string;
begin
  TempList := TStringList.Create;	{ construct the list object }
  Cipher:= TDCP_Rijndael.Create(MainForm);
  try
   ChDir(Directories.datadir);
   TempList.Add(EmailHost);
   TempList.Add(EmailUserID);
   TempList.Add(EmailPassword);
   TempList.Add(EmailSend);
   TempList.Add(EmailDisplayName);
   TempList.Add(IntToStr(EmailPort));

   {encrypt}
   KeyStr:=KeyStrRt;
   Cipher.InitStr(KeyStr,TDCP_sha1);         // initialize the cipher with a hash of the passphrase
   TempList.text:= Cipher.EncryptString(TempList.text);
   Cipher.Burn;
   TempList.SaveToFile('EmailSetup.DAT');
  finally
    TempList.Free;
    Cipher.Free;
  end;
end;

Function CheckStudInSub(st,sub: integer): boolean;
var
 j,a: integer;
 found: boolean;
begin
 found:=false;
 for j:=1 to chmax do
   begin
    a:=Stud[st].choices[j];
    if a<>0 then
     if a=sub then
     begin
      found:=true;
      break;
     end;
   end; {for j}
 result:=found;
end;

procedure WinOutput(winNum: smallint);
begin
 try
  screen.cursor:=crHourglass;
  case winNum of
    wnInfo:   tcinfo.infoTextExp;   {info win}
    wnTecode: TeCodeOut; {teacher codes}
    wnAddedStaff: AddedstaffwinOut; {added staff codes}
    wnTimes: TimesWinOut;  {Times window}
    wnAbsReason: AbsReasonWinOut; {absence reasons}
    wnCoverNote: CoverNotesWinOut; {preset cover notes}
    wnAbsentTe: AbsentteOut; {absent teachers}
    wnLostClass:LostClasseswinOut; {Lost Classes}
    wnAddedSel: addedstaffselwinOut;  {added staff selection}
    wnNewClass:  NewClasseswinOut;  {new classes}
    wnMergeClass:  MergedClasseswinOut; {merged classes}
    wnUnavailRooms: unavailableroomsOut; {unavailable rooms}
    wnRoomSwap: roomswapsOut; {room swaps}
    wnCurrentExtras: CurrentExtrasWinOut;
    wnPastExtras: pastExtrasWinOut;
    wnSubjectList: subbysubOut;
    wnTimeList: subbytimeslotOut; {subjects by time slot}
    wnStudentList: StudentlistOut;
    wnStudentTt: studTtableOut;
    wnTtable: maintimetableOut;
    wnTeacherTt: teacherTtableOut;
    wnRoomTt: roomTtableOut;
    wnSubjectTt: subjectTtabletext;
    wnFindStud: findstudentOut;
    wnFindTeach: findteacherWinOut;
    wnFindRoom: findroomWinOut;
    wnShowUsers: ShowUsersWinOut;
  end; {case}
 finally
  screen.cursor:=crDefault;
 end;
end;

procedure CopyExportWindow(winNum: smallint);
begin
 try
  ClipBoard.Open;
  CopyOut:=True;
  WinOutput(winNum);
  ClipBoard.SetTextBuf(Pchar(myCopyString));
 finally
  Clipboard.Close;
  CopyOut:=False;
 end;
end;

procedure TextExportWindow(winNum: smallint);
var
 tmpStr,tmpDir:  string;
 i,txtDirtest:       smallint;
 customTitle:  string;
begin
 try
   customTitle:=setprintertitle(winNum);
   if customTitle>'' then customTitle:=' - '+customTitle;
   mainform.SaveDialog.Title:='Text file out'+customTitle;
   mainform.SaveDialog.HelpContext:=132;
   mainform.SaveDialog.Filter:='Text file|*.txt';
   mainform.SaveDialog.InitialDir:=Directories.datadir;
   mainform.SaveDialog.defaultext:='txt';
   if mainform.SaveDialog.Execute then
   begin
    tmpStr:=ExtractFileName(mainform.SaveDialog.Filename);
    i:=pos('.',tmpStr);
    tmpStr:=copy(tmpStr,1,i-1); {only want filename - no ext.}
    TextFileName:=tmpStr+'.TXT';
    tmpStr:=mainform.SaveDialog.Filename;
    tmpdir:=GetDirName(tmpStr);

    txtDirtest:=verifyUserDirectory(tmpdir);
    if txtDirtest>2 then //doesn't exist or no read/write access
    begin
     showInvalidDirectoryMsg(txtDirtest,tmpdir);
     exit;
    end;

    screen.cursor:=crHourglass;
    try
     TextFileOut:=true;
     chdir(tmpdir);
     PweekCount:=0;
     WinOutput(winNum);
    finally
     TextFileOut:=false;
     chdir(Directories.datadir);
     screen.cursor:=crDefault;
    end;
   end;

 except

 end;
end;

function GetStudentName(st:integer):string;
var
 s:string;
begin
 with Stud[st] do
 begin
   s:=stname+' '+first+'   ';
   if sTyear then s:=s+YearShort+' '+yearname[TcYear]+' ';
   if stSex then s:=s+Sex+' ';
   if stID then s:=s+ID+' ';
   if stClass then s:=s+ClassCode[Tcclass]+' ';
   if stHouse then s:=s+Housename[house]+' ';
   if stTutor then s:=s+Tecode[tutor,0]+' ';
   if stHome then s:=s+Tecode[home,1]+' ';
  end;
 result:=s;
end;

function GetRoomTtItem(var su,te,RoYear,RoLevel: integer;ro,D,P: integer): boolean;
var
 y,L: integer;
 found: boolean;
 afnt,bfnt:  tpintpoint;
begin
 found:=false;
 for y:=0 to years_minus_1 do
  begin
    afnt:=FNT(d,p,y,0,0);
    for L:=1 to level[y] do
     begin
      inc(afnt,4);
      bfnt:=afnt;
      inc(bfnt,2);
      if (ro=bfnt^) then
       begin
        found:=true;
        su:=afnt^; bfnt:=afnt; inc(bfnt);
        te:=bfnt^; royear:=y; rolevel:=L;
        break;
       end;
     end; {for L}
    if found then break;
   end; {for y}
 result:=found;
end;

function GetTeachTtItem(var su,ro,TeYear,TeLevel: integer;te,D,P: integer): boolean;
var
 y,L: integer;
 found: boolean;
 afnt,bfnt:  tpintpoint;
begin
 found:=false;
 for y:=0 to years_minus_1 do
  begin
    afnt:=FNT(d,p,y,0,0);
    for L:=1 to level[y] do
     begin
      inc(afnt,4);
      bfnt:=afnt;
      inc(bfnt);
      if (te=bfnt^) then
       begin
        found:=true;
        su:=afnt^; inc(bfnt);
        ro:=bfnt^; teyear:=y; televel:=L;
        break;
       end;
     end; {for L}
    if found then break;
   end; {for y}
 result:=found;
end;

function GetLevelTtClass(MyYear,MyrollClass:integer):integer;
var
 L,Mylevel: integer;
begin
 Mylevel:=0;
 for L:=1 to level[MyYear] do
  if ClassShown[L,MyYear]=MyrollClass then
   if trim(ClassCode[MyrollClass])<>'' then
    begin Mylevel:=L; break; end;
 result:=Mylevel;
end;

procedure GetStudentTtItem(var te,su,ro,Sttyear,Sttlevel: integer;st,D,P: integer;MatchAll: boolean);
var
 Y,lowclass,rollclass:      integer;
 found:                   boolean;

  procedure SearchLowLevel;
  var
   j,a: integer;
  begin
   for j:=1 to nmbrChoices do
    begin
     a:=Stud[st].Choices[j];
     if a<>0 then if a=FNT(D,P,Y,lowclass,0)^ then
     begin
      found:=true; Sttyear:=Y; Sttlevel:=lowclass;
      break;
     end;
    end;
  end;

  procedure SearchYear;
  var
   j,L,a: integer;
  begin
   for j:=1 to nmbrChoices do
   begin
    a:=Stud[st].Choices[j];
    if a<>0 then
     for L:=1 to level[Y] do
      if a=FNT(D,P,Y,L,0)^ then
      begin
       found:=true;  Sttyear:=Y; Sttlevel:=L;
       break;
      end;
    if found then break;
   end; {for j}
  end;

begin
 te:=0; su:=0; ro:=0;
 Sttyear:=0; Sttlevel:=0; rollclass:=Stud[st].Tcclass;
 found:=false;
 Y:=Stud[st].TcYear;    {search studs own year first}
 lowclass:=GetLevelTtClass(Y,rollclass);
 if lowClass>0 then SearchLowLevel;
 if not(found) then SearchYear;
 if (not(found)) and MatchAll then
  for Y:=years_minus_1 downto 0 do
   begin
    lowclass:=GetLevelTtClass(Y,rollclass);
    if lowClass>0 then SearchLowLevel;
    if not(found) then SearchYear;
    if found then break;
   end;
 if found then
  begin
   su:=FNT(D,P,Sttyear,Sttlevel,0)^;
   te:=FNT(D,P,Sttyear,Sttlevel,2)^;
   ro:=FNT(D,P,Sttyear,Sttlevel,4)^;
  end;
end;

Function GetTePoint(myte:integer): integer;
var
 k,Mytepoint: integer;
begin
 Mytepoint:=0;
 for k:=1 to codenum[1] do
  if codepoint[k,1]=myte then
    begin Mytepoint:=k; break end;
 result:=Mytepoint;
end;

procedure TickCodeSubMenu(mitem:TMenuItem);
begin
 if mitem.count>0 then
  begin
   mitem.items[0].Checked:=wnFlag[wnTeCode];
   mitem.items[1].Checked:=wnFlag[wnAddedStaff];
   mitem.items[2].Checked:=wnFlag[wnTimes];
   mitem.items[3].Checked:=wnFlag[wnAbsReason];
   mitem.items[4].Checked:=wnFlag[wnCoverNote];
  end;
end;

procedure updateTallies;
var
 f:       file;
 astr:    string;
 i,j:     integer;
begin
 try
  chdir(Directories.datadir);
  doAssignFile(f,'TEAVAIL.DAT');
  try
   filemode:=fmOpenReadWrite+fmShareDenyWrite;
   rewrite(f,1);
   aStr:='TCE5';
   blockwrite(f,aStr[1],4);
   if numcodes[1]>0 then
    for i:=1 to numcodes[1] do
     begin
      blockwrite(f,Emax[i],8);      blockwrite(f,Etaken[i],8);
      blockwrite(f,Elieu[i],8);     blockwrite(f,Elieutaken[i],8);
      blockwrite(f,Ereplace[i],8);
      blockwrite(f,Eweek[i],8);     blockwrite(f,Eday[i],2);
      blockwrite(f,Emonth[i],2);
      for j:=1 to nmbrLikePreferences do
       begin
        blockwrite(f,LikEday[i,j],2);
        blockwrite(f,LikeTime[i,j],2);
       end;  {for j}
      blockwrite(f,Eten[i],2);
      aStr:=Ecomment[i]; aStr:=RpadString(aStr,szEcomment);
      blockwrite(f,aStr[1], szEcomment);
      //BlockWrite(f, EUserChanged[1], 2);
     end; {for i}

  finally
   closefile(f);
   NEW_DateChecks[3]:=FileDateToDateTime(fileage('TEAVAIL.DAT'));
  end; {try}
 except
 end;
end;

function findTutor2(enteredTxt: string): smallint;
var
 aStr:   string;
 j,aLen:       smallint;
begin
 aStr:=UpperCase(trim(enteredTxt));
 aLen:=Length(aStr);   j:=0;
 if aLen>0 then j:=checkCode(1,aStr);
 result:=j;
end;

function findRoom2(enteredTxt: string): smallint;
var
 aStr:   string;
 j,aLen:       smallint;
begin
 aStr:=UpperCase(trim(enteredTxt));
 aLen:=Length(aStr);   j:=0;
 if aLen>0 then j:=CheckCode(2,aStr);
 result:=j;
end;

function findHouse2(enteredTxt: string): smallint;
var
 aStr,bStr:   string;
 i,j,aLen:       smallint;
begin
 aStr:=UpperCase(trim(enteredTxt));
 aLen:=length(aStr);   j:=0;
 if aLen>0 then
  for i:=1 to housecount do
  begin
   bStr:=UpperCase(copy(HouseName[i],1,aLen));
   if aStr=bStr then
   begin
    j:=i;
    break;
   end;
  end; {for i}
 result:=j;
end;

procedure splitStreamName(StudentI:smallint; StudentName:string);
var
 strA,strB:  string;
 stpos,stpos1:     smallint;
begin
 StudentName:=trim(StudentName);
 strA:=StudentName;
 stpos:=pos(' ',strA);
 strB:=copy(strA,stpos+1,length(strA));
 stpos1:=stpos;
 while stpos1>0 do
 begin
  stpos1:=pos(' ',strB);
  strB:=copy(strB,stpos1+1,length(strB));
  stpos:=stpos+stpos1;
 end;
 Stud[StudentI].StName:=copy(strA,1,stpos-1);
 Stud[StudentI].First:=copy(strA,stpos+1,length(strA));
end;

procedure StudentQuickStreamLoad(year:smallint);
   var
    tmpfilename:   string;
    YearDigit:     string[2];
    FFileHandle:   THandle;
    FMapHandle:    THandle;
    FFileSize:     integer;
    FData,FDataStrt:         ^Byte;
    FDataPntrChk:  integer;

       function getbyte:byte;
       begin
        inc(FDataPntrChk);
        if FDataPntrChk>FFileSize then
        begin  {preventing old read beyond eof becoming a major gpf problem ???}
         result:=0; exit;
        end;
        result:=byte(FData^);
        inc(FData);
       end;

       function getINT:word;
       var
        i1,i2:smallint;
       begin
        i1:=getbyte; i2:=getbyte;
        result:=i1+(i2*256);
       end;

       function getStr(a:smallint): string;
       var
        i: smallint;
        s: string;
       begin
        s:='';
        for i:=1 to a do
         s:=s+chr(getbyte);
        result:=s;
       end;

     procedure getQuickStreamOldStudentFormat;
     var
      i,i1,j:     longint;
      strA,astr:    string;
     begin
      YearStat[year].RecordSize:=75;
      try
         YearStat[year].numstud:=getINT; IntRange(YearStat[year].numstud,0,nmbrStudents);
         setlength(Stud,(YearStat[year].numstud+numstud+1)); {zero based so +1}
         YearStat[year].chmax:=getINT; IntRange(YearStat[year].chmax,0,nmbrChoices);
         YearStat[year].IDlen:=getINT; IntRange(YearStat[year].IDlen,0,szID);
         YearStat[year].RecordSize:=getINT;
        if YearStat[year].numstud>0 then
        begin
         for i:=1 to YearStat[year].numStud do
         begin
          FData:=FDataStrt; i1:=i+numstud;
          inc(FData,(i*YearStat[year].RecordSize));
          FDataPntrChk:=(i*YearStat[year].RecordSize);
          astr:=getStr(25);
          strA:=trim(strA); splitStreamName(i1,strA);
          for j:=1 to nmbrchoices do Stud[i1].choices[j]:=0;
          for j:=1 to YearStat[year].chmax do
           Stud[i1].choices[j]:=getINT;
          Stud[i1].Sex:=chr(getbyte);
          Stud[i1].TcClass:=getINT;
          Stud[i1].House:=getINT;
          astr:=getStr(YearStat[year].IDlen);
          Stud[i1].ID:=trim(aStr);
          Stud[i1].TcYear:=year;
          Stud[i1].Tutor:=0;Stud[i1].Home:=0;
          Stud[i1].TcTag:=0;Stud[i1].StrRecord:=0;
         end;
        end; {if}
      except

      end;
     end;

     procedure getQuickStreamNewStudentFormat;
     var
      i,i1,j,ai:     longint;
      astr:    string;
     begin
      YearStat[year].RecordSize:=98;
      try
         YearStat[year].numstud:=getINT; IntRange(YearStat[year].numstud,0,nmbrStudents);
         setlength(Stud,(YearStat[year].numstud+numstud+1)); {zero based so +1}
         YearStat[year].chmax:=getINT; IntRange(YearStat[year].chmax,0,nmbrChoices);
         YearStat[year].IDlen:=getINT; IntRange(YearStat[year].IDlen,0,szID);
         YearStat[year].RecordSize:=getINT;

        if YearStat[year].numstud>0 then
         for i:=1 to YearStat[year].numstud do
         begin
          FData:=FDataStrt;i1:=i+numstud;
          inc(FData,(i*YearStat[year].RecordSize));
          FDataPntrChk:=(i*YearStat[year].RecordSize);
          astr:=getStr(20); Stud[i1].StName:=trim(aStr);
          astr:=getStr(20); Stud[i1].First:=trim(aStr);
          for j:=1 to nmbrchoices do Stud[i1].choices[j]:=0;
          for j:=1 to YearStat[year].chmax do
           Stud[i1].choices[j]:=getINT;
          ai:=getbyte;
          Stud[i1].Sex:=chr(ai);
          Stud[i1].TcClass:=getINT;
          Stud[i1].House:=getINT;
          if YearStat[year].IDlen>0 then astr:=getStr(YearStat[year].IDlen)
           else astr:='';
          Stud[i1].ID:=trim(aStr);
          Stud[i1].Tutor:=getINT;
          Stud[i1].Home:=getINT;
          Stud[i1].TcTag:=getINT;
          Stud[i1].strRecord:=smallint(getINT);
          Stud[i1].TcYear:=year;
         end; {for i}
      except

      end;
     end;


     procedure getQuickStreamNewStudentFormat6;
     var
      i,i1,j,ai:     longint;
      astr:    string;
     begin
      YearStat[year].RecordSize:=123;
      try
         YearStat[year].numstud:=getINT; IntRange(YearStat[year].numstud,0,nmbrStudents);
         setlength(Stud,(YearStat[year].numstud+numstud+1)); {zero based so +1}
         YearStat[year].chmax:=getINT; IntRange(YearStat[year].chmax,0,nmbrChoices);
         YearStat[year].IDlen:=getINT; IntRange(YearStat[year].IDlen,0,szID);
         YearStat[year].RecordSize:=getINT;

        if YearStat[year].numstud>0 then
         for i:=1 to YearStat[year].numstud do
         begin
          FData:=FDataStrt;i1:=i+numstud;
          inc(FData,(i*YearStat[year].RecordSize));
          FDataPntrChk:=(i*YearStat[year].RecordSize);
          astr:=getStr(30); Stud[i1].StName:=trim(aStr);
          astr:=getStr(30); Stud[i1].First:=trim(aStr);
          for j:=1 to nmbrchoices do Stud[i1].choices[j]:=0;
          for j:=1 to YearStat[year].chmax do
           Stud[i1].choices[j]:=getINT;
          ai:=getbyte;
          Stud[i1].Sex:=chr(ai);
          Stud[i1].TcClass:=getINT;
          Stud[i1].House:=getINT;
          if YearStat[year].IDlen>0 then astr:=getStr(YearStat[year].IDlen)
           else astr:='';
          Stud[i1].ID:=trim(aStr);
          Stud[i1].Tutor:=getINT;
          Stud[i1].Home:=getINT;
          Stud[i1].TcTag:=getINT;
          Stud[i1].strRecord:=smallint(getINT);
          Stud[i1].TcYear:=year;
         end; {for i}
      except

      end;
     end;

begin
   chdir(Directories.datadir);
   FMapHandle:=0;
   YearStat[year].numstud:=0; YearStat[year].chmax:=20; YearStat[year].IDlen:=5;
   YearStat[year].Namelen:=0; YearStat[year].MaleNum:=0; YearStat[year].FemaleNum:=0;
   YearDigit:=inttostr(year+1);  YearDigit:=trim(YearDigit);
   tmpfilename:='CHOICE'+YearDigit+'.ST';
   if fileexists(tmpfilename) then
     begin
      try
        {mem map file}
         FFileHandle:=FileOpen(tmpfilename,(fmOpenRead + fmShareDenyNone));
         FDataPntrChk:=0;
         FFileSize:=GetFileSize(FFileHandle,Nil);
         try
          try
           FMapHandle:=CreateFileMapping(FFileHandle,nil,PAGE_READONLY,0,FFileSize,nil);
           FData:=MapViewOfFile(FMapHandle,FILE_MAP_READ,0,0,FFileSize);
          finally
           dbgbool:=CloseHandle(FMapHandle);
          end;
         finally
          dbgbool:=CloseHandle(FFileHandle);
         end;

         try
          FDataStrt:=FData;
          {use FData in here as ^byte}
           TC4fileHeader:=getStr(4);
           if TC4fileHeader = 'TCV6' then
           begin
             getQuickStreamNewStudentFormat6;
           end else begin
             if TC4fileHeader = 'TCV4' then
             begin
               getQuickStreamNewStudentFormat;
             end else begin
               if (FFileSize>=4) then dec(FData,4);
               getQuickStreamOldStudentFormat;
             end;
           end;
     {
          TC4fileHeader:=getStr(4);
          if TC4fileHeader<>'TCV4' then
          begin
           if (FFileSize>=4) then dec(FData,4);
           getQuickStreamOldStudentFormat;
          end
          else
           getQuickStreamNewStudentFormat;
     }
         finally
          dbgbool:=UnmapViewOfFile(FDataStrt);  {not FData as it has changed by now}
          dbgdword:=getlasterror();
         end;

      except
      end;
      setlength(StGroup,(YearStat[year].numStud+numstud+1)); {zero based so +1}
      setlength(StPointer,(YearStat[year].numStud+numstud+1)); {zero based so +1}
     end;
  numstud:=numstud+YearStat[year].numstud;
  if YearStat[year].chmax >chmax then  chmax:=YearStat[year].chmax;
end;

procedure saveExtras;
var
 i:       integer;
 fname,tname,tmpstr:   string;
 // convert EXTRAS.XTR to EXTRAS.XML
begin
 if (usrPasslevel=0) then exit;
 try
  try
   chdir(Directories.datadir);
   screen.cursor:=crHourglass;
   saveExtras_xml(exfile);  //mantis-ak-1627
   //exit; //commented mantis-ak-1627
   // redundant since switch to XML
   fname:=exfile+'.XTR';
   tname:=exfile+'.TMP';
   tmpstr:='TCE5';
   ourSafetyMemStreamStr:='';
   ourSafetyMemStream:=TStringStream.Create(ourSafetyMemStreamStr);
//   setlength(ourSafetyMemStreamStr,9999);
   with ourSafetyMemStream do
    begin                                     
     Write(Pchar(@tmpstr[1])^,4);
     Write(exday,2);
     Write(exmonth,2);
     Write(exyear,2);
     Write(ttday,2);
     Write(numcodes[1],2);
     if numcodes[1]>0 then
      for i:=1 to numcodes[1] do
       begin
        Write(teon[i],4);
        Write(teAbsent[i],4);
        Write(telost[i],4);
        Write(tecover[i],4);
        Write(tereplace[i],4);
        Write(telieu[i],4);
        Write(teavail[i],8);
        Write(telieudbl[i],8);
        Write(tabsreason[i],2);
       end;
       Write(ETnum,2);
       if ETnum>0 then
        for i:=1 to ETnum do
        begin
         Write(Etlink[i],2);
         Write(ETon[i],4);
         Write(ETavail[i],4);
         Write(Etmax[i],8);
        end;
       Write(numcodes[2],2);
       if numcodes[2]>0 then
        for i:=1 to numcodes[2] do
        begin
         Write(roomon[i],4);
         Write(roAbsent[i],4);
         Write(roswap[i],4);
         Write(rocover[i],4);
         Write(rolost[i],4);
        end;
       Write(numchanges,2);
       if numchanges>0 then
        for i:=1 to numchanges do
         Write(Pchar(@Changes[i])^,Change5RecSize);
       Write(notenum,2);
       if notenum>0 then
        for i:=1 to notenum do
        begin
         ExNote[i]:=Rpadstring(ExNote[i],szNote);
         Write(Pchar(@(ExNote[i][1]))^,szNote);
        end;
    end; {with ourSafetyMemStream}

  SafelyStreamToFile(tname,fname);

  finally
   screen.cursor:=crDefault;
   ourSafetyMemStream.Free;
   NEW_DateChecks[9]:=FileDateToDateTime(fileage(fname));
  end;
 except

 end;
end;

function Sgn(a:integer):integer;
begin
 result:=0;
 if (a>0) then result:=1;
 if (a<0) then result:=-1;
end;

procedure studentPointerFemale;
var
 i8,i9,pos:     smallint;
begin
 pos:=1;
 for i9:=1 to GroupNum do
 begin
  i8:=StGroup[i9];
  if Stud[i8].Sex='F' then
  begin
   StPointer[pos]:=i8;
   inc(pos);
  end;
 end; {for i9}
(* sexGap:=pos;  *)
 for i9:=1 to GroupNum do
 begin
  i8:=StGroup[i9];
  if Stud[i8].Sex='M' then
  begin
   StPointer[pos]:=i8;
   inc(pos);
  end;
 end; {for i9}
end;

procedure studentPointerMale;
var
 i8,i9,pos:     smallint;
begin
 pos:=1;
 for i9:=1 to GroupNum do
 begin
  i8:=StGroup[i9];
  if Stud[i8].Sex='M' then
  begin
   StPointer[pos]:=i8;
   inc(pos);
  end;
 end; {for i9}
(* sexGap:=pos; *)
 for i9:=1 to GroupNum do
 begin
  i8:=StGroup[i9];
  if Stud[i8].Sex='F' then
  begin
   StPointer[pos]:=i8;
   inc(pos);
  end;
 end; {for i9}
end;

procedure studentPointerSet;
var
 i:     smallint;
begin
 try
  setlength(StPointer,(numStud+1)); {zero based so +1}
  case sexSelect of
   0: for i:=1 to numStud do StPointer[i]:=StGroup[i];
   1: studentpointerfemale;
   2: studentpointermale;
  end; {case}
 except
 end;
end;

function findDay(s: string): integer;
var
 i:  integer;
begin
 result:=-1;
 s:=trim(s);
 if s='' then exit;
 for i:=0 to days-1 do
   if pos(UpperCase(s),UpperCase(Day[i]))>0 then
     begin
       result:=i;
       break;
     end;
end;

function findYear(s: string): integer;
var
 i:  integer;
begin
 result:=-1;
 s:=trim(s);
 if s='' then exit;
 for i:=0 to years-1 do
   if pos(UpperCase(s),UpperCase(yearname[i]))>0 then
     begin
       result:=i;
       break;
     end;
end;

procedure topcentre(fm: Tform);
begin
 fm.top:=0;
 fm.left:=(screen.width-fm.width) div 2;
end;

procedure setdays;
var
 i: integer;
begin
  for i := 0 to 10 do
    Day[i] := Dayname[i];
 if days=5 then       {later comment-21/02/2017}
 begin
  Day[0]:='MON. ';
  Day[1]:='TUE. ';
  Day[2]:='WED. ';
  Day[3]:='THU. ';
  Day[4]:='FRI. ';
  for i:=5 to 10 do
   Day[i]:='';
 end
 else
  for i:=0 to 10 do
   Day[i]:='DAY'+inttostr(i+1); 
end;

procedure SetTimeCell;

 procedure SetCell(var d,p,y,l: byte);
 begin
  if d>=days then d:=days-1;
  if p>=Tlimit[d] then p:=Tlimit[d]-1;
  if y>=years then y:=years-1;
  if l<1 then l:=1;
  if l>level[y] then l:=level[y];
 end;
begin
 SetCell(dl,pl,yl,ll);
 SetCell(nd,np,ny,nl);
 SetCell(hd,hp,hy,hl);
end;

procedure singlerangecheck(var i: single; j,k: single);
begin
 try
  if i<j then i:=j
   else if i>k then i:=k;
 except
  on EInvalidOp do i:=j;
 end; {try}
end;

function IntRange(var i: smallint; j, k: smallint): Boolean;
begin
  Result := True;
  if i < j then
  begin
    i := j;
    Result := False;
  end
  else if i > k then
  begin
    i := k;
    Result := False;
  end;
end;

function byterangecheck(var i: byte; j,k: integer):integer ;
begin
 result:=0;
 if i<j then begin i:=j; result:=1; end
  else if i>k then begin i:=k; result:=2; end;
end;

procedure rangecheckwinpos(i: integer);
var
 j:       smallint;
begin
 j:=integer(winpos[i].state);
 IntRange(j,0,2);
 winpos[i].state:=Twindowstate(j);
 IntRange(winpos[i].width,0,mainform.clientwidth);
 IntRange(winpos[i].height,0,mainform.clientheight);
 IntRange(winpos[i].top,0,mainform.clientheight);
 IntRange(winpos[i].left,0,mainform.clientwidth);
end;

procedure saveWinpos(tf: Tform);
begin
 winpos[tf.tag].state:=tf.windowstate;
 tf.windowstate:=wsNormal;         {avoiding having max'd wins on restore}
 winpos[tf.tag].top:=tf.top;       {doesn't look good-  lots of flashing}
 winpos[tf.tag].left:=tf.left;
 winpos[tf.tag].width:=tf.width;
 winpos[tf.tag].height:=tf.height;
end;

procedure getprinterDPI(mycanvas:Tcanvas);
var
 dpix,dpiy:       integer;
 tmpHdc:  Hdc;
 t1,t2:   single;
begin
  tmpHdc:=mycanvas.handle;
  dpix:=getdevicecaps(tmpHdc,88);
  dpiy:=getdevicecaps(tmpHdc,90);
  t1:=dpix;
  t2:=dpiy;
  t1:=(prntLeftMargin/2.54)*t1;  {(cm/(cm/inch))*DPI=no. of pixels}
  prntHmargin:=integer(trunc(t1));
  t2:=(prntTopMargin/2.54)*t2;
  prntVmargin:=integer(trunc(t2));
end;

function findClass2(enteredTxt: string): smallint;
var
 aStr,bStr:   string;
 i,j,aLen,bLen,mLen:       smallint;
begin
 aStr:=UpperCase(trim(enteredTxt));
 aLen:=length(aStr);   j:=0;  mLen:=99;
 if classnum>0 then
  if aLen>0 then
   for i:=classnum downto 1 do
   begin
    bStr:=UpperCase(trim(ClassCode[i]));
    bLen:=length(bStr);
    bStr:=copy(bStr,1,aLen);
    if aStr=bStr then
    begin
     if bLen<=mLen then
     begin
      mLen:=bLen;  //keep only minimum match
      j:=i;
      if aLen=bLen then break;  //continue search unless perfect match found
     end;
    end;
   end; {for i}
 result:=j;
end;

function setprintertitle(winNum: integer): string;
var
 tmpStr:  string;
begin
 tmpStr:='';    {default, only there incase i miss one}
 case winNum of
  wnInfo: tmpStr:='Information';
  wnTecode: tmpStr:='Teacher Codes';
  wnAddedStaff: tmpStr:='Added Staff Codes';
  wnTimes: tmpStr:='Times List';
  wnAbsReason: tmpStr:='Absence Reasons';
  wnCoverNote: tmpStr:='Cover Notes';
  wnAbsentTe: tmpStr:='Absent Teachers';
  wnNewClass: tmpStr:='New Classes';
  wnLostClass: tmpStr:='Lost Classes';
  wnMergeClass: tmpStr:='Merged Classes';
  wnUnavailRooms: tmpStr:='Unavailable Rooms';
  wnRoomSwap: tmpStr:='Room Swaps';
  wnAddedSel: tmpStr:='Added Staff Selections';
  wnCurrentExtras: tmpStr:='Current Extras';
  wnPastExtras: tmpStr:='Past Extras';
  wnSubjectList: tmpStr:='Subject List by Subject';
  wnTimeList: tmpStr:='Subject List by Time Slot';
  wnStudentList: tmpStr:='Student List';
  wnStudentTt: tmpStr:='Student Timetable';
  wnTtable: tmpStr:='Main Timetable';
  wnTeacherTt: tmpStr:='Teacher Timetable';
  wnRoomTt: tmpStr:='Room Timetable';
  wnSubjectTt: tmpStr:='Subject Timetable';
  wnFindStud: tmpStr:='Find Student';
  wnFindTeach: tmpStr:='Find Teacher';
  wnFindRoom: tmpStr:='Find Room';
  wnShowUsers: tmpStr:='Show Users';
 end; {case}
 result:='Time Chart Extra '+tmpStr;
end;

procedure printOurWindowDetail(winNum: integer);
begin
 PweekCount:=0;
 case winNum of
  wnInfo:   tcinfo.infoprint;   {info win}
  wnTeCode: TeCodePrint;
  wnTimes: TimesWinPrint;
  wnTtable:   ttable.maintimetableprint; {main timetable}
  wnSubjectList:  subbysub.subbysubprint; {subject list by subject}
  wnTimeList:  subbyslt.subbytimeslotprint; {subject list by time slot}
  wnStudentList:  studlist.Studentlistprint; {student list}
  wnTeacherTt:  teachtt.teacherTtableprint; {teacher ttable}
  wnRoomTt:  roomtt.roomTtableprint; {room ttable}
  wnSubjectTt:  subjcttt.subjectTtableprint; {subject ttable}
  wnStudentTt:  studttab.studTtableprint; {student ttable}
  wnFindStud:  findstud.FindStudentprint; {student find (tt)}
  wnAbsReason:  absrsn.AbsReasonWinprint;  {absence reasons}
  wnCoverNote:  covnotes.covernoteswinprint; {cover notes}
  wnAddedStaff:  addstaff.Addedstaffwinprint; {added staff codes}
  wnAbsentTe:  abtes.Absentteprint; {absent teachers}
  wnNewClass:  newclass.NewClasseswinprint; {new classes}
  wnLostClass:  lostclss.LostClasseswinprint; {lost classes}
  wnMergeClass:  mrgclass.MergedClasseswinprint; {merged classes}
  wnUnavailRooms:  unavalro.unavailableroomsprint; {unavailable rooms}
  wnRoomSwap:  roomswap.roomswapsprint; {room swaps}
  wnCurrentExtras:  Curextra.CurrentExtrasWinprint; {current extras}
  wnAddedSel:  adstfsel.addedstaffselwinprint;  {added staff selection}
  wnPastExtras:  pstextra.pastExtrasWinprint; {past extras}
  wnFindTeach:  findte.findteacherWinprint; {find te}
  wnFindRoom:  findro.findroomWinprint; {find ro}
  wnShowUsers: ShowUsersWinPrint;
 end; {case}

end;

procedure printOurWindow(winNum: integer);
begin
 if printer.printing then exit;
 if mainform.printdialog.execute then
  try
   screen.cursor:=crHourglass;
   printer.title:=setprintertitle(winNum);
   printer.begindoc;
   printer.canvas.font.assign(tcfont);
   getPrntFontWidths(Printer.canvas);
   getprinterDPI(Printer.canvas);
   PrinterOn:=true;
   printOurWindowDetail(winNum);
   printer.enddoc;
  finally
   printer.title:='';
   printerOn:=false;
   screen.cursor:=crDefault;
  end;
end;

procedure allowBinaryInputOnly(var key: char);
begin
 if ((key<>'0') and (key<>'1')) then if ord(key)>32 then key:=chr(0);
end;

procedure UpdateAllWins; {call on code changes}
var
 i:       integer;
begin
 try
  screen.cursor:=crHourglass;
   displayCounts;
   merge_classes;
   new_classes;
  updateteacherMap;
  updateRoomMap;
  for i:=wnInfo to wnFindRoom do UpdateWindow(i);
  MainForm.UpdateToolbarIcons;
  updateStatusPanel;
  updateTtableWindow;
 finally
  screen.cursor:=crDefault;
 end;
end;

procedure UpdateExtrasWins;
const
 WinSet=[wnCurrentExtras,wnPastExtras,wnFindStud,wnFindTeach,wnFindRoom,
   wnAbsentTe,wnAddedSel,wnAddedStaff,wnLostClass,wnUnavailRooms,wnRoomSwap,
   wnMergeClass,wnNewClass,wnInfo];
var
 i: smallint;
begin
 try
  screen.cursor:=crHourglass;
  updateteacherMap;
  updateRoomMap;
  for i:=1 to nmbrWindows do if i in WinSet then UpdateWindow(i);
  MainForm.UpdateToolbarIcons;
  updateStatusPanel;
 finally
  screen.cursor:=crDefault;
 end;
end;

procedure UpdateStudWins; {call on student data change}
begin
 try
  screen.cursor:=crHourglass;
  updateStatusPanel;
  updateWindow(wnStudentList);
  UpdateWindow(wnStudentTt);
  UpdateWindow(wnTimeList);
  UpdateWindow(wnSubjectList);
  UpdateWindow(wnFindStud);
  if eplist then UpdateWindow(wnCurrentExtras);
 finally
  screen.cursor:=crDefault;
 end;
end;

procedure UpdateTimeTableWins; {call on timetable change}
const
 WinSet=[wnStudentList,wnStudentTt,wnTeacherTt,wnRoomTt,wnSubjectTt,wnTimeList,
         wnSubjectList,wnFindStud];
var
 i: smallint;
begin
 try
  screen.cursor:=crHourglass;
  updateStatusPanel;
  for i:=1 to nmbrWindows do if i in WinSet then UpdateWindow(i);
  updateTtableWindow;
 finally
  screen.cursor:=crDefault;
 end;
end;

procedure findSubTeacher(var ftc,frc: integer;snu: integer);
var
 i,p,L,d,y,max: integer;
 yrUsed:    array[0..nmbryears] of boolean; //only check year if true
 tc,rc,sc:       smallint;
 found:boolean;
 FirstTe,FirstRo:      smallint;
 multTeCount,multRoCount: array of smallint; //count for each teacher and room

 procedure SubOnTt(d,p,y,l:smallint);
 var
  fntA:    tpintpoint;
 begin
  fntA:=FNT(D,P,y,L,0);
  sc:=word(fntA^);
  if sc=snu then
    begin
     inc(fntA); tc:=word(fntA^);
     inc(fntA); rc:=word(fntA^);
     if ((tc>0) and (tc<=NumCodes[1]))  then
      begin
       if firstTe=0 then FirstTe:=tc;
       inc(multTeCount[tc]);
       found:=true;
      end;
     if ((rc>0) and (rc<=NumCodes[2])) then
      begin
       if firstRo=0 then FirstRo:=rc;
       inc(multRoCount[rc]);
      end;
    end;
 end;

begin
 for i:=0 to nmbryears do yrUsed[i]:=false;
 tc:=0;  rc:=0;   FirstTe:=0;  FirstRo:=0; found:=false;
 SetLength(multTeCount,2+NumCodes[1]);  SetLength(multRoCount,2+NumCodes[2]);
 for i:=0 to NumCodes[1] do multTeCount[i]:=0;
 for i:=0 to NumCodes[2] do multRoCount[i]:=0;

 for i:=1 to groupnum do yrUsed[Stud[StGroup[i]].TcYear]:=true;

 for d:=0 to days-1 do
  for p:=0 to tlimit[d]-1 do
   for y:=years_minus_1 downto 0 do
    if yrUsed[y] then
     for l:=1 to level[y] do SubOnTt(d,p,y,l);

 if not(found) and MatchAllYears then {check for match on all years}
  for y:=years_minus_1 downto 0 do
   for d:=0 to days-1 do
    for p:=0 to tlimit[d]-1 do
     for l:=1 to level[y] do SubOnTt(d,p,y,l);

 ftc:=FirstTe; max:=multTeCount[FirstTe];
 for i:=1 to NumCodes[1] do
  if multTeCount[i]>max then
   begin ftc:=i; max:=multTeCount[i]; end;

 frc:=FirstRo; max:=multRoCount[FirstRo];
 for i:=1 to NumCodes[2] do
  if multRoCount[i]>max then
   begin frc:=i; max:=multRoCount[i]; end;

end; {end of local proc}

procedure findTeacher(i,j: smallint; var ftc,frc: smallint; MatchALLFlg:wordbool);
var
 found:          bool;
 tc,rc,sc:       smallint;
 p,y,l,d,k:        smallint;
 max: integer;
 class1,lowClass,snu,FirstTe,FirstRo:         smallint;
 multTeCount: array[0..nmbrTeachers]of smallint; //count for each te
 multRoCount: array[0..nmbrTeachers]of smallint; //count for each te

 procedure SubOnTt(d,p,y,l:smallint);
 begin
  sc:=word((FNT(d,p,y,l,0))^);
  if sc=snu then
    begin
     tc:=word((FNT(d,p,y,l,2))^);
     rc:=word((FNT(d,p,y,l,4))^);
     if tc>0 then
      begin
       if firstTe=0 then FirstTe:=tc;
       inc(multTeCount[tc]);
       found:=true;
      end;
     if rc>0 then
      begin
       if firstRo=0 then FirstRo:=rc;
       inc(multRoCount[rc]);
      end;
    end;
 end;

begin
 found:=false;  ftc:=0; frc:=0; FirstTe:=0;  FirstRo:=0;
 Y:=Stud[i].TcYear;
 snu:=Stud[i].Choices[j];
 class1:=Stud[i].TcClass;
 for k:=0 to nmbrTeachers do multTeCount[k]:=0;
 for k:=0 to nmbrTeachers do multRoCount[k]:=0;
 lowclass:=GetLevelTtClass(Y,class1);

 if lowclass>0 then   {check for match on this level}
  for d:=0 to days-1 do
   for p:=0 to tlimit[d]-1 do SubOnTt(d,p,y,lowclass);

 if not(found) then {check for match on year}
  for d:=0 to days-1 do
   for p:=0 to tlimit[d]-1 do
    for l:=1 to level[y] do SubOnTt(d,p,y,l);

 if not(found) and MatchALLFlg then {check for match on all years}
  for y:=years_minus_1 downto 0 do
   for d:=0 to days-1 do
   for p:=0 to tlimit[d]-1 do
    for l:=1 to level[y] do SubOnTt(d,p,y,l);

 ftc:=FirstTe; max:=multTeCount[FirstTe];
 for k:=1 to NumCodes[1] do
  if multTeCount[k]>max then
   begin ftc:=k; max:=multTeCount[k]; end;


 frc:=FirstRo; max:=multRoCount[FirstRo];
 for k:=1 to NumCodes[2] do
  if multRoCount[k]>max then
   begin frc:=k; max:=multRoCount[k]; end;

end;

function GetDirName(var a:String):String;
begin
 result:=ExtractFilePath(a);
 if ((result[length(result)]='\') and (result[length(result)-1]<>':')) then
  SetLength(result,Length(result)-1);
end;

procedure updateStatusPanel;
var
  teNeeded2,roNeeded2: Integer;
  i,j: Integer;
  TmpStr: string;
  TmpStr2: string;
begin
  j := 0;
  ///mainform.panel2.caption:=' File: '+exfile+'   '+' Day: '+day[ttday]
       ///+' '+inttostr(exday)+' '+month[exmonth]+' '+formatdatetime('yyyy',now);

  MainForm.stbMain.Panels[1].Text := ' File: '+exfile+'   '+' Day: '+day[ttday] +' '+inttostr(exday)+' '+month[exmonth]+' '+formatdatetime('yyyy',now);
  //mainform.panel3.hint:='';
  tmpstr2:='';
  updateIgnoreChangesCount;
  teNeeded2 := 0; roNeeded2 := 0;
  if numchanges > 0 then
  for i := 1 to numchanges do
  begin
    if Changes[i].kind>9 then continue; {ignore ignored changes}
    if Changes[i].timeslot<=tlimit[ttday] then    {only for tslots shown as in cols}
    begin
      if boolean(Changes[i].needte) then inc(teNeeded2);
      if (Changes[i].needroom=1) then inc(roNeeded2);
    end;
  end; {for i}

  if ((teNeeded2=0) and (roNeeded2=0)) then j:=1;
  if (teNeeded2>0) then j:=2;
  if (roNeeded2>0) then j:=3;
  if ((teNeeded2>0) and (roNeeded2>0)) then j:=4;
  if numchanges=0 then j:=0;

  case j of
    0: tmpstr:='No changes';
    1: tmpstr:='All changes covered';
    2: tmpstr:='Teachers needed';
    3: tmpstr:='Rooms needed';
    4: tmpstr:='Teachers and Rooms needed';
  end; {case}
  case j of
    0,1: MainForm.stbMain.panels[2].AppearanceStyle := psDark;
  ///mainform.panel3.font.color:=clblack;
    2,3,4:
    begin
      ///mainform.panel3.font.color:=clred;
      MainForm.stbMain.panels[2].AppearanceStyle := psDark;
    end;
  end; {case}
  if ((j=1) and (ignoredChangesCount>0)) then
  begin
    tmpstr:='** '+tmpstr+' **';
    ///mainform.panel3.font.color:=clgreen;
    mainform.stbMain.Panels[2].AppearanceStyle := psLight;
    tmpstr2:=inttostr(ignoredChangesCount)+' change';
    if ignoredChangesCount=1 then tmpstr2:=tmpstr2+' was ignored'
     else tmpstr2:=tmpstr2+'s were ignored';
    ///mainform.panel3.hint:=tmpstr2;
    MainForm.stbMain.Panels[2].Text := TmpStr2;
  end;

  ///mainform.panel3.caption:=tmpstr;
  MainForm.stbMain.Panels[2].Text := TmpStr;
end;

function findFac(enteredTxt: string): integer;
var
 aStr,bStr:   string;
 i,j,aLen:       integer;
begin
 aStr:=FNupperCase(trim(enteredTxt));
 aLen:=Length(aStr);   j:=-1;
 if aLen>0 then
  for i:=1 to facNum do
  begin
   bStr:=FNupperCase(copy(facName[i],1,aLen));
   if aStr=bStr then
   begin
    j:=i;
    break;
   end;
  end; {for i}

 result:=j;
end;

function FNupperCase(aStr: String): string;
var
 i,j:     integer;
begin
 j:=Length(aStr);
{ if j=0 then exit;   }
 if j>0 then
  for i:=1 to j do
   aStr[i]:=upcase(aStr[i]);
 result:=aStr;
end;

procedure ttCalc(ttrow,ttcol:  integer);
var
 i,j,k,n:         integer;
begin
{ if scalingGridCellsFlag then exit;  }
 j:=0;  i:=0;   k:=0; n:=0;
 while (j<ttcol) do
 begin
  inc(j,tlimit[i]);
  inc(i);
  if j>=ttcol then break;
 end;
 if i>0 then dec(i);
 ttcalcD:=i;
 ttcalcP:=(ttcol-(j-tlimit[i]))-1;
 j:=1;
 for i:=years_minus_1 downto 0 do
 begin
  inc(j,Level[i]+1);
  if j>=ttrow then
  begin
   k:=i;
   n:=Level[i]-(j-ttrow);
   break;
  end;
 end;
 ttcalcY:=k;
 ttcalcL:=n;
end;

procedure setWindowDefaults(aForm: Tform; aVal: integer);
begin
 if winpos[aVal].height>0 then
   begin
    aForm.top:=winpos[aVal].top;
    aForm.left:=winpos[aVal].left;
    aForm.width:=winpos[aVal].width;
    aForm.height:=winpos[aVal].height;
    aForm.windowstate:=winpos[aVal].state;
   end;
 aForm.Tag:=aVal;
 wnFlag[aVal]:=true;
 if (aForm is TdrawWin) then TdrawWin(aForm).TabsDo:=true;
end;


procedure getAndSetNewFont;
begin
 mainform.fontDialog1.options:=[fdForceFontExist,fdShowHelp];
   {leaving out fdEffects, hence no colour or strikeout etc. selections}
 mainform.fontDialog1.font.assign(tcfont);
 if mainform.fontDialog1.execute  then
 begin
  try {ensure cursor restored}
   tcfont.assign(mainform.fontDialog1.font);
   screen.cursor:=crHourglass;
   mainform.canvas.font.assign(tcfont);
   getfontwidths;  AlterTimeFlag:=True;
   updateAllwins;
   finally
    screen.cursor:=crDefault;
   end; {try finally block}
 end; {if fontdialog1.execute}
end;

procedure updateTtableWindow;
begin
 if wnFlag[wnTtable] then
 begin
  Ttablewin.font.assign(tcFont);
  Ttablewin.stringgrid1.font.assign(tcfont);
  Ttablewin.image1.canvas.font.assign(tcfont);
  if alterTimeFlag then InitTtableWin(Ttablewin);
  Ttable.updateClashStatusBar(Ttablewin);
  Ttablewin.repaint;
  ttablewin.stringgrid1.repaint;
  restoreAnySelection(Ttablewin); {repaint removes it !!}
 end;
end;

procedure TeWinSelect;
begin
 if wnFlag[wnTeCode] then TeWindow.show
 else TeWindow:=TTeWindow.create(application);
end;

procedure infoWinSelect;
begin
 if wnFlag[wnInfo] then infowin.show
   else infowin:=tinfowin.create(application);
end;

Function GetWindow(wn:smallint): TDrawWin;
var
 mywin:TDrawWin;
begin
 mywin:=nil;
 case wn of
  wnInfo: mywin:=InfoWin;
  wnTecode: mywin:=TeWindow;
  wnAddedStaff: mywin:=AddedStaffwin;
  wnTimes: mywin:=TimesWindow;
  wnAbsReason: mywin:=AbsReasonWin;
  wnCoverNote: mywin:=CoverNotesWin;
  wnAbsentTe: mywin:=Absentte;
  wnLostClass: mywin:=LostClasseswin;
  wnAddedSel: mywin:=addedstaffselwin;
  wnNewClass: mywin:=NewClasseswin;
  wnMergeClass: mywin:=MergedClasseswin;
  wnRoomSwap: mywin:=roomswaps;
  wnUnavailRooms: mywin:=UnavailableRooms;
  wnFindStud: mywin:=FindStudent;
  wnFindTeach: mywin:=FindTeacherWin;
  wnFindRoom: mywin:=FindRoomWin;
  wnStudentTt: mywin:=STtable;
  wnRoomTt: mywin:=RoTtable;
  wnTeacherTt: mywin:=TeTtable;
  wnStudentList: mywin:=StudentListWin;
  wnSubjectList: mywin:=SubBySubjectWin;
  wnTimeList: mywin:=SubByTimeSlotWin;
  wnSubjectTt: mywin:=SuTtable;
  wnCurrentExtras: mywin:=CurrentExtrasWin;
  wnPastExtras: mywin:=PastExtrasWin;
  wnShowUsers: mywin:=ShowUsersWin;
 end;
 result:=mywin;
end;

procedure UpdateWindow(wn:smallint);
var
 mywin: TDrawWin;
begin
 if wnFlag[wn] then
  begin
   mywin:=GetWindow(wn);
   if (mywin is TdrawWin) then
   begin
     mywin.UpdateWin;
     if MyWin.Name = 'InfoWin' then
       MyWin.Activate;
   end;
  end;
end;

function findSubyear(place: smallint): smallint;
var
 i:      smallint;
begin
 result:=0;  {not found}
 for i:=1 to GroupSubs[0] do
 if GroupSubs[i]=place then
 begin
  result:=i;
  exit;
 end;
end;

procedure ensureSizeForFont(var frm :tform);
var
 i,a,b:       integer;
 need:        boolean;
 r:           single;
begin
 need:=false;  a:=1; b:=1;
 for i:=0 to (frm.controlcount-1) do
 begin
  if (frm.controls[i] is tlabel) then
  begin
   a:=frm.controls[i].height;  b:=tlabel(frm.controls[i]).canvas.textheight('ABcdgy');
   if a<b then
   begin
    need:=true; break;
   end;
  end; {if (frm.controls[i] is tlabel)}
 end; {for i}
 if need then
 begin
  r:=b/a;
  for i:=0 to (frm.controlcount-1) do
  if ((frm.controls[i] is tlabel) or (frm.controls[i] is tedit)) then
  begin
   frm.controls[i].height:=round(frm.controls[i].height*r);
   frm.controls[i].width:=round(frm.controls[i].width*r);
  end;
 end; {if need}
end;

procedure swapStudents(A,B: smallint);
var
 tmp:      tpStudRec;
begin
 tmp:=Stud[A];
 Stud[A]:=Stud[B];
 Stud[B]:=tmp;
end;

procedure sortStudents;
var
 i:            smallint;
 J,K,L,M,A,B:  smallint;
 strA,strB:    string;
label
 Label1,label2;
begin
 setlength(StGroup,(numStud+1)); {zero based so +1}
 setlength(StPointer,(numStud+1)); {zero based so +1}
 setlength(StudSort,(numStud+1)); {zero based so +1}
 K:=1;
 while K<numstud do
  K:=K+K;
 label2:
 K:=(K-1) div 2;
 if K=0 then
 begin
  //init sort array to alpha sort
  for i:=1 to numstud do StudSort[i]:=i;
  exit;
 end;

 M:=numstud-K;
 for i:=1 to M do
 begin
   J:=i;
   Label1:
   L:=J+K;
   A:=L;
   B:=J;
   strA:=UpperCase(Stud[A].StName+' '+Stud[A].First);
   strB:=UpperCase(Stud[B].StName+' '+Stud[B].First);
   if strA<strB then
   begin
    swapStudents(A,B);
    J:=J-K;
   end;
   if (strA<strB) and (J>0) then goto Label1;
  end;   {for}
 goto label2;
end;

procedure splitName(StudentI:smallint; StudentName:string);
var
 strA,strB:  string;
 stpos,stpos1:     smallint;
begin
 StudentName:=trim(StudentName);
 strA:=StudentName;
 stpos:=pos(' ',strA);
 strB:=copy(strA,stpos+1,length(strA));
 stpos1:=stpos;
 while stpos1>0 do
 begin
  stpos1:=pos(' ',strB);
  strB:=copy(strB,stpos1+1,length(strB));
  stpos:=stpos+stpos1;
 end;
 Stud[StudentI].StName:=copy(strA,1,stpos-1);
 Stud[StudentI].First:=copy(strA,stpos+1,length(strA));
end;

procedure CountChmax;
var
  i,j,k:    smallint;
begin
  chmax:=5;
  IDlen:=0;
  for i:=1 to numstud do
    begin
      for j:=1 to nmbrchoices do
         if (Stud[i].choices[j]>0) and (j>chmax) then chmax:=j;
      k:=ord(Stud[i].ID[0]);
      if k>IDlen then IDlen:=k;
    end;
  if chmax>nmbrChoices then chmax:=nmbrChoices;
  //if IDlen>10 then IDlen:=10;
  if IDlen>szID then IDlen:=szID;
  if FAsubnum=0 then FAsubnum:=chmax;
end;

function CodeFontWidth(mycanvas:Tcanvas; code: integer): smallint;
var
 j:             integer;
 maxTab,curTab:   integer;
begin
 maxTab:=1; curTab:=0;
 for j:=1 to NumCodes[code] do
 begin
  case code of
   0: curTab:=mycanvas.textwidth(trim(SubCode[j]));
   1: curTab:=mycanvas.textwidth(trim(Tecode[j,0]));
   2: curTab:=mycanvas.textwidth(trim(Tecode[j,1]));
  end;
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

function BlankCodeFontWidth(mycanvas:Tcanvas; code: integer): smallint;
var
 maxTab:   integer;
begin
 maxTab:=0;
 case code of
  0: maxTab:=mycanvas.textwidth(copy('__________',1,lencodes[code]));
  1: maxTab:=mycanvas.textwidth(copy('----------',1,lencodes[code]));
  2: maxTab:=mycanvas.textwidth(copy('..........',1,lencodes[code]));
 end;
 result:=maxTab;
end;

function CodeNameFontWidth(mycanvas:Tcanvas; code: integer): smallint;
var
 j:             integer;
 maxTab,curTab:   integer;
begin
 maxTab:=1; curTab:=0;
 for j:=1 to NumCodes[code] do
 begin
  case code of
   0: curTab:=mycanvas.textwidth(trim(SubName[j]));
   1: curTab:=mycanvas.textwidth(trim(TeName[j,0]));
   2: curTab:=mycanvas.textwidth(trim(TeName[j,1]));
  end;
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

procedure getCodeFontWidths(code: integer);
begin
 fwCode[code]:=CodeFontWidth(mainform.canvas,code);
 fwCodeBlank[code]:=BlankCodeFontWidth(mainform.canvas,code);
 if fwCodeBlank[code]<fwCode[code] then fwCodeBlank[code]:=fwCode[code];
 fwCodename[code]:=CodeNameFontWidth(mainform.canvas,code);
end;

function getTemailFontWidths(mycanvas: Tcanvas):smallint;
var
 maxTab,curTab,j: integer;
begin
 maxTab:=1;
  for j:=1 to NumCodes[1] do
   begin
    curTab:=mycanvas.textwidth(Temail[j]);
    if (curTab>maxTab) then maxTab:=curTab;
   end;
 result:=maxTab;
end;

function getETmailFontWidths(mycanvas: Tcanvas):smallint;
var
 maxTab,curTab,j: integer;
begin
 maxTab:=1;
  for j:=1 to ETnum do
   begin
    curTab:=mycanvas.textwidth(ETmail[j]);
    if (curTab>maxTab) then maxTab:=curTab;
   end;
 result:=maxTab;
end;

function StudentNameFontWidth(mycanvas: Tcanvas):smallint;
var
 i:             smallint;
 maxTab,curTab:   smallint;
begin
 maxTab:=1;
 for i:=1 to numstud do
 begin
  curTab:=mycanvas.textwidth(Stud[i].StName+' '+Stud[i].First);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

function StudentIDfontWidth(mycanvas: Tcanvas):smallint;
var
 i:             smallint;
 maxTab,curTab:   smallint;
begin
 maxTab:=1;
 for i:=1 to numstud do
 begin
  curTab:=mycanvas.textwidth(Stud[i].ID);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

function StudentSexFontWidth(mycanvas: Tcanvas):smallint;
var
 maxTab,curTab:   smallint;
begin
 maxTab:=mycanvas.textwidth('M');
 curTab:=mycanvas.textwidth('F');
 if (curTab>maxTab) then maxTab:=curTab;
 result:=maxTab;
end;

procedure getStudentFontWidths;
begin
 fwStname:=StudentNameFontWidth(mainForm.canvas);
 fwID:=StudentIDfontWidth(mainForm.canvas);
 fwSex:=StudentSexFontWidth(mainForm.canvas);
end;

function getHouseFontWidths(mycanvas:Tcanvas):smallint;
var
 i:             integer;
 maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=1 to Housecount do
 begin
  curTab:=mycanvas.textwidth(HouseName[i]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

function getFacultyFontWidths(mycanvas:Tcanvas):smallint;
var
 i:             integer;
 maxTab,curTab:   integer;
begin
 maxTab:=mycanvas.textwidth('All faculties');
 for i:=1 to facNum do
 begin
  curTab:=mycanvas.textwidth(facName[i]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 if maxTab=0 then maxTab:=1;
 result:=maxTab;
end;

function getClassFontWidths(mycanvas:Tcanvas):smallint;
var
 i:             smallint;
 maxTab,curTab:   smallint;
begin
 maxTab:=1;
 for i:=1 to Classnum do
 begin
  curTab:=mycanvas.textwidth(trim(ClassCode[i]));
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

function getYearnameFontWidths(mycanvas:Tcanvas):smallint;
var
 i:             integer;
 maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=0 to years-1 do
 begin
  curTab:=mycanvas.textwidth(Yearname[i]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

function getAddedStaffCodeFontWidths(mycanvas:Tcanvas):smallint;
var
 i,maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=0 to ETnum1 do
 begin
  curTab:=mycanvas.textwidth(etsub[Etpointer[i]]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

function getAddedStaffNameFontWidths(mycanvas:Tcanvas):smallint;
var
 i,maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=0 to ETnum1 do
 begin
  curTab:=mycanvas.textwidth(etName[Etpointer[i]]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

function getAddedStaffCommentFontWidths(mycanvas:Tcanvas):smallint;
var
 i,maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=0 to ETnum1 do
 begin
  curTab:=mycanvas.textwidth(etComment[Etpointer[i]]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

procedure getAddedStaffFontWidths;
begin
 fwAddedStaffcode:=getAddedStaffCodeFontWidths(mainform.canvas);
 fwAddedStaffname:=getAddedStaffNameFontWidths(mainform.canvas);
 fwAddedComment:=getAddedStaffCommentFontWidths(mainform.canvas);
end;

function getTsNameDayFontWidths(myDay:smallint; mycanvas:Tcanvas):smallint;
var
 i:             integer;
 maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=0 to periods-1 do
 begin
  curTab:=mycanvas.textwidth(TimeSlotName[myDay,i]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

procedure getTsNameFontWidths;
var
 i:             integer;
begin
 fwPeriodname:=1;
 for i:=0 to days-1 do
 begin
  fwTsName[i]:=getTsNameDayFontWidths(i,mainform.canvas);
  if (fwTsName[i]>fwPeriodname) then fwPeriodname:=fwTsName[i];
 end;
end;

procedure getPrntTsNameFontWidths(Mycanvas:Tcanvas);
var
 i:             integer;
begin
 fwPrntPeriodname:=1;
 for i:=0 to days-1 do
 begin
  fwPrntTsName[i]:=getTsNameDayFontWidths(i,Mycanvas);
  if (fwPrntTsName[i]>fwPrntPeriodname) then fwPrntPeriodname:=fwPrntTsName[i];
 end;
end;

function getDaynameFontWidths(mycanvas:Tcanvas):smallint;
var
 i:             integer;
 maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=0 to days-1 do
 begin
  curTab:=mycanvas.textwidth(Dayname[i]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

function getDayFontWidths(mycanvas:Tcanvas):smallint;
var
 i:             integer;
 maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=0 to days-1 do
 begin
  curTab:=mycanvas.textwidth(Day[i]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 result:=maxTab;
end;

function TeDutyCodeFontWidths(mycanvas:Tcanvas):smallint;
var
 i,j:             integer;
 maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=1 to numcodes[1] do
  for j:=0 to 2 do
  begin
   curTab:=mycanvas.textwidth(dutycode[i,j]);
   if (curTab>maxTab) then maxTab:=curTab;
  end;
 result:=maxTab;
end;

function TeDutyLoadFontWidths(mycanvas:Tcanvas):smallint;
var
 i,j:             integer;
 maxTab,curTab:   integer;
 s: string;
begin
 maxTab:=1;
 for i:=1 to numcodes[1] do
  for j:=0 to 2 do
  begin
   str(dutyload[i,j]:4:1,s);
   curTab:=mycanvas.textwidth(s);
   if (curTab>maxTab) then maxTab:=curTab;
  end;
 result:=maxTab;
end;

procedure getTeDutyCodeFontWidths;
begin
 fwTeDutyCode:=TeDutyCodeFontWidths(mainform.Canvas);
 fwTeDutyLoad:=TeDutyLoadFontWidths(mainform.Canvas);
end;

function getTeCommentFontWidths(mycanvas:Tcanvas):smallint;
var
 i:             integer;
 maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=1 to numcodes[1] do
  begin
   curTab:=mainform.canvas.textwidth(Ecomment[i]);
   if (curTab>maxTab) then maxTab:=curTab;
  end;
 result:=maxTab;
end;

function getAbsenceFontWidths(mycanvas:Tcanvas):smallint;
var
 i,maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=0 to nmbrreasons do
 begin
  curtab:=mycanvas.textwidth(Abcode[i]+' '+Absent[i]);
  if (curTab>maxTab) then maxTab:=curTab;
 end; {for i}
 result:=maxTab;
 if fwAbsence=0 then fwAbsence:=1;
end;

function getCoverNoteFontWidths(mycanvas:Tcanvas):smallint;
var
 i,maxTab,curTab:   integer;
begin
 maxTab:=1;
 for i:=0 to nmbrreasons do
 begin
  curtab:=mycanvas.textwidth(Cover[i]);
  if (curTab>maxTab) then maxTab:=curTab;
 end; {for i}
 result:=maxTab;
end;

function getLetterFontWidth(mycanvas:Tcanvas):smallint;
var
 i,maxTab:   integer;
begin
 maxTab:=mycanvas.textwidth('T');  {for mapping allignments, AA-aa-L etc.}
 i:=mycanvas.textwidth('-'); if i>maxTab then maxTab:=i;
 i:=mycanvas.textwidth('L'); if i>maxTab then maxTab:=i;
 i:=mycanvas.textwidth('C'); if i>maxTab then maxTab:=i;
 i:=mycanvas.textwidth('S'); if i>maxTab then maxTab:=i;
 i:=mycanvas.textwidth('U'); if i>maxTab then maxTab:=i;
 i:=mycanvas.textwidth('N'); if i>maxTab then maxTab:=i;
 i:=mycanvas.textwidth('R'); if i>maxTab then maxTab:=i;
 i:=mycanvas.textwidth('I'); if i>maxTab then maxTab:=i;
 i:=mycanvas.textwidth('A'); if i>maxTab then maxTab:=i;
 i:=mycanvas.textwidth('M'); if i>maxTab then maxTab:=i;
 result:=maxTab;
end;

function GetBoxFontWidth(mycanvas:Tcanvas):smallint;
var
 a,i,j: integer;
begin
 a:=0;
 for i:=0 to 9 do
  begin
   j:=mycanvas.textwidth(inttostr(i));
   if j>a then a:=j;
  end; {for i}
 result:=a*4;
end;

procedure getFontWidths;
var
 i:       integer;
begin
 for i:=0 to 2 do getCodeFontWidths(i);
 getStudentFontWidths;
 boxWidth:=getBoxFontWidth(mainform.canvas);
 fwHouse:=getHouseFontWidths(mainform.canvas);
 fwFaculty:=getFacultyFontWidths(mainform.canvas);
 fwClass:=getClassFontWidths(mainform.canvas);
 fwYearname:=getYearnameFontWidths(mainform.canvas);
 getTsNameFontWidths;
 fwDayname:=getDaynameFontWidths(mainform.canvas);
 fwDay:=getDayFontWidths(mainform.canvas);
 getTeDutyCodeFontWidths;
 fwTemail:=getTemailFontWidths(mainform.canvas);
 fwETmail:=getETmailFontWidths(mainform.canvas);
 fwTeComment:=getTeCommentFontWidths(mainform.canvas);
 getAddedStaffFontWidths;
 fwAbsence:=getAbsenceFontWidths(mainform.canvas);
 fwCoverNote:=getCoverNoteFontWidths(mainform.canvas);
 Hmargin:=mainform.canvas.textwidth('AA');
 txtHeight:=mainform.canvas.textheight('Ay');
 blankwidth:=mainform.canvas.textwidth('  '); {2 spaces}
 letterW:=getLetterFontWidth(mainform.canvas);
end;

function StringPad(charcount:integer; charval:integer):string;
var
 i:     integer;
 tmpStr:        string;
begin
 tmpStr:=''; result:=tmpStr;
 if charcount<=0 then exit;  {return blank string}
 for i:=1 to charcount do
  tmpStr:=tmpStr+chr(charval);
 result:=tmpStr;
end;

function StringPadChr(charcount:integer; charchr:string):string;
var
 charval:  integer;
begin
 charval:=Ord(charchr[1]);
 result:=StringPad(charcount,charval);
end;

function Space(StringLength: integer):string;
begin
 result:=StringPad(Stringlength,32);
end;

function RpadString(S:string; L: integer):string;
begin
 RpadString:=S+space(L-length(S));
end;

function LpadString(S:string; L: integer):string;
begin
 LpadString:=space(L-length(S))+S;
end;

function FNsub(A9,code9: integer):string;
begin
 if code9=0 then FNsub:=SubCode[A9] else FNsub:=TeCode[A9,code9-1];
end;

function FNsubname(A9,code9: integer):string;
begin
 if code9=0 then FNsubname:=Subname[A9] else FNsubname:=Tename[A9,code9-1];
end;

procedure swapint(var a:smallint; var b: smallint);
var
tmp:      smallint;
begin
 tmp:=a;
 a:=b;
 b:=tmp;
end;

procedure swapstr(var a:string; var b: string);
var
tmp:      string;
begin
 tmp:=a;
 a:=b;
 b:=tmp;
end;

procedure XrefGroupSubs;
var
 i:     smallint;
begin
 for i:=0 to NumCodes[0] do
  GsubXref[i]:=0;
 for i:=1 to GroupSubs[0] do
  GsubXref[GroupSubs[i]]:=i;
end;

procedure sortCodes(code: integer);
  var
    D,H,i,pos:         integer;
    J,L,A,B:           integer;
    aStr,tmpStr1,tmpStr2: string;
  label label1,label2;

begin
 pos:=0;
 for i:=1 to NumCodes[code] do
   begin
    aStr:=FNsub(i,code);
    aStr:=copy(aStr,1,2);
    if (aStr<>'00') then
     begin
      inc(pos);
      codepoint[pos,code]:=i;
     end;
   end;
 codenum[code]:=pos;
 if sorttype[code]=0 then exit;
 D:=1;
 while D<codenum[code] do D:=D+D;
 label1:
 D:=(D-1) div 2;
 if D=0 then exit;
 H:=codenum[code]-D;
 for i:=1 to H do
   begin
    J:=i;
    Label2:
    L:=J+D;
    A:=codepoint[L,code];
    B:=codepoint[J,code];
    case sorttype[code] of
     1: begin
         tmpStr1:=uppercase(FNsub(A,code));
         tmpStr2:=uppercase(FNsub(B,code));
        end;
     2: begin
         tmpStr1:=uppercase(FNsubname(A,code));
         tmpStr2:=uppercase(FNsubname(B,code));
        end;
     3: begin
         tmpStr1:=uppercase(Ecomment[A]);
         tmpStr2:=uppercase(Ecomment[B]);
        end;

    end; {case}

    if tmpStr1<tmpStr2 then
      begin
       codepoint[J,code]:=A;
       codepoint[L,code]:=B;
       dec(J,D);
      end;
    if (tmpStr1<tmpStr2) and (J>0) then goto Label2;
  end; {for}
  goto label1;
end;

procedure restoreAnySelection(aForm: TTtablewin);
var
 j:     integer;
 curSelection:        TgridRect;
 tmpstr:              string;
begin
   case box of
   0: begin {cell}
       j:=findcol(nd,np);
       CurSelection.left:=j;     CurSelection.right:=j;
       j:=findrow(ny,nl);
       CurSelection.top:=j;     CurSelection.bottom:=j;
       aForm.stringgrid1.selection:=CurSelection;
       aForm.label1.caption:='['+yearshort+' '+yearname[ny]+' Lev:'+ inttostr(nl)
                    +' '+Day[nd]+':'+inttostr(np+1)+']  ';
       aForm.label1.left:=aForm.panel1.clientwidth-aForm.label1.width;
      end;
   1: begin {level}
       CurSelection.left:=0;     CurSelection.right:=aForm.stringgrid1.colcount;
       j:=findrow(ny,nl);
       CurSelection.top:=j;     CurSelection.bottom:=j;
       aForm.stringgrid1.selection:=CurSelection;
       tmpStr:=yeartitle+' '+yearname[ny]+' Level '+inttostr(nl);
       aForm.label1.caption:=tmpStr;
       aForm.label1.left:=aForm.panel1.clientwidth-aForm.label1.width;
      end;
   2: begin {year}
       CurSelection.left:=0;     CurSelection.right:=aForm.stringgrid1.colcount;
       j:=findrow(ny,0);
       CurSelection.top:=j;     CurSelection.bottom:=j+level[ny];
       aForm.stringgrid1.selection:=CurSelection;
       aForm.label1.caption:=yeartitle+' '+yearname[ny];
       aForm.label1.left:=aForm.panel1.clientwidth-aForm.label1.width;
      end;
   3: begin {year timeslot}
       j:=findcol(nd,np);
       CurSelection.left:=j;    CurSelection.right:=j;
       j:=findrow(ny,0);
       CurSelection.top:=j;     CurSelection.bottom:=j+level[ny];
       aForm.stringgrid1.selection:=CurSelection;
       aForm.label1.caption:=yearshort+' '+yearname[ny]+' '+day[nd]+' '+inttostr(np+1);
       aForm.label1.left:=aForm.panel1.clientwidth-aForm.label1.width;
      end;
   4: begin {timeslot/period}
       j:=findcol(nd,np);
       CurSelection.left:=j;     CurSelection.right:=j;
       CurSelection.top:=1;     CurSelection.bottom:=aForm.stringgrid1.rowcount;
       aForm.stringgrid1.selection:=CurSelection;
       aForm.label1.caption:=day[nd]+' '+inttostr(np+1);
       aForm.label1.left:=aForm.panel1.clientwidth-aForm.label1.width;
      end;
   5: begin {block}

      end;
   6: begin {day}
       j:=findcol(nd,0);
       CurSelection.left:=j;     CurSelection.right:=j+tlimit[nd]-1;
       CurSelection.top:=0;     CurSelection.bottom:=aForm.stringgrid1.rowcount;
       aForm.stringgrid1.selection:=CurSelection;
       aForm.label1.caption:=day[nd];
       aForm.label1.left:=aForm.panel1.clientwidth-aForm.label1.width;
      end;
  end; {case}
end;

procedure InitTtableWin(aForm: TTtablewin);
var
 i,j:       integer;
 y:         integer;
 blankwidth:     integer;
 topgap:         integer;
 w4,colwidthmax:    integer;
 rowheightmax:   integer;
 curposCoord:    TgridCoord;
 curTgridRect:   TgridRect;
 tmpcanvasbitmap:  Tbitmap;
begin
 aForm.caption:='Timetable  Version:'+version+'  File:'+FileNames.LoadedTimeTable;
 aForm.canvas.font.assign(tcfont);
 aForm.stringgrid1.canvas.font.assign(tcfont);
 blankwidth:=aForm.{stringgrid1.}canvas.textwidth(' ');
 topgap:=blankwidth div 2;
 scalingGridCellsFlag:=true;
 with aForm.StringGrid1 do
 begin
  fwYearname:=getYearnameFontWidths(mainform.canvas);
  j:=0;
  for i:=0 to days-1 do
   inc(j,tlimit[i]);
  Colcount:=fixedcols+j;
  {set colwidths}
  colwidthmax:=aForm.stringgrid1.canvas.textwidth(yearshort+'   ')+fwYearname;
  if fwClass>colwidthmax then colwidthmax:=fwClass;
  colwidths[0]:=colwidthmax;
   colwidthmax:=1+fwCodeBlank[0]+fwCodeBlank[1]+fwCodeBlank[2]+blankwidth*4;
   w4:=(fwDayname+canvas.textwidth(':99 '));
   if w4>colwidthmax then colwidthmax:=w4;

  for i:=1 to (colcount-1) do colwidths[i]:=colwidthmax;

  j:=years;
  for i:=0 to years_minus_1 do
   inc(j,Level[i]);
  RowCount:=fixedrows+j;
  rowheightmax:=aForm.canvas.textheight('Ag')+topgap*2;
  for i:=0 to (rowCount-1) do
  begin
   aForm.StringGrid1.rowheights[i]:=rowheightmax;
  end;
  aForm.panel1.height:=rowheightmax;  {rowheightmax;}
  aForm.image1.height:=aForm.canvas.textheight('Ag')*2;  {rowheightmax*2;}
    {dispite align bottom on image, image not increasing width with form - if you want something done}
     aForm.image1.width:=aForm.width;
    {ensure canvas on image resizes so shove an image into it}
     tmpcanvasbitmap:=Tbitmap.create;
     tmpcanvasbitmap.width:=aForm.image1.width;
     tmpcanvasbitmap.height:=aForm.image1.height;
     aForm.image1.picture.graphic:=tmpcanvasbitmap;
     tmpcanvasbitmap.free;
     {after canvas finally resized, its forgotten what the font is -restore it}
     aForm.image1.canvas.font.assign(tcfont);

  aForm.label1.top:=0;
  aForm.label1.left:=aForm.panel1.clientwidth-aForm.label1.width;
  aForm.label2.top:=0;
  aForm.label2.left:=blankwidth div 2;
  aForm.label2.caption:='Top :'+yearshort+' '+yearname[years_minus_1]+' Lev:1 ';{'Day:1 Time:1'};

 end;  {with ttablewin.stringgrid1 do}
 scalingGridCellsFlag:=false;

 if winpos[9].height>0 then
 begin
  scalingGridCellsFlag:=true;  {prevent topleftchange event-triggered code}


  aForm.Stringgrid1.leftcol:=findcol(dl,pl); {restore col}
  y:=findrow(yl,ll);
  if (yl=ny) and (nl=ll) and (nl=1) then dec(y);
  aForm.Stringgrid1.toprow:=y;  {restore row} {2 fixed rows}
  scalingGridCellsFlag:=false;
  {restore selection}

  curposCoord.y:=findrow(ny,nl);

  curposCoord.x:=findcol(nd,np);
  curTgridRect.topleft:=curposCoord;
  curTgridRect.bottomright:=curposCoord;
  { MUST assign entire record at once - but can read individual record fields}
  aForm.Stringgrid1.selection:=curTgridRect;

 end  {if winPos[9].height>0}
 else {init selection}
  begin
   curposCoord.x:=1;
   curposCoord.y:=3;
   curTgridRect.topleft:=curposCoord;
   curTgridRect.bottomright:=curposCoord;
   aForm.Stringgrid1.selection:=curTgridRect;
  end;

 restoreAnySelection(aForm);

 alterTimeFlag:=false;
end;

procedure TtableWinSelect;
begin
 if wnFlag[wnTtable] then
 begin
  Ttablewin.show;
 end
 else
 begin
  Ttablewin:=TTtablewin.create(application);
  wnFlag[wnTtable]:=true;
  ttablewin.caption:='Timetable  Version:'+version+'  File:'+FileNames.LoadedTimeTable;
  screen.cursor:=crHourglass;
  Ttablewin.font.assign(tcFont);
  Ttablewin.stringgrid1.font.assign(tcfont);
  Ttablewin.image1.canvas.font.assign(tcfont);
  InitTtableWin(Ttablewin);
  Ttable.updateClashStatusBar(Ttablewin);
  Ttablewin.repaint;
  restoreAnySelection(Ttablewin); {repaint removes it !!}
  screen.cursor:=crDefault;
 end;
end;

procedure studentTtablewinSelect;
begin
 if wnFlag[wnStudentTt] then STtable.show
  else STtable:=TSTtable.create(application);
end;

procedure teachTtablewinSelect;
begin
 if wnFlag[wnTeacherTt] then TeTtable.show
  else TeTtable:=TTeTtable.create(application);
end;

procedure TeachersFreewinSelect;
begin
 if wnFlag[wnTeFree] then TeachersFree.show
  else TeachersFree:=TTeachersFree.create(application);
end;

procedure roomTtablewinSelect;
begin
 if wnFlag[wnRoomTt] then RoTtable.show
  else RoTtable:=TRoTtable.create(application);
end;

procedure subjectTtablewinSelect;

begin
 if wnFlag[wnSubjectTt] then SuTtable.show
  else SuTtable:=TSuTtable.create(application);
end;

procedure SubjectbySubjectListwinSelect;
begin
 if wnFlag[wnSubjectList] then SubBySubjectwin.show
  else SubBySubjectwin:=TSubBySubjectwin.create(application);
end;

procedure SubjectbyTimeSlotwinSelect;
begin
 if wnFlag[wnTimeList] then SubByTimeSlotwin.show
  else SubByTimeSlotwin:=TSubByTimeSlotwin.create(application);
end;

procedure StudentListwinSelect;
begin
 if wnFlag[wnStudentList] then StudentListWin.show
  else StudentListWin:=TStudentListWin.create(application);
end;

procedure validateCode(code: integer; var codeStr: string);
begin
  codeStr:=uppercase(copy(RpadString(codeStr,lenCodes[code]),1,lenCodes[code]));
end;

procedure editcustominformation;
begin
 EditCustomInfo:=TEditCustomInfo.create(application);   {allocate dlg}
 EditCustomInfo.showmodal;
 EditCustomInfo.free;               {release dlg}
end;

function checkCode(code: integer; var codeStr: string): integer;
var
 i:     integer;
 tmpStr: string;
begin
 result:=0; {not found}
 tmpStr:=Copy(codeStr,1,2);
 if tmpStr='00' then exit; {not found for deleted codes - flagged later}
 if numCodes[code]=0 then exit;
 validateCode(code,codeStr);
 for i:=1 to numCodes[code] do
  begin
   tmpStr:=uppercase(FNsub(i,code));
   if tmpStr=codeStr then
   begin
    result:=i;
    break; {leave for loop ???}
   end;
  end;
end;

function checkfaculty(codeStr: string): integer;
var
 i,j:     integer;
 tmpStr: string;
begin
 result:=0; {not found}

 codeStr:=uppercase(trim(codestr));
 if codeStr='*' then
 begin
  result:=-1;
  exit;
 end;
 j:=Length(codestr);
 if j=0 then exit;
 tmpStr:=Copy(codeStr,1,2);
 if tmpStr='00' then exit; {not found for deleted codes - flagged later}
 if facnum=0 then exit;
 for i:=1 to facnum do
 begin
  tmpStr:=uppercase(copy(facname[i],1,j));
  if tmpStr=codeStr then
  begin
   result:=i;
   break; {leave for loop ???}
  end;
 end;
end;

function checkWildSub(var codeStr: string): smallint;
var
 i,j:     smallint;
 tmpStr,tmpStr2: string;
begin
 result:=0; j:=0;{not found}
 tmpStr:=Copy(codeStr,1,2);
 if tmpStr='00' then exit; {not found for deleted codes - flagged later}
 if numCodes[0]=0 then exit;
 tmpStr:=trim(codeStr);
 if copy(tmpStr,lencodes[0],1)='*' then
 begin
  tmpStr2:=uppercase(copy(codeStr,1,lencodes[0]-1));
  for i:=1 to numCodes[0] do
  begin
   tmpStr:=copy(uppercase(subcode[i]),1,lencodes[0]-1);
   if tmpStr=tmpStr2 then
   begin
    j:=-i;
    break;
   end;
  end;
 end
 else   { not     copy(tmpStr,lencodes[code],1)='*'}
  j:=checkcode(0,codeStr);
 result:=j;
end;

{--------------     -printing routines -  ------------------}


procedure getPrntFontWidths(mycanvas:Tcanvas);
var
 i:       integer;
begin
 for i:=0 to 2 do
  begin
   fwPrntCode[i]:=CodeFontWidth(mycanvas,i);
   fwPrntCodeBlank[i]:=BlankCodeFontWidth(mycanvas,i);
   if fwPrntCodeBlank[i]<fwPrntCode[i] then fwPrntCodeBlank[i]:=fwPrntCode[i];
   fwPrntCodename[i]:=CodeNameFontWidth(mycanvas,i);
  end;
 fwPrntStname:=StudentNameFontWidth(mycanvas);  {was getPrntStudentFontWidths}
 fwPrntID:=StudentIDfontWidth(mycanvas);
 fwPrntSex:=StudentSexFontWidth(mycanvas);
 PrntBoxWidth:=getBoxFontWidth(mycanvas);
 fwPrntHouse:=getHouseFontWidths(mycanvas);
 fwPrntFaculty:=getFacultyFontWidths(mycanvas);
 fwPrntClass:=getClassFontWidths(mycanvas);
 fwPrntYearname:=getYearnameFontWidths(mycanvas);
 getPrntTsNameFontWidths(Mycanvas);
 fwPrntDayname:=getDaynameFontWidths(mycanvas);
 fwPrntDay:=getDayFontWidths(mycanvas);
 fwPrntTeDutyCode:=TeDutyCodeFontWidths(myCanvas);
 fwPrntTeDutyLoad:=TeDutyLoadFontWidths(myCanvas);
 fwPrntTemail:=getTemailFontWidths(mycanvas);
 fwPrntETmail:=getETmailFontWidths(mycanvas);
 fwPrntTeComment:=getTeCommentFontWidths(mycanvas);
 fwPrntAddedStaffcode:=getAddedStaffCodeFontWidths(mycanvas);
 fwPrntAddedStaffname:=getAddedStaffNameFontWidths(mycanvas);
 fwPrntAddedComment:=getAddedStaffCommentFontWidths(mycanvas);

 fwPrntAbsence:=getAbsenceFontWidths(mycanvas);
 fwPrntCoverNote:=getCoverNoteFontWidths(mycanvas);
 PrnttxtHeight:=trunc(mycanvas.textheight('Ay')*1.02);
 Prntblankwidth:=mycanvas.textwidth('  '); {2 spaces}
 letterWprnt:=getLetterFontWidth(mycanvas);
end;

function RescanTimetable(const pStealth: Boolean): Boolean;
var
  s: string;
  puton, putoff: tpTe32Data;
  i, p, sub, te, ro, ro1, year1, level1: Integer;
  new, new1: Integer;
  notlost: Boolean;

  isAbsent, isRT: boolean;
begin
  Result := False;
  if (usrPasslevel = 0) then exit;

  //#146 - Rescan seems to mess up most things so bail early
  // update to not allow stealth mode
  if (pStealth) then begin
    result:=true;
    exit;
  end;

  if not pStealth then
  begin
    s:='Scan for changes to Timetable [Extras Data maybe lost] (Y/N)?';
    if MessageDlg(s, mtConfirmation, [mbyes, mbno],0) <> mryes then Exit;
  end;
  {initialize temp arrays}
  for i:=1 to numcodes[2] do begin puton[i]:=0; putoff[i]:=0; end;    // [2] = rooms
  calculateTeach; {recalculate teach, teNA, roomteach and rolost}
  for i:=1 to numchanges do {check timetable details in changes}
  begin
    ro:=Changes[i].oldroom; p:=Changes[i].timeslot; te:=Changes[i].oldte;
    if (Changes[i].gen=0) and (ro>0) and (p>0) then {room change}
      if GetRoomTtItem(sub,te,Year1,Level1,ro,ttday,p-1) then
      begin
        Changes[i].year:=year1; Changes[i].level:=level1; Changes[i].sub:=sub;
        Changes[i].oldte:=te;
      end;
    if Changes[i].gen=1 then {absent teacher}
      if GetTeachTtItem(sub,ro,Year1,Level1,te,ttday,p-1) then
      begin
        if Changes[i].oldroom=Changes[i].newroom then Changes[i].newroom:=ro;
        Changes[i].year:=year1; Changes[i].level:=level1; Changes[i].sub:=sub;
        Changes[i].oldroom:=ro;
      end;
  end;

  ConsequentNum:=0;
  for i:=1 to numchanges do  {remove any teacher covers that can't be done}
  begin
    te:=Changes[i].newte; p:=Changes[i].timeslot;
    if (Changes[i].kind<2) or (te<1) or (te>numcodes[1]) or (te=Changes[i].oldte)
        or (p<1) or (p>tlimit[ttDay]) then continue; {data not in range or no cover}
    new:=teach[te] and (1 shl p);
    new1:=teNA[te] and (1 shl p);
    notlost:=(telost[te] and (1 shl p))<>0;
    // #47 dont do this if Kind=5 (Shared)
    if Changes[i].kind<>5 then begin
      if ((new=0) and notlost) or (new1=0) then RemoveTeacherCover(i,p);
    end;
   {teaching added or Not Available added}
  end;
  if ConsequentNum>0 then RemoveConsequents;

  {add or remove any teacher absences that no longer apply}
  for te:=1 to numcodes[1] do
  begin
    for p:=1 to tlimit[ttday] do   {absent, and now not on timetable or is NA}
      if boolean(not(teAbsent[te]) and (teach[te] or (not(teNA[te]))) and (1 shl p)) then
        removeabsent(te,p);
    updateAbsence(te); {change to unconditional check of absences}
  end;
  {fix up room covers, unavailable and swaps}
  for i:=1 to numchanges do  {remove any room covers that can't be done}
  begin
    ro:=Changes[i].newroom; p:=Changes[i].timeslot;
    ro1:=Changes[i].oldroom;
    if (ro<1) or (ro>numcodes[2]) or (ro=ro1)
        or (p<1) or (p>tlimit[ttDay]) then continue; {data not in range or no cover}
    new:=Roomteach[ro] and (1 shl p);
    notlost:=(rolost[ro] and (1 shl p))<>0;
    if ((new=0) and notlost) then
    begin  {either a cover or a swap}
      if ((roswap[ro] and (1 shl p))=0)and (ro1>0) then BalanceRoomSwap(ro1,ro,p)
      else RemoveMyRoomCover(i,p);
    end;
  end;

  for ro:=1 to numcodes[2] do   {add or remove unavailable room changes}
  begin
    for p:=1 to tlimit[ttday] do   {absent, and now not on timetable or is NA}
    begin
      isAbsent := boolean(roAbsent[ro]and (1 shl p));
      isRT     := boolean(RoomTeach[ro] and (1 shl p));
      if boolean(not(roAbsent[ro]) and Roomteach[ro] and (1 shl p)) then
        removeAbsentRoom(p,ro);
    end;
    {do interim recalc of RoomOn so that UpdateRoomAbsence works correctly}
    RoomOn[ro]:=(RoomTeach[ro] or not(rolost[ro])) and roCover[ro];
    UpdateRoomAbsence(ro);
  end;
  {recalc bit maps}
  for i:=1 to numcodes[1] do
  begin tecover[i]:=-1; tElieu[i]:=-1; tereplace[i]:=-1; end;
  for i:=1 to numcodes[2] do
  begin roswap[i]:=-1; rocover[i]:=-1; end;

  for i:=1 to numchanges do
  begin
  // part of the fix for #146
//    p:=Changes[i].timeslot; ro:=Changes[i].oldroom; ro1:=Changes[i].oldroom;
    p:=Changes[i].timeslot; ro:=Changes[i].oldroom; ro1:=Changes[i].newroom;
    te:=Changes[i].newte;
    if (ro1<>ro) then
    begin
      if ro>0 then putoff[ro]:=putoff[ro] and (1 shl p);
      // also part of the fix for #146
      if ro1>0 then puton[ro1]:=puton[ro1] and (1 shl p);
      if (ro>0) and (ro1>0) and ((roAbsent[ro] and (1 shl p))<>0) then
      begin
        roswap[ro1]:=roswap[ro1] and (not(1 shl p));
        roswap[ro]:=roswap[ro] and (not(1 shl p));
      end;
      if (ro1>0) and (((ro>0) and ((roAbsent[ro] and (1 shl p))=0)) or
       (changes[i].gen>2)) then rocover[ro1]:=rocover[ro1] and (not(1 shl p));
    end;
    if te>0 then
    begin
      if changes[i].kind=2 then tereplace[te]:=tereplace[te] and (not(1 shl p));
      if changes[i].kind=3 then tElieu[te]:=tElieu[te] and (not(1 shl p));
      if changes[i].kind>3 then tecover[te]:=tecover[te] and (not(1 shl p));
    end;
  end;

  for i:=1 to numcodes[1] do {recalc teOn bitmaps}
  teon[i]:=(teach[i] or not(telost[i])) and teCover[i] and tereplace[i] and tElieu[i];
  for i:=1 to numcodes[2] do {recalc RoomOn bitmaps}
  RoomOn[i]:=(RoomTeach[i] or not(rolost[i])) and roCover[i];
  for ro:=1 to numcodes[2] do
  for p:=1 to Tlimit[ttday] do
  begin
    if ((putoff[ro] and (1 shl p))<>0) and ((puton[ro] and (1 shl p))=0) then
      RoomOn[ro]:=RoomOn[ro] or (1 shl p);
    if ((putoff[ro] and (1 shl p))=0) and ((puton[ro] and (1 shl p))<>0) then
      RoomOn[ro]:=RoomOn[ro]  and (not(1 shl p));
  end;

  updateteacherMap;
  updateRoomMap;
  Result := True;
end;

function GetStudentHomeRoom(const pStudNo: Integer): string;
var
  lStr: string;
  lCode: string;
begin
   lstr := '';
   try
     lStr := Trim(TeName[Stud[pStudNo].Home, 1]);
     lCode := Trim(TeCode[Stud[pStudNo].Home, 1]);
     if lStr = '' then
       lStr := lCode
     else
       lStr := lCode +  ' (' + lStr + ')';
   finally
     Result := lStr;
   end;
end;

function IsEnoughLevels: Boolean;
var
  i: Integer;
begin
  Result := True;
  if YearLevels.Count > 0 then
    for i := 0 to years_minus_1 do
    begin
      if TYearLevel(YearLevels.iTems[i]).FLevelSize > Level[i] then
      begin
        Result := False;
        Break;
      end;
    end;
end;

function GetUsersDir: string;
begin
  Result := Directories.ProgDir + '\Users';
end;

end.


