    unit Main;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, Tcgetdir, Gauges,
  OleServer,TCEglobals, ActnList, ImgList, ActnMan, ToolWin, ActnCtrls,
  StdActns, BandActn, XPStyleActnCtrls, AdvToolBar, AdvOfficeStatusBar, AdvMenus,
  AdvToolBarStylers, ehshelprouter{, ehshelprouter};

  type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    NewDayItem: TMenuItem;
    Close1: TMenuItem;
    Save1: TMenuItem;
    Print1: TMenuItem;
    PrintSetup1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpContentsItem: TMenuItem;
    HelpSearchItem: TMenuItem;
    HelpHowToUseItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    PrintSetupDialog: TPrinterSetupDialog;
    Display: TMenuItem;
    N5: TMenuItem;
    Info1: TMenuItem;
    Codes1: TMenuItem;
    N6: TMenuItem;
    SubjectList1: TMenuItem;
    StudentList1: TMenuItem;
    StudentTimetable1: TMenuItem;
    N7: TMenuItem;
    Timetable1: TMenuItem;
    Teacher1: TMenuItem;
    Room1: TMenuItem;
    Subject1: TMenuItem;
    N8: TMenuItem;
    Teacher2: TMenuItem;
    Times1: TMenuItem;
    TileVertical1: TMenuItem;
    N2: TMenuItem;
    Font1: TMenuItem;
    Preferences1: TMenuItem;
    FontDialog1: TFontDialog;
    N4: TMenuItem;
    NewData1: TMenuItem;
    Find1: TMenuItem;
    Timetable2: TMenuItem;
    Student2: TMenuItem;
    Teacher3: TMenuItem;
    Room3: TMenuItem;
    Timetable3: TMenuItem;
    Levels1: TMenuItem;
    Custom1: TMenuItem;
    Clear1: TMenuItem;
    New1: TMenuItem;
    opencustomfile1: TMenuItem;
    Editcustomfile1: TMenuItem;
    Savecustomfile1: TMenuItem;
    BySubject1: TMenuItem;
    ByTimeslot1: TMenuItem;
    Panel4: TPanel;
    Margins1: TMenuItem;
    N15: TMenuItem;
    Selection1: TMenuItem;
    AbsenceReasons1: TMenuItem;
    CoverNotes1: TMenuItem;
    AddedStaff1: TMenuItem;
    AbsentTeachers1: TMenuItem;
    NewClasses1: TMenuItem;
    LostClasses1: TMenuItem;
    MergedClasses1: TMenuItem;
    UnavailableRooms1: TMenuItem;
    RoomSwaps1: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    CurrentExtras1: TMenuItem;
    PastExtras1: TMenuItem;
    Changes1: TMenuItem;
    AddedStaff2: TMenuItem;
    AbsentTeacher1: TMenuItem;
    Newclass1: TMenuItem;
    LostClass1: TMenuItem;
    MergeClass1: TMenuItem;
    RoomClass1: TMenuItem;
    RoomSwaps2: TMenuItem;
    WorkAheadNew1: TMenuItem;
    WorkAheadOpen1: TMenuItem;
    WorkAheadUse1: TMenuItem;
    Cover1: TMenuItem;
    Manual1: TMenuItem;
    N9: TMenuItem;
    ExcludeYears1: TMenuItem;
    N10: TMenuItem;
    Wipe1: TMenuItem;
    WeeklyExtras1: TMenuItem;
    InLieus1: TMenuItem;
    TotalExtras1: TMenuItem;
    PastExtras2: TMenuItem;
    AddedStaff3: TMenuItem;
    OpenTimetable1: TMenuItem;
    Student1: TMenuItem;
    Select1: TMenuItem;
    Sort1: TMenuItem;
    N11: TMenuItem;
    grp01: TMenuItem;
    grp11: TMenuItem;
    grp21: TMenuItem;
    grp31: TMenuItem;
    grp41: TMenuItem;
    grp51: TMenuItem;
    grp61: TMenuItem;
    grp71: TMenuItem;
    grp81: TMenuItem;
    grp91: TMenuItem;
    grp101: TMenuItem;
    grp111: TMenuItem;
    grp121: TMenuItem;
    grp131: TMenuItem;
    grp141: TMenuItem;
    grp151: TMenuItem;
    ReplaceExtras1: TMenuItem;
    PrintPreview1: TMenuItem;
    ExportFile: TMenuItem;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    EmailSetup1: TMenuItem;
    N12: TMenuItem;
    EmailCovers1: TMenuItem;
    RestorefromBackup1: TMenuItem;
    CreateBackup1: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    RescanTimetable1: TMenuItem;
    Weights1: TMenuItem;
    LastExtraDate1: TMenuItem;
    ActionImages: TImageList;
    ActionManager1: TActionManager;
    DoPrintPreview: TAction;
    MainPrint: TAction;
    FilePrintSetup1: TFilePrintSetup;
    NewData: TAction;
    CopyWin: TAction;
    WorkAheadNew: TAction;
    WorkAheadOpen: TAction;
    SetFont: TAction;
    Preferences: TAction;
    ShowSelection: TAction;
    NextView: TAction;
    NextView1: TMenuItem;
    ShowStudList: TAction;
    ManualCover: TAction;
    ShowTimetable: TAction;
    MyAutoCover: TAction;
    ShowAbsentTeachers: TAction;
    ChangeAbsent: TAction;
    ShowLostTeachers: TAction;
    ChangeLost: TAction;
    FileNewDay: TAction;
    WorkAheadUse: TAction;
    CustomizeActionBars1: TCustomizeActionBars;
    ChangeEmailCovers: TAction;
    CoverWeights: TAction;
    ToolSpace: TAction;
    WindowCascade1: TWindowCascade;
    ChangeAddedStaff: TAction;
    ShowAddedAvail: TAction;
    ChangeNewClass: TAction;
    ShowNewClasses: TAction;
    ChangeMergeClass: TAction;
    ShowMergeClass: TAction;
    ChangeUnavailRoom: TAction;
    ChangeRoomSwap: TAction;
    ShowUnavailRoom: TAction;
    ShowRoomSwaps: TAction;
    ShowCurrentExtras: TAction;
    ShowInfoWin: TAction;
    ShowPastExtras: TAction;
    actTeacherTallies: TAction;
    DoIncludeYears: TAction;
    ShowSubjectList: TAction;
    ShowStudentTt: TAction;
    ShowTeacherTimetable: TAction;
    ShowRoomTimetable: TAction;
    ShowSubjectTimetable: TAction;
    N19: TMenuItem;
    VisitAmigSystemsWebsite1: TMenuItem;
    User1: TMenuItem;
    Info2: TMenuItem;
    Changepassword1: TMenuItem;
    N20: TMenuItem;
    Adduser1: TMenuItem;
    Edituser1: TMenuItem;
    Deleteuser1: TMenuItem;
    N21: TMenuItem;
    Showusers1: TMenuItem;
    Autoloadtime1: TMenuItem;
    Checkforupdates1: TMenuItem;
    Logonasdifferentuser1: TMenuItem;
    Timer1: TTimer;
    Savedefaultdisplaysettings1: TMenuItem;
    Setcurrentdatadirectoryasdefault1: TMenuItem;
    ImageList1: TImageList;
    mniCoverWipeAll: TMenuItem;
    mniFileCloseAll: TMenuItem;
    mniHelpSystem: TMenuItem;
    mniHelpSystemArchiveData: TMenuItem;
    stbMain: TAdvOfficeStatusBar;
    AdvToolBarOfficeStyler: TAdvToolBarOfficeStyler;
    ToolBarCustomizer: TAdvToolBarCustomizer;
    AdvMainMenu: TAdvMainMenu;
    mnuFile: TMenuItem;
    mnuEdit: TMenuItem;
    mnuDisplay: TMenuItem;
    mnuUser: TMenuItem;
    mnuFind: TMenuItem;
    mnuStudent: TMenuItem;
    mnuTimetable: TMenuItem;
    mnuChanges: TMenuItem;
    mnuCover: TMenuItem;
    mnuWindow: TMenuItem;
    mnuHelp: TMenuItem;
    AdvDockPanel1: TAdvDockPanel;
    NewDay1: TMenuItem;
    N18: TMenuItem;
    WorkAhead1: TMenuItem;
    Use1: TMenuItem;
    Open1: TMenuItem;
    New2: TMenuItem;
    mniFileClose: TMenuItem;
    mniFileCloseAllb: TMenuItem;
    N22: TMenuItem;
    OpenTimetable2: TMenuItem;
    NewData2: TMenuItem;
    ExportasTextFile1: TMenuItem;
    N23: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    PrintPreview2: TMenuItem;
    N24: TMenuItem;
    CreateBackup2: TMenuItem;
    RestorefromBackup2: TMenuItem;
    N25: TMenuItem;
    Exit1: TMenuItem;
    Copy2: TMenuItem;
    Font2: TMenuItem;
    Preferences2: TMenuItem;
    Margins2: TMenuItem;
    Custom2: TMenuItem;
    Save2: TMenuItem;
    Edit2: TMenuItem;
    Open2: TMenuItem;
    New3: TMenuItem;
    Clear2: TMenuItem;
    N15N: TMenuItem;
    Selection2: TMenuItem;
    NextView2: TMenuItem;
    Info3: TMenuItem;
    Changepassword2: TMenuItem;
    Logonasdifferentuser2: TMenuItem;
    N27: TMenuItem;
    Showusers2: TMenuItem;
    Adduser2: TMenuItem;
    Edituser2: TMenuItem;
    Deleteuser2: TMenuItem;
    N28: TMenuItem;
    Autoloadtime2: TMenuItem;
    Savedefaultdisplaysettings2: TMenuItem;
    Setcurrentdatadirectoryasdefault2: TMenuItem;
    Student3: TMenuItem;
    eacher1: TMenuItem;
    Room2: TMenuItem;
    Select2: TMenuItem;
    Sort2: TMenuItem;
    N29: TMenuItem;
    grp0S: TMenuItem;
    grp1S: TMenuItem;
    grp2S: TMenuItem;
    grp3S: TMenuItem;
    grp4S: TMenuItem;
    grp5S: TMenuItem;
    grp6S: TMenuItem;
    grp7S: TMenuItem;
    grp8S: TMenuItem;
    grp9S: TMenuItem;
    grp10S: TMenuItem;
    grp11S: TMenuItem;
    grp12S: TMenuItem;
    grp13S: TMenuItem;
    grp14S: TMenuItem;
    grp15S: TMenuItem;
    Levels2: TMenuItem;
    imetable1: TMenuItem;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarButton23: TAdvToolBarButton;
    AdvToolBarButton24: TAdvToolBarButton;
    AdvToolBarButton25: TAdvToolBarButton;
    AdvToolBar2: TAdvToolBar;
    AdvToolBarButton15: TAdvToolBarButton;
    AdvToolBarButton16: TAdvToolBarButton;
    AdvToolBarButton17: TAdvToolBarButton;
    AdvToolBar3: TAdvToolBar;
    AdvToolBarButton12: TAdvToolBarButton;
    AdvToolBarButton13: TAdvToolBarButton;
    AdvToolBarButton14: TAdvToolBarButton;
    AdvToolBar4: TAdvToolBar;
    AdvToolBarButton5: TAdvToolBarButton;
    AdvToolBarButton6: TAdvToolBarButton;
    AdvToolBarButton8: TAdvToolBarButton;
    AdvToolBarButton18: TAdvToolBarButton;
    AdvToolBarButton11: TAdvToolBarButton;
    AdvToolBarButton9: TAdvToolBarButton;
    AdvToolBarButton1: TAdvToolBarButton;
    AdvToolBar5: TAdvToolBar;
    AdvToolBarButton10: TAdvToolBarButton;
    AdvToolBarButton2: TAdvToolBarButton;
    AdvToolBarButton19: TAdvToolBarButton;
    AdvToolBarButton4: TAdvToolBarButton;
    AdvToolBarButton3: TAdvToolBarButton;
    CoverasPDF1: TMenuItem;
    mniUserClearUserAccessLocks: TMenuItem;
    HelpRouter1: THelpRouter;
    AdvToolBarButton7: TAdvToolBarButton;
    AdvToolBarButton20: TAdvToolBarButton;
    AdvToolBarButton21: TAdvToolBarButton;
    AdvToolBarSeparator2: TAdvToolBarSeparator;
    AdvToolBarButton22: TAdvToolBarButton;
    AdvToolBarButton26: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    teachersFree1: TMenuItem;  { &Contents }
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure FilePrintSetup(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure WindowTile(Sender: TObject);
    procedure WindowArrange(Sender: TObject);
    procedure HelpContents(Sender: TObject);
    procedure HelpSearch(Sender: TObject);
    procedure HelpHowToUse(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Teacher2Click(Sender: TObject);
    procedure Times1Click(Sender: TObject);
    procedure TileVertical1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Color1Click(Sender: TObject);
    procedure FileMenuClick(Sender: TObject);
    procedure Timetable3Click(Sender: TObject);
    procedure WindowMenuClick(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Timetable2Click(Sender: TObject);
    procedure Timetable1Click(Sender: TObject);
    procedure ByTimeslot1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure opencustomfile1Click(Sender: TObject);
    procedure Levels1Click(Sender: TObject);
    procedure Margins1Click(Sender: TObject);
    procedure Student2Click(Sender: TObject);
    procedure Teacher3Click(Sender: TObject);
    procedure Room3Click(Sender: TObject);
    procedure Editcustomfile1Click(Sender: TObject);
    procedure Savecustomfile1Click(Sender: TObject);
    procedure Custom1Click(Sender: TObject);
    procedure TileHorizontal1Click(Sender: TObject);
    procedure TileVertical2Click(Sender: TObject);
    procedure Toolbar1Click(Sender: TObject);
    procedure AbsenceReasons1Click(Sender: TObject);
    procedure CoverNotes1Click(Sender: TObject);
    procedure OpenTimetable1Click(Sender: TObject);
    procedure AddedStaff3Click(Sender: TObject);
    procedure DisplayClick(Sender: TObject);
    procedure RoomSwaps2Click(Sender: TObject);
    procedure WeeklyExtras1Click(Sender: TObject);
    procedure InLieus1Click(Sender: TObject);
    procedure TotalExtras1Click(Sender: TObject);
    procedure PastExtras2Click(Sender: TObject);
    procedure Select1Click(Sender: TObject);
    procedure Sort1Click(Sender: TObject);
    procedure ReplaceExtras1Click(Sender: TObject);
    procedure ExportFileClick(Sender: TObject);
    procedure EmailSetup1Click(Sender: TObject);
    procedure CreateBackup1Click(Sender: TObject);
    procedure RestorefromBackup1Click(Sender: TObject);
    procedure RescanTimetable1Click(Sender: TObject);
    procedure WipeLastExtras(Sender: TObject);
    procedure DoPrintPreviewExecute(Sender: TObject);
    procedure MainPrintExecute(Sender: TObject);
    procedure NewDataExecute(Sender: TObject);
    procedure CopyWinExecute(Sender: TObject);
    procedure WorkAheadNewExecute(Sender: TObject);
    procedure WorkAheadOpenExecute(Sender: TObject);
    procedure SetFontExecute(Sender: TObject);
    procedure PreferencesExecute(Sender: TObject);
    procedure ShowSelectionExecute(Sender: TObject);
    procedure NextViewExecute(Sender: TObject);
    procedure ShowStudListExecute(Sender: TObject);
    procedure ManualCoverExecute(Sender: TObject);
    procedure ShowTimetableExecute(Sender: TObject);
    procedure MyAutoCoverExecute(Sender: TObject);
    procedure ShowAbsentTeachersExecute(Sender: TObject);
    procedure ChangeAbsentExecute(Sender: TObject);
    procedure ShowLostTeachersExecute(Sender: TObject);
    procedure ChangeLostExecute(Sender: TObject);
    procedure FileNewDayExecute(Sender: TObject);
    procedure WorkAheadUseExecute(Sender: TObject);
    procedure ChangeEmailCoversExecute(Sender: TObject);
    procedure CoverWeightsExecute(Sender: TObject);
    procedure ChangeAddedStaffExecute(Sender: TObject);
    procedure ShowAddedAvailExecute(Sender: TObject);
    procedure ChangeNewClassExecute(Sender: TObject);
    procedure ShowNewClassesExecute(Sender: TObject);
    procedure ShowMergeClassExecute(Sender: TObject);
    procedure ChangeUnavailRoomExecute(Sender: TObject);
    procedure ShowUnavailRoomExecute(Sender: TObject);
    procedure ShowRoomSwapsExecute(Sender: TObject);
    procedure ShowCurrentExtrasExecute(Sender: TObject);
    procedure ShowInfoWinExecute(Sender: TObject);
    procedure ShowPastExtrasExecute(Sender: TObject);
    procedure actTeacherTalliesExecute(Sender: TObject);
    procedure DoIncludeYearsExecute(Sender: TObject);
    procedure ShowSubjectListExecute(Sender: TObject);
    procedure ShowStudentTtExecute(Sender: TObject);
    procedure ShowTeacherTimetableExecute(Sender: TObject);
    procedure ShowRoomTimetableExecute(Sender: TObject);
    procedure ShowSubjectTimetableExecute(Sender: TObject);
    procedure ChangeMergeClassExecute(Sender: TObject);
    procedure ChangeRoomSwapExecute(Sender: TObject);
    procedure grp01Click(Sender: TObject);
    procedure VisitAmigSystemsWebsite1Click(Sender: TObject);
    procedure Info2Click(Sender: TObject);
    procedure Changepassword1Click(Sender: TObject);
    procedure Adduser1Click(Sender: TObject);
    procedure Edituser1Click(Sender: TObject);
    procedure Deleteuser1Click(Sender: TObject);
    procedure Showusers1Click(Sender: TObject);
    procedure Autoloadtime1Click(Sender: TObject);
    procedure Checkforupdates1Click(Sender: TObject);
    procedure Logonasdifferentuser1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SaveDefaultDisplaySettings(Sender: TObject);
    procedure SetCurrentDataDirectoryAsDefault(Sender: TObject);
    procedure User1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WipeAll(Sender: TObject);
    procedure CloseAllWindows(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure ArchiveData(Sender: TObject);
    procedure CreateCoverInPDF(Sender: TObject);
    procedure ClearUserAccessLocks(Sender: TObject);
    procedure DeletePastExtras2Click(Sender: TObject);
    procedure teachersFree1Click(Sender: TObject);
  public
    procedure ToolbarClear;
    procedure UpdateToolbarIcons;
  end;

var
  MainForm: TMainForm;

implementation

uses
  tcommon,TCEload,tcommon3, TcInfo,prefer,ClassDefs, vwcoddlg, ttable, subbsdlg,
  subbysub,subbyslt,studlist, studttab,stuttdlg,Cnfglev,margins, fndtedlg,fndrodlg,
  fndstdlg, tcommon2, bckupdlg, Newday
     {below only added for popup2}
  ,teachtt,roomtt,subjcttt,edcustom,newclass,
  abtes,addstaff,absrsn,covnotes,lostclss,mrgclass,unavalro,roomswap,
  adstfsel,astfsldg,weight,excover,curextra,pstextra,coveryr, findstud, findte,
  findro,exdatent,clipbrd, Groupsel, sortgrp, TeWnd, TimesWnd, PrintPreviewForm,
  EmailSetup,progress, ShellAPI,Edpasswd,tcommon5, Adduser, Eduser, Deluser,
  Autoload, uAMGTeacherAbsence, uAMGCommon, AbZipper, LoadProgress, uAMGConst,
  uAMGTeacherAvailability, TeFree;
var
 ib: integer;

{$R *.DFM}
//{$R vistaAdm.RES}

procedure TMainForm.ToolbarClear;
begin
 DoPrintPreview.Enabled:=false;
 mainprint.Enabled:=false;
 CopyWin.Enabled:=false;
 ShowSelection.enabled:=false;
end;

procedure TMainForm.UpdateToolbarIcons;
var
 wintag:  integer;
 hasWin: boolean;
 tmpstr: string;
begin
 hasWin:=(mdiChildCount>0);
 wintag:=0;
 if hasWin then wintag:=activemdichild.tag;

 DoPrintPreview.Enabled:=hasWin;
 mainprint.Enabled:=hasWin;
 CopyWin.Enabled:=hasWin;
 NextView.Enabled:=(activemdichild is TDrawWin) and (winViewMax[activemdichild.tag]>0);
 ManualCover.Enabled:=(numchanges>0);
 MyAutoCover.Enabled:=EnableAutoFlag and (numchanges>0);
 tmpstr:=getAutoCoverIgnoredHint;
 if Trim(tmpstr)>'' then
  MyAutoCover.hint:='Auto Cover Extras'+endline+'('+tmpstr+')'
 else
  MyAutoCover.hint:='Auto Cover Extras';
 ChangeEmailCovers.enabled:=(numchanges>0);
 ShowInfoWin.Checked:=wnFlag[wnInfo];
 ShowAbsentTeachers.Checked:=wnFlag[wnAbsentTe];
 ShowCurrentExtras.checked:=wnFlag[wnCurrentExtras];
 ShowLostTeachers.Checked:=wnFlag[wnLostClass];
 ShowAddedAvail.Checked:=wnFlag[wnAddedSel];
 ShowNewClasses.Checked:=wnFlag[wnNewClass];
 ShowMergeClass.Checked:=wnFlag[wnMergeClass];
 ShowUnavailRoom.Checked:=wnFlag[wnUnavailRooms];
 ShowRoomSwaps.Checked:=wnFlag[wnRoomSwap];
 ShowPastExtras.Checked:=wnFlag[wnPastExtras];
 ShowSubjectList.Checked:=wnFlag[wnSubjectList];
 ShowStudList.Checked:=wnFlag[wnStudentList];
 ShowStudentTt.Checked:=wnFlag[wnStudentTt];
 ShowTimetable.Checked:=wnFlag[wnTtable];
 ShowTeacherTimetable.Checked:=wnFlag[wnTeacherTt];
 ShowRoomTimetable.Checked:=wnFlag[wnRoomTt];
 ShowSubjectTimetable.Checked:=wnFlag[wnSubjectTt];

 ShowSelection.enabled:=false;
 case wintag of
  wnTecode,wnAbsentTe,wnLostClass,wnUnavailRooms,wnRoomSwap,wnAddedSel: ShowSelection.caption:='&View ...';
  wnTtable: ShowSelection.caption:='Print &Selection ...';
   else ShowSelection.caption:='&Selection ...';
 end;
 case wintag of
  wnTecode,wnAddedSel,wnAbsentTe,wnLostClass,wnUnavailRooms,wnRoomSwap,wnCurrentExtras,wnPastExtras,
  wnSubjectList,wnTimeList,wnStudentList,wnStudentTt,wnTtable,
  wnTeacherTt,wnRoomTt,wnSubjectTt: ShowSelection.enabled:=true;
 end; {case}

end;

 procedure TMainForm.FormCreate(Sender: TObject);
var
  ising:   single;
begin
  ///if (usrPasslevel=0) then ActionToolBar1.ActionManager.FileName:='';   //no saving if general user
  Application.OnHint := ShowHint;
  HelpContext:=1;
  mainform.caption:=mainform.caption+' - '+school;
  application.hintcolor:=clAqua;
  {init panels}
  ///panel1.left:=0;
  ising := stbMain.ClientWidth; ///StatusLine.clientwidth;
  ///panel1.width:=trunc(9*(single(ising) / 32));
  stbMain.Panels[0].Width := Trunc(9 * (single(ising) / 32));

  ///panel2.left:=panel1.left+panel1.width;
  ising := stbMain.ClientWidth; ///StatusLine.clientwidth;
  ///panel2.width:=trunc(14*(single(ising) / 32));
  stbMain.Panels[1].Width := Trunc(14 * (single(ising) / 32));
  ///panel3.left:=panel2.left+panel2.width;
  stbMain.Panels[2].AppearanceStyle := psLight;
  ///panel3.width:=StatusLine.clientwidth - panel3.left;{div 3};
  self.windowstate:=wsMaximized;
  TeacherAbsences := TAMGTeacherAbsences.Create;
  TeacherTallies := TAMGTeacherTallies.Create;
  YearLevels := TYearLevels.Create;
  AddStaffAvailabilities := TAMGAddStaffAvailabilities.Create;
end;

procedure TMainForm.FormDblClick(Sender: TObject);
begin
  About.RefreshObjects;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if Assigned(TeacherAbsences) then
    FreeAndNil(TeacherAbsences);
  if Assigned(TeacherTallies) then
    FreeAndNil(TeacherTallies);
  if Assigned(YearLevels) then
    FreeAndNil(YearLevels);
  if Assigned(AddStaffAvailabilities) then
    FreeAndNil(AddStaffAvailabilities);
end;

procedure clearWeeklyExtras;
var
 s:       string;
 i:       integer;
begin
 s:='Clear weekly extras (Y/N)?';
 if messagedlg(s,mtConfirmation,[mbyes,mbno],0)<>mryes then exit;
 for i:=1 to nmbrTeachers do Eweek[i]:=0;
 updateTallies;
 UpdateAllWins;
end;

procedure clearInLieuExtras;
var
 s:       string;
 i:       integer;
begin
 s:='Clear inlieu extras taken (Y/N)?';
 if messagedlg(s,mtConfirmation,[mbyes,mbno],0)<>mryes then exit;
 for i:=1 to nmbrTeachers do Elieutaken[i]:=0;
 checkInLieus;
 updateTallies;
 UpdateAllWins;
end;

procedure clearReplaceExtras;
var
 s:       string;
 i:       integer;
begin
 s:='Clear Replacements Available (Y/N)?';
 if messagedlg(s,mtConfirmation,[mbyes,mbno],0)<>mryes then exit;
 for i:=1 to nmbrTeachers do EReplace[i]:=0;
 checkReplace;
 updateTallies;
 UpdateAllWins;
end;

procedure clearTotalExtras;
var
 s:       string;
 i:       integer;
begin
 s:='Clear all extras taken (Y/N)?';
 if messagedlg(s,mtConfirmation,[mbyes,mbno],0)<>mryes then exit;
 for i:=1 to nmbrTeachers do
 begin
  Eday[i]:=0;  Emonth[i]:=0; Eten[i]:=0; EReplace[i]:=0;
  Eweek[i]:=0; Etaken[i]:=0; Elieutaken[i]:=0;
 end;
 checkReplace;
 updateTallies;
 UpdateAllWins;
end;

procedure clearPastExtras;
var
 s,t:       string;
 f:       file;
 astr:    string;
begin
 s:='Clear past extras (Y/N)?';
 t := 'Note: Please ensure you have taken an archive backup of the ' + 
      'data folder because this action will delete all past extras.' +
      ' Continue deleting past extras?';

 // second dialog acts a a confirmation dialog
 if messagedlg(s,mtConfirmation,[mbyes,mbno],0)= mrYes then
 begin
   if MessageDlg(t,mtWarning,[mbYes,mbNo],0) <> mrYes then
     exit;
 end
 else
   exit;

 chdir(datadir);
 doAssignFile(f,'ABSENT.DAT');
 filemode:=fmOpenReadWrite+fmShareDenyWrite;
 rewrite(f,1);
 astr:='TCE5'; AbsentTotal:=0;
 blockwrite(f,astr[1],4);
 blockwrite(f,AbsentTotal,2);
 closefile(f);
 NeedPastExtrasINITflag:=true; {request reload of data}
 UpdateAllWins;
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  stbMain.Panels[0].Text := Application.Hint;
end;

procedure TMainForm.FilePrintSetup(Sender: TObject);
begin
  PrintSetupDialog.Execute;
end;

procedure TMainForm.FileExit(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.WindowTile(Sender: TObject);
begin
  Tilemode:=tbHorizontal;
  Tile;
end;

procedure TMainForm.WindowArrange(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainForm.HelpContents(Sender: TObject);
begin
  if HelpRouter1.HTMLhelpInstalled then
    HelpRouter1.HelpContent;
end;

procedure TMainForm.HelpSearch(Sender: TObject);
const
  EmptyString: PChar = '';
begin
  if HelpRouter1.HTMLhelpInstalled then
    HelpRouter1.HelpKeyword('');
end;

procedure TMainForm.HelpHowToUse(Sender: TObject);
begin
  if HelpRouter1.HTMLhelpInstalled then
    HelpRouter1.HelpKeyword('');
end;

procedure TMainForm.HelpAbout(Sender: TObject);
begin
  about.showmodal;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
 i:      integer;
 winCount:    integer;
 msg: string;
 msgret: word;
begin
 if OKquitcheck then
  begin
   msg:='Exit Time Chart Extra.'+endline+endline;
   msg:=msg+'Are you sure you want to Quit ?';
   msgret:=messagedlg(msg,mtConfirmation,[mbYes,mbNo],0);
   if msgret=mrNo then
   begin
    action:=caNone; {don't allow close}
    exit;    {cancel quit as in mac}
   end;
  end;

 if (usrPasslevel<>0) then
 begin
  saveExtras;
  removeDormantLocks;
 end;

 if (usrPasslevel<>0) then
  if OKbackup then
  begin
   backup_action:=1; {backup}
   BackupDataDlg:=TBackupDataDlg.create(self);   {allocate dlg}
   BackupDataDlg.showmodal;
   BackupDataDlg.free;
  end;
{continue exit}
winCount:=mainform.mdiChildCount;
 screen.cursor:=crHourglass;

 try
  winOrderNum:=0;
  if winCount>0 then
   for i:=1 to winCount do
   begin
    inc(winOrderNum);
    winOrder[winOrderNum]:=mainform.ActiveMdiChild.tag;
    mainform.ActiveMdiChild.close;
    mainform.ActiveMdiChild.free;
   end;

  saveWinDisplay;    {save settings and window pos's}
 finally
  screen.cursor:=crDefault;
 end; {try}
end;

procedure TMainForm.Teacher2Click(Sender: TObject);
begin
 TeWinSelect;
end;

procedure TMainForm.Times1Click(Sender: TObject);
begin
 TimesWinSelect;
end;

procedure TMainForm.TileVertical1Click(Sender: TObject);
begin
  Tilemode:=tbVertical;
  Tile;
end;

procedure TMainForm.Close1Click(Sender: TObject);
begin
  if mainform.mdiChildCount>0 then
    mainform.ActiveMdiChild.close;
end;

procedure TMainForm.CloseAllWindows(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to mdiChildCount -1 do
  begin
    Application.ProcessMessages;
    ActiveMdiChild.Close;
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
var
  ising: Single;
begin
  ///panel1.left:=0;
  (*
  panel1.width:=StatusLine.clientwidth div 4;{trunc(15*(StatusLine.clientwidth / 36))}
  *)
  ising := stbMain.ClientWidth; ///StatusLine.clientwidth;
  ///panel1.width:=trunc(9*(single(ising) / 32));
  stbMain.Panels[0].Width := Trunc(9 * (Single(ising) / 32));
  ///panel2.width:=trunc(9*(single(ising) / 32));
  stbMain.Panels[1].Width := Trunc(9 * (Single(ising) / 32));
  ///panel2.left:=panel1.left+panel1.width;
  (*
  panel2.width:=StatusLine.clientwidth div 2;
  *)
  ising := stbMain.ClientWidth; ///StatusLine.clientwidth;
  ///panel2.width:=trunc(14*(single(ising) / 32));
  stbMain.Panels[1].Width := Trunc(14 * (Single(ising) / 32));
  ///panel3.left:=panel2.left+panel2.width;
  ///panel3.width:=StatusLine.clientwidth - panel3.left;{div 3};
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  UpdateToolbarIcons;
end;

procedure TMainForm.Color1Click(Sender: TObject);
begin
{ Application.CreateForm(Tcolordlg, colordlg);  }
(* colordlg:=Tcolordlg.create(self);   {allocate dlg}
 colordlg.showmodal;
 colordlg.free;   {release dlg} *)
end;

procedure TMainForm.FileMenuClick(Sender: TObject);
begin
  if mdiChildCount>0 then
  begin
    close1.enabled:= True;
    mniFileClose.Enabled := True;
    mniFileCloseAll.Enabled := True;
    print1.enabled:= True;
    exportfile.Enabled:= True;
  end
  else
  begin
    close1.enabled:= False;
    mniFileClose.Enabled := False;
    mniFileCloseAll.Enabled := False;
    print1.enabled:= False;
    exportfile.Enabled:= False;
  end;
end;

procedure TMainForm.Timetable3Click(Sender: TObject);
begin
 TtableWinSelect;
end;

procedure TMainForm.WindowMenuClick(Sender: TObject);
begin
 TickCodeSubMenu(Codes1);
 byTimeslot1.checked:=wnFlag[wnTimeList];
 teachersfree1.checked:=wnFlag[wnTeFree];
end;

procedure TMainForm.Clear1Click(Sender: TObject);
begin
 clearcustom;
end;

procedure TMainForm.ClearUserAccessLocks(Sender: TObject);
begin
  if MessageDlg(AMG_CLEAR_ACCESS_LOCKS_MSG, mtConfirmation, mbYesNo, 0) = mrYes then
    CheckAccessFile;
end;

procedure TMainForm.Timetable2Click(Sender: TObject);
begin
 if wnFlag[wnTtable] then timetable3.checked:=true else timetable3.checked:=false;
end;

procedure TMainForm.Timetable1Click(Sender: TObject);
begin
 TtableWinSelect;
end;

procedure TMainForm.ByTimeslot1Click(Sender: TObject);
begin
 SubjectbyTimeSlotwinSelect;
end;

procedure TMainForm.New1Click(Sender: TObject);
begin
 if clearCustom then
 begin
  custom:=''; {no name}
  UpdateWindow(wnInfo);
  editcustominformation;
 end;
end;

procedure TMainForm.opencustomfile1Click(Sender: TObject);
begin
 if loadcustom then editcustominformation;
end;

procedure TMainForm.Levels1Click(Sender: TObject);
begin
  if (usrPasslevel = 0) then
  begin
    showRestrictedMsg;
  end
  else
  begin
    ConfigureLevels := TConfigureLevels.Create(Application);
    try
      if ConfigureLevels.ShowModal = mrOk then
        if RescanTimetable(True) then
          UpdateAllWins;
    finally
      ConfigureLevels.Free;
    end;
  end;
end;

procedure TMainForm.Margins1Click(Sender: TObject);
begin
 pmargins:=Tpmargins.create(self);   {allocate dlg}
 pmargins.showmodal;
 pmargins.free;
end;

procedure TMainForm.Student2Click(Sender: TObject);
begin
 findStudentdlg:=TfindStudentdlg.create(self);   {allocate dlg}
 findStudentdlg.showmodal;
 findStudentdlg.free;               {release dlg}
 if wnFlag[wnFindStud] then FindStudent.setfocus;   {force focus}
end;

procedure TMainForm.Teacher3Click(Sender: TObject);
begin
 findteacherdlg:=Tfindteacherdlg.create(self);   {allocate dlg}
 findteacherdlg.showmodal;
 findteacherdlg.free;               {release dlg}
 if wnFlag[wnFindTeach] then FindTeacherWin.setfocus;   {force focus}
end;

procedure TMainForm.Room3Click(Sender: TObject);
begin
 findroomdlg:=Tfindroomdlg.create(self);   {allocate dlg}
 findroomdlg.showmodal;
 findroomdlg.free;               {release dlg}
 if wnFlag[wnFindRoom] then FindRoomWin.setfocus;  {force focus}
end;

procedure TMainForm.Editcustomfile1Click(Sender: TObject);
begin
 editcustominformation;
end;

procedure TMainForm.Savecustomfile1Click(Sender: TObject);
begin
 saveCustom;
end;

procedure TMainForm.Custom1Click(Sender: TObject);
begin
 savecustomfile1.enabled:=(addnum>0);
 clear1.enabled:=(addnum>0);
end;

procedure TMainForm.TileHorizontal1Click(Sender: TObject);
begin
  Tilemode:=tbHorizontal;
  Tile;
end;

procedure TMainForm.TileVertical2Click(Sender: TObject);
begin
  Tilemode:=tbVertical;
  Tile;
end;

procedure TMainForm.Toolbar1Click(Sender: TObject);
begin
 {ActionToolbar1.Visible:=not(ActionToolbar1.Visible);
 ToolBarFlag:=ActionToolbar1.Visible;
 UpdateToolbarIcons;}
end;

procedure TMainForm.AbsenceReasons1Click(Sender: TObject);
begin
 absreasonswinselect;
end;

procedure TMainForm.CreateCoverInPDF(Sender: TObject);
begin
  if CheckAccessRights(4, 9, True) then
  begin
    ProgressForm := TProgressForm.Create(Application);
    try
      if EmailCoverFlag or EmailAbsentFlag or EmailAddedFlag then
      begin
        if not ProgressForm.GeneratePDFCover then
        begin
          MessageDlg('No cover is found.', mtInformation, [mbOk], 0)
        end;
      end
      else
      begin
        MessageDlg('No cover is selected.' +  LF + CR + 'To select covers to generate PDF or email go to Email Setup in Cover menu and set "Send Emails to".', mtInformation, [mbOk], 0)
      end;
    finally
      FreeAndNil(ProgressForm);
    end;
    CheckAccessRights(4, 9, False);
    Exit;
  end;
end;

procedure TMainForm.CoverNotes1Click(Sender: TObject);
begin
 covernoteswinselect;
end;

procedure TMainForm.OpenTimetable1Click(Sender: TObject);
var
 tmpStr,tmpExt:  string;
 i:       integer;
 msg:     string;
begin
  OpenDialog.Title:='Load Timetable';
  OpenDialog.HelpContext:=9;
  OpenDialog.Filter:='Timetable|*.ttw';
  OpenDialog.InitialDir:=timedir;
  OpenDialog.filename:='';
  OpenDialog.defaultext:='ttw';
  OpenDialog.options:=[ofFileMustExist,ofHideReadOnly,ofPathMustExist,ofShowHelp];
  if OpenDialog.Execute then
  begin
   tmpExt:=ExtractFileExt(OpenDialog.Filename);
   tmpext:=uppercase(trim(tmpext));
   if (tmpExt<>'.TTW') then
   begin
    msg:='The file '+endline+'<'+opendialog.filename+'>'+endline+' is NOT a ';
    msg:=msg+'TimeChart Timetable file.';
    messagedlg(msg,mtError,[mbOK],0);
    exit;
   end;

   tmpStr:=ExtractFileName(OpenDialog.Filename);
   i:=pos('.',tmpStr);
   tmpStr:=copy(tmpStr,1,i-1); {only want filename - no ext.}
   ttfile:=tmpStr;
   tmpStr:=OpenDialog.Filename;
   timedir:=GetDirName(tmpStr);
   About.GetTTable;
   AlterTimeFlag:=True;
   SetTimeCell;
   SetDays;
   SetPshowmax;
   updateStatusPanel;
   UpdateTimeTableWins;
   UpdateWindow(wnInfo);
   if wnFlag[wnTtable]=false then  {display it if not already there}
    TtableWinSelect;
  end;

end;

procedure TMainForm.AddedStaff3Click(Sender: TObject);
begin
 AddedStaffWinSelect;
end;

procedure TMainForm.DisplayClick(Sender: TObject);
begin
 {if ActionToolbar1.Visible then Toolbar1.Caption:='Hide &Toolbar'
  else Toolbar1.Caption:='Show &Toolbar';}
end;

procedure TMainForm.RoomSwaps2Click(Sender: TObject);
begin
 roomswapsWinSelect;
 roomswaps.Change2Click(self);
end;

procedure TMainForm.WipeAll(Sender: TObject);
begin
  if CheckAccessRights(4,9,true) then
  begin
    ClearWeeklyExtras;
    ClearInLieuExtras;
    ClearReplaceExtras;
    ClearTotalExtras;
    WipeLastExtras(Self);
    // ClearPastExtras; removed Mantis #910
    CheckAccessRights(4,9,false)
  end;

end;

procedure TMainForm.WeeklyExtras1Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  clearWeeklyExtras;
  CheckAccessRights(4,9,false)
 end;
end;

procedure TMainForm.InLieus1Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  clearInLieuExtras;
  CheckAccessRights(4,9,false)
 end;
end;

procedure TMainForm.TotalExtras1Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  clearTotalExtras;
  CheckAccessRights(4,9,false)
 end;
end;

procedure TMainForm.PastExtras2Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  clearPastExtras;
  CheckAccessRights(4,9,false)
 end;
end;

procedure TMainForm.Select1Click(Sender: TObject);
begin
 groupseldlg:=Tgroupseldlg.create(self);   {allocate dlg}
 groupseldlg.showmodal;
 groupseldlg.free;    {release dlg}
end;

procedure TMainForm.Sort1Click(Sender: TObject);
begin
 sortChangeFlag:=false;
 SortGroupDlg:=TSortGroupDlg.create(self);   {allocate dlg}
 SortGroupDlg.showmodal;
 SortGroupDlg.free;    {release dlg}
end;

procedure TMainForm.ReplaceExtras1Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  clearReplaceExtras;
  CheckAccessRights(4,9,false)
 end;
end;

procedure TMainForm.ExportFileClick(Sender: TObject);
var
 winNum: smallint;
begin
 if mdichildcount=0 then exit;
 winNum:=activeMDIchild.tag;
 TextExportWindow(winNum);
end;

procedure TMainForm.EmailSetup1Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin        
  EmailSetupDlg:=TEmailSetupDlg.create(application);   {allocate dlg}
  EmailSetupDlg.showmodal;
  EmailSetupDlg.free;
  CheckAccessRights(4,9,false)
 end;
end;

procedure TMainForm.CreateBackup1Click(Sender: TObject);
begin
 if (usrPasslevel=0) then
 begin
  showRestrictedMsg;
  exit;
 end;

 backup_action:=1; {backup}
 BackupDataDlg:=TBackupDataDlg.create(self);   {allocate dlg}
 BackupDataDlg.showmodal;
 BackupDataDlg.free;
end;

procedure TMainForm.RestorefromBackup1Click(Sender: TObject);
begin
 if (usrPasslevel=0) then
 begin
  showRestrictedMsg;
  exit;
 end;

 backup_action:=2; {restore}
 BackupDataDlg:=TBackupDataDlg.create(self);   {allocate dlg}
 BackupDataDlg.showmodal;
 BackupDataDlg.free;
end;

procedure TMainForm.RescanTimetable1Click(Sender: TObject);
begin
  if RescanTimetable then
    UpdateAllWins;

(*var
 s: string;
 puton,putoff:     tpTe32Data;
 i,p,sub,te,ro,ro1,year1,level1: integer;
 new, new1: integer;
 notlost: boolean;
begin
 if (usrPasslevel=0) then exit;

 s:='Scan for changes to Timetable (Y/N)?';
 if messagedlg(s,mtConfirmation,[mbyes,mbno],0)<>mryes then exit;
 {initialize temp arrays}
 for i:=1 to numcodes[2] do begin puton[i]:=0; putoff[i]:=0; end;
 calculateTeach; {recalculate teach, teNA, roomteach and rolost}
 for i:=1 to numchanges do {check timetable details in changes}
  begin
   ro:=Changes[i].oldroom; p:=Changes[i].timeslot; te:=Changes[i].oldte;
   if (Changes[i].gen=0) and (ro>0) and (p>0) then {room change}
    if GetRoomTtItem(sub,te,Year1,Level1,ro,ttday,p-1) then
     begin
      Changes[i].year:=year1; Changes[i].level:=level1; Changes[i].sub:=sub;
      Changes[i].oldte:=te;
     end;
   if Changes[i].gen=1 then {absent teacher}
    if GetTeachTtItem(sub,ro,Year1,Level1,te,ttday,p-1) then
     begin
      if Changes[i].oldroom=Changes[i].newroom then Changes[i].newroom:=ro;
      Changes[i].year:=year1; Changes[i].level:=level1; Changes[i].sub:=sub;
      Changes[i].oldroom:=ro;
     end;
  end;

 ConsequentNum:=0;
 for i:=1 to numchanges do  {remove any teacher covers that can't be done}
  begin
   te:=Changes[i].newte; p:=Changes[i].timeslot;
   if (Changes[i].kind<2) or (te<1) or (te>numcodes[1]) or (te=Changes[i].oldte)
       or (p<1) or (p>tlimit[ttDay]) then continue; {data not in range or no cover}
   new:=teach[te] and (1 shl p);
   new1:=teNA[te] and (1 shl p);
   notlost:=(telost[te] and (1 shl p))<>0;
   if ((new=0) and notlost) or (new1=0) then RemoveTeacherCover(i,p);
   {teaching added or Not Available added}
  end;
 if ConsequentNum>0 then RemoveConsequents;

 {add or remove any teacher absences that no longer apply}
 for te:=1 to numcodes[1] do
  begin
   for p:=1 to tlimit[ttday] do   {absent, and now not on timetable or is NA}
    if boolean(not(teAbsent[te]) and (teach[te] or (not(teNA[te]))) and (1 shl p))
     then removeabsent(te,p);
   updateAbsence(te); {change to unconditional check of absences}
  end;
 {fix up room covers, unavailable and swaps}
 for i:=1 to numchanges do  {remove any room covers that can't be done}
  begin
   ro:=Changes[i].newroom; p:=Changes[i].timeslot;
   ro1:=Changes[i].oldroom;
   if (ro<1) or (ro>numcodes[2]) or (ro=ro1)
       or (p<1) or (p>tlimit[ttDay]) then continue; {data not in range or no cover}
   new:=Roomteach[ro] and (1 shl p);
   notlost:=(rolost[ro] and (1 shl p))<>0;
   if ((new=0) and notlost) then
    begin  {either a cover or a swap}
     if ((roswap[ro] and (1 shl p))=0)and (ro1>0) then BalanceRoomSwap(ro1,ro,p)
      else RemoveMyRoomCover(i,p);
    end;
  end;

 for ro:=1 to numcodes[2] do   {add or remove unavailable room changes}
  begin
   for p:=1 to tlimit[ttday] do   {absent, and now not on timetable or is NA}
    if boolean(not(roAbsent[ro]) and Roomteach[ro] and (1 shl p))
     then removeAbsentRoom(p,ro);
   {do interim recalc of RoomOn so that UpdateRoomAbsence works correctly}
   RoomOn[ro]:=(RoomTeach[ro] or not(rolost[ro])) and roCover[ro];
   UpdateRoomAbsence(ro);
  end;
{recalc bit maps}
 for i:=1 to numcodes[1] do
  begin tecover[i]:=-1; tElieu[i]:=-1; tereplace[i]:=-1; end;
 for i:=1 to numcodes[2] do
  begin roswap[i]:=-1; rocover[i]:=-1; end;

 for i:=1 to numchanges do
  begin
   p:=Changes[i].timeslot; ro:=Changes[i].oldroom; ro1:=Changes[i].oldroom;
   te:=Changes[i].newte;
   if (ro1<>ro) then
    begin
     if ro>0 then putoff[ro]:=putoff[ro] and (1 shl p);
     if ro1>0 then puton[ro]:=puton[ro] and (1 shl p);
     if (ro>0) and (ro1>0) and ((roAbsent[ro] and (1 shl p))<>0) then
      begin
       roswap[ro1]:=roswap[ro1] and (not(1 shl p));
       roswap[ro]:=roswap[ro] and (not(1 shl p));
      end;
     if (ro1>0) and (((ro>0) and ((roAbsent[ro] and (1 shl p))=0)) or
      (changes[i].gen>2)) then rocover[ro1]:=rocover[ro1] and (not(1 shl p));
    end;
   if te>0 then
    begin
     if changes[i].kind=2 then tereplace[te]:=tereplace[te] and (not(1 shl p));
     if changes[i].kind=3 then tElieu[te]:=tElieu[te] and (not(1 shl p));
     if changes[i].kind>3 then tecover[te]:=tecover[te] and (not(1 shl p));
    end;
  end;

 for i:=1 to numcodes[1] do {recalc teOn bitmaps}
  teon[i]:=(teach[i] or not(telost[i])) and teCover[i] and tereplace[i] and tElieu[i];
 for i:=1 to numcodes[2] do {recalc RoomOn bitmaps}
  RoomOn[i]:=(RoomTeach[i] or not(rolost[i])) and roCover[i];
 for ro:=1 to numcodes[2] do
  for p:=1 to Tlimit[ttday] do
   begin
    if ((putoff[ro] and (1 shl p))<>0) and ((puton[ro] and (1 shl p))=0) then
      RoomOn[ro]:=RoomOn[ro] or (1 shl p);
    if ((putoff[ro] and (1 shl p))=0) and ((puton[ro] and (1 shl p))<>0) then
      RoomOn[ro]:=RoomOn[ro]  and (not(1 shl p));
   end;

 updateteacherMap;
 updateRoomMap;
 UpdateAllWins;*)
end;

procedure TMainForm.WipeLastExtras(Sender: TObject);
 var
 s:       string;
 i:       integer;
begin
 if CheckAccessRights(4,9,true) then
 begin
  s:='Clear dates of last extra (Y/N)?';
  if messagedlg(s,mtConfirmation,[mbyes,mbno],0)<>mryes then exit;
  for i:=1 to nmbrTeachers do
   begin Eday[i]:=0; Emonth[i]:=0; end;
  updateTallies;
  if wnFlag[wnTeCode] then TeWindow.UpdateWin;
  CheckAccessRights(4,9,false)
 end;
end;

procedure TMainForm.DoPrintPreviewExecute(Sender: TObject);
begin
 PreviewWin:=activeMDIchild.tag;
 PrntPreviewForm:=TPrntPreviewForm.create(self);   {allocate dlg}
 PrntPreviewForm.WindowState:=wsMaximized;
 PrntPreviewForm.showmodal;
 PrntPreviewForm.free;               {release dlg}
end;

procedure TMainForm.teachersFree1Click(Sender: TObject);
begin
  TeachersFreewinSelect;
end;

procedure TMainForm.MainPrintExecute(Sender: TObject);
var
 winNum:  integer;
begin
 winNum:=activeMDIchild.tag;
 printOurWindow(winNum);
end;

procedure TMainForm.NewDataExecute(Sender: TObject);
var
  msg:   string;
  okForGeneralUsr: bool;
  f:            file;
  tmpDir:       string[100];
begin
  saveWinDisplay;
  GetDirDlg.showmodal;
  if newdataloadcancel then exit;  {user selected cancel in tcgetdir unit}

  {----------------------------------------------}
  if usrPassLevel=0 then {prevent general user going to faulty dir}
  begin
    ChDir(datadir);
    okForGeneralUsr:=true;
    if not(fileexists('SUBCODE.DAT')) then okForGeneralUsr:=false;
    if okForGeneralUsr then
    try
     try
       doAssignFile(f,'SUBCODE.DAT');
       filemode:=fmOpenRead+fmShareDenyNone;
       reset(f,1);
       if filesize(f)=0 then okForGeneralUsr:=false;
     finally
      closefile(f);
     end;
     if okForGeneralUsr then
     begin
      if not(fileexists('TECODE.DAT')) then okForGeneralUsr:=false;
      if okForGeneralUsr then
      begin
       try
        doAssignFile(f,'TECODE.DAT');
        filemode:=fmOpenRead+fmShareDenyNone;
        reset(f,1);
        if filesize(f)=0 then okForGeneralUsr:=false;
       finally
        closefile(f);
       end;
       if okForGeneralUsr then
       begin
        if not(fileexists('ROOMS.DAT')) then okForGeneralUsr:=false;
        if okForGeneralUsr then
         try
          doAssignFile(f,'ROOMS.DAT');
          filemode:=fmOpenRead+fmShareDenyNone;
          reset(f,1);
          if filesize(f)=0 then okForGeneralUsr:=false;
         finally
          closefile(f);
         end;
       end;
      end;
     end;
    except
    end;
    if not(okForGeneralUsr) then
    begin
      msg:='The directory '+datadir+endline;
      msg:=msg+'Does NOT contain useful Time Chart data.'+endline+endline;
      msg:=msg+'No valid Subject, Teacher or Room data was found.';
      messagedlg(msg,mtError,[mbOK],0);
      dataDir:=tmpDir;
      Exit;
    end;
  end; {if usrPassLevel=0 }
  {----------------------------------------------}
  removeDormantLocks;  {any still left}

  try
    NeedPastExtrasINITflag:=true;
    clearStudListBoxSelections; {clear stud sels}
    screen.cursor:=crHourglass;
    textdir:=datadir;
    timedir:=datadir;
    About.FirstLoad;
    CheckWinSelections;
    mainform.canvas.font.assign(tcfont);
    getFontWidths; {get max for commons such as teacher name, faculty name etc}
    if wnflag[wnInfo] then infowin.refresh;
    if wnFlag[wnTtable] then
    begin
      InitTtableWin(Ttablewin);
      Ttable.updateClashStatusBar(Ttablewin);
      Ttablewin.repaint;
    end;
    UpdateAllWins;
  finally
    screen.cursor:=crDefault;
  end; {try}
end;

procedure TMainForm.CopyWinExecute(Sender: TObject);
var
 winNum: smallint;
begin
 if mdichildcount=0 then exit;
 winNum:=activeMDIchild.tag;
 CopyExportWindow(winNum);
end;

procedure TMainForm.WorkAheadNewExecute(Sender: TObject);
var
 tmpStr:  string;
 i:       integer;
 msg:     string;
 msgret:  word;
begin
 if (usrPasslevel=0) then
 begin
  showRestrictedMsg;
  exit;
 end;
 
 chdir(exdir);
 OpenDialog.Title:='New Work Ahead File';
 OpenDialog.HelpContext:=5;
 OpenDialog.Filter:='Work Ahead|*.xtr';
 OpenDialog.InitialDir:=exdir;
 OpenDialog.filename:='';
 OpenDialog.defaultext:='xtr';
 OpenDialog.options:=[ofHideReadOnly,ofPathMustExist,ofShowHelp];
 if OpenDialog.Execute then
  begin
   tmpStr:=ExtractFileName(OpenDialog.Filename);
   i:=pos('.',tmpStr);
   tmpStr:=copy(tmpStr,1,i-1); {only want filename - no ext.}
   if uppercase(tmpStr)='EXTRAS' then
    begin
     msg:='The "Extras" file should not be used to work ahead.';
     messagedlg(msg,mtError,[mbOK],0);
     exit;
    end;
   if fileexists(tmpStr+'.xtr') then
    begin
     msg:='The file '+tmpStr+' is already in use.'+endline+'Use anyway?';
     msgret:=messagedlg(msg,mtConfirmation,[mbYes,mbNo],0);
     if msgret<>mrYes then exit;
    end;
    if CheckAccessRights(4,9,true) then
    begin
     SetNewDay(3);
    end;
 end; {file selected}
end;

procedure TMainForm.WorkAheadOpenExecute(Sender: TObject);
var
 tmpStr,tmpExt:  string;
 i:       integer;
 msg:     string;
begin
 if (usrPasslevel=0) then
 begin
  showRestrictedMsg;
  exit;
 end;

 OpenDialog.Title:='Open Work Ahead File';
 OpenDialog.HelpContext:=6;
 OpenDialog.Filter:='Extras|*.xtr';
 OpenDialog.InitialDir:=datadir;
 OpenDialog.filename:='';
 OpenDialog.defaultext:='xtr'{'tt'};
 OpenDialog.options:=[ofFileMustExist,ofHideReadOnly,ofPathMustExist,ofShowHelp];
 if OpenDialog.Execute then
  begin
   tmpExt:=ExtractFileExt(OpenDialog.Filename);
   tmpext:=uppercase(trim(tmpext));
   if (tmpExt<>'.XTR') then
   begin
    msg:='The file '+endline+'<'+opendialog.filename+'>'+endline+' is NOT a ';
    msg:=msg+'Work Ahead Extras file.';
    messagedlg(msg,mtError,[mbOK],0);
    CheckAccessRights(4,9,false);
    exit;
   end;
   if CheckAccessRights(4,9,true) then
   begin
    SaveExtras;
    CheckAccessRights(4,9,false);
   end;
   tmpStr:=ExtractFileName(OpenDialog.Filename);
   i:=pos('.',tmpStr);
   tmpStr:=copy(tmpStr,1,i-1); {only want filename - no ext.}
   exfile:=tmpStr;
   tmpStr:=OpenDialog.Filename;
   exdir:=GetDirName(tmpStr);   exload:=exdir;
   if CheckAccessRights(4,9,true) then
   begin
    ExtrasIn;
    UpdateAllWins;
    updateStatusPanel;
    CheckAccessRights(4,9,false);
   end;
  end;
end;

procedure TMainForm.SetFontExecute(Sender: TObject);
begin
 getAndSetNewFont;
end;

procedure TMainForm.PreferencesExecute(Sender: TObject);
begin
  FrmOptions := TFrmOptions.Create(Self);   {allocate dlg}
  try
    FrmOptions.ShowModal;
  finally
    FreeAndNil(FrmOptions);               {release dlg}
  end;
end;

procedure TMainForm.ShowSelectionExecute(Sender: TObject);
var
 wintag:  integer;
begin
 if mdichildcount=0 then exit;
 wintag:=activeMDIchild.tag;
 case wintag of
  wnTecode: TeWindow.View1Click(activemdichild);
  wnTimes: TimesWindow.Change1Click(activemdichild);
  wnAbsReason: AbsReasonWin.Change1Click(activemdichild);
  wnCoverNote: covernoteswin.Change1Click(activemdichild);
  wnAddedStaff: Addedstaffwin.Change1Click(activemdichild);
  wnAddedSel: addedstaffselwin.View2Click(activemdichild);
  wnAbsentTe: Absentte.View1Click(activemdichild);
  wnNewClass: NewClasseswin.Change2Click(activemdichild);
  wnLostClass: LostClasseswin.View2Click(activemdichild);
  wnMergeClass: MergedClasseswin.Change2Click(activemdichild);
  wnUnavailRooms: unavailablerooms.View1Click(activemdichild);
  wnRoomSwap: roomswaps.View1Click(activemdichild);
  wnCurrentExtras: CurrentExtrasWin.Change2Click(activemdichild);
  wnPastExtras: pastExtrasWin.Change2Click(activemdichild);
  wnSubjectList: subbysubjectwin.subject2Click(activemdichild);
  wnTimeList: subbytimeslotwin.timeslot2Click(activemdichild);
  wnStudentList: studentlistwin.selection1Click(activemdichild);
  wnStudentTt: sttable.selection2Click(activemdichild);
  wnTtable: ttablewin.selection1Click(activemdichild);
  wnTeacherTt: tettable.selection2Click(activemdichild);
  wnRoomTt: rottable.selection2Click(activemdichild);
  wnSubjectTt: suttable.selection2Click(activemdichild);
  wnTeFree: TeachersFree.Selection2Click(activemdichild);
 end; {case}
end;

procedure TMainForm.NextViewExecute(Sender: TObject);
begin
 if activemdichild is TDrawWin then
  TDrawWin(activemdichild).ChangeView;
end;

procedure TMainForm.ShowStudListExecute(Sender: TObject);
begin
 StudentListwinSelect;
end;

procedure TMainForm.ManualCoverExecute(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  Coverdlg:=TCoverdlg.create(application);   {allocate dlg}
  Coverdlg.showmodal;
  Coverdlg.free;
  CheckAccessRights(4,9,false);
 end;
end;

procedure TMainForm.ShowTimetableExecute(Sender: TObject);
begin
 TtableWinSelect;
end;

procedure TMainForm.MyAutoCoverExecute(Sender: TObject);
var
 oldAutoCover: integer;
begin
 if EnableAutoFlag then
  begin
   if CheckAccessRights(4,9,true) then
   begin
    oldAutoCover:=autocover;
    autocover:=1;
    ToolBarAuto:=true;
    SetCoverVariables;
    DoAutoCover;
    ToolBarAuto:=false;
    autocover:=oldAutoCover;
    CheckAccessRights(4,9,false);
   end;
  end;
end;

procedure TMainForm.ShowAbsentTeachersExecute(Sender: TObject);
begin
 AbsentteWinSelect;
end;

procedure TMainForm.ChangeAbsentExecute(Sender: TObject);
begin
 AbsentteWinSelect;
 if (usrPasslevel>0) then Absentte.Change2Click(self);
end;

procedure TMainForm.ShowLostTeachersExecute(Sender: TObject);
begin
 LostClassWinSelect;
end;

procedure TMainForm.ChangeLostExecute(Sender: TObject);
begin
 LostClassWinSelect;
 if (usrPasslevel>0) then LostClasseswin.Change2Click(self);
end;

procedure TMainForm.FileNewDayExecute(Sender: TObject);
begin
 if (usrPasslevel=0) then
 begin
  showRestrictedMsg;
  exit;
 end;

 SetNewDay(2);
end;

procedure TMainForm.WorkAheadUseExecute(Sender: TObject);
var
 tmpStr,tmpExt,file1:  string;
 i:       integer;
 msg:     string;
 msgret:  word;
 exitnew: boolean;
begin
 if (usrPasslevel=0) then
 begin
  showRestrictedMsg;
  exit;
 end;

 OpenDialog.Title:='Use Work Ahead File';
 OpenDialog.HelpContext:=7;
 OpenDialog.Filter:='Extras|*.xtr';
 OpenDialog.InitialDir:=datadir;
 OpenDialog.filename:='';
 OpenDialog.defaultext:='xtr'{'tt'};
 OpenDialog.options:=[ofFileMustExist,ofHideReadOnly,ofPathMustExist,ofShowHelp];
 if OpenDialog.Execute then
  begin
   tmpExt:=ExtractFileExt(OpenDialog.Filename);
   tmpext:=uppercase(trim(tmpext));
   if (tmpExt<>'.XTR') then
   begin
    msg:='The file '+endline+'<'+opendialog.filename+'>'+endline+' is NOT a ';
    msg:=msg+'Work Ahead Extras file.';
    messagedlg(msg,mtError,[mbOK],0);
    exit;
   end;
   tmpStr:=ExtractFileName(OpenDialog.Filename);
   i:=pos('.',tmpStr);
   tmpStr:=copy(tmpStr,1,i-1);
   if uppercase(tmpStr)=uppercase(usefile) then
    begin
     msg:='The file '+endline+'<'+opendialog.filename+'>'+endline+' is already in use';
     messagedlg(msg,mtError,[mbOK],0);
     exit;
    end;

   if CheckAccessRights(4,9,true) then
   begin
    SaveExtras;
    CheckAccessRights(4,9,false);
   end
   else exit; {no access}

   exitnew:=false;
   if not(ReloadUseFile) then exit;
   if numchanges>0 then
    begin
     msg:='Archive changes for '+inttostr(exday)+' '+month[exmonth]+' '+inttostr(exyear)+'?';
     msgret:=messagedlg(msg,mtConfirmation,[mbYes,mbNo],0);
     if msgret<>mrYes then exitnew:=true;
    end;
   if exitnew then exit;
   UpdatePastExtras(exday,exmonth,ttday);
   if (uppercase(exfile)<>'EXTRAS') then
   begin
    chdir(exdir);
    file1:=exfile+'.XTR';
    deletefile(Pchar(file1));
    AccessFileMaintenance(exfile);
   end;

   exfile:=tmpStr;  usefile:=exfile;
   tmpStr:=OpenDialog.Filename;
   exdir:=GetDirName(tmpStr);   exload:=exdir;  usedir:=exload;
   if CheckAccessRights(4,9,true) then
   begin
    ExtrasIn;
    SaveUseName;
    UpdateAllWins;
    updateStatusPanel;
//    #47 Hiding this next line (RescanTimetable) seemed to fix the Work Ahead issue - need to find out why this was being called here
//    I have now allowed access to this routine and have skipped some code in there instead
    RescanTimeTable(True);
    CheckAccessRights(4,9,false);
   end
  end;
end;

procedure TMainForm.ChangeEmailCoversExecute(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  ProgressForm:=TProgressForm.create(application);   {allocate dlg}
  ProgressForm.Tag:=1;
  ProgressForm.showmodal;
  ProgressForm.free;
  CheckAccessRights(4,9,false);
  exit;
 end;
end;

procedure TMainForm.CoverWeightsExecute(Sender: TObject);
begin
 if CheckAccessRights(4,6,true) then
 begin
  Weightdlg:=TWeightdlg.create(application);   {allocate dlg}
  Weightdlg.showmodal;
  Weightdlg.free;
  CheckAccessRights(4,6,false)
 end;
end;

procedure TMainForm.ChangeAddedStaffExecute(Sender: TObject);
begin
 addedstaffselwinSelect;
 if (usrPasslevel>0) then addedstaffselwin.Change2Click(self);
end;

procedure TMainForm.ShowAddedAvailExecute(Sender: TObject);
begin
 addedstaffselwinSelect;
end;

procedure TMainForm.ChangeNewClassExecute(Sender: TObject);
begin
 NewClassWinSelect;
 if (usrPasslevel>0) then NewClasseswin.Change2Click(self);
end;

procedure TMainForm.ShowNewClassesExecute(Sender: TObject);
begin
 NewClassWinSelect;
end;

procedure TMainForm.ShowMergeClassExecute(Sender: TObject);
begin
 MergedClassWinSelect;
end;

procedure TMainForm.ChangeUnavailRoomExecute(Sender: TObject);
begin
 UnavailableRoomsWinSelect;
 if (usrPasslevel>0) then unavailablerooms.Change2Click(self);
end;

procedure TMainForm.ShowUnavailRoomExecute(Sender: TObject);
begin
 UnavailableRoomsWinSelect;
end;

procedure TMainForm.ShowRoomSwapsExecute(Sender: TObject);
begin
 roomswapsWinSelect;
end;

procedure TMainForm.ShowCurrentExtrasExecute(Sender: TObject);
begin
 CurrentExtrasWinSelect;
end;

procedure TMainForm.ShowInfoWinExecute(Sender: TObject);
begin
 infoWinSelect;
end;

procedure TMainForm.ShowPastExtrasExecute(Sender: TObject);
begin
 PastExtrasWinSelect;
end;

procedure TMainForm.actTeacherTalliesExecute(Sender: TObject);
begin
 if CheckAccessRights(4,3,true) then
 begin
  TeWinSelect; {teacher win and then te times ed dlg}
  ExDataEntryDlg:=TExDataEntryDlg.create(self);  {allocate dlg}
  ExDataEntryDlg.showmodal;
  ExDataEntryDlg.free;   {release dlg}
  CheckAccessRights(4,3,false)
 end;
end;

procedure TMainForm.DoIncludeYearsExecute(Sender: TObject);
begin
 if CheckAccessRights(4,6,true) then
 begin
  CoverYearsDlg:=TCoverYearsDlg.create(application);   {allocate dlg}
  CoverYearsDlg.showmodal;
  CoverYearsDlg.free;
  CheckAccessRights(4,6,false)
 end;
end;

procedure TMainForm.ShowSubjectListExecute(Sender: TObject);
begin
  SubjectbySubjectListwinSelect;
end;

procedure TMainForm.ShowStudentTtExecute(Sender: TObject);
begin
 studentTtablewinSelect;
end;

procedure TMainForm.ShowTeacherTimetableExecute(Sender: TObject);
begin
 teachTtablewinSelect;
end;

procedure TMainForm.ShowRoomTimetableExecute(Sender: TObject);
begin
 roomTtablewinSelect;
end;

procedure TMainForm.ShowSubjectTimetableExecute(Sender: TObject);
begin
 subjectTtablewinSelect;
end;

procedure TMainForm.ChangeMergeClassExecute(Sender: TObject);
begin
 MergedClassWinSelect;
 if (usrPasslevel>0) then MergedClasseswin.Change2Click(self);
end;

procedure TMainForm.ChangeRoomSwapExecute(Sender: TObject);
begin
 roomswapsWinSelect;
 if (usrPasslevel>0) then roomswaps.Change2Click(self);
end;

procedure TMainForm.grp01Click(Sender: TObject);
var
  i: Integer;
begin
  cookCustomGroup(GOSmenu[(sender as TMenuItem).tag]);
  for i := 0 to (Sender as TMenuItem).Parent.Count - 1 do
    (Sender as TMenuItem).Parent.Items[i].Checked := False;
  (Sender as TMenuItem).Checked := True;
end;

procedure TMainForm.VisitAmigSystemsWebsite1Click(Sender: TObject);
begin
 ShellExecute(0, Nil, PChar('http://www.amig.com.au/'), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TMainForm.Info2Click(Sender: TObject);
begin
 showPassLevel;
end;

procedure TMainForm.Changepassword1Click(Sender: TObject);
begin
 if (usrPasslevel=0) then
 begin
  showRestrictedMsg;
  exit;
 end;

 edpassworddlg:=Tedpassworddlg.create(application);   {allocate dlg}
 edpassworddlg.showmodal;
 edpassworddlg.free;               {release dlg}
end;

procedure TMainForm.Adduser1Click(Sender: TObject);
var
  lDir: string;
begin
  if CheckAccessRights(6,7,true) then
  begin
    AddNewUserDlg:=TAddNewUserDlg.create(application);   {allocate dlg}
    try
      AddNewUserDlg.ShowModal;
    finally
      lDir := AddNewUserDlg.DirectoryListBox1.Directory;
      FreeAndNil(AddNewUserDlg);
      CheckAccessRights(6, 7, False);
      Application.ProcessMessages;
      if DirectoryExists(lDir) then
        if DirectoryExists(lDir) and IsDirEmpty(lDir) then
          RemoveDir(lDir);
    end;
  end;
end;

procedure TMainForm.ArchiveData(Sender: TObject);
// this is usful for emailing data
var
  AbZipper: TAbZipper;
  lFileList: TStringList;
  i: Integer;
  lFrmLoadProgress: TFrmLoadProgress;
  lProgress: Integer;
  lPrevProgress: Integer;
  lFileName: LPCTSTR;
begin
  lFileList := TStringList.Create;
  try
    FindFiles('*.*', faAnyFile, lFileList, True);
    AbZipper:= TAbZipper.Create(Self);
    lFrmLoadProgress := TFrmLoadProgress.Create(Application);
    lFrmLoadProgress.Title := AMG_ARCHIVING_DATA;
    try
      lFrmLoadProgress.Show;
      AbZipper.FileName := ProgDir + '\' + AMG_TCEDATA_ZIP_FILE;
      Application.ProcessMessages;
      lFileName := PChar(AbZipper.FileName);
      if FileExists(lFileName) then
      begin
        AbZipper.DeleteFiles('*.*');
        Application.ProcessMessages;
      end;

      lProgress := 0;
      lPrevProgress := 0;
      for i := 0 to lFileList.Count - 1 do
      begin
        AbZipper.AddFiles(lFileList.Strings[i], faAnyFile);
        if i > 0 then
          lProgress := Round(i * (100 / lFileList.Count));
        lFrmLoadProgress.UpdateProgress(lProgress - lPrevProgress, 'Adding ' + lFileList.Strings[i] + ' to the archive...', 10);
        lPrevProgress := lProgress;
      end;
      lFrmLoadProgress.UpdateProgress(lProgress - lPrevProgress, AMG_FILES_ARCHIVING_COMPLETE_MSG, 50);
      Application.ProcessMessages;
      if FileExists(AbZipper.FileName) then
        MessageDlg('Data has been archived in file ' + AMG_TCEDATA_ZIP_FILE + ' and stored in: ' + #10#13 + ProgDir, mtInformation, [mbOK], 0)
      else
        MessageDlg(AMG_DATA_FAILED_TO_ARCHIVE_MSG, mtInformation, [mbOK], 0);
    finally
      AbZipper.CloseArchive;
      AbZipper.Save;
      FreeAndNil(AbZipper);
    end;
  finally
    FreeAndNil(lFrmLoadProgress);
    FreeAndNil(lFileList);
  end;
end;

procedure TMainForm.Edituser1Click(Sender: TObject);
begin
 if CheckAccessRights(6,7,true) then
 begin
  EditUserDlg:=TEditUserDlg.create(application);   {allocate dlg}
  EditUserDlg.showmodal;
  EditUserDlg.free;               {release dlg}
  CheckAccessRights(6,7,false)
 end;
end;

procedure TMainForm.DeletePastExtras2Click(Sender: TObject);
begin
 if CheckAccessRights(4,9,true) then
 begin
  clearPastExtras;
  CheckAccessRights(4,9,false)
 end;
end;

procedure TMainForm.Deleteuser1Click(Sender: TObject);
begin
 if CheckAccessRights(6,7,true) then
 begin
  DeleteUserDlg:=TDeleteUserDlg.create(application);   {allocate dlg}
  DeleteUserDlg.showmodal;
  DeleteUserDlg.free;               {release dlg}
  CheckAccessRights(6,7,false)
 end;
end;

procedure TMainForm.Showusers1Click(Sender: TObject);
begin
 if usrPasslevel=6 then ShowUsersWinSelect; {only restore for Super}
end;

procedure TMainForm.Autoloadtime1Click(Sender: TObject);
begin
 if CheckAccessRights(6,7,true) then
 begin
  autoloaddlg:=Tautoloaddlg.create(application);   {allocate dlg}
  autoloaddlg.showmodal;
  autoloaddlg.free;               {release dlg}
  CheckAccessRights(6,7,false)
 end;
end;

procedure TMainForm.Checkforupdates1Click(Sender: TObject);
begin
//add link to webpage with link to downloadable zip update of exe
//- which should also contain install instructions on webpage!!!

//  ShellExecute(0, Nil, PChar('http://www.amig.com.au/updates.html'), Nil, Nil, SW_SHOWNORMAL);   //old  http://www.amig.com.au/time1.htm#Update
end;

procedure TMainForm.Logonasdifferentuser1Click(Sender: TObject);
var
 i:       integer;
 tmpstr:   string;
 oldUserPassID: string;
 oldusrPasslevel: smallint;
 usrOLDuser: smallint;
begin
 oldUserPassID:=usrPassID;  OldusrPasslevel:=usrPasslevel;
 if usrpasslevel>0 then usrOLDuser:=usrPassrecord
  else usrOLDuser:=-1;
 checkpassword;
 mniUserClearUserAccessLocks.Visible := usrPassLevel = 6;

 if ((usrPasslevel=0) and (usrOLDuser=-1)) then exit; {no need to reload, general to general}
 if (usrOLDuser<>usrPassrecord) then
 begin
  try
   tmpStr:=usrPassID;  usrPassID:=OldUserPassID;
   i:=usrPasslevel;   usrPasslevel:=OldusrPasslevel;
   removeDormantLocks;
   usrPassID:=tmpStr;   usrPasslevel:=i;
   CheckAccessFile;
   screen.cursor:=crHourglass;
   textdir:=datadir;
   timedir:=datadir;

   chdir(datadir); {ensure default name is used for new dirs if cur name not there}
   if ((not(fileexists(ttfile+'.TTW'))) and (not(fileexists(ttfile+'.TT')))) then
    ttfile:='TTABLE';

  About.FirstLoad;
  UpdateAllWins;
  finally
   screen.cursor:=crDefault;
  end; {try}
 end;

end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
 if not(loadFinished) then exit; //NOT during load
 if HaveDataLock then exit;
 inc(MouldAge);
 if MouldAge>=MouldyDataCheckTime then
 begin
  CheckForMouldyData;
  MouldAge:=0;
 end;
end;

procedure TMainForm.SaveDefaultDisplaySettings(Sender: TObject);
var
 i,j: integer;
begin
 if usrPasslevel<>6 then exit;
 j:=mainform.mdichildCount;
 if j>0 then
  for i:=1 to j do
   saveWinpos(mainform.mdichildren[i-1]);
 try
  getDEFDatadir;
  chdir(defDataDir);
  saveWinDisplayDo;
  chdir(DataDir);
 except
 end;
end;

procedure TMainForm.SetCurrentDataDirectoryAsDefault(
  Sender: TObject);
var
 F:       textfile;
begin
 if usrPasslevel<>6 then exit;
 try
  try
   chdir(progdir);
   doAssignFile(F,'DIR.SYS');
   filemode:=fmOpenReadWrite+fmShareDenyWrite;
   rewrite(F);
   Writeln(F,progdir);
   Writeln(F,datadir);
   Writeln(F,DOSscreenmem);
  finally
   closefile(F);
  end;
 except
 end;
end;

procedure TMainForm.User1Click(Sender: TObject);
begin
 if (usrPasslevel=6) then {supervisor only}
 begin
  n15.visible:=true; n16.visible:=true; n12.visible:=true;
  adduser1.visible:=true; edituser1.visible:=true;
  deleteuser1.visible:=true; showusers1.visible:=true;
  autoloadtime1.visible:=true;
  Savedefaultdisplaysettings1.visible:=true;
  Setcurrentdatadirectoryasdefault1.visible:=true;
  N19.visible:=true; N20.visible:=true; N21.visible:=true;
 end
 else
  begin
   n15.visible:=false; n16.visible:=false; n12.visible:=false;
   adduser1.visible:=false; edituser1.visible:=false;
   deleteuser1.visible:=false; showusers1.visible:=false;
   autoloadtime1.visible:=false;
   Savedefaultdisplaysettings1.visible:=false;
   Setcurrentdatadirectoryasdefault1.visible:=false;
   N19.visible:=false; N20.visible:=false; N21.visible:=false;
  end;
 {general cannot change password but can log on again as diff user}
 Changepassword1.visible:=(usrPassLevel>0);
end;

initialization
 PrinterOn:=false; PreviewOn:=false; TextFileOut:=false; CopyOut:=false;
 GenericTtableFlag:=false;  GlobalHints:=True;

 for ib:=1 to nmbrWindows do
  begin
   winView[ib]:=0;  winViewMax[ib]:=0;
   wnFlag[ib]:=false;
   winPos[ib].height:=0;
  end;
 winViewMax[wnTecode]:=3;
 winViewMax[wnAddedStaff]:=2;
 winViewMax[wnAbsentTe]:=2;
 winViewMax[wnLostClass]:=2;
 winViewMax[wnAddedSel]:=2;
 winViewMax[wnRoomSwap]:=2;
 winViewMax[wnUnavailRooms]:=2;
 winViewMAx[wnCurrentExtras]:=6;
 winViewMAx[wnPastExtras]:=6; // previously 5
 winViewMAx[wnShowUsers]:=1;
 winViewMax[wnTeacherTt]:=1;
 winViewMax[wnRoomTt]:=1;
 winViewMax[wnStudentTt]:=1;
 winViewMax[wnTeFree]:=2;
end.

