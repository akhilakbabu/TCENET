unit Tcommon5;
{$WARN UNIT_PLATFORM OFF}
interface
uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, SysUtils,Messages,FileCtrl,grids
  ,TCeload,Ttable,tceglobals, XML.UTILS, GlobalToTcAndTcextra, XML.USERS;

procedure checkpassword;
function FNencrypt(astr:shortstring):shortstring;
function FNencryptDIR(astr:shortstring):shortstring;
procedure idle(s: longint);  {pause for s milliseconds}
function myDelay(ms: DWORD):DWORD;
procedure NETreadINT(var f: file; var a: smallint);
procedure NETreadstring(var f: file; var astr: shortstring; alen: smallint);
procedure NETwritestring(var f: file; var astr: shortstring; alen: smallint);
procedure NETwriteINT(var f: file; var a: smallint);
procedure showPassLevel;
procedure newPassword;
procedure getPassword;
procedure ShowUsersWinSelect;
function SaveUsers: Boolean;
function findUserID(astr: shortstring): smallint;
procedure checkCount;
procedure loadUsers;
procedure CheckAccessFile;
function CheckPriorAccess(dataSection: smallint;
                           lockingData: bool):bool;
function CheckAccessRights(accessLevelNeeded,
                           dataSection: smallint;
                           lockingData: bool):bool;
procedure CheckForMouldyData;
procedure showRestrictedMsg;
procedure removeDormantLocks;
procedure getDEFDatadir;
function SafelyStreamToFile({var theStream: TStream;} tmpFileName, actFileName: shortstring):smallint;
function verifyUserDirectory(a: string):smallint;
procedure showInvalidDirectoryMsg(cc:integer;cstr:string);
procedure AccessFileMaintenance(fname: string);

{$WARN SYMBOL_DEPRECATED OFF}

implementation

uses
  tcommon,tcommon2,gtsprpss,logondlg,main,showuser,tcommon3, TeWnd, Addstaff,
  Absrsn, TimesWnd, uAMGCommon;

type tpAccessFileRec=record
                       date: tdatetime; {still 8 bytes - but no longer string[8];}
                       time: string[8];
                       userID: string[szPassID];
                       exname: string[80];
                       reserved: string[4];
                      end;
type tpTCAccessFileRec=record
                       date: tdatetime; {8 bytes}
                       time: string[8];
                       userID: string[szPassID];
                       exname: string[8];
                       reserved: string[4];
                      end;
                      
const
  szTCEWP51rec=sizeof(tpAccessFileRec);
  szTCWP51rec=sizeof(tpTCAccessFileRec);
  szIdleDelay=2000; {number of milliseconds}
  szIdleRetries=5; {number of times to retry}
var
 AccessRec: tpAccessFileRec;
 TCAccessRec: tpTCAccessFileRec;
 UserAccessfile: string;
 faccess: file;
 CheckForMouldyDataFlag: bool;

function openAccessFile: integer;
var
 tries,temp: smallint;
begin
 {$I-}
 doAssignFile(faccess,UserAccessfile);
 filemode:=fmOpenReadWrite+fmShareDenyWrite;
 reset(faccess,1);
 tries:=0;temp:=ioresult;
 while ((temp<>0) and (tries<szIdleRetries)) do
   begin
    idle(szIdleDelay);
    reset(faccess,1);  temp:=ioresult;
    inc(tries);
   end;     {should be open now}
 result:=temp; 
  {$I+}
end;

procedure showInvalidDirectoryMsg(cc:integer;cstr:string);
var
 msg: string;
begin
  if cc=3 then
   msg:='The directory'+endline+cstr+endline+'does not exist.'
  else
   msg:='You do not have read/write access to the directory'+endline+cstr;
  messagedlg(msg,mtInformation,[mbOK],183);
end;

function verifyUserDirectory(a: string):smallint;
var
 b,m: string;
 f: textfile;
