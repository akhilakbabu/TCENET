unit TeWnd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls,TCEglobals,ClassDefs, XML.UTILS, GlobalToTcAndTcextra;

type
  TTeWindow = class(TCodeWin)
    PopupMenu1: TPopupMenu;
    add2: TMenuItem;
    Change2: TMenuItem;
    Delete2: TMenuItem;
    Times3: TMenuItem;
    N6: TMenuItem;
    Timetable1: TMenuItem;
    View2: TMenuItem;
    CodeLengths2: TMenuItem;
    N7: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    MainMenu1: TMainMenu;
    Codes1: TMenuItem;
    SelectCode1: TMenuItem;
    Teacher1: TMenuItem;
    AddedStaff1: TMenuItem;
    Times1: TMenuItem;
    AbsenceReason1: TMenuItem;
    CoverNote1: TMenuItem;
    N5: TMenuItem;
    Add1: TMenuItem;
    Change1: TMenuItem;
    Delete1: TMenuItem;
    Times2: TMenuItem;
    N4: TMenuItem;
    View1: TMenuItem;
    Codelengths1: TMenuItem;
    Email: TMenuItem;
    EmailAddresses1: TMenuItem;
    Copy1: TMenuItem;
    popTeacherVariationSheet: TMenuItem;
    popTeN1: TMenuItem;
    popTeAbsentTeacher: TMenuItem;
    popTeLostClasses: TMenuItem;
    minTeN1: TMenuItem;
    mniTeAbsentTeachers: TMenuItem;
    mniTeLostClasses: TMenuItem;
    procedure SelectCode1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure View1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure Change1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure Codelengths1Click(Sender: TObject);
    procedure Codes1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timetable1Click(Sender: TObject);
    procedure AddedStaff1Click(Sender: TObject);
    procedure AbsenceReason1Click(Sender: TObject);
    procedure CoverNote1Click(Sender: TObject);
    procedure Times1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure EmailClick(Sender: TObject);
    procedure TeacherTallies(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DisplayVariationSheet(Sender: TObject);
    procedure ChangeLostClass(Sender: TObject);
    procedure ChangeAbsentTeacher(Sender: TObject);
  protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
    function MyCodePoint(i:integer): integer; override;
  end;


  procedure TeCodePrint;
  procedure TeCodeOut;
  procedure updatesub(code: integer);
  function zeromessage: string;
  procedure checkTeFaculty(var fac1,fac2,fac3,fac4: smallint);
  procedure insertfaculty(ebox: Tedit);

var
  TeWindow: TTeWindow;
{$WARN SYMBOL_DEPRECATED OFF}

implementation

uses
  main, vwcoddlg, addtcode, edtcode, deltcode, codelen, tcommon, tcommon2, tcommon3,
  exdatent, EdTeEmail, tcommon5, uAMGCommon, StaffTimetable, Edlstcls, EDABTES;

{$R *.dfm}

 type TPrintTeWin=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutTeWin=class(TOutCodeWin)
  public
   procedure head; override;
   function CodeToPrint(i:integer):string; override;
 end;

const
 mycode=1;
var
 PrintTeWin:    TPrintTeWin;
 OutTeWin:     TOutTeWin;

function TTeWindow.MyCodePoint(i:integer): integer;
begin
 result:=codepoint[i,mycode];
end;

procedure TTeWindow.setTabs;
var
 j,curtab:          integer;
begin
 setlength(Tabs,16);
 TotalCodes:=codenum[mycode];
 headwidth:=canvas.textwidth('Teacher Codes: 99  Sort: Name  Code length: 8 ');
 CodeWidth:=fwCode[mycode]+blankWidth;
 CalcScreenCodeFit;

 maxTab(1,Codewidth,'Code');
 maxTab(2,fwCodename[mycode],'Name ');
 case winView[wnTecode] of
  0: maxW:=CodeWidth*CodeFit;  {codes}
  1: begin  {code + name}
      maxTab(3,0,'32000');
      for j:=4 to 7 do maxTab(j,fwFaculty,'');
      for j:=0 to 2 do
       begin {j}
        maxTab(8+j*2,fwTeDutyCode,'');
        maxTab(9+j*2,fwTeDutyLoad,'');
       end; {j}
      maxW:=Tabs[13]+blankwidth;
      Tabs[15] := maxW;
     end;
  2: begin  {tallies}
      maxTab(1,Codewidth,'Teacher ');
      maxTab(2,canvas.textwidth('Extras'),'22.22 ');
      maxTab(3,canvas.textwidth('Extras'),'22.22 ');
      maxTab(4,canvas.textwidth('Extras'),'222.22/222.22 ');
      maxTab(5,canvas.textwidth('Replace'),'22.22 ');
      maxTab(6,canvas.textwidth('Week'),'2222 ');
      maxTab(7,0,'99 Aug ');
      maxTab(8,0,'0000000000 ');
      curTab:= canvas.textwidth('15 Day 10 ');
      maxTab(9,curTab,'Prefer ');
      maxTab(10,curTab,'Prefer ');
      maxTab(11,curTab,'Prefer ');
      maxTab(12,curTab,'Prefer ');
      maxTab(13,curTab,'Prefer ');
      maxTab(14, curTab,'Class Cover ');
      maxTab(15, fwTeComment, 'Comment');
      maxW := Tabs[14] + blankwidth;
     end;
  3: begin {email addresses}
      maxTab(3,fwTemail,'Email Addresses');
      maxW:=Tabs[3]+blankwidth;
     end;
 end; {case}
 ReDoSelection;
end;

function zeromessage: string;
var
 msg: string;
begin
 msg:='Codes starting with "00" are reserved by Time Chart for'+endline;
 msg:=msg+' deleted codes and are unavailable for other uses.'+endline;
 msg:=msg+'Please enter a different code.';
 result:=msg;
end;

procedure checkTeFaculty(var fac1,fac2,fac3,fac4: smallint);
begin
 if fac1<0 then fac1:=-1;
 if ((fac1=-1) or (fac2=-1) or (fac3=-1)or (fac4=-1)) then
 begin
  fac1:=-1; fac2:=0; fac3:=0; fac4:=0;
 end;
 if (fac1>FacNum) then fac1:=0;
 if (fac2<0) or (fac2>FacNum) then fac2:=0;
 if (fac3<0) or (fac3>FacNum) then fac3:=0;
 if (fac4<0) or (fac4>FacNum) then fac4:=0;
end;


function getfacname(a:integer): string;
begin
  result:='';
  if a=-1 then result:='All Faculties'
          else if (a>0) and (a<=FacNum)
          then result:=facName[a];
end;


procedure updatesub(code: integer);
var
i,j,v:                  integer;
fname,tname: string;
sub2:                   string;
name2:                  string;
tmpStr:                 string;
begin
 if code<>1 then exit;
 chdir(Directories.datadir);
 try
  try
   fname:='TECODE.DAT';
   tname:='TECODE.TMP';
   ourSafetyMemStreamStr:='';
   ourSafetyMemStream:=TStringStream.Create(ourSafetyMemStreamStr);
   with ourSafetyMemStream do
    begin
     Write(NumCodes[code],2);   Write(LenCodes[code],2);
     if NumCodes[code]>0 then
      for i:=1 to NumCodes[code] do
       begin
        sub2:=RPadString(FNsub(i,code),LenCodes[code]);
        Write(Pchar(@sub2[1])^,LenCodes[code]);
       end;
    end;
   SafelyStreamToFile(tname,fname);
  finally
   ourSafetyMemStream.Free;
   NEW_DateChecks[1]:=FileDateToDateTime(fileage(fname));
  end;
 except
 end;

 try
  try
   fname:='TENAME.DAT';
   tname:='TENAME.TMP';
   ourSafetyMemStreamStr:='';
   ourSafetyMemStream:=TStringStream.Create(ourSafetyMemStreamStr);
   with ourSafetyMemStream do
    begin
     Write(NumCodes[code],2);
     if NumCodes[code]>0 then
      for i:=1 to NumCodes[code] do
      begin
       name2:=RPadString(FNsubname(i,code),szTeName);
       Write(Pchar(@name2[1])^,szTeName);
      end;
    end;
   SafelyStreamToFile(tname,fname);
  finally
   ourSafetyMemStream.Free;
  end;
 except
 end;

 try
  try
   fname:='TELOAD.DAT';
   tname:='TELOAD.TMP';
   ourSafetyMemStreamStr:='';
   ourSafetyMemStream:=TStringStream.Create(ourSafetyMemStreamStr);
   with ourSafetyMemStream do
    begin
     TC4fileHeader:='TCV4';
     if NumCodes[code]>0 then
      begin
       Write(Pchar(@TC4fileHeader[1])^,4);
       for i:=1 to NumCodes[code] do
        begin
         Write(Load[i],2);
         for v:=1 to 3 do  Write(Tfaculty[i,v],2);
         for j:=0 to 2 do
          begin
           tmpStr:=RPadString(dutycode[i,j],szdutycode);
           Write(Pchar(@tmpStr[1])^,szdutycode);
           Write(dutyload[i,j],8); {double}
          end;
        end;
      end;
    end;
   SafelyStreamToFile(tname,fname);
  finally
   ourSafetyMemStream.Free;
  end;
 except
 end;

 try    {write fourth faculty}
  try
   fname:='TeFac.DAT';
   tname:='TeFac.TMP';
   ourSafetyMemStreamStr:='';
   ourSafetyMemStream:=TStringStream.Create(ourSafetyMemStreamStr);
   with ourSafetyMemStream do
    begin
     v:=1;
     write(NumCodes[code],2);
     write(v,2);
     if NumCodes[code]>0 then
       for i:=1 to NumCodes[code] do Write(Tfaculty[i,4],2);
    end;
   SafelyStreamToFile(tname,fname);
  finally
   ourSafetyMemStream.Free;
  end;
 except
 end;

 SaveTemail;
end;

function CheckLastDate(k:integer):string;
begin
 result:='';
 if (Emonth[k]>0) and (Emonth[k]<13) and (Eday[k]>0) and (Eday[k]<32)
    and ((Eday[k]<31) or ((Emonth[k]<>9) and (Emonth[k]<>4) and (Emonth[k]<>6) and
       (Emonth[k]<>11))) and ((Emonth[k]<>2) or (Eday[k]<30)) then
 result:=inttostr(Eday[k])+' '+month[Emonth[k]];
end;

function CheckLike(k,j:integer):string;
begin
 if ((liketime[k,j]=0) or (likEday[k,j]=-1)) then result:='none'
  else result:=inttostr(liketime[k,j])+' '+day[likEday[k,j]];
end;



procedure TTeWindow.PaintItem(i:integer;SelFlag:boolean);
var
 s: string;
 tmpInt,j,k:    integer;
begin
 k:=codepoint[i,mycode];

 case winView[wnTecode] of
   0: printw(tecode[k,0]);  {codes only}
   1: begin  {code + name}
        printw(tecode[k,0]);
        x:=Tabs[1]; printw(tename[k,0]);
        if Load[k]<0 then s:=inttostr(periods*days) else s:=inttostr(Load[k]);
        x:=Tabs[2]+canvas.textwidth('Load')-canvas.textwidth(s);
        printw(s);
        for j:=1 to nmbrTeFacs do
        begin
         x:=Tabs[2+j];
         tmpInt:= Tfaculty[k,j];
         s:=getfacname(tmpInt);
         if (j=1) or (tmpInt>0) then printw(s);
        end;
        for j:=0 to 2 do
         begin
          x:=Tabs[7+2*j];
          if trim(dutycode[k,j])='' then printw('-') else printw(dutycode[k,j]);
          x:=Tabs[9+2*j]-Blankwidth;
          if dutyload[k,j]=0 then
            begin
              s:='0';
              x:=x- self.canvas.textwidth('0.0');
            end
          else
           begin
            str(dutyload[k,j]:4:1,s);  {leaves leading blanks}
            s:=trim(s);
            x:=x-self.canvas.textwidth(s);
           end;
          printw(s);
         end; {for j}
      end;
   2: begin  {tallies}
        printw(tecode[k,0]);
        x:=Tabs[1]; str(Emax[k]:4:2,s); printw(s);
        x:=Tabs[2]; str(Etaken[k]:4:2,s); printw(s);
        x:=Tabs[3]; str(Elieutaken[k]:4:2,s); printwl(s+'/');
            str(Elieu[k]:4:2,s); printw(s);
        x:=Tabs[4]; str(Ereplace[k]:4:2,s); printw(s);
        x:=Tabs[5]; str(Eweek[k]:4:2,s); printw(s);
        x:=Tabs[6];  printw(CheckLastDate(k));
        x:=Tabs[7]; s:=InttoBINstr(Eten[k]); s:=copy(s,Length(s)-9,10); {last ten chars}
            printw(s);
        for j:=1 to 5 do
         begin
          x:=Tabs[7+j];  printw(CheckLike(k,j));
         end;
        x := Tabs[13] + 3 * BlankWidth;
        PrintW(IntToStr(GetTeacherCoverTally(TeCode[k, 0])));
        x := Tabs[14];
        printw(Ecomment[k]);
      end;
   3: begin   {email addresses}
        printw(tecode[k,0]);
        x:=Tabs[1]; printw(tename[k,0]);
        x:=Tabs[2]; printw(Temail[k]);
      end;
  end;
 fcolor(codecolor);
end;

procedure TTeWindow.PaintHead;
begin
 codeColor:=cpTeach; {teacher}
 {Headings}
  printw2('Teacher Codes: ',inttostr(TotalCodes));
  printw2('  Sort: ',sortname[sorttype[mycode]]);
  printw2('  Code Length: ',inttostr(lencodes[mycode]));
  newline;
  if TotalCodes>0 then
    case winView[wnTecode] of
     1: begin  {code + name}
          fcolor(cpNormal); printwl('Code ');
          x:=Tabs[1]; printw('Name');
          x:=Tabs[2]; printw('Load');
          x:=Tabs[3]; printw('Faculties');
          x:=Tabs[7]; printw('Duty Codes & Loads');
        end;
     2: begin  {tallies}
          fcolor(cpNormal);
           printw('Teacher');
           x:=Tabs[1]; printw('Extras');
           x:=Tabs[2]; printw('Extras');
           x:=Tabs[3]; printw('Extras');

           x:=Tabs[5]; printw('This');
           x:=Tabs[6]; printw('Last');
           x:=Tabs[7]; printw('Last');
           x:=Tabs[8]; printw('1st');
           x:=Tabs[9]; printw('2nd');
           x:=Tabs[10]; printw('3rd');
           x:=Tabs[11]; printw('4th');
           x:=Tabs[12]; printw('5th');
           x := Tabs[13]; PrintW('Class Cover');
           x:=Tabs[14]; printw('Extras');
           newline;
           printw('Code');
           x:=Tabs[1]; printw('Max.');
           x:=Tabs[2]; printw('Taken');
           x:=Tabs[3]; printw('InLieu');
           x:=Tabs[4]; printw('Replace');
           x:=Tabs[5]; printw('Week');
           x:=Tabs[6]; printw('Extra');
           x:=Tabs[7]; printw('Ten Days');
           x:=Tabs[8]; printw('prefer.');
           x:=Tabs[9]; printw('prefer');
           x:=Tabs[10]; printw('prefer');
           x:=Tabs[11]; printw('prefer');
           x:=Tabs[12]; printw('prefer');
           x := Tabs[13]; PrintW('by Others ');
           x:=Tabs[14]; printw('Comment');
        end;
     3: begin  {email addresses}
          fcolor(cpNormal); printwl('Code ');
          x:=Tabs[1]; printw('Name');
          x:=Tabs[2]; printw('Email Address');
        end;
    end;
  newline;
end;

procedure TTeWindow.SelectCode1Click(Sender: TObject);
begin
 TickCodeSubMenu(SelectCode1);
end;

procedure TTeWindow.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnTeCode);
end;

