unit Adstfsel;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,ClassDefs,TCEglobals, GlobalToTcAndTcextra;

type
  Taddedstaffselwin = class(TSelectCodeWin)
    PopupMenu1: TPopupMenu;
    Change2: TMenuItem;
    N6: TMenuItem;
    View2: TMenuItem;
    N7: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    Copy1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Change2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure View2Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
    function ItemIsSelected(k:integer):boolean; override;
    function BasicPoint(k:integer):integer; override;
  end;

var
  addedstaffselwin: Taddedstaffselwin;

procedure addedstaffselwinprint;
procedure addedstaffselwinOut;

implementation
uses tcommon,tcommon2,main,tcommon3,astfsldg,viewasel,printers,tcommon5;
{$R *.DFM}

 type TPrintAddedSelWin=class(TPrintCodeWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;

 type TOutAddedSelWin=class(TOutCodeWin)
  public
   procedure head; override;
   function CodeToPrint(i:integer):string; override;
 end;

var
 PrintAddedSelWin:    TPrintAddedSelWin;
 OutAddedSelWin:      TOutAddedSelWin;

function Taddedstaffselwin.ItemIsSelected(k:integer):boolean;
begin
 result:=bool(ETavail[k]);
end;

function Taddedstaffselwin.BasicPoint(k:integer):integer;
begin
 result:=Etpointer2[k];
end;


procedure Taddedstaffselwin.SetTabs;
begin
 setlength(Tabs,8);
 ETselectedCount;
 MaxItemPoint:=ETnum1;  CalcItemPoint;
 headwidth:=canvas.textwidth('Added Staff Codes: 199  Selected: 99  Sort: '
          +sortname[asSelsorttype]+'  Code Length: 8');
 CodeWidth:=fwAddedStaffcode+blankWidth;
 CalcScreenCodeFit;
 MaxTab(1,fwAddedStaffcode,'Code ');
 MaxTab(2,fwcode[1]+canvas.textwidth('*'),'Link ');
 MaxTab(3,fwAddedStaffname,'Name ');
 MaxTab(4,canvas.textwidth('W')*periods,'Load ');
 MaxTab(5,fwfaculty,'All faculties');
 MaxTab(6,canvas.textwidth('W')*14,'Day of Wk ');
 MaxTab(7,fwAddedComment,'Comment ');
 if winView[wnAddedSel]=0 then maxW:=codeWidth*codefit
            else maxW:=Tabs[7];
end;

procedure Taddedstaffselwin.PaintHead;
begin
 codeColor:=cpTeach; {teacher} codeColor2:=cpAbsentSel; {red on white}
 {Headings}
 fcolor(cpNormal);
 printw2('Added Staff Codes: ',inttostr(ETnum1));
   printw2('  Selected: ',inttostr(ETselected));
   printw2('  Sort: ',sortname[asSelsorttype]);
   printw2('  Code Length: ',inttostr(ETLencodes));

 newline;
 if TotalCodes>0 then
  if winView[wnAddedSel]>=1 then
   begin
     fcolor(cpNormal); printw('Code');
     x:=Tabs[1];  printw('Link');
     x:=Tabs[2];  printw('Name');
     x:=Tabs[3];  printw('Load');
     x:=Tabs[4];  printw('Faculty');
     x:=Tabs[5];  printw('Day of Wk');
     x:=Tabs[6];  printw('Comment');
     newline;
   end;
end;

procedure Taddedstaffselwin.PaintItem(i:integer;SelFlag:boolean);
var
 k,j:    integer;
 tmpstr: string;
begin
 k:=ItemPoint[i];
 case winView[wnAddedSel] of
   0: printw(etsub[k]);  {codes only}
   1,2: begin  {code + name}
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
       if ETfaculty[k]<0 then printw('All faculties')
        else printw(facname[ETfaculty[k]]);
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
      //printw(tmpstr);

       x:=Tabs[6]; printw(ETcomment[k]);
      end;
  end; {case}
 fcolor(codecolor);
end;

procedure Taddedstaffselwin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:= caFree;
end;

procedure Taddedstaffselwin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_insert then addedstaffselwin.Change2Click(self);
end;

procedure Taddedstaffselwin.FormResize(Sender: TObject);
begin
  Self.SetTabs;
  Refresh;
end;

procedure Taddedstaffselwin.Change2Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  addedstaffseldlg:=Taddedstaffseldlg.create(self);   {allocate dlg}
  addedstaffseldlg.showmodal;
  addedstaffseldlg.free;               {release dlg}
  CheckAccessRights(4,9,false);
 end;  
end;

procedure Taddedstaffselwin.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnAddedSel);
end;