begin
 result:=0;
 b:=trim(uppercase(a));
 if (trim(uppercase(Directories.progdir))=b) then
 begin  //check not same as program directory
  result:=1; exit;
 end;
 if (trim(uppercase(Directories.datadir))=b) then
 begin  //check not same as data directory
  result:=2; exit;
 end;
 {$I-}
 chdir(b);
 {$I+}
 if IOResult<>0 then
 begin   //check directory exists
  result:=3; exit;
 end;

 try   // check for read/write access
  try
    doAssignFile(F,'+');
    filemode:=fmOpenReadWrite+fmShareDenyWrite;
    rewrite(F);
    m:='TCE5 test file';
    Writeln(F,m);
    m:='1234567890';
  finally
   closefile(F);
  end;
  try
   reset(F);
   Readln(F,m);
  finally
   closefile(F);
  end;
  if (m<>'TCE5 test file') then
  begin
   result:=4; exit;
  end;
 except
  result:=4; exit;
 end;
end;

function TCcheckIDlock(data: smallint): bool;
var
 oktp: bool;
begin
  oktp:=true;
  try
    seek(faccess,data*(szTCWP51rec));
    blockread(faccess,TCAccessRec,sizeof(TCAccessRec));
    if ((uppercase(trim(TCAccessRec.UserID))>'') and
     (uppercase(trim(TCAccessRec.UserID))<>uppercase(trim(usrPassID)))) then
       oktp:=false;
  except
  end;
  result:=oktp;
end;


function checkIDlock(data: smallint): bool;
var
 oktp: bool;
begin
  oktp:=true;
  try
    seek(faccess,data*(szTCEWP51rec));
    blockread(faccess,AccessRec,sizeof(AccessRec));
    if ((uppercase(trim(AccessRec.UserID))>'') and
     (uppercase(trim(AccessRec.UserID))<>uppercase(trim(usrPassID)))) then
       oktp:=false;
  except
  end;
  result:=oktp;
end;


function TCsetIDaccess(i1:smallint):bool;
begin
 result:=false;
 try
   TCAccessRec.UserID:=usrPassID; TCAccessRec.Date:=now;
   seek(faccess,(i1*szTCWP51rec));
   blockwrite(faccess,TCAccessRec,sizeof(TCAccessRec));
   result:=true;
 except
 end;
end;

function setIDaccess(i1:smallint):bool;
begin
 result:=false;
 try
   AccessRec.UserID:=usrPassID; AccessRec.Date:=now;
   seek(faccess,(i1*szTCEWP51rec));
   blockwrite(faccess,AccessRec,sizeof(AccessRec));
   result:=true;
 except
 end;
end;

function TCclearIDaccess(i1:smallint):bool;
begin
 result:=false;
 try
   seek(faccess,(i1)*(szTCWP51rec));
   blockread(faccess,TCAccessRec,sizeof(TCAccessRec));
   if (uppercase(trim(TCAccessRec.UserID))=uppercase(trim(usrPassID))) then
     begin
      TCAccessRec.UserID:=space(szPassID);
      seek(faccess,(i1)*(szTCWP51rec));
      blockwrite(faccess,TCAccessRec,sizeof(TCAccessRec));
     end;
    result:=true;
 except
 end;
end;


function clearIDaccess(i1:smallint):bool;
begin
 result:=false;
 try
   seek(faccess,(i1)*(szTCEWP51rec));
   blockread(faccess,AccessRec,sizeof(AccessRec));
   if (uppercase(trim(AccessRec.UserID))=uppercase(trim(usrPassID))) then
     begin
      AccessRec.UserID:=space(szPassID);
      seek(faccess,(i1)*(szTCEWP51rec));
      blockwrite(faccess,AccessRec,sizeof(AccessRec));
     end;
    result:=true;
 except
 end;
end;


function SafelyStreamToFile(tmpFileName, actFileName: shortstring):smallint;
var
 ourSafetyFileStream: TFileStream;
 ourVerifyFileStream: TFileStream;
 ourVerifyStream: Tstream;
 ourCompStr1: TStringStream;
 ourCompStr2: TStringStream;
 ourErr: smallint;
 ourStr1: string;
 ourStr2: string;