procedure TTeWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:= caFree;
end;


procedure insertfaculty(ebox: Tedit);
var
 facStr:        string;
 facPlace,pos:  integer;
begin
 facStr:=ebox.text;   trim(facStr);
 if length(facStr)<3 then exit;
 facPlace:=checkFaculty(facStr);
 if facPlace>0 then
 begin
  pos:=ebox.selstart;
  ebox.text:=facName[facPlace];
  ebox.selstart:=pos;
 end;
end;

procedure TTeWindow.View1Click(Sender: TObject);

begin
 ViewCodeDialog:=TViewCodeDialog.create(self); {allocate dlg}
 viewCodeDialog.Show.ItemIndex:=winView[wnTecode];
 viewCodeDialog.Sort.ItemIndex:=sorttype[mycode];
 viewCodeDialog.showmodal;
 viewCodeDialog.free;
end;


procedure TTeWindow.Add1Click(Sender: TObject);
var
 msg:   string;
begin
 if TotalCodes<nmbrteachers then
  begin
   if CheckAccessRights(4,1,true) then
   begin
    addtcodedlg:=Taddtcodedlg.create(self); {allocate dlg}
    addtcodedlg.showmodal;
    addtcodedlg.free;  {release dlg}
    CheckAccessRights(4,1,false);
   end;
  end
 else
    begin
       msg:='Maximum number of '+codeName[mycode]+'codes is '+inttostr(nmbrteachers)+'.'+endline;
       msg:=msg+'There is no room to add another '+codeName[mycode]+' at this time.';
       messagedlg(msg,mtError,[mbOK],0);
 end; {if}
