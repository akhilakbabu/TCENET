unit Vwcrextr;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,TCEglobals, GlobalToTcAndTcextra;

type
  TViewCurrentExtrasDlg = class(TForm)
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    update: TBitBtn;
    finish: TBitBtn;
    BitBtn3: TBitBtn;
    ComboBox1: TComboBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    ComboBox2: TComboBox;
    Button1: TButton;
    ListByGroup: TRadioGroup;
    CheckBox1: TCheckBox;
    Label4: TLabel;
    ListBox2: TListBox;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Label5: TLabel;
    ListBox3: TListBox;
    Label7: TLabel;
    UpBtn: TBitBtn;
    DnBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure RadioButton7Click(Sender: TObject);
    procedure RadioButton8Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure ListByGroupClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DnBtnClick(Sender: TObject);
  private
   procedure SetButton1;
   procedure SetCover;
   procedure SetAdded;
   procedure SetAbsent;
   function GetSelectBy: integer;
  end;

var
  ViewCurrentExtrasDlg: TViewCurrentExtrasDlg;

implementation
uses tcommon,tcommon2,DlgCommon,tcommon3,curextra,main,progress;
{$R *.DFM}
var
 stillLoading: boolean;
 tmpSubg:       tpTeData;


procedure updateTmpsubg(j: integer);
var
 i: integer;
begin
 tmpsubg[0]:=winCurrentExtrasSelectionCount[j];
 if tmpsubg[0]>0 then
  for i:=1 to tmpsubg[0] do
   tmpsubg[i]:=winCurrentExtrasSelection[j][i];
end;

procedure updateSelectionArr(j: integer);
var
 i,k,m: integer;
begin
 if stillLoading then exit;
 with ViewCurrentExtrasDlg do
 begin
  k:=listbox3.items.count;  m:=0;
  winCurrentExtrasSelectionCount[j]:=k;
  if k>0 then
   for i:=1 to k do
   begin
    case j of
     1,2: m:=findtestring(copy(listbox3.items[i-1],1,lencodes[1]));
     3: m:=findaddedstaff(copy(listbox3.items[i-1],1,ETlencodes))
    end; {case}
    winCurrentExtrasSelection[j][i]:=m;
   end; {for i}
 end; {with}
end;

procedure updateSelection;
var j,k,m: integer;
begin
 with ViewCurrentExtrasDlg do
  m:=ListByGroup.ItemIndex-1;

 case m of
 1,2,3:
  begin
   k:=m;
   if tmpsubg[0]>0 then
    for j:=1 to tmpsubg[0] do
     winCurrentExtrasSelection[k][j]:=tmpsubg[j];
   winCurrentExtrasSelectionCount[k]:=tmpsubg[0];
  end;
 end;  {case}
end;




procedure updateEnabled;
var
 i,j: integer;
begin
 if stillLoading then exit;
 with ViewCurrentExtrasDlg do
 begin
  combobox1.color:=clwindow;
  combobox2.color:=clwindow;
  listbox2.color:=clwindow;  listbox3.color:=clwindow;

 i:=ListByGroup.ItemIndex;
 j:=GetSelectBy;

  case i of
   0,5,6: begin
            combobox1.enabled:=false;
            groupbox2.enabled:=false;
            listbox2.enabled:=false; listbox3.enabled:=false;
           end;
   1: begin
       combobox1.color:=clRelevantControlOnDlg;
       combobox1.enabled:=true;
       groupbox2.enabled:=false;
       listbox2.enabled:=false;   listbox3.enabled:=false;
      end;
   2,3,4: begin
           combobox1.enabled:=false;
           groupbox2.enabled:=true;
           case j of
            1: begin
                listbox2.enabled:=false; listbox3.enabled:=false;
                combobox2.enabled:=false;
               end;
            2: begin
                listbox2.color:=clRelevantControlOnDlg;
                listbox2.enabled:=true;
                listbox3.color:=clRelevantControlOnDlg;
                listbox3.enabled:=true; combobox2.enabled:=false;
               end;
            3: begin
                combobox2.color:=clRelevantControlOnDlg;
                listbox2.enabled:=false; listbox3.enabled:=false;
                combobox2.enabled:=true;
               end;
           end; {case}
          end;
  end; {case}
  SetButton1;
 end; {with}
 
end;

