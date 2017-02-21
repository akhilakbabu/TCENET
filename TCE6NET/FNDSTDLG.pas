unit Fndstdlg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, GlobalToTcAndTcextra;

type
  Tfindstudentdlg = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    lblStudentName: TLabel;
    Edit1: TEdit;
    Nextbutton: TBitBtn;
    Cancelbutton: TBitBtn;
    Helpbutton: TBitBtn;
    cboYear: TComboBox;
    Label3: TLabel;
    Okbutton: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    previousButton: TBitBtn;
    lblYearName: TLabel;
    lblHomeRoomCaption: TLabel;
    lblHomeRoom: TLabel;
    lblTutorCaption: TLabel;
    lblTutor: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RefreshStudentDetails(Sender: TObject);
    procedure OKbuttonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cboYearChange(Sender: TObject);
    procedure NextbuttonClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure previousButtonClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  end;

var
  findstudentdlg: Tfindstudentdlg;

implementation

uses
  tcommon,findstud,tcommon2;

{$R *.DFM}

var
 SFpos, SFpoint, SFyear,SFmax:  integer;
 SFfound:       boolean;
 MyStPointer: array of integer;

procedure MakeStArray;
var
 i,j: integer;
begin
 SFmax:=0;
 if UseGroupFindStud then
  begin
   for i:=1 to groupnum do
    begin
     j:=StGroup[i];
     if (Stud[j].tcyear=SFyear) or (SFyear=-1)
       then begin inc(SFmax); MyStPointer[SFmax]:=j; end;
    end;
  end
 else
  begin
   for i:=1 to numstud do
    begin
     if (Stud[i].tcyear=SFyear) or (SFyear=-1)
       then begin inc(SFmax); MyStPointer[SFmax]:=i; end;
    end;
  end;
 SFpoint:=0;
 if SFpos>0 then
  for i:=1 to SFmax do
   if MyStPointer[i]=SFpos then begin SFpoint:=i; break end;
end;

procedure SFbuttonSet;
begin
 with findstudentdlg do
  begin
   previousbutton.enabled:=(SFpoint>1);
   nextbutton.enabled:=(SFpoint<SFmax);
   OKbutton.enabled:=SFfound;
  end;
end;

procedure Tfindstudentdlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure Tfindstudentdlg.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  edit1.text:='';
  setLength(MyStPointer,numstud+1);
  label3.caption:='&'+Yeartitle;
  SFpos:=0; SFyear:=-1; SFpoint:=0;SFfound:=false;
  checkbox1.checked:=MatchAllYears;
  checkbox2.checked:=UseGroupFindStud;
  cboYear.MaxLength := szYearname;
  cboYear.Clear;
  cboYear.DropDownCount := nmbrYears;
  cboYear.Items.Add('All years');
  for i:=0 to years_minus_1 do
    cboYear.Items.Add(yearname[i]);
  cboYear.ItemIndex := 0; {default to all}
  MakeStArray;
end;

procedure Tfindstudentdlg.RefreshStudentDetails(Sender: TObject);
var
  astr,s: string;
  i,j,len: integer;
begin
  SFfound:=false; SFpoint:=0; SFpos:=0;
  s:=trim(edit1.text); len:=Length(s);
  s:=uppercase(s);
  if s>'' then
  for j:=1 to SFmax do
  begin
    i:=MyStPointer[j];
    astr:=uppercase(Stud[i].stname+' '+Stud[i].first);
    astr:=copy(astr,1,len);
    if s=astr then begin SFfound:=true; SFpoint:=j; SFpos:=i; break; end;
  end;
  if SFfound then
  begin
    lblStudentName.Caption := Stud[SFpos].stname+' '+Stud[SFpos].first;
    lblHomeRoom.Caption := GetStudentHomeRoom(SFpos);
    lblTutor.Caption := TeName[Stud[SFpos].Tutor, 0];
    lblYearName.Caption := Yeartitle + ' ' + yearname[Stud[SFpos].TcYear];
  end
  else lblStudentName.Caption := 'Enter Student Name';
  SFbuttonSet;
end;

procedure Tfindstudentdlg.OKbuttonClick(Sender: TObject);
var
 msg: string;
begin
 if SFfound then
 begin
  studfindnum:=SFpos;
  findstudentwinselect;
  UpdateWindow(wnFindStud);
  close;
  findstudent.setfocus;
 end
 else
  begin  {none selected}
   msg:='No Student selected';
   messagedlg(msg,mtError,[mbOK],0);
  end;
end;

procedure Tfindstudentdlg.FormActivate(Sender: TObject);
begin
  cboYear.Hint := 'Select '+Yeartitle+' to search';
  lblYearName.Caption := '';
  lblHomeRoom.Caption := '';
  lbltutor.Caption := '';
  lblStudentName.Caption := 'Enter Student Name';
  SFbuttonSet;
end;

procedure Tfindstudentdlg.cboYearChange(Sender: TObject);
var
  oldyear: Integer;
  astr: string;
begin
  oldyear := SFyear;
  astr := cboYear.Text;
  SFyear:=findyear(astr);
  if SFyear<>oldyear then
  begin
    MakeStArray;
    SFbuttonSet;
  end;
end;

procedure Tfindstudentdlg.NextbuttonClick(Sender: TObject);
begin
  if SFpoint<SFmax then
  begin
    inc(SFpoint); SFfound:=true;
    SFpos:=MyStPointer[SFpoint];
    lblStudentName.Caption := Stud[SFpos].stname+' '+Stud[SFpos].first;
    lblHomeRoom.Caption := GetStudentHomeRoom(SFpos);
    lblTutor.Caption := TeName[Stud[SFpos].Tutor, 0];
    lblYearName.Caption := Yeartitle + ' ' + yearname[Stud[SFpos].TcYear];
    SFbuttonSet;
  end;
end;

procedure Tfindstudentdlg.CheckBox2Click(Sender: TObject);
begin
 UseGroupFindStud:=checkbox2.checked;
 MakeStArray;
end;

procedure Tfindstudentdlg.previousButtonClick(Sender: TObject);
begin
  if SFpoint>1 then
  begin
    dec(SFpoint); SFfound:=true;
    SFpos:=MyStPointer[SFpoint];
    lblStudentName.Caption :=Stud[SFpos].stname+' '+Stud[SFpos].first;
    lblHomeRoom.Caption := GetStudentHomeRoom(SFpos);
    lblTutor.Caption := TeName[Stud[SFpos].Tutor, 0];
    lblYearName.Caption := Yeartitle + ' ' + yearname[Stud[SFpos].TcYear];
    SFbuttonSet;
  end;
end;

procedure Tfindstudentdlg.CheckBox1Click(Sender: TObject);
begin
 MatchAllYears:=checkbox1.checked;
end;

end.