end;

procedure TTeWindow.ChangeLostClass(Sender: TObject);
begin
  if CheckAccessRights(4, 9, True) then
  begin
    EdLostClasses := TEdLostClasses.Create(Application);   {allocate dlg}
    try
      EdLostClasses.SelectedTeCode := Self.SelCode;
      EdLostClasses.IsDirect := True;
      EdLostClasses.ShowModal;
    finally
      FreeAndNil(EdLostClasses);
    end;
    CheckAccessRights(4, 9, False);
  end;
end;

procedure TTeWindow.Change1Click(Sender: TObject);
var
 msg:     string;
begin
 if TotalCodes=0 then
   begin
    msg:='No '+CodeName[mycode]+' codes available to edit.';
    messagedlg(msg,mtError,[mbOK],0);
    exit;
   end;
  if CheckAccessRights(4,1,true) then
  begin
   edtcodedlg:=Tedtcodedlg.create(self);    {allocate dlg}
   edtcodedlg.showmodal;
   edtcodedlg.free;     {release dlg}
   CheckAccessRights(4,1,false);
  end;
end;

procedure TTeWindow.ChangeAbsentTeacher(Sender: TObject);
begin
  if CheckAccessRights(4, 9, True) then
  begin
    EditAbsTeacherss := TEditAbsTeacherss.Create(Application);   {allocate dlg}
    try
      EditAbsTeacherss.SelectedTeCode := Self.SelCode;
      EditAbsTeacherss.IsDirect := True;
      EditAbsTeacherss.ShowModal;
    finally
      FreeAndNil(EditAbsTeacherss);
    end;
    CheckAccessRights(4, 9, False);
  end;