function TViewCurrentExtrasDlg.GetSelectBy: integer;
begin
 result:=0;
 if radiobutton6.checked then result:=1
  else if radiobutton7.checked then result:=2
   else if radiobutton8.checked then result:=3;
end;


procedure TViewCurrentExtrasDlg.SetButton1;
begin
Button1.Enabled:=(ListByGroup.ItemIndex>1) and (ListByGroup.ItemIndex<5)
end;


procedure TViewCurrentExtrasDlg.FormCreate(Sender: TObject);
var
 i:  integer;
begin
 fillchar(tmpSubg,sizeof(tmpSubg),chr(0));
 stillLoading:=true;
 combobox1.maxlength:=szYearname;
 combobox2.maxlength:=szFacName;
 checkbox1.Checked:=IncludeShareFlag;
 label9.caption:=inttostr(numchanges);
 combobox1.clear;
 combobox1.items.add('All years');
 for i:=0 to years_minus_1 do combobox1.items.add(yearname[i]);
 combobox2.clear;
 for i:=1 to facnum do combobox2.items.add(facname[i]);
 listbox2.clear;  listbox3.clear;
 label6.caption:=inttostr(listbox2.items.count);
 label7.caption:=inttostr(listbox3.items.count);

 ListByGroup.ItemIndex:=winView[wnCurrentExtras];

 case winCurrentExtrasBrief2 of
  1: radiobutton6.checked:=true;
  2: radiobutton7.checked:=true;
  3: radiobutton8.checked:=true;
 end;
 combobox1.itemindex:=winCurrentExtrasyear+1;
 combobox2.itemindex:=winCurrentExtrasCode-1;
 SetButton1;
 stillLoading:=false;
end;

procedure TViewCurrentExtrasDlg.updateClick(Sender: TObject);
var
 i,j,kk: integer;
 msg: string;
begin

 winView[wnCurrentExtras]:=ListByGroup.ItemIndex;
 winCurrentExtrasBrief2:=GetSelectBy;

 winCurrentExtrasyear:=findyear(combobox1.text);
 if (combobox1.text>'') and (winCurrentExtrasyear=-1)
  and (combobox1.text<>'All years') and (combobox1.text<>'*') then
 begin
  msg:='Check year';
  messagedlg(msg,mtError,[mbOK],0);
  exit;
 end;

 winCurrentExtrasCode:=findfac(combobox2.text);
 kk:=winView[wnCurrentExtras]-1;
 case kk of
  1,2,3: winCurrentExtrasSelectionCount[kk]:=0;
  else kk:=1; {prevent error in if test}
 end; {case}
 if winCurrentExtrasBrief2=2 then
 if winView[wnCurrentExtras]=4 then
 begin
   {for i:=1 to etnum1 do}
   if listbox3.items.count>0 then
    for i:=1 to listbox3.items.count do
    begin
     j:=findaddedstaff(copy(listbox3.items[i-1],1,ETlencodes));
     inc(winCurrentExtrasSelectionCount[kk]);
     winCurrentExtrasSelection[kk][winCurrentExtrasSelectionCount[kk]]:=Etpointer[j];
    end;
 end
 else
  if ((winView[wnCurrentExtras]=2) or (winView[wnCurrentExtras]=3)) then
   begin
    if listbox3.items.count>0 then
     for i:=1 to listbox3.items.count do
     begin
      j:=findtestring(copy(listbox3.items[i-1],1,lencodes[1]));
      inc(winCurrentExtrasSelectionCount[kk]);
      winCurrentExtrasSelection[kk][winCurrentExtrasSelectionCount[kk]]:=j;
     end;
   end;
 if (winCurrentExtrasBrief2=2) and (winCurrentExtrasSelectionCount[kk]=0)
  and ((winView[wnCurrentExtras]=2) or (winView[wnCurrentExtras]=3) or (winView[wnCurrentExtras]=4))then
 begin
  msg:='No teachers selected';
  messagedlg(msg,mtError,[mbOK],0);
  exit;
 end;
 IncludeShareFlag:=checkbox1.Checked;
 CurrentExtrasWin.updateWin;
 close;
 CurrentExtrasWin.updateWin;
end;

procedure TViewCurrentExtrasDlg.SetAdded;
var
 i,j,k: integer;
 found: bool;
 gotcode: tpAddedData;
