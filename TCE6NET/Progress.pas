unit Progress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IdMessage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,TCEglobals,
  IdExplicitTLSClientServerBase, IdSMTPBase, ppParameter, ppBands, ppStrtch,
  ppMemo, ppCtrls, ppVar, ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppDB,
  ppComm, ppRelatv, ppDBJIT, Contnrs, IdSASLPlain, IdSASL, IdSASLUserPass,
  IdSASLLogin, IdUserPassProvider, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdAttachmentFile, Tcommon5, XML.UTILS, GlobalToTcAndTcextra;

type
  TTeacherCovers = class;
  TProgressForm = class(TForm)
    UpdateDone: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    pipCover: TppJITPipeline;
    ppJITChangesDetails: TppField;
    repCover: TppReport;
    ppHeaderBand1: TppHeaderBand;
    lblSchoolName: TppLabel;
    lblTitle: TppLabel;
    imgSchoolLogo: TppImage;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLine5: TppLine;
    ppSystemVariable2: TppSystemVariable;
    ppParameterList1: TppParameterList;
    memStudentDetails: TppDBMemo;
    pipCoverppTeacherName: TppField;
    txtTeacherName: TppDBText;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    pipCoverppDayOfChanges: TppField;
    txtDayOfChanges: TppDBText;
    ppLine1: TppLine;
    ppDBMemo1: TppDBMemo;
    pipCoverppCustomAddOn: TppField;
    repAbsentTeacher: TppReport;
    ppHeaderBand2: TppHeaderBand;
    lblSchoolNameAbsentTe: TppLabel;
    lblTitleAbsentTe: TppLabel;
    ppImage1: TppImage;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppLine2: TppLine;
    ppDetailBand2: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    ppLine3: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppDBMemo3: TppDBMemo;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppParameterList2: TppParameterList;
    pipAbsentTeacher: TppJITPipeline;
    ppField2: TppField;
    ppField3: TppField;
    ppField4: TppField;
    pipAbsentTeacherppTimeSlot: TppField;
    pipAbsentTeacherppSubject: TppField;
    pipAbsentTeacherppYearName: TppField;
    pipAbsentTeacherppClass: TppField;
    pipAbsentTeacherppRoom: TppField;
    pipAbsentTeacherppNewTe: TppField;
    pipAbsentTeacherStatus: TppField;
    pipAbsentTeacherppNote: TppField;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLine4: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    memFooter: TppDBMemo;
    pipAbsentTeacherppMisc: TppField;
    ppLine8: TppLine;
    IdSASLLogin1: TIdSASLLogin;
    IdSASLPlain1: TIdSASLPlain;
    IdUserPassProvider1: TIdUserPassProvider;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function PopulateFieldData(aFieldName: string): Variant;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function PopulateFieldAbsentTe(aFieldName: string): Variant;
  private
    NewMessage : TidMessage;
    emailDate: string;
    mailtag:   array of bool;
    spamAvoidingDelayBetweenMessages: integer;
    FTeacherCovers: TTeacherCovers;
    procedure newline;
    procedure ClearMailTag;
    function ShowStudent(st: integer):string;
    function GetCustomAddon: string;
    procedure EmailSubjectList(su,myset:integer);
    procedure EmailConnect;
    procedure EmailOneCover(te: integer);
    procedure EmailOneAddedStaff(te: integer);
    procedure EmailOneAbsent(te: integer);
    procedure SelectedEmails;
    procedure AllEmails;
    function GetFieldValue(pRecIndex: Integer; const pFieldName: string): Variant;
    function GetFieldAbsentTe(pRecIndex: Integer; const pFieldName: string): Variant;
    function CreateOneCoverPDF(const pTeNo: Integer): Boolean;
    function CreateOneAbsentPDF(const pTeNo: Integer): Boolean;
    function CreateOneAddedStaffPDF(const pTeNo: Integer): Boolean;
    function GetSubjectList(const pSub, pMySet: Integer): string;
  public
    myview,myselect,num2,myfac: integer;
    ListItems:   array of integer;
    function GeneratePDFCover(const showMessage: Boolean = true): Boolean;
  end;

  TTeacherCover = class
  private
    FTeacherName: string;
    FTeacherCode: string;
    FTeacherNo: Integer;
    FDayOfChanges: string;
    FChangesDetails: string;
    FCustomAddOn: string;
    FYearName: string;
    FRoom: string;
    FRollClass: string;
    FSubject: string;
    FNewTeacher: string;
    FTimeSlot: string;
    FNote: string;
    FStatus: string;
    FMisc: string;
  public
    property TeacherNo: Integer read FTeacherNo write FTeacherNo;
    property TeacherCode: string read FTeacherCode write FTeacherCode;
    property TeacherName: string read FTeacherName write FTeacherName;
    property DayOfChanges: string read FDayOfChanges write FDayOfChanges;
    property ChangesDetails: string read FChangesDetails write FChangesDetails;
    property CustomAddOn: string read FCustomAddOn write FCustomAddOn;
    property TimeSlot: string read FTimeSlot write FTimeSlot;
    property Subject: string read FSubject write FSubject;
    property YearName: string read FYearName write FYearName;
    property RollClass: string read FRollClass write FRollClass;
    property Room: string read FRoom write FRoom;
    property NewTeacher: string read FNewTeacher write FNewTeacher;
    property Status: string read FStatus write FStatus;
    property Note: string read FNote write FNote;
    property Misc: string read FMisc write FMisc;
  end;

  TTeacherCovers = class(TobjectList)

  end;

var
  ProgressForm: TProgressForm;
  televel,teyear,teroom,tesub: integer;

implementation

uses
  Main, tcommon, tcommon2, tcommon3,IdSASL_NTLM;

{$R *.dfm}

var
 connected,emailsent: boolean;
const
 divider='------------------------------------';