end;

procedure TTeWindow.Delete1Click(Sender: TObject);
var
 msg:   string;
begin
 if TotalCodes=0 then
   begin
    msg:='No '+CodeName[mycode]+' codes available to delete.';
    messagedlg(msg,mtError,[mbOK],0);
    exit;
   end;
  if CheckAccessRights(4,1,true) then
  begin
   deltcodedlg:=Tdeltcodedlg.create(self);  {allocate dlg}
   deltcodedlg.showmodal;
   deltcodedlg.free;   {release dlg}
   CheckAccessRights(4,1,false);
  end;
end;

procedure TTeWindow.DisplayVariationSheet(Sender: TObject);
//var
  //lFrmStaffTT: TFrmStaffTT;
begin
  {lFrmStaffTT := TFrmStaffTT.Create(Application);
  try
    lFrmStaffTT.SelectedTe := CodePoint[SelCode, 1];
    lFrmStaffTT.RefreshTimetable;
    lFrmStaffTT.PrintPreviewReport(Self);
  finally
    FreeAndNil(lFrmStaffTT);
  end;}
end;

procedure TTeWindow.Codelengths1Click(Sender: TObject);
begin
 if CheckAccessRights(4,1,true) then
 begin
  codelendlg:=Tcodelendlg.create(self);   {allocate dlg}
  codelendlg.tag:=self.tag;
  codelendlg.showmodal;
  codelendlg.free;   {release dlg}
  CheckAccessRights(4,1,false);
 end;