begin
 ourErr:=0;  //no probs
{fmCreate	Create a file with the given name. If a file with the given name exists, open the file in write mode.
}
 {save the file }
 ourSafetyFileStream:=TFileStream.Create(tmpFileName,fmCreate);
 try
  ourSafetyFileStream.CopyFrom(tmemorystream(ourSafetyMemStream),0);
 finally
  ourSafetyFileStream.Free
 end;

 ourVerifyStream:=TMemoryStream.Create;
 ourVerifyFileStream:=TFileStream.Create(tmpFileName,fmOpenRead);
  try
   ourVerifyStream.CopyFrom(ourVerifyFileStream,0);
  finally
   ourVerifyFileStream.Free
  end;

 ourStr1:=''; ourCompStr1:=TStringStream.Create(ourStr1);
 ourStr2:=''; ourCompStr2:=TStringStream.Create(ourStr2);
 try
  ourCompStr1.CopyFrom(ourSafetyMemStream,0);
  ourCompStr2.CopyFrom(ourVerifyStream,0);
  if (ourCompStr1.DataString<>ourCompStr2.DataString) then ourErr:=1;
  if (ourCompStr1.Size<>ourCompStr2.Size) then ourErr:=2;
  if (ourSafetyMemStream.Size<>ourVerifyStream.Size) then ourErr:=3;

 finally
  ourVerifyStream.Free;
  ourCompStr2.Free;
  ourCompStr1.Free;
 end;

 if (ourErr=0) then
  if fileexists(tmpFileName) then    //only if tmp file was written out - else no point trying to switch
  begin
   if fileexists(actFileName) then  //getting error trying to delete what isn't there initially!
    if not(DeleteFile(actFileName)) then ourErr:=4;
   if not(RenameFile(tmpFileName,actFileName)) then ourErr:=5;
  end;

 case ourErr of
  1: showmessage('File Save Error 1 - Write Validation Failed');
  2: showmessage('File Save Error 2 - Write Validation Failed');
  3: showmessage('File Save Error 3 - Write Validation Failed');
  4: showmessage('File Save Error 4 - Unable to delete '+actFileName+' prior to update');
  5: showmessage('File Save Error 5 - Unable to rename '+tmpFileName+' prior to update');
 end;
 result:=ourErr;
end;

procedure ShowUsersWinSelect;
begin
 if usrPasslevel<>6 then exit;
 if wnFlag[wnShowUsers] then ShowUsersWin.show
  else ShowUsersWin:=tShowUsersWin.create(application);
end;



function findUserID(astr: shortstring): smallint;
var
 i,j:      smallint;
begin
 j:=-1;
 for i:=1 to UserRecordsCount do
  if uppercase(trim(astr))=uppercase(trim(passID[i])) then
   begin j:=i; break; end;
 result:=j;
end;

procedure getDEFDatadir; {read in def DIR.SYS ------------------------------}
var
 F:       textfile;
 tmpStr: String[szDirName];
begin
 try
  try
   chdir(Directories.progdir);
   doAssignFile(F,'DIR.SYS');
   reset(F);
   Readln(F,tmpStr);
   Readln(F,defDataDir);
  finally
   closefile(F);
  end;
 except
 end;
end;





procedure checkMouldOnEntry(dataSection: smallint);
var
 needrefreshFLG:      boolean;
 o_exday,o_exmonth,o_exyear,o_ttday: integer;
 msg:                                string;
