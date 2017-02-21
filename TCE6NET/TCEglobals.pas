unit TCEglobals;    {global variables and constants}

interface

uses  WinProcs, Graphics, Forms, classes, GlobalToTcAndTcextra;

const
  nmbrUsers=200;
  
  nmbrChanges=400;
  nmbrAddedTeachers=400;
  nmbrLikePreferences=5;
  nmbrReasons=60;   //was 30 for TCV5, TCV4
  nmbrnewclasses=100;
  nmbrmergedclasses=100;

  nmbrDays=10;
  nmbrHouse=50;
  nmbrCustomGroupMenus=16;
  nmbrSubYear=2000;
  nmbrSAA=160;
  nmbrBoxes=21;
  nmbrColourPairs=25;
  boxGap=1;
  Change5RecSize=30; {record size for Changes in TCE5}

                            {   $74ffff - yellow , any higher ie $75ffff and we get greyed}
  lf = chr(10);
  cr=chr(13); ht=chr(9);

  {timetable box selections}
  {string sizes}
  szAbcode = 3;
  szAbcode_xml = 10;
  szEcomment=30;
  szCovNotes=500; // previously 30
  // szEcomment is used by a number of fields so add a new one and make it longer for Absence Reason
  szAbReason = 60;
  
  szDirName=100;
  
  szTeMap=32;
  szFacName=15;
  szTslotcode=2;
  szIgnoreStatusMsg=15;
  szNote=30;
  {other sizes}
  szTTDayBlock=48100;

 {network version}
  szUserDirName=128;
  szTCEWP52rec=17+szPassID+szUserDirName;
     szTCP2rec=25;     {old one for load old users}


  InuseDataFile='TTinUse.DAT';
{window numbers}
  wnInfo=1;
  wnTecode=2;
  wnAddedStaff=3;
  wnTimes=4;
  wnAbsReason=5;
  wnCoverNote=6;
  wnAbsentTe=7;
  wnLostClass=8;
  wnAddedSel=9;
  wnNewClass=10;
  wnMergeClass=11;
  wnUnavailRooms=12;
  wnRoomSwap=13;
  wnCurrentExtras=14;
  wnPastExtras=15;
  wnSubjectList=16;
  wnTimeList=17;
  wnStudentList=18;
  wnStudentTt=19;
  wnTtable=20;
  wnTeacherTt=21;
  wnRoomTt=22;
  wnSubjectTt=23;
  wnFindStud=24;
  wnFindTeach=25;
  wnFindRoom=26;
  wnTeShow=27;
  wnRoShow=28;
  wnShowUsers=29;
  wnTeFree=30;

  {colour pairs}
  cpInfoHead=6;  {info window headings}
  cpInfo=7;   {info window text}
  cpTclash=8; {teacher clash}
  cpRclash=9; {room clash}
  cpTTblock=10;  {timetable block}
  cpDouble=11;   {timetable double}
  cpDoubleBlock=12; {blocked double}
  cpStList=13;  {student list}
  cpLost=14;  {map - lost class}
  cpCover=15; {map - cover}
  cpSwap=16;  {map - room swap, teacher replace}
  cpAbsent=17; {map - absent or room unavailable}
  cpCurrent=18; {current extras}
  cpAbsentSel=19; {absent selected}
  cpTimeSel=20; {selected time slot}
  cpBlockClash=21;

  {encryption key}
  KeyStrRt='©ªA¹X°¿NZVT FLFGRZF¶E@R±B¾G´·ºJß';

  {sort data}
  sortName: array[0..9] of string[7] =('none','code','name','comment','faculty','priority','*code','*name','*comment','*faculty');
  codeName: array[0..2] of string[10] =('subject','teacher','room'); {10 n$(2)}
  codeNameCap: array[0..2] of string[10] =('Subject','Teacher','Room');
  TslotUnitName: array[0..3] of string[10]=('Minutes','Hours','Periods','Units');
  nth: array[1..7] of string[10]=('first','second','third','fourth','fifth',
				  'sixth','seventh');
  month: array[0..12] of string[3]=('','Jan','Feb','Mar','Apr','May','Jun','Jul',
                                     'Aug','Sep','Oct','Nov','Dec');
  covershow: array[1..5] of string[10]=('All','Extra','Replace','In-lieu','Lost Class');


//======================================================
  accessType: array[0..8] of string[20] =('General','Timetabler','Student Data',
                                          'Blocking','Extras','Fees','Supervisor',
                                          '','');
  encryptStr: string[szPassword]='TIME CHART';
  encryptStrDIR: string[szUserDirName]='BART HAD A WITTLE TIME CHART WAMB, HER TIME'+
  ' CHART FWEECE WAS WHITE AS TIME CHART SNOW, AND EVERYWHERE THAT TIME CHART WENT, THE ';