function StripName(const pText: string): string;
  begin
    Result := StringReplace(StringReplace(pText, ' ', '', [rfReplaceAll, rfIgnoreCase]), ',', '', [rfReplaceAll, rfIgnoreCase]);
  end;

procedure TProgressForm.newline;
begin
  if Assigned(NewMessage) then
    NewMessage.Body.Add('');
end;

procedure TProgressForm.ClearMailTag;
var
 i: integer;
begin
 for i:=1 to nmbrteachers do mailtag[i]:=false;
end;

function TProgressForm.ShowStudent(st: integer):string;
var
 s: string;
begin
 s := Trim(Stud[st].stname) + ' ' + Trim(Stud[st].first) + ht + '  ';
 if sTyear then s:=s+ht+yearname[Stud[st].TcYear];
 if stSex then s:=s+ht+Stud[st].Sex;
 if stID then s:=s+ht+Stud[st].ID;
 if stClass then s:=s+ht+ClassCode[Stud[st].Tcclass];
 if stHouse then s:=s+ht+HouseName[Stud[st].house];
 if stTutor then s:=s+ht+Tecode[Stud[st].tutor,0];
 if stHome then s:=s+ht+Tecode[Stud[st].home,1];
 result:=s;
end;

procedure TProgressForm.EmailSubjectList(su,myset:integer);
var
 st,stcount: integer;
 s: string;
begin
 newline;
 stcount:=0;
 if Changes[myset].sub>0 then
  begin
   GetShares(myset);
   s:='Student List for '+SubCode[su]+' '+SubName[su];
   if SubShareFlag then s:=s+' / '+SubCode[ShareSub]+' '+subname[ShareSub]+ '(share)';
   NewMessage.Body.Add(s);
   for st:=1 to GroupNum do
    if IncludeStud(st,myset) then
     begin
      NewMessage.Body.Add(ShowStudent(StPointer[st]));
      inc(stcount);
     end;
   NewMessage.Body.Add('Students: '+inttostr(stcount));
  end
 else if ((Changes[myset].level>0) and (Changes[myset].gen=2)) then
  begin
   NewMessage.Body.Add('Student List for '+ClassCode[Changes[myset].level]);
   for st:=1 to GroupNum do
    if Stud[StPointer[st]].Tcclass=Changes[myset].level then
     begin
      NewMessage.Body.Add(ShowStudent(StPointer[st]));
      inc(stcount);
     end;
   NewMessage.Body.Add('Students: '+inttostr(stcount));
  end;
  newline;
end;

function TProgressForm.GetCustomAddon: string;
var
  i: Integer;
  lStrList: TStringList;
begin
  Result := '';
  lStrList := TStringList.Create;
  try
    parseCustomInfo;
    if CustomCnt = 0 then exit;
    newline;
    for i:=1 to CustomCnt do
    begin
      if Assigned(NewMessage) then
      begin
        NewMessage.Body.Add(CustomArr[i]);
        newline;
      end;
      lStrList.Add(CustomArr[i]);
    end;
  finally
    Result := lStrList.Text;
    FreeAndNil(lStrList);
  end;
end;

procedure TProgressForm.EmailConnect;
var
   system_datetime: TSystemTime;
   NTLM: TIdSASLNTLM;
   NTLM_Level: integer;
begin
  if not(EmailPlainSMTP) then
  begin
   // #991 - Configure the authentication methods
   ShowMEssage('  TProgressForm.EmailConnect');
   IdSMTP1.SASLMechanisms.Clear;
   NTLM := TIdSASLNTLM.Create(IdSMTP1);
   NTLM.UserPassProvider := IdUserPassProvider1;
   IdSMTP1.SASLMechanisms.Add.SASL := NTLM;
   IdSMTP1.SASLMechanisms.Add.SASL := IdSASLLogin1;
   IdSMTP1.SASLMechanisms.Add.SASL := IdSASLPlain1;
  end else begin
    IdSMTP1.AuthType := satDefault;
    IdSMTP1.IOHandler := nil;
  end;

 NewMessage := TidMessage.Create(nil);
 NewMessage.BccList.Clear;
 NewMessage.From.Name:=EmailDisplayName;
 NewMessage.From.Address:=EmailSend;
 NewMessage.Organization:=School;

 // There is a bug with IdMessage component to do with UTC time
 // This should set the correct send date/time
   GetSystemTime(system_datetime);
 NewMessage.Date := SystemTimeToDateTime(system_datetime);

 emailDate:=' for '+dayname[ttday]+' '+inttostr(exday)+' '+month[exmonth];
 NewMessage.Subject:='Changes'+emailDate;
 if not idSMTP1.Connected then
  begin
  // #1 We want to allow SMTP connection without User/Pwd
//   if (EmailHost='') or (EmailUserId='') or (EmailPassword='')
   if (EmailHost='')
    then MainForm.EmailSetup1Click(MainForm);
//   if (EmailHost>'') and (EmailUserId>'') and (EmailPassword>'') then
   if (EmailHost>'')  then
    begin
     IdSMTP1.Host := EmailHost;
     IdSMTP1.Port := EmailPort;
     IdSMTP1.Username:=EmailUserId;
     IdSMTP1.Password :=EmailPassword;

     if not(EmailPlainSMTP) then
     begin
      // #991
           NTLM.Domain := IdSMTP1.Username;
           //try
           //  NTLM_Level := StrToInt(IdSMTP1.Password);
           //except
           //  NTLM_Level := 0;
           //end;
           //NTLM.LMCompatibility := NTLM_Level;
           IdUserPassProvider1.Username := IdSMTP1.Username;
           IdUserPassProvider1.Password := IdSMTP1.Password;
     end;

     IdSMTP1.Connect;   //ToDo
// #991 - SMTP not authenticating
     if EmailUserId <> '' then
     begin
       IdSMTP1.Authenticate;
     end;
    end;
  end;
 connected:=idSMTP1.Connected;
end;

