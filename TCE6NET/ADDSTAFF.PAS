unit Addstaff;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  TAddedstaffwin = class(TCodeWin)
    MainMenu1: TMainMenu;
    Codes1: TMenuItem;
    SelectCode1: TMenuItem;
    Teacher1: TMenuItem;
    Times1: TMenuItem;
    N5: TMenuItem;
    Add1: TMenuItem;
    Change1: TMenuItem;
    Delete1: TMenuItem;
    N4: TMenuItem;
    View1: TMenuItem;
    AddedStaff1: TMenuItem;
    AbsenceReason1: TMenuItem;
    CoverNote1: TMenuItem;
    PopupMenu1: TPopupMenu;
    add2: TMenuItem;
    Change2: TMenuItem;
    Delete2: TMenuItem;
    N6: TMenuItem;
    View2: TMenuItem;
    N7: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    CodeLengths1: TMenuItem;
    CodeLengths2: TMenuItem;
    EmailAddresses1: TMenuItem;
    EmailAddresses2: TMenuItem;
    Copy1: TMenuItem;
    popAddedStaffTimetable: TMenuItem;
    popAddedStaffAvailability: TMenuItem;
    mniAddedStaffAvailability: TMenuItem;
    mniAddedStaffTimetable: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Add1Click(Sender: TObject);
    procedure Change1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure View1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Teacher1Click(Sender: TObject);
    procedure AddedStaff1Click(Sender: TObject);
    procedure Times1Click(Sender: TObject);
    procedure AbsenceReason1Click(Sender: TObject);
    procedure CoverNote1Click(Sender: TObject);
    procedure CodeLengths1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure SelectCode1Click(Sender: TObject);
    procedure EmailAddresses1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DisplayTimetable(Sender: TObject);
    procedure ChangeAvailability(Sender: TObject);
  protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
    function MyCodePoint(i:integer): integer; override;
  end;

var
  Addedstaffwin: TAddedstaffwin;

procedure Addedstaffwinprint;
procedure AddedstaffwinOut;

implementation

uses
  tcommon,tcommon2,edadstff,deladstf,adadstff,main, tcommon3,viewas, printers,
  ascodlen, EdETmail, tcommon5, StaffTimetable, ASTFSLDG;

{$R *.DFM}

 type TPrintAddedStaffWin=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutAddedStaffWin=class(TOutCodeWin)
  public
   procedure head; override;
   function CodeToPrint(i:integer):string; override;
 end;

var
 PrintAddedStaffWin:    TPrintAddedStaffWin;
 OutAddedStaffWin:     TOutAddedStaffWin;

function TAddedstaffwin.MyCodePoint(i:integer): integer;
begin
 result:=Etpointer[i];
end;

procedure TAddedstaffwin.setTabs;
begin
 SetLength(Tabs,10);
 TotalCodes:=ETnum1;
 CodeWidth:=fwAddedStaffcode+blankWidth;
 CalcScreenCodeFit;
 headwidth:=canvas.textwidth('Added Staff Codes: 99  Sort: Name  Code length: 8 ');
 MaxTab(1,fwAddedStaffcode,'Code ');
 MaxTab(2,fwcode[1]+canvas.textwidth('*'),'Link ');
 MaxTab(3,fwAddedStaffname,'Name ');
 MaxTab(4,canvas.textwidth('W')*periods,'Load ');
 MaxTab(5,fwfaculty,'All faculties');
 Maxtab(6,fwfaculty,'All faculties');
 Maxtab(7,fwfaculty,'All faculties');
 Maxtab(8,fwfaculty,'All faculties');
 MaxTab(9,fwAddedComment,'Comment ');
 if winView[wnAddedStaff]=0 then maxW:=codeWidth*codefit
            else maxW:=Tabs[9];
 if winView[wnAddedStaff]=2 then
  begin {email addresses}
   MaxTab(2,fwAddedStaffname,'Name ');
   maxTab(3,fwETmail,'Email Addresses');
   maxtab(4,canvas.textwidth('9')*15,'Phone');
   MaxTab(5,canvas.textwidth('W')*14,'Availability ');
   MaxTab(6,canvas.TextWidth('9'),'Priority');
   maxW:=Tabs[6]+blankwidth;
  end;
 ReDoSelection;