//======================================================


  groupSortName: array[0..7] of string[10] =('Year','Name','Roll Class','House','ID',
                                            'Value ID','Tutor','Room');

  nmbrScrollHints=25;

  scrollHinttxt: array[1..nmbrScrollHints] of string{[70]}
    =({'1234567890123456789012345678901234567890123456789012345678901234567890'}
       'You are welcome to visit our web site any time at www.amig.com.au',
       'Press the Right mouse button for speedy pop-up menus',
       'The main window''s pop-up menu allows quick student group selection',
       'Bug reports can now be lodged at our web site',
       'Double click on an entry on the timetable to change it',

       'Pressing F1 provides context sensitive Help',
       'The web site has a Frequently Asked Questions section',
       'The On-line help is practically a full copy of the manual',
       'Click on a code in a code window and press Enter to change it',
       'Suggestions for improvements can now be lodged through our web site at'
        +' www.amig.com.au',

       'Move subject (blocking operation) is now a floating dialogue'
       +' and has a new step command to step a subject through the blocks',
       'Info window shows male and female numbers for each year',
       'Custom student groupings can now be created, named, saved and recalled',
       'Clash matrix print outs now make use of multi-page horizontal printing',
       'Blocks print outs now make use of multi-page horizontal printing',

       'Ctrl X, Ctrl C, Ctrl V now work as cut copy and paste shortcuts'
       +' for the timetable and block windows',
       'Double clicking listboxes now transfers all selected item to second'
       +' listbox, i.e. clash matrix selection dialogue',
       'The toolbars can be docked or floating',
       'The timetable entries dialogue is now interactive. Click on a different'
       +' place on the timetable while it''s open to edit that entry',
       'Student input sheets now make use of barcodes for speedy entry'
       +' of student choices',

       'Pressing V on the keyboard does the same as the view button',
       'Substituted local/network drives can be used for the backup drive',
       'We welcome written suggestions for improvements to Time Chart',
       'The web site has a discussion forum to exchange questions and answers',
       'Use File/New Data to check or set the location of the data files');


  type
      tpIntPoint=  ^smallint;
      tpBytePoint= ^byte;
      tpttprntselsubg=array[0..nmbrSubjects] of smallint;
      tpttprntselroomg=array[0..nmbrRooms] of smallint;
      tpSubData = array[0..nmbrSubjects] of smallint;
      tpStudentData = array[0..nmbrStudents] of smallint;
      tpChoices = array[0..nmbrChoices] of smallint;

 {network version types}
      tpPassData = array[0..nmbrUsers] of smallint;

      tpWinInt = array[0..nmbrWindows] of smallint;
      tpTeData = array[0..nmbrTeachers] of smallint;
      tpTe32Data = array[0..nmbrTeachers] of integer;
      tpExData = array[0..nmbrTeachers] of double;
      tpExAbsent = array[0..nmbrReasons] of string[szAbReason];
      //tpExCover = array[0..nmbrReasons] of string[szCovNotes];
      tpExCover = array[0..nmbrReasons] of string;
      tpTemap = array[0..nmbrTeachers] of string[sztemap];
      tpPeriodData = array[0..nmbrPeriods] of smallint;

      tpAddedData = array[0..nmbrAddedTeachers] of smallint;
      tpAdded32Data = array[0..nmbrAddedTeachers] of integer;
      tpAddedmax = array[0..nmbrAddedTeachers] of double;

      tpLikeData = array[0..nmbrTeachers,1..nmbrLikePreferences] of smallint;
      tpAllot = array[0..nmbrPeriods] of double;

      tplevelSub=array[0..nmbrClass] of smallint;
      tpTtDayBlock = array[1..szTTDayBlock] of byte;
      tpnewclass= array[0..nmbrnewclasses] of smallint;
      tpmergeclass= array[0..nmbrmergedclasses] of smallint;
      tpCustomArr=array[0..nmbrCustom] of string;
      tpWinPos=record
                      top:     smallint;
                      left:    smallint;
                      width:   smallint;
                      height:  smallint;
                      state:   Twindowstate;
                end;


      tpGroupIngredient=record
                          slct: smallint;
                          meth: smallint;
                          e1:   string[10];
                          e2:   string[10];
                         end;

      tpGroupMix=record
                   NumSteps: smallint;
                   steps: array of tpGroupIngredient;
                   SubOfferName: string;
                  end;

 type tpStudRec=record
                      StName:       string[szStName];
                      First:        string[szStName];
                      Choices:      tpChoices;
                      Sex:          string[1];
                      ID:           string[szID];
                      TcClass:      smallint;
                      TcYear:       smallint;
                      House:        smallint;
                      Tutor:        smallint;
                      Home:         smallint;
                      TcTag:        word;
                      StrRecord:    smallint;
                     end;

type tpChangeRec=record
                        timeslot:  integer;
                        year:      smallint;
                        level:     smallint;
                        sub:       smallint;
                        gen:       smallint;
                        oldte:      smallint;
                        newte:      smallint;
                        oldroom:    smallint;
                        newroom:    smallint;
                        kind:       smallint;
                        needte:     smallint;
                        needroom:   smallint;
                        notes:      smallint;
                        reason:     smallint;
                        // reasons:     string; // Bryan - support for multi-reasons
                     end;