end;

procedure TTeWindow.Codes1Click(Sender: TObject);
var
 hascodes:  boolean;
begin
  add1.enabled:=(TotalCodes<nmbrTeachers);
  hascodes:=(TotalCodes>0);
  change1.enabled:=hascodes;
  delete1.enabled:=hascodes;
  times2.enabled:=hascodes;
  view1.enabled:=hascodes;
end;

procedure TTeWindow.PopupMenu1Popup(Sender: TObject);
var
 hascodes:  boolean;
begin
 add2.enabled:=(TotalCodes<nmbrTeachers);
 hascodes:=(TotalCodes>0);
 change2.enabled:=hascodes;
 delete2.enabled:=hascodes;
 times3.enabled:=hascodes;
 view2.enabled:=hascodes;
 timetable1.visible:=(selcode>0);
end;

procedure TTeWindow.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
   vk_Delete: Delete1Click(self);  {call popup menu routine}
   vk_Insert: Add1Click(self);   {call popup menu routine}
  end; {case}
end;

procedure TTeWindow.FormResize(Sender: TObject);
begin
  Self.SetTabs;
  Refresh;
end;

procedure TTeWindow.Timetable1Click(Sender: TObject);
begin
 tettselection[0]:=1;
 tettselection[1]:=codepoint[selcode,1];  {selection}
 tettlistvals[3]:=0;    {fac}
 tettseltype:=2; {selection}
 winView[wnTeacherTt]:=1; {weekly}
 teachttablewinselect;
 UpdateWindow(wnTeacherTt);
