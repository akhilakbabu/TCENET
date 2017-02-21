unit Mancover;

interface                                               

uses SysUtils,WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs,TCEglobals, GlobalToTcAndTcextra;

type
  TManCoverDlg = class(TForm)
    HelpBtn: TBitBtn;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Finish: TBitBtn;
    CoverBtn: TBitBtn;
    Image1: TImage;
    previous: TBitBtn;
    next: TBitBtn;
    Label4: TLabel;
    IgnoreBtn: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    ComboBox2: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure nextClick(Sender: TObject);
    procedure previousClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X1, Y1: Integer);
    procedure CoverBtnClick(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure IgnoreBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShowHideTimetable(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    x,y: integer;
    SelBox,NewRect: Trect;
    codecolor:  integer;
    procedure SetKindList(te: integer);
    procedure ShowItem(j: integer);
    procedure ShowFreeStaff;
    procedure fcolor(fcol:integer);
    procedure printw(a:string);
    procedure printMap(ss: string);
    procedure HighlightBox(myrect:Trect);
    function SetRect(j: integer):Trect;
    procedure CalcItemPosition(j:integer);
    procedure ShowRoomItem(j: integer);
    procedure DisplayTeacherTT(const pTeachNo: Integer);
    procedure HideTeacherTT;
    procedure GetSolution;
    procedure ResetDlg;
    procedure EnterSolution;
    procedure AddComboBoxItem(const itemStr: string);
    function GetItemIndex(const itemStr: string): integer;
  public
    { Public declarations }
  end;

  type
    TCoverNote = class
      Value: string;
      Display: string;
    end;

var
  ManCoverDlg: TManCoverDlg;

const
  MAX_DISPLAY = 40;

implementation

{$R *.DFM}
uses
  tcommon,excover,tcommon2,tcommon3,manteach,teshow,roshow, StaffTimetable;

var
 autoselect:  integer;  {positions in groupnum}
 CoverType: array[0..10] of integer;
 Bitmap1:     Tbitmap;
 xtab:        array[0..12] of integer;
 Ncols,subwidth:   integer;
 Hmargin,txtheight:  integer;
 doubleclick:          boolean;
 MyletterW:              integer;
 firstshow:        bool;

procedure TManCoverDlg.FormCreate(Sender: TObject);
var
 j,maxtab,curtab,blankwidth: integer;
begin
 Bitmap1:=Tbitmap.Create;
 Bitmap1.canvas.brush.color:=clWhite;
 Hmargin:=self.canvas.textwidth('A');
 blankwidth := Self.Canvas.textwidth('       ');
 txtHeight:=self.canvas.textheight('Ag');
 image1.canvas.font:=self.canvas.font;
 doubleclick:=false;  autoselect:=0;
 checkbox1.checked:=ShowCoverTimetable;
 wnFlag[wnTeShow]:=false; wnFlag[wnRoShow]:=false; firstshow:=true;
 combobox1.clear;
 if nmbrCoverInUse>0 then
  for j:=1 to nmbrCoverInUse do
   if Cover[j]>'' then if combobox1.items.IndexOf(Cover[j])=-1 then
      // combobox1.items.add(Cover[j]);
      AddComboBoxItem(Cover[j]);
 if notenum>0 then
  for j:=1 to notenum do
   if ExNote[j]>'' then if combobox1.items.IndexOf(ExNote[j])=-1 then
      // combobox1.items.add(ExNote[j]);
      AddComboBoxItem(ExNote[j]);
 {calculate tabs}
 maxTab:=0;
 for j:=1 to NumCodes[2] do
 begin
  curTab:=self.canvas.textwidth(Trim(Tecode[j,1]));
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 xtab[0]:=maxTab; {room codes}
 subwidth:=maxTab+self.canvas.textwidth('  ');
 xtab[1]:=Hmargin;
 maxTab:=0;
 for j:=1 to NumCodes[1] do
 begin
  curTab:=self.canvas.textwidth(Trim(Tecode[j,0]));
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 if ETnum>0 then for j:=1 to ETnum do
 begin
  curTab:=self.canvas.textwidth(Trim(etsub[j]));
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 curTab:=self.canvas.textwidth('Code');
 if (curTab>maxTab) then maxTab:=curTab;
 xtab[2]:=xtab[1]+maxTab+blankwidth;
 maxTab:=0;
 for j:=1 to 12 do
 begin
  curTab:=self.canvas.textwidth(month[j]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 maxTab:=self.canvas.textwidth('99 ')+maxTab;
 curTab:=self.canvas.textwidth('Last');
 if (curTab>maxTab) then maxTab:=curTab;
 curTab:=self.canvas.textwidth('TODAY');
 if (curTab>maxTab) then maxTab:=curTab;
 xtab[3]:=xtab[2]+maxTab+blankwidth;
 maxTab:=self.canvas.textwidth('99');
 curTab:=self.canvas.textwidth('Load');
 if (curTab>maxTab) then maxTab:=curTab;
 xtab[4]:=xtab[3]+maxTab+blankwidth;
 maxTab:=self.canvas.textwidth('99/99');
 curTab:=self.canvas.textwidth('Extras');
 if (curTab>maxTab) then maxTab:=curTab;
 xtab[5]:=xtab[4]+maxTab+blankwidth;
 maxTab:=self.canvas.textwidth('00 ');
 curTab:=self.canvas.textwidth('W   ');
 if (curTab>maxTab) then maxTab:=curTab;
 xtab[6]:=xtab[5]+maxTab;
 xtab[7]:=xtab[6]+self.canvas.textwidth('P   ');
 xtab[8]:=xtab[7]+self.canvas.textwidth('F   ');
 xtab[9]:=xtab[8]+self.canvas.textwidth('S   ');
 maxTab:=self.canvas.textwidth('Status');
 curTab:=self.canvas.textwidth('Added');
 if (curTab>maxTab) then maxTab:=curTab;
 curTab:=self.canvas.textwidth('Replace');
 if (curTab>maxTab) then maxTab:=curTab;
 curTab:=self.canvas.textwidth('In Lieu');
 if (curTab>maxTab) then maxTab:=curTab;
 curTab:=self.canvas.textwidth('0000000000');
 if (curTab>maxTab) then maxTab:=curTab;
 xtab[10]:=xtab[9]+maxTab+blankwidth;
 MyletterW:=self.canvas.textwidth('T');  {for mapping allignments, AA-aa-L etc.}
 j:=self.canvas.textwidth('L'); if j>MyletterW then MyletterW:=j;
 j:=self.canvas.textwidth('C'); if j>MyletterW then MyletterW:=j;
 j:=self.canvas.textwidth('S'); if j>MyletterW then MyletterW:=j;
 j:=self.canvas.textwidth('U'); if j>MyletterW then MyletterW:=j;
 j:=self.canvas.textwidth('N'); if j>MyletterW then MyletterW:=j;
 j:=self.canvas.textwidth('R'); if j>MyletterW then MyletterW:=j;
 j:=self.canvas.textwidth('I'); if j>MyletterW then MyletterW:=j;
 j:=self.canvas.textwidth('A'); if j>MyletterW then MyletterW:=j;
 maxTab:=Tlimit[ttday]*MyletterW;
 curTab:=self.canvas.textwidth('Map');
 if (curTab>maxTab) then maxTab:=curTab;
 xtab[11]:=xtab[10]+maxTab+blankwidth;
 maxTab:=self.canvas.textwidth('Comment');
 for j:=1 to NumCodes[1] do
 begin
  curTab:=self.canvas.textwidth(Ecomment[j]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 if ETnum>0 then for j:=1 to ETnum do
 begin
  curTab:=self.canvas.textwidth(Etcomment[j]);
  if (curTab>maxTab) then maxTab:=curTab;
 end;
 xtab[12]:=xtab[11]+maxTab+blankwidth;
 maxTab:=Hmargin+self.canvas.textwidth('W-weekly extras  P-preferred time  F-same faculty  S-spare');
 if maxTab>xtab[12] then xtab[12]:=maxTab;
end;

procedure hidetimetable;
begin
 if wnFlag[wnTeShow] and Assigned(TeShowWin) then TeShowWin.close;
 if wnFlag[wnRoShow] and Assigned(RoShowWin) then RoShowWin.close;
 wnFlag[wnTeShow]:=false; wnFlag[wnRoShow]:=false;
end;

procedure RoShowWinSelect;
begin
 RoShowWin:=tRoShowWin.create(application);
end;

procedure Showtimetable(te: integer);
begin
 if ShowCoverTimetable then
  begin {show appropriate timetable}
   if DoingTeacherCover then {show teacher timetable, hide room timetable}
    begin
     if wnFlag[wnRoShow] then RoShowWin.close;
     wnFlag[wnRoShow]:=false;
     if (te>0) then
      begin
       teshownum:=te;  {selection}
       if not(wnFlag[wnTeShow]) then TeShowWinSelect;
       TeShowWin.repaint;
       wnFlag[wnTeShow]:=true;
      end;
    end
   else
    begin {show room timetable}
     if wnFlag[wnTeShow] and Assigned(TeShowWin) then
       TeShowWin.Close;
     wnFlag[wnTeShow] := False;
     if (te>0) then
      begin
       roshownum:=te;  {selection}
       if not(wnFlag[wnRoShow]) then RoShowWinSelect;
       RoShowWin.repaint;
       wnFlag[wnRoShow]:=true;
      end;
    end;
  end
 else
  Hidetimetable;
end;

procedure SetImageSize(maxH,maxW: integer);
begin
 Bitmap1.width:= maxW;
 Bitmap1.height:=maxH;
 ManCoverDlg.image1.Picture.Graphic:=Bitmap1;
 ManCoverDlg.image1.canvas.pen.color:=clBlack;
// ManCoverDlg.image1.Canvas.FloodFill(0,0,clWhite,fsBorder);
 ManCoverDlg.image1.canvas.font:=ManCoverDlg.canvas.font;
 ManCoverDlg.scrollbox1.VertScrollbar.Range:=maxH;
 ManCoverDlg.scrollbox1.HorzScrollbar.Range:=maxW;
end;

procedure TManCoverDlg.fcolor(fcol:integer);
begin
 Image1.canvas.font.color:=FontColorPair[fcol,1];
 Image1.canvas.brush.color:=FontColorPair[fcol,2];
end;

procedure TManCoverDlg.printw(a:string);
begin
 Image1.canvas.textout(x,y,a);
end;

procedure TManCoverDlg.printMap(ss: string);
var
 i,j,oldCol,oldBack:  integer;
 myRect:                      trect;
begin
 oldCol:=Image1.canvas.font.color;
 oldBack:=Image1.canvas.brush.color;
 for i:=1 to tlimit[ttday] do
  begin
   case ss[i] of
    'T','t': j:=cpNormal;
    'L','l': j:=cpLost;
    'C','c','I','i': j:=cpCover;
    'S','s','R','r': j:=cpSwap;
    'U','u','N','n','A','a': j:=cpAbsent;
    else j:=cpNormal;
   end; {case}
  if i=P then j:=cpTimeSel;
  fcolor(j);
  myRect.top:=y; myRect.bottom:=y+TxtHeight;
  myRect.left:=x;
  myRect.right:=x+MyletterW;
  fillrect(Image1.canvas.handle,myRect,Image1.canvas.brush.handle);
  printw(ss[i]);  inc(x,MyletterW);
 end; {for i}
 Image1.canvas.font.color:=oldCol;
 Image1.canvas.brush.color:=oldBack;
end;

procedure TManCoverDlg.HideTeacherTT;
begin
  if Assigned(FrmStaffTT) then
    FrmStaffTT.Hide;
end;

procedure TManCoverDlg.HighlightBox(myrect:Trect);
begin
 SelBox:=myrect;
 Image1.canvas.font.color:=FontColorHiLitePair[codeColor,1];
 Image1.canvas.brush.color:=FontColorHiLitePair[codeColor,2];
 Image1.canvas.fillrect(selbox);
end;

function TManCoverDlg.SetRect(j: integer):Trect;
begin
 result.Top:=txtHeight*(2+j)+1;
 result.bottom:=result.top+txtHeight;
 result.left:=2;
 result.right:= scrollbox1.HorzScrollbar.Range;
end;

procedure TManCoverDlg.ShowRoomItem(j: integer);
var
 k: integer;
begin
 CalcItemPosition(j);
 k:=tepoint[j];
 printw(tecode[k,1]);
end;

procedure TManCoverDlg.ShowItem(j: integer);
var
 k,k2,j2,alreadyOn: integer;
 astr,bstr:                    string;
 spare: bool;
begin
 alreadyOn:=0;
 if Changes[myI].kind<>1 then alreadyOn:=Changes[myI].newte;
    // Mantis 821-1
    k:=tepoint[j];  y:=(2+j)*txtHeight; x:=Hmargin;
 //k:=tepoint[j];  y:=(3+j)*txtHeight; x:=Hmargin;
 if k>=1000 then {added staff}
  begin
   k2:=k-1000;
   printw(etsub[k2]);
   x:=xtab[3]; str(Ettaught[k2]:2:0,astr); printw(astr);
   x:=xtab[4]; str(Etmax[k2]:2:0,bstr); printw(astr+'/'+bstr);
   x:=xtab[7]; if (ETfaculty[k2]=facultyIn) and (facultyIn>0) then printw('*');
   x:=xtab[9]; printw('Added');
   x:=xtab[10];
   bstr:='';
   for j2:=1 to tlimit[ttday] do
    begin
     astr:='-';
     if bool(ETavail[k2] and (1 shl j2)) then
      begin
       astr:='F';
       if (Eton[k2] and (1 shl j2))=0 then astr:='C';
      end;
      bstr:=bstr+astr;
    end; {for j2}
   printmap(bstr);
   x:=xtab[11]; printw(Etcomment[k2]);
  end
 else  {not added staff}
  begin
   printw(tecode[k,0]);
   x:=xtab[3]; str(teload[k]:2:0,astr); printw(astr);
   x:=xtab[6]; if ((prefer[k] and (1 shl p))<>0) then printw('*');
   x:=xtab[7];
   if (facultyIn>0) and ( (Tfaculty[k,1]=facultyIn) or (Tfaculty[k,2]=facultyIn)
     or (Tfaculty[k,3]=facultyIn) or (Tfaculty[k,4]=facultyIn)) then printw('*');
   spare:=false;
   if p>1 then
      if ((teon[k] and teabsent[k] and (1 shl (p-1)))<>0) then spare:=true;
   if p<Tlimit[ttday] then
      if ((teon[k] and teabsent[k] and (1 shl (p+1)))<>0) then spare:=true;
   x:=xtab[8]; if spare then printw('*');
   x:=xtab[10]; printmap(temap[k]);
   x:=xtab[11]; printw(Ecomment[k]);
   CanDoReplace:=((teavail[k]>0) and ((teavail[k]+0.00001)>=getEallot(1,Changes[myI].year,ttday,p)))
     or ((k=alreadyOn) and (Changes[myI].kind=2));
   CanDoLieu:=((telieudbl[k]>0) and ((telieudbl[k]+0.00001)>=getEallot(1,Changes[myI].year,ttday,p)))
     or ((k=alreadyOn) and (Changes[myI].kind=3));
   if CanDoReplace and CanDoLieu then
    begin
     if WtReplace>WtLieu then CanDoLieu:=false else CanDoReplace:=false;
    end;
   if CanDoReplace or CanDoLieu then
    begin {replace or in lieu}
     x:=xtab[9]; if CanDoReplace then printw('Replace') else printw('In Lieu');
    end
   else
    begin {cover}
     x:=xtab[2]; if doingextra[k]>0 then printw('TODAY')
      else if Eday[k]>0 then
       begin
        str(Eday[k]:2,astr); printw(astr+'-'+month[Emonth[k]]);
       end;
    x:=xtab[4];  str(Etaken[k]+doingextra[k]:2:0,astr);
    str(Emax[k]:2:0,bstr); printw(astr+'/'+bstr);
    x:=xtab[5]; str(Eweek[k]+doingextra[k]:2:0,astr); printw(astr);
    x:=xtab[9]; astr:=InttoBINstr(Eten[k]);
    astr:=copy(astr,Length(astr)-9,10); printw(astr);
    end;  {cover}
  end; {not added staff}
end;

procedure TManCoverDlg.AddComboBoxItem(const itemStr: string);
var
  s: string;
  coverNote: TCoverNote;
begin
  if Trim(itemStr) <> '' then
  begin
    if Length(itemStr) > MAX_DISPLAY then
      s := Copy(itemStr,0,MAX_DISPLAY) + '...'
    else
      s := Copy(itemStr,0,MAX_DISPLAY);

    if combobox1.items.IndexOf(s)=-1 then
    begin
      coverNote := TCoverNote.Create;
      coverNote.Value := itemStr;
      coverNote.Display := s;
      combobox1.Items.AddObject(s,TObject(coverNote));
    end;
  end;
end;

procedure TManCoverDlg.CalcItemPosition(j:integer);
begin
 if DoingTeacherCover then
   begin
     // Mantis 821-1
     //y:=(2+j)*txtHeight; x:=Hmargin;
     y:=(3+j)*txtHeight; x:=Hmargin;
    newrect.left:=2;
    newrect.right:= scrollbox1.HorzScrollbar.Range;
   end
 else
   begin
     x:=Hmargin+(subwidth*((j-1) mod Ncols));
     y:=txtHeight*(2+((j-1) div Ncols));
     newrect.left:=x-1;
     newrect.right:=newrect.left+xtab[0]+2;
   end;
 newrect.top:=y; newrect.bottom:=y+TxtHeight;
end;

procedure TManCoverDlg.ShowFreeStaff;
var
 j,maxH,maxW:          integer;
 astr,bstr:                    string;
 a:string;
 i:integer;
 myrect:TRect;

 procedure newline;
  begin
   x:=Hmargin;
   y:=y+txtHeight;
  end;

begin
 y:=txtHeight; x:=Hmargin;
 if DoingTeacherCover then bstr:='teachers' else bstr:='rooms';
 if freetotal=0 then
  begin
   astr:='No '+bstr+' available';
   maxW:=Hmargin+image1.canvas.textwidth(astr)+blankWidth;
   maxH:=3*txtHeight;
   SetImageSize(maxH,maxW);
   printw(astr);
   exit;
  end;
 if DoingTeacherCover then
  begin
   maxW:=xtab[12]; maxH:=txtHeight*(freetotal+4);
   SetImageSize(maxH,maxW);
   astr:='W-weekly extras   P-preferred time   F-same faculty   S-spare';  printw(astr);
   newline;  printw('Code');

   // Mantis 821-1
   a:='';
   for i:=1 to tlimit[ttday] do a:=a+tslotcode[i,ttday];


   x:=xtab[2]; printw('Last');    x:=xtab[3]; printw('Load');
   x:=xtab[4]; printw('Extras');  x:=xtab[5]; printw('W');
   x:=xtab[6]; printw('P');       x:=xtab[7]; printw('F');
   x:=xtab[8]; printw('S');       x:=xtab[9]; printw('Status');
   // Mantis 821-1
   //x:=xtab[10]; printw('Map');    x:=xtab[11]; printw('Comment');
   x:=xtab[10];
   for i:=1 to tlimit[ttday] do
    begin
      myRect.top:=y; myRect.bottom:=y+TxtHeight;
      myRect.left:=x;
      myRect.right:=x+MyletterW;
      fillrect(Image1.canvas.handle,myRect,Image1.canvas.brush.handle);
      printw(a[i]);  inc(x,MyletterW);
   end; {for i}

 //printmap(a); //printw(a);

   x:=xtab[11]; printw('Comment');
   newLine;
   //printw('***'); x:=xtab[10];printw('xAJGx');
   //newLine;
   CodeColor:=cpTeach;
   for j:=1 to freetotal do
    begin
     if (autoselect>0) and (j=autoselect) then HighlightBox(SetRect(j))
     else fcolor(codecolor);
     ShowItem(j);
     newline;
    end; {for j}
  end {DoingTeacherCover}
 else
  begin {room cover}
   Ncols:=(ManCoverDlg.scrollbox1.width-2*Hmargin) div subwidth;
   if Ncols<1 then Ncols:=1;
   maxW:=Hmargin+(Ncols*subwidth); maxH:=txtHeight*(4+(freetotal div Ncols));
   SetImageSize(maxH,maxW);
   astr:='Rooms Available: '+inttostr(freetotal);  printw(astr);
   codecolor:=cpRoom;
   fcolor(codecolor);
   newline;
   for j:=1 to freetotal do
    begin
     CalcItemPosition(j);
     if (autoselect>0) and (j=autoselect) then HighlightBox(newrect)
        else fcolor(codecolor);
     ShowRoomItem(j);
     if (j mod Ncols)=0 then newline;
    end; {j}
  end; {room cover}
end;

function ETmap(te: integer): string;
var
 astr,bstr: string;
 j:    integer;
begin
 astr:='';
 for j:=1 to tlimit[ttday] do
  begin
   bstr:='-';
   if bool(ETavail[te] and (1 shl j)) then
    begin
     bstr:='F';
     if (Eton[te] and (1 shl j))=0 then bstr:='C';
    end;
   astr:=astr+bstr;
  end; {for j}
 result:=astr;
end;

procedure ShowRoomSelect;
var
 ro:           integer;
begin
 with mancoverDlg do
  begin
    edit1.maxlength:=lenCodes[2];
    if autoselect=0 then
      begin
       edit1.text:=''; label12.caption:='';
       if Changes[myI].kind>=10 then
        begin
         label12.caption:='IGNORE this change';
         hidetimetable;
         exit;
        end;
      end
     else
      begin
       ro:=tepoint[autoselect];
       edit1.text:=tecode[ro,1];
       label12.caption:=romap[ro];
       showtimetable(ro);
      end;
  end;
end;

procedure ShowTeacherSelect;
var
 j,te:           integer;
begin
 with mancoverDlg do
  begin
    j:=lenCodes[1];
    if ETLencodes>j then j:=ETLencodes;
    edit1.maxlength:=j;
    if autoselect=0 then
      begin
       edit1.text:=''; label12.caption:='';
       if Changes[myI].kind>=10 then
        begin
         label12.caption:='IGNORE this change';
         hidetimetable;
         exit;
        end;
      end
     else
      begin
       te:=tepoint[autoselect];
       if te>1000 then
        begin {ET selected}
         edit1.text:=etsub[te-1000];
         label12.caption:=ETmap(te-1000);
        end
       else
        begin  {teacher selected}
         edit1.text:=tecode[te,0];
         label12.caption:=temap[te];
        end;
       //showtimetable(te);
       DisplayTeacherTT(Te);
      end;
  end;
end;

procedure showsolution;
var
 astr,newsub: string;
 j,te,ro:           integer;
begin
 with ManCoverDlg do
  begin
   label2.caption:=yearshort+' '+yearname[Changes[myI].year];
   label3.caption:=ClassCode[ClassShown[Changes[myI].level,Changes[myI].year]];
   label7.caption:=inttostr(p)+' ('+TimeSlotName[ttDay,p-1]+')';
   label8.caption:=Subcode[Changes[myI].sub];
   astr:='';
   if (Changes[myI].notes>0) and (Changes[myI].notes<=nmbrCoverInUse) then astr:=Cover[Changes[myI].notes];
   if (Changes[myI].notes>1000) then astr:=ExNote[Changes[myI].notes-1000];
   // combobox1.text:=astr;
   comboBox1.ItemIndex := GetItemIndex(astr);
   autoselect:=1;
   if freetotal=0 then begin autoselect:=0; edit1.text:=''; label12.caption:='';  end;
   if DoingTeacherCover then
    begin
     case Changes[myI].gen of
      1: label1.caption:='Absent teacher';
      2: label1.caption:='New class';
      3: label1.caption:='Merged class';
      5,6: label1.caption:='Consequent change';
     else
      label1.caption:='';
     end; {case}
     astr:='';
     if ((Changes[myI].newroom=Changes[myI].oldroom) and (Changes[myI].newroom>0))
      or ((Changes[myI].oldroom>0) and (Changes[myI].newroom=0)) then astr:=tecode[Changes[myI].oldroom,1];
     if (Changes[myI].oldroom=0) and (Changes[myI].newroom>0) then astr:=tecode[Changes[myI].newroom,1];
     if (Changes[myI].oldroom>0) and (Changes[myI].newroom<>Changes[myI].oldroom) and (Changes[myI].newroom>0)
      then astr:=tecode[Changes[myI].oldroom,1]+' => '+tecode[Changes[myI].newroom,1];
     if astr>'' then astr:='Room '+astr;
     label4.caption:=astr;
     label9.caption:='Teacher';
     if (Changes[myI].kind=1) then newsub:=etsub[Changes[myI].newte] else newsub:=tecode[Changes[myI].newte,0];
     if Changes[myI].newte=0 then newsub:='?';
     label10.caption:=tecode[Changes[myI].oldte,0]+' => '+newsub;
     if (freetotal>1) and (Changes[myI].newte>0) then
      begin
       if Changes[myI].kind=1 then te:=1000+Changes[myI].newte else te:=Changes[myI].newte;
       for j:=1 to freetotal do
        if tepoint[j]=te then
         begin
          autoselect:=j;
          break;
         end;
      end;
     if Changes[myI].kind>=10 then autoselect:=0;
     ShowTeacherSelect;
     ShowFreeStaff;
     if edit1.enabled then
      begin
       edit1.SelectAll; edit1.SetFocus; edit1.hint:='Enter teacher code';
      end;
    end {DoingTeacherCover}
   else
    begin {room cover}
     label1.caption:='Room change';
     if (Changes[myI].kind=1) then newsub:=etsub[Changes[myI].newte] else newsub:=tecode[Changes[myI].newte,0];
     astr:='Teacher '+tecode[Changes[myI].oldte,0];
     if newsub<>tecode[Changes[myI].oldte,0] then astr:=astr+' => '+newsub;
     label4.caption:=astr;
     label9.caption:='Room';
     newsub:=''; if Changes[myI].newroom<>Changes[myI].oldroom then newsub:=tecode[Changes[myI].newroom,1];
     if Changes[myI].newroom=0 then newsub:='?';
     label10.caption:=tecode[Changes[myI].oldroom,1]+' => '+newsub;
     if (freetotal>0) and (Changes[myI].newroom>0) then
      begin
       ro:=Changes[myI].newroom;
       for j:=1 to freetotal do
        if tepoint[j]=ro then
         begin
          autoselect:=j;
          break;
         end;
      end;
     if Changes[myI].kind>=10 then autoselect:=0;
     ShowRoomSelect;
     ShowFreeStaff;
     if edit1.enabled then
      begin
       edit1.SelectAll; edit1.SetFocus; edit1.hint:='Enter room code';
      end;
    end; {room cover}

  end; {with ManCoverDlg}

end;

procedure TManCoverDlg.ResetDlg;
var
 tmpDoingTeacherCover: bool;
 tmp_p,tmp_i,tmp_puse: integer;
begin
 tmpDoingTeacherCover:=DoingTeacherCover;
 tmp_p:=p;  tmp_i:=myI; tmp_puse:=puse;
 with ManCoverDlg do
  begin
   if GetNext(1) then Next.enabled:=true else Next.enabled:=false;
   DoingTeacherCover:=tmpDoingTeacherCover;
   p:=tmp_p;  myI:=tmp_i; puse:=tmp_puse;
   if GetNext(-1) then Previous.enabled:=true else Previous.enabled:=false;
   DoingTeacherCover:=tmpDoingTeacherCover;
   p:=tmp_p;  myI:=tmp_i; puse:=tmp_puse;
   if Changes[myI].kind>=10 then
    begin
     IgnoreBtn.Caption:='Undo Ignore';
     IgnoreBtn.hint:='Restore this change';
     edit1.enabled:=false;
    end
   else
    begin
     IgnoreBtn.Caption:='Set Ignore';
     IgnoreBtn.hint:='Ignore this change';
     edit1.enabled:=true;
    end;
   if (Changes[myI].kind>=10) or (freetotal=0) then
    CoverBtn.enabled:=false else CoverBtn.enabled:=true;
  end;
 showsolution;
end;

function TManCoverDlg.GetItemIndex(const itemStr: string): integer;
var
  s: string;
  coverNote: TCoverNote;
begin
  if Length(itemStr) > MAX_DISPLAY then
    s := Copy(itemStr,0,MAX_DISPLAY) + '...'
  else
    s := Copy(itemStr,0,MAX_DISPLAY);

  Result := combobox1.items.IndexOf(s)
end;

procedure TManCoverDlg.Getsolution;
begin
 if DoingTeacherCover then
  begin
   findCoverFaculty;
   GetFreeStaff;
  end
 else
  GetFreeRooms;
 resetDlg;

end;

procedure TManCoverDlg.FormActivate(Sender: TObject);
begin
 if firstshow then getsolution;
 firstshow:=false;
  if (MancoverTop>=0) and ((MancoverTop+Height)<=screen.Height) then
     Top:=MancoverTop;
 if (MancoverLeft>=0) and ((MancoverLeft+Width)<=screen.Width) then
     Left:=MancoverLeft;
end;

procedure TManCoverDlg.nextClick(Sender: TObject);
begin
 screen.cursor:=crHourglass;
 getnext(1);
 getsolution;
 screen.cursor:=crDefault;
end;

procedure TManCoverDlg.previousClick(Sender: TObject);
begin
 screen.cursor:=crHourglass;
 getnext(-1);
 getsolution;
 screen.cursor:=crDefault;
end;

procedure TManCoverDlg.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X1, Y1: Integer);
var
 ylocate,xlocate,newlocate:  integer;
begin
 if doubleclick then
  begin
   doubleclick:=false;
   exit;
  end;
 if (Changes[myI].kind>=10) or(freetotal=0) then exit;

 if DoingTeacherCover then
  begin
   // Mantis 821-1
   ylocate:=(y1 div txtHeight)-2;
   //ylocate:=(y1 div txtHeight)-3;
   if (ylocate=autoselect) or (ylocate<1) or (ylocate>freetotal) then exit;
   if autoSelect>0 then
    begin
     fcolor(CodeColor);
     Image1.canvas.fillrect(selbox);
     ShowItem(autoSelect);
    end;
   autoSelect:=ylocate;
   HighlightBox(SetRect(autoSelect));
   ShowItem(autoSelect);
   autoSelect:=ylocate;
   ShowTeacherSelect;
  end
 else
  begin {room cover}
   ylocate:=(y1 div txtHeight)-2;
   xlocate:=1+((x1-(Hmargin div 2)) div subwidth);
   newlocate:=ylocate*Ncols+xlocate;
   if (newlocate=autoselect) or (newlocate<1) or (newlocate>freetotal) then exit;
   if autoSelect>0 then
    begin
     fcolor(CodeColor);
     Image1.canvas.fillrect(selbox);
     ShowRoomItem(autoSelect);
    end;
   autoSelect:=newlocate;
   CalcItemPosition(autoSelect);
   HighlightBox(newrect);
   ShowRoomItem(autoSelect);
   ShowRoomSelect;
  end;
 image1.repaint;
 edit1.SelectAll; edit1.SetFocus;
end;

function SameConsequential(e1,replacete: integer):boolean;
var
  i5: integer;
begin
 SameConsequential:=false;
 if (replacete=0) or (Changes[e1].newte<>replacete) then exit;
 if (Changes[e1].kind=1) then exit;
 for i5:=1 to numchanges do
  if (((Changes[i5].gen=5) or (Changes[i5].gen=6)) and
     (Changes[i5].oldte=Changes[e1].newte)) then
   begin
    SameConsequential:=true;
    break;
   end;
end;

function GetAddedTeTimetable(const pAddedTe: Integer): string;
var
  lStr: string;
  j: Integer;
begin
  lStr := '';
  for j :=1 to nmbrChanges do
  begin
    if Changes[j].newte = pAddedTe then
    begin
      lStr := lStr + ' Year: ' + YEarName[Changes[j].Year] +  ' Period: ' + PeriodName[Changes[j].TimeSlot -1] +  ' Subject: ' + SubCode[Changes[j].sub] + #10#13;
    end;
  end;
  Result := lStr;
end;

procedure TManCoverDlg.EnterSolution;
var
 msg,s:  string;
 a,noteUsed,replacete,te,j,y2,l:  integer;
 replaceET,ETcover:  integer;
 replacero,ro:    integer;
 msgret:         word;
 tefound:        bool;
 su2,level2,year2,replacekind:  integer;
 room1,room2,room3:                 integer;
 afnt,bfnt:                                tpintpoint;
begin
 te:=0; room2:=0; room3:=0; su2:=0;  year2:=0; level2:=0;
 if DoingTeacherCover then
  begin
   j:=mancoverDlg.combobox2.itemindex;
   if j>=0 then autokind:=covertype[j] else autokind:=0;
   replacete:=0; replacekind:=0;  msg:='';
   if autoselect>0 then replacete:=tepoint[autoselect];
   s:=mancoverDlg.edit1.text;
   s:=TrimRight(s);
   if (replacete=0) and (s>'') then
    begin {user has entered a code not shown in list}

     j:=findaddedstaff(s);
     if j>0 then te:=1000+Etpointer[j]
      else te:=checkCode(1,s);
     if te=0 then
      begin
       msg:='Check replacement teacher code';
       messagedlg(msg,mtError,[mbOK],0);
       ManCoverDlg.edit1.setfocus;
       ManCoverDlg.edit1.SelectAll;
       exit;
      end;
     msg:='';
     if te>1000 then
      begin
       replaceET:=te-1000;
       if (ETavail[replaceET] and (1 shl p))=0
        then msg:=etsub[replaceET]+' is not free in this time slot';
       if (ETavail[replaceET]=0)
        then msg:=etsub[replaceET]+' is not selected today';
       if (msg='') and ((Eton[replaceET] and (1 shl p))<>0) and
        ((Ettaught[replaceET]+getEallot(1,Changes[myI].year,ttday,p))>Etmax[replaceET])
        then msg:=etsub[replaceET]+'- maximum load would be exceeded';
       if msg='' then
        begin {check if ET covering an absence}
         ETcover:=0;
         for j:=1 to numchanges do
          if (j<>myI) and (Changes[j].timeslot=p) and (Changes[j].kind=1)
           and (Changes[j].newte=replaceET) then begin ETcover:=j; break; end;
         if ETcover>0 then
          begin
           s:=etsub[replaceET]+' is already covering a change in '
                +TimeSlotName[ttDay,p-1]+endline+'Use for this cover instead?';
           msgret:=messagedlg(s,mtWarning,[mbYes,mbNo],0);
           if msgret<>mrYes then
            begin
             ManCoverDlg.edit1.setfocus;
             ManCoverDlg.edit1.SelectAll;
             exit;
            end;
           RemoveTeacherCover(ETcover,Changes[ETcover].timeslot);
           replacete:=te;
          end; {ETcover>0}
        end; {check for ET covering an absence}
      end
     else
      begin {te>0 and <1000}
       {check for teacher in use}
       if (teabsent[te] and (1 shl p))=0
        then msg:=tecode[te,0]+' is absent in this time slot';
       if (tena[te] and (1 shl p))=0
        then msg:=tecode[te,0]+' is Not Available in this time slot';
       if (msg='') and ((teon[te] and (1 shl p))<>0) and
        ((Etaken[te]+getEallot(1,Changes[myI].year,ttday,p))>Emax[te])
        then msg:=tecode[te,0]+' - maximum extras would be exceeded';
       if (msg='') then
        begin {check cover - already teaching, or covering a change}
         if ((teach[te] and (1 shl p))=0) and ((telost[te] and (1 shl p))<>0) then
          begin {check teaching cover}
           room2:=0; tefound:=false;
           for y2:=0 to years_minus_1 do
            begin
             afnt:=FNT(ttday,p-1,y2,0,2);
             for l:=1 to level[y2] do
              begin
               inc(afnt,4);
               if afnt^=te then
                begin
                 tefound:=true; level2:=l; year2:=y2;
                 bfnt:=afnt; dec(bfnt); su2:=bfnt^;
                 inc(bfnt,2); room2:=bfnt^;
                end;
              end; {l}
            end; {y2}
           if tefound then
            begin
             AlreadyTeachingdlg:=TAlreadyTeachingDlg.create(application);
             with AlreadyTeachingdlg do
              begin
               label1.caption:= tecode[te,0]+' is teaching '
                +Subcode[su2]+' in '+ tecode[room2,1]+' '+ yeartitle+' '+yearname[year2];
               label3.caption:='Cancel - don''t use '+tecode[te,0];
               label4.caption:='Merge with '+tecode[te,0]+'''s class';
               label5.caption:='Cover '+tecode[te,0]+'''s class';

               label6.left:=label4.left+label4.width+6;
               edit1.left:=label6.left+label6.width+6;
               edit1.maxlength:=lencodes[2];
               tag:=room2;
              end;
             AlreadyTeachingdlg.showmodal;
             case AlreadyTeachingdlg.modalresult of
              mrOK:  replacekind:=2; {cover change}
              mrYes: replacekind:=1; {merge change}
              mrCancel:replacekind:=0;
             end;
             room3:=AlreadyTeachingDlg.edit1.tag;
             AlreadyTeachingdlg.free;
             if replacekind=0 then exit;
             replacete:=te;
            end; {tefound}
          end; {check teaching cover}
        end; {msg=''}
      end; ; {te>0 and <1000}
   end; {user has entered a code not shown in list}

   if msg>'' then
    begin
     messagedlg(msg,mtError,[mbOK],0);
     ManCoverDlg.edit1.setfocus;
     ManCoverDlg.edit1.SelectAll;
     exit;
    end;
//  don't cover if same teacher with consequential changes
   if not(SameConsequential(myI,replacete)) then
    begin
     if Changes[myI].newte>0 then RemoveTeacherCover2;
     if replacete>0 then
      case replacekind of
       0: begin
            if replacete>1000 then AddETcover(replacete-1000) {normal cover}
              else AddStaffCover(replacete);
          end;
       1: begin {merge change}
           room1:=Changes[myI].oldroom;
           teon[te]:=teon[te] and (not(1 shl p)); Changes[myI].newte:=te;
           Changes[myI].kind:=5; {share cover}
           Changes[myI].newroom:=room3;
           if (room3<>room1) and (room3<>room2) then
            begin
             roCover[room3]:=roCover[room3] and (not(1 shl p));
             roomon[room3]:=roomon[room3] and (not(1 shl p));
            end;
           if room1<>room2 then
            begin
             roomon[room1]:=roomon[room1] or (1 shl p);
             rolost[room1]:=rolost[room1] and (not(1 shl p));
            end;
           if room2<>room3 then
            begin
             a:=0;
             for j:=1 to numchanges do
              if (Changes[j].timeslot=p) and ((Changes[j].gen=0) or (Changes[j].gen=5)) and (Changes[j].oldte=te)
                then a:=j;
             if a=0 then begin inc(numchanges); a:=numchanges; end;
             Changes[a].timeslot:=p; Changes[a].year:=year2; Changes[a].level:=level2; Changes[a].sub:=su2;
             Changes[a].oldte:=te; Changes[a].newte:=te; Changes[a].oldroom:=room2; Changes[a].newroom:=room3;
             Changes[a].kind:=0; Changes[a].needte:=0; Changes[a].notes:=0; Changes[a].gen:=5;
             roomon[room2]:=roomon[room2] or (1 shl p);
             rolost[room2]:=rolost[room2] and (not(1 shl p));
            end;
          end; {merge change}
       2: begin {new cover change}
           a:=0;  Changes[myI].newte:=te; Changes[myI].kind:=6;
           for j:=1 to numchanges do
            if (Changes[j].timeslot=p) and ((Changes[j].gen=0) or (Changes[j].gen=6)) and (Changes[j].oldte=te)
             then a:=j;
           if a=0 then
             begin
              inc(numchanges); a:=numchanges; ManCoverDlg.next.enabled:=true;
             end;
           Changes[a].timeslot:=p; Changes[a].year:=year2; Changes[a].level:=level2; Changes[a].sub:=su2;
           Changes[a].oldte:=te; Changes[a].oldroom:=room2; Changes[a].notes:=0; Changes[a].gen:=6;
           if (Changes[a].newte=0) or (Changes[a].newte=te) then
            begin
             Changes[a].newte:=0; Changes[a].needte:=-1;
            end;
           if Changes[a].needroom=0 then Changes[a].newroom:=room2;
          end;  {new cover change}
      end; {case}
    end;
   if replacete>0 then Changes[myI].needte:=0 else Changes[myI].needte:=-1;
   ResetLoads;
  end {DoingTeacherCover}
 else
  begin {doing room cover}
   replacero:=0;
   if autoselect>0 then replacero:=tepoint[autoselect];
   s:=mancoverDlg.edit1.text;
   s:=TrimRight(s);
   if (replacero=0) and (s>'') then
    begin {user has entered a code not shown in list}
     ro:=checkCode(2,s);
     if ro=0 then
      begin
       msg:='Check replacement room code';
       messagedlg(msg,mtError,[mbOK],0);
       ManCoverDlg.edit1.setfocus;
       ManCoverDlg.edit1.SelectAll;
       exit;
      end;
     if (roomon[ro] and roabsent[ro] and (1 shl p))<>0
      then replacero:=ro else
       begin
        msg:='Room is already in use!';
        messagedlg(msg,mtError,[mbOK],0);
        ManCoverDlg.edit1.setfocus;
        ManCoverDlg.edit1.SelectAll;
        exit;
       end;
    end;
   if Changes[myI].newroom>0 then RemoveRoomCover;
   if replacero>0 then AddRoomCover(replacero);
  end; {doing room cover}
 NoteUsed:=Changes[myI].notes;
 if NoteUsed>1000 then
  begin
   a:=NoteUsed-1000;
   ExNote[a]:='';
   if a=notenum then dec(notenum);
  end;
 Changes[myI].notes:=0;
 // s:=Trim(ManCoverDlg.combobox1.text);
 if combobox1.ItemIndex > -1 then
   s := TCoverNote(combobox1.Items.Objects[combobox1.ItemIndex]).Value
 else
   s := '';
 if (s>'') then
  begin
   a:=0;
   if nmbrCoverInUse>0 then
    for j:=1 to nmbrCoverInUse do
     if UpperCase(Cover[j])=UpperCase(s) then a:=j;
   if a>0 then Changes[myI].notes:=a
   else
    begin {new note}
     NoteUsed:=0;
     if notenum=0 then NoteUsed:=1
      else
       begin
        for j:=1 to notenum do
         if ExNote[j]='' then begin NoteUsed:=j; break; end;
        if NoteUsed=0 then NoteUsed:=notenum+1;
       end;
     if noteNum<NoteUsed then notenum:=NoteUsed;
     ExNote[NoteUsed]:=s;
     Changes[myI].notes:=1000+NoteUsed;
     if ManCoverDlg.combobox1.items.IndexOf(s)=-1 then
      // ManCoverDlg.combobox1.items.add(s);
      AddComboBoxItem(s);
    end; {new note}
  end;
 screen.cursor:=crHourglass;
 if ManCoverDlg.next.enabled then getnext(1);
 getsolution;
 UpdateExtrasWins;
 screen.cursor:=crDefault;
 CoverFlag:=true;
end;

procedure TManCoverDlg.CoverBtnClick(Sender: TObject);
begin
 if Changes[myI].kind>=10 then exit;
 EnterSolution;
end;

procedure TManCoverDlg.DisplayTeacherTT(const pTeachNo: Integer);
begin
  if ShowCoverTimetable then
  begin //show appropriate timetable
    if DoingTeacherCover then //show teacher timetable, hide room timetable
    begin
      if wnFlag[wnRoShow] then RoShowWin.close;
      wnFlag[wnRoShow]:=false;
      if (pTeachNo > 0) then
      begin
        teshownum := pTeachNo;  //selection
        if not(wnFlag[wnTeShow]) and not Assigned(FrmStaffTT) then
          FrmStaffTT := TFrmStaffTT.Create(Application);
        FrmStaffTT.SelectedTe := pTeachNo;
        FrmStaffTT.RefreshTimetable;
        FrmStaffTT.IsCoverSouce := True;
        FrmStaffTT.Show;
        wnFlag[wnTeShow] := True;
      end;
    end
    else
    begin
      FrmStaffTT.Close;
    end;
  end
  else
    Hidetimetable;
end;

procedure TManCoverDlg.Image1DblClick(Sender: TObject);
begin
 if Changes[myI].kind>=10 then exit;
 doubleclick:=true;
 EnterSolution;
end;

procedure TManCoverDlg.FormDestroy(Sender: TObject);
begin
 Bitmap1.free;
end;

procedure TManCoverDlg.SetKindList(te: integer);
var
 mycount,alreadyOn,j: integer;
 test: boolean;
begin
 mycount:=-1;   Autokind:=0;
 if DoingTeacherCover and (te>0) then
  begin
   Combobox2.Enabled:=true;
   Combobox2.Clear;
   if te>1000 then
    begin
     Combobox2.items.Add('Added');
     Autokind:=1;
     CoverType[0]:=1;
     combobox2.ItemIndex:=0;
     exit;
    end;
   if copy(tecode[te,0],1,2)='00' then exit;
   alreadyOn:=Changes[myI].newte;
   test:=((Emax[te]>=(Etaken[te]+doingextra[te]+getEallot(1,Changes[myI].year,ttday,p))) or ((telieudbl[te]>0) and
    ((telieudbl[te]+0.0001)>=getEallot(1,Changes[myI].year,ttday,p))) or ((teavail[te]>0) and
    ((teavail[te]+0.0001)>=getEallot(1,Changes[myI].year,ttday,p))) ) and ((teon[te] and (1 shl p)
    and (teabsent[te] and tena[te])<>0) );
   if test or (alreadyOn=te) then
    begin
     TestReplace(te,alreadyOn);
     if CanDoReplace then
      begin
       inc(mycount);
       Combobox2.items.Add('Replace');
       CoverType[mycount]:=2;
       if ShouldDoReplace then
        begin
         combobox2.itemindex:=mycount;
         autokind:=2;
        end;
      end;
     if CanDoLieu then
      begin
       inc(mycount);
       Combobox2.items.Add('In Lieu');
       CoverType[mycount]:=3;
       if ShouldDoLieu then
        begin
         combobox2.itemindex:=mycount;
         autokind:=3;
        end;
      end;
     inc(mycount);
     Combobox2.items.Add('Extra');
     CoverType[mycount]:=4;
     if autokind=0 then
      begin
       combobox2.itemindex:=mycount;
       autokind:=4;
      end;
     if alreadyOn=te then if mycount>=0 then
      for j:=0 to mycount do
       if Changes[myI].kind=CoverType[j] then
         begin
           combobox2.itemindex:=j;
           autokind:=CoverType[j];
           break;
         end;

    end; {if test}
   if alreadyOn=te then
    case Changes[myI].kind of
     
     5: begin
         inc(mycount);
         Combobox2.items.Add('Shared');
         CoverType[mycount]:=5;
         combobox2.itemindex:=mycount;
         autokind:=5;
        end;
     6: begin
         inc(mycount);
         Combobox2.items.Add('Swap');
         CoverType[mycount]:=6; autokind:=6;
         combobox2.itemindex:=mycount;
        end;
    end;
  end
 else
  begin
   Combobox2.Clear;
   Combobox2.Enabled:=false;
  end;
end;

procedure TManCoverDlg.Edit1Change(Sender: TObject);
var
 j,te,ro,old_autoselect: integer;
 astr: string;
begin
 if Changes[myI].kind>=10 then exit;
 if DoingTeacherCover then
  begin
    old_autoselect:=autoselect;
   astr:=self.edit1.text;
   astr:=TrimRight(astr);
   j:=findaddedstaff(astr);
   if j>0 then te:=1000+Etpointer[j]
    else te:=checkCode(1,astr);
   if te=0 then label12.caption:=''
    else if te>1000 then label12.caption:=ETmap(te-1000)
     else label12.caption:=temap[te];
   autoselect:=0;
   if (te>0) and (freetotal>0) then
    for j:=1 to freetotal do
     if tepoint[j]=te then
      begin
       autoselect:=j;
       break;
      end;
   if (Te <> TeShownum) or not(wnFlag[wnTeShow]) then
   begin
     //showtimetable(te);
     if Te > 0 then
     begin
       DisplayTeacherTT(Te);
       Edit1.SetFocus;
     end;
   end;
   SetKindList(te);
   if autoselect=old_autoselect then exit;

   if old_autoSelect>0 then
    begin
     fcolor(CodeColor);
     Image1.canvas.fillrect(selbox);
     ShowItem(old_autoSelect);
    end;
   if autoselect>0 then
    begin
     HighlightBox(SetRect(autoSelect));
     ShowItem(autoSelect);
    end;
  end
 else
  begin {doing room cover}
   Combobox2.Clear;
   Combobox2.Enabled:=false;
   old_autoselect:=autoselect;
   astr:=edit1.text;
   astr:=TrimRight(astr);
   ro:=checkCode(2,astr);
   if ro=0 then label12.caption:=''
    else label12.caption:=romap[ro];
   autoselect:=0;
   if (ro>0) and (freetotal>0) then
    for j:=1 to freetotal do
     if tepoint[j]=ro then
      begin
       autoselect:=j;
       break;
      end;
   if (ro<>roshownum) or not(wnFlag[wnRoShow]) then showtimetable(ro);
   if autoselect=old_autoselect then exit;

   if old_autoSelect>0 then
    begin
     fcolor(CodeColor);
     Image1.canvas.fillrect(selbox);
     ShowRoomItem(old_autoSelect);
    end;
   if autoselect>0 then
    begin
     CalcItemPosition(autoSelect);
     HighlightBox(NewRect);
     ShowRoomItem(autoSelect);
    end;
  end;
 image1.repaint;
end;

procedure TManCoverDlg.IgnoreBtnClick(Sender: TObject);
var
 alreadyIgnore:  bool;
begin
 screen.cursor:=crHourglass;
 alreadyIgnore:=(Changes[myI].kind>=10);
 if alreadyIgnore then
  begin
   Changes[myI].kind:=Changes[myI].kind-10;
  end
 else
  begin
   if (Changes[myI].kind>0) and (Changes[myI].newte>0) then RemoveTeacherCover2;
   if (Changes[myI].needroom<>0) and (Changes[myI].newroom>0) then RemoveRoomCover;
   Changes[myI].kind:=Changes[myI].kind+10;
   if (next.enabled=true) then getnext(1);
  end;
 ResetLoads;
 getsolution;
 CoverFlag:=true;
 UpdateExtrasWins;
 screen.cursor:=crDefault;
end;

procedure TManCoverDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MancoverTop := Top;
  MancoverLeft := Left;
  Hidetimetable;
  HideTeacherTT;
  if Coverflag then
  begin
    SaveExtras;
    CoverFlag := False;
  end;
  if Assigned(FrmStaffTT) then
    FreeAndNil(FrmStaffTT);
end;

procedure TManCoverDlg.ShowHideTimetable(Sender: TObject);
begin
 ShowCoverTimetable:=Checkbox1.checked;
 if ShowCoverTimetable then
  Edit1Change(Self)
 else
 begin
   HideTimetable;
   HideTeacherTT;
 end;
end;

procedure TManCoverDlg.ComboBox2Change(Sender: TObject);
var
 j: integer;
begin
 j:=combobox2.itemindex;
 if j>=0 then autokind:=covertype[j] else autokind:=0;
end;

procedure TManCoverDlg.FormDeactivate(Sender: TObject);
begin
 MancoverTop:=top;
 MancoverLeft:=Left;
end;

end.