var

  HaveDataLock: bool;
{passwords}
  passcount: array[0..10] of smallint;

  defDataDir:   String[szDirName];

  usrPassTime:            string[8];
  usrPassDate:            string[8];
  usrPassLevel:           smallint;
  usrPassDir:             string[szUserDirName];
  usrPassUse:             smallint;
  usrPassYear:            smallint;
  usrPassID:              string[szPassID];
  usrPassword:            string[szPassword];
  usrPassBKUP:            boolean;
  usrpassAlter:           bool;
  usrPassRecord:          smallint;


  NEW_DateChecks:         array[0..20] of tDateTime;

  MouldyDataCheckTime: smallint;
  MouldAge:            smallint;


  TCE5Error:    integer;
  fgsubBySubListZeroSkip:     wordbool;
  globalHints:                wordbool;
  OKbackup:                   wordbool;
  OKquitcheck:                wordbool;
  EnableAutoFlag,ToolBarAuto: wordbool;
  ToolBarFlag:                boolean;
  GenericTtableFlag:          wordbool;
  
  studText,genText:           ansistring;

  UseGroupFindStud:           wordbool;
  MatchAllYears:      boolean;

  {Timetable In Use variables}
  TtInUseNum:               smallint=1;
  TtInUseName               : string;
  TtInUseCalendar           : string='';

  {global flags}
  KeepReplaceFlag:            wordbool;
  newdataloadcancel:          wordbool;
  scalingGridCellsFlag:       wordbool;
  loadFinished:               wordbool;
  wnFlag: array[0..nmbrWindows] of boolean;
  showHintsDlg:               wordbool;
  customFileLoad:             string;
  customFileLoadFlag:         wordbool;
  winView,winViewMax: tpWinInt;

  {fonts}
  tcfont,previewfont:         Tfont;
  txtHeight:                  smallint;
  Hmargin:                    smallint;
  blankwidth:                 smallint;
  Formfeed:                   wordbool;

  {teachers  free dlg}
  TeFreeSelect         : tpTeData;
  teachersfreeday               : smallint;
  TeFreePeriod            : smallint;
  teachersfreefac               : smallint;
  teachersfreeshow1             : smallint; {1..3, time slot/frees/teacher}
  teachersfreeshow2             : smallint; {1..3, all/selection/year }
  teFreeYear                    : smallint;

  {current extras}
  winCurrentExtrasyear:       smallint;
  winCurrentExtrasBrief2:     smallint;
  IncludeShareFlag:           boolean;

  SubShareFlag:               boolean;   {shared subject flag}
  ShareSub,ShareYear:         smallint;

  winCurrentExtrasSelection: array[1..3] of tpTeData;
  winCurrentExtrasSelectionCount: array[1..3] of smallint;
  winCurrentExtrasCode:       smallint;

  {past extras}
  NeedPastExtrasINITflag:     boolean;
  winPastExtrasyear:          smallint;
  winPastExtrasBrief2:        smallint;
  winPastExtrasSelection: array[1..5,0..nmbrTeachers] of smallint;
  winPastExtrasSelectionCount: array[1..5] of smallint;
  winPastExtrasCode:          smallint;
  winPastExtrasDay1,winPastExtrasDay2,
  winPastExtrasMonth1,winPastExtrasMonth2: smallint;

  {for DISPLAY.DAT}
  winOrder:       tpWinInt;
  winOrderNum:                     smallint;
  prefNotebookPageIndex:           smallint;
  letterW:                         smallint;
  letterWprnt:                     smallint;
  colorPrinterFlag:                boolean;

  {extras data} 
  Emax:                            tpExdata;     {maximum extras}
  Etaken:                          tpExdata;     {extras taken}
  Eweek:                           tpExdata;     {extras taken in week}
  Eday:                            tpTeData;     {day of last extra}
  Emonth:                          tpTeData;     {month of last extra}
  LikeDay:                         tpLikeData;   {preferred day for extra}
  LikeTime:                        tpLikeData;   {preferred time for extra}
  Elieu:                           tpExData;     {maximum in lieus}
  Elieutaken:                      tpExData;     {in lieus taken}
  Ereplace:                        tpExData;     {replacements available}
  Eten:                            tpTeData;     {bit map for last 10 days}
  Ecomment:   array[0..nmbrTeachers] of string[szEcomment];
  EUserChanged: array[0..nmbrTeachers] of Boolean;
  Abcode:     array[0..nmbrReasons] of string[szAbcode_xml]; {absence reason code}
  Absent:                          tpExAbsent;
  Cover:                           tpExCover; // tpExAbsent;
  Eallot:  array[0..nmbryears,0..nmbrdays,0..nmbrperiods] of double;
  CusEallotYear,  cusEallotDay: smallint; {for display view}

  //ExNote:     array[0..nmbrChanges] of string[szCovNotes];  // previous size was szNote.. Mantis 1333
  ExNote:     array[0..nmbrChanges] of string;
  {AM}

  IgnoreStatusMsg:                 string[szIgnoreStatusMsg];
  IgnoreStatusMsgFlag:             boolean;

  Exday,   {day}
  Exmonth,  {month}
  Exyear,   {year}
  ttday:                           smallint;  {DAY}

  ttroom,ttsub,ttlevel,ttyear,tsharecount:  smallint;
  ttshare:  byte;
  ttfound:  boolean;

  Changes:   array[0..nmbrChanges] of tpChangeRec;
  ignoredChangesCount:   smallint;

   Tneed,
   Tgot,
   Tavail,
   Rneed,
   Rgot,
   Ravail:      tpPeriodData;
   treq:        array[0..nmbrPeriods] of double;
   trequire,
   rrequire,
   treplace,
   tlieu,
   rlost,
   eavail,
   textra,
   rextra:     tpPeriodData;


 ntime,nyear,nsub,nlevel,nstaff,nrooms,nflag: tpnewclass;
 mtime,mkind,msub,myear,mlevel,moldte,mnewte,moldroom,mnewroom,mflag: tpmergeclass;

 consequent,contime:         array[0..nmbrChanges] of smallint;
 consequentnum:              smallint;
 teon:                       tpTe32Data;    {1=available, 0=not available}
 teavail:                    tpexdata;   {available time for replacement classes}
 teabsent:                   tpTe32Data;  {1=available, 0=absent}
 doingextra:                 tpexdata;    {allotment - doing extras today}
 teach:                      tpTe32Data;  {1=free on timetable, 0=on timetable}
 telost:                     tpte32data;  {1=not lost, 0=lost class}
 tabsReason:                 tptedata;    {reason for absence}
                                          { making this as a default..
                                            for backward compatibility .. Bryan }
 //tabsReasons:                tptemap;    { support for multi-absences .. Bryan }
 tecover:                    tpte32data;   { 1=no cover, 0-cover extra}
 telieu:                     tpte32data;   {1=no inlieu, 0=in lieu class}
 telieudbl:                  tpexdata;     {available time for in lieu classes}
 tereplace:                  tpte32data;   {1=no replace, 0=replacement class}
 temap:                      tptemap;
 tena:                       tpte32data;  {1=no NA code, 0=NA code (on timetable)}

 roomon:                     tpte32data;
 roabsent:                   tpte32data;
 roomteach:                  tpte32data;
 rocover:                    tpte32data;
 roswap:                     tpte32data;
 rolost:                     tpte32data;
 romap:                      tptemap;

 Abreason:                   tpTedata;

 {Past Extras}
 AbsentTotal:                smallint;  {number in file}
 numabsences:                smallint;  {number in array}
 StartDate,EndDate:          integer;
 firstday,firstmonth,lastday,lastmonth: smallint;
 nmbrReasonsInUse:           smallint;
 nmbrCoverInUse:             smallint;

 Torder:             array[0..nmbrPeriods,0..nmbrDays] of smallint;
 Tslotcode:          array [0..nmbrPeriods,0..nmbrDays] of string[sztslotcode];
 numDayGroups,numYearGroups: smallint;
 DayGroup:            array[0..nmbrDays] of smallint;
 YearGroup:           array[0..nmbrYears] of smallint;
 yg: array[0..nmbryears,0..nmbryears] of smallint;
 dg: array[0..nmbrdays,0..nmbrdays] of smallint;

 CoverYear:             array[0..nmbrYears] of boolean;

 ESprint, ESteach, ESreason, EStlost, ESroom,
 ESrlost, ESadd,   ESnew,    ESmerge:    boolean;
  shareExclude,teamExclude:               boolean;
  edLostClassYear,edLostClassSub,edLostClassClass,
  edLostClassLevto,edLostClassLevfrom,edLostClassBy:  smallint;

  EPteach, EProom,  EPreason, EPlist:     boolean;
  EPTimes : boolean;
  EPblank,
  PEday1,
  PEmonth1,
  PEday2,
  PEmonth2,
  PEdetail,
  PEcover:    smallint;
  ETnum,
  ETnum1,
  ETselected,
  ETcover,ETplace,place,
  ETLencodes:  smallint;

  {Cover dialogue}
  ShowCoverTimetable:  boolean;
  ExcoverTop,ExcoverLeft,ManCoverTop,ManCoverLeft: integer;
  autocover, coverall, coverstart,
  WtET, WtFrees, WtToday, WtAvail, WtPerc, WtETfac, WtWeek, WtLastNum,
  WtLast, Wtfac, WtSpare, WtLieu, WtReplace, WtPrefer:   smallint;

  numchanges,  notenum:   smallint;

  Etsub:      array[0..nmbrAddedTeachers] of string[szTecode];
  Etname:     array[0..nmbrAddedTeachers] of string[szTename];
  Ettaught:   tpAddedmax;
  Eton:       tpAdded32Data;
  // #171
  //Etcomment:  array[0..nmbrAddedTeachers] of string[szEcomment];
  Etcomment:  array[0..nmbrAddedTeachers] of string;

  Etavail:    tpAdded32Data;
  Etfaculty:  tpAddeddata;
  // #171
  EtFaculty2: tpAddeddata;
  EtFaculty3: tpAddeddata;
  EtFaculty4: tpAddeddata;
  // #173
  EtPhone:    array[0..nmbrAddedTeachers] of string[15];
  EtPriority: tpAddedData;
  ETMon:      tpAddedData;
  ETTue:      tpAddedData;
  ETWed:      tpAddedData;
  ETThu:      tpAddedData;
  ETFri:      tpAddedData;
  ETSat:      tpAddedData;
  ETSun:      tpAddedData;

  Etlink:     tpAddeddata;
  telink:     tptedata;
  Etpointer:  tpAddeddata;
  Etpointer2: tpAddeddata;
  Etmax:      tpAddedmax;

  SubSexCountFlg: boolean;

  {stud list win}
  UpdateStudListFlg:    boolean;
  StudListType:       smallint;  {1-7}
  listNumbertype: smallint;  {1-5}
  listEnrolment:  wordbool;
  listRanges:    array[1..4,1..2] of smallint; {class to & from, then house then tutor then room}
  liststudentselection:  tpstudentdata;

   {stud ttable}
  studentttselection: tpstudentdata;
  stuttlistSelection: smallint;
  stuttlistVals:      array[1..8] of smallint;
  {stud find}
  studfindtype:       wordbool;
  studfindnum:        smallint;
  tefindnum,rofindnum: smallint;
  teshownum,roshownum: smallint;

  {teach ttable}
  TeTTSelection:       tpteData;
  TeTTSelType:         smallint;
  TeTTListVals:        array[1..5] of smallint;
  {room ttable}
  RoTTSelection:       tpteData;
  RoTTSeltype:         smallint;
  RoTTListVals:        array[1..5] of smallint;
  {sub ttable}
  SubTTListSelection:  smallint;
  SubTTListVals:       array[1..4] of smallint;
  SubTTGroupCnt:       smallint;
  SubTTGroup:          tplevelsub;
  SubTTWide:           boolean;

  {tt print selection dlg}
  ttprntselsubg:      tpSubData;
  ttprntselteachg:    tpTeData;
  ttprntselroomg:     tpTeData;
  ttprntseltype:      smallint;
  ttPrntFac:    smallint;
  ttprntselday:       smallint;
  ttprntselyear:      smallint;
  ttPrntType:  smallint;

  {sub list win}
  subBySubListType:          smallint;
  sublistYear:               smallint;
  subBySubListTypeGroupnum:  smallint;
  sublistRanges:  array[-2..nmbrOfGroupSubjects] of smallint;
  {-2 & -1 ==> sub range, 0 = count for group 1+ is group}
  sublistfacnum:  smallint;
  sublistday,sublisttime1,sublisttime2:   smallint;
  sublistfree:              smallint;

  {fontWidths}
  fwCode:       array[0..2] of smallint;
  fwTemail:     smallint;
  fwETmail:     smallint;
  fwCodeBlank:  array[0..2] of smallint;  {used for ttable}
  fwCodename:   array[0..2] of smallint;
  fwStName:     smallint;
  fwHouse:      smallint;
  fwFaculty:    smallint;
  fwSex:        smallint;
  fwID:         smallint;
  fwClass:      smallint;
  fwYearname:   smallint;
  fwPeriodname: smallint;
  fwTimeUnit                    : smallint;
  fwTsName:  array[0..nmbrdays] of smallint;
  fwTsCode                      : smallint;
  fwDayname:    smallint;
  fwDay:        smallint;
  fwTeDutycode: smallint;
  fwTeDutyLoad: smallint;
  fwTeComment: smallint;
  fwAddedStaffcode: smallint;
  fwAddedStaffname: smallint;
  fwAddedComment:   smallint;
  fwCoverNote:      smallint;
  fwAbsence:        smallint;

  {printing}
  PrinterOn,PreviewOn,TextFileOut,CopyOut: boolean;
  myCopyString:     String;
  PreviewWin:       smallint;
  fwprntCode:       array[0..2] of smallint;
  fwprntTemail:     smallint;
  fwprntETmail:     smallint;    
  fwprntCodeBlank:  array[0..2] of smallint;  {used for ttable}
  fwprntCodename:   array[0..2] of smallint;
  fwprntStName:     smallint;
  fwprntHouse:      smallint;
  fwprntFaculty:    smallint;
  fwprntSex:        smallint;
  fwprntID:         smallint;
  fwprntClass:      smallint;
  fwprntYearname:   smallint;
  fwprntPeriodname: smallint;
  fwprntTsName:  array[0..nmbrdays] of smallint;
  fwprntTsCode                  : smallint;
  fwprntDayname:    smallint;
  fwprntDay:        smallint;
  fwprntTeDutycode: smallint;
  fwPrntTeDutyLoad: smallint;
  fwPrntTeComment:  smallint;
  fwprntAddedStaffcode: smallint;
  fwprntAddedStaffname: smallint;
  fwprntAddedComment: smallint;
  fwPrntCoverNote:      smallint;
  fwprntAbsence:        smallint;

  prnttxtHeight:    smallint;
  prntHmargin:      integer; {canvas units}
  prntVmargin:      integer;
  prntLeftMargin,
  prntTopMargin:    single; {keep cm wanted}

  prntblankwidth:   smallint;

  {General}
  School:       String[szSchool];
  TCvers:       String[szTCvers];  {20 TCvers$}
  NumCodes:     array[0..2] of smallint;  {nsub(2)}  {subject,teacher,room}
  LenCodes:     array[0..2] of smallint;  {lsub(2)}
  LenClassCodes: smallint;
  TC4fileHeader:        String[4];
  FontColorPair:   array[0..nmbrColourPairs,1..2] of tcolor;
  FontColorHiLitePair:   array[0..nmbrColourPairs,1..2] of tcolor;  


  winpos:       array[0..nmbrWindows] of tpWinPos;
  {timetable data}
  Lnum:         smallint;
  TcLabel:      array[0..nmbrLabels] of String[szTcLabel];

  ttMain:        array[0..nmbrDays-1] of ^tpTtDayBlock;


  {flags for saving}
  AlterTimeFlag:       wordbool;