procedure Taddedstaffselwin.View2Click(Sender: TObject);
var
  sel:integer;
begin
 if selCode>0 then selCode2:=itemPoint[selCode];
 viewaseldlg:=Tviewaseldlg.create(self);   {allocate dlg}
 viewaseldlg.Show.ItemIndex:=winView[wnAddedSel];
 if asSelSortType > 4 then begin
     Sel := asSelSortType - 5;
     viewaseldlg.chkPriority.Checked := True;
 end else begin
     Sel := asSelSortType;
     viewaseldlg.chkPriority.checked := False;
 end;
 viewaseldlg.Sort.ItemIndex:=Sel;
 viewaseldlg.showmodal;
 viewaseldlg.free;               {release dlg}
end;

{
----------------- print procs follow -------------
}

procedure TPrintAddedSelWin.setTabs;
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
end;




procedure TPrintAddedSelWin.head;
begin
 UnderlineOn;
 codeColor:=cpTeach;
 printw2('Added Staff Codes: ',inttostr(TotalCodes));
 printw2('  Selected: ',inttostr(ETselected));
 printw2('  Sort: ',sortname[asSelsorttype]);
 printw2('  Code Length: ',inttostr(ETLencodes));
 printw(PageCount);
 fcolor(cpNormal);
 x:=0; y:=y+prnttxtheight;
 if (winView[wnAddedSel]>=1) then
  begin
   printw('Code');
   x:=prntTabs[1];  printw('Link');
   x:=prntTabs[2];  printw('Name');
   x:=prntTabs[3];  printw('Load');
   x:=prntTabs[4];  printw('Faculty');
   x:=prntTabs[5];  printw('Comment');
   x:=0; y:=y+prnttxtheight;
  end;
 fcolor(codecolor);
 UnderlineOff;
end;


procedure addedstaffselwinprint;
var
 tmpstr:            string;
 i,j,k,codeColor2: integer;

begin
 codeColor2:=cpAbsentSel;
 PrintAddedSelWin:=TPrintAddedSelWin.Create;
 with PrintAddedSelWin do
  try
   PrintHead;
   if TotalCodes<=0 then exit;
   for i:=1 to TotalCodes do
    begin
     k:=etpointer2[i];
     if bool(ETavail[k]) then fcolor(codecolor2) else fcolor(codecolor);
     if (winView[wnAddedSel]=2) and  not(bool(ETavail[k])) then continue;
     case winView[wnAddedSel] of
      0: begin
          printw(etsub[k]);
          x:=(i mod codefit)*codeWidth;
          if (i mod codefit)=0 then newline;
         end;
      1,2: begin
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
     end; {case}
   end;  {for i  to totalcodes}
   newline;
   printCustomAddon;
  finally
   PrintAddedSelWin.free;
  end;
end;

procedure TOutAddedSelWin.head;
begin
 printLine(['Added Staff Codes: ',inttostr(TotalCodes),'Selected:',inttostr(ETselected),
   'Sort:',sortname[asSelsorttype],'Code Length:',inttostr(ETLencodes)]);
 if (winView[wnAddedSel]>=1) then
   printLine(['Code','Link','Name','Load','Faculty','Comment']);
end;

function TOutAddedSelWin.CodeToPrint(i:integer):string;
begin
 result:=etsub[etpointer2[i]];
end;

procedure addedstaffselwinOut;
var
 tmpstr,s:            string;
 i,j,k: integer;
begin
 OutAddedSelWin:=TOutAddedSelWin.Create;
 with OutAddedSelWin do
  try
   Setup(ETnum1);
   if TotalCodes<=0 then exit;
   for i:=1 to TotalCodes do
    begin
     k:=etpointer2[i];
     if (winView[wnAddedSel]=2) and  not(bool(ETavail[k])) then continue;
     case winView[wnAddedSel] of
      0: PrintCode(i);
      1,2: begin
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
     end; {case}
   end;  {for i  to totalcodes}
   newline;
   printCustomAddon;
  finally
   OutAddedSelWin.free;
  end;
end;

procedure Taddedstaffselwin.FormDblClick(Sender: TObject);
begin
 doubleclick:=true;
 addedstaffselwin.Change2Click(self);
end;

end.
