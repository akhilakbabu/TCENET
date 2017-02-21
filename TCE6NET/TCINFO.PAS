Unit Tcinfo;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, StdCtrls,ClassDefs,TCEglobals, ComCtrls, Buttons,
  ExtCtrls, NiceGrid, XML.UTILS, GlobalToTcAndTcextra;

type
  TInfoWin = class(TDrawWin)
    PopupMenu1: TPopupMenu;
    Print1: TMenuItem;
    PrintSetup1: TMenuItem;
    Copy1: TMenuItem;
    lblExtrasFile: TLabel;
    lblTodayDate: TLabel;
    lblFormFeedCaption: TLabel;
    lblTimeTableName: TLabel;
    lblTeachersAbsent: TLabel;
    lblChanges: TLabel;
    lblIignoredChanges: TLabel;
    lblReplacementTeachers: TLabel;
    lblAddedTeachers: TLabel;
    lblRoomsUnavail: TLabel;
    lblTeachersNeeded: TLabel;
    lblInlieuTeachers: TLabel;
    lblCustom: TLabel;
    lblFormFeed: TLabel;
    edtExtrasFile: TEdit;
    edtTeachersAbsent: TEdit;
    edtAddedTeachers: TEdit;
    edtChanges: TEdit;
    edtRoomsUnavail: TEdit;
    edtTeachersNeeded: TEdit;
    edtInlieuTeachers: TEdit;
    edtCustom: TEdit;
    edtTimeTableName: TEdit;
    edtReplacementTeachers: TEdit;
    lblTimetableDay: TLabel;
    edtTimetableDay: TEdit;
    edtVersion: TEdit;
    lblVersion: TLabel;
    lblNewClasses: TLabel;
    edtNewClasses: TEdit;
    Label1: TLabel;
    lblProgress: TLabel;
    edtRoomsNeeded: TEdit;
    lblRoomsNeeded: TLabel;
    ngdInfo: TNiceGrid;
    procedure FormCreate(Sender: TObject);
    //procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  protected
    //procedure SetTabs; override;
  private
    procedure RefreshInfo;
  end;

procedure infoPrint;
procedure infoTextExp;

var
  InfoWin: TInfoWin;