{student data}

  RollClassPoint:     array of smallint;
  StGroup:          array of smallint;
  StPointer:         array of smallint;
  StudSort:       array of smallint;

  StudGrpFlg:     array of smallint;
  {Groups of Students - GOS}
  GOSnum:  smallint;
  GOSrecipe:    tpGroupMix;  {using zero rec for count only}
  GOS:      array of tpGroupMix;
  GOSname:      array of string[250];
  GOSmenu:      array [0..nmbrCustomGroupMenus] of smallint;

  sortChangeFlag:        wordbool;
  numstud:               smallint;
  chmax:                 smallint;
  IDlen:                 smallint;
  boxwidth,prntBoxWidth:              smallint;
 yearStat:     array[0..nmbryears] of record
                         numstud:      smallint;
                         chmax:        smallint;
                         idlen:        smallint;
                         recordsize:   smallint;
                         namelen:      smallint;
                         malenum:      smallint;
                         femalenum:    smallint;
                       end;

  { - - - -  DYNAMIC STUDENT DATA - - - - }
  Stud:  array of tpStudRec;

   {group data}
  GroupName:  string[20]; {group$}
  GroupType:  smallint;     {Gtype}
  GroupSort:  smallint;     {Gsort}
  GroupNum:   smallint;     {Gnum}
  groupSelStr:             array[1..2] of string;


  {year data}
  yearTitle:            string[10]; {Y$}
  yearShort:            string[10]; {Yshort$}
