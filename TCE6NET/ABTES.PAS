unit Abtes;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, ppDB, ppDBJIT, ppParameter,
  ppBands, ppCtrls, ppVar, ppPrnabl, ppClass, ppCache, ppComm, ppRelatv, ppProd,
  ppReport, uAMGCommon, ppStrtch, ppMemo, GlobalToTcAndTcextra;

type
  TAbsentte = class(TSelectCodeWin)
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N6: TMenuItem;
    View2: TMenuItem;
    N7: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    Copy1: TMenuItem;
    repAbsentTeachers: TppReport;
    ppHeaderBand1: TppHeaderBand;
    lblSchoolName: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLine1: TppLine;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel5: TppLabel;
    imgSchoolLogo: TppImage;
    ppLine2: TppLine;
    ppShape1: TppShape;
    ppShape2: TppShape;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppLine3: TppLine;
    ppShape3: TppShape;
    ppShape4: TppShape;
    ppFooterBand1: TppFooterBand;
    ppParameterList1: TppParameterList;
    pipAbsentTeachers: TppJITPipeline;
    ppJITAbsenceDate: TppField;
    ppJITAbsence: TppField;
    ppJITAbsenceReason: TppField;
    ppJITTeacherName: TppField;
    popAbsenceHistory: TMenuItem;
    ppMemo1: TppMemo;
    ppSystemVariable2: TppSystemVariable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Change2Click(Sender: TObject);
    procedure View1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDblClick(Sender: TObject);
    procedure DisplayAbsenceHistory(Sender: TObject);
    function PopulateFieldData(aFieldName: string): Variant;
    procedure repAbsentTeachersBeforePrint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
    function ItemIsSelected(k:integer):boolean; override;
    function BasicPoint(k:integer):integer; override;
  private
    procedure PrintAbsentTeachers(const pOutputType: TOutputType);
    function GetFieldValue(pRecIndex: Integer; const pFieldName: string): Variant;
    function GetReasonByCode(const pReasonCode: string): string;
  end;

var
  Absentte: TAbsentte;


procedure Absentteprint;
procedure AbsentteOut;

implementation

uses
  tcommon,tcommon2,edabtes,viewabte,main,printers, tcommon3, tcommon5, uAMGTeacherAbsence;

{$R *.DFM}
const
 mycode=1;

 type TPrintAbsentTeWin=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutAbsentTeWin=class(TOutCodeWin)
  public
   procedure head; override;
   function CodeToPrint(i:integer):string; override;
 end;

var
 PrintAbsentTeWin:    TPrintAbsentTeWin;
 OutAbsentTeWin:     TOutAbsentTeWin;

procedure TAbsentte.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TAbsentte.FormCreate(Sender: TObject);
begin
 doubleclick:=false;
 setWindowDefaults(self,wnAbsentTe);
end;

procedure TAbsentte.Change2Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  EditAbsTeacherss:=TEditAbsTeacherss.create(self);   {allocate dlg}
  EditAbsTeacherss.showmodal;
  EditAbsTeacherss.free;
  CheckAccessRights(4,9,false);
 end;
end;

procedure TAbsentte.DisplayAbsenceHistory(Sender: TObject);
begin
  PrintAbsentTeachers(otScreen);
end;

function TAbsentte.ItemIsSelected(k:integer):boolean;
begin
 result:=(teAbsent[k]<>-1);
end;

function TAbsentte.BasicPoint(k:integer):integer;
begin
 result:=abcodepoint[k];
end;

procedure TAbsentte.SetTabs;
begin
 setlength(Tabs,6);
 MaxItemPoint:=codenum[mycode];
 CalcItemPoint;
 headwidth:=canvas.textwidth('Absent Teachers: 99    Team teaching excluded');
 CodeWidth:=fwCode[mycode]+blankWidth;
 CalcScreenCodeFit;

 maxTab(1,Codewidth,'Code');
 maxTab(2,fwCodename[mycode],'Name ');
 case winView[wnAbsentTe] of
   0: maxW:=CodeWidth*CodeFit;  {codes}
  1,2: begin  {code + name}
        maxTab(3,periods*canvas.textwidth('W'),'Timeslot Codes');
        maxTab(4,fwTeComment,'Comment');
        maxTab(5,fwabsence,'Reason');
        maxW:=Tabs[5];
       end;
 end; {case}
end;