implementation
 Uses tcommon,printers,main,tcommon2,tcommon3, PrintPreviewForm;
{$R *.DFM}

 type TPrintInfoWin=class(TPrintDrawWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutInfoWin=class(TOutputwin)
  public
   procedure head; override;
 end;

var
 PrintInfoWin:    TPrintInfoWin;
 OutInfoWin:      TOutInfoWin;
 TotalStudents,a:        integer;
 teabsent2,newclasses,roomslost,teInlieus,
 tesubs,teneeded,roomsneeded:           integer;
 tneed,tgot,tavail,rgot,ravail,rneed:   array[0 .. nmbrperiods] of integer;

procedure CalcInfoTotals;
var
 i,p: integer;
 minAllot: double;
 CanDoReplace,CanDoLieu: boolean;
begin
 totalstudents:=0;
  for i:=0 to years_minus_1 do
   inc(totalstudents,yearStat[i].NumStud);
  updateIgnoreChangesCount;
  teabsent2:=0; newclasses:=0; roomslost:=0; tesubs:=0; teneeded:=0;
  roomsneeded:=0;   teInlieus:=0;
  if numchanges>0 then
  for i:=1 to numchanges do
  begin
   if Changes[i].timeslot<=tlimit[ttday] then    {only for tslots shown as in cols}
    begin
     if Changes[i].kind>9 then continue;
     if (Changes[i].gen=2) then inc(newclasses);
     if bool(Changes[i].needte) then inc(teneeded);
     if Changes[i].needroom=1 then inc(roomsneeded);
    end;
  end; {for i}

  ETselectedCount;
    {get min allot}

  minAllot:=99999;
  for i:=1 to Tlimit[ttday] do
    if (getEallot(4,0,ttday,i)<minAllot) then minAllot:=getEallot(4,0,ttday,i);

  for i:=1 to numcodes[1] do
  begin
   CanDoReplace:=false; CanDoLieu:=false;
   if ((teavail[i]>0) and ((teavail[i]+0.00001)>=minAllot)) then
    CanDoReplace:=true;
   if ((telieudbl[i]>0) and ((telieudbl[i]+0.00001)>=minAllot)) then
    CanDoLieu:=true;
   if CanDoReplace and CanDoLieu then
   begin
    if WtReplace>=WtLieu then CanDoLieu:=false else CanDoReplace:=false;
   end;

   if CanDoReplace then inc(tesubs)
    else if CanDoLieu then inc(teInlieus);

   if teabsent[i]<>-1 then inc(teabsent2)
  end;  {for i}
  for i:=1 to numcodes[2] do
   if roabsent[i]<>-1 then inc(roomslost);

  for i:=1 to tlimit[ttday] do
   begin
     tneed[i]:=0; tgot[i]:=0; tavail[i]:=0;
     rneed[i]:=0; rgot[i]:=0; ravail[i]:=0;
   end;
  if numchanges>0 then
   for i:=1 to numchanges do
    begin
     a:=Changes[i].timeslot; if Changes[i].kind>9 then continue;
     if (a<0) or (a>periods) then continue;
     if bool(Changes[i].kind and not(Changes[i].needte)) then inc(tgot[a]);
     if bool(Changes[i].needte) then inc(tneed[a]);
     if Changes[i].needroom=1 then inc(rneed[a]);
     if Changes[i].needroom=2 then inc(rgot[a]);
    end; {for i}
  for i:=1 to numcodes[1] do
   begin
     if copy(tecode[i,0],1,2)='00' then continue;
     for p:=1 to tlimit[ttday] do
     begin
      if ((getEallot(4,i,ttday,p)+Etaken[i])<=emax[i]) or
       ((teavail[i]>0) and ((teavail[i]+0.00001)>=getEallot(4,i,ttday,p))) or
       ((telieu[i]>0) and ((telieu[i]+0.00001)>=getEallot(4,i,ttday,p))) then
        if bool(teon[i] and (1 shl p) and teabsent[i] and tena[i]) then
         inc(tavail[p]);
     end; {for p}
   end; {for i}

  for i:=1 to numcodes[2] do
     for p:=1 to tlimit[ttday] do
      if bool(roomon[i]  and (1 shl p) and roabsent[i]) then
       inc(ravail[p]);
   for i:=1 to etnum do
     for p:=1 to tlimit[ttday] do
      if (Etmax[i]>=(Ettaught[i]+getEallot(7,i,ttday,p))) and
       bool(etavail[i] and Eton[i] and (1 shl p)) then inc(tavail[p]);
end;

(*procedure TInfoWin.SetTabs;
var
 i,j:      integer;
begin
 SetLength(Tabs,14);
 CalcInfoTotals;
 caption:='Info - '+School;
 MaxTab(1,canvas.textwidth(DateStr+'  '),'FormFeed: OFF  ');
 j:=canvas.textwidth('(no ignored changes)  ');
 if j>Tabs[1] then Tabs[1]:=j;
 MaxTab(2,0,'TimeTable Day: Wed. ');
 Tabs[3]:=canvas.textwidth('99 ');
 i:=canvas.textwidth('Time Slot ');
 j:=canvas.textwidth('99: ')+fwperiodname;
 if j>i then i:=j;
 Tabs[4]:=i+blankwidth;
 MaxTab(5,0,'Order ');
 MaxTab(6,0,'Teachers ');
 MaxTab(7,0,'Got ');
 MaxTab(8,0,'Need ');
 MaxTab(9,0,'Avail ');
 MaxTab(10,0,'Rooms ');
 MaxTab(11,0,'Got ');
 MaxTab(12,0,'Need ');
 MaxTab(13,0,'Avail ');
 MaxW:=Tabs[13];
 MaxH:=txtheight*(14+periods);
end;*)

procedure TInfoWin.FormCreate(Sender: TObject);
begin
  Winpos[wnInfo].Width := 666;
  Winpos[wnInfo].Height := 520;
  SetWindowDefaults(self, wnInfo);
end;

(*procedure TInfoWin.FormPaint(Sender: TObject);
begin
var
  p: Integer;
  s: string;

  procedure print3(a,b:string);
  begin
    fcolor(cpInfo);
    printwl(a);
    fcolor(cpInfoHead);
    printwl(b);
  end;

  procedure print2(a,b:string);
  begin
    fcolor(cpInfoHead);
    printwl(a);
    fcolor(cpInfo);
    printwl(b);
  end;

begin
 fcolor(cpInfo);
 printw(inttostr(exday)+' '+month[exmonth]+' '+formatdatetime('yyyy',now));
 x:=Tabs[1]; print2('Timetable Day: ',day[ttday]);
 x:=Tabs[2]; print2('Version: ',Version);  newline;

{ Line 2 }  print2('Timetable: ',ttfile); newline;
{ Line 3 } print2('Extras File: ',exfile); newline;
{ Line 4 } print2('Changes: ',inttostr(numchanges));
 x:=Tabs[1]; print3(inttostr(teabsent2),' teacher');
 if teabsent2<>1 then printwl('s');
 printw(' absent');
 x:=Tabs[2]; print3(inttostr(newclasses),' new class');
 if newclasses<>1 then printw('es');
 newline;
 { Line 5 }
 if ignoredChangesCount>0 then
  print3(inttostr(ignoredChangesCount),' ignored changes')
 else
  printw('(no ignored changes)');
 x:=Tabs[1]; print3(inttostr(roomslost),' room');
 if roomslost<>1 then printwl('s');
 printw(' unavail');
 newline;
{ line 6 }
 fcolor(cpInfoHead);
 printw('Resources: ');
 x:=Tabs[1]; print3(inttostr(ETselected),' added teacher');
 if ETselected<>1 then printw('s');
 x:=Tabs[2]; print3(inttostr(tesubs),' replacement teacher');
 if tesubs<>1 then printw('s');
 newline;
 { line 7 }
 x:=Tabs[1]; print3(inttostr(teInlieus),' inlieu teacher');
 if teInlieus<>1 then printw('s');
{ line 8 }
 newline; fcolor(cpInfoHead);
 printw('Progress: ');
 x:=Tabs[1]; print3(inttostr(teneeded),' teacher');
 if teneeded<>1 then printwl('s');
 printw(' needed');
 x:=Tabs[2]; print3(inttostr(roomsneeded),' room');
 if roomsneeded<>1 then printwl('s');
 printw(' needed');
 newline;
 newline;
 printw('Time Slot');
 x:=Tabs[4];    printw('Order');
 x:=Tabs[5];    printw('Teachers:');
 x:=Tabs[6];    printw('Got');
 x:=Tabs[7];    printw('Need');
 x:=Tabs[8];    printw('Avail');
 x:=Tabs[9];    printw('Rooms:');
 x:=Tabs[10];   printw('Got');
 x:=Tabs[11];   printw('Need');
 x:=Tabs[12];   printw('Avail');
 newline;

 for p:=1 to tlimit[ttday] do
 begin
  printw(inttostr(p));
  x:=Tabs[3];  printw(tsName[ttday,p-1]);
  x:=Tabs[4];  printw(inttostr(torder[p,ttday]));
  x:=Tabs[6];  printw(inttostr(tgot[p]));
  x:=Tabs[7];  printw(inttostr(tneed[p]));
  x:=Tabs[8];  printw(inttostr(tavail[p]));
  x:=Tabs[10];  printw(inttostr(rgot[p]));
  x:=Tabs[11];  printw(inttostr(rneed[p]));
  x:=Tabs[12];  printw(inttostr(ravail[p]));
  newline;
 end;
 newline;
 fcolor(cpInfoHead);
 if gotcustom then
 begin
  if trim(custom)='' then s:='(New)' else s:=custom;
  print2('Custom ',s+'   ('+inttostr(addnum)+' entries)')
 end
 else
  print2('Custom ','(None)');
 newline;
end;*)

procedure TInfoWin.RefreshInfo;
var
  p: Integer;
  s: string;
begin
  ngdInfo.RowCount := Tlimit[TTDay];
  lblTodayDate.Caption := IntToStr(ExDay) + ' ' + month[exmonth] + ' ' + FormatDateTime('yyyy', Now);
  edtTimetableDay.Text := Day[TTDay];
  edtVersion.Text := Trim(Version);
  edtTimeTableName.Text := FileNames.LoadedTimeTable;
  edtExtrasFile.Text := ExFile;
  if Formfeed then
    lblFormFeed.Caption := 'ON'
  else
    lblFormFeed.Caption := 'OFF';
  edtChanges.Text := IntToStr(NumChanges);
  edtTeachersAbsent.Text := IntToStr(teabsent2);
  lblTeachersAbsent.Caption := 'teacher';
  if teabsent2 <> 1 then lblTeachersAbsent.Caption := lblTeachersAbsent.Caption + ('s');
  lblTeachersAbsent.Caption := lblTeachersAbsent.Caption + ' absent';
  edtNewClasses.Text := IntToStr(newclasses);
  lblNewClasses.Caption := 'new class';
  if newclasses <> 1 then lblNewClasses.Caption := lblNewClasses.Caption + 'es';
  if ignoredChangesCount > 0 then
    lblIignoredChanges.Caption := IntToStr(ignoredChangesCount) + ' ignored changes'
  else
    lblIignoredChanges.Caption := '(no ignored changes)';
  edtRoomsUnavail.Text := IntToStr(roomslost);
  lblRoomsUnavail.Caption := ' room';
  if roomslost<>1 then lblRoomsUnavail.Caption := lblRoomsUnavail.Caption + 's';
  lblRoomsUnavail.Caption := lblRoomsUnavail.Caption  + ' unavail';

  edtAddedTeachers.Text := IntToStr(ETselected);
  lblAddedTeachers.Caption := 'added teacher';
  if ETselected <> 1 then lblAddedTeachers.Caption := lblAddedTeachers.Caption + 's';
  edtReplacementTeachers.Text := IntToStr(TeSubs);
  lblReplacementTeachers.Caption := 'replacement teacher';
  if TeSubs <> 1 then lblReplacementTeachers.Caption := lblReplacementTeachers.Caption + 's';
  edtInlieuTeachers.Text := IntToStr(teInlieus);
  lblInlieuTeachers.Caption := 'inlieu teacher';
  if teInlieus <> 1 then lblInlieuTeachers.Caption := lblInlieuTeachers.Caption + 's';

  edtTeachersNeeded.Text := IntToStr(teneeded);
  lblTeachersNeeded.Caption := 'teacher';
  if teneeded <> 1 then lblTeachersNeeded.Caption :=  lblTeachersNeeded.Caption + 's';
  lblTeachersNeeded.Caption := lblTeachersNeeded.Caption + ' needed';
  edtRoomsNeeded.Text := IntToStr(roomsneeded);
  lblRoomsNeeded.Caption := 'room';
  if roomsneeded <> 1 then lblRoomsNeeded.Caption := lblRoomsNeeded.Caption + 's';
  lblRoomsNeeded.Caption := lblRoomsNeeded.Caption + ' needed';

  ngdInfo.Clear;
  for p := 1 to Tlimit[TTDay] do
  begin
    ngdInfo[0, P - 1] := TimeSlotName[ttday, p - 1];
    ngdInfo[1, P - 1] := IntToStr(torder[p, ttday]);
    ngdInfo[2, P - 1] := IntToStr(tgot[p]);
    ngdInfo[3, P - 1] := IntToStr(tneed[p]);
    ngdInfo[4, P - 1] := IntToStr(tavail[p]);
    ngdInfo[5, P - 1] := IntToStr(rgot[p]);
    ngdInfo[6, P - 1] := IntToStr(rneed[p]);
    ngdInfo[7, P - 1] := IntToStr(ravail[p]);
  end;
  if GotCustom then
  begin
    if Trim(custom) = '' then s := '(New)' else s := custom;
    edtCustom.Text := s + '   (' + IntToStr(AddNum) + ' entries)'
  end;
end;

procedure TInfoWin.FormActivate(Sender: TObject);
begin
  CalcInfoTotals;
  RefreshInfo;
end;

procedure TInfoWin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
end;

{-------============-----------  P R I N T I N G      ROUTINES -=-=-=-=-===============------------------------------}


procedure TPrintInfoWin.head;
begin
 UnderlineOn;
 printwl('Information');
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
end;


procedure TPrintInfoWin.SetTabs;
var
 i,j:      integer;
begin
 SetLength(PrntTabs,14);
 MaxTab(1,0,DateStr+'   ');
 j:=PrintCanvas.textwidth('(no ignored changes)  ');
 if j>PrntTabs[1] then PrntTabs[1]:=j;
 MaxTab(2,0,'TimeTable Day: Wed.  ');
 PrntTabs[3]:=PrintCanvas.textwidth('99 ');
 i:=PrintCanvas.textwidth('Time Slot ');
 j:=PrintCanvas.textwidth('99: ')+fwprntperiodname;
 if j>i then i:=j;
 PrntTabs[4]:=i+prntblankwidth;
 MaxTab(5,0,'Order ');
 MaxTab(6,0,'Teachers ');
 MaxTab(7,0,'Got ');
 MaxTab(8,0,'Need ');
 MaxTab(9,0,'Avail ');
 MaxTab(10,0,'Rooms ');
 MaxTab(11,0,'Got ');
 MaxTab(12,0,'Need ');
 MaxTab(13,0,'Avail ');
end;

procedure infoPrint;
var
 p:        integer;
 s:            string;

    procedure print2(a,b:string);
    begin
      PrintInfoWin.fcolor(cpNormal);     {was cpInfoHead }
      PrintInfoWin.printwl(a);
      PrintInfoWin.fcolor(cpNormal);     {was cpInfo }
      PrintInfoWin.printwl(b);
    end;

    procedure print3(a,b:string);
    begin
      PrintInfoWin.fcolor(cpNormal);     {was cpInfo }
      PrintInfoWin.printwl(a);
      PrintInfoWin.fcolor(cpNormal);     {was cpInfoHead }
      PrintInfoWin.printwl(b);
    end;

begin        {------------    start main proc  --------------------}
 PrintInfoWin:=TPrintInfoWin.create;
 with PrintInfoWin do
  try
   PrintHead;
   fcolor(cpnormal); {was cpInfo}
   printw(DateStr);
   x:=PrntTabs[1]; print2('Timetable Day: ',day[ttday]);
   x:=PrntTabs[2]; print2('Version: ',Version);  newline;

{ Line 2 } print2('Timetable: ',FileNames.LoadedTimeTable); newline;
{ Line 3 } print2('Extras File: ',exfile); newline;
{ Line 4 } print2('Changes: ',inttostr(numchanges));
 s:=' teacher'; if teabsent2<>1 then s:=s+'s';
 x:=PrntTabs[1]; print3(inttostr(teabsent2),s+' absent');
 s:=' new class'; if newclasses<>1 then s:=s+'es';
 x:=PrntTabs[2]; print3(inttostr(newclasses),s);
 newline;
 { Line 5 }
 if ignoredChangesCount>0 then
  print3(inttostr(ignoredChangesCount),' ignored changes')
 else
  printw('(no ignored changes)');
 s:=' room'; if roomslost<>1 then s:=s+'s';
 x:=PrntTabs[1]; print3(inttostr(roomslost),s+' unavail');
 newline;
 { line 6 }
  fcolor(cpNormal);   {was cpInfoHead}
  printw('Resources: ');
  s:=' added teacher'; if ETselected<>1 then s:=s+'s';
  x:=PrntTabs[1]; print3(inttostr(ETselected),s);
  s:=' replacement teacher'; if tesubs<>1 then s:=s+'s';
  x:=PrntTabs[2]; print3(inttostr(tesubs),s);
  newline;
  s:=' inlieu teacher'; if teInlieus<>1 then s:=s+'s';
  x:=PrntTabs[1]; print3(inttostr(teInlieus),s);
  { line 8 }
  newline;  fcolor(cpNormal);   {was cpInfoHead}
  printw('Progress: ');
  s:=' teacher'; if teneeded<>1 then s:=s+'s';
  x:=PrntTabs[1]; print3(inttostr(teneeded),s+' needed');
  s:=' room'; if roomsneeded<>1 then s:=s+'s';
   x:=PrntTabs[2]; print3(inttostr(roomsneeded),s+' needed');
   newline;
   newline;
   printw('Time Slot');
   x:=PrntTabs[4];    printw('Order');
   x:=PrntTabs[5];    printw('Teachers:');
   x:=PrntTabs[6];    printw('Got');
   x:=PrntTabs[7];    printw('Need');
   x:=PrntTabs[8];    printw('Avail');
   x:=PrntTabs[9];    printw('Rooms:');
   x:=PrntTabs[10];   printw('Got');
   x:=PrntTabs[11];   printw('Need');
   x:=PrntTabs[12];   printw('Avail');
   newline;

   for p:=1 to tlimit[ttday] do
   begin
    printw(inttostr(p));
    x:=PrntTabs[3];  printw(TimeSlotName[ttday,p-1]);
    x:=PrntTabs[4];  printw(inttostr(torder[p,ttday]));
    x:=PrntTabs[6];  printw(inttostr(tgot[p]));
    x:=PrntTabs[7];  printw(inttostr(tneed[p]));
    x:=PrntTabs[8];  printw(inttostr(tavail[p]));
    x:=PrntTabs[10];  printw(inttostr(rgot[p]));
    x:=PrntTabs[11];  printw(inttostr(rneed[p]));
    x:=PrntTabs[12];  printw(inttostr(ravail[p]));
    newline;
   end;
   newline;

   fcolor(cpNormal);   {was cpInfoHead}
   if gotcustom then
   begin
    if trim(custom)='' then s:='(New)' else s:=custom;
    print2('Custom ',s+'   ('+inttostr(addnum)+' entries)')
   end
   else
    print2('Custom ','(None)');
   newline;
   printCustomAddon;
  finally
   PrintInfoWin.Free;
  end;
end;

// Text File Output


procedure TOutInfoWin.head;
begin
 printw('Information');
 newline; newline;
end;


procedure infoTextExp;
var
 p:        integer;
 s:            string;
begin        {------------    start main proc  --------------------}
 OutInfoWin:=TOutInfoWin.create;
 with OutInfoWin do
  try
   Header;
   printline([DateStr,'Timetable Day: ',day[ttday],'Version: ',Version]);
   printline(['Timetable: ',FileNames.LoadedTimeTable]);
   printline(['Extras File: ',exfile]);
 {Line 4}
   printw('Changes: '); printc(inttostr(numchanges));
   printc(inttostr(teabsent2));
   s:=' teacher'; if teabsent2<>1 then s:=s+'s';
   s:=s+'absent'; printc(s);
   printc(inttostr(newclasses));
   s:=' new class'; if teabsent2<>1 then s:=s+'es';
   printc(s);  newline;
 { Line 5 }
 if ignoredChangesCount>0 then
  printw(inttostr(ignoredChangesCount)+' ignored changes')
 else
  printw('(no ignored changes)');
 s:=' room'; if roomslost<>1 then s:=s+'s';
 s:=s+' unavail';
 printc(inttostr(roomslost));printc(s);
 newline;
 { line 6 }
  printw('Resources: ');
  s:=' added teacher'; if ETselected<>1 then s:=s+'s';
  printc(inttostr(ETselected)); printc(s);
  s:=' replacement teacher'; if tesubs<>1 then s:=s+'s';
  printc(inttostr(tesubs)); printc(s);
  newline;
 { line 7}
  s:=' inlieu teacher';if teInlieus<>1 then s:=s+'s';
  printc(inttostr(teInlieus)); printc(s);
  newline;  
  { line 8 }
  printw('Progress: ');
  s:=' teacher'; if teneeded<>1 then s:=s+'s';
  s:=s+' needed';
  printc(inttostr(teneeded)); printc(s);
  s:=' room'; if roomsneeded<>1 then s:=s+'s';
  s:=s+' needed';
  printc(inttostr(roomsneeded)); printc(s);
  newline;
  newline;
  printline(['Time Slot','','Order','Teachers: Got','Need','Avail','Rooms: Got',
  'Need','Avail']);

   for p:=1 to tlimit[ttday] do
   printline([inttostr(p),TimeSlotName[ttday,p-1],inttostr(torder[p,ttday]),inttostr(tgot[p]),
   inttostr(tneed[p]),inttostr(tavail[p]),inttostr(rgot[p]),
    inttostr(rneed[p]),inttostr(ravail[p])]);

   if gotcustom then
   begin
    if trim(custom)='' then s:='(New)' else s:=custom;
    printw('Custom '+s); printc('   ('+inttostr(addnum)+' entries)');
   end
   else
    printw('Custom ');printc('(None)');
   newline;

   printCustomAddon;
  finally
   OutInfoWin.Free;
  end;

end;



end.