//  currentYear:          smallint;   {year}
  Yearname:             array[0..nmbrYears] of String[szYearname];  {10 yearname$(10)}
  GroupSubs:     array of smallint;  {replaces subyear^}
  GroupSubCount: array of smallint;  {replaces student^}
  GsubXref : array of smallint;  {replaces subyearcode^}

  {day data}
  DateStr:      string[30];  {30 date$}
  Day:          array[0..nmbrDays] of String[szDay];  {60 Day$  CHANGE TO 5 Day$(10)}
  Dayname:      array[0..nmbrDays] of String[szDayname]; {10 dayname$(10)}
  PeriodName:   array[0..nmbrPeriods] of String[szPeriodName];

         {Time Chart variable time slots in each day}
// tsCode, tsName, tsOn, tsAllot, tsStart, tsEnd are zero based
// eg tsOn[0,0] is flag for Monday, period 1.
  tsCode:          array [0..nmbrDays,0..nmbrPeriods] of string[sztslotcode];
  TimeSlotName: array [0..nmbrDays,0..nmbrPeriods] of String[szPeriodName];
  tsOn: array  [0..nmbrDays,0..nmbrPeriods] of boolean;
  tsShow: array[0..nmbrDays,0..nmbrPeriods] of smallint;
  tsDg: array[0..nmbrdays,0..nmbrdays] of smallint;

  tsAllot:  array[0..nmbrdays,0..nmbrperiods] of double;
  tsStart,tsEnd:  array[0..nmbrdays,0..nmbrperiods] of TDateTime;
  TslotUnit,SlotUnitDec,SlotUnitMain: smallint;  {kind of unit, decimal and main places}
  DayOfMaxPeriods,tsShowMax: smallint;
  tsShowMaxDay: array[0..nmbrdays] of smallint;
  WeekMaxLoad: smallint;
  BaseAllot                     : array [0..nmbrPeriods] of double;
  tsNumDayGroups: smallint;
  tsDayGroup:            array[0..nmbrDays] of smallint;

  {names of files}
  TimeTableFileName:       String;
  TextFileName: String;
  timefile:     String;
  newtimeFile:  String;
  custom:       String;
  usefile:      String;
  exfile:       String;

  accessfile:   string;
  namefile:     string;
  passfile:     string;

  ttAccessPos:  smallint; {ttfile name access position}
  blAccessPos:  smallint; {blockfile name access position}
  ttAccess:     boolean;
  blockAccess:  array[0..nmbryears] of boolean;
  yearAccess:   array[0..nmbryears] of boolean;

  {names of directories}
  progdir:      String[szDirName];
  datadir:      String[szDirName];
  textdir:      String[szDirName];
  timedir:      String[szDirName];
  backupDir:    String[szDirName];

  usedir:       String[szDirName];
  exdir:        String[szDirName];
  exload:       String[szDirName];
  userDir:      String[szUserDirName];

  ourSafetyMemStream: TStream;
  ourSafetyMemStreamStr: string;

  {printer settings}
  datestamp:    boolean;
  double_space: wordbool;
  double_print: smallint;

  {display settings}
  DOSscreenmem: string[20];
  sexselect:    smallint;
  sTselect:     smallint;
  Tfreeshow:    boolean;
  Rfreeshow:    boolean;
  Tyr:          smallint;
  Txtsep:       smallint;
  Txtlim:       smallint;
  FAsubnum:     smallint;
  Pyear:        array[0..nmbrYears] of boolean;
  Tlimit:       array[0..nmbrDays] of smallint;
  ttcalcD,ttcalcP,ttcalcY,ttcalcL:     smallint;
  TlimitTotal:  smallint;

  Dprint:       array[0..nmbrDays] of boolean;
  Pweek:        smallint;
  PweekCount:   smallint;

   {Student Display settings}
  sTsex:        boolean;
  sTclass:      boolean;
  sThouse:      boolean;
  sTtutor:      boolean;
  sThome:       boolean;
  sTID:         boolean;
  sTyear:       boolean;
  stBarcode:    boolean;

  ClassShown:          array[0..nmbrLevels,0..nmbrYears] of smallint;    {whether to show on tt}
  ClassCode:  array of string[szClassName];
  Classnum:            smallint;
  ClassCount:          smallint;

  {house data}
  HouseName:        array[0..nmbrHouse] of String[szHouseName];
  HouseCount:        smallint;

  {subject data}
  SubCode:          array of String[szSubCode];
  Subname:          array[0..nmbrSubjects] of String[szSubnameMax];
  snsize:           smallint;
  subNA:            smallint;  {Not Available code)

  {custom data}
  Add:              array[0..nmbrCustom] of String[szCustomAdd];
  customTab:        array[0..nmbrCustom] of smallint;
  AddNum:           smallint;
  gotCustom:        boolean;

  {backup data}
  backup_number:        smallint;
  backup_action:        smallint; {1=backup, 2=restore}
  backup_drive:         string[3];


  {teacher/room data}
  TeCode:       array[0..nmbrTeachers,0..1] of String[szTeCode];
     {0- teachers ;  1-rooms ;  }
  TeName:       array[0..nmbrTeachers,0..1] of String[szTeName];
  Load:         tpTeData;
  Tfaculty:     array[0..nmbrTeachers,1..nmbrTeFacs] of smallint;
  Temail,ETmail:       array of string;
  EmailHost,EmailUserID,EmailPassword:  string;
  EmailSend,EmailDisplayName: string;
  EmailPort: Integer;
  EmailCoverFlag,EmailAbsentFlag,EmailAddedFlag:  wordbool;
  EmailPlainSMTP: wordbool;
  RoSize:       tpTeData;
  Rfaculty:     array[0..nmbrTeachers,1..3] of smallint;
  DutyLoad:     array[0..nmbrTeachers,0..2] of double;
  DutyCode:     array[0..nmbrTeachers,0..2] of String[szDutyCode];
  {Cover dialogue arrays}
  prefer,tepoint:    tptedata;
  teload:            tpExdata;
  TeActualLoad: array of double;

 {faculty data}
 facCount:           array[0..nmbrFaculty] of smallint;  {fa(30)}
 facName:            array[0..nmbrFaculty] of string[szFacName];{fa$(30)}
 facSubs:            array[0..nmbrFaculty,0..nmbrSubsInFaculty] of smallint;
 facNum:             smallint; {fn}

 {sort data}
 sortType:       array [0..2] of smallint; {0,1, or 2}
 code:           smallint;
 codepoint:      array[0..nmbrSubjects,0..2] of smallint;
 codenum:        array[0..2] of smallint;
 codeCount: array [0..2] of smallint;

  {debug}
 dbgi,dbgj,dbgk,dbgm:      smallint;
 dbgstr: string;
 dbgbool:                  boolean;
 dbgdword:                 dword;
 scrollHint:               wordbool;

 assorttype:               smallint;

 asSelsorttype:            smallint;

 abcodepoint:              tpTeData;
 absorttype:               smallint;

 lccodepoint:              tpTeData;
 lcsorttype:               smallint;

 CustomArr:                tpCustomArr;
 CustomCnt:                smallint;