end;



procedure TPrintTeWin.SetTabs;
var
 j,curtab:          integer;
begin   {start of setprntTabs}
 setlength(PrntTabs,16);
 TotalCodes:=codenum[mycode];
 CodeWidth:=fwPrntCode[mycode]+prntBlankwidth;
 maxTab(1,Codewidth,'Code');
 maxTab(2,fwPrntCodename[mycode],'Name ');
 case winView[wnTecode] of
 0: CalcPrintCodeFit;  {codes}
 1: begin  {code + name}
     codefit:=1;
     maxTab(3,0,'32000');
     for j:=4 to 7 do maxTab(j,fwPrntFaculty,'');
     for j:=0 to 2 do
      begin {j}
       maxTab(8+j*2,fwPrntTeDutyCode,'');
       maxTab(9+j*2,fwPrntTeDutyLoad,'');
      end; {j}
    end;
 2: begin  {tallies}
     codefit:=1;
     maxTab(1,Codewidth,'Teacher ');
     maxTab(2,PrintCanvas.textwidth('Extras'),'22.22 ');
     maxTab(3,PrintCanvas.textwidth('Extras'),'22.22 ');
     maxTab(4,PrintCanvas.textwidth('Extras'),'222.22/222.22 ');
     maxTab(5,PrintCanvas.textwidth('Replace'),'22.22 ');
     maxTab(6,PrintCanvas.textwidth('Week'),'2222 ');
     maxTab(7,0,'99 Aug ');
     maxTab(8,0,'0000000000 ');
     curTab:= PrintCanvas.textwidth('15 Day 10 ');
     maxTab(9,curTab,'Prefer ');
     maxTab(10,curTab,'Prefer ');
     maxTab(11,curTab,'Prefer ');
     maxTab(12,curTab,'Prefer ');
     maxTab(13, curTab,'Prefer ');
     maxTab(14, curTab,'Class Cover ');
    end;
 3: begin  {email addresses}
     codefit:=1;
     maxTab(3,fwPrntTemail,'Email Addresses');
    end;
 end;
end;

procedure TPrintTeWin.head;
begin
 UnderlineOn;
 codeColor:=cpTeach; {teacher}
 printw2('Teacher Codes: ',inttostr(codenum[mycode]));
 printw2('  Sort: ',sortname[sorttype[mycode]]);
 printw2('  Code Length: ',inttostr(lencodes[mycode]));
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(cpNormal);
  case winView[wnTecode] of
   1: begin {codes + name}
       printwl('Code ');
       x:=prntTabs[1]; printw('Name');
       x:=prntTabs[2]; printw('Load');
       x:=prntTabs[3]; printw('Faculties');
       x:=prntTabs[7]; printw('Duty Codes & Loads');
      end;
   2: begin {tallies}
       printw('Teacher');
       x:=prntTabs[1]; printw('Extras');
       x:=prntTabs[2]; printw('Extras');
       x:=prntTabs[3]; printw('Extras');

       x:=prntTabs[5]; printw('This');
       x:=prntTabs[6]; printw('Last');
       x:=prntTabs[7]; printw('Last');
       x:=prntTabs[8]; printw('1st');
       x:=prntTabs[9]; printw('2nd');
       x:=prntTabs[10]; printw('3rd');
       x:=prntTabs[11]; printw('4th');
       x:=prntTabs[12]; printw('5th');
       x := prntTabs[13]; PrintW('Class Cover');
       x := prntTabs[14]; PrintW('Extras');
       x:=0; y:=y+PrnttxtHeight;
       printw('Code');
       x:=prntTabs[1]; printw('Max.');
       x:=prntTabs[2]; printw('Taken');
       x:=prntTabs[3]; printw('InLieu');
       x:=prntTabs[4]; printw('Replace');
       x:=prntTabs[5]; printw('Week');
       x:=prntTabs[6]; printw('Extra');
       x:=prntTabs[7]; printw('Ten Days');
       x:=prntTabs[8]; printw('prefer.');
       x:=prntTabs[9]; printw('prefer');
       x:=prntTabs[10]; printw('prefer');
       x:=prntTabs[11]; printw('prefer');
       x:=prntTabs[12]; printw('prefer');
       x := prntTabs[13]; PrintW('by Others ');
       x := prntTabs[14]; printw('Comment');
      end;
   3: begin {email addresses}
       printwl('Code ');
       x:=prntTabs[1]; printw('Name');
       x:=prntTabs[2]; printw('Email Address');
      end;
  end; {case}
 x:=0; y:=y+PrnttxtHeight;