procedure TProgressForm.EmailOneCover(te:integer);
var
 count,p,i,su: integer;
 s,s1: string;
 attachment: string;
begin
 NewMessage.Recipients.Clear;
 count:=0;
 NewMessage.Recipients.Add.Text := Temail[te];
 NewMessage.Body.Clear;
 NewMessage.Body.Add('To '+tename[te,0]);
 NewMessage.Body.Add('Changes'+emailDate);
 newline;
 for p:=1 to tlimit[ttday] do
  for i:=1 to numchanges do
   begin
    if (Changes[i].timeslot<>p) or (Changes[i].newte<>te) then continue;
    if (Changes[i].kind=1) then continue;
    inc(count); su:=Changes[i].sub;
    s:='Time: '+TimeSlotName[ttday,p-1]+ht+'Subject: '+SubCode[su];
    s:=s+ht+yeartitle+' '+yearname[Changes[i].year];
    s1:=trim(ClassCode[ClassShown[Changes[i].level,Changes[i].year]]);
    if s1>'' then s:=s+ht+'Class: '+s1;
    NewMessage.Body.Add(s);
    s:='Room: '+tecode[Changes[i].newroom,1];
    NewMessage.Body.Add(s);
    s:='Change: '+GenType3(i);
    if printkind(i)>'' then s:=s+ht+'Status: '+printkind(i);
    NewMessage.Body.Add(s);
    s:=GetStatusNote(i);
    if s>'' then NewMessage.Body.Add('Note: '+s);
    if (su>0) and eplist and (GroupSubCount[GsubXref[su]]>0)
      then EmailSubjectList(su,i);{student list}
    newline; NewMessage.Body.Add(divider); newline;
   end; {for i}
   GetCustomAddOn;
 if count=1 then s:=' Change' else s:=' Changes';
 NewMessage.Body[1]:=inttostr(count)+s+emailDate;
 idSMTP1.Send(NewMessage);
 ProgressForm.Label2.Caption:=tename[te,0];
 ProgressForm.Update;
 myDelay(spamAvoidingDelayBetweenMessages);
end;

procedure TProgressForm.EmailOneAddedStaff(te:integer);
var
 count,p,i,su: integer;
 s,s1: string;
begin
  NewMessage.Recipients.Clear;
  count:=0;
  NewMessage.Recipients.Add.Text := ETmail[te];
  NewMessage.Body.Clear;
  NewMessage.Body.Add('To '+ETname[te]);
  NewMessage.Body.Add('Changes'+emailDate);
  newline;
  for p:=1 to tlimit[ttday] do
   for i:=1 to numchanges do
   begin
    if (Changes[i].timeslot<>p) or (Changes[i].newte<>te) then continue;
    if (Changes[i].kind<>1) then continue;
    inc(count); su:=Changes[i].sub;
    s:='Time: '+TimeSlotName[ttday,p-1]+ht+'Subject: '+SubCode[su];
    s:=s+ht+yeartitle+' '+yearname[Changes[i].year];
    s1:=trim(ClassCode[ClassShown[Changes[i].level,Changes[i].year]]);
    if s1>'' then s:=s+ht+'Class: '+s1;
    NewMessage.Body.Add(s);
    s:='Room: '+tecode[Changes[i].newroom,1];
    NewMessage.Body.Add(s);
    s:='Change: '+GenType3(i);
    if printkind(i)>'' then s:=s+ht+'Status: '+printkind(i);
    NewMessage.Body.Add(s);
    s:=GetStatusNote(i);
    if s>'' then NewMessage.Body.Add('Note: '+s);
    if (su>0) and eplist and (GroupSubCount[GsubXref[su]]>0)
      then EmailSubjectList(su,i);{student list}

    GetCustomAddOn;
    newline; NewMessage.Body.Add(divider); newline;
   end; {for i}
  if count=1 then s:=' Change' else s:=' Changes';
  NewMessage.Body[1]:=inttostr(count)+s+emailDate;
  idSMTP1.Send(NewMessage);
  ProgressForm.Label2.Caption:=ETname[te];
  ProgressForm.Update;
  myDelay(spamAvoidingDelayBetweenMessages);
end;

procedure TProgressForm.EmailOneAbsent(te:integer);
var
 count,p,i: integer;
 s,tmpstr1,tmpstr2:string;
 tallot,tcovallot: double;
 found,tlost: boolean;

begin
  NewMessage.Recipients.Clear;
  NewMessage.Recipients.Add.Text := Temail[te];
  NewMessage.Body.Clear;
  s:='Absent teacher: '+tename[te,0]+emailDate;
  NewMessage.Body.Add(s);
  if EPreason then
   begin
    s:='Reason: '+Abcode[tabsreason[te]]+' '+Absent[tabsreason[te]];
    NewMessage.Body.Add(s);
   end;
  newline; newline;
  s:='Time'+ht+'Subject'+ht+yeartitle+ht+'Class'+ht+'Room'+ht+'New Teacher'
      +ht+'Status'+ht+'Note';
  NewMessage.Body.Add(s);
  count:=0; tallot:=0;
  tcovallot:=0;
  for p:=1 to tlimit[ttday] do
  begin
   if bool(teAbsent[te] and (1 shl p)) then continue;
   s:=TimeSlotName[ttday,p-1]; found:=false; inc(count);
   for i:=1 to numchanges do
   begin
    if (Changes[i].gen=4) or (Changes[i].timeslot<>p) or (Changes[i].oldte<>te) then continue;
    found:=true;
    s:=TimeSlotName[ttday,p-1]+ht+SubCode[Changes[i].sub]+ht+yearname[Changes[i].year]
     +ht+ClassCode[ClassShown[Changes[i].level,Changes[i].year]]
     +ht+tecode[Changes[i].newroom,1];
    if Changes[i].kind=1 then s:=s+ht+ETname[Changes[i].newte]
     else s:=s+ht+tename[Changes[i].newte,0];
    if (Changes[i].kind>9) then s:=s+ht+IgnoreStatusMsg
     else
      begin
       s:=s+ht+printkind(i)+ht+GetStatusNote(i);
      end;
    NewMessage.Body.Add(s); s:='';
    tallot:=tallot+getEallot(2,te,ttday,p);
    tcovallot:=tcovallot+getEallot(2,te,ttday,p);
   end; {for i}
   tlost:=false; if (telost[te] and (1 shl p))=0 then tlost:=true;
   if not(found) and tlost then
      NewMessage.Body.Add(s+ht+'Lost Class');
   if not(found) and (tlost=false) then NewMessage.Body.Add(s+ht+'Free');
  end; {for p}
  str(tallot:5:2,tmpstr1); str(tcovallot:5:2,tmpstr2);
  NewMessage.Body.Add('Absent times this day: '+inttostr(count)
   +ht+' Alloted: '+tmpstr1);
  newline; GetCustomAddOn;
  idSMTP1.Send(NewMessage);
  ProgressForm.Label2.Caption:=tename[te,0];
  ProgressForm.Update;
  myDelay(spamAvoidingDelayBetweenMessages);
