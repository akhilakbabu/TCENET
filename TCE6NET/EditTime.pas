unit EditTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, Grids,TCEglobals, XML.UTILS, GlobalToTcAndTcextra;

type
  TNewAllotDlg = class(TForm)
    PageControl1: TPageControl;
    tabMain: TTabSheet;
    tabYearGroup: TTabSheet;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    UpDown1: TUpDown;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    tabDayGroup: TTabSheet;
    Label1: TLabel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    UpDown2: TUpDown;
    Edit2: TEdit;
    BitBtn6: TBitBtn;
    Label6: TLabel;
    StringGrid1: TStringGrid;
    Label44: TLabel;
    ComboBox1: TComboBox;
    Label46: TLabel;
    Memo1: TMemo;
    Label45: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    finish: TBitBtn;
    update: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    procedure BitBtn2Clic(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure myYearColourPress(Sender: TObject);
    procedure myYearColour2Press(Sender: TObject);
    procedure myDayColour2Press(Sender: TObject);
    procedure myDayColourPress(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tabYearGroupExit(Sender: TObject);
    procedure tabDayGroupExit(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure updateClick(Sender: TObject);
  private
    procedure FillGrid;
    procedure ConfigGrid;

  end;

 procedure GroupArrayCalc;

var
  NewAllotDlg: TNewAllotDlg;

implementation

uses tcommon,TimesWnd,tcommon5;
{$R *.dfm}

var
 inLoad,timechange: boolean;
 GroupDayNum,Ygroup,Dgroup:   smallint;
 yearcol1,YearCol2:     array[1..nmbrYears] of Tlabel;
 YearCheck:             array[1..nmbrYears] of Tcheckbox;
 DayCheck:              array[1..nmbrDays] of Tcheckbox;
 DayCol1,DayCol2:       array[1..nmbrDays] of Tlabel;
 usingResources:        boolean;
 saveTimesFlag:         boolean;
 dayuse:    smallint;


function showGroupColour(i: integer): Tcolor;
begin
 result:=clBtnFace;
 case i of
  1: result:=$00DDFFFF;
  2: result:=$00C6C6FF;
  3: result:=$00DDFFDD;
  4: result:=$00B0D8FF;
  5: result:=$00FFFFDF;
  6: result:=$00FFC1FF;
  7: result:=$009FFF9F;
  8: result:=$0062B0FF;
  9: result:=$00FFFFAC;
  10: result:=$008C8CFF;
  11: result:=$0013FFFF;
  12: result:=$00E4AD76;
  13: result:=$004575F1;
  14: result:=$0015FF15;
  15: result:=$00FF0FFF;
 end;
end;


procedure updateTimes;
var
 s:         string;
 fname,tname: string;
 tmp:       smallint;
 i,j,k:     integer;
begin
 chdir(Directories.datadir);
 try
  try
   fname:='EXALLOT.DAT';
   tname:='EXALLOT.TMP';
   ourSafetyMemStreamStr:='';
   ourSafetyMemStream:=TStringStream.Create(ourSafetyMemStreamStr);
   with ourSafetyMemStream do
    begin
     s:='TCE5';     Write(Pchar(@s[1])^,4);
     tmp:=years-1;  Write(tmp,2);
     tmp:=days-1;   Write(tmp,2);
     tmp:=periods;  Write(tmp,2);
     for i:=0 to days-1 do Write(DayGroup[i],2);
     for i:=0 to years-1 do Write(YearGroup[i],2);
     for j:=0 to days-1 do
       for k:=1 to periods do
         begin
           Write(torder[k,j],2);
           Write(tslotcode[k,j][1],1);
         end;
      for i:=0 to years-1 do
        for j:=0 to days-1 do
         for k:=1 to periods do
          Write(Eallot[i,j,k],8);
    end;
   SafelyStreamToFile(tname,fname);
  finally
   ourSafetyMemStream.Free;
   NEW_DateChecks[5]:=FileDateToDateTime(fileage(fname));
  end;
 except
 end;
end;



procedure yeargroupCount;
var
 gs: array[0..nmbryears] of smallint;
 i:     smallint;
begin
 numYearGroups:=0;
 for i:=1 to years do gs[i]:=0;
 for i:=1 to years do inc(gs[YearGroup[i-1]]);
 for i:=1 to years do if gs[i]>0 then inc(numYearGroups);
end;

procedure daygroupCount;
var
 gs: array[0..nmbrdays] of smallint;
 i:     smallint;
begin
 numDayGroups:=0;
 for i:=1 to days do gs[i]:=0;
 for i:=1 to days do inc(gs[DayGroup[i-1]]);
 for i:=1 to days do if gs[i]>0 then inc(numDayGroups);
end;


procedure TNewAllotDlg.FillGrid;
var
 i,j:  integer;
 astr:  string;
begin
 dayuse:=dg[GroupDayNum,1];
 for i:=1 to periods do  {fill grid}
  begin
   stringgrid1.cells[0,i]:=TimeSlotName[dayuse,i-1];
   stringgrid1.cells[1,i]:=Tslotcode[i,dayuse];
   stringgrid1.cells[2,i]:=inttostr(Torder[i,dayuse]);
   for j:=1 to numYearGroups do
    begin
     str(Eallot[yg[j,1],dayuse,i]:5:2,astr);
     stringgrid1.cells[2+j,i]:=trim(astr);
    end;
  end;
end;


procedure YearGroupCalc;
var
 i,j,k: integer;
begin
 yeargroupcount;
//yg[a,0] holds count of years in group a
//yg[a,1] first year in group a

 for i:=0 to years do
   for j:=0 to years do yg[i,j]:=0;

 for i:=1 to years do
  begin
   j:=YearGroup[i-1];
   inc(yg[j,0]);
   yg[j,yg[j,0]]:=i-1;
  end;

 k:=0; {pack array into lower numYearGroups groups}
 for i:=1 to years do
  if yg[i,0]>0 then
   begin
    inc(k);
    for j:=0 to years do yg[k,j]:=yg[i,j];
   end;
end;


procedure DayGroupCalc;
var
 i,j,k: integer;
begin
 daygroupcount;
// Calculate array
  //dg[a,0] holds count of days in group a
//dg[a,1] first day in group a
 for i:=0 to nmbrdays do
  for j:=0 to nmbrdays do dg[i,j]:=0;

 for i:=1 to days do
  begin
   j:=DayGroup[i-1];
   inc(dg[j,0]);
   dg[j,dg[j,0]]:=i-1;
  end;

 k:=0; {pack array into lower part of dg array}
 for i:=1 to days do
  if dg[i,0]>0 then
   begin
    inc(k);
    for j:=0 to days do dg[k,j]:=dg[i,j];
   end;

end;



procedure GroupArrayCalc;
begin
 DayGroupCalc;
 if GroupDayNum>numDayGroups then GroupDayNum:=numDayGroups;
 YearGroupCalc;
 dayuse:=dg[GroupDayNum,1];
end;

procedure TNewAllotDlg.ConfigGrid;
var
 i,k,m: integer;
begin
 GroupArrayCalc;
 label61.caption:=inttostr(numYearGroups);
 label59.caption:=inttostr(numDayGroups);
 stringgrid1.rowcount:=periods+1;
 stringgrid1.colcount:=numYearGroups+3;

 stringgrid1.cells[0,0]:='Time Slot';
 m:=canvas.textwidth(' Time Slot ');
 if fwPeriodName>m then m:=fwPeriodName;
 stringgrid1.ColWidths[0]:=m;
 stringgrid1.cells[1,0]:='Code';
 m:=canvas.textwidth(' Code ');
 stringgrid1.ColWidths[1]:=m;
 stringgrid1.cells[2,0]:='Order';
 m:=canvas.textwidth(' Order ');
 stringgrid1.ColWidths[2]:=m;
 fillgrid;

 if (numYearGroups>1) and (numYearGroups<years) then
   for i:=1 to numYearGroups do
       stringgrid1.cells[2+i,0]:=yearShort+' Group '+inttostr(i);
 if(numYearGroups=years) then
   for i:=1 to years do
       stringgrid1.cells[2+i,0]:=yearShort+' '+yearname[i-1];
 if numYearGroups=1 then
  begin
   label45.visible:=true;
   label45.caption:='All '+yeartitle+'s';
   stringgrid1.cells[2+numYearGroups,0]:='All '+yeartitle+'s';
  end;

 Memo1.clear; {deal with memo}
 if (numYearGroups>1) and (numYearGroups<years) then //fill memo with years legend
   for i:=1 to numYearGroups do
    begin
      Memo1.lines.append(yearShort+' Group '+inttostr(i)+':');
      for k:=1 to yg[i,0] do
         Memo1.lines.append('     '+yearname[yg[i,k]]);
      Memo1.lines.append('______________________');
    end;
 if (numDayGroups>1) and (numDayGroups<days) then //fill memo with days legend
   for i:=1 to numDayGroups do
    begin
      Memo1.lines.append('Day Group '+inttostr(i)+':');
      for k:=1 to dg[i,0] do
         Memo1.lines.append('     '+dayname[dg[i,k]]);
      Memo1.lines.append('______________________');
    end;

 if ((numYearGroups>1) and (numYearGroups<years))or ((numDayGroups>1) and (numDayGroups<days)) then
   memo1.visible:=true else memo1.visible:=false;
 if (numYearGroups>1) then label45.visible:=false else label45.visible:=true;

 combobox1.clear;
 if (numDayGroups>1) and (numDayGroups<days) then
  for i:=1 to numDayGroups do combobox1.Items.add('Day Group '+inttostr(i));
 if (numDayGroups=days) then
  for i:=1 to numDayGroups do combobox1.Items.add(dayname[i-1]);

  combobox1.itemindex:=GroupDayNum-1;

 if numDayGroups>1 then
  begin combobox1.visible:=true; label44.visible:=true; label57.visible:=false; end
 else begin combobox1.visible:=false; label44.visible:=false; label57.visible:=true; end;
end;


Procedure DoTimeUpdate;
begin
 UpdateAllWins;
 saveTimesFlag:=true;
 TimesWindow.Tabsdo:=true;
 TimesWindow.Repaint;
 timechange:=false;
end;


procedure colourResults2;
var
 i: integer;
begin
 for i:=1 to days do
  begin
   DayCol2[i].caption:=inttostr(DayGroup[i-1]);
   DayCol2[i].color:=showGroupColour(DayGroup[i-1]);
   DayCheck[i].checked:=false;
   DayCheck[i].color:=showGroupColour(DayGroup[i-1]);
  end;
 if timechange then DoTimeUpdate;
 NewAllotDlg.label59.caption:=inttostr(numDayGroups);
end;


procedure colourResults;
var
 i: integer;
begin
 for i:=1 to years do
  begin
   YearCol2[i].caption:=inttostr(YearGroup[i-1]);
   YearCol2[i].color:=showGroupColour(YearGroup[i-1]);
   YearCheck[i].checked:=false;
   YearCheck[i].color:=showGroupColour(YearGroup[i-1]);
  end;
 if timechange then DoTimeUpdate;
 NewAllotDlg.label61.caption:=inttostr(numYearGroups);
end;


procedure ChangeYearGroup(myYear,newYearGroup: integer);
var
 d,p,oldYearGroup,oldNumYearGroups,year1:     integer;
begin
 oldNumYearGroups:=NumYearGroups;
 oldYearGroup:=YearGroup[myYear];
 YearGroup[myYear]:=newYearGroup;
 if (oldYearGroup<>newYearGroup) and (yg[newYearGroup,0]>0) then {joining an existing group}
  begin
   year1:=yg[newYearGroup,1];
   for d:=0 to days-1 do
    for p:=1 to periods do
     Eallot[myYear,d,p]:=Eallot[year1,d,p];
   timechange:=true;
  end;
 YearGroupCalc;
 if oldNumYearGroups<>NumYearGroups then timechange:=true;
end;







procedure updateALLUpDowns;
var
 i: integer;
begin
 for i:=1 to years do
   if YearCheck[i].checked then ChangeYearGroup(i-1,Ygroup);
 colourResults;
end;

procedure ChangeDayGroup(myday,newDayGroup: integer);
var
 p,j,k,oldDayGroup,oldNumDayGroups,day1:     integer;
begin
 oldNumDayGroups:=NumDayGroups;
 oldDayGroup:=DayGroup[myday];
 DayGroup[myday]:=newDayGroup;
 if (oldDayGroup<>newDayGroup) and (dg[newDayGroup,0]>0) then {joining an existing group}
  begin
   day1:=dg[newDayGroup,1];
   for p:=1 to periods do
    begin
     Tslotcode[p,myday]:=Tslotcode[p,day1];
     Torder[p,myday]:=Torder[p,day1];
     for j:=1 to numYearGroups do
      for k:=1 to yg[j,0] do Eallot[yg[j,k],myday,p]:=Eallot[yg[j,k],day1,p];
    end;  {for p}
   timechange:=true;
  end;
 DayGroupCalc;
 if oldNumDayGroups<>NumDayGroups then timechange:=true;
end;


procedure updateALLUpDowns2;
var
 i:     integer;
begin
 for i:=1 to days do
   if DayCheck[i].checked then ChangeDayGroup(i-1,Dgroup);
 colourResults2;
end;


procedure TNewAllotDlg.BitBtn2Clic(Sender: TObject);
var
 i:  integer;
begin
 for i:=1 to years do ChangeYearGroup(i-1,i);
 colourResults;
end;


procedure TNewAllotDlg.myYearColourPress(Sender: TObject);
begin
 if sender is Tlabel then
  begin
   Ygroup:=Tlabel(Sender).tag;
   edit1.text:=inttostr(Ygroup); UpDown1.Position:=Ygroup;
   updateALLUpDowns;
  end;
end;

procedure TNewAllotDlg.myYearColour2Press(Sender: TObject);
var
 getnum:        integer;
begin
 if sender is Tlabel then
  begin
   getnum:=Tlabel(Sender).tag;
   Yearcheck[getnum].checked:=not(YearCheck[getnum].checked);
  end;
end;

procedure TNewAllotDlg.myDayColour2Press(Sender: TObject);
var
 getnum:        integer;
begin
 if sender is Tlabel then
  begin
   getnum:=Tlabel(Sender).tag;
   Daycheck[getnum].checked:=not(DayCheck[getnum].checked);
  end;
end;



procedure TNewAllotDlg.myDayColourPress(Sender: TObject);
var
 getnum:        integer;
begin
 if sender is Tlabel then
  begin
   getnum:=Tlabel(Sender).tag;
   edit2.text:=inttostr(getnum); UpDown2.Position:=getnum;
   updateALLUpDowns2;
  end;
end;


procedure TNewAllotDlg.FormCreate(Sender: TObject);
var
 i: integer;
begin
 for i:=1 to years do
  begin
   YearCol1[i]:=tlabel.create(application);
   YearCol1[i].alignment:=taCenter;
   YearCol1[i].caption:=inttostr(i);
   YearCol1[i].hint:='Assign selected years to group '+inttostr(i);
   YearCol1[i].tag:=i; YearCol1[i].color:=showGroupColour(i);
   YearCol1[i].parent := tabYearGroup;
   YearCol1[i].width:=20;  YearCol1[i].height:=20;
   YearCol1[i].top:=177;  YearCol1[i].left:=21*i-7;
   YearCol1[i].onClick:=myYearColourPress;

   YearCol2[i]:=tlabel.create(application);
   YearCol2[i].Font.Name:='ms san serif';  YearCol2[i].Font.Style:=[];
   YearCol2[i].caption:=inttostr(YearGroup[i-1]);
   YearCol2[i].hint:='Select years to assign to a group';
   YearCol2[i].color:=showGroupColour(YearGroup[i-1]);
   YearCol2[i].tag:=i; YearCol2[i].AutoSize:=false;
   YearCol2[i].parent := tabYearGroup;
   YearCol2[i].width:=20;  YearCol2[i].height:=13;
   YearCol2[i].top:=27+21*((i-1) mod 5);  YearCol2[i].left:=11+135*((i-1)div 5);
   YearCol2[i].onClick:=myYearColour2Press;

   YearCheck[i]:=tcheckbox.create(application);
   YearCheck[i].caption:=Yearname[i-1];
   YearCheck[i].hint:='Select years to assign to a group';
   YearCheck[i].color:=showGroupColour(YearGroup[i-1]);
   YearCheck[i].tag:=i;
   YearCheck[i].parent := tabYearGroup;
   YearCheck[i].width:=100;  YearCheck[i].height:=13;
   YearCheck[i].top:=27+21*((i-1) mod 5);  YearCheck[i].left:=31+135*((i-1)div 5);
  end;
 for i:=1 to days do
  begin
   DayCol1[i]:=tlabel.create(application);
   DayCol1[i].alignment:=taCenter;
   DayCol1[i].caption:=inttostr(i);
   DayCol1[i].hint:='Assign selected days to group '+inttostr(i);
   DayCol1[i].tag:=i; DayCol1[i].color:=showGroupColour(i);
   DayCol1[i].parent := tabDayGroup;
   DayCol1[i].width:=20;  DayCol1[i].height:=20;
   DayCol1[i].top:=177;  DayCol1[i].left:=21*i-7;
   DayCol1[i].onClick:=myDayColourPress;

   DayCol2[i]:=tlabel.create(application);
   DayCol2[i].Font.Name:='ms san serif';  DayCol2[i].Font.Style:=[];
   DayCol2[i].caption:=inttostr(DayGroup[i-1]);
   DayCol2[i].hint:='Select days to assign to a group';
   DayCol2[i].color:=showGroupColour(DayGroup[i-1]);
   DayCol2[i].tag:=i; DayCol2[i].AutoSize:=false;
   DayCol2[i].parent := tabDayGroup;
   DayCol2[i].width:=20;  DayCol2[i].height:=13;
   DayCol2[i].top:=27+21*((i-1) mod 5);  DayCol2[i].left:=11+135*((i-1)div 5);
   DayCol2[i].onClick:=myDayColour2Press;

   DayCheck[i]:=tcheckbox.create(application);
   DayCheck[i].caption:=Dayname[i-1];
   DayCheck[i].hint:='Select days to assign to a group';
   DayCheck[i].color:=showGroupColour(DayGroup[i-1]);
   DayCheck[i].tag:=i;
   DayCheck[i].parent := tabDayGroup;
   DayCheck[i].width:=100;  DayCheck[i].height:=13;
   DayCheck[i].top:=27+21*((i-1) mod 5);  DayCheck[i].left:=31+135*((i-1)div 5);
  end;
 edit1.Text:='1';Ygroup:=1;
 edit2.Text:='1';Dgroup:=1;
 usingResources:=true;
 inLoad:=true;
 GroupDayNum:=1;
 stringgrid1.DefaultColWidth:=90;
 Pagecontrol1.activepage := tabMain;
 updown1.max:=years; updown2.max:=days;
 tabYearGroup.Caption:='Group &'+YearTitle+'s';
 inLoad := false;  timechange:=false;
 saveTimesFlag:=false;
end;

procedure TNewAllotDlg.BitBtn1Click(Sender: TObject);
var
 i:  integer;
begin
 for i:=1 to years do ChangeYearGroup(i-1,1);
 colourResults;
end;

procedure TNewAllotDlg.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
 edit1.text:=inttostr(UpDown1.Position);
end;

procedure TNewAllotDlg.BitBtn3Click(Sender: TObject);
begin
 updateALLUpDowns;
end;

procedure TNewAllotDlg.BitBtn4Click(Sender: TObject);
var
 i:  integer;
begin
 for i:=1 to days do ChangeDayGroup(i-1,1);
 colourResults2;
end;

procedure TNewAllotDlg.BitBtn5Click(Sender: TObject);
var
 i:  integer;
begin
 for i:=1 to days do ChangeDayGroup(i-1,i);
 colourResults2;
end;

procedure TNewAllotDlg.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
 edit2.text:=inttostr(UpDown2.Position);
end;

procedure TNewAllotDlg.BitBtn6Click(Sender: TObject);
begin
 updateALLUpDowns2;
end;

procedure TNewAllotDlg.FormActivate(Sender: TObject);
begin
 configGrid;
end;

procedure TNewAllotDlg.Edit1Change(Sender: TObject);
begin
 Ygroup:=strtointdef(edit1.text,0);
 if (Ygroup>0) and (Ygroup<=Years) then
  begin
   updown1.Position:=Ygroup;
   BitBtn3.Enabled:=true;
  end
 else BitBtn3.Enabled:=false;
end;

procedure TNewAllotDlg.Edit2Change(Sender: TObject);
begin
 Dgroup:=strtointdef(edit2.text,0);
 if (Dgroup>0) and (Dgroup<=Days) then
  begin
   updown2.Position:=Dgroup;
   BitBtn6.Enabled:=true;
  end
 else BitBtn6.Enabled:=false;
end;

procedure TNewAllotDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
 i:     integer;
begin
 if saveTimesFlag then updatetimes;
 if usingResources then   {can call close even after closed it seems}
   begin
    usingResources:=false;
    NewAllotDlg.hide; {prevent seeing controls beeing removed -slows things down a lot}
    for i:=1 to years do YearCol1[i].free;
    for i:=1 to days do DayCol1[i].free;
   end;
end;

procedure TNewAllotDlg.tabYearGroupExit(Sender: TObject);
begin
 configGrid;
end;

procedure TNewAllotDlg.tabDayGroupExit(Sender: TObject);
begin
 configGrid;
end;

procedure TNewAllotDlg.ComboBox1Change(Sender: TObject);
var
 getindex: integer;
begin
 getindex:=1+ComboBox1.ItemIndex;
 if (getindex>0) and (getindex<>GroupDayNum) then
  begin
   GroupDayNum:=getindex;
   fillGrid;
  end;
end;

procedure TNewAllotDlg.updateClick(Sender: TObject);
var
 i,j,k,d,p,y: smallint;
 sss,msg:     string;
 dd:      double;
 SRect: TGridRect;
 erCode:   integer;
 highest,lowest,found,missing,AA,duplicate,nm:  smallint;
 checktorder,myorder:      array[0..nmbrperiods] of smallint;
begin
 nm:=0;
 {validate allotments}
 for i:=1 to numYearGroups do
  for p:=1 to periods do
   begin
    sss:=stringgrid1.cells[2+i,p];
    val(sss,dd,erCode);
    if ((dd<0) or (dd>5000)) then
     begin
      msg:='Enter allotment from 0 to 5000!';
      messagedlg(msg,mtError,[mbOK],0);
      SRect.Top := p; SRect.Left := 2+i;
      SRect.Bottom := p; SRect.Right := 2+i;
      StringGrid1.Selection := SRect;
      exit;
     end;
   end;

 for p:=1 to periods do   {validate time slot codes}
  begin
   sss:=trim(stringgrid1.cells[1,p]);
   if (length(sss)<>1) then
    begin
     msg:='Enter single character code';
     messagedlg(msg,mtError,[mbOK],0);
     SRect.Top := p; SRect.Left := 1;
     SRect.Bottom := p; SRect.Right := 1;
     StringGrid1.Selection := SRect;
     exit;
    end;
  end;

 for p:=1 to periods do  {validate order numbers}
  begin
   sss:=stringgrid1.cells[2,p];
   val(sss,myorder[p],erCode);
   if ((myorder[p]<0) or (myorder[p]>periods)) then
    begin
     msg:='Enter order number in the range 0 to '+inttostr(periods);
     messagedlg(msg,mtError,[mbOK],0);
     SRect.Top := p; SRect.Left := 2;
     SRect.Bottom := p; SRect.Right := 2;
     StringGrid1.Selection := SRect;
     exit;
    end;
  end;

 {check range of order numbers is complete}
 for i:=1 to periods do checktorder[i]:=0;
 highest:=0; lowest:=periods;
 for i:=1 to periods do
  begin
   aa:=myorder[i];
   checktorder[i]:=aa;
   if aa> highest then highest:=aa;
   if aa<lowest then lowest:=aa;
  end;
 if highest>lowest then
  begin
   missing:=0;
   for i:=1 to highest do
    begin
     found:=0;
     for j:=1 to periods do
      if checktorder[j]=i then found:=-1;
     if not(bool(found)) then begin missing:=i; break; end;
    end; {for i}
   if bool(missing) then
    begin
     msg:='Order number '+inttostr(missing)+' is missing';
     messagedlg(msg,mtError,[mbOK],0);
     exit;
    end;
   duplicate:=0;
   for i:=1 to periods-1 do
    for j:=i+1 to  periods do
     begin
      aa:=checktorder[i];
      if ((aa>0) and (checktorder[j]=aa)) then begin duplicate:=aa; nm:=j; end;
     end;
   if bool(duplicate) then
    begin
     msg:='Order number '+inttostr(duplicate)+' is duplicated';
     messagedlg(msg,mtError,[mbOK],0);
     SRect.Top := nm; SRect.Left := 2;
     SRect.Bottom := nm; SRect.Right := 2;
     StringGrid1.Selection := SRect;
     exit;
    end;
  end;
 if highest=0 then
  begin
   msg:='No order numbers set';
   messagedlg(msg,mtError,[mbOK],0);
   exit;
  end;

 for i:=1 to dg[GroupDayNum,0] do
  begin
   d:=dg[GroupDayNum,i];
   for p:=1 to periods do  {get values}
    begin
     sss:=stringgrid1.cells[1,p];
     Tslotcode[p,d]:=trim(sss);
     Torder[p,d]:=myorder[p];
     for j:=1 to numYearGroups do
      begin
       sss:=stringgrid1.cells[2+j,p];
       val(sss,dd,erCode);
       for k:=1 to yg[j,0] do Eallot[yg[j,k],d,p]:=dd;
      end;
    end;
  end; {for i}
 DoTimeUpdate;
end;


end.