(*
 *****************  DATA DEFINITIONS  ********************
 

Time Chart Extra 5 - File Structures and Variables

Variable Prefixes
  nmbr: number
  bx: box
  sz: string size
  wn: window number
  cp: colour pair
  tp: type
  te: teacher
  ro: room
  PE: past extras
  ET: emergency teacher (added staff)
  Wt: weight
  fw: font width
  fwprnt: font width printer
  ts: time slot
  ab: auto build
  ES: Extras Summary
  sT: student
  tt: timetable


Files

EXTRAS.XTR - all extras for a day stored in file with .XTR extension.
 Default is EXTRAS.XTR
TEAVAIL.DAT - running totals of tallies (extras, in lieus, last extra) plus preferred times
EXFILE.DAT - stores name of extras file currently in use
REASON.DAT - absence codes and reasons, preset cover notes
COVERSET.DAT - Cover weights
EMTEACH.DAT - added staff (emergency teachers) codes, names and faculties
EXALLOT.DAT - time allotments, order and codes for each day, year and time slot
EmailSetup.DAT - encrypted file with data for connecting to email.
TEMAIL.DAT - text file with teacher's email addresses.
custom add on files - .CUS (same format as Time Chart)
EXDISPLAY5.DAT - display file for open windows and dialogue settings



Files from Time Chart

Timetable - .TTW sequential file format from windows version
Subjects - SUBCODE.DAT and SUBNAME.DAT
Teachers - TECODE.DAT, TENAME.DAT, TELOAD.DAT
Rooms - ROOMS.DAT, ROOMNAME.DAT, ROLOAD.DAT
Faculties - FACULTY.DAT
roll class codes - CLASS.DAT (does not read CLASSn.DAT files)
Houses - HOUSE.DAT
Time Chart time allotments - ALLOT.DAT
Group definitions - GROUP.DAT
Students - CHOICE1.ST, CHOICE2.ST, ...

 


File Structures

EXTRAS.XTR (main extras file, also any other .XTR work ahead file)
 4 byte string ('TCE5')
 exday: (2 byte integer) calendar day 
 exmonth:  (2 byte integer) calendar month
 exyear:  (2 byte integer) calendar year
 ttDay:  (2 byte integer) timetable day
 tenum:  (2 byte integer) number of teachers
   for i:=1 to teNum 
	teon:  (4 byte bit map) teacher on/off available
        teAbsent:  (4 byte bit map) teacher absent
        telost:  (4 byte bit map) teacher lost class
        teCover:  (4 byte bit map) teacher cover class
        tereplace:  (4 byte bit map) replacement class
        tElieu:  (4 byte bit map) in lieu class
        teavail: (8 byte real) available for replacement
        telieudbl: (8 byte real) available for in lieus
        tabsreason: (2 byte integer) absence reason
 ETnumTemp:  (2 byte integer) number of added staff
   for i:=1 to ETnumTemp
	ETlink:  (2 byte integer) linked teacher
        Eton:  (4 byte bit map) ET on/off teaching
        ETavail:  (4 byte bit map) ET availability
        Etmax: (8 byte real) ET maximum load
 roNum:  (2 byte integer) number of rooms
   for i:=1 to roNum
	roomon:  (4 byte bit map) room on/off
        roAbsent:  (4 byte bit map) room unavailable
        roswap:  (4 byte bit map) room swapped
        roCover:  (4 byte bit map) room cover
        rolost:  (4 byte bit map) room lost class
 numchanges:  (2 byte integer) number of changes
   for i:=1 to numchanges read Changes record
 notenum:  (2 byte integer) number of cover notes
   for i:=1 to notenum read exnote (string of 30 char)
     

EmailSetup.DAT - encrypted text file.
 5 lines, lines for email host, user ID, password, sender's email, sender's name

TEMAIL.DAT - text file.
 First line has number of email addresses.  Followed by email addresses (one per line),
 matching tecodes order.

EXFILE.DAT - text file with 2 lines: current extras file name , current extras directory
(data directory is default, extras directory on

COVERSET.DAT
 4 byte string ('TCE5') 
 WtET (2 byte integer) for added staff weight
 WtFrees (2 byte integer) for frees in day
 WtToday (2 byte integer) for extras done today
 WtAvail (2 byte integer) for available extras left 
 WtPerc (2 byte integer) for percentage of available extras left
 WtETfac (2 byte integer) for added staff same faculty
 WtWeek (2 byte integer) for extras done in week
 WtLastNum (2 byte integer) for number of days (n) for last n days
 WtLast (2 byte integer) for last n days
 Wtfac (2 byte integer) for same faculty
 WtSpare (2 byte integer) for spare on either side of extra
 WtLieu (2 byte integer) for in lieus
 WtReplace (2 byte integer) for replacement
 WtPrefer (2 byte integer) for preferred time slot
 KeepReplaceFlag (2 byte word boolean) to keep lost classes not used


EXALLOT.DAT
 bytes 0-3: header string 'TCE5'
 tmpY (2 byte integer): years-1
 tmpD (2 byte integer): days-1
 tmpP (2 byte integer): periods
 for i:=0 to tmpD read DayGroup[i] (2 byte integer): daygroup number for each day
 for i:=0 to tmpY read YearGroup[i] (2 byte integer): yeargroup number for each year
 for j:=0 to tmpD do
       for k:=1 to tmpP do
            read torder[k,j] (2 byte integer): time slot order for period and day
            read tslotcode[k,j] (1 byte string): time slot code for period and day

 for i:=0 to tmpY do
       for j:=0 to tmpD do
           for k:=1 to tmpP do
              read Eallot[i,j,k] (8 byte real number for time allotment

ABSENT.DAT - past extras file of past extras records.
record 0: bytes 0-3 version string 'TCE5'
          bytes 4-5 2 byte integer: number of records
 

EMTEACH.DAT - added staff information
  bytes 0-3 header string 'TCV4'
  ETnum: 2 byte integer - number of added staff
  ETlencodes: 2 byte integer - length of codes
 followed by records for each added staff:
  ETsub - string of length ETlencodes
  ETname - 25 char string
  comment - 30 char string 
  faculty - 2 byte integer for faculty number

REASON.DAT - absence reasons and preset cover notes
 bytes 0-3 header string 'TCV4'
    for i:=1 to nmbrReasons (30) do
       read absence code (string of 3 char),
            absence reason (string of 30 char)
    for i:=1 to nmbrReasons do
     read cover note (string of 30 char)

TEAVAIL.DAT - teacher tallies
 bytes 0-3 header string 'TCE5' 
   for i:=1 to num teacher codes
	Emax:  8 byte real number: maximum extras
	Etaken:  8 byte real number: extras taken
	Elieu:   8 byte real number: maximum in-lieus
	Elieutaken: 8 byte real number: in-lieus taken
	Ereplace: 8 byte real number: replacements available
	Eweek: 8 byte real number: extras in week
	Eday: 2 byte integer: day of last extra
	Emonth: 2 byte integer: month of last extra
	for j:=1 to nmbrLikePreferences(5)
		LikEday: 2 byte integer: preferred timetable day 
		LikeTime: 2 byte integer: preferred time slot
	Eten: 2 byte integer: bit map of extras in last 10 days
	Ecomment: comment (string of 30 char)






        
Data Structures

Changes Array - stores all changes for the current day.

 Changes Record
                        timeslot:  4 byte integer: either time slot or bit map of times
                        year:      2 byte integer: timetable year
                        level:     2 byte integer: timetable level
                        sub:       2 byte integer: subject
                        gen:       2 byte integer: how change is generated
                        oldte:     2 byte integer: old teacher
                        newte:     2 byte integer: new teacher
                        oldroom:   2 byte integer: old room
                        newroom:   2 byte integer: new room
                        kind:      2 byte integer: kind of cover
                        needte:    2 byte integer: (<>0 teacher needed)
                        needroom:  2 byte integer: (0=no change,1=needed, 2=filled)
                        notes:     2 byte integer: cover note number
                        reason:    2 byte integer: absence reason, or consequential change no.

	legend for gen: (how change is generated)                    
		0 - room change only
		1 - absent teacher
		2 - new class
		3 - merged class
		4 - absent teacher map of absent times (in past extras)
		5 - consequential change - room change only
		6 - consequential change - teacher change
		7 - lost classes map of lost times (in past extras)

	legend for kind: (kind of cover)
		0 - no teacher change
		1 - added staff
		2 - replacement class
		3 - in lieu class
		4 - extra
		5 - shared class
		6 - teacher swap
		10 - ignore change


 Past Absence Record
                     aday:        2 byte integer: calendar day
                     amonth:      2 byte integer: calendar month
                     atimeslot:   4 byte integer: either time slot or bit map of times
                     ayear:       2 byte integer: timetable year
                     asub:        2 byte integer: subject
                     aoldte:      2 byte integer: old teacher
                     anewte:      2 byte integer: new teacher
                     akind:       2 byte integer: kind of change
                     areason:     2 byte integer: absence reason
                     agen:        2 byte integer: cause of change
                     attday:      2 byte integer: timetable day

Variables:

Added Staff (Emergency Teachers ET)
 ETnum - Number of added staff
 ETsub, ETname, ETcomment, ETfaculty - basic data
 ETlink: linked teacher - 0=no link, >0=temp link, <0=permanent link

Teachers
 TabsReason: reason for absence
 temap: string showing map of day

Absence
 Absent: absence reason (string)
 Abcode: absence reason code (string)


Added Staff bitmaps
	ETon: 1=available, 0=teaching
	ETavail: 1=available, 0=not at school (not available)	

Teacher Bitmaps
	teOn: 1=available, 0=not available (teaching, extra, replacement, etc)
	teach: 1=free on timetable, 0=on timetable
	teAbsent: 1=available, 0=absent
	telost: 1=not lost, 0=lost class
	tecover: 1=no cover, 0-cover extra
	teReplace: 1=no replace, 0=replacement class
	telieu: 1=no inlieu, 0=in lieu class
	teNA: 1=no NA code, 0=NA code (on timetable)

Room Bitmaps
	RoomOn: 1=available, 0=not available
	RoomTeach: 1=free on timetable, 0=on timetable
	RoAbsent: 1=available, 0=unavailable
	RoSwap: 1=no swap, 0=swap
	RoCover: 1=no cover, 0=cover
	RoLost: 1=not lost, 0=lost class

Added Staff Time Allotments
	ETmax: maximum allotment for day
	ETtaught: teaching allotment for day

Teacher Time Allotments
	teload: teaching load on timetable (NA's excluded)
	teAvail: available time for replacement classes
	teLieuDbl: available time for in lieu classes
	Emax: maximum extras
	Etaken:  extras taken
	Elieu:   maximum in-lieus
	Elieutaken: in-lieus taken
	Ereplace: replacements available
	Eweek: extras in week 
                    
New Classes arrays
 ntime: bitmap of times, 1=nochange, 0=change needed
 nyear,nsub,nlevel,nstaff,nrooms,nflag
  

Merge Classes arrays
 mtime,mkind,msub,myear,mlevel,moldte,mnewte,moldroom,mnewroom,mflag

Resources: Tneed, Tgot, Tavail, Rneed, Rgot, Ravail

Map Symbols
	- free
	T teaching
	L lost class
	C cover (extra)
	S swap (room)
	U unavailable room
	N Not available (teacher)
	R replace
	I in lieu
	A absent (cover needed)
	a absent (no cover needed - not teaching)
	F free (added staff available to teach)

Weight Variables	default
	WtET 		9999	ETfree
	WtFrees		1 	Tlimit[DAY]-teload
	WtToday		-3
	WtAvail		1	Emax-Etaken
	WtETfac		1	ETfaculty
	WtPerc		20	(Emax-Etaken)/Emax
	WtWeek		-1	Eweek
	WtLastNum	3	last n days (1-10)
	WtLast		-2	Eten
	WtFac		1
	WtSpare		1
	WtLieu		4000
	WtReplace	5000
	WtRefer		1	


File and Directory names	
 exfile - current file loaded
 usefile - current file 'in use' for today
 exload - directory of file loaded
 usedir - directory of file in use

Time Chart Extra - Previous versions

Files

COVERSET.DAT - time slot codes, order of codes, cover weights

File Structures

EXTRAS.XTR (Version 4 format)
 4 byte string ('TCV4')
 exday: (2 byte integer) calendar day 
 exmonth:  (2 byte integer) calendar month
 exyear:  (2 byte integer) calendar year
 ttDay:  (2 byte integer) timetable day
 tenum:  (2 byte integer) number of teachers
   for i:=1 to teNum 
	teon:  (2 byte bit map) teacher on/off available
        teAbsent:  (2 byte bit map) teacher absent
        telost:  (2 byte bit map) teacher lost class
        teCover:  (2 byte bit map) teacher cover class
        tereplace:  (2 byte bit map) replacement class
        tElieu:  (2 byte bit map) in lieu class
        teavail: (8 byte real) available for replacement
        telieudbl: (8 byte real) available for in lieus
        tabsreason: (2 byte integer) absence reason
 ETnumTemp:  (2 byte integer) number of added staff
   for i:=1 to ETnumTemp
	ETlink:  (2 byte integer) linked teacher
        Eton:  (2 byte bit map) ET on/off teaching
        ETavail:  (2 byte bit map) ET availability
        Etmax: (8 byte real) ET maximum load
 roNum:  (2 byte integer) number of rooms
   for i:=1 to roNum
	roomon:  (2 byte bit map) room on/off
        roAbsent:  (2 byte bit map) room unavailable
        roswap:  (2 byte bit map) room swapped
        roCover:  (2 byte bit map) room cover
        rolost:  (2 byte bit map) room lost class
 numchanges:  (2 byte integer) number of changes
   for i:=1 to numchanges read Changes record (version 4 format)
 notenum:  (2 byte integer) number of cover notes
   for i:=1 to notenum read exnote (string of 30 char)

EXTRAS.XTR (Version 3 format)
 (no version string)
 exday: (2 byte integer) calendar day 
 exmonth:  (2 byte integer) calendar month
 exyear:  (2 byte integer) calendar year
 ttDay:  (2 byte integer) timetable day
 for i:=1 to 600 read teon:  (2 byte bit map) teacher on/off available
 for i:=1 to 600 read teAbsent:  (2 byte bit map) teacher absent
 for i:=1 to 600 read roAbsent:  (2 byte bit map) room unavailable
 for i:=1 to 200 read Eton:  (2 byte bit map) ET on/off teaching
 for i:=1 to 600 read roomon:  (2 byte bit map) room on/off
 for i:=1 to 600 read teavail: (2 byte integer) available for replacement
 for i:=1 to 200 read ETavail: (2 byte integer) ET availability
 numchanges:  (2 byte integer) number of changes
   for i:=1 to numchanges read Changes record (version 3 format)
 notenum:  (2 byte integer) number of cover notes
   for i:=1 to notenum read exnote (string of 30 char)
  


COVERSET.DAT (version 4 or less)
 nmbrperiods (15) * 
  torder (2 byte integer)
  tslotcode (1 byte string)
then cover weights
 WtET (2 byte integer) for added staff weight
 WtFrees (2 byte integer) for frees in day
 WtToday (2 byte integer) for extras done today
 WtAvail (2 byte integer) for available extras left 
 WtPerc (2 byte integer) for percentage of available extras left
 WtETfac (2 byte integer) for added staff same faculty
 WtWeek (2 byte integer) for extras done in week 
 WtLastNum (2 byte integer) for number of days (n) for last n days
 WtLast (2 byte integer) for last n days
 Wtfac (2 byte integer) for same faculty
 WtSpare (2 byte integer) for spare on either side of extra
 WtLieu (2 byte integer) for in lieus
 WtReplace (2 byte integer) for replacement
 WtPrefer (2 byte integer) for preferred time slot 

EXALLOT.DAT (Version 4 or less)
 for k:=1 to periods read Eallot[k] (8 byte real number): time allotment for period


EMTEACH.DAT - added staff information - Version 3 or less
  ETnum: 2 byte integer - number of added staff
 followed by records for each added staff:
  ETsub - string of length 5 char
  ETname - 25 char string
  comment - 30 char string

REASON.DAT - absence reasons and preset cover notes - Version 3 or less
    for i:=1 to 10 
       read absence reason (string of 30 char)
    for i:=1 to 10 
     read cover note (string of 30 char)

TEAVAIL.DAT - teacher tallies (version 4)
 bytes 0-3 header string 'TCV4' or 'TCE4' 
   for i:=1 to num teacher codes
	Emax:  8 byte real number: maximum extras
	Etaken:  8 byte real number: extras taken	
       if (aStr='TCE4')  then
		Elieu:   8 byte real number: maximum in-lieus
		Elieutaken: 8 byte real number: in-lieus taken
	Eweek: 8 byte real number: extras in week
	Eday: 2 byte integer: day of last extra
	Emonth: 2 byte integer: month of last extra
	for j:=1 to nmbrLikePreferences(5)
		LikEday: 2 byte integer: preferred timetable day 
		LikeTime: 2 byte integer: preferred time slot
	Eten: 2 byte integer: bit map of extras in last 10 days
	Ecomment: comment (string of 30 char)

For TEAVAIL.DAT prior to version 4 - need to convert real numbers
 using BCD2BIN(astr) conversion function



Data Structures

Changes Record (version 4)
                        timeslot:  2 byte integer: either time slot or bit map of times
                        year:      2 byte integer: timetable year
                        level:     2 byte integer: timetable level
                        sub:       2 byte integer: subject
                        gen:       2 byte integer: how change is generated
                        oldte:     2 byte integer: old teacher
                        newte:     2 byte integer: new teacher
                        oldroom:   2 byte integer: old room
                        newroom:   2 byte integer: new room
                        kind:      2 byte integer: kind of cover
                        needte:    2 byte integer: (<>0 teacher needed)
                        needroom:  2 byte integer: (0=no change,1=needed, 2=filled)
                        notes:     2 byte integer: cover note number
                        reason:    2 byte integer: absence reason, or consequential change no.

Changes Record (version 3)
                        timeslot:  2 byte integer: either time slot or bit map of times
                        year:      2 byte integer: timetable year
                        level:     2 byte integer: timetable level
                        sub:       2 byte integer: subject
                        oldte:     2 byte integer: old teacher
                        newte:     2 byte integer: new teacher
                        oldroom:   2 byte integer: old room
                        newroom:   2 byte integer: new room
                        kind:      2 byte integer: kind of cover
                        needte:    2 byte integer: (<>0 teacher needed)
                        needroom:  2 byte integer: (0=no change,1=needed, 2=filled)
                        notes:     2 byte integer: cover note number
                        reason:    2 byte integer: absence reason, or consequential change no.
  

Past Absence Record - Version 3
                     Aday:        smallint;
                     Amonth:      smallint;
                     Atime:       word;
                     Ayear:       smallint;
                     Asub:        smallint;
                     Aoldte:      smallint;
                     Anewte:      smallint;
                     Akind:       smallint;
                     Areason:     smallint;
                    end;

Past Absence Record - Version 4
                     aday:        smallint;
                     amonth:      smallint;
                     atimeslot:   word;
                     ayear:       smallint;
                     asub:        smallint;
                     aoldte:      smallint;
                     anewte:      smallint;
                     akind:       smallint;
                     areason:     smallint;
                     agen:        smallint;
                    end;


 Network Usage

Access Levels for Password file TCEWP52.DAT
0-General
1-Timetable
2-Student
3-Blocking
4-Extras
5-Fees
6-Supervisor

Data Locking records in access file    TCEWP51.DAT
1: teacher
2: added staff
3: teacher tallies
4: absence reasons & cover notes
5: time allotments
6: weights
7-8: not used
9: extras (EXTRAS.DAT)
10-: work ahead files


*)




implementation

end.