end;

procedure TAddedstaffwin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
  if Assigned(FrmStaffTT) then
    FreeAndNil(FrmStaffTT);
end;

procedure TAddedstaffwin.PaintItem(i:integer;SelFlag:boolean);
var
 tmpstr: string;
 j,k:    integer;
begin
 k:=Etpointer[i];
 case winView[wnAddedStaff] of
   0: printw(etsub[k]);  {codes only}
   1: begin  {code + name}
       printw(etsub[k]);
       x:=Tabs[1];
       if ETlink[k]<>0 then
        begin
         printwl(tecode[abs(ETlink[k]),0]);
         if ETlink[k]<0 then printw('*');
        end;
       x:=Tabs[2]; printw(ETname[k]);
       x:=Tabs[3];
       if bool(ETavail[k]) then
         for j:=1 to tlimit[ttday] do
         begin
          tmpstr:='-';
          if bool(ETavail[k] and (1 shl j)) then
          begin
           tmpstr:='F';
           if (Eton[k] and (1 shl j))=0 then tmpstr:='C';
          end;
          printw(tmpstr);  inc(x,letterW);
         end; {for j}
       x:=Tabs[4];
       tmpstr := '';
       if ETfaculty[k]<0 then begin
         tmpstr:='All faculties';
       end else begin
         tmpstr:=facname[ETfaculty[k]];
       end;
       printw(tmpstr);

       x:=Tabs[5];
       if ETfaculty2[k]<0 then begin
         tmpstr:='All faculties';
       end else begin
         tmpstr:=facname[ETfaculty2[k]];
       end;
       printw(tmpstr);

       x:=Tabs[6];
       if ETfaculty3[k]<0 then begin
         tmpstr:='All faculties';
       end else begin
         tmpstr:=facname[ETfaculty3[k]];
       end;
       printw(tmpstr);

       x:=Tabs[7];
       if ETfaculty4[k]<0 then begin
         tmpstr:='All faculties';
       end else begin
         tmpstr:=facname[ETfaculty4[k]];
       end;
       printw(tmpstr);

{*
       x:=Tabs[5];
       tmpstr:='';
       if ETMon[k]=1 then begin
         printw('Mo');
       end;
       inc(x,letterW);inc(x,LetterW);
       if ETTue[k]=1 then begin
         printw('Tu');
       end;
       inc(x,letterw); inc(x,letterw);
       if ETWed[k]=1 then begin
         printw('We');
       end;
       inc(x,letterw); inc(x,letterw);
       if ETThu[k]=1 then begin
         printw('Th');
       end;
       inc(x,letterw); inc(x,letterw);
       if ETFri[k]=1 then begin
         printw('Fr');
       end;
       inc(x,letterw); inc(x,letterw);
       if ETSat[k]=1 then begin
         printw('Sa');
       end;
       inc(x,letterw); inc(x,letterw);
       if ETSun[k]=1 then begin
         printw('Su');
       end;
*}
       //printw(tmpstr);
       x:=Tabs[8]; printw(ETcomment[k]);
      end;
    2: begin   {email addresses}
      printw(etsub[k]);
      x:=Tabs[1]; printw(etname[k]);
      x:=Tabs[2]; printw(ETmail[k]);
      x:=Tabs[3]; printw(ETPhone[k]);

      x:=Tabs[4];
       tmpstr:='';
       if ETMon[k]=1 then begin
         printw('Mo');
       end;
       inc(x,letterW);inc(x,LetterW);
       if ETTue[k]=1 then begin
         printw('Tu');
       end;
       inc(x,letterw); inc(x,letterw);
       if ETWed[k]=1 then begin
         printw('We');
       end;
       inc(x,letterw); inc(x,letterw);
       if ETThu[k]=1 then begin
         printw('Th');
       end;
       inc(x,letterw); inc(x,letterw);
       if ETFri[k]=1 then begin
         printw('Fr');
       end;
       inc(x,letterw); inc(x,letterw);
       if ETSat[k]=1 then begin
         printw('Sa');
       end;
       inc(x,letterw); inc(x,letterw);
       if ETSun[k]=1 then begin
         printw('Su');
       end;

      x:=Tabs[5]; printw(inttostr(ETPriority[k]));
    end;
  end; {case}
 fcolor(codecolor);