end;

procedure TProgressForm.SelectedEmails;
var
 i,j,te,num,count: integer;
 free2:   array[0..nmbrteachers] of integer;
begin
 screen.cursor:=crHourglass;
 ClearMailTag;
 num:=0; count:=0;
 MySelect := 2; //ToDo Assign later in a GUI
 if myselect=2 then
   begin {user selection}
    num:=num2;
    if num>0 then for i:=1 to num do free2[i]:=listItems[i];
   end
  else
   case myview of {all teachers}
    2: begin   {absent teachers}
        for j:=1 to codenum[1] do
         begin
          te:=codepoint[j,1];
          if TeAbsent[te]<>-1 then if (myselect=1) or TeachInAnyFac(te,myfac)
              then begin inc(num); free2[num]:=te; end;
         end; {for j}
       end;   {absent teachers}{absent}
    3: begin {cover}
        for i:=1 to numchanges do
         begin
          if (Changes[i].kind>9) and (not(IgnoreStatusMsgFlag)) then continue;
          if (Changes[i].kind=1) then continue;
          mailtag[Changes[i].newte]:=true
         end;
        for j:=1 to codenum[1] do
         begin
          te:=codepoint[j,1];
          if mailtag[te] then if (myselect=1) or TeachInAnyFac(te,myfac)
              then begin inc(num); free2[num]:=te; end;
         end; {for j}
       end; {cover}
    4: begin   {added staff}
        for i:=1 to numchanges do
         begin
          if (Changes[i].kind>9) and (not(IgnoreStatusMsgFlag)) then continue;
          if (Changes[i].kind<>1) then continue;
          mailtag[Changes[i].newte]:=true;
         end;
        for j:=1 to etnum1 do
         begin
          te:=Etpointer[j];
          if mailtag[te] then
            if (myselect=1) or(ETfaculty[te]=-1) or (ETfaculty[te]=myfac)
              then begin inc(num); free2[num]:=te; end;
         end; {for j}
       end; {added staff}
   end; {case}
  if (num>0) then for i:=1 to num do
   begin
    te:=free2[i];
    case myview of
     2: if (teAbsent[te]<>-1) and (Temail[te]>'') then
         begin EmailOneAbsent(te); inc(count); end;
     3: if (Temail[te]>'') then
         begin EmailOneCover(te); inc(count); end;
     4: if (ETmail[te]>'') then
         begin EmailOneAddedStaff(te); inc(count); end;
    end;
   end; {for i}
  case myview of
     2: begin
          Label7.Visible:=true;
          Label8.Caption:=inttostr(count);
        end;
     3: begin
         Label3.Visible:=true;
         Label4.Caption:=inttostr(count);
        end;
     4: begin
         Label5.Visible:=true;
         Label6.Caption:=inttostr(count);
        end;
  end;
  screen.cursor:=crDefault;
end;

procedure TProgressForm.AllEmails;
var
 i,j,te,count: integer;
begin
  screen.cursor:=crHourglass;
  if EmailCoverFlag then
   begin
    ClearMailTag; count:=0;
    for i:=1 to numchanges do
     begin
      if (Changes[i].kind>9) and (not(IgnoreStatusMsgFlag)) then continue;
      if (Changes[i].kind=1) then continue;
      mailtag[Changes[i].newte]:=true
     end;
    for j:=1 to codenum[1] do
     begin
      te:=codepoint[j,1];
      if mailtag[te] and (Temail[te]>'') then
       begin EmailOneCover(te); inc(count); end;
     end; {for j}
    Label3.Visible:=true;
    Label4.Caption:=inttostr(count);
   end; {EmailCoverFlag}

  if EmailAddedFlag then
   begin
    ClearMailTag; count:=0;
    for i:=1 to numchanges do
     begin
      if (Changes[i].kind>9) and (not(IgnoreStatusMsgFlag)) then continue;
      if (Changes[i].kind<>1) then continue;
      mailtag[Changes[i].newte]:=true;
     end;
    for j:=1 to etnum1 do
     begin
      te:=Etpointer[j];
      if mailtag[te] and (ETmail[te]>'') then
       begin EmailOneAddedStaff(te); inc(count); end;
     end; {for j}
    Label5.Visible:=true;
    Label6.Caption:=inttostr(count);
   end; {EmailAddedFlag}

  if EmailAbsentFlag then
   begin
    count:=0;
    for j:=1 to codenum[1] do
     begin
      te:=codepoint[j,1];
      if (teAbsent[te]<>-1) and (Temail[te]>'') then
       begin EmailOneAbsent(te); inc(count); end;
     end; {for j}
    Label7.Visible:=true;
    Label8.Caption:=inttostr(count);
   end;   {EmailAbsentFlag}
  screen.cursor:=crDefault;