procedure TAbsentte.PaintHead;
begin
 codeColor:=cpTeach; {teacher} codeColor2:=cpAbsentSel; {red on white}
 {Headings}
 fcolor(cpNormal);
 printw2('Absent Teachers: ',inttostr(countAbsTes));
 if teamexclude then printw('    Team teaching excluded')
     else printw('    Team teaching included');
 newline;
 if TotalCodes>0 then
  if winView[wnAbsentTe]>=1 then
   begin
    fcolor(cpNormal);  printw('Code ');
    x:=Tabs[1]; printw('Name');
    x:=Tabs[2]; printw('Timeslot Codes');
    x:=Tabs[3]; printw('Comment');
    x:=Tabs[4]; printw('Reason');
    newline;
   end;
end;

procedure TAbsentte.PaintItem(i:integer;SelFlag:boolean);
var
 k:    integer;
begin
 k:=ItemPoint[i];
 case winView[wnAbsentTe] of
   0: printw(tecode[k,0]);  {codes only}
   1,2: begin  {code + name}
         printw(tecode[k,0]);
         x:=Tabs[1]; printw(tename[k,0]);
         x:=Tabs[2]; printMap(temap[k]);
         x:=Tabs[3];  printw(Ecomment[k]);
         if tabsreason[k]>0 then
          begin
           x:=Tabs[4];
           printw(Abcode[tabsreason[k]]+' '+Absent[tabsreason[k]]);
          end;
      end;
  end;
 fcolor(codecolor);
end;

function TAbsentte.PopulateFieldData(aFieldName: string): Variant;
begin
  Result := GetFieldValue(pipAbsentTeachers.RecordIndex, aFieldName);
end;

procedure TAbsentte.PrintAbsentTeachers(const pOutputType: TOutputType);
begin
  pipAbsentTeachers.InitialIndex := 1;
  pipAbsentTeachers.RecordCount := TeacherAbsences.Count;
  lblSchoolName.Caption := School;
  repAbsentTeachers.DeviceType := GetDeviceType(pOutputType);
  repAbsentTeachers.Print;
end;

procedure TAbsentte.repAbsentTeachersBeforePrint(Sender: TObject);
begin
  pipAbsentTeachers.Fields[0].Sortable := True;
  pipAbsentTeachers.Fields[0].Sort := True;
end;

procedure TAbsentte.View1Click(Sender: TObject);
begin
  if selCode>0 then selCode2:=itemPoint[selCode];
  ViewAbTeDlg:=TViewAbTeDlg.create(self);   {allocate dlg}
  ViewAbTeDlg.Show.ItemIndex:=winView[wnAbsentTe];
  ViewAbTeDlg.Sort.ItemIndex:=absorttype;
  ViewAbTeDlg.showmodal;
  ViewAbTeDlg.free;
end;

procedure TAbsentte.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_insert then Change2Click(self);
end;

procedure TAbsentte.FormResize(Sender: TObject);
begin
  Self.SetTabs;
  Refresh;
end;

function TAbsentte.GetFieldValue(pRecIndex: Integer; const pFieldName: string): Variant;
var
  i: Integer;
  lAbsence: string;
  lAbsWithSpace: string;
  lAbsenceLen: Integer;
  lPos: Integer;
  lTeacherAbsence: TAMGTeacherAbsence;
begin
  lTeacherAbsence := TAMGTeacherAbsence(TeacherAbsences.Items[PRecIndex -1]);
  if pFieldName = 'fldTeacherName' then
    Result := lTeacherAbsence.TeacherName + ' (' + lTeacherAbsence.TeacherCode + ')'
  else if pFieldName = 'fldAbsenceDate' then
    Result := lTeacherAbsence.AbsenceDateStr
  else if pFieldName = 'fldAbsence' then
  begin
    lAbsence := lTeacherAbsence.Absence;
    lAbsenceLen := Length(lAbsence);
    lAbsWithSpace := '';
    for i := 0 to lAbsenceLen - 1 do
    begin
      lPos := i + 1;
      lAbsWithSpace := lAbsWithSpace + Copy(lAbsence, lPos, 1) + ' ';
    end;

    Result := lAbsWithSpace;
  end
  else if pFieldName = 'fldAbsenceReason' then
    Result := lTeacherAbsence.AbsenceReasonCode;
end;

function TAbsentte.GetReasonByCode(const pReasonCode: string): string;
var
  i: Integer;
begin
  for i := 1 to nmbrReasons do
  begin
    if pReasonCode = Abcode[i] then
    begin
      Result := Absent[i];
      Break;
    end;
  end;
end;

{
------------------- print procs follow -------------------
}

