unit ClassDefs;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, SysUtils, Messages,printers,TCEglobals,StBarC,stcommon, GlobalToTcAndTcextra;

 type TDrawWin=Class(Tform)  {General-purpose window where contents are drawn and scrolled.}
   private
    tabsDoPriv:          bool;
    leftCutoff,rightCutoff:  integer;
    procedure MyMouseWheelDown(Sender: TObject;  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure MyMouseWheelUp(Sender: TObject;  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure SetScroll;   {Sets Hscroll and Vscroll, cutoffs, x and y to top left}
    procedure SetScrollRange; {Initializes scroll bars based on MaxH, MaxW and Headwidth}
    procedure HomeEndPageUpDown(var key: word); {uses keys for scrolling}
   protected
    procedure paint; override; {if Tabs do then (set font, call SetTabs, SetScrollRange methods),
                               SetScroll, normal paint (inherited)}
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
              {if 'V' pressed, calls Change View method, HomeEndPageUpDown.}
    procedure SetTabs; virtual;  {overridde to do Tabs calcs}
   public
    x,y: integer;           {window canvas position}
    codecolor:  integer;    {colour used text for main body of window}
    maxW,maxH:  integer;    {maximum width and height of contents (pixels)}
    headwidth:  integer;    {maximum width of heading}
    bottomCutoff,topCutoff:  integer;   {window limits to avoid unnecessary drawing}
    Hscroll,Vscroll:      integer;  {horizontal and vertical scroll positions}
    Tabs: array of integer;  {dynamic array for window tab positions.
                              Set size with SetLength in SetTabs method.}
    procedure printw(a:string);    {prints string a, at position x,y}
    procedure printwl(a:string);   {prints string and increments x to end of string}
    procedure fcolor(fcol:integer); {sets font and brush colour using FontColorPair array}
    procedure printw2(a,b:string);  {prints a in colour 1, and b in codecolor}
    procedure newline;              {set x=0, y to next  line}
    procedure drawMyLine(x1,y1,x2,y2: integer);  {draws a line from x1,y1 to x2,y2, offset by Hmargin-Hscroll }
    procedure ChangeView; virtual;  {Increments WinView array and calls UpdateWin}
    procedure UpdateWin;            {set TabsDo and call refresh}
    procedure printMap(ss: string); {prints load map (from ss) in correct spacing and colours}
    destructor Destroy; override;   {Set winpos array to window position and wnFlag[] to false}
    procedure Activate; override;
    constructor Create(AOwner: TComponent); override;
    procedure Maxtab(i,tab:integer;s:string);
              {Next Tab = Previous tab + larger of (tab and screen width of s) +blankwidth}
    property tabsDo:  bool read tabsDoPriv write tabsDoPriv; {Set to true when window is created}
      {If true, then SetTabs is called on paint. UpdateWin method sets it to true.}
 end;
{Implementation
1. Subclass from TdrawWin  e.g. TInfoWin = class(TDrawWin)
2. Add SetTabs method e.g.
  protected
    procedure SetTabs; override;
3. In SetTabs
(a) SetLength(Tabs, n)
(b) Use MaxTab procedure to calculate Tabs array
4. Don't need any sub - procedures in Paint procedure.}



 type TPrintDrawWin=Class(TPersistent)   {general-purpose class for printing the contents
  of a window.  It includes all the functions and variables needed for printing.}
   public
    x,y:        integer;    {position on page}
    mypagenumber: integer;  {current page number}
    PrintPageHeight,PrintPageWidth: integer;
    PrintCanvas: Tcanvas;
    codecolor:        integer;
    TabsDo: boolean;          {flag to calculate printing tabs;}
    PrntTabs: array of integer; {dynamic array for printing - set length before using.}
    function PageCount: string;  {returns a string with page number (if page >1)}
    procedure header;     {sets margins, prints school name & date stamp, calls Head procedure.}
    procedure SetTabs; virtual; abstract;  {override to calculate printing tabs.}
    procedure head; virtual; abstract;  {override to print additional headings}
    procedure PrintHead;   {calls SetTabs, then header. Use to print headings in main print}
    procedure UnderlineOn;    {turns underline on}
    procedure UnderlineOff;   {turns underline off}
    procedure fcolor(fcol:integer);  {if colorPrinterFlag, sets pen and brush colours using FontColorPair array.}
    procedure printw(a:string);    {prints string at x,y (offset by left margin)}
    procedure printwl(a:string);   {calls printw and increments x}
    procedure printw2(a,b:string); {prints a in colour 1, and b in codecolor}
    procedure printw3(a: string); {print wrapped string}
    procedure StartNewPage;        {starts a new page and sets top margin}
    procedure newline;    {increases y by one line. If within 2 lines from bottom of page,
                         calls StartNewPage and Header}
    procedure drawMyLine(x1,y1,x2,y2: integer);  {draws a line from x1,y1 to x2,y2 (offset by left margin)}
    procedure printMap(ss: string);
    procedure printCustomAddon;    {prints custom add-on.}
    procedure Maxtab(i,tab:integer;s:string);  {Next Tab = Previous tab + larger of (tab and screen width of s) +Prntblankwidth}
    procedure AfterConstruction; override;     {sets TabsDo to true, so that SetTabs
             is automatically called from PrintHead, and sets pagewidth and Pageheight}
 end;
{Implementation
1. Subclass from TPrintDrawWin and override head and SetTabs procedures.
Example:
 type TPrintInfoWin=class(TPrintDrawWin)
  public
   procedure head; override;
   procedure SetTabs; override;
 end;
var
 PrintInfoWin:    TPrintInfoWin;
2. In SetTabs
(a) SetLength(PrntTabs, n)
(b) Use MaxTab procedure to calculate Tabs array
3. In Head, add any additional headings for the printout. (school name, date stamp and page number printed automatically).
4. In main print procedure
(a) create an instance of class.  Put into a try finally loop so that instance is freed at the end.
(b) Don't need any sub - procedures in Print procedure.
(c) Call PrintHead at least once to print headings and call SetTabs procedure.
Example
PrintInfoWin:=TPrintInfoWin.create;
 with PrintInfoWin do
  try
   PrintHead;
   (do other stuff here)
Finally
   PrintInfoWin.free
End;}

 type TOutputWin=Class(TPersistent)   {general-purpose class for copying the contents
  of a window to the clipboard or a text file.  It includes all the functions and variables needed.}
   private
    delim,delim2:   string;
   public
      OutStream: Tstream;
      OutString: string;
      EndLineOut: string;
    procedure header;     {prints school name & date stamp, calls Head procedure.}
    procedure head; virtual; abstract;  {override to print additional headings}
    procedure printw(a:string);    {prints string at x,y (offset by left margin)}
    procedure printc(a:string);
    procedure printLine(const a:array of string);
    procedure newline;    {start new line by adding end of line character(s)}
    procedure printCustomAddon;    {prints custom add-on.}
    procedure AfterConstruction; override;     {sets TabsDo to true, so that SetTabs is automatically called from PrintHead}
    destructor Destroy; override;  
 end;
{Implementation
1. Subclass from TOutputWin and override head procedure.
Example:
 type TOutInfoWin=class(TOutputWin)
  public
   procedure head; override;
 end;
var
 OutInfoWin:      TOutInfoWin;

2. In Head, add any additional headings for the printout.
  (school name, date stamp and page number printed automatically).
3. In main print procedure
(a) create an instance of class.  Put into a try finally loop so that instance is freed at the end.
(b) Don't need any sub procedures.
(c) Call Header to print headings.
(d)  In each line, use Printw for first item, Printc for later items, then newline.
Or, use PrintLine to print all iterms on a line
}



 type TCodeWin=Class(TDrawWin)     {print codes window with multiple views
                  The view is specified from winView[tag].
                  The codes only view (=0) shows multiple codes across the page.
                  Other views show one code for each line.
                  The paint method is part of the class.
                  Code selection is handled in the class.}
   private
    FselBox:    Trect;              {rectangle for selected code}
   protected
    procedure paint; override;     {draws window based on PaintItem method}
    procedure MouseDown(Button: TMouseButton;Shift: TShiftState; X1, Y1: Integer); override;
                                   {used to select a code}
    procedure PaintItem(i:integer;SelFlag:boolean); virtual; abstract;
                                   {override to draw code I at position x,y}
    procedure PaintItemFull(i:integer;SelFlag:boolean); virtual;
              {calculates the item position, highlights code (if selected) and calls PaintItem}
    procedure CalcItemPosition(i:integer); virtual;  {calculates the screen position of item i}
    procedure PaintHead; virtual; abstract; {override to paint the heading at the top of the window}
    function MyCodePoint(i:integer): integer; virtual;
   public
    CodeFit: smallint;       {number of codes per line}
    TotalCodes: smallint;    {number of codes in window}
    CodeWidth: smallint;     {width of code in pixels}
    yHead: integer;         {y position after heading is drawn}
    NewRect: Trect;          {rectangle used when changing a selected code}
    DoubleClick:        boolean;    {Used when window is double clicked,
                                to prevent additional code selection from MouseDown method}
    myselect,selCode:  smallint;  {selected code,code position}
    property selBox: Trect  read FselBox write FselBox;         {rectangle for selected code}
    procedure CalcScreenCodeFit;                               {calculates CodeFit}
    procedure HighlightBox(newrect:Trect);    {highlights rectangle for selected code}
    procedure RedoSelection;
    constructor Create(AOwner: TComponent); override;
 end;

{Implementation

1. Subclass from TcodeWin e.g. TTeWindow = class(TCodeWin)
2. Add required methods fo class e.g.
  Protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
3. In SetTabs:
(a)  Set Length for Tabs array e.g. setlength(Tabs,15);
(b)  Set TotalCodes
(c)  Calculate headwidth (width of heading)
 (d)  Calculate CodeWidth    e.g.  CodeWidth:=fwCode[mycode]+blankWidth
 (e)  Call  CalcScreenCodeFit method
(f)  Calculate tabs needed for longer views in PaintItem method
4. In Head - print headings (for each view)
5. In PaintItem print each item (for each view), making use of any sort order being used.}


type TPrintCodeWin=Class(TPrintDrawWin)   {class for printing code windows.
                It includes extra variables and procedures to simplify the print routine.}
  public
    CodeFit: smallint;        {number of codes per line on printed page}
    TotalCodes: smallint;     {number of codes to print}
    CodeWidth: smallint;      {width of code (on printed page)}
    procedure CalcPrintCodeFit;   {calculates CodeFit}
 end;


{Implementation

Same implementation as for TprintDrawWin except
(a) Subclass from TprintCodeWin
(b) In SetTabs, set Codefit, totalcodes and Codewidth.  Call CalcPrintCodeFit.
(c) In printing, can make use of printMap to show load maps. }

type TOutCodeWin=Class(TOutPutWin)   {class for printing code windows.
                It includes extra variables and procedures to simplify the print routine.}
  private
   FirstInLine: boolean;
  public
    CodeFit: smallint;        {number of codes per line on output}
    TotalCodes: smallint;     {number of codes to output}
    function CodeToPrint(i:integer):string; virtual; abstract;
    procedure CalcPrintCodeFit;   {calculates CodeFit}
    procedure Setup(setTotal: smallint);
    procedure PrintCode(i:integer);
 end;


type TLineCodewin=Class(TCodeWin)   {codes window with only one view - one line per code
                                    It includes all the features of TcodeWin, but with
                                    CalcItemPosition and MouseDown overridden in the class
                                    to do the different calculation of position.}
   protected
    procedure CalcItemPosition(i:integer); override;
    procedure MouseDown(Button: TMouseButton;Shift: TShiftState; X1, Y1: Integer); override;
 end;

{Implementation
  Same implementation as for TcodeWin except:
  -  in SetTabs, don't need to calculate CodeWidth or call CalcScreenCodeFit method.}


type TSelectCodeWin=Class(TCodeWin)   {codes window where multiple codes are selected
            e.g. absent teachers, in addition to one highlighted code }
   protected
    procedure PaintItemFull(i:integer;SelFlag:boolean); override;
            {paints item including calculating position, setting colours,
             highlighting if needed and calling PaintItem.}
    function ItemIsSelected(k:integer):boolean; virtual; abstract;
             {override to set whether item k is selected}
    function BasicPoint(k:integer):integer; virtual; abstract;
             {override to get code number using sort order in operation}
   public
    ItemPoint: array of integer;   {sets sort order for use with CalcItemPoint -
               takes into account the sort order (from BasicPoint function) and the view,
                so that only selected items are shown in the third view}
    SelCode2:  smallint;  {actual code pointed at by Selcode from ItemPoint array}
    codeColor2:  smallint; {colour used for selected codes}
    MaxItemPoint:  smallint; {number of codes}
    procedure ChangeView; override;  {calls CalcItemPoint and changes selection - as one
               view may show selected codes only}
    procedure CalcItemPoint;   {sets ItemPoint using BasicPoint and ItemIsSelected functions}
 end;
{Implementation
1. SubClass from TSelectCodeWin e.g. TAbsentte = class(TSelectCodeWin)
2. Add required methods fo class e.g.
  protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
    function ItemIsSelected(k:integer):boolean; override;
    function BasicPoint(k:integer):integer; override;
3. In SetTabs
 (a) Set Length for Tabs array e.g. setlength(Tabs,6);
 (b) Set MaxItemPoint to number of codes e.g. MaxItemPoint:=codenum[mycode];
 (c) Call CalcItemPoint;
 (d) Calculate headwidth (width of heading)
 (e) Calculate CodeWidth e.g. CodeWidth:=fwCode[mycode]+blankWidth;
 (e) call CalcScreenCodeFit
4. In PaintItem print each item (for each view), making use of ItemPoint for the sort order.
5. In PaintHead, print the window heading (for each view)
6. In ItemIsSelected, set the selection flag e.g. result:=(teAbsent[k]<>-1);
7. In BasicPoint set the sort order to use e.g. result:=abcodepoint[k];}


type TTimeSet=Class(Tcontrol)  {control with push buttons for each time slot }
   private
    All:        Tbutton;        {Button to select all time slots}
    None:        Tbutton;       {Button to select no time slots}
    procedure mybutton1click(Sender: TObject);  {changes button caption}
    procedure Allclick(Sender: TObject);   {sets all button captions}
    procedure NoneClick(Sender: TObject);   {clears all button captions}
   protected
    function SmallCase(i:integer): boolean; virtual;  {override to set case of button caption}
   public
    BaseGroup:         TGroupBox;   {group box to hold the buttons}
    ButtonHint:        String;    {button hint to show}
    ButtonChar:        Char;       {character used for button}
    button1:           array of tbitbtn;  {button array}
    perlab1,perlab2:   array of tlabel;   {label arrays}
    procedure makebuttons;   {creates and spaces the buttons}
    procedure ButtonShow(i:integer;show:boolean); {sets button caption based on smallcase function}
 end;

{Implementation
1. Define type and add method
e.g. type TAbsentTime=class(TTimeSet)
       protected
         function SmallCase(i:integer): boolean; override;
     end;
2. Define variable for the type e.g.  AbsentTime:    TAbsentTime;
3. In Form Create method, create the groupbox to hold the buttons and set its position.
  Set ButtonChar, ButtonHint, BaseGroup, and call makebuttons.
e.g.   AbsentTime:=TAbsentTime.create(GroupBox1);
       With AbsentTime do
        begin
         ButtonChar:='A';
         AbsentTime.Left:=10;
         AbsentTime.Top:=166;
         ButtonHint:='Toggles absence for time slot';
         BaseGroup:=GroupBox1;
         makebuttons;
        end;
4. In SmallCase function, set the condition where the button caption is lower case.
5. In the form's procedures, make use of the class methods and variables as needed
 e.g. if uppercase(AbsentTime.button1[i].caption)='A' then
}

 type TListWin=Class(TDrawWin)   {base class for list windows - student and timetable}
   protected
    procedure GetLists; virtual; abstract; {override to set NumOfLists and sizes of lists}
    procedure GetListContents(i: integer); virtual; abstract; {override to set list contents}
   public
    listtype: smallint;   {sets whether handled from class(student), or type of timetable}
    tabStField: smallint; {tab spacing of student fields being shown}
    NumOfLists: smallint;  {number of lists}
    TotalCount: integer;  {number of items in all the lists}
    ListSize: array of integer;  {number of items in each list}
    ListTop: array of integer;    {top y setting for each list}
    ListSet: array of integer;    {descriptor for list e.g. teacher, tutor, roll class}
    ListContents: array of integer;  {array pointing to items for a particular list}
    StBarCode1:   TStBarCode;
    procedure CalcTabStField;     {calculates tabStField based of preference settings}
    procedure SetArraySizes;      {sets array sizes needed based on NumOfLists}
    procedure ShowStudentNameBrief(i: integer);   {print student name and increment x}
    procedure ShowStudentHouse(i: integer);    {print student details and increment x}
    procedure ShowStudentName(i: integer);    {print student name and details, increment x}
    procedure ShowIDbarcode(i:integer;SelFlag:boolean);
    procedure BarcodeMake;
 end;
 {No implemenation - used as base class for other list classes}


 type TPrintListWin=Class(TPrintDrawWin)    {general list class for printing}
   protected
    procedure GetLists; virtual; abstract; {override to set NumOfLists and sizes of lists}
    procedure GetListContents(i: integer); virtual; abstract; {override to set list contents}
   public
    listtype: smallint;  {listtype=1 is handled from class, other types handled directly }
    tabStField: smallint;  {tab spacing of student fields being shown}
    NumOfLists: smallint;   {number of lists}
    TotalCount: integer;    {number of items in all the lists}
    ListSize: array of integer;  {number of items in each list}
    ListSet: array of integer;   {descriptor for list e.g. teacher, tutor, roll class}
    ListContents: array of integer;  {array pointing to items for a particular list}
    StBarCode1:   TStBarCode;
    procedure CalcTabStField;      {calculates tabStField based of preference settings}
    procedure SetArraySizes;       {sets array sizes needed based on NumOfLists}
    procedure ShowStudentNameBrief(i: integer);  {print student name and increment x}
    procedure ShowStudentHouse(i: integer);   {print student details and increment x}
    procedure ShowStudentName(i: integer);    {print student name and details, increment x}
    procedure PrintIDbarcode(i:integer);
    procedure BarcodeMake;
 end;
 {No implemenation - used as base class for other list classes}

  type TOutListWin=Class(TOutputWin)    {general list class for output}
   protected
    procedure GetLists; virtual; abstract; {override to set NumOfLists and sizes of lists}
    procedure GetListContents(i: integer); virtual; abstract; {override to set list contents}
   public
    listtype: smallint;  {listtype=1 is handled from class, other types handled directly }
    NumOfLists: smallint;   {number of lists}
    TotalCount: integer;    {number of items in all the lists}
    TabCount: smallint;   {number of tabs used in student name}
    ListSize: array of integer;  {number of items in each list}
    ListSet: array of integer;   {descriptor for list e.g. teacher, tutor, roll class}
    ListContents: array of integer;  {array pointing to items for a particular list}
    procedure SetArraySizes;       {sets array sizes needed based on NumOfLists}
    procedure ShowStudentNameBrief(i: integer);  {print student name}
    procedure ShowStudentHouse(i: integer);   {print student details}
    procedure ShowStudentName(i: integer);    {print student name and details}
    procedure CalcTotalCount;
    procedure CalcTabCount; {calculate name tabs}
 end;
 {No implemenation - used as base class for other list classes}



 type TStudListWin=Class(TListWin)   {class for showing student lists}
   private
    selbox,newrect: Trect;       {rectangle for selected student, and changing selection}
    procedure StudEnrolment(i:integer;SelFlag:boolean);  {prints choices in enrolment format}
    procedure DisplayStudent(i:integer;SelFlag:boolean);  {print a student}
    procedure PaintItemFull(pos,list:integer;SelFlag:boolean);
                   {calculate position,highlight if selected, show student}
    procedure CalcItemPosition(pos,list: integer);  {calculate position of student}
    procedure ShowLists;       {overall routine to show all lists}
    procedure HighlightBox(newrect:Trect);   {set colour and highlight box}
    procedure RemoveSelection(pos,list: integer); {remove highlight and repaint student}
   protected
    procedure ListHead(i:integer); virtual; abstract;   {override to print list heading}
    procedure ListFooter(i:integer);    {print footer of list - number of students in list}
    procedure PaintHead; virtual; abstract;    {main heading of all lists}
    procedure paint; override;     {class paints all student lists if listtype=1}
    procedure MouseDown(Button: TMouseButton;Shift: TShiftState; X1, Y1: Integer); override;
           {calculate  which list and item, remove existing selection, and select student}
   public
    StudSelect,ListSelect,Selcode: integer;   {student, list and item of selected student}
    StudHeight: integer;     {height for one student - pixels}
    StudLines: integer;      {lines for one student}
    ListHeadLines: integer;   {lines in list heading}
    EnrolFlag: boolean;        {flag for printing in enrolment format}
    ShowZeroList: boolean;      {if true, show empty lists (no items in list)}
    DoubleClick:        boolean;   {flag to set for mouse double click}
    procedure CalcArrayTops;    {calculates the top position of each list}
    procedure RedoSelection;    {find selcode and ListSelect for selected student}
    procedure ShowStudTt;       {show student timetable for selected student}
    procedure AfterConstruction; override;   { tabsDo:=true; SelCode:=0;}
 end;
 {Implementation
1. SubClass from TStudListWin e.g. TStudentListWin = class(TStudListWin)
2. Add required methods fo class e.g.
  protected
    procedure SetTabs; override;
    procedure GetLists; override;
    procedure GetListContents(i: integer); override;
    procedure PaintHead;  override;
    procedure ListHead(i:integer);  override;
3. In SetTabs
 (a) Set Length of Tabs array if needed for lists not printed by class e.g. SetLength(Tabs,8);
 (b) set ListType, codeColor, EnrolFlag, ShowZeroList, ListHeadLines
 (c) if ListType=1 then call GetLists and CalcArrayTops
 (c) call RedoSelection (in case Selection dialogue used with new settings)
4.  In GetLists
(a) Calculate how many lists (NumOfLists) and call SetArraySizes
(b) Calulated number of students in each list (ListSize array)
(c) Define ListSet to specify the list e.g. roll class code, tutor code, etc.
5. In GetListContents - set ListContents array size and set the array to the students in
the list.
e.g.  SetLength(ListContents,ListSize[i]+1);
 GeneralListContents(i,ListSize[i],ListSet[i],ListContents); - separate procedure so can
 be reused for printing
6.  In PaintHead - print the contents of the list
7.  In ListHead - print the heading for list i
8.  Paint - only need paint if also showing a student list not implemented in the class}


 type TPrintStudListWin=Class(TPrintListWin)  {class for printing student lists}
   private
    LastOne: boolean;      {last student to print}
    procedure StudEnrolment(i:integer);   {prints choices in enrolment format}
    procedure DisplayStudent(i:integer);  {print a student}
   protected
    procedure ListFooter(i:integer);  {print footer of list - number of students in list}
    procedure ListHead(i:integer); virtual; abstract;  {override to print list heading}
   public
    StudHeight: integer;   {height for one student - pixels}
    StudLines: integer;     {lines for one student}
    EnrolFlag: boolean;     {flag for printing in enrolment format}
    ShowZeroList: boolean;  {if true, show empty lists (no items in list)}
    procedure CalcHeights;  {calculates StudLines and StudHeight}
    procedure ShowLists;    {prints all student lists}
 end;
{Implementation
1.  Define type and methods to override e.g.
type TPrintStudList=class(TPrintStudListWin)
  public
   procedure head; override;
   procedure SetTabs; override;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i:integer); override;
 end;
2.  Define variable e.g. PrintStudList:    TPrintStudList;
3. In printing routine
(a) define instance of class
(b) if ListType=1 then call SetTabs and ShowLists, else do own printing
e.g.
 PrintStudList:=TPrintStudList.Create;
 with PrintStudList do
  try
   SetTabs;
   ShowLists;
  finally
   PrintStudList.free;
  end;
4. In Head, print overall list heading
5. In ListHead print heading for list i
6. In SetTabs
 (a) Set Length of PrntTabs array if needed for lists not printed by class
 (b) set ListType, codeColor, EnrolFlag, ShowZeroList
 (c) if ListType=1 then call GetLists and CalcHeights
7. In GetLists define number of lists and sizes.  Can reuse code from window e.g.
 NumOfLists:=StudentListWin.NumOfLists;
 SetArraySizes;
 if NumOfLists>0 then
  for i:=1 to NumOfLists do
   begin
    ListSize[i]:=StudentListWin.ListSize[i];
    ListSet[i]:=StudentListWin.ListSet[i];
   end;
 8. In GetListContents - set ListContents array size and set the array to the students in
the list.  Can re-use procedure from window}

 type TOutStudListWin=Class(TOutListWin)  {class for printing student lists}
   private
    LastOne: boolean;      {last student to print}
    procedure StudEnrolment(i:integer);   {prints choices in enrolment format}
    procedure DisplayStudent(i:integer);  {print a student}
   protected
    procedure ListFooter(i:integer);  {print footer of list - number of students in list}
    procedure ListHead(i:integer); virtual; abstract;  {override to print list heading}
   public
    EnrolFlag: boolean;     {flag for printing in enrolment format}
    ShowZeroList: boolean;  {if true, show empty lists (no items in list)}
    procedure ShowLists;    {prints all student lists}
 end;
{Implementation
1.  Define type and methods to override e.g.
type TOutStudList=class(TOutStudListWin)
  public
   procedure head; override;
   procedure SetTabs;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i:integer); override;
 end;
2.  Define variable e.g. OutStudList:    TOutStudList;
3. In printing routine
(a) define instance of class
(b) if ListType=1 then call SetTabs and ShowLists, else do own printing
e.g.
 OutStudList:=TOutStudList.Create;
 with OutStudList do
  try
   SetTabs;
   ShowLists;
  finally
   OutStudList.free;
  end;
4. In Head, print overall list heading
5. In ListHead print heading for list i
6. In SetTabs
 (a) set ListType, EnrolFlag, ShowZeroList
 (b) if ListType=1 then call GetLists and CalcTotalCount
7. In GetLists define number of lists and sizes.  Can reuse code from window e.g.
 NumOfLists:=StudentListWin.NumOfLists;
 SetArraySizes;
 if NumOfLists>0 then
  for i:=1 to NumOfLists do
   begin
    ListSize[i]:=StudentListWin.ListSize[i];
    ListSet[i]:=StudentListWin.ListSet[i];
   end;
 8. In GetListContents - set ListContents array size and set the array to the students in
the list.  Can re-use procedure from window}

 type TListTtWin=Class(TListWin)   {class for daily and weekly timetables}
   private
    WeeklyHeight: integer;    {height of weekly timetable}
    procedure DailyTt;   {prints daily timetables using list information}
    procedure WeeklyTt;   {prints weekly timetables using list information}
    Function DayListSize(i:integer):integer;  {size of day list}
   protected
    procedure ShowTtItems(i,d,p,x1: integer); virtual; abstract; {override to print cell in timetable}
    procedure ListHead(i,d:integer); virtual; abstract; {override to print list heading}
    procedure ShowName(i:integer); virtual; abstract;  {override to print name for timetable}
    procedure WeeklyFooter(i:integer);  virtual; abstract; {override to print weekly footer}
    procedure paint; override;
   public
    dx: smallint;      {spacing for timetable column}
    tab1: smallint;    {spacing at left of daily timetable}
    day1,day2: smallint;  {range of days for daily timetable}
    yFooter: smallint;   {spacing needed for weekly footer}
    procedure ShowDaily(studnum,dI: integer); {prints individual daily timetable}
    procedure ShowWeekly(studnum: integer);  {prints individual weekly timetable}
    procedure CalcArrayTops;   {calculates the top position of each list}
 end;
{Implementation
1. SubClass from TListTtWin e.g. TRoTtable = class(TListTtWin)
2. Add required methods fo class e.g.
  protected
    procedure SetTabs; override;
    procedure GetLists; override;
    procedure GetListContents(i: integer); override;
    procedure ShowTtItems(i,d,p,x1: integer); override;
    procedure ListHead(i,d:integer);  override;
    procedure ShowName(i:integer);  override;
    procedure WeeklyFooter(i:integer); override;
3. In SetTabs
(a) Set listtype (1=daily,2=weekly), codecolor, day1, day2, yFooter
(b) Calculate dx, tab1
(c) Call GetLists, CalcArrayTops
4. Implement GetLIsts,GetListContents,ListHead,ShowName (as in TStudListWin)
5. ShowTtItems - print the contents of the timetable cell
6. WeeklyFooter - print the required footer.}



 type TPrintListTtWin=Class(TPrintListWin)    {print list of timetables}
   private
    y2t,y1t: integer;    {y positions used for drawing lines}
    WeeklyHeight: integer;    {height of weekly timetable}
    procedure ShowDaily(var FirstOne:boolean; studnum,dI: integer); {prints individual daily timetable}
    procedure ShowWeekly(studnum: integer);  {prints individual weekly timetable}
   protected
    procedure ShowTtItems(i,d,p,x1: integer); virtual; abstract; {override to print cell in timetable}
    procedure ShowName(i:integer); virtual; abstract; {override to print name for timetable}
    procedure WeeklyFooter(i:integer);  virtual; abstract;
    procedure ListHead(i,d:integer); virtual; abstract;  {override to print list heading}
   public
    dx: smallint;   {spacing for timetable column}
    tab1: smallint;  {spacing at left of daily timetable}
    day1,day2: smallint;  {range of days for daily timetable}
    yFooter: smallint;    {spacing needed for weekly footer}
    procedure DailyTt;    {prints daily timetables using list information}
    procedure WeeklyTt;   {prints weekly timetables using list information}
    procedure PaintOnPrinter;  {prints all lists of timetables}
 end;
{Implementation
1.  Define type and methods to override e.g.
type TPrintRoTtWin=class(TPrintListTtWin)
  public
   procedure head; override;
   procedure SetTabs; override;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i,d:integer); override;
   procedure ShowName(i:integer);  override;
   procedure WeeklyFooter(i:integer); override;
   procedure ShowTtItems(i,d,p,x1: integer);  override;
 end;
2.  Define variable e.g. PrintRoTtWin:    TPrintRoTtWin;
3. In SetTabs
(a) Set listtype (1=daily,2=weekly), codecolor, day1, day2, yFooter
(b) Calculate dx, tab1
(c) Call GetLists
4. Implement GetLIsts,GetListContents,ListHead,ShowName (as in TPrintStudListWin)
5. ShowTtItems - print the contents of the timetable cell
6. WeeklyFooter - print the required footer.}


 type TOutListTtWin=Class(TOutListWin)    {print list of timetables}
   private
    procedure ShowDaily(studnum,dI: integer); {prints individual daily timetable}
    procedure ShowWeekly(studnum: integer);  {prints individual weekly timetable}
   protected
    procedure ShowTtItems(i,d,p: integer); virtual; abstract; {override to print cell in timetable}
    procedure ShowName(i:integer); virtual; abstract; {override to print name for timetable}
    procedure WeeklyFooter(i:integer);  virtual; abstract;
    procedure ListHead(i,d:integer); virtual; abstract;  {override to print list heading}
    procedure SetTabs; virtual; abstract;
   public
    day1,day2: smallint;  {range of days for daily timetable}
    procedure DailyTt;    {prints daily timetables using list information}
    procedure WeeklyTt;   {prints weekly timetables using list information}
    procedure PaintOnOutput;  {prints all lists of timetables}
 end;
{Implementation   ********  yet to do ************
1.  Define type and methods to override e.g.
type TOutRoTtWin=class(TOutListTtWin)
  public
   procedure head; override;
   procedure SetTabs; override;
   procedure GetLists; override;
   procedure GetListContents(i: integer); override;
   procedure ListHead(i,d:integer); override;
   procedure ShowName(i:integer);  override;
   procedure WeeklyFooter(i:integer); override;
   procedure ShowTtItems(i,d,p,x1: integer);  override;
 end;
2.  Define variable e.g. OutRoTtWin:    TOutRoTtWin;
3. In SetTabs
(a) Set listtype (1=daily,2=weekly), day1, day2
(b) Call GetLists
(c) set TabCount
4. Implement GetLIsts,GetListContents,ListHead,ShowName (as in TPrintStudListWin)
5. ShowTtItems - print the contents of the timetable cell
6. WeeklyFooter - print the required footer.}

implementation

uses tcommon,tcommon2,PrintPreviewForm,main;

// TDrawWin Procedures

destructor TDrawWin.Destroy;
begin
 winpos[tag].state:=windowstate;
 winpos[tag].top:=top;
 winpos[tag].left:=left;
 winpos[tag].width:=width;
 winpos[tag].height:=height;
 wnFlag[tag]:=false;
 inherited;
 mainform.UpdateToolbarIcons;
end;

procedure TDrawWin.Activate;
begin
 inherited;
 mainform.UpdateToolbarIcons;
end;

constructor TDrawWin.Create(AOwner: TComponent);
begin
 inherited;
 self.VertScrollBar.Tracking:=true;
 self.HorzScrollBar.Tracking:=true;
 self.OnMouseWheelDown:=MyMouseWheelDown;
 self.OnMouseWheelUp:=MyMouseWheelUp;
end;

procedure TDrawWin.SetTabs;
begin
 tabsDo:=false;
end;

procedure TDrawWin.SetScrollRange;
begin
 if maxW<Headwidth then maxW:=Headwidth;
 if maxH>maxWinScrollRange then maxH:=maxWinScrollRange;
 if (maxW+Hmargin)>maxWinScrollRange then maxW:=maxWinScrollRange-Hmargin;
 horzscrollbar.range:=maxW+Hmargin;
 vertscrollbar.range:=maxH;
end;

procedure TDrawWin.paint;
begin
 SetScroll;
 if tabsDo then
  begin
   maxW:=0;
   canvas.font.assign(tcfont);
   setTabs;
   SetScrollRange;
   Invalidate;
  end;
 tabsDo:=false;
 inherited;
end;

procedure TDrawWin.UpdateWin;
begin
 tabsDo:=True;
 repaint;
end;

procedure TDrawWin.ChangeView;
begin
 inc(winView[tag]);
 if winView[tag]>winViewMax[tag] then winView[tag]:=0;
 UpdateWin;
end;

procedure TDrawWin.printMap(ss: string);
var
 i,j,oldCol,oldBack:  integer;
 Arect: Trect;
begin
 oldCol:=canvas.font.color;
 oldBack:=canvas.brush.color;
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
   fcolor(j);
   Arect.top:=y; Arect.bottom:=y+TxtHeight;
   Arect.left:=x+Hmargin-Hscroll;
   Arect.right:=x+Hmargin-Hscroll+letterW;
   fcolor(j);
   canvas.fillrect(Arect);
   printw(ss[i]);  inc(x,letterW);
 end; {for i}
 canvas.font.color:=oldCol;
 canvas.brush.color:=oldBack;
end;

procedure TDrawWin.HomeEndPageUpDown(var key: word);
var
 t,r,hs:       integer;
 t2,horzr,horzw:       integer;
 vertCorrect:   integer;
begin
 if key=0 then exit;
 t:=vertscrollbar.position;
 r:=vertscrollbar.range;
 hs:=horzscrollbar.increment;
 t2:=horzscrollbar.position;
 horzr:=horzscrollbar.range;
 horzw:=clientwidth;
 vertCorrect:=0;
 if txtHeight<clientHeight then vertCorrect:=txtHeight;
 case key of
  vk_prior: begin  {page up}
             t:=t-clientheight+vertCorrect;
             if t<0 then t:=0;
             vertscrollbar.position:=t;
            end;
  vk_next: begin  {page down}
             t:=t+clientheight-vertCorrect;
             if t>(r-clientheight) then t:=r-clientheight;
             vertscrollbar.position:=t;
            end;
  vk_home: vertscrollbar.position:=0;   {home}
  vk_end: vertscrollbar.position:=r-clientheight;  {end}
  { 4 arrow keys }
  vk_up:  begin
           t:=t-txtHeight;  if t<0 then t:=0;
           vertscrollbar.position:=t;
          end;
  vk_down: begin
            t:=t+txtHeight;
            if t>(r-clientheight) then t:=r-clientheight;
            vertscrollbar.position:=t;
           end;
  vk_left:  begin
             t2:=t2-hs;
             if t2<0 then t2:=0;
             horzscrollbar.position:=t2;
            end;
  vk_right: begin
             t2:=t2+hs;
             if t2>(horzr-horzw) then t2:=horzr-horzw;
             horzscrollbar.position:=t2;
            end;

 end; {case}

end;

procedure TDrawWin.KeyDown(var Key: Word; Shift: TShiftState);
begin
 if (uppercase(chr(key))='V') and (winViewMax[tag]>0) then
  begin
   ChangeView;
   key:=0;
  end;
 HomeEndPageUpDown(key);
 inherited;
end;

procedure TDrawWin.MyMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
 VertScrollBar.Position:=VertScrollBar.Position+100;
end;

procedure TDrawWin.MyMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
 VertScrollBar.Position:=VertScrollBar.Position-100;
end;

procedure TDrawWin.SetScroll;
begin
  Hscroll:=self.HorzScrollBar.Position;
  Vscroll:=self.VertScrollBar.Position;
  topCutoff:=-2*txtHeight;
  bottomCutoff:=Height+txtHeight;
  leftCutoff:=Hscroll-Hmargin;
  rightCutoff:=leftCutoff+Width+Hmargin;
  if rightCutoff>maxWinScrollRange then rightCutoff:=maxWinScrollRange;
  x:=0;  y:=txtHeight-Vscroll;
end;

procedure TDrawWin.printw(a:string);
 var
  x1,x2:   integer;
 begin
  x1:=x+Hmargin;
  x2:=x1+canvas.textwidth(a);

  if (y>topCutoff) and (x2>leftCutoff) and (x1<rightCutoff)
       then canvas.textout(x+Hmargin-Hscroll,y,a);
 end;

procedure TDrawWin.printwl(a:string);
begin
 printw(a);
 x:=x+canvas.textwidth(a);
end;

procedure TDrawWin.fcolor(fcol:integer);
  begin
    canvas.font.color:=FontColorPair[fcol,1];
    canvas.brush.color:=FontColorPair[fcol,2];
  end;

procedure TDrawWin.printw2(a,b:string);
  begin
    fcolor(cpNormal);
    printwl(a);
    fcolor(codeColor);
    printwl(b);
  end;

procedure TDrawWin.newline;
var
  lineheight:integer;
 begin
   lineheight:=txtHeight;
   if StBarcode then lineheight:=round(lineheight*1.5);

   x:=0; y:=y+lineheight;
 end;

procedure TDrawWin.drawMyLine(x1,y1,x2,y2: integer);
begin
  canvas.moveto(x1+Hmargin-Hscroll,y1);
  canvas.lineto(x2+Hmargin-Hscroll,y2);
end;

procedure TDrawWin.Maxtab(i,tab:integer;s:string);
var
 temp: integer;
begin
 temp:=canvas.textwidth(s);
 if tab>temp then temp:=tab;
 Tabs[i]:=Tabs[i-1]+temp+blankwidth;
end;

// TPrintDrawWin procedures

procedure TPrintDrawWin.AfterConstruction;
begin
 TabsDo:=true;
 if PrinterOn then
  begin
   PrintCanvas:=Printer.Canvas;
   PrintPageHeight:=Printer.PageHeight;
   PrintPageWidth:=Printer.PageWidth;
  end
 else if PreviewOn then
  begin
   PrintCanvas:=PrntPreviewForm.PrintPreview.Canvas;
   PrintPageHeight:=PrntPreviewForm.PrintPreview.PageHeight;
   PrintPageWidth:=PrntPreviewForm.PrintPreview.PageWidth;
  end;
end;

procedure TPrintDrawWin.PrintHead;
begin
 if TabsDo then SetTabs;
 TabsDo:=false;
 x:=0;    y:=prntVmargin;
 fcolor(cpNormal);
 header;
end;

procedure TPrintDrawWin.UnderlineOn;
begin
 PrintCanvas.font.style:=PrintCanvas.font.style+[fsunderline];
end;

procedure TPrintDrawWin.UnderlineOff;
begin
 PrintCanvas.font.style:=PrintCanvas.font.style-[fsunderline];
end;

procedure TPrintDrawWin.header;
begin
  y := PrntVmargin;
  //UnderlineOn;
  Printwl(School + '  -  ' + version);
  Newline;
  if datestamp then
  begin
    Printwl('  ' + dateStr);
    Printwl('  ' + TimeToStr(time));
  end;
  x := 0;
  y := y + PrnttxtHeight;
  UnderlineOff;
  head;
end;

procedure TPrintDrawWin.printw(a:string);
begin
 PrintCanvas.textout(x+prntHmargin,y,a);
end;

procedure TPrintDrawWin.printwl(a:string);
begin
 printw(a);
 x:=x+PrintCanvas.textwidth(a);
end;

procedure TPrintDrawWin.fcolor(fcol:integer);
begin
 if colorPrinterFlag then
  begin
   PrintCanvas.font.color:=FontColorPair[fcol,1];
   PrintCanvas.brush.color:=FontColorPair[fcol,2];
  end;
end;

procedure TPrintDrawWin.printw2(a,b:string);
begin
 fcolor(cpNormal);
 printwl(A);
 fcolor(codeColor);
 printwl(b);
end;

procedure TPrintDrawWin.printw3(a: string);
var
  r: TRect;
begin
  r := Rect(10, 10, 60, 60);
  DrawText(PrintCanvas.Handle,
    PChar(a),
    Length(a),
    r,
    DT_LEFT or DT_WORDBREAK or DT_CALCRECT);

  DrawText(PrintCanvas.Handle,
    PChar(a),
    Length(a),
    r,
    DT_LEFT or DT_WORDBREAK);
end;

procedure TPrintDrawWin.StartNewPage;
begin
 if PrinterOn then Printer.newpage
  else if PreviewOn then
  begin
   PrntPreviewForm.PrintPreview.NewPage;
   PrintCanvas:=PrntPreviewForm.PrintPreview.Canvas;
   PrntPreviewForm.PrintPreview.canvas.Font.Assign(PreviewFont);
  end;
 x:=0; y:=prntVmargin;
end;

procedure TPrintDrawWin.newline;
var
  lineheight:integer;
begin
  lineheight:=PrntTxtHeight;
 if StBarcode then lineheight:=round(lineheight*1.5);
 
 x:=0; y:=y+lineheight;
 if (y+PrnttxtHeight)>(PrintPageHeight-2*prntTxtHeight) then
   begin
    StartNewPage;
    Header;
   end;
end;

procedure TPrintDrawWin.drawMyLine(x1,y1,x2,y2: integer);
begin
  PrintCanvas.moveto(x1+prntHmargin,y1);
  PrintCanvas.lineto(x2+prntHmargin,y2);
end;

function TPrintDrawWin.PageCount:string;
var
 mypagenumber: integer;
begin
 mypagenumber:=1;
 if PrinterOn then mypagenumber:=Printer.PageNumber
  else if PreviewOn then mypagenumber:=1+PrntPreviewForm.PrintPreview.TotalPages;
 result:='';
 if mypagenumber>1 then
   result:='  Page '+inttostr(mypagenumber);
end;

procedure TPrintDrawWin.printCustomAddon;
var
 i:       integer;
begin
 fcolor(cpNormal);
 parseCustomInfo;
 if CustomCnt=0 then exit;
 newline;
 fcolor(cpNormal);
 for i:=1 to CustomCnt do
 begin
  printw(CustomArr[i]);
  newline;
 end;
end;

procedure TPrintDrawWin.Maxtab(i,tab:integer;s:string);
var
 temp: integer;
begin
 temp:=PrintCanvas.textwidth(s);
 if tab>temp then temp:=tab;
 PrntTabs[i]:=PrntTabs[i-1]+temp+PrntBlankwidth;
end;

procedure TPrintDrawWin.printMap(ss: string);
var
 i,j,oldCol,oldBack:  integer;
 Arect: Trect;
begin
 oldCol:=PrintCanvas.font.color;
 oldBack:=PrintCanvas.brush.color;
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
  fcolor(j);
  Arect.top:=y; Arect.bottom:=y+prntTxtHeight;
  Arect.left:=x+prntHmargin;
  Arect.right:=x+prntHmargin+letterWprnt;
  fcolor(j);
  PrintCanvas.fillrect(Arect);
  printw(ss[i]);  inc(x,letterWprnt);
 end; {for i}
 PrintCanvas.font.color:=oldCol;
 PrintCanvas.brush.color:=oldBack;
end;

// TOutputWin procedures

procedure TOutputWin.printCustomAddon;
var
 i:       integer;
begin
 parseCustomInfo;
 if CustomCnt=0 then exit;
 newline;
 for i:=1 to CustomCnt do
 begin
  printw(CustomArr[i]);
  newline;
 end;
end;

procedure TOutputWin.newline;
begin
 OutStream.Write(Pchar(EndLineOut)^,length(EndLineOut));
end;

procedure TOutputWin.printw(a:string);
var
 b: string;
begin
 b:=delim2+a+delim2;
 OutStream.Write(Pchar(b)^,length(b))
end;

procedure TOutputWin.printc(a:string);
var
 b: string;
begin
 b:=delim+delim2+a+delim2;
 OutStream.Write(Pchar(b)^,length(b))
end;

procedure TOutputWin.printLine(const a:array of string);
var
 i: integer;
begin
 printw(a[Low(a)]);
 if High(a)>Low(a) then
  for i:=Low(a)+1 to High(a) do printc(a[i]);
 newline;
end;

procedure TOutputWin.header;
begin
 printw(School); printc(version);
 if datestamp then
   begin
    printc(dateStr);
    printc(timetostr(time));
   end;
 newline;
 head;
end;

procedure TOutputWin.AfterConstruction;
begin
 if TextFileOut then
  begin
   OutStream:=TFileStream.Create(TextFileName,fmCreate or fmOpenWrite);
   delim:=chr(txtsep);
   delim2:=chr(txtlim); if txtlim=0 then delim2:='';
   EndLineOut:=endline;
  end
 else if CopyOut then
  begin
   OutString:='';
   OutStream:=TStringStream.Create(OutString);
   delim:=ht;delim2:='';
   EndLineOut:=endline;
  end;
end;

destructor TOutputWin.Destroy;
begin
 if CopyOut then
  myCopyString:=TStringStream(OutStream).DataString;
 OutStream.Free;
 Inherited;
end;

// TCodeWin procedures

procedure TCodeWin.CalcScreenCodeFit;
var
  tmpInt: Integer;
begin
  //tmpInt:=trunc(screen.width*0.9);
  tmpInt := Trunc(Self.Width - HMargin);
  if CodeWidth <> 0 then
    CodeFit := tmpInt div CodeWidth
  else
    CodeFit := 0;

  // tmpInt:=trunc(screen.width*0.9);
  // CodeFit:= tmpInt div CodeWidth;
  if CodeFit<minCodeFit then CodeFit:=minCodeFit;
  if CodeFit>TotalCodes then CodeFit:=TotalCodes;
  if Codefit=0 then Codefit:=1;
  if winView[tag]>0 then Codefit:=1;
  maxH:=txtheight*((TotalCodes div CodeFit)+5)
end;

procedure TCodeWin.PaintItemFull(i:integer;SelFlag:boolean);
begin
 CalcItemPosition(i);
 if (y<topCutoff) or (y>bottomCutoff) then exit;
 if selFlag then HighlightBox(newrect);
 PaintItem(i,SelFlag);
end;

procedure TCodeWin.paint;
var
 i: integer;
 SelFlag:       boolean;
begin
 inherited;
 if (selcode<0) or (selcode>Totalcodes) then
  begin
   selcode:=0; Fselbox.left:=0; Fselbox.top:=0; Fselbox.bottom:=0; Fselbox.right:=0;
  end;
 canvas.fillrect(selbox);
 Fselbox.left:=0; Fselbox.top:=0; Fselbox.bottom:=0; Fselbox.right:=0;
 PaintHead;
 fcolor(codecolor); yHead:=y;
 if TotalCodes>0 then
   for i:=1 to TotalCodes do
     begin
      selFlag:=(selCode>0) and (i=selCode);
      PaintItemFull(i,SelFlag);
      if y>bottomCutoff then break; {no printing past range}
     end;  {for i  to totalcodes}
end;

procedure TCodeWin.HighlightBox(newrect:Trect);
begin
 SelBox:=newrect;
 canvas.font.color:=FontColorHiLitePair[codeColor,1];
 canvas.brush.color:=FontColorHiLitePair[codeColor,2];
 canvas.fillrect(selbox);
end;

procedure TCodeWin.CalcItemPosition(i:integer);
begin
 if winView[tag]=0 then
   begin
     x:=((i-1) mod codefit)*CodeWidth;
     y:=yHead + ((i-1) div codefit)*txtHeight;
     newrect.left:=x+Hmargin-Hscroll;
     newrect.right:=newrect.left+CodeWidth-blankWidth;
   end
 else
   begin
    x:=0; y:=yHead +(i-1)*txtHeight;
    newrect.left:=x+Hmargin-Hscroll;
    newrect.right:=newrect.left+maxW;
   end;
 newrect.top:=y; newrect.bottom:=y+TxtHeight;
end;

constructor TCodeWin.Create(AOwner: TComponent);
begin
 inherited;
 myselect:=0;
end;

function TCodeWin.MyCodePoint(i:integer): integer;
begin
 result:=i;
end;

procedure TCodeWin.RedoSelection;
var
 i: integer;
begin
 SelCode:=0;
 if MySelect>0 then
  for i:=1 to TotalCodes do
   if MySelect=MyCodePoint(i) then
    begin SelCode:=i; break; end;
end;

procedure TCodeWin.MouseDown(Button: TMouseButton;Shift: TShiftState; X1, Y1: Integer);
var
 xx,yy:  integer;
 newselcode: integer;
begin
 if doubleclick then
   begin
    doubleclick:=false;
    exit;
   end;

 if winView[tag]=0 then
 begin
  xx:=((x1-Hmargin+Hscroll) div CodeWidth)+1;
  if (xx>Codefit) then xx:=Codefit;
  yy:=((y1-yHead) div txtHeight);
  newselcode:=xx+yy*Codefit;
 end
 else  {not winView[tag]=0}
  begin
   yy:=((y1-yHead) div txtHeight);
   newselcode:=yy+1;
  end;
 if (y1+Vscroll)<=(yHead) then newselcode:=0;
 if ((newselcode>0) and (newselcode<=TotalCodes)
      and (newselcode<>selCode)) then
 begin
  if selCode>0 then
  begin
   canvas.fillrect(selbox);
   PaintItemFull(selcode,false);
  end;
  selCode:=newselcode;
  PaintItemFull(selcode,true);
 end;
 if SelCode>0 then MySelect:=MyCodePoint(SelCode) else MySelect:=0;
end;

// TPrintCodeWin procedures


procedure TPrintCodeWin.CalcPrintCodeFit;
var
 tmpInt: integer;
begin
 tmpInt:=trunc(PrintPageWidth*0.9)-prntHmargin;
 CodeFit:= tmpInt div Codewidth;
 if CodeFit>TotalCodes then CodeFit:=TotalCodes;
 if Codefit=0 then Codefit:=1;
end;

// TOutCodeWin procedures

procedure TOutCodeWin.CalcPrintCodeFit;
begin
 CodeFit:=10;
 if CodeFit>TotalCodes then CodeFit:=TotalCodes;
 if Codefit=0 then Codefit:=1;
end;

procedure TOutCodeWin.Setup(setTotal: smallint);
begin
 TotalCodes:=setTotal;
 FirstInLine:=true;
 CalcPrintCodeFit;
 Header;
end;

procedure TOutCodeWin.PrintCode(i:integer);
begin
 if FirstInLine then
   begin printw(CodeToPrint(i)); FirstInLine:=false; end
  else printc(CodeToPrint(i));
  if (i mod codefit)=0 then begin newline;FirstInLine:=true; end;
end;

//  TLineCodeWin procedures

procedure TLineCodeWin.CalcItemPosition(i:integer);
begin
 x:=0; y:=yHead +(i-1)*txtHeight;
 newrect.left:=x+Hmargin-Hscroll;
 newrect.right:=newrect.left+maxW;
 newrect.top:=y; newrect.bottom:=y+TxtHeight;
end;

procedure TLineCodeWin.MouseDown(Button: TMouseButton;Shift: TShiftState; X1, Y1: Integer);
var
 yy:  integer;
 newselcode: integer;
begin
 if doubleclick then
   begin
    doubleclick:=false;
    exit;
   end;
 yy:=((y1-yHead) div txtHeight);
 newselcode:=yy+1;
 if (y1+Vscroll)<=(yHead) then newselcode:=0;
 if ((newselcode>0) and (newselcode<=TotalCodes)
      and (newselcode<>selCode)) then
 begin
  if selCode>0 then
  begin
   canvas.fillrect(selbox);
   PaintItemFull(selcode,false);
  end;
  selCode:=newselcode;
  PaintItemFull(selcode,true);
 end;
end;

//  TSelectCodeWin procedures


procedure TSelectCodeWin.CalcItemPoint;
var
 i,num:    integer;
begin
 SetLength(ItemPoint,MaxItemPoint+1);
 if winView[tag]=winViewMax[tag] then
  begin
   num:=0;
   for i:=1 to MaxItemPoint do
    if ItemIsSelected(BasicPoint(i)) then
     begin inc(num);ItemPoint[num]:=BasicPoint(i); end;
   TotalCodes:=num;
  end
 else
  begin
   TotalCodes:=MaxItemPoint;
   for i:=1 to MaxItemPoint do ItemPoint[i]:=BasicPoint(i);
  end;
end;

procedure TSelectCodeWin.ChangeView;
var
 i: integer;
begin
 if selCode>0 then selCode2:=itemPoint[selCode];
 inc(winView[tag]);
 if winView[tag]>winViewMax[tag] then winView[tag]:=0;
 CalcItemPoint;
 selCode:=0;
 if selCode2>0 then
   for i:=1 to TotalCodes do if ItemPoint[i]=selCode2 then
     begin selCode:=i; break; end;
 UpdateWin;
end;

procedure TSelectCodeWin.PaintItemFull(i:integer;SelFlag:boolean);
var
 oldCol: integer;
begin
 oldCol:=CodeColor;
 CalcItemPosition(i);
 if (y<topCutoff) or (y>bottomCutoff) then exit;
 if itemIsSelected(ItemPoint[i]) then
  begin codeColor:=codeColor2; fcolor(codeColor2); end;
 if selFlag then HighlightBox(newrect);
 PaintItem(i,SelFlag);
 CodeColor:=oldCol; fcolor(codeColor);
end;


//  TTimeSet procedures


function TTimeSet.SmallCase(i:integer): boolean;
begin
 result:=false;
end;

procedure TTimeSet.AllClick(Sender: TObject);
var
 i:       integer;
begin
 for i:=1 to tlimit[ttDay] do ButtonShow(i,True);
 BaseGroup.SetFocus;
end;

procedure TTimeSet.NoneClick(Sender: TObject);
var
 i:       integer;
begin
 for i:=1 to tlimit[ttDay] do button1[i].caption:='';
 BaseGroup.SetFocus;
end;

procedure TTimeSet.ButtonShow(i:integer;show:boolean);
begin
 if show then
  begin
   if SmallCase(i) then button1[i].caption:=LowerCase(ButtonChar)
    else button1[i].caption:=ButtonChar;
  end
   else button1[i].caption:='';
end;

procedure TTimeSet.mybutton1click(Sender: TObject);
var
 i:integer;
 show: boolean;
begin
 if sender is TbitBtn then
  begin
   i:=tbitbtn(Sender).tag;
   show:=(button1[i].caption='');
   ButtonShow(i,show);
   BaseGroup.SetFocus;
  end;
end;

Procedure TTimeSet.makebuttons;
const ButtonH=17;  xgap=3; ygap=3; ButtonW=15;
var
 i,xpos: integer;
begin
 SetLength(button1,1+Tlimit[ttday]);  SetLength(perlab1,1+Tlimit[ttday]);
 SetLength(perlab2,1+Tlimit[ttday]);

 All:=Tbutton.Create(BaseGroup);
 All.Left:=left; All.Top:=top;
 All.Height:=ButtonH; All.Caption:='&All';
 All.Width:=37; All.font.style:=[fsbold];
 All.Parent:=BaseGroup; All.onclick:=Allclick;

 for i:=1 to Tlimit[ttday] do
   begin
    button1[i]:=tbitbtn.create(BaseGroup);
    button1[i].tag:=i;
    button1[i].width:=ButtonW;
    button1[i].height:=ButtonH;
    button1[i].Parent:=BaseGroup;
    button1[i].hint:=ButtonHint;{'Toggles absence for time slot'; }
    button1[i].font.style:=[fsbold];
    button1[i].font.color:=clred;
    button1[i].caption:='';
    xpos:=left+37+xgap+(i-1)*(ButtonW+xgap);
    button1[i].left:=xpos;
    button1[i].Top:=top;
    button1[i].visible:=true;
    button1[i].onclick:=mybutton1click;

    perlab1[i]:=tlabel.create(BaseGroup);
    perlab1[i].tag:=i;
    perlab1[i].parent:=BaseGroup;
    perlab1[i].caption:=' '+tslotcode[i,ttday];
    perlab2[i]:=tlabel.create(BaseGroup);
    perlab2[i].tag:=i;
    perlab2[i].font.color:=clblue;
    perlab2[i].parent:=BaseGroup;

    {if j>0 then perlab2[i].caption:=' '+temap[j][i]
     else perlab2[i].caption:=''; }

    perlab1[i].visible:=true;
    perlab2[i].visible:=true;
    perlab1[i].left:=button1[i].left;
    perlab2[i].left:=button1[i].left;

    perlab1[i].top:=button1[i].top-perlab1[1].height-ygap;
    perlab2[i].top:=button1[i].top+button1[i].height+ygap;
   end; {for i}

 xpos:=left+37+xgap+Tlimit[ttday]*(ButtonW+xgap);
 None:=Tbutton.Create(BaseGroup);
 None.Left:=xpos; None.Top:=top;
 None.Height:=ButtonH; None.Caption:='&None';
 None.Width:=37; None.font.style:=[fsbold];
 None.Parent:=BaseGroup; None.onclick:=NoneClick;

end;

//  TListWin procedures

procedure TListWin.SetArraySizes;
begin
 SetLength(ListSize,NumOfLists+2);
 SetLength(ListTop,NumOfLists+2);
 SetLength(ListSet,NumOfLists+2);
end;

procedure TListWin.ShowStudentNameBrief(i: integer);
begin
 canvas.font.color:=FontColorPair[cpStList,1]; {as in student list}
 x:=blankwidth div 3;
 printw(Stud[i].stname+' '+Stud[i].first);
 inc(x,fwStname+blankwidth);
end;

procedure TListWin.ShowStudentHouse(i: integer);
begin
 if sTyear then
  begin
   printw(yearname[Stud[i].TcYear]);
   inc(x,fwyearname+blankwidth);
  end;
 if stSex then
  begin
   printw(Stud[i].Sex);
   inc(x,fwSex+blankwidth);
  end;
 if stID then
  begin
   printw(Stud[i].ID);
   inc(x,fwID+blankwidth);
  end;
 //if stBarcode then
 // begin
 //   printw('*'+Stud[i].ID+'*');
 //   inc(x,fwID+2+blankwidth);
 // end;
 if stClass then
  begin
   printw(ClassCode[Stud[i].Tcclass]);
   inc(x,fwClass+blankwidth);
  end;
 if stHouse then
  begin
   printw(HouseName[Stud[i].house]);
   inc(x,fwHouse+blankwidth);
  end;
 if stTutor then
  begin
   printw(Tecode[Stud[i].tutor,0]);
   inc(x,fwcode[1]+blankwidth);
  end;
 if stHome then
  begin
   printw(Tecode[Stud[i].home,1]);
   inc(x,fwcode[2]+blankwidth);
  end;
end;

procedure TListWin.showStudentName(i: integer);
begin
 ShowStudentNameBrief(i);
 ShowStudentHouse(i);
end;

procedure TListWin.CalcTabStField;
begin
 TabStField:=0;
 if sTyear then inc(TabStField,(fwyearname+blankwidth));
 if sTsex then inc(TabStField,(fwSex+blankwidth));
 if sTclass then inc(TabStField,(fwclass+blankwidth));
 if sThouse then inc(TabStField,(fwhouse+blankwidth));
 if sTtutor then inc(TabStField,(fwcode[1]+blankwidth));
 if sThome then inc(TabStField,(fwcode[2]+blankwidth));
 if sTID then inc(TabStField,(fwID+blankwidth));
 //if stBarcode then inc(TabStField, (fwID+2+blankwidth));
 
end;

procedure TListWin.BarcodeMake;
begin
 StBarCode1:=TStBarCode.Create(self);
 StBarCode1.BarCodeType:=bcCode128;
 StBarCode1.BarColor:=clBlack;
 StBarCode1.BarToSpaceRatio:=1;
 StBarCode1.BarWidth:=12;
 StBarCode1.BearerBars:=true;
 StBarCode1.Code128Subset:=csCodeB;
 StBarCode1.ShowGuardChars:=true;
 StBarCode1.TallGuardBars:=true;
 StBarCode1.Height:=68;
 StBarCode1.Width:=130;
 StBarCode1.ShowCode:=false;
end;

procedure TListWin.ShowIDbarcode(i:integer;SelFlag:boolean);
var
 ar:                   trect;
 IDlen:  smallint;
 mx,my:     integer;
begin
 if trim(Stud[i].ID)>'' then
  begin
   IDlen:=CalcIDlen;
   mx:=x; my:=y;
//   dec(y,txtheight div 2);
   if StBarcode1=nil then BarCodeMake;

   inc(x,StBarCode1.width div 3);
   ar.top:=y; ar.bottom:=y+2*txtheight;
   ar.left:=x+Hmargin-Hscroll; ar.right:=ar.left+StBarCode1.width;
   StBarcode1.code:=RpadString(Stud[i].ID,idlen);
   if SelFlag then stbarcode1.color:=FontColorHiLitePair[codeColor,2]
    else stbarcode1.color:=FontColorPair[codeColor,2];
   StBarcode1.paintToCanvas(Canvas,ar);
   x:=mx; y:=my;
  end;
 newline; if double_space then newline;
end;

//  TStudListWin procedures

procedure TStudListWin.AfterConstruction;
begin
 tabsDo:=true;
 SelCode:=0;
end;

procedure TStudListWin.CalcItemPosition(pos,list:integer);
begin
 GetListContents(list);
 StudSelect:=ListContents[pos];
 x:=0; y:=ListTop[List]+ListHeadLines*TxtHeight*double_print+StudHeight*(pos-1)-Vscroll;
 newrect.left:=x+Hmargin-Hscroll;  newrect.right:=newrect.left+maxW;
 newrect.top:=y; newrect.bottom:=y+StudHeight;
end;

procedure TStudListWin.HighlightBox(newrect:Trect);
begin
 SelBox:=newrect;
 canvas.font.color:=FontColorHiLitePair[codeColor,1];
 canvas.brush.color:=FontColorHiLitePair[codeColor,2];
 canvas.fillrect(selbox);
end;

procedure TStudListWin.PaintItemFull(pos,list:integer;SelFlag:boolean);
var
 oldCol: integer;
begin
 oldCol:=CodeColor;
 CalcItemPosition(pos,list);
 if (y<(topCutoff-2*StudHeight)) or (y>bottomCutoff) then exit;
 if selFlag then HighlightBox(newrect);
 DisplayStudent(StudSelect,SelFlag);
 CodeColor:=oldCol; fcolor(codeColor);
end;

procedure TStudListWin.RemoveSelection(pos,list: integer);
begin
 CalcItemPosition(pos,list);
 canvas.fillrect(newrect);
 PaintItemFull(pos,list,false);
end;

procedure TStudListWin.RedoSelection;
var
 i,j: integer;
begin
 if (ListType<>1) or (selcode<1) then
  begin
   selcode:=0;
   exit;
  end;
 selcode:=0; ListSelect:=0;
 for i:=1 to NumOfLists do
  begin
   if ListSize[i]>0 then
    begin
     GetListContents(i);
     for j:=1 to ListSize[i] do
      if ListContents[j]=StudSelect then begin selcode:=j; ListSelect:=i; break; end;
    end;
   if selcode>0 then break;
  end;
end;

procedure TStudListWin.ShowStudTt;
begin
 if selcode>0 then
 begin
  stuttlistselection:=1; {selection}
  winView[wnStudentTt]:=1; {weekly}
  studentttselection[0]:=1;
  studentttselection[1]:=StudSelect;
  stuttlistvals[3]:=0; {class;}
  stuttlistvals[4]:=0; {tmphouse; }
  stuttlistvals[5]:=0; {tmptutor; }
  stuttlistvals[6]:=0; {room;  }
  studentTtablewinSelect;
  UpdateWindow(wnStudentTt);
 end;
end;

procedure TStudListWin.MouseDown(Button: TMouseButton;Shift: TShiftState; X1, Y1: Integer);
var
 yy,i:  integer;
 newselcode,NewListSelect: integer;
begin
 if listtype<>1 then exit; {selection only for student lists}
 if doubleclick then
   begin
    doubleclick:=false;
    exit;
   end;
 yy:=y1+Vscroll;
 newListSelect:=0;
 for i:=1 to NumOfLists do
  if yy>ListTop[i] then newListSelect:=i;
 if newListSelect=0 then exit;
 yy:=yy-ListTop[newListSelect]-ListHeadLines*TxtHeight*double_print;
 newselcode:=1+(yy div StudHeight);
 if (newselcode<1) or (newselcode>ListSize[newListSelect]) then exit;
 if (newselcode<>selcode) or (NewListSelect<>ListSelect) then
  begin
   if selCode>0 then RemoveSelection(selcode,ListSelect);
   selCode:=newselcode;
   ListSelect:=NewListSelect;
   PaintItemFull(selcode,ListSelect,true);
  end;
end;

procedure TStudListWin.StudEnrolment(i:integer;SelFlag:boolean);
var
 j,su: integer;
 te,ro: smallint;
begin
 printw(':'); newline; if double_space then newline;
 for j:=1 to chmax do
  begin
   su:=Stud[i].Choices[j];
   if trim(SubCode[su])>'' then
    begin
     if SelFlag then canvas.font.color:=FontColorHiLitePair[cpSub,1]
          else canvas.font.color:=FontColorPair[cpSub,1];
     x:=0; printw('    '+SubCode[su]+': ');
     x:=fwCode[0]+blankwidth*5; printw(Subname[su]);
     findteacher(i,j,te,ro,MatchAllYears);
     if trim(TeCode[te,0])>'' then
       begin
        canvas.font.color:=FontColorPair[cpTeach,1];
        x:=fwCode[0]+blankwidth*5+fwCodename[0];
        printw('    '+TeCode[te,0]+': ');
        x:=fwCode[0]+blankwidth*5+fwCodename[0]+fwCode[1]+blankwidth*3;
        printw(TeName[te,0]);
       end;
    end;
   newline; if double_space then newline;
  end; {for j}
 newline; if double_space then newline;
 fcolor(codecolor);
end;

procedure TStudListWin.DisplayStudent(i:integer;SelFlag:boolean);
var
 j,su:       integer;
 tab: integer;
begin
 x:=0;
 if y>bottomCutoff then exit; {no printing past range}
 ShowStudentName(i); tab:=x;
 if stBarcode then ShowIDbarcode(i,SelFlag);
 if EnrolFlag then begin StudEnrolment(i,SelFlag); exit; end;
 case sTselect of
   1: begin    {other subs}
       for j:=1 to chmax do
        begin
         if SelFlag then canvas.font.color:=FontColorHiLitePair[cpSub,1]
          else canvas.font.color:=FontColorPair[cpSub,1];
         x:=tab+((j-1)*(fwCode[0]+blankwidth));
         su:=Stud[i].Choices[j];
         if (su>0) then printw(trim(SubCode[su]))
           else printw(copy('-------------',1,lencodes[0])); {print underscores for blank}
        end; {for j}
       fcolor(codecolor);
      end;
   2: begin  {boxes}
       x:=tab+Hmargin-Hscroll;;
       canvas.moveto(x,y+boxGap*2);
       canvas.lineto(x,y+txtheight);
       for j:=1 to nmbrBoxes do
        begin
         x:=tab+((j-1)*(boxWidth))+Hmargin-Hscroll;;
         canvas.moveto(x,y+txtheight-1);
         canvas.lineto(x+boxWidth,y+txtheight-1);
         canvas.lineto(x+boxWidth,y+boxGap);
        end; {for j}
      end;
   3: begin {lines}
       x:=tab+Hmargin-Hscroll;
       canvas.moveto(x,y+txtheight-1);
       canvas.lineto(x+boxWidth*nmbrBoxes,y+txtheight-1);
      end;
 end; {case}
 newline; if double_space then newline;
end;

procedure TStudListWin.ListFooter(i:integer);
begin
 printw('Number of Students: '+inttostr(ListSize[i]));
 newline; newline;
 if double_space then begin newline;newline; end;
end;

procedure TStudListWin.ShowLists;
var
 i,j,k: integer;
 selFlag: boolean;
begin
 fcolor(cpNormal);
 painthead;
 newline;
 if (NumOfLists=0) or ((TotalCount=0) and not(ShowZeroList)) then
   begin
    printw('No student lists selected.');
    exit;
   end;
 for i:=1 to NumOfLists do
  if (ListSize[i]>0) or ShowZeroList then
   begin
    if (i<NumofLists) then
     if ((ListTop[i+1]-Vscroll)<-StudHeight) then
      begin
       y:=ListTop[i+1]-Vscroll;
       continue;
      end;
    GetListContents(i);
    fcolor(cpNormal); ListHead(i);if double_space then newline;

    for j:=1 to ListSize[i] do
     begin
      k:=ListContents[j];
      if (y<-(2*StudHeight)) then
        begin
         inc(y,StudHeight);
         continue;
        end;
      fcolor(codecolor);
      selflag:=(ListSelect=i) and (SelCode=j);
      if selFlag then PaintItemFull(j,i,SelFlag) else
      DisplayStudent(k,selflag);
      if y>bottomCutoff then exit; {no printing past range}
     end;
    fcolor(cpNormal);
    ListFooter(i);
   end;
end;



procedure TStudListWin.paint;
begin
 inherited;
 if listtype=1 then showlists;
end;

procedure TStudListWin.CalcArrayTops;
var
 i,zerolists: integer;
begin
 TotalCount:=0;
 zerolists:=0;
 for i:=1 to NumOfLists do
  if (ListSize[i]=0) and not(ShowZeroList) then inc(zerolists);
 for i:=1 to NumOfLists do inc(TotalCount,ListSize[i]);
 StudLines:=1;
 if EnrolFlag then StudLines:=2+chmax;
 if stBarcode then inc(StudLines);

 StudHeight:=TxtHeight*StudLines*double_print;
 if listtype=1 then
 begin  {student list}
   ListTop[1]:=3*txtHeight;
   if NumofLists>1 then
    for i:=2 to NumofLists do
      if (ListSize[i-1]>0) or ShowZeroList then
        ListTop[i]:=ListTop[i-1]+double_print*txtHeight*(ListHeadLines+2+StudLines*ListSize[i-1])
       else ListTop[i]:=ListTop[i-1];
   CalcTabStField;
   maxW:=fwStName+blankwidth+TabStField;
   if StBarCode1=nil then BarCodeMake;

   if stBarcode then inc(maxW,StBarCode1.width);

   case sTselect of
    1: inc(maxW,(fwCode[0]+blankwidth)*chmax);
    2,3: inc(maxW,(nmbrBoxes+2)*boxwidth);
   end; {case}
   maxH:=4*TxtHeight+double_print*TxtHeight*((ListHeadLines+2)*(NumOfLists-zerolists)+TotalCount*StudLines);
 end;
end;

// TListTtWin procedures

Function TListTtWin.DayListSize(i:integer):integer;
begin
 result:=0; if ListSize[i]>0 then
  result:=(day2-day1+1)*(6+(4*txtHeight)+ListSize[i]*(txtHeight*2+6));
end;


procedure TListTtWin.CalcArrayTops;
var
 i,mydays,tsNameNum: integer;
begin
 TotalCount:=0;  tsNameNum:=1;
 for i:=1 to days-1 do
  if tsDayGroup[i]<>tsDayGroup[i-1] then inc(tsNameNum);
 WeeklyHeight:=yFooter+4*txtHeight+ (txtheight div 2)+6+
        (tsShowMax*(txtHeight*2+9));
 for i:=1 to NumOfLists do inc(TotalCount,ListSize[i]);
 if listtype=1 then
 begin  {daily}
   mydays:=day2-day1+1;
   maxH:=txtHeight+mydays*(((6+(4*txtHeight))*NumOfLists)+(TotalCount*(txtHeight*2+6)));
   maxW:=Hmargin*2+tab1+(dx+3)*periods;
   ListTop[1]:=txtHeight;
   if NumofLists>1 then
    for i:=2 to NumofLists do ListTop[i]:=ListTop[i-1]+DayListSize(i-1);
 end
 else  {weekly}
  begin
   maxH:=((2+NumOfLists)*txtHeight)+TotalCount*WeeklyHeight;
   maxW:=Hmargin*2+(tab1*tsNameNum)+(dx+3)*days;
  end;
end;


procedure TListTtWin.paint;
begin
 inherited;
 fcolor(cpNormal); {main headings etc -black}
 if TotalCount=0 then
   begin
    printw('No timetables selected.');
    exit;
   end;
 if listtype=1 then DailyTt else WeeklyTt;
end;

procedure TListTtWin.WeeklyTt;
var
 i,j,k:    integer;
begin
 for i:=1 to NumOfLists do
  if ListSize[i]>0 then
   begin
    GetListContents(i);
    fcolor(cpNormal);  ListHead(i,0);
    for j:=1 to ListSize[i] do
     begin
      k:=ListContents[j];
      if (y+WeeklyHeight)<(-2*TxtHeight) then
       begin
        inc(y,WeeklyHeight);
        continue;
       end;
      newline;
      fcolor(codecolor); ShowName(k);
      newline;
      ShowWeekly(k);
      WeeklyFooter(k);
      inc(y,6);
      if y>bottomCutoff then exit; {no printing past range}
     end;
   end;
end;



procedure TListTtWin.DailyTt;
var
 i,j,k,p,Ip,dI,dailyHeight:    integer;
begin
 dailyHeight:=txtHeight*2+6;
 for i:=1 to NumOfLists do
  if ListSize[i]>0 then
   begin
    if (i<NumofLists) then
     if ((ListTop[i+1]-Vscroll)<-dailyHeight) then
      begin
       y:=ListTop[i+1]-Vscroll;
       continue;
      end;
    for dI:=day1 to day2 do
     begin
      GetListContents(i);
      fcolor(cpNormal); ListHead(i,dI);
       for p:=1 to tsShowMax do   {period header}
         begin
          Ip:=tsShow[dI,p];
          if (Ip=0) and (p>1) then break;
          x:=tab1+dx*(p-1)+((dx-Canvas.textwidth(TimeSlotName[dI,Ip])) div 2); {centre period name}
          printw(TimeSlotName[dI,Ip]);
         end;
         inc(y,6);
      for j:=1 to ListSize[i] do
       begin
        k:=ListContents[j];
        if (y<-(2*dailyHeight)) then
          begin
           inc(y,dailyHeight);
           continue;
          end;
        newline;
        fcolor(codecolor); ShowName(k);
        ShowDaily(k,dI);
        inc(y,6);
        if y>bottomCutoff then exit; {no printing past range}
       end;
      newline; fcolor(cpNormal);
      WeeklyFooter(i);
      newline;     newline;
     end;
   end;
end;




procedure TListTtWin.ShowWeekly(studnum: integer);
var
 dI,Ip,p:      integer;
 y1t,y2t:                 integer;
 firstOne:                   bool;
 dayStart: array[0..nmbrdays] of integer;
 ShowTnames: array[0..nmbrdays] of boolean;
begin
 if y>bottomCutoff then exit; {no printing past range}
 tab1:=fwPeriodname+blankwidth;
 firstOne:=true;
 fcolor(cpNormal);
 dayStart[0]:=Hmargin;  ShowTnames[0]:=true;
 for dI:=1 to days-1 do ShowTnames[dI]:=(tsDayGroup[dI]<>tsDayGroup[dI-1]);

 for dI:=1 to days do
  begin
   dayStart[dI]:=dayStart[dI-1]+dx;
   if ShowTnames[dI-1] then inc(dayStart[dI],tab1);
  end;

 for dI:=0 to days-1 do
 begin
  x:=dayStart[dI]; if ShowTnames[dI] then inc(x,tab1);
  x:=x+((dx-canvas.textwidth(dayname[dI])) div 2); {centre dayname}
  printw(dayname[dI]);
 end; {for dI}
 newline;
 newline;  inc(y,txtheight div 2);
 for Ip:=1 to tsShowMax do
 begin
  y2t:=y+txtHeight+3;  y1t:=y-txtHeight-6;
  dec(y,txtheight);
  for dI:=0 to days-1 do
  begin
   p:=tsShow[dI,Ip];
   if (p=0) and (Ip>1) then continue;
   if ShowTnames[dI] then
    begin
     inc(y,txtHeight);
     x:=dayStart[dI]+blankwidth div 3;
     fcolor(cpNormal);
     printw(TimeSlotName[dI,p]);
     dec(y,txtheight);
    end;
   x:=dayStart[dI]; if ShowTnames[dI] then inc(x,tab1);
   ShowTtItems(studnum,dI,p,x);
  end; {for dI}
  inc(y,txtheight*3);
  x:=hmargin;
  if firstOne then
  begin
   firstOne:=false;
   drawMyLine(x-3,y1t,dayStart[days]-3,y1t);
  end;
  drawMyLine(x-3,y2t,dayStart[days]-3,y2t);
  for dI:=0 to days do
  begin
   drawMyLine(dayStart[dI]-3,y1t,dayStart[dI]-3,y2t);
   if dI<days then if ShowTnames[dI] then
    drawMyLine(dayStart[dI]+tab1-3,y1t,dayStart[dI]+tab1-3,y2t);
  end;  {for dI}
  inc(y,9);
 end; {for Ip}
end;

procedure TListTtWin.ShowDaily(studnum,dI: integer);
var
 Ip,k:      integer;
 y1t,y2t:                 integer;
begin
 if y>bottomCutoff then exit; {no printing past range}
 for k:=1 to tsShowMaxDay[dI] do
 begin
  Ip:=tsShow[dI,k];
  if (Ip=0) and (k>1) then break;
  ShowTtItems(studnum,dI,Ip,tab1+dx*(k-1));
 end; {for k}
 newline;
 y1t:=y-txtheight-3; y2t:=y+txtheight+3; x:=0;
 drawMyLine(x-3,y2t,x+tab1+dx*tsShowMaxDay[dI]-3,y2t);
 drawMyLine(x-3,y1t,x+tab1+dx*tsShowMaxDay[dI]-3,y1t);
 drawMyLine(x-3,y1t,x-3,y2t);
 for Ip:=0 to tsShowMaxDay[dI] do
  drawMyLine(x+tab1+dx*Ip-3,y1t,x+tab1+dx*Ip-3,y2t);
end;

//TPrintListWin  procedures

procedure TPrintListWin.BarcodeMake;
var
 ratio: integer;
begin
 ratio:=PrntTxtHeight div TxtHeight;
 if ratio<1 then ratio:=1;
 StBarCode1:=TStBarCode.Create(application);
 StBarCode1.BarCodeType:=bcCode128;
 StBarCode1.BarColor:=clBlack;
 StBarCode1.BarToSpaceRatio:=1;
 if PrinterOn then StBarCode1.BarWidth:=12
   else if PreviewOn then StBarCode1.BarWidth:=12*ratio;
 StBarCode1.BearerBars:=true;
 StBarCode1.Code128Subset:=csCodeB;
 StBarCode1.ShowGuardChars:=true;
 StBarCode1.TallGuardBars:=true;
 StBarCode1.Height:=68;
 StBarCode1.Width:=130*ratio;
 StBarCode1.ShowCode:=false;
end;

procedure TPrintListWin.PrintIDbarcode(i:integer);
var
 ar:                   trect;
 IDlen:  smallint;
 mx,my:     integer;
begin
 if trim(Stud[i].ID)>'' then
  begin
   IDlen:=CalcIDlen;
   mx:=x; my:=y;
   dec(y,PrntTxtheight div 2);
   if STBarCode1=nil then BarCodeMake;
   
   inc(x,StBarCode1.width div 4);
   ar.top:=y; ar.bottom:=y+2*PrntTxtheight;
   ar.left:=x+prntHmargin; ar.right:=ar.left+StBarCode1.width;
   StBarcode1.code:=RpadString(Stud[i].ID,idlen);
   StBarcode1.paintToCanvas(PrintCanvas,ar);
   x:=mx; y:=my;
  end;
 newline; if double_space then newline;
end;

procedure TPrintListWin.SetArraySizes;
begin
 SetLength(ListSize,NumOfLists+1);
 SetLength(ListSet,NumOfLists+1);
end;

procedure TPrintListWin.ShowStudentNameBrief(i: integer);
begin
 fcolor(cpStList); {as in student list}
 x:=PrntBlankwidth div 3;
 printw(Stud[i].stname+' '+Stud[i].first);
 inc(x,fwPrntStname+PrntBlankwidth);
end;

procedure TPrintListWin.ShowStudentHouse(i: integer);
begin
 if sTyear then
  begin
   printw(yearname[Stud[i].TcYear]);
   inc(x,fwPrntyearname+PrntBlankwidth);
  end;
 if stSex then
  begin
   printw(Stud[i].Sex);
   inc(x,fwPrntSex+PrntBlankwidth);
  end;
 if stID then
  begin
   printw(Stud[i].ID);
   inc(x,fwPrntID+PrntBlankwidth);
  end;
// if stBarcode then
//  begin
//    printw('*'+Stud[i].ID+'*');
//    inc(x,fwPrntID+2+PrntBlankWidth);
//  end;
 if sTclass then
  begin
   printw(ClassCode[Stud[i].Tcclass]);
   inc(x,fwPrntClass+PrntBlankwidth);
  end;
 if stHouse then
  begin
   printw(HouseName[Stud[i].house]);
   inc(x,fwPrntHouse+PrntBlankwidth);
  end;
 if stTutor then
  begin
   printw(Tecode[Stud[i].tutor,0]);
   inc(x,fwPrntcode[1]+PrntBlankwidth);
  end;
 if stHome then
  begin
   printw(Tecode[Stud[i].home,1]);
   inc(x,fwPrntcode[2]+PrntBlankwidth);
  end;
end;

procedure TPrintListWin.showStudentName(i: integer);
begin
 ShowStudentNameBrief(i);
 ShowStudentHouse(i);
end;


procedure TPrintListWin.CalcTabStField;
begin
 TabStField:=0;
 if sTyear then inc(TabStField,(fwPrntyearname+PrntBlankwidth));
 if sTsex then inc(TabStField,(fwPrntSex+PrntBlankwidth));
 if sTclass then inc(TabStField,(fwPrntclass+PrntBlankwidth));
 if sThouse then inc(TabStField,(fwPrnthouse+PrntBlankwidth));
 if sTtutor then inc(TabStField,(fwPrntcode[1]+PrntBlankwidth));
 if sThome then inc(TabStField,(fwPrntcode[2]+PrntBlankwidth));
 if sTID then inc(TabStField,(fwPrntID+PrntBlankwidth));
 //if stBarcode then inc(TabStField,(fwPrntID+2+PrntBlankWidth));
 
end;

// TOutListWin procedures

procedure TOutListWin.SetArraySizes;
begin
 SetLength(ListSize,NumOfLists+1);
 SetLength(ListSet,NumOfLists+1);
end;

procedure TOutListWin.ShowStudentNameBrief(i: integer);
begin
 printw(Stud[i].stname);
 printc(Stud[i].first);
end;

procedure TOutListWin.ShowStudentHouse(i: integer);
begin
 if sTyear then printc(yearname[Stud[i].TcYear]);
 if stSex then printc(Stud[i].Sex);
 if stID then printc(Stud[i].ID);
 //if stBarcode then printc('*'+Stud[i].ID+'*');
 if stClass then printc(ClassCode[Stud[i].Tcclass]);
 if stHouse then printc(HouseName[Stud[i].house]);
 if stTutor then printc(Tecode[Stud[i].tutor,0]);
 if stHome then printc(Tecode[Stud[i].home,1]);
end;

procedure TOutListWin.CalcTabCount;
begin
 TabCount:=1;
 if sTyear then inc(TabCount);
 if stSex then inc(TabCount);
 if stID then inc(TabCount);
 //if stBarcode then inc(TabCount);
 if stClass then inc(TabCount);
 if stHouse then inc(TabCount);
 if stTutor then inc(TabCount);
 if stHome then inc(TabCount);
end;

procedure TOutListWin.showStudentName(i: integer);
begin
 ShowStudentNameBrief(i);
 ShowStudentHouse(i);
end;

procedure TOutListWin.CalcTotalCount;
var
 i: integer;
begin
 TotalCount:=0;
 for i:=1 to NumOfLists do inc(TotalCount,ListSize[i]);
end;

// TPrintStudListWin procedures



procedure TPrintStudListWin.CalcHeights;
var
 i: integer;
begin
 TotalCount:=0;
 for i:=1 to NumOfLists do inc(TotalCount,ListSize[i]);
 StudLines:=1;
 if EnrolFlag then StudLines:=2+chmax;
 StudHeight:=PrntTxtHeight*StudLines*double_print;
end;

procedure TPrintStudListWin.StudEnrolment(i:integer);
var
 j,su: integer;
 te,ro: smallint;
begin
 printw(':'); newline; if double_space then newline;
 for j:=1 to chmax do
  begin
   su:=Stud[i].Choices[j];
   if trim(SubCode[su])>'' then
    begin
     fcolor(cpSub);
     x:=0; printw('    '+SubCode[su]+': ');
     x:=fwPrntCode[0]+PrntBlankwidth*5; printw(Subname[su]);
     findteacher(i,j,te,ro,MatchAllYears);
     if trim(TeCode[te,0])>'' then
       begin
        fcolor(cpTeach);
        x:=fwPrntCode[0]+PrntBlankwidth*5+fwPrntCodename[0];
        printw('    '+TeCode[te,0]+': ');
        x:=fwPrntCode[0]+PrntBlankwidth*5+fwPrntCodename[0]+fwPrntCode[1]+PrntBlankwidth*3;
        printw(TeName[te,0]);
       end;
    end;
   newline; if double_space then newline;
  end; {for j}
 newline; if double_space then newline;
 fcolor(codecolor);
end;

procedure TPrintStudListWin.DisplayStudent(i:integer);
var
 j,su:       integer;
 tab: integer;
begin
 x:=0;
 ShowStudentName(i); tab:=x;
 if StBarcode1=nil then BarCodeMake;
 
 if stBarcode then PrintIDBarcode(i);
 
 if EnrolFlag then begin StudEnrolment(i); exit; end;
 case sTselect of
   1: begin    {other subs}
       for j:=1 to chmax do
        begin
         fcolor(cpSub);
         x:=tab+((j-1)*(fwPrntCode[0]+PrntBlankwidth));
         su:=Stud[i].Choices[j];
         if (su>0) then printw(trim(SubCode[su]))
           else printw(copy('-------------',1,lencodes[0])); {print underscores for blank}
        end; {for j}
       fcolor(codecolor);
      end;
   2: begin  {boxes}
       x:=tab+prntHmargin;;
       PrintCanvas.moveto(x,y+boxGap*2);
       PrintCanvas.lineto(x,y+prntTxtHeight);
       for j:=1 to nmbrBoxes do
        begin
         x:=tab+((j-1)*(prntboxwidth))+prntHmargin;;
         PrintCanvas.moveto(x,y+prntTxtHeight);
         PrintCanvas.lineto(x+prntboxwidth,y+prntTxtHeight);
         PrintCanvas.lineto(x+prntboxwidth,y+boxGap);
        end; {for j}
      end;
   3: begin {lines}
       x:=tab+prntHmargin;
       PrintCanvas.moveto(x,y+prntTxtHeight);
       PrintCanvas.lineto(x+prntboxwidth*nmbrBoxes,y+prntTxtHeight);
      end;
 end; {case}
 newline; if double_space then newline;
end;

procedure TPrintStudListWin.ListFooter(i:integer);
begin
 printw('Number of Students: '+inttostr(ListSize[i]));
 newline; newline;
 if double_space then begin newline;newline; end;
end;

procedure TPrintStudListWin.ShowLists;
var
 i,j,k: integer;

  procedure checkNewPage;
  begin
   if Formfeed then
     begin
      printCustomAddon;
      if not(lastone) then  begin StartNewPage; header; end;
     end
    else {not formfeed}
     if EnrolFlag and (y+StudHeight>(PrintPageHeight-2*prntTxtHeight)) and
      ((PrintPageHeight div 2)>StudHeight) and not(lastone) then
       begin StartNewPage; header; end;  {prevent part on enrol on end of page}
  end;


begin
 fcolor(cpNormal);
 header;
 newline;
 lastone:=false;
 if (NumOfLists=0) or ((TotalCount=0) and not(ShowZeroList)) then
  begin
   printw('No students selected.');
   exit;
  end;
 for i:=1 to NumOfLists do
  begin
    if (ListSize[i]>0) or ShowZeroList then
     begin
      GetListContents(i);
      fcolor(cpNormal); ListHead(i);if double_space then newline;
      for j:=1 to ListSize[i] do
       begin
        if ((j=ListSize[i]) or (not(EnrolFlag))) and (i=NumOfLists) then lastOne:=true;
        k:=ListContents[j];
        fcolor(codecolor);
        DisplayStudent(k);
        if EnrolFlag then CheckNewPage;
       end;
      fcolor(cpNormal);
      if not(enrolflag and formfeed) then ListFooter(i);
      if not(enrolflag) then CheckNewPage;
     end;
  end;
 if not(formfeed) then printCustomAddon;
end;

// TOutStudListWin

procedure TOutStudListWin.StudEnrolment(i:integer);
var
 j,su: integer;
 te,ro: smallint;
begin
 printw(':'); newline; if double_space then newline;
 for j:=1 to chmax do
  begin
   su:=Stud[i].Choices[j];
   if trim(SubCode[su])>'' then
    begin
     printw(SubCode[su]);
     printc(Subname[su]);
     findteacher(i,j,te,ro,MatchAllYears);
     if trim(TeCode[te,0])>'' then
       begin
        printc(TeCode[te,0]);
        printc(TeName[te,0]);
       end;
    end;
   newline; if double_space then newline;
  end; {for j}
 newline; if double_space then newline;
end;

procedure TOutStudListWin.DisplayStudent(i:integer);
var
 j,su:       integer;
begin
 ShowStudentName(i);
 if EnrolFlag then begin StudEnrolment(i); exit; end;
 case sTselect of
   1: begin    {other subs}
       for j:=1 to FAsubnum do
        begin
         su:=Stud[i].Choices[j];
         if (su>0) then printc(trim(SubCode[su]))
           else printc(copy('-------------',1,lencodes[0])); {print underscores for blank}
        end; {for j}
      end;
   2: begin  {boxes}
       for j:=1 to nmbrBoxes do printc('_|');
      end;
   3: begin {lines}
       printc('___________________________________');
      end;
 end; {case}
 newline; if double_space then newline;
end;

procedure TOutStudListWin.ListFooter(i:integer);
begin
 printLine(['Number of Students: ',inttostr(ListSize[i])]);
 newline; newline;
 if double_space then begin newline;newline; end;
end;

procedure TOutStudListWin.ShowLists;
var
 i,j,k: integer;

  procedure checkNewPage;
  begin
   if Formfeed then printCustomAddon;
  end;


begin
 header;
 newline;
 lastone:=false;
 if (NumOfLists=0) or ((TotalCount=0) and not(ShowZeroList)) then
  begin
   printLine(['No student lists selected.']);
   exit;
  end;
 for i:=1 to NumOfLists do
  begin
    if (ListSize[i]>0) or ShowZeroList then
     begin
      GetListContents(i);
      ListHead(i);if double_space then newline;
      for j:=1 to ListSize[i] do
       begin
        if ((j=ListSize[i]) or (not(EnrolFlag))) and (i=NumOfLists) then lastOne:=true;
        k:=ListContents[j];
        DisplayStudent(k);
        if EnrolFlag then CheckNewPage;
       end;
      if not(enrolflag and formfeed) then ListFooter(i);
      if not(enrolflag) then CheckNewPage;
     end;
  end;
 if not(formfeed) then printCustomAddon;
end;


// TPrintListTtWin procedures

procedure TPrintListTtWin.PaintOnPrinter;
var
 i: integer;
begin
 SetTabs;
 TotalCount:=0;
 for i:=1 to NumOfLists do inc(TotalCount,ListSize[i]);
 if TotalCount=0 then
  begin
   printw('No timetables selected.');
   exit;
  end;
 if listtype=1 then
   begin
    printhead;
    DailyTt;
   end
    else WeeklyTt;
end;



procedure TPrintListTtWin.ShowDaily(var FirstOne:boolean; studnum,dI: integer);
var
 Ip,k,VertOffset:      integer;
begin
 for k:=1 to tsShowMaxDay[dI] do
  begin
   Ip:=tsShow[dI,k];
   if (Ip=0) and (k>1) then break;
   ShowTtItems(studnum,dI,Ip,tab1+dx*(k-1));
  end; {for k}
 newline;
 VertOffset:=PrntTxtHeight div 3;
 y1t:=y-PrntTxtheight-VertOffset; y2t:=y+PrntTxtheight; x:=0;
 drawMyLine(x-3,y2t,x+tab1+dx*tsShowMaxDay[dI]-3,y2t);
 if firstOne then
  begin
   firstOne:=false;
   drawMyLine(x-3,y1t,x+tab1+dx*tsShowMaxDay[dI]-3,y1t);
  end;
 drawMyLine(x-3,y1t,x-3,y2t);
 for Ip:=0 to tsShowMaxDay[dI] do
  drawMyLine(x+tab1+dx*Ip-3,y1t,x+tab1+dx*Ip-3,y2t);
end;

procedure TPrintListTtWin.DailyTt;
var
 i,j,k,dI,VertOffset:    integer;
 firstOne:         boolean;

   procedure DayHead;
   var
    p,Ip: integer;
   begin
     newline;
     fcolor(cpNormal); ListHead(i,dI); firstOne:=true;
     for p:=1 to tsShowMax do   {period header}
       begin
        Ip:=tsShow[dI,p];
        if (Ip=0) and (p>1) then break;
        x:=tab1+dx*(p-1)+ ((dx-PrintCanvas.textwidth(TimeSlotName[dI,Ip])) div 2); {centre period name}
        printw(TimeSlotName[dI,Ip]);
       end;
       inc(y,VertOffset);
   end;

begin
 VertOffset:=PrntTxtHeight div 3;
 for i:=1 to NumOfLists do
  if ListSize[i]>0 then
   begin
    for dI:=day1 to day2 do
     begin
      GetListContents(i);
      DayHead;
      for j:=1 to ListSize[i] do
       begin
        k:=ListContents[j];
        newline;
        fcolor(codecolor); ShowName(k);
        ShowDaily(FirstOne,k,dI);
        inc(y,VertOffset);
        if ((y+5*PrntTxtheight+2*VertOffset)>PrintPageHeight) and (j<ListSize[i]) then
         begin
          startnewPage;
          PrintHead;
          DayHead;
         end;
       end;
      newline; fcolor(cpNormal);
      WeeklyFooter(i);
      newline;
      printCustomAddon;
       if formfeed and ((dI<day2) or (i<NumOfLists)) then
        begin  startnewPage; PrintHead; end
       else  newline;
     end;
   end;
end;

procedure TPrintListTtWin.ShowWeekly(studnum: integer);
var
 dI,Ip,p,VertOffset,headgap:      integer;
 firstOne:                   bool;
 dayStart: array[0..nmbrdays] of integer;
 ShowTnames: array[0..nmbrdays] of boolean;

 procedure WeekHead;
 var dI: integer;
 begin
  firstOne:=true;
  fcolor(codecolor);
  ShowName(studnum);   newline; fcolor(cpNormal);
  for dI:=0 to days-1 do
   begin
    x:=dayStart[dI]; if ShowTnames[dI] then inc(x,tab1);
    x:=x+((dx-PrintCanvas.textwidth(dayname[dI])) div 2); {centre dayname}
    printw(dayname[dI]);
   end; {for dI}
  x:=0; y:=y+PrnttxtHeight+headgap;   //newline
 end;


begin
 tab1:=fwPrntPeriodname+PrntBlankwidth;
 dayStart[0]:=0;  ShowTnames[0]:=true;
 for dI:=1 to days-1 do ShowTnames[dI]:=(tsDayGroup[dI]<>tsDayGroup[dI-1]);
 for dI:=1 to days do
  begin
   dayStart[dI]:=dayStart[dI-1]+dx;
   if ShowTnames[dI-1] then inc(dayStart[dI],tab1);
  end;

 VertOffset:=PrntTxtHeight div 5;
 headgap:=PrntTxtHeight div 4;
 WeekHead;
 for Ip:=1 to tsShowMax do
 begin
  y1t:=y; inc(y,VertOffset);
  for dI:=0 to days-1 do
  begin
   p:=tsShow[dI,Ip];
   if (p=0) and (Ip>1) then continue;
   if ShowTnames[dI] then
    begin
     inc(y,(PrntTxtheight div 2));
     x:=dayStart[dI]+PrntBlankwidth div 2;
     fcolor(cpNormal);
     printw(TimeSlotName[dI,p]);
     dec(y,(PrntTxtheight div 2));
    end;
   x:=dayStart[dI]; if ShowTnames[dI] then inc(x,tab1);
   ShowTtItems(studnum,dI,p,x);
  end; {for dI}
  inc(y,2*PrntTxtheight+VertOffset);
  x:=0;
  if firstOne then
  begin
   firstOne:=false;
   drawMyLine(x-3,y1t,dayStart[days]-3,y1t);
  end;
  drawMyLine(x-3,y,dayStart[days]-3,y);
  drawMyLine(x-3,y1t,x-3,y);
  for dI:=0 to days do
   begin
    drawMyLine(dayStart[dI]-3,y1t,dayStart[dI]-3,y);
    if dI<days then if ShowTnames[dI] then
     drawMyLine(dayStart[dI]+tab1-3,y1t,dayStart[dI]+tab1-3,y);
   end;
  if ((y+PrntTxtHeight*2+9)>PrintPageheight) and (Ip<tsShowMax) then
   begin
    startnewPage;
    PrintHead;
    WeekHead;
   end;
 end; {for Ip}
end;

procedure TPrintListTtWin.WeeklyTt;
var
 i,j,k,PweekCount,count:    integer;
 weekspace,smallWeekSpace: integer;
begin
 count:=0; PweekCount:=0;
 if Pweek<1 then Pweek:=1;
 WeeklyHeight:=yFooter+4*PrntTxtHeight+ (Prnttxtheight div 2)+6+
        (tsShowMax*2*(PrntTxtHeight+(PrntTxtHeight div 5)));
 parseCustomInfo;
 if CustomCnt>0 then inc(WeeklyHeight,(1+CustomCnt)*PrntTxtHeight);
 smallWeekSpace:=3*prntTxtHeight;
 weekspace:=(PrintPageheight-4*prntTxtHeight-prntVmargin-Pweek*WeeklyHeight) div (1+Pweek);
 if weekspace<0 then weekspace:=0;
 if Pweek=1 then if smallWeekSpace<weekspace then weekspace:=smallWeekSpace;
 for i:=1 to NumOfLists do
  if ListSize[i]>0 then
   begin
    GetListContents(i);
    fcolor(cpNormal);
    for j:=1 to ListSize[i] do
     begin
      k:=ListContents[j];
      if PweekCount=0 then
       begin
        PrintHead;
        if weekspace>0 then inc(y,weekspace);
       end;
      newline;
      ShowWeekly(k);
      newline;
      WeeklyFooter(k);
      inc(y,6);
      printCustomAddon;
      if weekspace>0 then inc(y,weekspace);
      inc(PweekCount); inc(count);
       if ((PweekCount>=Pweek)
        or (  ((y+WeeklyHeight)>PrintPageheight) and
         (WeeklyHeight<(PrintPageheight-4*prntTxtHeight-prntVmargin)) )) then

   {avoiding orphaned lines in print out -ensure at least 10 lines can print}
       begin
        PweekCount:=0;
        if count<>TotalCount then startnewPage; {only if not last}
       end;
     end;
   end;
end;


// TOutListTtWin procedures

procedure TOutListTtWin.PaintOnOutput;
var
 i: integer;
begin
 SetTabs;
 TotalCount:=0;
 for i:=1 to NumOfLists do inc(TotalCount,ListSize[i]);
 if TotalCount=0 then
  begin
   printLine(['No timetables selected.']);
   exit;
  end;
 if listtype=1 then
   begin
    header;
    DailyTt;
   end
    else WeeklyTt;
end;



procedure TOutListTtWin.ShowDaily(studnum,dI: integer);
var
 Ip,k:      integer;
begin
 for k:=1 to tsShowMaxDay[dI] do
 begin
  Ip:=tsShow[dI,k];
  if (Ip=0) and (k>1) then break;
  ShowTtItems(studnum,dI,Ip);
 end; {for k}
 newline;
end;

procedure TOutListTtWin.DailyTt;
var
 i,j,k,dI:    integer;
   procedure DayHead;
   var
    p,Ip: integer;
   begin
     newline;
     ListHead(i,dI);
     if Tabcount>0 then
      for Ip:= 1 to tabcount do printc(''); {match heading tabs with item tabs}
     for p:=1 to tsShowMax do   {period header}
       begin
        Ip:=tsShow[dI,p];
        if (Ip=0) and (p>1) then break;
        printc(TimeSlotName[dI,Ip]);printc('');printc('');
       end;
   end;

begin
 for i:=1 to NumOfLists do
  if ListSize[i]>0 then
   begin
    for dI:=day1 to day2 do
     begin
      GetListContents(i);
      DayHead;
      for j:=1 to ListSize[i] do
       begin
        k:=ListContents[j];
        newline;
        ShowName(k);
        ShowDaily(k,dI);
       end;
      newline;
      WeeklyFooter(i);
      newline;
      printCustomAddon;
      newline;
     end;
   end;
end;

procedure TOutListTtWin.ShowWeekly(studnum: integer);
var
 dI,Ip,p:      integer;

 firstOne:                   bool;
 ShowTnames: array[0..nmbrdays] of boolean;

 procedure WeekHead;
 var dI: integer;
 begin
  firstOne:=true;
  ShowName(studnum);   newline;
  for dI:=0 to days-1 do
   begin
    if (ShowTnames[dI] and (dI>0)) then printc('');
    printc(dayname[dI]);printc('');printc('');
   end; {for dI}
  newline;
 end;

  procedure ShowDummy;
  var
   aStr,bStr,cStr,dStr:                    string;
  begin
   astr:=''; bStr:=''; cStr:='';
   dStr:='';
   if ShowTnames[dI] then
    begin
     if ((p>0) or (Ip=1)) then dStr:=TimeSlotName[dI,p];
     if dI=0 then printw(dStr) else printc(dStr);
    end;

   printc(aStr); printc(bStr);printc(cStr); 
  end;


begin
 ShowTnames[0]:=true;
 for dI:=1 to days-1 do ShowTnames[dI]:=(tsDayGroup[dI]<>tsDayGroup[dI-1]);

 WeekHead;
 for Ip:=1 to tsShowMax do
 begin
  for dI:=0 to days-1 do
  begin
   p:=tsShow[dI,Ip];
   if (p=0) and (Ip>1) then
    begin
     ShowDummy;
     continue;
    end; 
   if ShowTnames[dI] then
    begin
     if dI=0 then printw(TimeSlotName[dI,p]) else printc(TimeSlotName[dI,p]);
    end;
   ShowTtItems(studnum,dI,p);
  end; {for dI}
  newline;
 end; {for Ip}
 newline;
end;

procedure TOutListTtWin.WeeklyTt;
var
 i,j,k:    integer;
begin
 for i:=1 to NumOfLists do
  if ListSize[i]>0 then
   begin
    GetListContents(i);
    for j:=1 to ListSize[i] do
     begin
      k:=ListContents[j];
      if PweekCount=0 then
      newline;
      ShowWeekly(k);
      WeeklyFooter(k);
      printCustomAddon;
      newline;newline;
     end;
   end;
end;

end.