//   s:='file to save goes here';
//   TIdAttachment.create(NewMessage.MessageParts,s);
//
// if idSMTP1.Connected then idSMTP1.Disconnect;
end;

procedure TProgressForm.FormCreate(Sender: TObject);
begin
  FTeacherCovers := TTeacherCovers.Create;
  spamAvoidingDelayBetweenMessages := 100;
  if MessageDlg('Adding a short delay (30 seconds) between each email helps to avoid these messages being treated as spam.'
                + Cr + 'OK to add this delay between messages?', mtConfirmation, [mbYes,mbNo], 0) <> mrYes then
    Exit;
  spamAvoidingDelayBetweenMessages := 30000;
  
end;

procedure TProgressForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FTeacherCovers) then
    FreeAndNil(FTeacherCovers);
end;

procedure TProgressForm.FormShow(Sender: TObject);
begin
  SetLength(mailtag,nmbrteachers+1);
  SetLength(ListItems,nmbrteachers+1);
  emailsent:=false;
  EmailConnect;
  if not connected then
  begin
    Label1.Caption:='  No email';
    Label2.Caption:='connection!';
  end;
end;

procedure TProgressForm.FormActivate(Sender: TObject);
begin
 //if emailsent or not(connected) then exit;  //ToDo
 update;
 if tag=1 then AllEmails;
 if tag=2 then SelectedEmails;
 emailsent:=true;
end;

procedure TProgressForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  NewMessage.Free;
end;

function TProgressForm.GetFieldAbsentTe(pRecIndex: Integer; const pFieldName: string): Variant;
begin
  if pFieldName = 'fldTeacherName' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FTeacherName
  else if pFieldName = 'fldDayOfChanges' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FDayOfChanges
  else if pFieldName = 'fldTimeSlot' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FTimeSlot
  else if pFieldName = 'fldSubject' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FSubject
  else if pFieldName = 'fldYearName' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FYearName
  else if pFieldName = 'fldClass' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FRollClass
  else if pFieldName = 'fldRoom' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FRoom
  else if pFieldName = 'fldNewTeacher' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FNewTeacher
  else if pFieldName = 'fldStatus' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FStatus
  else if pFieldName = 'fldNote' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FNote
  else if pFieldName = 'fldMisc' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FMisc
  else if pFieldName = 'fldCustomAddOn' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FCustomAddOn;
end;

function TProgressForm.GetFieldValue(pRecIndex: Integer; const pFieldName: string): Variant;
begin
  if pFieldName = 'fldChangesDetails' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FChangesDetails
  else if pFieldName = 'fldTeacherName' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FTeacherName
  else if pFieldName = 'fldDayOfChanges' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FDayOfChanges
  else if pFieldName = 'fldCustomAddOn' then
    Result := TTeacherCover(FTeacherCovers.Items[pRecIndex -1]).FCustomAddOn;
end;

function TProgressForm.GetSubjectList(const pSub, pMySet: Integer): string;
var
  st, StCount: Integer;
  s: string;
  lTempStr: string;
begin
  try
    lTempStr := '';
    StCount := 0;
    if Changes[pMySet].sub > 0 then
    begin
      GetShares(pMySet);
      s := 'Student List for ' + SubCode[pSub] + ' ' + SubName[pSub];
      if SubShareFlag then s := s + ' / ' + SubCode[ShareSub] + ' ' + SubName[ShareSub] + '(share)';
      lTempStr := lTempStr + Lf + Cr + s;
      for st :=1 to GroupNum do
        if IncludeStud(st, pMySet) then
        begin
          lTempStr := lTempStr + Cr + Trim(ShowStudent(StPointer[st]));
          Inc(StCount);
        end;
      lTempStr := lTempStr + Cr + 'Students: ' + IntToStr(StCount);
    end
    else if ((Changes[pMySet].level > 0) and (Changes[pMySet].gen = 2)) then
    begin
      lTempStr := Lf + Cr + 'Student List for ' + ClassCode[Changes[pMySet].level];
      for st := 1 to GroupNum do
        if Stud[StPointer[st]].Tcclass = Changes[pMySet].level then
        begin
          lTempStr := lTempStr + Cr + Trim(ShowStudent(StPointer[st]));
          Inc(StCount);
        end;
      lTempStr := lTempStr + Lf + Cr + 'Students: ' + IntToStr(StCount);
    end;
  finally
    Result := lTempStr;
  end;
end;

function TProgressForm.CreateOneAbsentPDF(const pTeNo: Integer): Boolean;
var
  lCount: Integer;
  p,i: Integer;
  s,tmpstr1, tmpstr2: string;
  tallot,tcovallot: Double;
  found,tlost: Boolean;
  lTeacherCover: TTeacherCover;
  lDayOfChanges: string;
  lCoverCount: Integer;