end;



procedure TeCodePrint;
var
 s:            string;
 i,j,k,tmpInt: integer;
 tmpstr:               string;

begin
 PrintTeWin:=TPrintTeWin.Create;
 with PrintTeWin do
  try
   PrintHead;
   if TotalCodes<=0 then exit;
   for i:=1 to TotalCodes do
    begin
     fcolor(codecolor);
     k:=codepoint[i,mycode];
     case winView[wnTecode] of
      0: begin
          printw(tecode[k,0]);
          x:=(i mod codefit)*CodeWidth;
          if (i mod codefit)=0 then newline;
         end;
      1: begin
          printw(tecode[k,0]);
          x:=prntTabs[1]; printw(tename[k,0]);
          if Load[k]<0 then s:=inttostr(periods*days) else s:=inttostr(Load[k]);
          x:=prntTabs[2]+PrintCanvas.textwidth('Load')-PrintCanvas.textwidth(s);
          printw(s);
          for j:=1 to nmbrTeFacs do
           begin
            x:=prntTabs[2+j];
            tmpInt:= Tfaculty[k,j];
            s:=getfacname(tmpInt);
            if (j=1) or (tmpInt>0) then printw(s);
           end;
          for j:=0 to 2 do
           begin
            x:=prntTabs[7+2*j];
            if trim(dutycode[k,j])='' then printw('-') else printw(dutycode[k,j]);
            x:=prntTabs[9+2*j]-prntBlankwidth;
            if dutyload[k,j]=0 then
             begin
               s:='0';
               x:=x-PrintCanvas.textwidth('0.0');
             end
            else
             begin
               str(dutyload[k,j]:4:1,s);  {leaves leading blanks}
               s:=trim(s);
               x:=x-PrintCanvas.textwidth(s);
              end;
            printw(s);
           end; {for j}
          newline;
         end;
      2: begin
          printw(tecode[k,0]);
          x:=prntTabs[1]; str(Emax[k]:4:2,tmpstr); printw(tmpstr);
          x:=prntTabs[2]; str(Etaken[k]:4:2,tmpstr); printw(tmpstr);
          x:=prntTabs[3]; str(Elieutaken[k]:4:2,tmpstr); printwl(tmpstr+'/');
            str(Elieu[k]:4:2,tmpstr); printw(tmpstr);
          x:=prntTabs[4]; str(Ereplace[k]:4:2,tmpstr); printw(tmpstr);
          x:=prntTabs[5]; str(Eweek[k]:4:2,tmpstr); printw(tmpstr);
          x:=prntTabs[6]; printw(CheckLastDate(k));
          x:=prntTabs[7]; tmpstr:=InttoBINstr(Eten[k]); tmpstr:=copy(tmpstr,Length(tmpstr)-9,10); {last ten chars}
            printw(tmpstr);
          for j:=1 to 5 do
           begin
            x:=prntTabs[7+j];  printw(CheckLike(k,j));
           end;
          x := prntTabs[13] + 3 * PrntBlankwidth;  // trying to centre the text
          PrintW(IntToStr(GetTeacherCoverTally(TeCode[k, 0])));
          x := prntTabs[14]; printw(Ecomment[k]);
         newline
         end;
      3: begin {email addresses}
          printw(tecode[k,0]);
          x:=prntTabs[1]; printw(tename[k,0]);
          x:=prntTabs[2]; printw(Temail[k]);
          newline;
         end;
     end;  {case}
    end;  {for i  to totalcodes}
    newline;
   printCustomAddon;
  finally; {with PrintTeWin}
   PrintTeWin.Free;
  end;
end; {main print}

procedure TOutTeWin.head;
begin
 printLine(['Teacher Codes: ',inttostr(codenum[mycode]),' Sort: ',sortname[sorttype[mycode]],
     ' Code Length: ',inttostr(lencodes[mycode])]);
 newline;
  case winView[wnTecode] of
   1: begin {codes + name}
       printLine(['Code ','Name','Load','Faculties','','','','Duty Codes & Loads']);
      end;
   2: begin {tallies}
       printLine(['Teacher','Extras','Extras','Extras','','This','Last','Last',
        '1st','2nd','3rd','4th','5th','Extras']);
       newline;
       Printline(['Code','Max.','Taken','InLieu','Replace','Week','Extra','Ten Days',
        'prefer.','prefer','prefer','prefer','prefer','Comment']);
      end;
   3: begin {email addresses}
       printLine(['Code ','Name','Email Address']);
      end;
  end; {case}
 newline;