begin
 needrefreshFLG:=false;
 chdir(Directories.datadir);
 case dataSection of
  1:  begin  {teachers}
       if (fileexists('TECODE.DAT') and fileexists('TENAME.DAT')
         and fileexists('TELOAD.DAT')) then
       begin
        if (NEW_DateChecks[1]<FileDateToDateTime(fileage('TECODE.DAT'))) then
        begin
         getTeacherCodes;
         sortcodes(1);
         needrefreshFLG:=true;
        end;
       end;
      end;
  2:  begin  {added staff}
       if (fileexists('EMTEACH.DAT')) then
       begin
        if (NEW_DateChecks[2]<FileDateToDateTime(fileage('EMTEACH.DAT'))) then
        begin
         Etin;
         needrefreshFLG:=true;
        end;
       end;
      end;
  3:  begin  {teacher tallies}
       if fileexists('TEAVAIL.DAT') then
       begin
        if (NEW_DateChecks[3]<FileDateToDateTime(fileage('TEAVAIL.DAT'))) then
        begin
         teavailin;
         needrefreshFLG:=true;
        end;
       end;
      end;
   4: begin  {reason/note}
       if fileexists('REASON.DAT') then
       begin
        if (NEW_DateChecks[4]<FileDateToDateTime(fileage('REASON.DAT'))) then
        begin
         getreasons;
         calcReasonsInUse;
         calcCoverInUse;
         needrefreshFLG:=true;
        end;
       end;
      end;
   5: begin  {allot/times}
       if fileexists('EXALLOT.DAT') then
        if (NEW_DateChecks[5]<FileDateToDateTime(fileage('EXALLOT.DAT'))) then
        begin
          ExtrasAllotload;
          needrefreshFLG:=true;
        end;
       end;
  6: begin  {weights}
      if fileexists('COVERSET.DAT') then
       if (NEW_DateChecks[6]<FileDateToDateTime(fileage('COVERSET.DAT'))) then
       begin
        LoadCoverWeights;
        needrefreshFLG:=true;
       end;
      end;
  9:  begin  {extras}
       if fileexists(exfile+'.XTR') then
       begin
        if (NEW_DateChecks[9]<FileDateToDateTime(fileage(exfile+'.XTR'))) then
        begin
         o_exday:=exday;    o_exmonth:=exmonth;
         o_exyear:=exyear;  o_ttday:=ttday;
         extrasin;
         needrefreshFLG:=true;
         if ((o_exday<>exday) or (o_exmonth<>exmonth) or (o_exyear<>exyear)
              or (o_ttday<>ttday)) then
          begin  {disp msg to indicate date change}
           msg:='The Date for the current extras has changed.'+endline;
           msg:=msg+'The new date is'+endline;
           msg:=msg+' Day: '+day[ttday]+' '+inttostr(exday)+' '
             +month[exmonth]+' '+formatdatetime('yyyy',now);
           messagedlg(msg,mtInformation,[mbOK],0);
          end;
        end;
       end;
      end;
 end; {case}
 if needrefreshFLG then UpdateAllWins;
end;


procedure CheckForMouldyData;
begin
 if not(loadFinished) then exit; //NOT during load
 if CheckForMouldyDataFlag then exit;  {prevent re entry}
 CheckForMouldyDataFlag:=true;
 MouldAge:=0; {reset timer}
 chdir(Directories.datadir);
 checkMouldOnEntry(1); //teacher codes
 checkMouldOnEntry(2); //added staff
 checkMouldOnEntry(3); //teacher tallies
 checkMouldOnEntry(4); //reasons
 checkMouldOnEntry(5); //allotments/times
 checkMouldOnEntry(6); //weights
 checkMouldOnEntry(7); //not currently in use - RESERVED
 checkMouldOnEntry(8); //not currently in use - RESERVED
 checkMouldOnEntry(9); //EXTRAS

 CheckForMouldyDataFlag:=false;
end;


function CheckTCPriorAccess(dataSection: smallint;
                           lockingData: bool):bool;
var
 msg:   shortstring;
 okTOpass: bool;