begin
  //s:='Time'+ht+'Subject'+ht+yeartitle+ht+'Class'+ht+'Room'+ht+'New Teacher' +ht+'Status'+ht+'Note';
  lCount := 0;
  tallot := 0;
  tcovallot := 0;
  lCoverCount := 0;
  for p := 1 to tlimit[ttday] do
  begin
    if Bool(teAbsent[pTeNo] and (1 shl p)) then Continue;
    lDayOfChanges := emailDate + ' ';
    if EPreason then
      lDayOfChanges := lDayOfChanges + 'Reason: ' + Abcode[tabsreason[pTeNo]] + ' ' + Absent[tabsreason[pTeNo]];
    s := TimeSlotName[ttday, p-1];
    found := False;
    Inc(lCount);
    lTeacherCover := TTeacherCover.Create;
    lTeacherCover.FTeacherNo := pTeNo;
    lTeacherCover.FTeacherCode := TeCode[pTeNo, 0];
    lTeacherCover.FTeacherName := TeName[pTeNo, 0];
    lTeacherCover.FTimeSlot := TimeSlotName[ttday, p - 1];
    for i := 1 to NumChanges do
    begin
      if (Changes[i].gen=4) or (Changes[i].timeslot<>p) or (Changes[i].oldte <> pTeNo) then Continue;
      found := True;
      lTeacherCover.FSubject := SubCode[Changes[i].sub];
      lTeacherCover.FYearName := YearName[Changes[i].year];
      lTeacherCover.FRollClass := ClassCode[ClassShown[Changes[i].level,Changes[i].year]];
      lTeacherCover.FRoom := tecode[Changes[i].newroom, 1];
      //s:=tsName[ttday,p-1]+ht+SubCode[Changes[i].sub]+ht+yearname[Changes[i].year] +ht+ClassCode[ClassShown[Changes[i].level,Changes[i].year]] +ht+tecode[Changes[i].newroom,1];
      if Changes[i].kind = 1 then
        //s:=s+ht+ETname[Changes[i].newte]
        lTeacherCover.FNewTeacher := ETname[Changes[i].newte]
      else
        //s:=s+ht+tename[Changes[i].newte,0];
        lTeacherCover.FNewTeacher := TeName[Changes[i].newte, 0];
      if (Changes[i].kind > 9) then
        //s:=s+ht+IgnoreStatusMsg
        lTeacherCover.FStatus := IgnoreStatusMsg
      else
      begin
        //s:=s+ht+printkind(i)+ht+GetStatusNote(i);
        lTeacherCover.FStatus := PrintKind(i);
        lTeacherCover.FNote := GetStatusNote(i);
      end;
      //s:='';
      tallot := tallot + getEallot(2, pTeNo, ttday, p);
      if Copy(TeMap[pTeNo], p, 1) = 'A' then
        Inc(lCoverCount);
      tcovallot := tcovallot + getEallot(2, pTeNo, ttday, p);
      str(tallot:5:2,tmpstr1);
      str(tcovallot:5:2,tmpstr2);
    end; //for
    lTeacherCover.FDayOfChanges := lDayOfChanges;
    tlost := false; if (telost[pTeNo] and (1 shl p))=0 then tlost := True;
    if not(found) and tlost then
      lTeacherCover.FSubject := 'Lost Class';
    if not(found) and (tlost = False) then
      lTeacherCover.FSubject := 'Free';
    lTeacherCover.FMisc := 'Absent times this day: '+inttostr(lCount) + ' Alloted: ' + tmpstr1 + ht + ' Cover: ' + FloatToStr(lCoverCount) +' Alloted: ' + tmpstr2;
    lTeacherCover.CustomAddOn := GetCustomAddOn;
    FTeacherCovers.Add(lTeacherCover);
  end; //for p
  Result := True;
end;

function TProgressForm.CreateOneAddedStaffPDF(const pTeNo: Integer): Boolean;
var
  lCount: Integer;
  p, i, Su: Integer;
  s, s1: string;
  lStr: string;
  lTeacherCover: TTeacherCover;
  lSubject: string;
begin
  lCount := 0;
  for p := 1 to tlimit[ttday] do
    for i:=1 to numchanges do
    begin
      if (Changes[i].timeslot<>p) or (Changes[i].newte <> pTeNo) then Continue;
      if (Changes[i].kind<>1) then Continue;
      Inc(lCount);
      Su := Changes[i].sub;
      lSubject := SubName[Su];
      if lSubject <> '' then
        lSubject := ' (' + lSubject + ')';
      s := 'Time: ' + ht + TimeSlotName[ttday,p-1] + lf + cr + 'Subject: '+ ht + SubCode[su] + lSubject;
      s := s + lf + cr + yeartitle + ' ' + ht + yearname[Changes[i].year];
      s1 := Trim(ClassCode[ClassShown[Changes[i].level, Changes[i].year]]);
      if s1>'' then s := s + ht + 'Class: ' + ht + s1;
      lStr := lStr + s + lf + cr;
      s := 'Room: '+ ht + tecode[Changes[i].newroom,1];
      lStr := lStr + s + lf + cr;
      s := 'Change: ' + GenType3(i);
      if printkind(i)> '' then s := s + lf + cr +'Status: ' + ht + printkind(i);
        lStr := lStr + s;
      s := GetStatusNote(i);
      if s > '' then
        lStr := lStr + lf + cr + 'Note: '+ ht + s;
      if (su>0) and eplist and (GroupSubCount[GsubXref[su]]>0) then
        lStr := lStr + GetSubjectList(su,i);  //student list

      lStr := lStr + cr + divider + lf + cr;
    end; {for i}
  if lCount > 0 then
  begin
    ProgressForm.Label2.Caption := ETname[pTeNo];
    lTeacherCover := TTeacherCover.Create;
    lTeacherCover.FTeacherNo := pTeNo;
    lTeacherCover.FTeacherCode := etsub[pTeNo];
    lTeacherCover.FTeacherName := ETName[pTeNo];
    if lCount = 1 then s:=' Change' else s:=' Changes';
    lTeacherCover.FDayOfChanges := IntToStr(lCount)+ s + ' for ' + emailDate;
    lTeacherCover.FChangesDetails := lStr;
    lTeacherCover.FCustomAddOn := GetCustomAddOn;
    FTeacherCovers.Add(lTeacherCover);
  end;
end;

function TProgressForm.CreateOneCoverPDF(const pTeNo: Integer): Boolean;
const
  MAXCOLS = 4; // max column per row
  SUMMDIV = divider + divider + divider + divider + divider + divider;
  DEFSPACES = 65;
  MINLENGTH = 5;