procedure TPrintAbsentTeWin.SetTabs;
begin   {start of setprntTabs}
 setlength(PrntTabs,6);
 TotalCodes:=codenum[mycode];
 CodeWidth:=fwPrntCode[mycode]+prntBlankwidth;
 maxTab(1,Codewidth,'Code');
 maxTab(2,fwPrntCodename[mycode],'Name ');
 case winView[wnAbsentTe] of
 0: CalcPrintCodeFit;  {codes}
 1,2: begin  {code + name}
        maxTab(3,periods*PrintCanvas.textwidth('W'),'Timeslot Codes');
        maxTab(4,fwPrntTeComment,'Comment');
        maxTab(5,fwPrntabsence,'Reason');
       end;
 end; {case}
end;

procedure TPrintAbsentTeWin.head;
begin
 codeColor:=cpTeach; {teacher}
 fcolor(cpNormal);
 UnderlineOn;
 printw2('Absent Teachers: ',inttostr(countAbsTes));
 if teamexclude then printwl('    Team teaching excluded')
     else printwl('    Team teaching included');
 printw(PageCount);
 UnderlineOff;
 x:=0; y:=y+PrnttxtHeight;
 fcolor(cpNormal);
 if TotalCodes>0 then
  if winView[wnAbsentTe]>=1 then
   begin
    printw('Code ');
    x:=prntTabs[1]; printw('Name');
    x:=prntTabs[2]; printw('Timeslot Codes');
    x:=prntTabs[3]; printw('Comment');
    x:=prntTabs[4]; printw('Reason');
    x:=0; y:=y+PrnttxtHeight;;
   end;
end;

procedure Absentteprint;
var
 i,k: integer;
 codeColor2: smallint;
begin
 codeColor2:=cpAbsentSel;
 PrintAbsentTeWin:=TPrintAbsentTeWin.Create;
 with PrintAbsentTeWin do
  try
   PrintHead;
   code:=1;
   if TotalCodes>0 then
   for i:=1 to TotalCodes do
    begin
     k:=abcodepoint[i];
     if teAbsent[k]=-1 then fcolor(codecolor) else fcolor(CodeColor2);
     if winView[wnAbsentTe]=2 then  {only show absent ones}
        if teAbsent[k]=-1 then continue;
     case winView[wnAbsentTe] of
      0: begin
          printw(tecode[k,0]);
          x:=(i mod codefit)*CodeWidth;
          if (i mod codefit)=0 then newline;
         end;
      1,2: begin  {code + name}
            printw(tecode[k,0]);
            x:=prntTabs[1]; printw(tename[k,0]);
            x:=prntTabs[2]; printMap(temap[k]);
            x:=prntTabs[3];  printw(Ecomment[k]);
            if tabsreason[k]>0 then
             begin
              x:=prntTabs[4];
              printw(Abcode[tabsreason[k]]+' '+Absent[tabsreason[k]]);
             end;
            newline;
           end;
     end;  {case}
    end;  {for i  to totalcodes}
   newline;
   printCustomAddon;
  finally; {with PrintAbsentTeWin}
   PrintAbsentTeWin.Free;
  end;
end;

procedure TOutAbsentTeWin.head;
begin
 printw('Absent Teachers: ');
 printc(inttostr(countAbsTes));
 if teamexclude then printc(' Team teaching excluded')
     else printc(' Team teaching included');
 newline;
 if TotalCodes>0 then
  if winView[wnAbsentTe]>=1 then
    printLine(['Code','Name','Timeslot Codes','Comment','Reason']);
end;

function TOutAbsentTeWin.CodeToPrint(i:integer):string;
begin
 result:=tecode[abcodepoint[i],0];
end;

procedure AbsentteOut;
var
 i,k: integer;
begin
 OutAbsentTeWin:=TOutAbsentTeWin.Create;
 with OutAbsentTeWin do
  try
   Setup(codenum[mycode]);
   if TotalCodes>0 then
   for i:=1 to TotalCodes do
    begin
     k:=abcodepoint[i];
     if winView[wnAbsentTe]=2 then  {only show absent ones}
        if teAbsent[k]=-1 then continue;
     case winView[wnAbsentTe] of
      0: PrintCode(i);
      1,2: begin  {code + name}
            printw(tecode[k,0]);
            printc(tename[k,0]);
            printc(temap[k]);
            printc(Ecomment[k]);
            if tabsreason[k]>0 then
              printc(Abcode[tabsreason[k]]+' '+Absent[tabsreason[k]])
             else printc('');
            newline;
           end;
     end;  {case}
    end;  {for i  to totalcodes}
   newline;
   printCustomAddon;
  finally; {with OutAbsentTeWin}
   OutAbsentTeWin.Free;
  end;
end;

procedure TAbsentte.FormDblClick(Sender: TObject);
begin
 doubleclick:=true;
 Absentte.Change2Click(self);
end;

end.