begin
 label4.caption:='Added Staff';
 updateEnabled;
 listbox2.clear;
 for i:=0 to nmbrAddedTeachers do gotcode[i]:=0;
 if etnum1>0 then
  for i:=1 to etnum1 do
  begin
   j:=Etpointer[i]; found:=false;
   for k:=1 to numchanges do
   begin
    if (Changes[k].kind>9) or (Changes[k].newte<>j) then continue;
    if not({etprint}true xor (Changes[k].kind=1)) then found:=true;
   end; {for k}
   if found then
    begin
     listbox2.items.add(etsub[j]+'  '+ETname[j]);
     gotcode[j]:=1;
    end;
  end; {for i}

 listbox3.clear;
 k:=0;
 if winCurrentExtrasSelectionCount[3]>0 then
  for i:=1 to winCurrentExtrasSelectionCount[3] do
  begin
   j:=winCurrentExtrasSelection[3][i];
   if (j>0) and (j<=Etnum) then
    if (gotcode[j]=1) then
     begin
      listbox3.items.add(etsub[j]+'  '+ETname[j]);
      inc(k); gotcode[j]:=2; tmpsubg[k]:=j;
     end;
  end;
 tmpsubg[0]:=k;
 label6.caption:=inttostr(listbox2.items.count);
 label7.caption:=inttostr(listbox3.items.count);
end;

procedure TViewCurrentExtrasDlg.SetAbsent;
var
 i,j,k: integer;
 gotcode: tpTeData;
begin
 label4.caption:='Absent Teachers';
 updateEnabled;
 listbox2.clear;
 for i:=0 to nmbrTeachers do gotcode[i]:=0;
 if codenum[1]>0 then
  for i:=1 to codenum[1] do
  begin
   j:=codepoint[i,1];
   if (teabsent[j]<>-1) then
    begin
     listbox2.items.add(tecode[j,0]+'  '+tename[j,0]);
     gotcode[j]:=1;
    end;
  end;

 listbox3.clear;
 k:=0;
 if winCurrentExtrasSelectionCount[1]>0 then
  for i:=1 to winCurrentExtrasSelectionCount[1] do
  begin
   j:=winCurrentExtrasSelection[1][i];
   if (j>0) and (j<=NumCodes[1]) then
    if (gotcode[j]=1) then
     begin
      listbox3.items.add(tecode[j,0]+'  '+tename[j,0]);
      inc(k); gotcode[j]:=2; tmpsubg[k]:=j;
     end;
  end;
 tmpsubg[0]:=k;
 label6.caption:=inttostr(listbox2.items.count);
 label7.caption:=inttostr(listbox3.items.count);
end;

procedure TViewCurrentExtrasDlg.SetCover;
var
 i,j,k: integer;
 found: bool;
 gotcode: tpTeData;
begin
 label4.caption:='Cover Teachers';
 updateEnabled;
 listbox2.clear;
 for i:=0 to nmbrTeachers do gotcode[i]:=0;
 if codenum[1]>0 then
  for i:=1 to codenum[1] do
  begin
   j:=codepoint[i,1]; found:=false;
   for k:=1 to numchanges do
   begin
    if (Changes[k].kind>9) or (Changes[k].newte<>j) then continue;
    if Changes[k].kind<>1 then found:=true;
   end; {for k}
   if found then
    begin
     listbox2.items.add(tecode[j,0]+'  '+tename[j,0]);
     gotcode[j]:=1;
    end;
  end; {for i}

 listbox3.clear;
 k:=0;
 if winCurrentExtrasSelectionCount[2]>0 then
  for i:=1 to winCurrentExtrasSelectionCount[2] do
  begin
   j:=winCurrentExtrasSelection[1][i];
   if (j>0) and (j<=NumCodes[1]) then
    if (gotcode[j]=1) then
     begin
      listbox3.items.add(tecode[j,0]+'  '+tename[j,0]);
      inc(k); gotcode[j]:=2; tmpsubg[k]:=j;
     end;
  end;
 tmpsubg[0]:=k;
 label6.caption:=inttostr(listbox2.items.count);
 label7.caption:=inttostr(listbox3.items.count);
end;


procedure TViewCurrentExtrasDlg.RadioButton6Click(Sender: TObject);
begin
updateEnabled;
end;

procedure TViewCurrentExtrasDlg.RadioButton7Click(Sender: TObject);
begin
updateEnabled;
end;