end;

function TOutTeWin.CodeToPrint(i:integer):string;
begin
 result:=tecode[codepoint[i,mycode],0];
end;


procedure TeCodeOut;
var
 s:            string;
 i,j,k,tmpInt: integer;
 tmpstr:               string;

begin
 OutTeWin:=TOutTeWin.Create;
 with OutTeWin do
  try
   Setup(codenum[mycode]);
   if TotalCodes<=0 then exit;
   for i:=1 to TotalCodes do
    begin
     k:=codepoint[i,mycode];
     case winView[wnTecode] of
      0: PrintCode(i);
      1: begin
          printw(tecode[k,0]);
          printc(tename[k,0]);
          if Load[k]<0 then s:=inttostr(periods*days) else s:=inttostr(Load[k]);
          printc(s);
          for j:=1 to nmbrTeFacs do
           begin
            tmpInt:= Tfaculty[k,j];
            s:='';
            if (j=1) or (tmpInt>0) then s:=getfacname(tmpInt);
            printc(s);
           end;
          for j:=0 to 2 do
           begin
            if trim(dutycode[k,j])='' then printc('-') else printc(dutycode[k,j]);
            if dutyload[k,j]=0 then s:='0'
            else
             begin
               str(dutyload[k,j]:4:1,s);  {leaves leading blanks}
               s:=trim(s);
              end;
            printc(s);
           end; {for j}
          newline;
         end;
      2: begin
          printw(tecode[k,0]);
          str(Emax[k]:4:2,tmpstr); printc(tmpstr);
          str(Etaken[k]:4:2,tmpstr); printc(tmpstr);

          str(Elieutaken[k]:4:2,tmpstr);  str(Elieu[k]:4:2,s);
          s:=tmpstr+'/'+s; printc(s);

          str(Ereplace[k]:4:2,tmpstr); printc(tmpstr);
          str(Eweek[k]:4:2,tmpstr); printc(tmpstr);
          printc(CheckLastDate(k));
          tmpstr:=InttoBINstr(Eten[k]); tmpstr:=copy(tmpstr,Length(tmpstr)-9,10); {last ten chars}
            printc('['+tmpstr+']');
          for j:=1 to 5 do printc(CheckLike(k,j));
          printc(Ecomment[k]);
          newline;
         end;
      3: begin {email addresses}
          printw(tecode[k,0]);
          printc(tename[k,0]);
          printc(Temail[k]);
          newline;
         end;
     end;  {case}
    end;  {for i  to totalcodes}
    newline;
   printCustomAddon;
  finally; {with OutTeWin}
   OutTeWin.Free;
  end;
end; {main text output}


procedure TTeWindow.AddedStaff1Click(Sender: TObject);
begin
 AddedStaffWinSelect;
end;

procedure TTeWindow.AbsenceReason1Click(Sender: TObject);
begin
 absreasonswinselect;
end;

procedure TTeWindow.CoverNote1Click(Sender: TObject);
begin
 covernoteswinselect;
end;

procedure TTeWindow.Times1Click(Sender: TObject);
begin
 TimesWinSelect;
end;

procedure TTeWindow.FormDblClick(Sender: TObject);
begin
  DoubleClick := True;
  if codenum[mycode] = 0 then Exit;
  case winView[wnTecode] of
    0,1: Change1Click(Self);
      2: TeacherTallies(self);
      3: EmailClick(Self);
  end;
end;

procedure TTeWindow.EmailClick(Sender: TObject);
begin
 EdTemail:=TEdTemail.Create(self);  {allocate dlg}
 EdTemail.showmodal;
 EdTemail.free;   {release dlg}
end;

procedure TTeWindow.TeacherTallies(Sender: TObject);
begin
 if CheckAccessRights(4,3,true) then
 begin
  ExDataEntryDlg:=TExDataEntryDlg.create(self);  {allocate dlg}
  ExDataEntryDlg.showmodal;
  ExDataEntryDlg.free;   {release dlg}
  CheckAccessRights(4,3,false)
 end;
end;

end.