var
  lCount: Integer;
  p, i, su: Integer;
  s, s1: string;
  lTeacherCover: TTeacherCover;
  lSubject: string;
  lRoom: string;
  tscount: integer;
  ldcount: double;
  x: integer;
  lStr: widestring;

  // summary variables
  lSummary, lSummaryHeader1, lSummaryHeader2: string;
  lSubjectItem, lRoomItem, lTeacherItem, lCountItem: string;
  colCnt: integer;

  procedure InitSummaryVariables;
  begin
    colCnt := 1;
    lSummaryHeader2 := SUMMDIV + cr;
    lSubjectItem := '';
    lRoomItem := '';
    lTeacherItem := '';
  end;

  function AddSpaces(const itemLine, itemStr: string): string;
  var
    lineLength, totalSpaces: integer;
    spaces: string;
  begin
    if colCnt = 1 then
      Result := itemStr
    else
    begin
      totalSpaces := (colCnt - 1) * DEFSPACES;
      lineLength := Length(itemLine);

      if Length(itemStr) <= MINLENGTH then
        totalSpaces := totalSpaces + (MINLENGTH - Length(itemStr) - 1);
      
      while lineLength <= totalSpaces do
      begin
        spaces := spaces + ' ';
        Inc(lineLength);
      end;

      Result := itemLine + spaces + itemStr;
    end;
  end;

  procedure AddSummaryColHeader;
  begin
    if colCnt = 1 then
      lSummaryHeader2 := lSummaryHeader2 + TimeSlotName[ttday, p - 1]
    else
      lSummaryHeader2 := lSummaryHeader2 + ht + ht + ht + ht + TimeSlotName[ttday, p - 1];

    //lSummaryHeader2 := AddSpaces(lSummaryHeader2, tsName[ttday, p - 1]);

    if colCnt = MAXCOLS then
      lSummaryHeader2 := lSummaryHeader2 + cr + SUMMDIV;
  end;

  procedure AddSummaryItem;
  begin
    lSubjectItem := AddSpaces(lSubjectItem, SubCode[su]);
    lRoomItem := AddSpaces(lRoomItem, TeCode[Changes[i].newroom,1]);
    lTeacherItem := AddSpaces(lTeacherItem, GenType3(i));
  end;

  procedure CreateSummary;
  begin
    if (colCnt > MAXCOLS) or (p = tlimit[ttday]) then
    begin
     lSummary := lSummary + cr + lSummaryHeader2;
     lSummary := lSummary + cr + lSubjectItem;
     lSummary := lSummary + cr + lRoomItem;
     lSummary := lSummary + cr + lTeacherItem;

     lSummary := lSummary + cr + cr;
     
     // re-initialise the summary variables
     InitSummaryVariables;
    end
  end;

  procedure AddScheduledItem;
  begin
    // GetTeachTtItem func gets the details of the timeslot the teacher
    // originally is scheduled to teach
    if GetTeachTtItem(tesub,teroom,TeYear,TeLevel,tefindnum,ttday,P-1) then
    begin
      lSubjectItem := AddSpaces(lSubjectItem, SubCode[tesub]);
      lRoomItem := AddSpaces(lRoomItem, tecode[teroom,1]);
    end;
  end;

begin
  InitSummaryVariables;

  lSummaryHeader1 := cr + TeName[pTeNo, 0] + ' - ' + TeCode[pTeNo,0] + cr;
  lCount := 0;

  for p := 1 to tlimit[ttday] do
  begin
    tesub:=0; teroom:=0; teyear:=0; televel:=0;
    tefindnum := pTeNo;
    AddSummaryColHeader;
    AddScheduledItem;
    for i := 1 to numchanges do
    begin
      if (Changes[i].timeslot <> p) or (Changes[i].newte <> pTeNo) then 
        Continue;
      if (Changes[i].kind = 1) then Continue;
      Inc(lCount);
      su := Changes[i].sub;
      if (TimeSlotName[ttday, p - 1] <> '') or (SubCode[su] <> '') then
      begin
        if lStr <> '' then
          lStr := lStr + lf + cr;
        lSubject := SubName[Su];
        if lSubject <> '' then
          lSubject := ' (' + lSubject + ')';
        s := 'Time: ' + ht + TimeSlotName[ttday, p - 1] + lf + cr + 'Subject: ' + ht + SubCode[su] + lSubject;
        s := s + lf + cr + YearTitle + ' ' + ht + yearname[Changes[i].year];
        s1 := Trim(ClassCode[ClassShown[Changes[i].level, Changes[i].year]]);
        if s1 > '' then s := s + ht + 'Class: ' + ht + s1;
        lStr := lStr + s + lf + cr;
        lRoom := TeName[Changes[i].NewRoom, 1];
        if lRoom <> '' then
          lRoom := ' (' + lRoom + ')';
        s := 'Room: ' + ht+ TeCode[Changes[i].newroom,1] + lRoom;
        lStr := lStr + s + lf + cr;
        s := 'Change: ' + ht + GenType3(i);
        if printkind(i) > '' then
          s := s + lf + cr + 'Status: ' + ht + printkind(i);
        lStr := lStr + s;
        s := GetStatusNote(i);
        if s > '' then
          lStr := lStr + 'Note: ' + ht + Trim(s);
        if (su > 0) and eplist and (GroupSubCount[GsubXref[su]]>0) then
          lStr := lStr + GetSubjectList(su, i);   //student list     //ToDo
        lStr := lStr + cr + divider;
        AddSummaryItem;
      end;
    end;
    Inc(colCnt);
    CreateSummary;
  end;

  // concatenate the summary prior to writing to the pdf file
  lStr := lStr + cr + cr + lSummaryHeader1 + lSummary;

  lTeacherCover := TTeacherCover.Create;
  lTeacherCover.FTeacherNo := pTeNo;
  lTeacherCover.FTeacherCode := TeCode[pTeNo, 0];
  lTeacherCover.FTeacherName := TeName[pTeNo, 0];
  if lCount = 1 then s:=' Change' else s:=' Changes';
  if lCount > 0 then
  begin
    lTeacherCover.FDayOfChanges := IntToStr(lCount) + s + ' for ' + emailDate;
    lTeacherCover.FChangesDetails := lStr;
    lTeacherCover.CustomAddOn := GetCustomAddOn;
    FTeacherCovers.Add(lTeacherCover);
  end;