procedure TViewCurrentExtrasDlg.RadioButton8Click(Sender: TObject);
begin
updateEnabled;
end;

procedure TViewCurrentExtrasDlg.FormActivate(Sender: TObject);
begin
updateEnabled;
end;

procedure TViewCurrentExtrasDlg.BitBtn1Click(Sender: TObject);
begin
 MoveOffList(tmpsubg,listbox3,label7);
 updateSelection;
end;

procedure TViewCurrentExtrasDlg.BitBtn2Click(Sender: TObject);
begin
 ClearList(tmpsubg,listbox3,label7);
 updateSelection;
end;

procedure TViewCurrentExtrasDlg.BitBtn4Click(Sender: TObject);
var
 i,k:       integer;
begin
 if listbox2.items.count>0 then
 begin
  for i:=0 to (listbox2.items.count-1) do
  begin
   if listbox2.selected[i] then
    if listbox3.items.indexof(listbox2.items[i])=-1 then {not already in list}
    begin
     listbox3.items.add(listbox2.items[i]);
     inc(tmpsubg[0]);
     if ListByGroup.ItemIndex=4 then
     begin
      k:=findaddedstaff(copy(listbox2.items[i],1,ETlencodes));
      tmpsubg[tmpsubg[0]]:=Etpointer[k];
     end
     else
     begin
      k:=findtestring(copy(listbox2.items[i],1,lencodes[1]));
      tmpsubg[tmpsubg[0]]:=k;
     end;
    end;
  end;  {for i}
 end;
 label6.caption:=inttostr(listbox2.items.count);
 label7.caption:=inttostr(listbox3.items.count);
 updateSelection;
end;

procedure TViewCurrentExtrasDlg.BitBtn5Click(Sender: TObject);
var
 i: integer;
begin
 listbox3.items:=listbox2.items;
 label6.caption:=inttostr(listbox2.items.count);
 label7.caption:=inttostr(listbox3.items.count);
 if ListByGroup.ItemIndex=4 then
 begin
  for i:=1 to etnum1 do tmpsubg[i]:=Etpointer[i];
  tmpsubg[0]:=etnum1;
 end
 else
 begin
  for i:=1 to codenum[1] do tmpsubg[i]:=codepoint[i,1];
  tmpsubg[0]:=codenum[1];
 end;
 updateSelection;
end;

procedure TViewCurrentExtrasDlg.ListByGroupClick(Sender: TObject);
begin
 updateEnabled;
 case ListByGroup.ItemIndex of
  2: SetAbsent;
  3: SetCover;
  4: SetAdded;
 end; 
end;

procedure TViewCurrentExtrasDlg.Button1Click(Sender: TObject);
var
 i,j,count:    integer;
begin
 ProgressForm:=TProgressForm.create(application);   {allocate dlg}
 ProgressForm.Tag:=2;
 with ProgressForm do
  try
   if Length(ListItems)=0 then
   begin
     //SetLength(mailtag,nmbrteachers+1);
     SetLength(ListItems,nmbrteachers+1);
   end;
   myview:=ListByGroup.ItemIndex;
   myselect:=GetSelectby;
   num2:=0; count:=0;
   myfac:=findfac(combobox2.text);
   if myselect=2 then {user selection}
     begin
      num2:=listbox3.items.count;
      if num2>0 then
       case myview of
        4:for i:=1 to num2 do
           begin {added staff}
            j:=findaddedstaff(copy(listbox3.items[i-1],1,ETlencodes));
            if j>0 then begin inc(count);ListItems[count]:=Etpointer[j]; end;
           end;
        2,3: for i:=1 to num2 do
           begin {teachers}
            j:=findtestring(copy(listbox3.items[i-1],1,lencodes[1]));
            if j>0 then begin inc(count);ListItems[count]:=j; end;
           end;
       end; {case}
     end; {myselect=2}
  finally; {with ProgressForm}
   ProgressForm.showmodal;
   ProgressForm.free;
  end; 
end;

procedure TViewCurrentExtrasDlg.UpBtnClick(Sender: TObject);
begin
 MoveUpList(tmpsubg,ListBox3);
end;

procedure TViewCurrentExtrasDlg.DnBtnClick(Sender: TObject);
begin
 MoveDownList(tmpsubg,ListBox3);
end;

end.