end;

procedure TAddedstaffwin.PaintHead;
begin
 codecolor:=cpTeach;
 {Headings}
 printw2('Added Staff Codes: ',inttostr(TotalCodes));
 printw2('  Sort: ',sortname[assorttype]);
 printw2('  Code Length: ',inttostr(ETLencodes));
 newline;
 if TotalCodes>0 then
 begin
  fcolor(cpNormal);
  case winView[wnAddedStaff] of
   1:begin
      printw('Code');
      x:=Tabs[1];  printw('Link');
      x:=Tabs[2];  printw('Name');
      x:=Tabs[3];  printw('Load');
      x:=Tabs[4];  printw('Faculty');
      //x:=Tabs[5];  printw('Day of Wk');
      x:=Tabs[8];  printw('Comment');
      newline;
     end;
   2:begin  {email addresses}
      printwl('Code ');
      x:=Tabs[1]; printw('Name');
      x:=Tabs[2]; printw('Email Address');
      x:=Tabs[3]; printw('Phone');
      x:=Tabs[4]; printw('Available');
      x:=Tabs[5]; printw('Priority');
     end;
  end; {case}
  newline;
 end;
end;

procedure TAddedstaffwin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_insert then add1Click(self);
 if key=vk_Delete then delete1Click(self);
end;

procedure TAddedstaffwin.Add1Click(Sender: TObject);
begin
 if CheckAccessRights(4,2,true) then
 begin
  addaddedstaff:=Taddaddedstaff.create(self);   {allocate dlg}
  addaddedstaff.showmodal;
  addaddedstaff.free;               {release dlg}
  CheckAccessRights(4,2,false);
 end;
end;

procedure TAddedstaffwin.Change1Click(Sender: TObject);
begin
 if CheckAccessRights(4,2,true) then
 begin
  edaddedstaff:=Tedaddedstaff.create(self);   {allocate dlg}
  edaddedstaff.showmodal;
  edaddedstaff.free;               {release dlg}
  CheckAccessRights(4,2,false);
 end;
end;

procedure TAddedstaffwin.ChangeAvailability(Sender: TObject);
begin
  if CheckAccessRights(4, 9, True) then
  begin
    AddedStaffSelDlg := TAddedStaffSelDlg.Create(Application);
    try
      AddedStaffSelDlg.SelectedStaffCode := SelCode;
      AddedStaffSelDlg.IsDirect := True;
      AddedStaffSelDlg.ShowModal;
    finally
      FreeAndNil(AddedStaffSelDlg);
    end;
    CheckAccessRights(4, 9, False);
  end;
end;

procedure TAddedstaffwin.Delete1Click(Sender: TObject);
begin
 if CheckAccessRights(4,2,true) then
 begin
  deleteaddedstaff:=Tdeleteaddedstaff.create(self);   {allocate dlg}
  deleteaddedstaff.showmodal;
  deleteaddedstaff.free;               {release dlg}
  CheckAccessRights(4,2,false);
 end;
end;

procedure TAddedstaffwin.DisplayTimetable(Sender: TObject);
begin
  if not Assigned(FrmStaffTT) then
    FrmStaffTT := TFrmStaffTT.Create(Application);
  FrmStaffTT.SelectedTe := Etpointer[Addedstaffwin.selCode] + 1000;
  FrmStaffTT.IsCoverSouce := False;
  FrmStaffTT.RefreshTimetable;
  FrmStaffTT.Show;
end;

procedure TAddedstaffwin.View1Click(Sender: TObject);
begin
 viewaddedstaffdlg:=Tviewaddedstaffdlg.create(self);   {allocate dlg}
 viewaddedstaffdlg.showmodal;
 viewaddedstaffdlg.free;               {release dlg}
end;

procedure TAddedstaffwin.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnAddedStaff);
end;