end;

function TProgressForm.GeneratePDFCover(const showMessage: Boolean = true): Boolean;
var
  i, j, lTe: Integer;
  lMsg: string;
  lCoverPDFDir: string;
  lFileName: string;
  lIsCreated: Boolean;
  lCoverFound: Boolean;

  procedure ReduceFont(aReport: TppReport);
  var  
    liBand: Integer;
    liObject: Integer;
    lObject: TppComponent;
  begin
    for liBand := 0 to aReport.BandCount-1 do
    begin
      for liObject := 0 to aReport.Bands[liBand].ObjectCount-1 do
      begin
        lObject := aReport.Bands[liBand].Objects[liObject];
        if lObject.HasFont then
          lObject.Font.Size := 7; // lObject.Font.Size - 1;
       end;
    end;
  end;

begin
  lCoverFound := False;
  lCoverPDFDir := Directories.DataDir + '\CoverPDF\';
  ForceDirectories(lCoverPDFDir);
  emailDate := DayName[ttday] + ' ' + IntToStr(exday) + ' ' + Month[exmonth];
  if EmailCoverFlag then
  begin
    lIsCreated := False;
    lMsg := '';
    for j := 1 to CodeNum[1] do
    begin
      lTe := codepoint[j, 1];
      FTeacherCovers.Clear;
      CreateOneCoverPDF(lTe);
      if FTeacherCovers.Count > 0 then
      begin
        lFileName := lCoverPDFDir + 'CoverTeacher_' + Trim(TTeacherCover(FTeacherCovers.Items[0]).FTeacherCode) + '_' + StripName(TTeacherCover(FTeacherCovers.Items[0]).FTeacherName) + '_' + FormatDateTime('dd-mm-yyy', Date) + '.pdf';
        lMsg := lMsg + lFileName + Cr;
        pipCover.InitialIndex := 1;
        pipCover.RecordCount := FTeacherCovers.Count;
        lblTitle.Caption := 'Cover Teacher';
        repCover.DeviceType := 'PDF';
        repCover.TextFileName := lFileName;
        lblSchoolName.Caption := School;
        ReduceFont(repCover);
        repCover.Print; // write to pdf file
        lIsCreated := True;
      end;
    end; //for j
    if (lIsCreated) and (showMessage) then
    begin
      MessageDlg('The following Cover Teachers PDF documents have been created:' + Cr +lMsg, mtInformation, [mbOK], 0);
      lCoverFound := True;
    end;
  end; //EmailCoverFlag

  if EmailAddedFlag then
  begin
    lIsCreated := False;
    lMsg := '';
    for j := 1 to ETnum1 do
    begin
      FTeacherCovers.Clear;
      lTe := Etpointer[j];
      CreateOneAddedStaffPDF(lTe);
      if FTeacherCovers.Count > 0 then
      begin
        lFileName := lCoverPDFDir + 'AddedStaff_' + TTeacherCover(FTeacherCovers.Items[0]).FTeacherCode + '_' + StripName(TTeacherCover(FTeacherCovers.Items[0]).FTeacherName) + '_' + FormatDateTime('dd-mm-yyy', Date) + '.pdf';
        lMsg := lMsg + lFileName + Cr;
        pipCover.InitialIndex := 1;
        pipCover.RecordCount := FTeacherCovers.Count;
        lblTitle.Caption := 'Added Staff';
        repCover.DeviceType := 'PDF';
        repCover.TextFileName := lFileName;
        lblSchoolName.Caption := School;
        repCover.Print;
        lIsCreated := True;
      end;
    end; //for j
    if (lIsCreated) and (showMessage) then
    begin
      MessageDlg('The following Added Staff PDF documents have been created:' + Cr +lMsg, mtInformation, [mbOK], 0);
      lCoverFound := True;
    end;
  end; //EmailAddedFlag

  if EmailAbsentFlag then
  begin
    lIsCreated := False;
    lMsg := '';
    for j := 1 to CodeNum[1] do
    begin
      lTe := CodePoint[j, 1];
      if TeAbsent[lTe] <> -1  then
      begin
        FTeacherCovers.Clear;
        CreateOneAbsentPDF(lTe);
        if FTeacherCovers.Count > 0 then
        begin
          lFileName := lCoverPDFDir + 'AbsentTeacher_' + TTeacherCover(FTeacherCovers.Items[0]).FTeacherCode + '_' + StripName(TTeacherCover(FTeacherCovers.Items[i]).FTeacherName) + '_' + FormatDateTime('dd-mm-yyy', Date) + '.pdf';
          lMsg := lMsg + lFileName + Cr;
          pipAbsentTeacher.InitialIndex := 1;
          pipAbsentTeacher.RecordCount := FTeacherCovers.Count;
          lblTitleAbsentTe.Caption := 'Absent Teacher';
          repAbsentTeacher.DeviceType := 'PDF';
          repAbsentTeacher.TextFileName := lFileName;
          repAbsentTeacher.Print;
          lblSchoolNameAbsentTe.Caption := School;
          lIsCreated := True;
        end;
      end;
    end; //for j
    if (lIsCreated) and (showMessage) then
    begin
      MessageDlg('The following Absent Teacher PDF documents have been created:' + Cr +lMsg, mtInformation, [mbOK], 0);
      lCoverFound := True;
    end;
  end;   //EmailAbsentFlag
  Result := lCoverFound;
end;

function TProgressForm.PopulateFieldAbsentTe(aFieldName: string): Variant;
begin
  Result := GetFieldAbsentTe(pipAbsentTeacher.RecordIndex, aFieldName);
end;

function TProgressForm.PopulateFieldData(aFieldName: string): Variant;
begin
  Result := GetFieldValue(pipCover.RecordIndex, aFieldName);
end;


end.
