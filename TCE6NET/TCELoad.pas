unit TCEload;   {Common variables, constants and load data}

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, SysUtils,Messages,TCEglobals, Tcommon, XML.REASON, XML.UTILS,
  XML.TTABLE, XML.TTABLE.TTW, GlobalToTcAndTcextra;

type
  TAbout = class(TForm)
    pnlAbout: TPanel;
    OKButton: TBitBtn;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    loadLabel: TLabel;
    SchoolName: TLabel;
    Timer1: TTimer;
    imgAbout: TImage;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseAbout(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
    procedure ProgramIconDblClick(Sender: TObject);
  public
    procedure FirstLoad;
    procedure GetTTable;
    procedure RefreshMaxInLieu;
    function RefreshObjects: Boolean;
    function RefreshTeacherAbsence: Boolean;
    function RefreshAddedStaffAvailability: Boolean;
    procedure UpdateComparisonLevels;
  end;


  function BCD2BIN(R: string):double;
  procedure LoadCoverWeights;
  procedure ExtrasAllotload;
  procedure getReasons;
  procedure teavailIN;
  procedure ETin;
  procedure getTeacherCodes;

  procedure getSubjectCodes;
  procedure getRoomCodes;
  procedure HouseLoad;
  procedure ClassLoad;
  procedure getFaculty;
  procedure LoadDisplayFile(displayFile:string);

var
  About:        TAbout;

{$WARN SYMBOL_DEPRECATED OFF}

implementation

uses
  main,ttable,Tcgetdir,tcommon2,tcommon3,tcommon4, registry,DCPrijndael, DCPsha256,
  DCPsha1, tcommon5, uAMGTeacherAbsence, Pstextra, uAMGCommon, uAMGTeacherAvailability;

{$R *.DFM}
var
 i:           smallint;

 function rotit(lin:string):string;
 var
  i:integer;
 begin
  try
   result:=lin;
   for i:=1 to length(result) do
   begin
    if (upcase(result[i]) in ['A'..'Z']) then
    begin
     if upcase(result[i])>='N' then
      result[i]:=chr(ord(result[i])-13)
     else
      result[i]:=chr(ord(result[i])+13)
    end;
   end;
  except
//  MainHTMLstrxxx:=MainHTMLstrxxx+' 96 EXCEPTION <br>';
  end;
end;

function KeyFileValidationCheck:wordbool;
const
 // KeyFileName='TCE5NET1.DAT';
 KeyFileName='TCE6NET1.DAT';
var
 fn: string;
 KeyStr: AnsiString;
 ReadInEncryptedStr: AnsiString;
 DecryptedReadInStr: AnsiString;
 OriginalMsgReadStr: AnsiString;
 OriginalCRCReadStr: AnsiString;
 AppReadStr:        AnsiString;
 VersionReadStr:     AnsiString;
 Cipher: TDCP_Rijndael;
 Hash: TDCP_sha256;
 //Digest: array[0..50] of byte;  // RipeMD-160 produces a 160bit digest (20bytes)  { replaced by code below }
 Digest: array[0..1900] of byte;  // RipeMD-160 produces a 160bit digest (20bytes)
 Source: AnsiString;
 i,FLen: integer;
 s: AnsiString;
 f: file;
begin
 KeyFileValidationCheck:=false;
{ KeyStr:=KeyStrRt;
 KeyStr:=rotit(KeyStr);  }
 //KeyStr:=rotit(KeyStrRt);
 KeyStr := KeyStrRt;
 TCE5Error:=0;
 ReadInEncryptedStr:='';
 fn:=KeyFileName;

 chdir(Directories.progdir);
 if fileexists(fn) then
 begin
  assign(f,fn);
  filemode:=fmOpenRead+fmShareDenyNone;
  reset(f,1);
  FLen:=filesize(f);
  setlength(ReadInEncryptedStr,FLen);
  blockread(f,ReadInEncryptedStr[1],FLen);
  closefile(f);
 end
 else
  begin
 // no file
   // School:='Application Validation - FAILED!';
   School:='License key not found. Please reinstall software ' +
        'or contact support@timechart.com.au for assistance.';
        
   TCE5Error:=300;
   Exit;
  end;
 chdir(Directories.datadir);

 Cipher:= TDCP_Rijndael.Create(nil);
 // Cipher.InitStr(KeyStr,TDCP_sha1);         // initialize the cipher with a hash of the passphrase
 Cipher.InitStr(KeyStr,TDCP_sha256);
 DecryptedReadInStr:= Cipher.DecryptString(ReadInEncryptedStr);
 Cipher.Burn;
 Cipher.Free;

 OriginalMsgReadStr:='';
 OriginalMsgReadStr:=copy(DecryptedReadInStr,1,length(DecryptedReadInStr)-40);
 OriginalCRCReadStr:='';
 OriginalCRCReadStr:=copy(DecryptedReadInStr,length(DecryptedReadInStr)-39,length(DecryptedReadInStr));

 Source:= OriginalMsgReadStr;
 fillchar(Digest,sizeof(Digest),0);

// source:='SYDNEY SECONDARY COLLEGE-BLACKWATTLE BAY CAMPUS'#$D#$A'WebTC'#$D#$A'1'#$D#$A'€BB3B';

 if Source <> '' then
 begin
   Hash:= TDCP_sha256.Create(nil);          // create the hash
   Hash.Burn;
   Hash.Init;                                   // initialize it
//    if Hash.SelfTest then label8.caption:='YES - good hash' else label8.caption:='NO - shit hash';
   // Hash.Update(Source,length(Source));
   Hash.UpdateStr(Source);
   Hash.Final(Digest);                          // produce the digest
   s:= '';
   for i:= 0 to 19 do
     s:= s + IntToHex(Digest[i],2);
   if OriginalCRCReadStr=s then
   begin
//   VALIDATED - assign school name and continue;
    i:=pos(endline,OriginalMsgReadStr);
    School:=copy(OriginalMsgReadStr,1,i-1);
///    School:='School name keyfile check - SUCCEEDED!!!!';

//check application & version

    // version 5
    { AppReadStr:=copy(OriginalMsgReadStr,i+2,24);
    VersionReadStr:=copy(OriginalMsgReadStr,i+28,1); }

    AppReadStr:=copy(OriginalMsgReadStr,i+2,15);
    VersionReadStr:=copy(OriginalMsgReadStr,i+19,1);

    if (AppReadStr<>'TimeChart Extra') or (VersionReadStr<>'6') then
     begin
//   Validation FAILED';
      KeyFileValidationCheck:=false;
      //School:='Application Validation - FAILED!';  //one of our keyfiles, but not for Web Time Chart version 1
      School:='License key not found. Please reinstall software ' +
        'or contact support@timechart.com.au for assistance.';
      TCE5Error:=100;
      exit;
     end;
    KeyFileValidationCheck:=true;
   end
    else
     begin
//   Validation FAILED';
      KeyFileValidationCheck:=false;
      School:='School Name Validation - FAILED!';
      TCE5Error:=100;
     end;
 end;
end;

procedure LoadDisplayFile(displayFile:string);
begin

end;

procedure initFontColorPairs;
begin
 FontColorPair[0,1]:=clBlack;  FontColorPair[0,2]:=clWhite;
 FontColorPair[cpNormal,1]:=clBlack;  FontColorPair[cpNormal,2]:=clWhite; {normal colour}
 FontColorPair[cpSub,1]:=clFuchsia;  FontColorPair[cpSub,2]:=clWhite;      {subject codes}
 FontColorPair[cpTeach,1]:=clBlue;  FontColorPair[cpTeach,2]:=clWhite;     {teacher codes}
 FontColorPair[cpRoom,1]:=clTeal;  FontColorPair[cpRoom,2]:=clWhite;   {room codes}
 FontColorPair[cpClass,1]:=cldkgray;  FontColorPair[cpClass,2]:=clWhite;    {class codes}
{Info window - clBtnFace background}
 FontColorPair[cpInfoHead,1]:=clBlack;  FontColorPair[cpInfoHead,2]:=clBtnFace;  {info win headers}
 FontColorPair[cpInfo,1]:=clMaroon;  FontColorPair[cpInfo,2]:=clBtnFace;             {info win info}
{Timetable colours}
 FontColorPair[cpTclash,1]:=clNavy;  FontColorPair[cpTclash,2]:=clAqua;    {teacher clash}
 FontColorPair[cpRclash,1]:=clRed;  FontColorPair[cpRclash,2]:=clLime;      {room clash}
 FontColorPair[cpTTblock,1]:=clBlack;  FontColorPair[cpTTblock,2]:=clBtnFace;    {blocks}
 FontColorPair[cpDouble,1]:=clRed;  FontColorPair[cpDouble,2]:=clWhite;     {double}
 FontColorPair[cpDoubleBlock,1]:=clRed;  FontColorPair[cpDoubleBlock,2]:=clBtnFace;        {block double}
{student list}
 FontColorPair[cpStList,1]:=clMaroon;  FontColorPair[cpStList,2]:=clWhite;    {student list}

 {maps}
 FontColorPair[cpLost,1]:=clWhite;  FontColorPair[cpLost,2]:=clblue;  {lost}
 FontColorPair[cpCover,1]:=clWhite;  FontColorPair[cpCover,2]:=clGray;  {cover}
 FontColorPair[cpSwap,1]:=clWhite;  FontColorPair[cpSwap,2]:=clGreen;  {swap}
 FontColorPair[cpAbsent,1]:=clWhite;  FontColorPair[cpAbsent,2]:=clRed;  {unavailable}
{reports - current extras, past extras}
 FontColorPair[cpCurrent,1]:=clNavy;  FontColorPair[cpCurrent,2]:=clWhite; {cur extras}

 FontColorPair[cpAbsentSel,1]:=clRed;  FontColorPair[cpAbsentSel,2]:=clWhite; {absent te selected}
 FontColorPair[cpTimeSel,1]:=clBlack;  FontColorPair[cpTimeSel,2]:=clYellow; {current time slot}

////  HiLite colours

 FontColorHiLitePair[0,1]:=clBlack;  FontColorHiLitePair[0,2]:=clWhite;
 FontColorHiLitePair[cpNormal,1]:=clBlack;  FontColorHiLitePair[cpNormal,2]:=clWhite;            {main}
 FontColorHiLitePair[cpSub,1]:=clred;  FontColorHiLitePair[cpSub,2]:=clAqua;  {subject codes}
 FontColorHiLitePair[cpTeach,1]:=clnavy;  FontColorHiLitePair[cpTeach,2]:=clAqua; {teacher codes}
 FontColorHiLitePair[cpRoom,1]:=clblue;  FontColorHiLitePair[cpRoom,2]:=clAqua;   {room codes}
 FontColorHiLitePair[cpClass,1]:=cldkgray;  FontColorHiLitePair[cpClass,2]:=clAqua; {class codes}
 FontColorHiLitePair[cpStList,1]:=clMaroon;  FontColorHiLitePair[cpStList,2]:=claqua;        {student list}
 FontColorHiLitePair[cpCurrent,1]:=clblue;  FontColorHiLitePair[cpCurrent,2]:=claqua;        {student list clashes}
 FontColorHiLitePair[cpAbsentSel,1]:=clRed;  FontColorHiLitePair[cpAbsentSel,2]:=clAqua; {absent te selected}

 tcfont:=tfont.create;
 tcfont.name:='Ms Sans Serif';
 tcfont.size:=8;
 tcfont.style:=[fsbold];
 tcfont.pitch:=fpvariable;
end;

procedure getTTParameters;
var
 i:              byte;
 msg:              string;
 ttformatTemp:     integer;
begin
 msg:='';
 i:=byterangecheck(days,1,nmbrDays);
 if i>0 then msg:='Number of Days failed Range Check and was adjusted';
 i:=byterangecheck(periods,1,nmbrPeriods);
 if i>0 then msg:='Number of Periods failed Range Check and was adjusted';
 i:=byterangecheck(years,1,nmbrYears);
 if i>0 then msg:='Number of Years failed Range Check and was adjusted';
 if msg>'' then  messagedlg(msg,mtWarning,[mbOK],0);

 years_minus_1:=years-1;

 ttformatTemp:=ttmainformat mod 10;
 if ttformatTemp=1 then
   LevelMax:=trunc(8000/(days*periods*years))
  else LevelMax:=trunc((ttformatTemp*1000)/(periods*years));

 ttMemorySetting1.Value:=8*levelmax;
 ttMemSetting2.Value:=years*ttMemorySetting1.Value;
 ttMemSetting3.Value:=64000 div days;
 if (arrow>4) then arrow:=0;
 if box>6 then box:=bxCell;
end;

procedure newSchool;
var
 i:     integer;
begin
 Yeartitle:='Year'; {default}
 yearshort:='Yr';
 for i:=1 to years do Yearname[i-1]:=inttostr(6+i);
 for i:=1 to periods do Periodname[i-1]:='p.'+inttostr(i);
 if days=5 then
 begin
  Dayname[0]:='MON.';
  Dayname[1]:='TUE.';
  Dayname[2]:='WED.';
  Dayname[3]:='THU.';
  Dayname[4]:='FRI.';
 end
 else
  for i:=1 to days do  Dayname[i-1]:='DAY'+inttostr(i);

end;

procedure getNAMfile;
var
 fname:   string;
 f:       textfile;
 i:       integer;
 s:       string;
begin
 fname:=FileNames.LoadedTimeTable+'.NAM';
 if (fileexists(fname)) then
 begin
  try
   try
    doAssignFile(f,fname);
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(f);
    for i:=0 to years_minus_1 do
    begin
     readln(f,s);  Yearname[i]:=trim(s);
    end;
    for i:=0 to periods-1 do
    begin
     readln(f,s);  Periodname[i]:=trim(s);
    end;
    for i:=0 to days-1 do
    begin
     readln(f,s);  Dayname[i]:=trim(s);
    end;
    readln(f,s);  yearTitle:=trim(s);
    readln(f,s);  yearShort:=trim(s);
   finally
    closefile(f);
   end;
  except
  end;

 end
 else newSchool;{file not there}

end;

procedure addLabel(var labelIndex: integer);
var
 J:             integer;
 oldlabel:      word;
 found:         integer;
begin

 if Lnum>=nmbrLabels then exit;
 oldlabel:=labelIndex;
 found:=0;
 for J:=1 to Lnum do
  if TcLabel[J]='' then
  begin
   found:=J;
   break; {shortcut for loop}
  end;
 if (found=0) or (Lnum=0) then
 begin
  inc(Lnum);
  found:=Lnum;
 end;
 labelIndex:=found;
 TcLabel[labelIndex]:=TcLabel[oldlabel];
end;


procedure checkLabels;
var
 labelcheck:    array[0..nmbrLabels] of integer;
 labelIndex:    integer;
 D,P,Y,L:       integer;
 su,sub:        word;
 IntPoint:      tpIntPoint;
 i:             integer;
begin

 if Lnum=0 then exit;
 for i:=0 to nmbrLabels do labelcheck[i]:=0;
 for D:=0 to days-1 do
 begin
  for P:=0 to periods-1 do
  begin
   for Y:=0 to years_minus_1 do
   begin
    IntPoint:=FNT(d,p,y,0,0);
    for L:=1 to levelmax do
    begin
     inc(IntPoint,4);
     su:=IntPoint^;
     if su>LabelBase then
     begin
      labelIndex:=su-LabelBase;
      if (labelIndex>Lnum) or (TcLabel[labelIndex]='') then
      begin
       labelIndex:=0;
       IntPoint^:=labelIndex;
      end;
      if (su=LabelBase) then  {added - corinda was crashing}
      begin
       su:=0;
       IntPoint^:=su; {clear it - don't want a val of labelbase sitting there - label zero no good}
      end;
      inc(labelcheck[labelIndex]);
      if (TcLabel[labelIndex]>'') and (labelIndex>0) and (labelcheck[labelIndex]>1) then
      begin
       addLabel(labelIndex);
       sub:=LabelBase+labelIndex;
       IntPoint^:=sub;
       labelcheck[labelIndex]:=1;
      end;
     end; {if su>1000 then}
    end; {for l}
   end; {for y}
  end; {for p}
 end; {for d}

 for i:=1 to Lnum do
  if labelcheck[i]=0 then TcLabel[i]:='';

 while (Lnum>0) and (TcLabel[Lnum]='') do
  dec(Lnum);

end;


procedure GetNewTTable(var f: file);
var
 i,j,d:             integer;
 dummyByte: byte;
 tempPointer2:         pointer;
begin
 try
  try
   blockread(f,ttMainFormat,1);
   blockread(f,days,1);        byterangecheck(days,1,nmbrdays);
   blockread(f,periods,1);       byterangecheck(periods,1,nmbrperiods);
   blockread(f,years,1);  byterangecheck(years,1,nmbryears);  years_minus_1:=years-1;
   blockread(f,levelmax,2);
   for i:=0 to years_minus_1 do
    blockread(f,Level[i],1);
   for i:=0 to years_minus_1 do
    blockread(f,Blocks[i],1);

   blockread(f,Version[0],1);
   blockread(f,Version[1],ord(Version[0]));
   Version:=trim(Version);

   for i:=0 to days-1 do
    for j:=0 to periods-1 do
     blockread(f,Tclash[i,j],2);
   for i:=0 to days-1 do
    for j:=0 to periods-1 do
     blockread(f,Rclash[i,j],2);
   for i:=0 to days-1 do
    for j:=0 to periods-1 do
     blockread(f,fclash[i,j],1);
   {d1,p1 etc. 900+ params from standard}
   blockread(f,dl,1);  blockread(f,pl,1);
   blockread(f,yl,1);  blockread(f,ll,1);
   blockread(f,hd,1);  blockread(f,hp,1);
   blockread(f,hy,1);  blockread(f,hl,1);
    {skipped pos=0}
   blockread(f,nd,1);  blockread(f,np,1);
   blockread(f,ny,1);  blockread(f,nl,1);
   blockread(f,dummyByte,1);  blockread(f,dummyByte,1);
   blockread(f,warn,1);
   blockread(f,arrow,1);
   if arrow>4 then arrow:=0;
   blockread(f,box,1);
   if box>6 then box:=bxCell;
   blockread(f,dummyByte,1);  blockread(f,dummyByte,1);
   blockread(f,dummyByte,1);  blockread(f,dummyByte,1);

   ttMemorySetting1.Value:=8*levelmax;
   ttMemSetting2.Value:=years*ttMemorySetting1.Value;
   ttMemSetting3.Value:=64000 div days;

   {main timetable data}
   for d:=0 to days-1 do
   begin
    tempPointer2:=FNT(d,0,0,1,0);
    blockread(f,tempPointer2^,8*word(levelmax)*word(periods)*word(years));
   end;
   About.UpdateComparisonLevels;
  finally
   closefile(f);
  end;
 except

 end;
end;


procedure ConvertLabels;
var
 d,p,y,l,su: integer;
 a:          tpIntPoint;
begin
 if (ttmainformat>10) or (LabelBase=LabelBaseOld) then exit;
 inc(ttmainformat,10);
 for d:=0 to days-1 do
  for p:=0 to periods-1 do
   for y:=0 to years-1 do
    begin
     a:=FNT(d,p,y,0,0);
     for l:=1 to levelmax do
      begin
       inc(a,4);
       su:=a^;
       if (su>LabelBaseOld) then
        begin
         su:=su-LabelBaseOld+LabelBase;
         a^:=su;
        end;
      end; {l}
    end; {y}
end;

procedure MakeTtable;
var
 i,j: shortint;
begin
 days:=5;   periods:=6;   years:=6;  version:='';
 for i:=0 to (years-1) do
   begin Blocks[i]:=6;   Level[i]:=6; end;
 for i:=0 to days-1 do
   for j:=0 to periods-1 do
    begin
     Tclash[i,j]:=0; Rclash[i,j]:=0; fclash[i,j]:=0;
    end;
 ttMainFormat:=1;    {default to standard 64000 format}
 dl:=0;  pl:=0; yl:=years-1; ll:=1;
 hd:=0;  hp:=0; hy:=years-1; hl:=1;
 nd:=0;  np:=0; ny:=years-1; nl:=1;
 warn:=false; arrow:=0; box:=bxCell;
 getTTParameters;
end;

procedure tsBaseAllot;
var
  tmpDouble2: Double;
  i: Smallint;
  f: file;
  lAmtTransferred: Integer;
begin
 chdir(Directories.datadir);
  {init Allot first}
 for i:= 0 to nmbrPeriods do BaseAllot[i]:=1.0; {default}
 if fileexists('ALLOT.DAT') then
  begin
   try {protection block}
    try
     doAssignFile(f, 'ALLOT.DAT');
     filemode:=fmOpenRead+fmShareDenyNone;
     reset(f, 1);
     TC4fileHeader[0]:=chr(4);
     blockread(f,TC4fileHeader[1],4);
     if TC4fileHeader = 'TCV4' then
      for i:=0 to periods-1 do blockread(f, BaseAllot[i], 8, lAmtTransferred)

    finally
     closefile(f)
    end;

   except
   end;
   for i:= 0 to periods-1 do
    begin
     tmpDouble2:= 1.0 + BaseAllot[i];
     if (tmpDouble2 < 1.0) then BaseAllot[i]:= 1.0;
     if (tmpDouble2 > 5001.0) then BaseAllot[i] := 1.0
    end;
  end;
end;

procedure ExtrasAllotLoad;
var
  i, j, k: Integer;
  adbl: Double;
  f: file;
  tmpY,tmpD,tmpP: smallint;
  lAmtTransferred: Integer;
begin
 SetLength(TC4fileHeader,4);
 numDayGroups:=tsNumDayGroups; numYearGroups:=1;
 for i:=0 to days do DayGroup[i]:=tsDayGroup[i];
 for i:=0 to years do YearGroup[i]:=1;

 for i:=0 to nmbryears do
  for j:=0 to nmbrdays do
   for k:=0 to nmbrPeriods do
    Eallot[i,j,k]:=1;

  if fileexists('EXALLOT.DAT') then
    try
      try
       doAssignFile(f,'EXALLOT.DAT');
       filemode:=fmOpenRead+fmShareDenyNone;
       reset(f,1);
       blockread(f,TC4fileHeader[1],4);
       if (TC4fileHeader='TCE5') then
       begin
         blockread(f,tmpY,2);  blockread(f,tmpD,2); blockread(f,tmpP,2);
         for i:=0 to tmpD do blockread(f,DayGroup[i],2);
         for i:=0 to tmpY do blockread(f,YearGroup[i],2);
         for j:=0 to tmpD do
           for k:=1 to tmpP do
           begin
             blockread(f,torder[k,j],2);
             SetLength(tslotcode[k,j],1);
             blockread(f,tslotcode[k,j][1],1);
           end;
         for i:=0 to tmpY do
           for j:=0 to tmpD do
             for k:=1 to tmpP do
             begin
               BlockRead(f,Eallot[i,j,k],8); MinCheckDoubleVal(Eallot[i,j,k]);
             end;
        end
        else
        begin
          reset(f,1);
          for k:=1 to periods do
          begin
            BlockRead(f, adbl, 8, lAmtTransferred);
            {copy across days + years}
            for i:=0 to nmbryears do
             for j:=0 to nmbrdays do
             begin
               Eallot[i,j,k]:=adbl; MinCheckDoubleVal(Eallot[i,j,k]);
             end;
          end;
         end;
     finally
       CloseFile(f);
     end;
   except
   end;

end;

procedure getCLSfile;
var
 fname: string;
 f    : file;
 i,j,k,tmpD  : smallint;
 lAmtTransferred: Integer;
begin
 yeartitle:='Year'; yearshort:='Yr';
 XMLHelper.getNAM_EXTENSION(FileNames.LoadedTimeTable,toRead); {read in names, including old periodnames}   //commented mantis-01612
//  getNAMfile; //uncommented mantis-01612{read in names, including old periodnames}
 if (yearTitle<>'Form') and (yearTitle<>'Year') then
  begin
   yearTitle:='Year';  yearShort:='Yr'
  end;

 tsBaseAllot; {get base allotments - old allot storage}
 try
  {initialise all values}
  TimeSeparator:=':'; tsNumDayGroups:=1;
  TslotUnit:=2; SlotUnitDec:=2; SlotUnitMain:=6;
  for i:=0 to nmbrDays do
   begin
    Tlimit[i]:=periods;  tsDayGroup[i]:=1;
   end;
  for j:=0 to days-1 do
   for k:=0 to periods-1 do
    begin
     TimeSlotName[j,k]:=periodname[k];
     if k<9 then tsCode[j,k]:=inttostr(k+1) else tsCode[j,k]:=chr(56+k);
     tsAllot[j,k]:=BaseAllot[k];
     if (k=0) then
      begin tsStart[j,k]:=StrToTime('9:00'); tsEnd[j,k]:=StrToTime('10:00'); end
       else begin
             tsStart[j,k]:=tsStart[j,k-1]+StrToTime('1:00');
             tsEnd[j,k]:=tsEnd[j,k-1]+StrToTime('1:00');
            end;
    end;
  chdir(Directories.datadir);
 fname:=XMLHelper.getCLS_EXTENSION(FileNames.LoadedTimeTable,toRead);  //commented mantis-01612
  tsDaygroupCount;
 except
   //!!!
 end;
end;

procedure Tabout.GetTTable;
var
 f:                 file;
 fname:             string;
 i:                 integer;
begin

 
 for i:=0 to nmbrDays-1 do
    fillchar(ttMain[i]^,szTTDayBlock,chr(0));
  newtimefile:=FileNames.LoadedTimeTable+'.TTW';
 newtimefile:= XMLHelper.getTTW_EXTENSION(FileNames.LoadedTimeTable, checkExists);
  try
   if fileExists(newTimeFile) then
   begin
    XMLHelper.getTTW_EXTENSION(FileNames.LoadedTimeTable, toRead);
    About.UpdateComparisonLevels;
   end
   else  {no new sequential format file found}
    MakeTtable;

  except

  end;

 LevelPrint:=LevelMax;
 if LevelPrint>nmbrClass then LevelPrint:=nmbrClass;
 getCLSfile;

 for i:=0 to nmbrLabels do
   TcLabel[i]:='';
 fname:=FileNames.LoadedTimeTable+'.LAB';
 if fileexists(fname) then
 begin
  try
   try
    doAssignFile(f,fname);
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(f,1);
    blockread(f,Lnum,2);  IntRange(Lnum,0,nmbrlabels);
    if Lnum>0 then
     for i:=1 to Lnum do
     begin
      SetLength(TcLabel[i],szTcLabel);
      blockread(f,TcLabel[i][1],szTcLabel);
      TcLabel[i]:=TrimRight(TcLabel[i]); {remove chr(0) for string grid on tt}
     end;
   finally
    closefile(f);
   end;
  except

  end;
 end;
 ConvertLabels;
 checkLabels;
end;

procedure InitializeCustom;
var
 i:  integer;
begin
 gotCustom:=false;  AddNum:=0;
 for i:=0 to nmbrCustom do
  begin Add[i]:=''; customTab[i]:=0; end;
end;

procedure getCustom;
var
 F:       textfile;
 Fname:   string;
 S:       string;
 i:  integer;
begin
 {read in CUSTOM file ------------------------------}
 InitializeCustom;

 if (custom>'') then
 begin
  Fname:=custom+'.CUS';
  doAssignFile(F,Fname);
  if FileExists(Fname) then
  begin
   try
    try
     filemode:=fmOpenRead+fmShareDenyNone;
     reset(F);
     Readln(F,S);
     S:=trim(S);
     Addnum:=strToInt(S);   IntRange(Addnum,0,nmbrCustom);
     if (AddNum>0) then
      for i:=1 to AddNum do
      begin
       readln(F,S);
       s:=trim(S);
       customTab[i]:=strToInt(S);
       readln(F,Add[i]);
      end;
     gotCustom:=true;
    finally
     closefile(F);
    end;
   except

   end;
  end;
 end;
end;

procedure setTitle;
begin
 about.SchoolName.caption:=School;
 about.Version.caption:=TCvers;
 about.Copyright.caption:='© AMIG Systems '+FormatDateTime('YYYY',now);
end;

procedure getTTfilename;
var
 A:       String;
 B:       integer;
 L,i,c:   integer;
 found:   bool;
begin
 if ParamCount>0 then
 begin
  A:=ParamStr(1);
  A:=trim(A);
  B:=pos('.',A);
  if B>0 then A:=copy(A,1,B-1);
  L:=length(A);
  if L>0 then
  begin
   found:=false;
   for i:=1 to L do
    begin
     c:=ord(A[i]);
     if ((c<32) or (c>122)) then found:=true;
     case c of
      92,47,58,42,34,63,60,62: found:=true;
     end;
    end;
   if found then A:='';
  end;
  if A='' then
  begin
   FileNames.LoadedTimeTable:='ttable';
  end
  else
   FileNames.LoadedTimeTable:=A;
 end
 else
   FileNames.LoadedTimeTable:='ttable';
end;

procedure initRoomLoad;
var
 i,j:       integer;
 f:         file;
 A:         smallint;
begin
 for i:=1 to nmbrRooms do
  begin
   RoSize[i]:=30;
   Rfaculty[i,1]:=-1;
  end;
 if FileExists('ROLOAD.DAT') then
   try
    try
     doAssignFile(f,'ROLOAD.DAT');
     filemode:=fmOpenRead+fmShareDenyNone;
     reset(f,1);
     blockread(f,A,2);   IntRange(A,0,nmbrRooms);
     if A>0 then
      begin
       for i:=1 to A do
        begin
         blockread(f,RoSize[i],2);
         for j:=1 to 3 do blockread(f,Rfaculty[i,j],2);
        end;
      end;
    finally
     closefile(f);
    end;
   except
   end;

end;

procedure initTeacherLoad;
var
 i,j,k: smallint;
 f: file;
 a: smallint;
begin
 for i := 1 to nmbrteachers do
  begin
   Load[i] := -1;
   Tfaculty[i, 1] := -1;
   for k:=2 to nmbrTeFacs do Tfaculty[i,k]:=0;
   for k:=0 to 2 do
    begin
     DutyCode[i,k]:='';
     DutyLoad[i,k]:=0
    end;
  end;
 if fileexists('TELOAD.DAT') then
  try
    try
     doAssignFile(f,'TELOAD.DAT');
     filemode:=fmOpenRead+fmShareDenyNone;
     reset(f,1);
     a:=NumCodes[1];
     if a>0 then
      begin
       TC4fileHeader[0]:=chr(4);
       blockread(f,TC4fileHeader[1],4);
       if TC4fileHeader='TCV4' then
        for i:= 1 to a do
         begin
          blockread(f,Load[i],2);
          for j:= 1 to 3 do blockread(f,Tfaculty[i,j],2);
          for k:= 0 to 2 do
           begin
            DutyCode[i,k][0]:= chr(szDutyCode);
            blockread(f,DutyCode[i,k][1], szDutyCode);
            DutyCode[i,k]:= trim(DutyCode[i,k]);
            blockread(f,DutyLoad[i,k],8)
           end;
         end
        else
         begin
          seek(f, 0);
          for i:= 1 to a do
           begin
            blockread(f,Load[i],2);
            for j:= 1 to 3 do blockread(f,Tfaculty[i,j],2);
            for k:= 0 to 2 do
             begin
              DutyCode[i,k]:= '';
              DutyLoad[i,k]:= 0{init}
             end;
           end;
         end;
      end;

    finally
      closefile(f)
    end;

   except

   end;
 if fileexists('TeFac.DAT') then  {read in 4th faculty}
  try
   try
    doAssignFile(f,'TeFac.DAT');
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(f, 1);
    blockread(f,a,2);
    blockread(f,k,2);
    if a>NumCodes[1] then a:=NumCodes[1];
    if a > 0 then
     for i := 1 to a do blockread(f,Tfaculty[i,4],2);
   finally
    closefile(f)
   end;

  except
  end;

end;

procedure getSubjectCodes;
var
 codeFile:                file;
 i,NumSubNames: smallint;
 tempstr:                 string;
begin
 subNA:=0;  NumCodes[0]:=0;  LenCodes[0]:=3;
 if FileExists('SUBCODE.DAT') then
 begin
  try
   try
    doAssignFile(codeFile,'SUBCODE.DAT');
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(codeFile,1);
    blockread(codeFile,NumCodes[0],2);   IntRange(NumCodes[0],0,nmbrSubjects);
    blockread(codeFile,LenCodes[0],2);   IntRange(LenCodes[0],2,szSubcode);
    SetLength(Subcode,NumCodes[0]+1);
    if NumCodes[0]>0 then
    begin
     for i:=1 to NumCodes[0] do
     begin
      SubCode[i][0]:=chr(LenCodes[0]);
      blockread(codeFile,SubCode[i][1],LenCodes[0]);
      tempstr:=(SubCode[i]);
      tempstr:=trim(tempstr);
      tempstr:=uppercase(tempstr);
      if tempstr='NA' then subNA:=i;
     end;
    end;
   finally
    closefile(codeFile);
   end;
  except

  end;
 end;
 setlength(GroupSubs,NumCodes[0]+1);
 setlength(GroupSubCount,NumCodes[0]+1);
 setlength(GsubXref,NumCodes[0]+1);
 for i:=0 to nmbrSubjects do  Subname[i]:='';
 snsize := szSubnameDefault; NumSubNames:=NumCodes[0];
 if fileexists('SUBNAME.DAT') then
  try
    try
      doAssignFile(codeFile, 'SUBNAME.DAT');
      filemode:=fmOpenRead+fmShareDenyNone;
      reset(codeFile, 1); 
      SetLength(tempstr,4);
      blockread(codeFile, tempstr[1], 4);
      if tempstr = 'TC4W' then
       begin
        blockread(codeFile,NumSubNames,2);
        blockread(codeFile,snsize,2);
       end
      else
       begin
        seek(codeFile, 0);
        blockread(codeFile,NumSubNames,2)
       end;
      if NumSubNames>NumCodes[0] then NumSubNames:=NumCodes[0];
      if NumSubNames > 0 then
       begin
        for i := 1 to NumSubNames do
        begin
          SetLength(Subname[i],snsize);
          blockread(codeFile, Subname[i][1], snsize);
          Subname[i] := trim(Subname[i])
        end;
      end;

    finally
      closefile(codeFile)
    end;

  except
  end;
end;

procedure getRoomCodes;
var
 codeFile:                file;
 i:                     integer;
begin
 for i:=0 to nmbrRooms do
   TeCode[i,0]:=Space(szTeCode);  NumCodes[2]:=0; LenCodes[2]:=3;
 if Fileexists('ROOMS.DAT') then
 begin
  try
   try
    doAssignFile(codeFile,'ROOMS.DAT');
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(codeFile,1);
    blockread(codeFile,NumCodes[2],2);   IntRange(NumCodes[2],0,nmbrRooms);
    blockread(codeFile,LenCodes[2],2);   IntRange(LenCodes[2],2,szTecode);
    if NumCodes[2]>0 then
    begin
     for i:=1 to NumCodes[2] do
     begin
      TeCode[i,1][0]:=chr(LenCodes[2]);
      blockread(codeFile,TeCode[i,1][1],LenCodes[2]);
     end;
    end;
   finally
    closefile(codeFile);
   end;
  except

  end;
 end;

 for i:=0 to nmbrRooms do
   TeName[i,1]:='';
 if Fileexists('ROOMNAME.DAT') then
 begin
  try
   try
    doAssignFile(codeFile,'ROOMNAME.DAT');
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(codeFile,1);
    blockread(codeFile,NumCodes[2],2);  IntRange(NumCodes[2],0,nmbrRooms);
    if NumCodes[2]>0 then
    begin
     for i:=1 to NumCodes[2] do
     begin
      SetLength(TeName[i,1],szTeName);
      blockread(codeFile,TeName[i,1][1],szTeName);
      TeName[i,1]:=trim(TeName[i,1]);
     end;
    end;
   finally
    closefile(codeFile);
   end;
  except

  end;
 end;
 initRoomLoad;
end;

procedure getTeacherCodes;  { TODO : load in Temail string from Temail.dat text file }
var
 codeFile:                file;
 f:       textfile;
 i,num,ercode:       integer;
 s:       string;
begin
 for i:=0 to nmbrTeachers do
  TeCode[i,0]:=Space(szTeCode); NumCodes[1]:=0; LenCodes[1]:=3;
 if Fileexists('TECODE.DAT') then
 begin
  try
   try
    doAssignFile(codeFile,'TECODE.DAT');
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(codeFile,1);
    blockread(codeFile,NumCodes[1],2); IntRange(NumCodes[1],0,nmbrTeachers);
    blockread(codeFile,LenCodes[1],2);  IntRange(LenCodes[1],2,szTecode);
    if NumCodes[1]>0 then
    begin
     for i:=1 to NumCodes[1] do
     begin
      TeCode[i,0][0]:=chr(LenCodes[1]);
      blockread(codeFile,TeCode[i,0][1],LenCodes[1]);
     end;
    end;
   finally
    closefile(codeFile);
    NEW_DateChecks[1]:=FileDateToDateTime(fileage('TECODE.DAT'));
   end;
  except

  end;
 end;

 {------------------------}
 for i:=0 to nmbrTeachers do
  TeName[i,0]:='';
 if Fileexists('TENAME.DAT') then
 begin
  try
   try
    doAssignFile(codeFile,'TENAME.DAT');
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(codeFile,1);
    blockread(codeFile,NumCodes[1],2);   IntRange(NumCodes[1],0,nmbrTeachers);
    if NumCodes[1]>0 then
    begin
     for i:=1 to NumCodes[1] do
     begin
      SetLength(TeName[i,0],szTeName);
      blockread(codeFile,TeName[i,0][1],szTeName);
      TeName[i,0]:=trim(TeName[i,0]);
     end;
    end;
   finally
    closefile(codeFile);
   end;
  except

  end;
 end;
 initTeacherLoad;
 SetLength(Temail,NumCodes[1]+1);
 for i:=1 to NumCodes[1] do Temail[i]:='';
 if (fileexists('TEMAIL.DAT')) then
  try
   try
    doAssignFile(f,'TEMAIL.DAT');
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(f);
    readln(f,s); val(s,num,ercode);
    if num>NumCodes[1] then SetLength(Temail,num+1);
    for i:=1 to num do
     begin
      readln(f,s);  Temail[i]:=trim(s);
     end;
   finally
    closefile(f);
   end;
  except

  end;

end;

procedure getCodes;
begin
 getSubjectCodes;
 getRoomCodes;
 getTeacherCodes;
end;

procedure getDirectories;
var
 F:       textfile;
 TempList: Tstrings;
 S:       string;
 tmpStr:  string;
 tmpInt:  integer;
begin
 tmpStr:=Paramstr(0);
 Directories.progdir:=GetDirName(tmpStr);
 tmpStr:=Directories.progdir;
 if usrPassLevel>0 then
 begin
  try
   if (trim(usrPassDir)>'') then
   begin
    chdir(usrPassDir);
    if FileExists('DIR.SYS') THEN
     tmpstr:=usrPassDir;
   end
    else tmpstr:=Directories.progdir;
  except
  end;
 end;

 chdir(tmpstr);
 {read in DIR.SYS ------------------------------}
 doAssignFile(F,'DIR.SYS');
 if FileExists('DIR.SYS') THEN
 begin
  try
   try
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(F);
    Readln(F,S);
    Readln(F,S);
    Directories.datadir:=S;
    Readln(F,S);
    DOSscreenmem:=S;
   finally
    CloseFile(F);
   end;
  except

  end;

  {remove last '\'   from progdir now}
   if ((Directories.progdir[length(Directories.progdir)]= '\') and (Directories.progdir[length(Directories.progdir)-1]<>':')) then
      Directories.progdir := COPY(Directories.progdir,1, length(Directories.progdir)-1);
   if not(directoryexists(Directories.datadir)) then getdirdlg.ShowModal
  end
 else
  begin
   s:='DATA';
   if (Directories.progdir[length(Directories.progdir)]<>'\') then s:='\DATA';
   Directories.datadir:=Directories.progdir+s;
   DOSscreenmem:=chr(0);
   {remove last '\' from progdir now}
   if ((Directories.progdir[length(Directories.progdir)]= '\') and (Directories.progdir[length(Directories.progdir)-1]<>':')) then
      Directories.progdir := COPY(Directories.progdir,1, length(Directories.progdir)-1);
   getdirdlg.ShowModal
  end;

 {$I-}
 chdir(Directories.datadir);
 {$I+}
 if IOResult<>0 then
  begin
   messagedlg('Invalid data directory - Exit Time Chart Extra',mtError,[mbOK],0); //Invalid data directory
   Application.Terminate
  end;
 Directories.textdir:=Directories.datadir;
 Directories.timedir:=Directories.datadir;
 getdirdlg.CancelBtn.caption:= 'Cancel';


  {-------------ASSIGN Help file---------------------------------------}
 S:=Directories.progdir;
 if S[length(S)]<>'\' then S:=S+'\';
 //application.helpfile:=S+'TCE5NET.HLP';
 MainForm.HelpRouter1.Helpfile := s + 'TCE6NET.CHM';  {Assign Help file}


 {read in BACK.DAT --------------------------------}
   backup_number:=1;
   backupDir:='C:\';
   if (upcase(Directories.datadir[1])='A') then backupDir:='B:\';

 chdir(Directories.progdir);
 if FileExists('EXBACK.DAT') then
  try
   TempList := TStringList.Create;	{ construct the list object }
   try
    TempList.LoadFromFile('EXBACK.DAT');
    val(TempList.Strings[0],backup_number,tmpInt);
    BackupDir:=TempList.Strings[1];
    if (BackupDir=Directories.ProgDir) or (BackupDir=Directories.DataDir) then
     begin
       backupDir:='C:\';
       if (upcase(Directories.datadir[1])='A') then backupDir:='B:\';
     end;
   finally
    TempList.Free;
   end;
  except

  end;
end;

procedure getFaculty;
var
 i,j,k,m:       integer;
 f:         file;
 tmpStr:           string;
begin
 for i:=1 to nmbrFaculty do
 begin
  facCount[i]:=0;
  facName[i]:='';
  for j:=1 to nmbrSubsInFaculty do
  facSubs[i,j]:=0;
 end;
 facnum:=0;
 if fileexists('FACULTY.DAT') then
 begin
  try
   try
    doAssignFile(f,'FACULTY.DAT');
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(f,1);
    blockread(f,facNum,2);
      IntRange(facNum,0,nmbrFaculty);
    if facNum>0 then
    begin
     for i:=1 to facNum do
      begin
       tmpStr:=readFileLine(f);
       facName[i]:=trim(tmpStr);
       tmpStr:=readFileLine(f);
       tmpStr:=trim(tmpStr); facCount[i]:=strtointdef(tmpStr,0);
        IntRange(facCount[i],0,nmbrSubsInFaculty);
       if facCount[i]>0 then
       begin
        k:=0;
        for j:=1 to facCount[i] do
        begin
         tmpStr:=readFileLine(f);
         tmpStr:=trim(tmpStr);
          m:=strtointdef(tmpStr,0);
          if (m<>0) and (copy(SubCode[abs(m)],1,2)<>'00')
            and (abs(m)<=numcodes[0]) and (abs(m)<>subNA)
            and (k<nmbrSubsInFaculty) then
          begin
           inc(k);
           facSubs[i,k]:=m;
          end;
        end; {for j}
        facCount[i]:=k; {update count after possible repack}
       end;
      end;  {for i}
    end; {facnum>0}
   finally
    closefile(f);
   end;
  except

  end;
 end; {file exists}
end;

procedure sortClassCodes;
  var
    D,H,i:         smallint;
    J,L,A,B:           smallint;
    tmpStr1,tmpStr2: string;
  label label1,label2;

begin
 D:=1;
 while D<ClassCount do D:=D+D;
 label1:
 D:=(D-1) div 2;
 if D=0 then exit;
 H:=ClassCount-D;
 for i:=1 to H do
   begin
    J:=i;
    Label2:
    L:=J+D;
    A:=RollClassPoint[L];
    B:=RollClassPoint[J];
    tmpStr1:=uppercase(ClassCode[A]);
    tmpStr2:=uppercase(ClassCode[B]);
    if tmpStr1<tmpStr2 then
      begin
       RollClassPoint[J]:=A;
       RollClassPoint[L]:=B;
       dec(J,D);
      end;
    if (tmpStr1<tmpStr2) and (J>0) then goto Label2;
  end; {for}
  goto label1;
end;

procedure updateClasspoint;
var
 i,k: smallint;
begin
 k:=0;
 for i:=1 to classnum do
  if trim(ClassCode[i])>'' then
  begin
   inc(k); RollClassPoint[k]:=i;
  end;
 ClassCount:=k;
// reduce trailing blank classes from count
 i:=classnum;
 while ((i>0) and (trim(ClassCode[i])='')) do
 begin
  dec(classnum);
  dec(i);
 end;
 sortClassCodes;
end;

procedure ClassLoad;
var
 i:     smallint;
 f:         file;
 tmpFileName,h:      string;
begin
 setlength(RollClassPoint,nmbrclass+1);
 setlength(ClassCode,nmbrclass+1);
 LenClassCodes:=4; classnum:=0;  //default values
 chdir(Directories.datadir);
 try
  tmpFileName:='CLASS.DAT';
  if not(fileexists(tmpFileName)) then exit;
  try
   doAssignFile(f,tmpFileName);
   filemode:=fmOpenRead+fmShareDenyNone;
   reset(f,1);
   blockread(f,LenClassCodes,2);
   IntRange(LenClassCodes,1,szClassName);
   blockread(f,classnum,2);
   if classnum>0 then
    for i:=1 to classnum do
    begin
     setlength(h,LenClassCodes{+1});
     blockread(f,h[1],LenClassCodes);
     ClassCode[i]:=trim(h);
    end; {for i}
   finally
    closefile(f);
   end;
  except
  end;
 updateClasspoint;
end;

procedure HouseLoad;
var
 i:       integer;
 f:         file;
begin
 for i:=0 to nmbrHouse do HouseName[i]:='';
 HouseCount:=0;
 if FileExists('HOUSE.DAT') then
 begin
  try
   try
    doAssignFile(f,'HOUSE.DAT');
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(f,1);
    blockread(f,HouseCount,2);  IntRange(HouseCount,0,nmbrhouse);
    if HouseCount>nmbrHouse then HouseCount:=nmbrHouse;
    if HouseCount>0 then
    for i:=1 to HouseCount do
    begin
     SetLength(HouseName[i],szHouseName);
     blockread(f,HouseName[i][1],szHouseName);
     HouseName[i]:=trim(HouseName[i]);
    end;
   finally
    closefile(f);
   end;
  except

  end;
 end;
end;

 function BCD2BIN(R: string):double;
 {
 Pass BCD varible in a STRING...
 ...and it will be converted to binary floating point
 IE. Pass in BCD variable in a string 'READ#3,x$;8'
			...instead of 'READ#3,x#  '
   and then do 'x#=FN BCD2BIN#(x$)
 }
 var
  R1:   string[6];
  R2:   string[64];
  R3:   string[1];
  intR1:        integer;
  intR2:        integer;
  erCode:       integer;
  tmpDouble:    double;
 begin
  R2:='';
  intR1:=ord(R[1]);
  if intR1>127 then R2:='-';
  intR1:=(intR1 and 127);
  for intR2:=2 to length(R) do
  begin
   R1:=inttohex(ord(R[intR2]),2);
   if intR2=2 then
   begin
    R3:=R1[1];
    R1:=R1[length(R1)];
    R2:=R2+R3+'.'+R1;
   end
   else
    begin
     R2:=R2+R1;
    end;
  end; {for}
  R2:=R2+'E';
  if intR1>64 then intR1:=-(128-intR1);
  R1:=inttostr(intR1);
  if ord(R1[1])=32 then R1[1]:='+';
  R2:=R2+R1;
  val(R2,tmpDouble,erCode);
  BCD2BIN:=tmpDouble;
 end;

procedure InitDisplay;
var
 i,j:       smallint;
begin
  {Email Setup}
  EmailCoverFlag:=true; EmailAbsentFlag:=false; EmailAddedFlag:=false;
  {backup}
  backup_action:=0;
  {Student page of preferences}
  sTsex:=true;  sTclass:=true; sThouse:=true; sTID:=true; sTtutor:=false; stBarcode:=false;
  sThome:=false; sTyear:=true; double_space:=false; sexselect:=0; sTselect:=1;
  double_print:=1;
  {Timetable page of preferences}
  for i:=0 to nmbrDays do
   for j:=0 to nmbrPeriods do tsOn[i,j]:=true;
  for i:=0 to nmbrYears do Pyear[i]:=true;
  for i:=1 to nmbrDays do Dprint[i]:=true;
  Tfreeshow:=false; Rfreeshow:=false;
  Pweek:=1; {weekly tt's per page}
  Tyr:= 1; //year
   {General page of preferences}
  Txtsep:=44;  Txtlim:=0; FAsubnum:=0;
  OKbackup:=true; OKquitCheck:=true; CustomFileLoadFlag:=false;
  EnableAutoFlag:=true;  ToolBarAuto:=false;  ToolBarFlag:=true;
  custom:='';  {custom file name}


  CusEallotYear:=0; CusEallotDay:=0;
  {Extras page of preferences}
  ESprint:=True; ESteach:=True; ESreason:=True; EStlost:=True;
  ESroom:=True; ESrlost:=True;  ESadd:=True; ESnew:=True; ESmerge:=True;
  EPteach:=True; EProom:=True; EPblank:=3; EPreason:=True; EPlist:=False;
  EPTimes := false;

  prefNotebookPageIndex:=0;
 {stud list}
  StudListType:=2; listEnrolment:=false;
     for i:=1 to 4 do
      for j:=1 to 2 do
       listRanges[i,j]:=0;
  liststudentselection[0]:=0;
      {sub list win}
  sublistfacnum:=0;
  for i:=-2 to nmbrOfgroupsubjects do sublistRanges[i]:=0;
  subbysublisttype:=1;  subbysublisttypegroupnum:=1;
  sublistfree:=0;  sublistday:=0;  sublisttime1:=0; sublisttime2:=0;
      {stu tt}
  studentttselection[0]:=0; stuttlistselection:=2;
  for i:=1 to 8 do stuttlistvals[i]:=0;
      {tea tt}
  tettselection[0]:=0; tettseltype:=1; {all}
  for i:=1 to 3 do tettlistVals[i]:=1;
  for i:=4 to 5 do tettlistVals[i]:=0; {day from/to}
  tettlistVals[3]:=-1; {no fac}
      {room tt}
  rottselection[0]:=0; rottseltype:=1; {all}
  for i:=1 to 3 do rottlistVals[i]:=1;
  for i:=4 to 5 do rottlistVals[i]:=0; {day from/to}
  rottlistVals[3]:=-1; {no fac}
      {sub tt}
  subttlistSelection:=3;   {level}
  for i:=1 to 4 do stuttlistvals[i]:=1;
  subttgroupcnt:=0;
      {margins}
  prntLeftMargin:=1;  {1 cm}
  prntTopMargin:=1;  {1 cm}
  datestamp:=false;

  assorttype:=1; {code}
  asSelsorttype:=1; {code}
    {tt prnt sel}
  ttprntselsubg[0]:=codenum[0];
   {timetable print selections}
  for i:=0 to 2 do begin sorttype[i]:=1; sortCodes(i); end;
  for i:=1 to codenum[0] do ttprntselsubg[i]:=codepoint[i,0];
  ttprntselteachg[0]:=codenum[1];
  for i:=1 to codenum[1] do ttprntselteachg[i]:=codepoint[i,1];
  ttprntselroomg[0]:=codenum[2];
  for i:=1 to codenum[2] do ttprntselroomg[i]:=codepoint[i,2];
  ttprntseltype:=0; ttPrntFac:=0; ttprntselday:=0; ttprntselyear:=0;
  ttPrntType:=0;

      {extras settings}
  shareExclude:=true;
  edLostClassYear:=0; edLostClassSub:=0; edLostClassClass:=0;
  edLostClassLevto:=1; edLostClassLevfrom:=1; edLostClassBy:=0;

  {dialogue positions}
  ExcoverTop:=-1; ExcoverLeft:=-1;
  ManCoverTop:=-1; ManCoverLeft:=-1;

  teamExclude:=false; autocover:=0; coverall:=0; coverstart:=1;
  ShowCoverTimetable:=false;
  for i:=0 to nmbryears do CoverYear[i]:=true;

 {ignore changes}
  IgnoreStatusMsg:=''; IgnoreStatusMsgFlag:=false;

 {absent teacher views}
  absorttype:=1;

 {lost class view}
  lcsorttype:=1;
 {current extras view}
  winCurrentExtrasBrief2:=1;  IncludeShareFlag:=false;
  winCurrentExtrasyear:=0;   winCurrentExtrasCode:=0;
  for i:=1 to 3 do winCurrentExtrasSelectionCount[i]:=0;

 {past extras view}
 winView[wnPastExtras]:=0; winpastExtrasBrief2:=1;
 winpastExtrasyear:=0;  winpastExtrasCode:=0;

 {teachers free dlg}
 TeFreeSelect[0]:=0; {zero index is count}
 teachersfreeday:=-1; {0-days, if =days means all days, -1 not selected}
 TeFreePeriod:=-1; teachersfreefac:=-1;
 teachersfreeshow1:=1; teachersfreeshow2:=1;

 peday1:=1; pemonth1:=1; peday2:=31; pemonth2:=12;
 pedetail:=1; pecover:=1;
 for i:=1 to 3 do winPastExtrasSelectionCount[i]:=0;
 Formfeed:=true;
end;

procedure loadWinDisplay;
var
  winfile:    file;
  i,j,kk,dummysmall:          smallint;
  tmpStr:     string;
  tmpInt,cI:     smallint;
  fontlen:   byte;
  tmpFs:      tFontStyles;
  dispDIR,dispFILE:     string;
  lAmtTransferred: Integer;

  function GetInt2(a,b: smallint): smallint;
  var
   c: smallint;
  begin
   blockread(winfile,c,2);  IntRange(c,a,b);
   result:=c;
  end;

begin
 InitDisplay;    {init first}
 dispDIR:=usrPassDir;
 dispFILE:='EXDISPLAY5.DAT';
 if usrPassLevel=0 then
   begin
    dispDIR:=Directories.datadir;
    dispFILE:='EXDISPLAY5.DAT';
   end;

  chdir(dispDIR);
  if fileExists(dispFILE) then
    begin
      doAssignFile(winfile,dispFILE);
      try
       try
        filemode:=fmOpenRead+fmShareDenyNone;
        reset(winfile,1);
        {start}
        {time chart's font}
        blockread(winfile,fontlen,1);
        SetLength(tmpStr,fontlen);
        blockread(winfile,tmpStr[1],fontlen);
        tmpStr:=trim(tmpStr);
        Tcfont.name:=tmpStr;
        blockread(winfile,tmpFs,sizeof(TFontStyles));

        {ensure no underline OR EVEN STRIKEOUT gets turned on on corrupt file (1byte file will do it)}
        tmpFs:=[fsBold,fsItalic]*tmpFs;
        Tcfont.style:=tmpFs;
        blockread(winfile,i,2);
        if i<4 then i:=12;
        if i>99 then i:=12;
        TcFont.size:=i;
        {end of font}

        {window pos}
        blockread(winfile,winOrderNum,2);
         IntRange(winOrdernum,0,nmbrWindows);
        if winOrderNum>0 then
         for i:=1 to winOrderNum do
          begin
           blockread(winfile,winOrder[i],2);
           IntRange(winorder[i],0,nmbrwindows);
          end;
        blockread(winfile,tmpInt,2);
         IntRange(tmpint,0,nmbrwindows);
        if tmpint>0 then
         for i:=0 to tmpInt do
          begin
           blockread(winfile,winPos[i],sizeof(winPos[i]));
           rangecheckwinpos(i);
          end; {for i}
        {end of window pos}


        for i:=0 to 2 do
         begin
          blockread(winfile,sorttype[i],2);
          IntRange(sorttype[i],0,2);
         end;
        blockread(winfile,cI,2);
        IntRange(cI,0,nmbrWindows);
        if cI>0 then
         for i:=1 to cI do
         begin
          blockread(winfile,winView[i],2);
          IntRange(winView[i],0,winViewMax[i]);
         end;
        blockread(winfile,MatchAllYears,sizeof(boolean));
        {stud list win}
        blockread(winfile,StudListType,2);
         IntRange(StudListType,1,7);
        blockread(winfile,listnumbertype,2);
         IntRange(listnumbertype,1,5);
        {stud list dialog}
        for i:=1 to 4 do
         for j:=1 to 2 do
          blockread(winfile,listRanges[i,j],2);
        for j:=1 to 2 do
          IntRange(listranges[1,j],0,Classnum);
        for j:=1 to 2 do
         IntRange(listranges[2,j],0,housecount);
        for j:=1 to 2 do
         IntRange(listranges[3,j],0,numcodes[1]);
        for j:=1 to 2 do
         IntRange(listranges[4,j],0,numcodes[2]);
        blockread(winfile,cI,2);
        IntRange(cI,0,nmbrstudents);
        liststudentselection[0]:=cI;
        if cI>0 then
         for i:=1 to cI do
          blockread(winfile,liststudentselection[i],2);
        {sub list dialog}
        blockread(winfile,subbysublisttype,2); {1-5}
         IntRange(subbysublisttype,1,5);
        blockread(winfile,subbysublisttypegroupnum,2); {1-3}
         IntRange(subbysublisttypegroupnum,1,3);
        blockread(winfile,cI,2);
         IntRange(cI,0,nmbrOfgroupsubjects);

        for i:=-2 to cI{nmbrOfgroupsubjects} do
         blockread(winfile,sublistRanges[i],2);
        for i:=-2 to -1 do
         IntRange(sublistRanges[i],0,numcodes[0]);   {range subs}
        IntRange(sublistRanges[0],0,nmbrOfGroupSubjects{numcodes[0]});  {count}
        for i:=1 to cI{nmbrOfgroupsubjects} do
         IntRange(sublistRanges[i],0,numcodes[0]); {actual subs list}
        blockread(winfile,sublistfacnum,2);
         IntRange(sublistfacnum,0,facNum);
        blockread(winfile,sublistday,2);
         IntRange(sublistday,0,days-1);
        blockread(winfile,sublistyear,2);
         IntRange(sublistyear,0,years-1);
        blockread(winfile,sublisttime1,2);
         IntRange(sublisttime1,0,periods-1);
        blockread(winfile,sublisttime2,2);
         IntRange(sublisttime2,0,periods-1);
        blockread(winfile,sublistfree,2);  {bool}
        {stud ttable}
        blockread(winfile,cI,2);
        IntRange(cI,0,nmbrstudents);
        studentttselection[0]:=cI;
        if cI>0 then
         for i:=1 to cI do
          blockread(winfile,studentttselection[i],2);
        blockread(winfile,stuttlistselection,2);  {1-6}
         IntRange(stuttlistselection,1,6);
        blockread(winfile,dummysmall,2); {1-2}
        for i:=1 to 8 do
         blockread(winfile,stuttlistvals[i],2);
        for i:=1 to 2 do
         IntRange(stuttlistvals[i],0,numstud);
        IntRange(stuttlistvals[3],0,ClassCount);

        IntRange(stuttlistvals[4],0,housecount);
        IntRange(stuttlistvals[5],0,numcodes[1]);
        IntRange(stuttlistvals[6],0,numcodes[2]);
        for i:=7 to 8 do
         IntRange(stuttlistvals[i],0,days-1);
        {teach ttable}
        blockread(winfile,cI,2);
        IntRange(cI,0,nmbrTeachers); tettselection[0]:=cI;
        if cI>0 then
         for i:=1 to cI do begin        {zero index is count}
          blockread(winfile,tettselection[i],2);
          IntRange(tettselection[i],0,numcodes[1]);
         end;
        blockread(winfile,tettseltype,2); {1-2}
        blockread(winfile,dummysmall,2);  {1-2}
        for i:=1 to 5 do
         blockread(winfile,tettlistVals[i],2);
        for i:=1 to 2 do
         IntRange(tettlistVals[i],1,numcodes[1]);
        IntRange(tettlistVals[3],0,facnum);
        for i:=4 to 5 do
         IntRange(tettlistVals[i],0,days-1);

        {room ttable}
        blockread(winfile,cI,2);
         IntRange(cI,0,nmbrTeachers); rottselection[0]:=cI;
        if cI>0 then
         for i:=1 to cI do begin        {zero index is count}
          blockread(winfile,rottselection[i],2);
          IntRange(rottselection[i],0,numcodes[2]);
         end;
        blockread(winfile,rottseltype,2); {1-2}
        blockread(winfile,dummysmall,2);  {1-2}
        for i:=1 to 5 do
         blockread(winfile,rottlistVals[i],2);
        for i:=1 to 2 do
         IntRange(rottlistVals[i],1,numcodes[2]);
        IntRange(rottlistVals[3],0,facnum);
        for i:=4 to 5 do
         IntRange(rottlistVals[i],0,days-1);


        {sub ttable}
        blockread(winfile,subttlistSelection,2); {1-3}
         IntRange(subttlistSelection,1,3);
        for i:=1 to 4 do
         blockread(winfile,subttlistVals[i],2);
        IntRange(subttlistVals[1],0,years-1);
        IntRange(subttlistVals[2],0,level[subttlistVals[1]]);
        IntRange(subttlistVals[3],0,days-1);
        IntRange(subttlistVals[4],0,periods-1);

        blockread(winfile,subttgroupcnt,2);
        IntRange(subttgroupcnt,0,numcodes[0]);
        cI:=subttgroupcnt;
        if cI>0 then
         for i:=1 to cI do
          begin
           blockread(winfile,subttgroup[i],2);
           IntRange(subttgroup[i],0,numcodes[0]);
          end;
       {tt prnt seldlg}
        blockread(winfile,cI,2);
        IntRange(cI,0,nmbrSubjects);
        ttprntselsubg[0]:=cI;
        if cI>0 then
         for i:=1 to cI do
          begin
           blockread(winfile,ttprntselsubg[i],2);
           IntRange(ttprntselsubg[i],0,numcodes[0]);
          end;
        blockread(winfile,cI,2);
        IntRange(cI,0,nmbrTeachers);
        ttprntselteachg[0]:=cI;
        if cI>0 then
         for i:=1 to cI do
          begin
           blockread(winfile,ttprntselteachg[i],2);
           IntRange(ttprntselteachg[i],0,numcodes[1]);
          end;
        blockread(winfile,cI,2);
        IntRange(cI,0,nmbrRooms);
        ttprntselroomg[0]:=cI;
        if cI>0 then
         for i:=1 to cI do
          begin
           blockread(winfile,ttprntselroomg[i],2);
           IntRange(ttprntselroomg[i],0,numcodes[2]);
          end;
        blockread(winfile,ttprntseltype,2);  {1-5}
        IntRange(ttprntseltype,0,4);
        blockread(winfile,ttPrntFac,2);
         IntRange(ttPrntFac,0,facnum);
        blockread(winfile,ttprntselday,2);
         IntRange(ttprntselday,-1,days-1);   {-1  all days}
        blockread(winfile,ttprntselyear,2);
         IntRange(ttprntselyear,-1,years-1);  {can have all years ?}
        blockread(winfile,ttPrntType,2);
         IntRange(ttPrntType,0,1);  {either 0- main or 1- year tt}

        {margins etc}
        blockread(winfile,prntLeftMargin,4);
         singlerangecheck(prntLeftMargin,0,99);
        blockread(winfile,prntTopMargin,4);
         singlerangecheck(prntTopMargin,0,99);
        blockread(winfile,datestamp,sizeof(boolean));

        {preferences }
        {general}
        blockread(winfile,prefNotebookPageIndex,2);   {0-2}
         IntRange(prefNotebookPageIndex,0,4);
        BlockRead(winfile, GroupIndexDisplay, 2);  //blockread(winfile,dummysmall,2);
        blockread(winfile,colorPrinterFlag,sizeof(colorPrinterFlag));
        {student section}
        blockread(winfile,sTsex,sizeof(boolean));
        blockread(winfile,sTClass,sizeof(boolean));
        blockread(winfile,sTHouse,sizeof(boolean));
        blockread(winfile,sTID,sizeof(boolean));
        blockread(winfile,sTyear,sizeof(boolean));
        blockread(winfile,sTTutor,sizeof(boolean));
        blockread(winfile,sTHome,sizeof(boolean));
        blockread(winfile,double_space,2);   {used as bool}
         double_print:=1; if double_space then double_print:=2;
        blockread(winfile,sTselect,2);       {0-3}
         IntRange(sTselect,0,3);
        blockread(winfile,Sexselect,2);      {0-2}
         IntRange(Sexselect,0,2);
        blockread(winfile,listEnrolment,2);    {bool}
        {timetable section}
        blockread(winfile,cI,2); IntRange(cI,0,nmbrPeriods);
        if cI>0 then for i:= 0 to cI-1 do
            blockread(winfile,tsOn[1,i],sizeof(boolean));
        blockread(winfile,cI,2);
        IntRange(cI,0,nmbryears);
        if cI>0 then
         for i:=0 to cI do
          blockread(winfile,Pyear[i],sizeof(boolean));
        blockread(winfile,cI,2);
        IntRange(cI,0,nmbrdays);
        if cI>0 then   {was read of Tlimit}
         for i:=0 to cI do blockread(winfile,dummysmall,2);
        blockread(winfile,cI,2);
        IntRange(cI,0,nmbrdays);
        if cI>0 then
         for i:=1 to cI{nmbrdays} do
          blockread(winfile,Dprint[i],sizeof(boolean));
        blockread(winfile,Tfreeshow,sizeof(boolean));
        blockread(winfile,Rfreeshow,sizeof(boolean));
        blockread(winfile,Pweek,2);
         IntRange(Pweek,1,9); {weekly tt's per page upper limit ??}
        blockread(winfile,Tyr,2);  {0-3}
         IntRange(Tyr,0,3);
        blockread(winfile,yearTitle[0],5);
         i:=ord(yearTitle[0]);
         IntRange(i,0,4);  {just check length ??}
         yearTitle[0]:=chr(i);
         if ((yeartitle<>'Year') and (yeartitle<>'Form')) then
          yeartitle:='Year';     {prevent garbage string}
        blockread(winfile,yearShort[0],3);
          i:=ord(yearShort[0]);
          IntRange(i,0,2);  {just check length ??}
          yearshort[0]:=chr(i);
        if ((yearshort<>'Yr') and (yearshort<>'Fm')) then
         begin
          if yeartitle='Year' then yearshort:='Yr'
           else yearshort:='Fm';
         end;

        {extras list settings}
        blockread(winfile,ESprint,sizeof(ESprint));
        blockread(winfile,ESteach,sizeof(ESteach));
        blockread(winfile,ESreason,sizeof(ESreason));
        blockread(winfile,EStlost,sizeof(EStlost));
        blockread(winfile,ESroom,sizeof(ESroom));
        blockread(winfile,ESrlost,sizeof(ESrlost));
        blockread(winfile,ESadd,sizeof(ESadd));
        blockread(winfile,ESnew,sizeof(ESnew));
        blockread(winfile,ESmerge,sizeof(ESmerge));


        blockread(winfile,EPteach,sizeof(boolean));
        blockread(winfile,EProom,sizeof(boolean));
        blockread(winfile,EPblank,2);   IntRange(EPblank,0,99);
        blockread(winfile,EPreason,sizeof(boolean));
        blockread(winfile,EPlist,sizeof(boolean));

        blockread(winfile,coverall,2);  IntRange(coverall,0,1);
        blockread(winfile,autocover,2);  IntRange(autocover,0,1);
        blockread(winfile,coverstart,2);
        blockread(winfile,ShowCoverTimetable,sizeof(boolean));

        blockread(winfile,ExcoverTop,sizeof(ExcoverTop));
        blockread(winfile,ExcoverLeft,sizeof(ExcoverLeft));
        blockread(winfile,ManCoverTop,sizeof(ManCoverTop));
        blockread(winfile,ManCoverLeft,sizeof(ManCoverLeft));

        blockread(winfile,cI,2);
        IntRange(cI,0,nmbryears);
        if cI>0 then
         for i:=0 to cI do
          blockread(winfile,CoverYear[i],sizeof(boolean));

        blockread(winfile,cI,2);
        IntRange(cI,0,szIgnoreStatusMsg);
        IgnoreStatusMsg[0]:=chr(cI);
        blockread(winfile,IgnoreStatusMsg[1],cI);
        blockread(winfile,IgnoreStatusMsgFlag,sizeof(IgnoreStatusMsgFlag));

        {absent teacher views}
        blockread(winfile,absorttype,2);  IntRange(absorttype,0,4);
        blockread(winfile,teamExclude,sizeof(teamexclude));  {bool}
        {added staff view}
        blockread(winfile,assorttype,2);  IntRange(assorttype,0,9);
        {added staffsel view}
        blockread(winfile,UseGroupFindStud,2);
        blockread(winfile,asSelsorttype,2);  IntRange(asSelsorttype,0,9);
        {lost class view}
        blockread(winfile,lcsorttype,2);  IntRange(lcsorttype,0,4);
        blockread(winfile,shareExclude,sizeof(shareExclude)); {bool}

        blockread(winfile,edLostClassYear,2);  IntRange(edLostClassYear,0,years-1);
        blockread(winfile,edLostClassSub,2);  IntRange(edLostClassSub,0,nmbrSubjects);
        blockread(winfile,edLostClassClass,2);  IntRange(edLostClassClass,0,nmbrClass);
        blockread(winfile,edLostClassLevto,2);
            IntRange(edLostClassLevto,1,LevelMax);
        blockread(winfile,edLostClassLevfrom,2);
            IntRange(edLostClassLevfrom,1,LevelMax);
        blockread(winfile,edLostClassBy,2);  IntRange(edLostClassBy,0,3);

        {current extras view}
        blockread(winfile,winCurrentExtrasBrief2,2);  IntRange(winCurrentExtrasBrief2,1,3);
        blockread(winfile,winCurrentExtrasyear,2);  IntRange(winCurrentExtrasyear,-1,years);
        blockread(winfile,winCurrentExtrasCode,2);  IntRange(winCurrentExtrasCode,0,facnum);
        blockread(winfile,IncludeShareFlag,sizeof(IncludeShareFlag));
        for kk:=1 to 3 do
        begin
         blockread(winfile,winCurrentExtrasSelectionCount[kk],2);
         if winView[wnCurrentExtras]=4 then
          IntRange(winCurrentExtrasSelectionCount[kk],0,etnum)
         else
          IntRange(winCurrentExtrasSelectionCount[kk],0,numcodes[1]);
         if winCurrentExtrasSelectionCount[kk]>0 then
          for i:=1 to winCurrentExtrasSelectionCount[kk] do
          begin
           blockread(winfile,winCurrentExtrasSelection[kk][i],2);
             if winView[wnCurrentExtras]=4 then
              IntRange(winCurrentExtrasSelection[kk][i],0,etnum1)
             else
              IntRange(winCurrentExtrasSelection[kk][i],0,codenum[1]);
          end;
         end; {for kk}
        {past extras view}
        blockread(winfile,winpastExtrasBrief2,2);  IntRange(winpastExtrasBrief2,1,3);
        blockread(winfile,winpastExtrasyear,2);  IntRange(winpastExtrasyear,-1,years);
        blockread(winfile,winpastExtrasCode,2);  IntRange(winpastExtrasCode,0,facnum);

        blockread(winfile,peday1,2);  IntRange(peday1,1,31);
        blockread(winfile,pemonth1,2);  IntRange(pemonth1,1,12);
        blockread(winfile,peday2,2);  IntRange(peday2,1,31);
        blockread(winfile,pemonth2,2);  IntRange(pemonth2,1,12);
        blockread(winfile,pedetail,2);  IntRange(pedetail,1,4);
        blockread(winfile,pecover,2);  IntRange(pecover,1,4);

        for kk:=1 to 5 do
        begin
         blockread(winfile,winPastExtrasSelectionCount[kk],2);
          if kk=3 then
           IntRange(winPastExtrasSelectionCount[kk],0,etnum)
          else
           IntRange(winPastExtrasSelectionCount[kk],0,numcodes[1]);
         if winPastExtrasSelectionCount[kk]>0 then
          for i:=1 to winPastExtrasSelectionCount[kk] do
          begin
           blockread(winfile,winPastExtrasSelection[kk,i],2);
            if winView[wnCurrentExtras]=4 then
             IntRange(winPastExtrasSelection[kk,i],0,etnum1)
            else
             IntRange(winPastExtrasSelection[kk,i],0,codenum[1]);
          end;
        end; {for kk}

        blockread(winfile,Formfeed,2);  {bool}
        blockread(winfile,globalHints,2); {bool}
        blockread(winfile,OKbackup,2); {bool}
        blockread(winfile,OKquitcheck,2); {bool}
        blockread(winfile,EnableAutoFlag,2);
        blockread(winfile,ToolBarFlag,sizeof(ToolBarFlag));
        blockread(winfile,txtsep,2); {int}
         IntRange(txtsep,0,255);     {used as char}
        blockread(winfile,txtlim,2); {int}
         IntRange(txtlim,0,255);
        blockread(winfile,FAsubnum,2);
         IntRange(FAsubnum,0,nmbrChoices);
        blockread(winfile,CusEallotYear,2);  IntRange(CusEallotYear,0,years_minus_1);
        blockread(winfile,CusEallotDay,2);  IntRange(CusEallotDay,0,(days-1));

        blockread(winfile,kk,2);
        IntRange(kk,1,years);
         for i:=1 to kk do
         begin
          blockread(winfile,level[i-1],2);
          IntRange(level[i-1],1,levelprint);
         end;
        blockread(winfile,GenericTtableFlag,2);
        blockread(winfile,customFileLoadFlag,2);
        if customFileLoadFlag then
         begin
          blockread(winfile,i,2);
           IntRange(i,0,250);
          SetLength(customFileLoad,i);
          blockread(winfile,customFileLoad[1],i);
         end;
        blockread(winfile,EmailCoverFlag,2);
        blockread(winfile,EmailAbsentFlag,2);
        blockread(winfile,EmailAddedFlag,2);
        blockread(winfile, tmpInt, 2, lAmtTransferred); IntRange(tmpInt,0,nmbrDays);
        blockread(winfile,cI,2); IntRange(cI,0,nmbrPeriods);
        if tmpInt>1 then
         for i:= 2 to tmpInt do
          for j:=0 to cI-1 do
            BlockRead(winfile, tsOn[i,j], sizeof(boolean), lAmtTransferred);

        // Barcode setting for student lists
        blockread(winfile,stBarcode,sizeof(boolean));

        //Extras Pref Start/End Times
        blockread(winfile,EPTimes,sizeof(boolean));

                {teachers free dlg}
         cI:=GetInt2(0,nmbrteachers);   TeFreeSelect[0]:=cI;
         if cI>0 then
           for i:=1 to cI do TeFreeSelect[i]:=GetInt2(0,NumCodes[1]);
         teachersfreeday:=GetInt2(-1,days-1);  TeFreePeriod:=GetInt2(-1,periods+1);
         teachersfreefac:=GetInt2(-1,FacNum);  teachersfreeshow1:=GetInt2(1,3);
         teachersfreeshow2:=GetInt2(1,3); teFreeYear:=GetInt2(-1,years_minus_1-1);

        // Plain SMTP Flag
        try
          blockread(winfile, EmailPlainSMTP,2);
        except
          EmailPlainSMTP := true;
        end;
       finally
         CloseFile(winfile);
       end;
      except

      end;
    end;
 for i:=0 to 2 do sortCodes(i);  {do sort after reading sorttype from disp file}
end;

procedure newPastExtras;
var
 f:       file;
 astr:    string;
begin
 doAssignFile(f,'ABSENT.DAT');
 filemode:=fmOpenReadWrite+fmShareDenyWrite;
 rewrite(f,1);
 astr:='TCE5'; AbsentTotal:=0;
 blockwrite(f,astr[1],4);
 blockwrite(f,AbsentTotal,2);
 closefile(f);
end;

function ConvertWord(a: word):longword;
var
 mytime: longword;
begin
 a:=not(a);
 mytime:=a;
 result:=not(mytime);
end;

procedure checkPastExtras;
var
 f,f2:                    file;
 astr:                    string;
 old_day,old_month:       smallint;
 Agen,newkind,kind:       smallint;
 count2,aStart,aFinish:   integer;
 Eflag:                   tpTe32data;
 Dday,Dmonth,Dyear,Dsub,Dnewte,Dkind,Dgen:  smallint;
 Dtime:                   longword;
 i:                       integer;
 Doldte,Dreason:          smallint;
 Aday,Amonth,Ayear,Asub,Aoldte,Akind,Anewte,Areason:  integer;
 Atime:                   longword;
type
 pastAbsenceRec3= record
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
 pastAbsenceRec4= record
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

 pastAbsenceRec5= record
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
 tmpRec3:    pastAbsenceRec3;
 tmpRec4:    pastAbsenceRec4;
 tmpRec5:    pastAbsenceRec5;


       procedure convertKind;
         begin
          Agen:=0; newkind:=0; kind:=Akind;
          case kind of
           1: begin Agen:=1; newkind:=1; end;
           2: begin Agen:=1; newkind:=2; end;
           3: begin Agen:=1; newkind:=4; end;
           4: begin Agen:=2; newkind:=1; end;
           5: begin Agen:=2; newkind:=2; end;
           6: begin Agen:=2; newkind:=4; end;
          10: begin Agen:=4; newkind:=0; end;
          end; {case}
          Akind:=newkind;
       end;

       procedure clearFlags;
        var
         i:      integer;
        begin
         for i:=1 to nmbrTeachers do
         begin
          eflag[i]:=-1; Abreason[i]:=0;
         end; {for i}
       end;


        procedure addabsentrecords;
         var
          j:       integer;
         begin
          Dday:=old_day; Dmonth:=old_month; Dyear:=0; Dsub:=0; Dnewte:=0; Dkind:=0; Dgen:=4;
          for j:=1 to numcodes[1] do
          begin
           if eflag[j]<>-1 then
           begin
            inc(count2); Dtime:=eflag[j]; Doldte:=j; Dreason:=abreason[j];
            seek(f2,longint(count2)*sizeof(tmpRec5));
            tmpRec5.aday:=Dday; tmpRec5.amonth:=Dmonth; tmpRec5.atimeslot:=Dtime;
            tmpRec5.ayear:=Dyear; tmpRec5.asub:=Dsub; tmpRec5.aoldte:=Doldte;
            tmpRec5.anewte:=Dnewte; tmpRec5.akind:=Dkind; tmpRec5.areason:=Dreason;
            tmpRec5.agen:=Dgen;  tmpRec5.attday:=0;
            blockwrite(f2,tmpRec5,sizeof(tmpRec5));
           end
          end; {for j}
          clearflags;
          old_day:=Aday; old_month:=Amonth;
          for j:=astart to afinish do
          begin
           try
            seek(f,longint(j)*18);
            blockread(f,tmpRec3,sizeof(tmprec3));
           except

           end;
               IntRange(tmpRec3.Aoldte,0,nmbrTeachers);
               IntRange(tmpRec3.Anewte,0,nmbrTeachers);
               IntRange(tmpRec3.Asub,1,nmbrsubjects);
               IntRange(tmpRec3.amonth,1,12);
               IntRange(tmpRec3.aday,1,31);

           aday:=tmpRec3.Aday; Amonth:=tmpRec3.Amonth; Atime:=tmpRec3.Atime;
           Ayear:=tmpRec3.Ayear; Asub:=tmpRec3.Asub; Aoldte:=tmpRec3.Aoldte;
           Anewte:=tmpRec3.Anewte; Akind:=tmpRec3.Akind; Areason:=tmpRec3.Areason;
           convertkind;
           if agen<>4 then
           begin
            inc(count2);
            seek(f2,longint(count2)*sizeof(tmpRec5));
            tmpRec5.aday:=aday; tmpRec5.amonth:=amonth; tmpRec5.atimeslot:=Atime;
            tmpRec5.ayear:=ayear; tmpRec5.asub:=asub; tmpRec5.aoldte:=aoldte;
            tmpRec5.anewte:=anewte; tmpRec5.akind:=akind; tmpRec5.areason:=areason;
            tmpRec5.agen:=agen; tmpRec5.attday:=0;
            blockwrite(f2,tmpRec5,sizeof(tmpRec5));
           end;
          end;  {for j}
          astart:=i;
          try
           seek(f,longint(i)*18);
           blockread(f,tmpRec3,sizeof(tmprec3));
          except

          end;
              IntRange(tmpRec3.Aoldte,0,nmbrTeachers);
              IntRange(tmpRec3.Anewte,0,nmbrTeachers);
              IntRange(tmpRec3.Asub,1,nmbrsubjects);
              IntRange(tmpRec3.amonth,1,12);
              IntRange(tmpRec3.aday,1,31);

          aday:=tmpRec3.Aday; Amonth:=tmpRec3.Amonth; Atime:=tmpRec3.Atime;
          Ayear:=tmpRec3.Ayear; Asub:=tmpRec3.Asub; Aoldte:=tmpRec3.Aoldte;
          Anewte:=tmpRec3.Anewte; Akind:=tmpRec3.Akind; Areason:=tmpRec3.Areason;
        end;


begin
 astr:=''; ClearFlags;
 if not(fileexists('ABSENT.DAT')) then
 begin
  newPastExtras;
  exit;
 end;
 try
  try
   doAssignFile(f,'ABSENT.DAT');
   filemode:=fmOpenRead+fmShareDenyNone;
   reset(f,1);
   SetLength(astr,4);
   blockread(f,astr[1],4);
  finally
   closefile(f);
  end;
 except

 end;
 if Astr='TCE5' then exit;
 if astr='TCE4' then
  begin {TCE4}
   try
     try
      doAssignFile(f2,'ABSENT.TMP');
       try
        filemode:=fmOpenReadWrite+fmShareDenyWrite;
        reset(f,1);
        rewrite(f2,1);
        blockread(f,astr[1],4);
        blockread(f,AbsentTotal,2);
        astr:='TCE5';
        blockwrite(f2,astr[1],4);    blockwrite(f2,AbsentTotal,2);
        if AbsentTotal>0 then
        begin
         for i:=1 to AbsentTotal do
         begin
          seek(f,longint(i)*20);
          blockread(f,tmpRec4,sizeof(tmprec4));

          tmpRec5.aday:=tmpRec4.aday;
          tmpRec5.amonth:=tmpRec4.amonth;
          tmpRec5.ayear:=tmpRec4.ayear;
          tmpRec5.asub:=tmpRec4.asub;
          tmpRec5.aoldte:=tmpRec4.aoldte;
          tmpRec5.anewte:=tmpRec4.anewte;
          tmpRec5.akind:=tmpRec4.akind;
          tmpRec5.areason:=tmpRec4.areason;
          tmpRec5.agen:=tmpRec4.agen;
          tmpRec5.attday:=0;
          if tmpRec4.agen=4 then tmpRec5.atimeslot:=ConvertWord(tmpRec4.atimeslot)
           else tmpRec5.atimeslot:=tmpRec4.atimeslot;
          seek(f2,longint(i)*sizeof(tmprec5));
          blockwrite(f2,tmpRec5,sizeof(tmprec5));
         end; {for i}
        end; {if AbsentTotal>0}
       finally
        closefile(f);
       end;
      erase(f);
     finally
      closefile(f2);
     end;
    rename(f2,'ABSENT.DAT');
    except

    end;

  end  {TCE4}
 else
  begin {version before TCE4}
    old_day:=0; old_month:=0;
    doAssignFile(f,'ABSENT.DAT');
    try
     try
      filemode:=fmOpenReadWrite+fmShareDenyWrite;
      reset(f,1);
      doAssignFile(f2,'ABSENT.TMP');
       try
        rewrite(f2,1);
        blockread(f,AbsentTotal,2);
        count2:=0; aStart:=1; aFinish:=1;
        if AbsentTotal>0 then
        begin
         for i:=1 to AbsentTotal do
         begin
          seek(f,longint(i)*18);
          blockread(f,tmpRec3,sizeof(tmprec3));
           IntRange(tmpRec3.Aoldte,0,nmbrTeachers);
           IntRange(tmpRec3.Anewte,0,nmbrTeachers);
           IntRange(tmpRec3.Asub,1,nmbrsubjects);
           IntRange(tmpRec3.amonth,1,12);
           IntRange(tmpRec3.aday,1,31);

          aday:=tmpRec3.Aday; Amonth:=tmpRec3.Amonth; Atime:=tmpRec3.Atime;
          Ayear:=tmpRec3.Ayear; Asub:=tmpRec3.Asub; Aoldte:=tmpRec3.Aoldte;
          Anewte:=tmpRec3.Anewte; Akind:=tmpRec3.Akind; Areason:=tmpRec3.Areason;
          if i=1 then begin old_day:=aday; old_month:=amonth; end;
          if ((aday<>old_day) or (amonth<>old_month)) then
           begin afinish:=i-1; addabsentrecords; end;
          convertkind;
          if agen=1 then
          begin
           eflag[aoldte]:=(eflag[aoldte] and (not(1 shl atime)));
           abreason[aoldte]:=areason;
          end;
          if agen=4 then abreason[aoldte]:=areason;
          if i=Absenttotal then begin Afinish:=i; addabsentrecords; end;
         end; {for i}
        end; {if AbsentTotal>0}
        seek(f2,0);
        astr:='TCE5';
        blockwrite(f2,astr[1],4);    blockwrite(f2,count2,2);
       finally
        closefile(f);
       end;
      erase(f);    {KILL "ABSENT.DAT"}
     finally
      closefile(f2);
     end;
    rename(f2,'ABSENT.DAT');
    except

    end;
 end;{version before TCE4}
end;

procedure GroupSetAll;
var
 i:       smallint;
begin
 setlength(StGroup,(numstud+1)); {zero based so +1}
 for i:=1 to numstud do StGroup[i]:=i;
 GroupName:='All';  GroupType:=0;  GroupSort:=1;
 GroupNum:=numstud;
 setlength(GOSrecipe.steps,2+1);
 GOSrecipe.NumSteps:=1;   {using zero rec for count only}
 GOSrecipe.steps[0].meth:=0;
 GOSrecipe.steps[0].e1:=''; GOSrecipe.steps[0].e2:='';
 GOSrecipe.steps[1].slct:=0; {all}
 GOSrecipe.steps[1].meth:=0; {new}
 GOSrecipe.steps[1].e1:=''; GOSrecipe.steps[1].e2:='';  {don't care}
 GOSrecipe.SubOfferName:=''; {no sub selection}
end;

procedure SetGOSunit(a,b,num,slct1,meth1: smallint; en1,en2: string);
begin
 GOS[a].NumSteps:=num;
 GOS[a].steps[b].slct:=slct1;
 GOS[a].steps[b].meth:=meth1;
 GOS[a].steps[b].e1:=en1;
 GOS[a].steps[b].e2:=en2;
 GOS[a].SubOfferName:='';
end;

procedure loadGroups;
var
 f:       file;
 fn,s:      string;
 dummy: smallint;

 function ReadEntry(len: smallint): string;
 begin
  s:=RpadString('',len); blockread(f,s[1],len);
  result:=trim(s);
 end;

    procedure loadGOSold;
    var
     i,k,a,m,n:       smallint;
    begin
     blockread(f,GOSnum,2); blockread(f,dummy,2);
     ReadEntry(10);  ReadEntry(10);
     setlength(GOS,GOSnum+1);
     setlength(GOSname,GOSnum+1);
     if GOSnum>0 then
      for i:=1 to GOSnum do
       begin
        GOSname[i]:=ReadEntry(250); GOS[i].SubOfferName:='';
        blockread(f,a,2);
        if a>50 then a:=0;
        setlength(GOS[i].steps,a+1);
        GOS[i].NumSteps:=a;                 {num sels in grp}
        blockread(f,GOS[i].steps[0].meth,2);
        GOS[i].steps[0].e1:=ReadEntry(10);
        GOS[i].steps[0].e2:=ReadEntry(10);
        for k:=1 to a do
         begin
          blockread(f,GOS[i].steps[k].slct,2);
          blockread(f,GOS[i].steps[k].meth,2);
          GOS[i].steps[k].e1:=ReadEntry(10);
          GOS[i].steps[k].e2:=ReadEntry(10);;
          GOS[i].NumSteps := k;
         end; {for k}
        blockread(f,m,2);
        if m>nmbrsubjects then m:=0;
        if m>0 then for n:=1 to m do blockread(f,dummy,2);
       end; {for i}
       blockread(f,GOSmenu[0],2);
        IntRange(GOSmenu[0],0,nmbrCustomGroupMenus);
       if GOSmenu[0]>0 then
        for k:=1 to GOSmenu[0] do
        begin
         blockread(f,GOSmenu[k],2);
         IntRange(GOSmenu[k],0,GOSnum);
        end;
    end;


    procedure MakeGOS;
    var
     i,a:       smallint;
    begin
     setlength(GOS,nmbryears+1);
     setlength(GOSname,nmbryears+1);
     for i:=0 to nmbryears do
     begin
      setlength(GOS[i].steps,2+1);
     end;
     GOSnum:=1;
     SetGOSunit(0,0,1,0,0,'','');
     SetGOSunit(1,1,1,0,0,'',''); GOSname[1]:='All';
     GOSmenu[0]:=0; {none}
     a:=1;
     try
      for i:=years_minus_1 downto 0 do
       if yearStat[i].numstud>0 then
       begin
        inc(a);
        GOSname[a]:=yeartitle+' '+yearname[i];
        GOS[a].SubOfferName:='';
        SetGOSunit(a,1,1,1,0,yearname[i],'');
       end;
      GOSnum:=a; {nmbr of groups}
      GOSmenu[0]:=a;
      for i:=1 to a do GOSmenu[i]:=i;
     except
     end;

    end;

    procedure loadGOSnew;
    var
     i,k,a:       smallint;
    begin
     blockread(f,GOSnum,2);
     setlength(GOS,GOSnum+1);
     setlength(GOSname,GOSnum+1);
     if GOSnum>0 then
      for i:=1 to GOSnum do
       begin
        blockread(f,a,2);
        if a>0 then GOSname[i]:=ReadEntry(a) else GOSname[i]:='';
        blockread(f,a,2);
        if a>0 then GOS[i].SubOfferName:=ReadEntry(a) else GOS[i].SubOfferName:='';
        blockread(f,a,2);
        if a>50 then a:=0;
        setlength(GOS[i].steps,a+1);
        GOS[i].NumSteps:=a;                 {num sels in grp}
        GOS[i].Steps[0].slct:=0; GOS[i].steps[0].meth:=0;
        GOS[i].steps[0].e1:=''; GOS[i].steps[0].e2:='';
        for k:=1 to a do
         begin
          blockread(f,GOS[i].steps[k].slct,2);
          blockread(f,GOS[i].steps[k].meth,2);
          GOS[i].steps[k].e1:=ReadEntry(10);
          GOS[i].steps[k].e2:=ReadEntry(10);;
         end; {for k}

       end; {for i}
       blockread(f,GOSmenu[0],2);
        IntRange(GOSmenu[0],0,nmbrCustomGroupMenus);
       if GOSmenu[0]>0 then
        for k:=1 to GOSmenu[0] do
        begin
         blockread(f,GOSmenu[k],2);
         IntRange(GOSmenu[k],0,GOSnum);
        end;
    end;


begin
 chdir(Directories.datadir);
 fn:='GROUP.DAT';
 if fileexists(fn) then
 begin
  try
   try
     assign(f,fn);
     reset(f,1);
     s:='AMIG';
     blockread(f,s[1],4);
     if s='TC52' then loadGOSNew
      else if s='TC5W' then loadGOSOld
       else MakeGOS;

   finally
    closefile(f);
   end;

   except
   end;
  end
 else MakeGOS;
 try
   updateCustomMenus;
 except
 end;

end;

procedure ETin;
var
 f:       file;
 f1:      textfile;
 astr,s:    string;
 i,num,ercode,l:       integer;
begin
 chdir(Directories.datadir);
 if not(fileexists('EMTEACH.DAT')) then
 begin
  Etnum:=0; Etnum1:=0; Etlencodes:=lencodes[1];
  exit;
 end;
 doAssignFile(f,'EMTEACH.DAT');
 try
  try
   filemode:=fmOpenRead+fmShareDenyNone;
   reset(f,1);
   NEW_DateChecks[2]:=FileDateToDateTime(fileage('EMTEACH.DAT'));   
   SetLength(astr,4);
   blockread(f,astr[1],4);
   if astr='TCV5' then
   begin
      blockread(f,Etnum,2); blockread(f,Etlencodes,2);
       IntRange(Etnum,0,nmbrAddedTeachers); IntRange(Etlencodes,2,szTecode);
      if Etnum>0 then
      begin
       for i:=1 to Etnum do
       begin
        etsub[i][0]:=chr(Etlencodes);
        blockread(f,etsub[i][1],Etlencodes);
        TrimRight(etsub[i]);
        SetLength(Astr,szTename);
        blockread(f,astr[1],szTename);
        ETname[i]:=trim(astr);
        TrimRight(ETname[i]);
        // #171
        //SetLength(Astr,szEcomment);
        //blockread(f,astr[1],szEcomment);
        blockread(f,l,2); // Size of Comments
        SetLength(Astr,l);
        blockread(f,astr[1],l);
        Etcomment[i]:=trim(astr);
        TrimRight(Etcomment[i]);
        blockread(f,ETfaculty[i],2);
        blockread(f,ETfaculty2[i],2);
        blockread(f,ETfaculty3[i],2);
        blockread(f,ETfaculty4[i],2);
        // #173
        SetLength(AStr,15);
        blockread(f,astr[1],15);
        ETPhone[i] := trim(astr);
        blockread(f,ETPriority[i],2);
        blockread(f,ETMon[i],2);
        blockread(f,ETTue[i],2);
        blockread(f,ETWed[i],2);
        blockread(f,ETThu[i],2);
        blockread(f,ETFri[i],2);
        blockread(f,ETSat[i],2);
        blockread(f,ETSun[i],2);
       end; {for i}
      end;
   end else begin
     if astr='TCV4' then
     begin
      blockread(f,Etnum,2); blockread(f,Etlencodes,2);
       IntRange(Etnum,0,nmbrAddedTeachers); IntRange(Etlencodes,2,szTecode);
      if Etnum>0 then
      begin
       for i:=1 to Etnum do
       begin
        etsub[i][0]:=chr(Etlencodes);
        blockread(f,etsub[i][1],Etlencodes);
        TrimRight(etsub[i]);
        SetLength(Astr,szTename);
        blockread(f,astr[1],szTename);
        ETname[i]:=trim(astr);
        TrimRight(ETname[i]);
        SetLength(Astr,szEcomment);
        blockread(f,astr[1],szEcomment);
        Etcomment[i]:=trim(astr);
        TrimRight(Etcomment[i]);
        blockread(f,ETfaculty[i],2);
       end; {for i}
      end;
     end
     else
      begin
       seek(f,0);
       blockread(f,Etnum,2);
       Etlencodes:=lencodes[1];
       if Etnum>0 then
       begin
        for i:=1 to Etnum do
        begin
         SetLength(etsub[i],5);
         blockread(f,etsub[i][1],5);
         SetLength(astr,szTename);
         blockread(f,astr[1],sztename);
         ETname[i]:=trim(astr);
         SetLength(astr,szecomment);
         blockread(f,astr[1],szecomment);
         Etcomment[i]:=trim(astr);
         etsub[i]:=copy(etsub[i],1,lencodes[1]);
         ETfaculty[i]:=-1;
        end; {for i}
       end;
      end;
   end;
  finally
   closefile(f);
  end;
 except

 end;
 CountETnum1;
 SetLength(ETmail,Etnum+1);
 for i:=1 to Etnum do ETmail[i]:='';
 if (fileexists('ETMAIL.DAT')) then
  try
   try
    doAssignFile(f1,'ETMAIL.DAT');
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(f1);
    readln(f1,s); val(s,num,ercode);
    if num>Etnum then SetLength(ETmail,num+1);
    for i:=1 to num do
     begin
      readln(f1,s);  ETmail[i]:=trim(s);
     end;
   finally
    closefile(f1);
   end;
  except

  end;

end;

procedure LoadCoverWeights;
var
  f:file;
  fname: string;
  i,j: smallint;
  astr: string;
  lAmtTransferred: Integer;

   procedure InitWeights;
   var
    i,j:       smallint;
   begin
    WtET:=9999; WtFrees:=1; WtToday:=-3; WtAvail:=1; WtPerc:=20;
    WtETfac:=1; WtWeek:=-1;
    WtLastNum:=3; WtLast:=-2; Wtfac:=1; WtSpare:=1; WtLieu:=4000;
    WtReplace:=5000; WtPrefer:=1;  KeepReplaceFlag:=false;
    for i:=1 to nmbrperiods do
     for j:=0 to days-1 do
      begin
       torder[i,j]:=i;  astr:='   ';
       astr:=inttostr(i);
       if i>9 then astr:=chr(55+i);
       tslotcode[i,j]:=astr;
      end;
   end;


begin
 InitWeights;
 fname:='COVERSET.DAT';
 astr:='TCE5';
 if not(fileexists(fname)) then exit;
 doAssignFile(f,fname);
 try
  try
   filemode:=fmOpenRead+fmShareDenyNone;
   reset(f,1);
   NEW_DateChecks[6]:=FileDateToDateTime(fileage('COVERSET.DAT'));
   blockread(f,astr[1],4);
   if astr='TCE5' then
    begin
     blockread(f,WtET,2); blockread(f,WtFrees,2); blockread(f,WtToday,2);
     blockread(f,WtAvail,2); blockread(f,WtPerc,2); blockread(f,WtETfac,2);
     blockread(f,WtWeek,2); blockread(f,WtLastNum,2); blockread(f,WtLast,2);
     blockread(f,Wtfac,2); blockread(f,WtSpare,2); blockread(f,WtLieu,2);
     blockread(f,WtReplace,2); blockread(f,WtPrefer,2);
     blockread(f,KeepReplaceFlag,2);
    end {version 5}
   else
    begin {version 4}
     reset(f,1);
     for i:=1 to nmbrperiods do
      begin
        blockread(f,torder[i,0],2);
        for j:=1 to days-1 do Torder[i,j]:=Torder[i,0];
        SetLength(tslotcode[i,0],1);
        blockread(f,tslotcode[i,0][1],1);
        for j:=1 to days-1 do tslotcode[i,j]:=tslotcode[i,0];
      end; {for i}
     blockread(f,WtET,2); blockread(f,WtFrees,2); blockread(f,WtToday,2);
     blockread(f,WtAvail,2); blockread(f,WtPerc,2); blockread(f,WtETfac,2);
     BlockRead(f, WtWeek, 2, lAmtTransferred); BlockRead(f, WtLastNum, 2, lAmtTransferred); BlockRead(f, WtLast, 2, lAmtTransferred);
     BlockRead(f, Wtfac, 2, lAmtTransferred); BlockRead(f, WtSpare, 2, lAmtTransferred); BlockRead(f, WtLieu, 2, lAmtTransferred);
     BlockRead(f, WtReplace, 2, lAmtTransferred); BlockRead(f, WtPrefer, 2, lAmtTransferred);
    end; {version 4}
  finally
   closefile(f);
  end;
 except

 end;
end;

procedure teavailIN;
var
  i,j,a:   integer;
  f:       file;
  aStr,bstr:    string;
begin
 for i:=0 to nmbrTeachers do
  begin
   Emax[i]:=0; Etaken[i]:=0; Eweek[i]:=0; Eday[i]:=0; Emonth[i]:=0;
   for j:=1 to nmbrLikePreferences do
    begin
     LikeDay[i,j]:=-1;
     LikeTime[i,j]:=0;
    end;
   Elieu[i]:=0; Elieutaken[i]:=0; Ereplace[i]:=0; Eten[i]:=0; //EUserChanged[i] := False;
  end;
 if not(fileexists('TEAVAIL.DAT')) then exit;

 doAssignFile(f,'TEAVAIL.DAT');
 try
  try
   filemode:=fmOpenRead+fmShareDenyNone;
   reset(f,1);
   NEW_DateChecks[3]:=FileDateToDateTime(fileage('TEAVAIL.DAT'));
   SetLength(aStr,4);
   blockread(f,aStr[1],4);
   aStr:=uppercase(aStr);
   if ((aStr='TCV4') or (aStr='TCE4') or (aStr='TCE5')) then
   begin
    a:=numcodes[1];
    if a>0 then
     for i:=1 to a do
      begin
       blockread(f,Emax[i],8);   MinCheckDoubleVal(Emax[i]);
       blockread(f,Etaken[i],8); MinCheckDoubleVal(Etaken[i]);
       if (aStr='TCE4') or (aStr='TCE5') then
        begin
         blockread(f,Elieu[i],8);  MinCheckDoubleVal(Elieu[i]);
         blockread(f,Elieutaken[i],8); MinCheckDoubleVal(Elieutaken[i]);
        end;
       if (aStr='TCE5') then
         begin
          blockread(f,Ereplace[i],8); MinCheckDoubleVal(Ereplace[i]);
         end;
       blockread(f,Eweek[i],8);  MinCheckDoubleVal(Eweek[i]);
       blockread(f,Eday[i],2);
       if not IntRange(Eday[i], 1, 31) then
         Eday[i] := 0;
       blockread(f,Emonth[i],2);
       if not IntRange(Emonth[i], 1, 12) then
         Emonth[i] := 0;
       for j:=1 to nmbrLikePreferences do
        begin
         blockread(f,LikEday[i,j],2); IntRange(LikEday[i,j],-1,(days-1));
         blockread(f,LikeTime[i,j],2);IntRange(LikeTime[i,j],0,(periods-1));
        end;  {for j}
       blockread(f,Eten[i],2);
       SetLength(bStr,szEcomment);
       blockread(f,bStr[1],szEcomment);
       if IsAlphaNumeric(bStr) then
         Ecomment[i] := Trim(bStr);
      end; {for i}
   end
  else  {not((aStr='TCV4') or (aStr='TCE4')or (aStr='TCE5'))}
   begin
    a:=numcodes[1];
    seek(f,0);
    if a>0 then
    begin
     for i:=1 to a do
     begin
      SetLength(astr,8); blockread(f,astr[1],8);
      Emax[i]:=BCD2BIN(astr);  MinCheckDoubleVal(Emax[i]);
      SetLength(astr,8); blockread(f,astr[1],8);
      Etaken[i]:=BCD2BIN(astr);  MinCheckDoubleVal(Etaken[i]);
      SetLength(astr,8); blockread(f,astr[1],8);
      Eweek[i]:=BCD2BIN(astr);  MinCheckDoubleVal(Eweek[i]);
      blockread(f,Eday[i],2);
      if not IntRange(Eday[i], 1, 31) then
        Eday[i] := 0;
      blockread(f,Emonth[i],2);
      if not IntRange(Emonth[i], 1, 12) then
        Emonth[i] := 0;
      for j:=1 to nmbrlikepreferences do
      begin
       blockread(f,likEday[i,j],2);
       blockread(f,LikeTime[i,j],2);
      end; {for j}
      blockread(f,Eten[i],2);
      SetLength(astr,szEcomment); blockread(f,astr[1],szEcomment);
      if IsAlphaNumeric(bStr) then
        Ecomment[i] := Trim(astr);
     end; {for i}
    end;
   end;

  finally
   closefile(f);
  end;
 except

 end;
end;

procedure CountIDlen;
var
  i,k:    smallint;
begin
  IDlen:=0;
  for i:=1 to numstud do
  begin
   k:=ord(Stud[i].ID[0]);
   if k>IDlen then IDlen:=k;
  end;
  //if IDlen>10 then IDlen:=10;
  if IDlen>szID then IDlen:=szID;
end;

procedure TAbout.ProgramIconDblClick(Sender: TObject);
begin
 Alphablend:=not(AlphaBlend);
end;

function TAbout.RefreshAddedStaffAvailability: Boolean;
begin
  Result := AddStaffAvailabilities.RefreshFromFile;
end;

procedure TAbout.RefreshMaxInLieu;
{var
  lTeNo: Integer;
  lTotalLoad: Double;
  lDutyload: Double;
  j: Integer;}
begin
  {lTotalLoad := CalculateLoads;
  for lTeNo := 1 to codenum[1] do
  begin
    if Elieu[lTeNo] = 0 then
    begin
      lDutyload := 0;
      for j := 0 to 2 do
        lDutyload := lDutyload + Dutyload[lTeNo, j];
      ELieu[lTeNo] := lTotalLoad - TeActualLoad[lTeNo] - lDutyload;
    end;
  end;}
end;

function TAbout.RefreshObjects: Boolean;
begin
  RefreshTeacherAbsence;
  RefreshAddedStaffAvailability;
  Result := True;
end;

function TAbout.RefreshTeacherAbsence: Boolean;
var
  i: Integer;
  j :Integer;
  k :Integer;
  lCoverTally: Integer;
  lTeacherTally: TAMGTeacherTally;
  lTeIndex: Integer;
  lTeCode: string;
begin
  TeacherAbsences.RefreshFromFile;
  Pstextra.ReadPastExtras;
  for i := 1 to CodeNum[2] do
  begin
    lCoverTally := 0;
    lTeCode := TeCode[CodePoint[i, 2], 0];
    for j := 1 to NumChanges do
    begin
      //Add current extras
      if Changes[j].OldTe = CodePoint[i, 2] then
      begin
        Inc(lCoverTally);
      end; // if
    end;
    //Now add past
    for k := 1 to NumAbsences do
    begin
      if Past[k].aOldTe = CodePoint[i, 2] then
      begin
        Inc(lCoverTally);
      end;
    end;

    lTeIndex := TeacherTallies.GetIndex(lTeCode);
    if lTeIndex > - 1  then
      TAMGTeacherTally(TeacherTallies.Items[lTeIndex]).CoverTally := lCoverTally
    else
    begin
      lTeacherTally := TAMGTeacherTally.Create;
      lTeacherTally.Code := lTeCode;
      lTeacherTally.CoverTally := lCoverTally;
      TeacherTallies.Add(lTeacherTally);
    end; // if
  end; // for
  Result := True;
end;


procedure getReasons;
var
 i:       integer;
 aStr:    string;
 f:       file;
 FileVerStr: string;
begin
 chdir(Directories.datadir);
 if FileExists(REASONS_XML_FILE) then begin
  getReasons_xml;
  exit;
 end;
 Abcode[0]:='oth';
 Absent[0]:='(Other reason)';

 if not(fileexists('REASON.DAT')) then exit;
 doAssignFile(f,'REASON.DAT');
 try
  try
   filemode:=fmOpenRead+fmShareDenyNone;
   reset(f,1);
   NEW_DateChecks[4]:=FileDateToDateTime(fileage('REASON.DAT'));
   SetLength(aStr,4);
   blockread(f,aStr[1],4);
   FileVerStr := aStr;

   if (FileVerStr='TCV6') then
   begin
    for i:=1 to nmbrReasons do
    begin
     SetLength(astr,szAbcode );
     blockread(f,astr[1],szAbcode );
     Abcode[i]:=trim(astr);
     SetLength(astr,szAbReason);
     blockread(f,astr[1], szAbReason);
     Absent[i]:=trim(astr);
    end; {for i}
    for i:=1 to nmbrReasons do
    begin
     SetLength(astr,szCovNotes); // previous size was szEcomment.. Mantis 1333
     blockread(f,astr[1], szCovNotes); // previous size szEcomment.. Mantis 1333
     Cover[i]:=trim(astr);
    end; {for i}


   end;

  if (FileVerStr='TCV5') then
   begin
    for i:=1 to 30 do
    begin
     SetLength(astr,szAbcode );
     blockread(f,astr[1],szAbcode );
     Abcode[i]:=trim(astr);
     SetLength(astr,szAbReason);
     blockread(f,astr[1], szAbReason);
     Absent[i]:=trim(astr);
    end; {for i}
    for i:=1 to 30 do
    begin
     SetLength(astr,szEcomment);
     blockread(f,astr[1], szEcomment);
     Cover[i]:=trim(astr);
    end; {for i}
   end;

   if FileVerStr='TCV4' then
   begin
    for i:=1 to 30 do
    begin
     SetLength(astr,szAbcode );
     blockread(f,astr[1],szAbcode );
     Abcode[i]:=trim(astr);
     SetLength(astr,szEcomment);
     blockread(f,astr[1], szEcomment);
     Absent[i]:=trim(astr);
    end; {for i}
    for i:=1 to 30 do
    begin
     SetLength(astr,szEcomment);
     blockread(f,astr[1], szEcomment);
     Cover[i]:=trim(astr);
    end; {for i}
   end;

   if (FileVerStr<>'TCV4') and (FileVerStr<>'TCV5') and (FileVerStr<>'TCV6') then
    begin
     seek(f,0);
     for i:=1 to 10 do
     begin
      SetLength(astr,szEcomment);
      blockread(f,astr[1], szEcomment);
      Absent[i]:=trim(astr);
      aStr:=inttostr(i);
      if Absent[i]<>'' then Abcode[i]:=aStr
       else Abcode[i]:='';
     end; {for i}
     for i:=1 to 10 do
     begin
      SetLength(astr,szEcomment);
      blockread(f,astr[1], szEcomment);
      Cover[i]:=trim(astr);
     end; {for i}
    end;
  finally
   closefile(f);
   saveReasons_xml;
  end;
 except
 end;
end;

procedure EmailRegistrySettings;
var
  Registry: TRegistry;
  AccountStr: string;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := hkey_CURRENT_USER;
    if Registry.OpenKey('software\microsoft\internet account manager', False) then  {}
    begin
      AccountStr := Registry.ReadString('default mail account');
      Registry.CloseKey;
      if (AccountStr <> '') then
        if Registry.OpenKey('software\microsoft\internet account manager\accounts\' +
          AccountStr, False) then  {}
        begin
          EmailHost:= Registry.ReadString('SMTP Server'); //host
          EmailSend:= Registry.ReadString('SMTP Email Address'); // address from
//          Edit3.Text := Registry.ReadString('SMTP Reply To Email Address');// return to
//          Edit4.Text := Registry.ReadString('SMTP Organization Name'); // school name
          EmailDisplayName:= Registry.ReadString('SMTP Display Name'); // display name
          EmailUserID:= Registry.ReadString('POP3 User Name'); // userID
          Registry.CloseKey;
        end;
    end;
  finally
    Registry.Free;
  end;
end;

procedure EmailSetupRead;
var
 TempList: Tstrings;
 Cipher: TDCP_Rijndael;
 KeyStr: string;
begin
  TempList := TStringList.Create;	{ construct the list object }
  Cipher:= TDCP_Rijndael.Create(mainform);
  try
   TempList.LoadFromFile('EmailSetup.DAT');
   {decrypt string}
   KeyStr:= KeyStrRt;
///   KeyStr:=rotit(KeyStrRt);
   Cipher.InitStr(KeyStr,TDCP_sha1);   // initialize the cipher with a hash of the passphrase
   TempList.text:= Cipher.DecryptString(TempList.text);
   Cipher.Burn;
   {retrieve strings}
   EmailHost:=TempList.Strings[0];
   if TempList.Count > 1 then
     EmailUserID := TempList.Strings[1];
   if TempList.Count > 2 then
     EmailPassword := TempList.Strings[2];
   if TempList.Count > 3 then
     EmailSend := TempList.Strings[3];
   if TempList.Count > 4 then
     EmailDisplayName := TempList.Strings[4];
   if TempList.Count > 5 then
     EmailPort := StrToInt(TempList.Strings[5])
   else
     EmailPort := 25;
  finally
    TempList.Free;
    Cipher.Free;
  end;
end;

procedure emailSetup;
begin
  try
    if fileexists('EmailSetup.DAT') then EmailSetupRead
    else
    begin
       EmailHost:='';
       EmailUserID:='';
       EmailPassword:='';
       EmailSend:='';
       EmailDisplayName:='';
       EmailPort := 25;
       EmailRegistrySettings;
       EmailSetupWrite;
       //    if IsConnectedToInternet then
    end;
  except
  end;
end;

procedure winShow;
var
 i,j:       integer;
begin
 if winOrderNum>0 then
 begin
  for i:=winOrderNum downto 1 do
  begin
   j:=winOrder[i];   {windows tag value}
   if winpos[j].height>0 then {only if its been saved once and array initialized}
   case j of
    wnInfo: infowinselect;
    wnTimes: TimesWinSelect;
    wnTecode:  TeWinSelect;
    wnAddedStaff: AddedStaffWinSelect;
    wnAbsReason: absreasonswinselect;
    wnCoverNote: covernoteswinselect;
    wnTtable:  Ttablewinselect;
    wnSubjectList: SubjectbySubjectListwinSelect;
    wnTimeList: SubjectbyTimeSlotwinSelect;
    wnStudentList: StudentListwinSelect;
    wnTeacherTt: teachTtablewinSelect;
    wnRoomTt: roomTtablewinSelect;
    wnSubjectTt: subjectTtablewinSelect;
    wnStudentTt: studentTtablewinSelect;
    wnAbsentTe: AbsentteWinSelect;
    wnNewClass: NewClassWinSelect;
    wnLostClass: LostClassWinSelect;
    wnMergeClass: MergedClassWinSelect;
    wnUnavailRooms: UnavailableRoomsWinSelect;
    wnRoomSwap: roomswapsWinSelect;
    wnCurrentExtras: CurrentExtrasWinSelect;
    wnAddedSel: addedstaffselwinSelect;
    wnPastExtras: PastExtrasWinSelect;
    wnTeFree: TeachersFreewinSelect;
   end; {case j of}
  end; {for i}
 end; {if winOrderNum>0}
end;

procedure ReLoadCustomAtStart;
var
 S:       string;
 i:       smallint;
begin
 try
  if not(customFileLoadFlag) then exit;
  chdir(Directories.datadir);
  s:=Extractfilename(customFileLoad);
  i:=pos('.',s);
  if boolean(i) then s:=copy(s,1,i-1);
  custom:=s;
  getcustom;
 except
 end;
end;

procedure extrasFileName;
var
 f:       textfile;
begin
 if fileexists('EXFILE.DAT') then
 begin
  try
   try
    doAssignFile(f,'EXFILE.DAT');
    filemode:=fmOpenRead+fmShareDenyNone;
    reset(f);
    readln(f,usefile);
    readln(f,usedir);
   finally
    closefile(f);
   end;
  except

  end;
 end
 else
  begin
   usefile:='EXTRAS'; usedir:=Directories.datadir;
  end;
 if fileexists(usefile+'.XTR') then usedir:=Directories.datadir;
 exfile:=usefile; exdir:=usedir; exload:=usedir;
end;

function  ReadTTinUse: string;
var
 f: file;
 astr: string;
 k: smallint;
begin
 Result:=FileNames.LoadedTimeTable;
 if FileExists(InuseDataFile) then
   try
    try
     doAssignFile(f,InuseDataFile);
     filemode:=fmOpenRead+fmShareDenyNone;
     reset(f,1);
     blockread(f,TtInUseNum,2);
     astr:='';
     blockread(f,k,2);
     if k>0 then
     begin
      astr:=space(k);
      blockread(f,astr[1],k);
     end;
     Result:=astr;
    finally
     closefile(f);
    end;
   except
   end;
end;

procedure TAbout.firstLoad;
var
 i: smallint;
begin
 if DirectoryExists(Directories.datadir) then
 begin
  chdir(Directories.datadir);
  FileNames.LoadedTimeTable:= ReadTTinUse;
  getTTable;
  getCodes;  ETin;
  InitializeCustom;
  getFaculty;
  ClassLoad;
  HouseLoad;
  LoadCoverWeights;
  ExtrasAllotload;
  loadwinDisplay;

  for i:=0 to 2 do sortCodes(i);  {do sort after reading sorttype from disp file}
  Etsort2; etsort3;

  SetPshowmax;
  SetTimeCell;
  SetDays;

  screen.cursor:=crHourglass;
  numStud:=0;
  for i:=0 to years_minus_1 do StudentQuickStreamLoad(i);
  loadGroups;
  setlength(StudGrpFlg,(numStud+1));
  SubSexCountFlg:=true;
  sortStudents;   {maintain sort after sep. years}
  groupsetAll;
  CountChmax;
  if GroupIndexDisplay = 0 then
  begin
    GroupSetAll;
  end
  else if GroupIndexDisplay > 0 then
  begin
    CookCustomGroup(GroupIndexDisplay);
    for i := 0 to MainForm.Student1.Count - 1 do
    begin
      if MainForm.Student1.Items[i].Tag = GroupIndexDisplay then
        MainForm.Student1.Items[i].Checked := True
      else
        MainForm.Student1.Items[i].Checked := False;
    end;
  end;
  updateGroupSubs;
  CountIDlen;
  ReLoadCustomAtStart;
  {validate selections for listboxes here to reduce errors due to corrupt file}
  rangeCheckSubSels(ttprntselsubg);
  rangeCheckCodeSels(ttprntselteachg,1);
  rangeCheckCodeSels(ttprntselroomg,2);
  rangeCheckCodeSels(rottselection,2);
  rangeCheckCodeSels(tettselection,1);

  AlterTimeFlag:=True;

  {----- tce4w load adds ----------}

  extrasFileName;
  checkPastExtras;
  TeAvailIn;
  RefreshMaxInLieu;
  getReasons;
  extrasIn;
  emailSetup;
  updateTelink;
  etsort2;    etsort3;
  sortabcodes;
  sortlccodes;
  {----------------------}
  studentPointerSet;
  calcReasonsInUse;
  calcCoverInUse;
  updateStatusPanel;
  //MainForm.ActionToolbar1.Visible:=ToolbarFlag;

 end;
  IsEnoughLevels;
  RefreshObjects;
end;

procedure TAbout.FormCreate(Sender: TObject);
var
 tmpstr: string;
 lDate: TDateTime;
 lKeyFileOK: Boolean;
begin
  TCvers:='Version 6.0.0.0';
  TCvers := 'Version '+GetVersion;

  {School:='PROPERTY OF AMIG SYSTEMS   (EVALUATION COPY ONLY)';}
  {School:='PROPERTY OF AMIG SYSTEMS   (SEMINAR TRAINING)';}

  {TIME CHART EXTRA TIME CHART EXTRA TIME CHART EXTRA
  TIME CHART EXTRA TIME CHART EXTRA TIME CHART EXTRA
  TIME CHART EXTRA TIME CHART EXTRA TIME CHART EXTRA}
  School:='PROPERTY OF AMIG SYSTEMS';
  {TIME CHART EXTRA TIME CHART EXTRA TIME CHART EXTRA
  TIME CHART EXTRA TIME CHART EXTRA TIME CHART EXTRA
  TIME CHART EXTRA TIME CHART EXTRA TIME CHART EXTRA}

 loadFinished:=false;
 newdataloadcancel:=false;
 DateStr:=FormatDateTime('d mmmm yyyy',date);

 screen.cursor:=crDefault;
    tmpstr:=Paramstr(0);
    Directories.progdir:=GetDirName(tmpstr);
    checkpassword;
  MainForm.mniUserClearUserAccessLocks.Visible := usrPassLevel = 6;
 screen.cursor:=crHourglass;

 If OKquitcheck =True then Exit;    //Mantis-0001621

 getTTfilename;
 getDirectories;
 if (trim(usrPassDir)='') then usrPassDir:=Directories.datadir;
 CheckAccessFile;

 screen.cursor:=crHourglass;
 timer1.enabled:=true;  {done here incase getdirdlg comes up, don't want about restored too soon.}


 {$IfDef TRIAL}
// lDate := StrToDateTime('14/07/2011');
 lDate := EncodeDate(2013,04,30);
 lKeyFileOK := lDate >= Date;
 School := 'AMIG SYSTEMS - Trial Version';
 //lblExpiry.Caption := 'Expiry date: ' + DateTimeToStr(lDate);
 if not lKeyFileOK then
 begin
   School := 'Time Limited Trial has expired!';
  about.timer1.enabled:=false;
 //reset about to use as about box
  setTitle;
  about.SchoolName.caption := School;
  about.okbutton.visible:=true;
  about.borderstyle := bsNone;
  about.bordericons:=[biSystemMenu];
  about.caption:='About';
  screen.cursor:=crDefault;
  TCE5Error := 1; // to close the application
  About.ShowModal;
 end
 else
 begin
 {$EndIf}

 if not(KeyFileValidationCheck) then Timer1Timer(Self);
 setTitle;
 if TCE5Error=0 then
  begin
   about.show;
   about.refresh;
   mainform.caption:='TimeChart Extra 6 - '+school;
   firstLoad;
   mainform.canvas.font.assign(tcfont);

   getFontWidths; {get max for commons such as teacher name, faculty name etc}
   Winshow;    {restores previously open windows}

   loadFinished:=true;  {flag to allow timer to reset about box}
  end
 else about.showmodal;

 {$IfDef TRIAL}
 end;
 {$EndIf}

end;

procedure TAbout.FormDestroy(Sender: TObject);
var
 i:       integer;
begin
 for i:=0 to nmbrDays-1 do Dispose(ttMain[i]);
 tcfont.free;
end;

procedure TAbout.CloseAbout(Sender: TObject);
begin
 about.hide;
end;

procedure TAbout.Timer1Timer(Sender: TObject);
begin
  about.timer1.enabled:=false;
 {reset about to use as about box}
  about.hide ;
  about.loadlabel.visible:=false;
  about.okbutton.visible:=true;
  //about.borderstyle:=bsDialog;
  about.bordericons:=[biSystemMenu];
  about.caption:='About';
  screen.cursor:=crDefault;
end;

procedure TAbout.UpdateComparisonLevels;
var
  i: Integer;
  lYearLevel: TYearLevel;
begin
  if Assigned(YearLevels) then
  begin
    YearLevels.Clear;
    for i := 0 to years_minus_1 do
    begin
      lYearLevel := TYearLevel.Create;
      lYearLevel.Year := i;
      lYearLevel.LevelSize := Level[i];
      YearLevels.Add(lYearLevel);
    end;
  end;
end;

procedure TAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caHide;
end;

procedure TAbout.FormDeactivate(Sender: TObject);
begin
 if TCE5Error>0 then application.Terminate;
end;

initialization

screen.cursor:=crHourglass;

initFontColorPairs; {used in dispString}

for i:=0 to nmbrDays-1 do
 begin
  New(ttMain[i]);
  {initialize blocks to zero}
  fillchar(ttMain[i]^,sizeof(ttMain[i]^),chr(0));
 end;

end.