procedure TAddedstaffwin.Teacher1Click(Sender: TObject);
begin
 TeWinSelect;
end;

procedure TAddedstaffwin.AddedStaff1Click(Sender: TObject);
begin
 AddedStaffWinSelect;
end;

procedure TAddedstaffwin.Times1Click(Sender: TObject);
begin
 TimesWinSelect;
end;

procedure TAddedstaffwin.AbsenceReason1Click(Sender: TObject);
begin
 absreasonswinselect;
end;

procedure TAddedstaffwin.CoverNote1Click(Sender: TObject);
begin
 covernoteswinselect;
end;

procedure TAddedstaffwin.FormResize(Sender: TObject);
begin
  Self.SetTabs;
  Refresh;
end;

{
---------- print procs follow ----------------
}


procedure TPrintAddedStaffWin.setTabs;
begin
 SetLength(PrntTabs,7);
 TotalCodes:=ETnum1;
 CodeWidth:=fwprntAddedStaffcode+prntblankwidth;
 CalcPrintCodeFit;
 MaxTab(1,fwprntAddedStaffcode,'Code ');
 MaxTab(2,fwprntcode[1]+PrintCanvas.textwidth('*'),'Link ');
 MaxTab(3,fwPrntAddedStaffname,'Name ');
 MaxTab(4,PrintCanvas.textwidth('W')*periods,'Load ');
 MaxTab(5,fwprntfaculty,'All faculties');
 MaxTab(6,fwprntAddedComment,'Comment ');
 if winView[wnAddedStaff]=2 then
  begin {email addresses}
   codefit:=1;
   MaxTab(2,fwPrntAddedStaffname,'Name ');
   maxTab(3,fwPrntETmail,'Email Addresses');
  end;
end;

procedure TPrintAddedStaffWin.head;
begin
 UnderlineOn;
 codeColor:=cpTeach;
 printw2('Added Staff Codes: ',inttostr(TotalCodes));
 printw2('  Sort: ',sortname[assorttype]);
 printw2('  Code Length: ',inttostr(ETLencodes));
 printw(PageCount);
 fcolor(cpNormal);
 x:=0; y:=y+prnttxtheight;
 case winView[wnAddedStaff] of
  1:begin
   printw('Code');
   x:=prntTabs[1];  printw('Link');
   x:=prntTabs[2];  printw('Name');
   x:=prntTabs[3];  printw('Load');
   x:=prntTabs[4];  printw('Faculty');
   x:=prntTabs[5];  printw('Comment');
   x:=0; y:=y+prnttxtheight;
  end;
  2: begin {email addresses}
       printwl('Code ');
       x:=prntTabs[1]; printw('Name');
       x:=prntTabs[2]; printw('Email Address');
       x:=0; y:=y+prnttxtheight;
      end;
 end; {case}
 fcolor(codecolor);
 UnderlineOff; x:=0; y:=y+prnttxtheight;
end;

procedure Addedstaffwinprint;
var
 i,j,k:        integer;
 tmpstr:        string;
begin   {start of main print}
 PrintAddedStaffWin:=TPrintAddedStaffWin.Create;
 with PrintAddedStaffWin do
  try
   PrintHead;
   if TotalCodes<=0 then exit;
   for i:=1 to TotalCodes do
    begin
     fcolor(codecolor);
     k:=etpointer[i];
     case winView[wnAddedStaff] of
      0: begin
          printw(etsub[k]);
          x:=(i mod codefit)*codeWidth;
          if (i mod codefit)=0 then newline;
         end;
      1: begin
          printw(etsub[k]);
          x:=prntTabs[1];
          if ETlink[k]<>0 then
           begin
            printwl(tecode[abs(ETlink[k]),0]);
            if ETlink[k]<0 then printw('*');
           end;
          x:=prntTabs[2]; printw(ETname[k]);
          x:=prntTabs[3];
          if bool(ETavail[k]) then
            for j:=1 to tlimit[ttday] do
             begin
              tmpstr:='-';
              if bool(ETavail[k] and (1 shl j)) then
              begin
               tmpstr:='F';
               if (Eton[k] and (1 shl j))=0 then tmpstr:='C';
              end;
              printw(tmpstr); inc(x,letterWprnt);
             end; {for j}
          x:=prntTabs[4];
          if ETfaculty[k]<0 then printw('All faculties')
            else printw(facname[ETfaculty[k]]);
          x:=prntTabs[5]; printw(ETcomment[k]);
          newline
         end;

      2: begin {email addresses}
          printw(etsub[k]);
          x:=prntTabs[1]; printw(etname[k]);
          x:=prntTabs[2]; printw(ETmail[k]);
          newline;
         end;
     end; {case}
   end;  {for i  to totalcodes}
   printCustomAddon;
  finally
   PrintAddedStaffWin.free;
  end;