begin
 if (usrPasslevel=0) then begin result:=false; exit; end;
 okTOpass:=false;
 UserAccessfile:='TCWP51.DAT';
 try
  try
   if openAccessFile<>0 then
    begin
     msg:='Cannot open access file, try again later.';
     if lockingdata then messagedlg(msg,mtError,[mbOK],0);
     result:=false;
     exit;
    end;
   msg:='';
    if lockingdata then
     begin
        if not(TCcheckIDlock(dataSection)) then
           begin
              msg:='The User '+AccessRec.UserID
              +' is already altering this part of Time Chart.'+endline;
              try
               msg:=msg+'    ('+FormatDateTime('h:n:sam/pm "on" dddd"," mmmm d',AccessRec.Date)+')'+endline;
               msg:=msg+'No changes can be made to this data until this user has finished.';
              except

              end;
           end;

        if msg='' then {lockingdata, have locks and ID is clear so set ID's}
         okTOpass:=TCsetIDaccess(datasection);
     end {lockingdata}
     else
        okTOpass:=TCclearIDaccess(dataSection);  {clearing ID}
   if lockingdata then if msg>'' then messagedlg(msg,mtWarning,[mbOK],0);

  finally
   closefile(faccess);
  end;
 except

 end;
 result:=okTOpass;
end;


function CheckPriorAccess(dataSection: smallint;
                           lockingData: bool):bool;
var
 msg:   shortstring;
 okTOpass: bool;
begin
 if (usrPasslevel=0) then begin result:=false; exit; end;
 okTOpass:=false;
 UserAccessfile:='TCEWP51.DAT';
 chdir(Directories.datadir);
 if dataSection=1 then
   if fileexists('TCWP51.DAT') then
    begin
     result:=CheckTCPriorAccess(dataSection,lockingData);
     exit;
    end;
 try
  try
   if openAccessFile<>0 then
    begin
     msg:='Cannot open access file, try again later.';
     if lockingdata then messagedlg(msg,mtError,[mbOK],0);
     result:=false;
     exit;
    end;
   msg:='';
    if lockingdata then
     begin
        if not(checkIDlock(dataSection)) then
           begin
              msg:='The User '+AccessRec.UserID
              +' is already altering this part of Time Chart Extra.'+endline;
              try
               msg:=msg+'    ('+FormatDateTime('h:n:sam/pm "on" dddd"," mmmm d',AccessRec.Date)+')'+endline;
               msg:=msg+'No changes can be made to this data until this user has finished.';
              except

              end;
           end;

        if msg='' then {lockingdata, have locks and ID is clear so set ID's}
         okTOpass:=setIDaccess(datasection);
     end {lockingdata}
     else
        okTOpass:=clearIDaccess(dataSection);  {clearing ID}
   if lockingdata then if msg>'' then messagedlg(msg,mtWarning,[mbOK],0);

  finally
   closefile(faccess);
  end;
 except

 end;
 result:=okTOpass;
end;

procedure showRestrictedMsg;
var
 msg: shortstring;
begin
  msg:='Your User Access Level does not permit you to alter the data ';
  msg:=msg+'for this part of Time Chart Extra.';
  messagedlg(msg,mtInformation,[mbOK],176);
end;




function CheckEXAccess(dataSection: smallint;
                           lockingData: bool):bool;
var
 f:     file;
 msg:   shortstring;
 tries,accesscount,i: smallint;
 okTOpass: bool;
 found:    smallint;
 availRecPlace:    smallint;
begin
 if (usrPasslevel=0) then begin result:=false; exit; end;
 {$I-}
 fillchar(AccessRec,sizeof(AccessRec),chr(0));
 okTOpass:=false; {locked:=false;}
 found:=0;  availRecPlace:=0;
 chdir(Directories.datadir);
 try
  try
   doAssignFile(f,'TCEWP51.DAT');
   filemode:=fmOpenReadWrite+fmShareDenyWrite;
   reset(f,1);
   tries:=0;
   while ((ioresult<>0) and (tries<szIdleRetries)) do
   begin
    idle(szIdleDelay);
    reset(f,1);
    inc(tries);
   end;
   blockread(f,accesscount,2);
    IntRange(accesscount,9,32000); {must be atleast 9 if exists}
   if accesscount>9 then
    for i:=10 to accesscount do
    begin
     seek(f,longint(i)*(szTCEWP51rec));
     blockread(f,AccessRec,sizeof(AccessRec));
     if uppercase(trim(AccessRec.exname))='' then
      if availRecPlace=0 then availRecPlace:=i;
     if uppercase(trim(AccessRec.exname))=uppercase(trim(EXfile)) then
     begin
      found:=i; break;
     end;
    end; {for i}

   if not(bool(found)) then {add it}
   begin {check for deleted option first before adding new one}
    if availRecPlace>0 then found:=availRecPlace
     else begin
           inc(accesscount); found:=accesscount;
           seek(f,0); blockwrite(f,accesscount,2);
          end;

    seek(f,longint(found)*szTCEWP51rec);
    AccessRec.exname:=uppercase(EXfile);   AccessRec.UserID:=space(szpassID);
    blockwrite(f,AccessRec,sizeof(AccessRec));
   end;

   if lockingData then
   begin
    if (uppercase(trim(AccessRec.UserID))>'') then
     begin
      msg:='The User '+AccessRec.UserID
       +' is already altering the data for this part of Time Chart Extra.'+endline;
      try
       msg:=msg+'    ('+FormatDateTime('h:n:sam/pm "on" dddd"," mmmm d',AccessRec.Date)+')'+endline;
      except

      end;

      msg:=msg+'No changes can be made to this data until this user has finished.';
      messagedlg(msg,mtInformation,[mbOK],0);
      okTOpass:=false;
     end
     else {claim it}
      begin
       if found>0 then
       begin
        AccessRec.UserID:=usrPassID;
        AccessRec.Date:=now;
        seek(f,longint(found)*(szTCEWP51rec));
        blockwrite(f,AccessRec,sizeof(AccessRec));
        okTOpass:=true;
       end;
      end;
   end
   else {releasing claim}
   begin
    AccessRec.UserID:=space(szPassID);
    seek(f,longint(found)*(szTCEWP51rec));
    blockwrite(f,AccessRec,sizeof(AccessRec));
    okTOpass:=true;
   end;
  finally
   closefile(f);
  end;
 except

 end;
 {$I+}
 result:=okTOpass;
end;

function CheckAccessRights(accessLevelNeeded,
                           dataSection: smallint; {index into access file tcp1}
                           lockingData: bool     {true to try and lock else release}
                           ):bool;
var
 okTOpass: bool;
begin
 okTOpass:=false;
 case usrPassLevel of
  0: if accessLevelNeeded>0 then okTOpass:=false;
  4: if accessLevelNeeded<>6 then okTOpass:=true;
  6: okTOpass:=true;
 end; {case}
 if not(okTOpass) then
 begin
  showRestrictedMsg;
  result:=false;
  exit;
 end;

 if lockingData then HaveDataLock:=true;
 if ((dataSection=5) or (dataSection=6)) then  {time slot code & order saved with weights }
  begin                                          {in coverset.dat}
   okTOpass:=CheckPriorAccess(5,lockingData);
   if okTOpass then okTOpass:=CheckPriorAccess(6,lockingData);
  end
 else
  begin
   if dataSection=9 then
     begin
      if uppercase(trim(exfile))='EXTRAS' then
        okTOpass:=CheckPriorAccess(dataSection,lockingData)
      else  {check additional tt's}
        okTOpass:=CheckEXAccess(dataSection,lockingData);
     end
    else
     okTOpass:=CheckPriorAccess(dataSection,lockingData);
  end;
  if not(lockingData) then HaveDataLock:=false;

 {ensure data current on entry}
 if lockingData then CheckForMouldyData;
 result:=okTOpass;
end;

procedure AccessFileMaintenance(fname: string);
var
 i: integer;
 accesscount:   smallint;
begin
 if (usrPasslevel=0) then exit;
 fillchar(AccessRec,sizeof(AccessRec),chr(0));
 UserAccessfile:='TCEWP51.DAT';
 chdir(Directories.DataDir);
 if not(fileexists(UserAccessfile)) then exit;
 try
  try
   if openAccessFile<>0 then exit;
   blockread(faccess,accesscount,2);  IntRange(accesscount,50,32000);
   if accesscount>9 then
    for i:=10 to accesscount do
     begin
      seek(faccess,i*sztcewp51rec);
      blockread(faccess,AccessRec,sizeof(AccessRec));
      if (uppercase(trim(AccessRec.exname))=uppercase(trim(fname))) then
       begin
        AccessRec.exname:=space(80);
        seek(faccess,i*sztcewp51rec);
        blockwrite(faccess,AccessRec,sizeof(AccessRec));
       end;
     end; {for i}
  finally
   closefile(faccess);
  end;
 except

 end;

end;

procedure removeDormantLocks;
var
 i,accesscount: smallint;
 tmpDate:       tDateTime;
begin
 if (usrPasslevel=0) then exit;
 fillchar(AccessRec,sizeof(AccessRec),chr(0));
 UserAccessfile:='TCEWP51.DAT';
 chdir(Directories.DataDir);
 if not(fileexists(UserAccessfile)) then exit;
 try
  try
   if openAccessFile<>0 then exit;
   blockread(faccess,accesscount,2); tmpdate:=now;
    IntRange(accesscount,50,32000); {must be atleast 50 if exists}
   for i:=1 to accesscount do
   begin
    seek(faccess,i*(sztcewp51rec));
    blockread(faccess,AccessRec,sizeof(AccessRec));
    if ((uppercase(trim(AccessRec.UserID))=uppercase(trim(usrPassID)))
     or (double(tmpdate)-double(AccessRec.Date)>7)) then
    begin   {clear if own lock found or if lock older than 7 days}
     AccessRec.UserID:=space(szPassID);
     seek(faccess,i*(sztcewp51rec));
     blockwrite(faccess,AccessRec,sizeof(AccessRec));
    end;
   end;   {for i}
  finally
   closefile(faccess);
  end;
 except

 end;
end;

procedure CheckAccessFile;
var
 f:               file;
 i:               smallint;
begin
 if (usrPassLevel=0) then exit;
 fillchar(AccessRec,sizeof(AccessRec),chr(0));
 chdir(Directories.DataDir);
 if not(fileexists('TCEWP51.DAT')) then
 begin       {not there - create it}
  try
   try
    doAssignFile(f,'TCEWP51.DAT');
    filemode:=fmOpenReadWrite+fmShareDenyNone;
    rewrite(f,1);
    AccessRec.date:=0; AccessRec.time:='tttttttt'; AccessRec.userid:='        ';
    AccessRec.exname:=space(80); AccessRec.reserved:='xxxx';
    for i:=0 to 50 do
    begin
     seek(f,i*(sztcewp51rec));
     blockwrite(f,AccessRec,sizeof(AccessRec));
    end;

    seek(f,0);  i:=50;
    blockwrite(f,i,2);
   finally
    closefile(f);
   end;
  except

  end;
 end
 else {exists}
  begin   {clear dormant locks}
   removeDormantLocks;
  end;
end;


procedure checkCount;
var
 Jc:      smallint;
begin
 for Jc:=0 to 10 do passCount[Jc]:=0;
 if UserRecordsCount=0 then exit;
 for Jc:=1 to UserRecordsCount do
  inc(passCount[passLevel[Jc]]);
end;


procedure NETreadINT(var f: file; var a: smallint);
var
 tries: smallint;
begin
{$I-}
 try
  blockread(f,a,2);
  tries:=0;
  while (not(eof(f)) and (ioresult<>0) and (tries<szIdleRetries)) do
  begin
   idle(szIdleDelay);
   blockread(f,a,2);
   inc(tries);
  end;
 except

 end;
{$I+}
end;


procedure NETwriteINT(var f: file; var a: smallint);
var
 tries: smallint;
begin
 if (usrPasslevel=0) then exit;
{$I-}
 blockwrite(f,a,2);
 tries:=0;
 while ((ioresult<>0) and (tries<szIdleRetries)) do
 begin
  idle(szIdleDelay);
  blockwrite(f,a,2);
  inc(tries);
 end;
{$I+}
end;

procedure NETreadstring(var f: file; var astr: shortstring; alen: smallint);
var
 tries: smallint;
begin
{$I-}
 try
  setlength(astr,alen);
  blockread(f,astr[1],alen);
  tries:=0;
  while (not(eof(f)) and (ioresult<>0) and (tries<szIdleRetries)) do
  begin
   idle(szIdleDelay);
   blockread(f,astr[1],alen);
   inc(tries);
  end;
 except

 end;
 setlength(astr,alen);
{$I+}
end;

procedure NETwritestring(var f: file; var astr: shortstring; alen: smallint);
var
 tries: smallint;
begin
 if (usrPasslevel=0) then exit;
{$I-}
 blockwrite(f,astr[1],alen);
 tries:=0;
 while ((ioresult<>0) and (tries<szIdleRetries)) do
 begin
  idle(szIdleDelay);
  blockwrite(f,astr[1],alen);
  inc(tries);
 end;
 setlength(astr,alen);
{$I+}
end;

procedure idle(s: longint); {pause for s milliseconds}
var
 f,f2,f3,f4:       real;
const
 ff:double=24*60*60*1000;
begin
 f:=time; f3:=f*ff;
 f2:=f; f4:=f2*ff;
 while s>(f4-f3) do
 begin
  f2:=time; f4:=f2*ff;
 end;
end;

function myDelay(ms: DWORD):DWORD;
var _start: DWORD;
begin
   _start:= getTickCount;
   while abs(getTickCount-_start) < ms do begin
      Application.ProcessMessages;
      if application.Terminated then
        exit;
   end;
end;



function FNencryptDIR(astr:shortstring):shortstring;
var
 j1,len: smallint;
 b1,b2,b3: byte;
 bstr,es: shortstring;
begin
 es:='';
 len:=length(astr);
 for j1:=1 to len do
 begin
  bstr:=copy(astr,j1,1); b1:=ord(bstr[1]);
  bstr:=copy(encryptStrDIR,j1,1); b2:=ord(bstr[1]);
  b3:=b1 xor b2; bstr:=chr(b3);
  es:=es+bstr;
 end;
 result:=es;
end;

function FNencrypt(astr:shortstring):shortstring;
var
 j1,len: smallint;
 b1,b2,b3: byte;
 bstr,es: shortstring;
begin
 es:='';
 len:=length(astr);
 for j1:=1 to len do
 begin
  bstr:=copy(astr,j1,1); b1:=ord(bstr[1]);
  bstr:=copy(encryptStr,j1,1); b2:=ord(bstr[1]);
  b3:=b1 xor b2; bstr:=chr(b3);
  es:=es+bstr;
 end;
 result:=es;
end;


procedure newPassword;
begin
 getSuperPasswordDlg:=TgetSuperPasswordDlg.create(application);   {allocate dlg}
 getSuperPasswordDlg.showmodal;
 getSuperPasswordDlg.free;               {release dlg}
end;


procedure getPassword;
begin
 LoggingonDlg:=TLoggingonDlg.create(application);   {allocate dlg}
 LoggingonDlg.showmodal;
 LoggingonDlg.free;               {release dlg}
end;

procedure showPassLevel;
var
 msg: shortstring;
begin
  msg:='Access level: '+accessType[usrPasslevel];
  if usrPasslevel>0 then
  begin
   msg:=msg+endline;
   msg:=msg+'User ID: '+usrPassID;
  end;

  messagedlg(msg,mtInformation,[mbOK],181);
  exit;
end;


function SaveUsers: Boolean;

begin
  if (usrPassLevel=0) then Exit;
  ChDir(Directories.progdir);
  XML_USERS.saveUserPasswords_xml(Directories.progdir);
end;



procedure loadUsers;
var
 f:               file;
 a,i:             smallint;
 astr,bstr,cstr,dstr:       shortstring;
begin
 try
   chdir(Directories.progdir);
   if (fileexists(OldExtrasUserPasswordFilename)) then
   try
       doAssignFile(f,OldExtrasUserPasswordFilename);
       filemode:=fmOpenRead+fmShareDenyNone;
       reset(f,1);
       NETreadINT(f,UserRecordsCount);
        IntRange(UserRecordsCount,1,nmbrUsers);
       NETreadINT(f,MouldyDataCheckTime);
        IntRange(MouldyDataCheckTime,1,600);

       if UserRecordsCount>0 then
        for i:=1 to UserRecordsCount do
        begin
         seek(f,sztcewp52rec*longint(i));
         NETreadINT(f,a);
          IntRange(a,1,6);
         NETreadINT(f,passyear[i]);

         NETreadstring(f,astr,szPassword);
         NETreadstring(f,bstr,szPassID);
         NETreadstring(f,cstr,szUserDirName);
         NETreadstring(f,dstr,1);
         passlevel[i]:=a;
         passWord[i]:=trim(FNencrypt(astr));
         passID[i]:=trim(FNencrypt(bstr));
         passUserDir[i]:=trim(FNencryptDIR(cstr));
         // !!! passBKUP[i]:=dstr;
        end;
   finally
       closefile(f);
       XML_USERS.saveUserPasswords_xml(Directories.progdir);
       deletefile(OldExtrasUserPasswordFilename);
   end;
   XML_USERS.getUserPasswords_xml(Directories.progdir);
 except

 end;
end;

procedure checkpassword;
var _passwordFileExists: boolean;
begin
 if not(loadFinished) then {init on load only, later for log on as diff - stay same if cancel}
 begin   {general mode during load if cancel}
  usrPasslevel:=0; usrPassyear:=0; usrPassuse:=0;
  usrPasstime:=timetostr(time); usrPassdate:=datetostr(date);
  usrPassDir:=Directories.progdir;
 end;
 chdir(Directories.progdir);
 loadUsers;
 _passwordFileExists :=  fileexists(OldExtrasUserPasswordFilename);
 if not _passwordFileExists  then
    _passwordFileExists :=  fileexists(XML_USERS.DataFile);
 if _passwordFileExists then
    getPassword
 else
    newPassword;

 if (usrPasslevel>0) then loadUsers; {need it for duplicate checks also}
 if usrPasslevel<>6 then
  if wnFlag[wnShowUsers] then
  begin
   ShowUsersWin.close;    {hide it if no longer the super}
   ShowUsersWin.free;    {without this explicict statement, it stays and tries repaints}
  end;
 //showPassLevel;
end;



end.