end;

procedure TOutAddedStaffWin.head;
begin
 printLine(['Added Staff Codes: ',inttostr(TotalCodes),' Sort: ',sortname[assorttype],
  ' Code Length: ',inttostr(ETLencodes)]);
 newline;
 case winView[wnAddedStaff] of
  1:begin
   printLine(['Code','Link','Name','Load','Faculty','Comment']);
   newline;
  end;
  2: begin {email addresses}
       printLine(['Code ','Name','Email Address']);
       newline;
     end;
 end; {case}
 newline;
end;

function TOutAddedStaffWin.CodeToPrint(i:integer):string;
begin
 result:=etsub[etpointer[i]];
end;

procedure AddedstaffwinOut;
var
 i,j,k:        integer;
 tmpstr,s:        string;
begin   {start of main print}
 OutAddedStaffWin:=TOutAddedStaffWin.Create;
 with OutAddedStaffWin do
  try
   Setup(ETnum1);
   if TotalCodes<=0 then exit;
   for i:=1 to TotalCodes do
    begin
    k:=etpointer[i];
     case winView[wnAddedStaff] of
      0: PrintCode(i);
      1: begin
          printw(etsub[k]);
          s:='';
          if ETlink[k]<>0 then
           begin
            s:=tecode[abs(ETlink[k]),0];
            if ETlink[k]<0 then s:=s+'*';
           end;
          printc(s);
          printc(ETname[k]);
          s:='';
          if bool(ETavail[k]) then
            for j:=1 to tlimit[ttday] do
             begin
              tmpstr:='-';
              if bool(ETavail[k] and (1 shl j)) then
              begin
               tmpstr:='F';
               if (Eton[k] and (1 shl j))=0 then tmpstr:='C';
              end;
              s:=s+tmpstr;
             end; {for j}
          printc(s);
          if ETfaculty[k]<0 then printc('All faculties')
            else printc(facname[ETfaculty[k]]);
          printc(ETcomment[k]);
          newline;
         end;

      2: begin {email addresses}
          printw(etsub[k]);
          printc(etname[k]);
          printc(ETmail[k]);
          newline;
         end;
     end; {case}
   end;  {for i  to totalcodes}
   printCustomAddon;
  finally
   OutAddedStaffWin.free;
  end;
end;

procedure TAddedstaffwin.CodeLengths1Click(Sender: TObject);
begin
 if CheckAccessRights(4,2,true) then
 begin
  Etcodelengthdlg:=TEtcodelengthdlg.create(self);   {allocate dlg}
  Etcodelengthdlg.tag:=self.tag;
  Etcodelengthdlg.showmodal;
  Etcodelengthdlg.free;   {release dlg}
  CheckAccessRights(4,2,false);
 end;
end;

procedure TAddedstaffwin.FormDblClick(Sender: TObject);
begin
 doubleclick:=true;
 if ETnum1=0 then exit;
 case winView[wnAddedStaff] of
  0,1:Change1Click(Self);
    2:EmailAddresses1Click(Self);
 end;

end;

procedure TAddedstaffwin.SelectCode1Click(Sender: TObject);
begin
 TickCodeSubMenu(SelectCode1);
end;

procedure TAddedstaffwin.EmailAddresses1Click(Sender: TObject);
begin
 EdETemail:=TEdETemail.Create(self);  {allocate dlg}
 EdETemail.showmodal;
 EdETemail.free;   {release dlg}
end;

end.
