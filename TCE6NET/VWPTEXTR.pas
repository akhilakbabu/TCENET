unit Vwptextr;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, ExtCtrls, GlobalToTcAndTcextra;

type
  TViewPastExtrasDlg = class(TForm)
    Label8: TLabel;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    update: TBitBtn;
    finish: TBitBtn;
    BitBtn3: TBitBtn;
    Label4: TLabel;
    Edit1: TEdit;
    Edit3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label23: TLabel;
    Label24: TLabel;
    ListByGroup: TRadioGroup;
    SelGroup: TRadioGroup;
    ComboBox2: TComboBox;
    Label19: TLabel;
    ListBox2: TListBox;
    Label21: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Label20: TLabel;
    ListBox3: TListBox;
    Label22: TLabel;
    UpBtn: TBitBtn;
    DnBtn: TBitBtn;
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure updateClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure ListByGroupClick(Sender: TObject);
    procedure SelGroupClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DnBtnClick(Sender: TObject);
  private
    procedure updateSelection;
    procedure RenameSelGroupLabels;
  end;

var
  ViewPastExtrasDlg: TViewPastExtrasDlg;

implementation
uses tcommon,DlgCommon,tcommon2,tcommon3,pstextra;
{$R *.DFM}
var
 stillLoading: bool;
 tmpSubg:       tpTeData;
 tmpSubj:       tpSubData;
 HasTeList,HasETlist: boolean;
                                  
procedure updateTmpsubg(j: integer);
var
 i: integer;
begin
 tmpsubg[0]:=winPastExtrasSelectionCount[j];
 if tmpsubg[0]>0 then
  for i:=1 to tmpsubg[0] do
   tmpsubg[i]:=winPastExtrasSelection[j,i];
end;

procedure updateSelectionArr(j: integer);
var
 i,k,m: integer;
begin
 if stillLoading then exit;
 with ViewPastExtrasDlg do
 begin
  k:=listbox3.items.count;  m:=0;
  winPastExtrasSelectionCount[j]:=k;
  if k>0 then
   for i:=1 to k do
   begin
    case j of
     1,2,4,5: m:=findtestring(copy(listbox3.items[i-1],1,lencodes[1]));
     3: m:=findaddedstaff(copy(listbox3.items[i-1],1,ETlencodes))
    end; {case}
    winPastExtrasSelection[j,i]:=m;
   end; {for i}
 end; {with}
end;

procedure TViewPastExtrasDlg.updateSelection;
var j,m: integer;
begin
 m:=ListByGroup.ItemIndex;
 case m of
  1..5:
   begin
    if tmpsubg[0]>0 then
     for j:=1 to tmpsubg[0] do
      winPastExtrasSelection[m,j]:=tmpsubg[j];
    winPastExtrasSelectionCount[m]:=tmpsubg[0];
   end;
   6:
   begin
    if tmpsubj[0]>0 then
     for j:=1 to tmpsubg[0] do
      winPastExtrasSelection[m,j]:=tmpsubj[j];
    winPastExtrasSelectionCount[m]:=tmpsubj[0];
   end;
 end;  {case}
end;


procedure updateEnabled;
var
 i,j: integer;
begin
 if stillLoading then exit;
 with ViewPastExtrasDlg do
 begin
  combobox1.color:=clwindow;
  combobox2.color:=clwindow;
  listbox2.color:=clwindow;   listbox3.color:=clwindow;

  i:=ListByGroup.ItemIndex;
  j:=SelGroup.ItemIndex+1;

  case i of
   0: begin  {year}
       combobox1.color:=clRelevantControlOnDlg;
       combobox1.enabled:=true;
       combobox2.Enabled:=false;
       Selgroup.enabled:=false;
       listbox2.enabled:=false;  listbox3.enabled:=false;
       scrollbar1.enabled:=false; scrollbar2.enabled:=false;
      end;
   1..6: begin  // previously 1..5
           combobox1.enabled:=false;
           combobox2.Enabled:=true;
           Selgroup.enabled:=true;
           scrollbar1.enabled:=(i>0) and (i<4);
           scrollbar2.enabled:=(i=2);
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
 end; {with}
end;

procedure TViewPastExtrasDlg.ScrollBar1Change(Sender: TObject);
begin
 case scrollbar1.position of
  1: label12.caption:='1 - Most detail';
  2: label12.caption:='2 - More detail';
  3: label12.caption:='3 - Less detail';
  4: label12.caption:='4 - Least detail';
 end;
end;

procedure TViewPastExtrasDlg.ScrollBar2Change(Sender: TObject);
begin
 case scrollbar2.position of
  1: label11.caption:='A - All';
  2: label11.caption:='E - Extra';
  3: label11.caption:='R - Replace';
  4: label11.caption:='I - In Lieu';
 end;
end;

procedure TViewPastExtrasDlg.FormCreate(Sender: TObject);
var
 i: integer;
begin
 HasTeList:=false; HasETlist:=false;
 for i:=0 to nmbrTeachers do tmpSubg[i]:=0;
 stillLoading:=true;
 combobox1.maxlength:=szYearname;
 combobox2.maxlength:=szFacName;
 label11.caption:=''; label12.caption:='';
 scrollbar1.position:=pedetail;
 scrollbar2.position:=pecover;
 ScrollBar1Change(self);
 ScrollBar2Change(self);

 combobox3.clear; combobox4.clear;
 for i:=1 to 12 do
 begin
  combobox3.items.add(month[i]);
  combobox4.items.add(month[i]);
 end;

 edit1.text:=inttostr(peday1);
 combobox3.itemindex:=pemonth1-1;
 edit3.text:=inttostr(peday2);
 combobox4.itemindex:=pemonth2-1;

 combobox1.clear;
 combobox1.items.add('All years');
 for i:=0 to years_minus_1 do combobox1.items.add(yearname[i]);
 combobox2.clear;
 for i:=1 to facnum do combobox2.items.add(facname[i]);
 listbox2.clear;    listbox3.clear;
 label21.caption:=inttostr(listbox2.items.count);
 label22.caption:=inttostr(listbox3.items.count);

 ListByGroup.ItemIndex:=winView[wnPastExtras];
 SelGroup.ItemIndex:=winPastExtrasBrief2-1;

 combobox1.itemindex:=winPastExtrasyear+1;
 combobox2.itemindex:=winPastExtrasCode-1;
 if (firstmonth>0) and (firstmonth<=12) then
  label17.caption:=month[firstmonth]+' '+inttostr(firstday)
   else label17.Caption:='';
 if (lastmonth>0) and (lastmonth<=12) then
  label18.caption:=month[lastmonth]+' '+inttostr(lastday)
   else label18.Caption:='';
 label24.caption:=inttostr(numabsences);
 label9.caption:=inttostr(AbsentTotal);

 stillLoading:=false;
end;

procedure TViewPastExtrasDlg.FormActivate(Sender: TObject);
begin
 updateEnabled;
end;

procedure TViewPastExtrasDlg.updateClick(Sender: TObject);
var
 i,j,kk: integer;
 msg: string;
 startdateOLD,startdateNEW,
 enddateOLD,enddateNEW:     integer;
begin
 winView[wnPastExtras]:=ListByGroup.ItemIndex;
 winpastExtrasBrief2:=SelGroup.ItemIndex+1;

 winpastExtrasyear:=findyear(combobox1.text);
 if (combobox1.text>'') and (winpastExtrasyear=-1)
  and (combobox1.text<>'All years') and (combobox1.text<>'*') then
 begin
  msg:='Check year';
  messagedlg(msg,mtError,[mbOK],0);
  exit;
 end;

 winpastExtrasCode:=findfac(combobox2.text);
 kk:=winView[wnPastExtras];
 case kk of
  //1..5: winpastExtrasSelectionCount[kk]:=0; // range has been increased to accommodate the "subject" option
  1..6: winpastExtrasSelectionCount[kk]:=0;
  else kk:=1; {prevent error in if test}
 end; {case}

 if winpastExtrasBrief2=2 then
  if winView[wnPastExtras]=3 then
  begin  {added staff}
   if listbox3.items.count>0 then
    for i:=1 to listbox3.items.count do
    begin
     j:=findaddedstaff(copy(listbox3.items[i-1],1,ETlencodes));
     inc(winpastExtrasSelectionCount[kk]);
     winpastExtrasSelection[kk,winpastExtrasSelectionCount[kk]]:=Etpointer[j];
    end;
  end
  // add logic for subject
  else
   if (winView[wnPastExtras]=6) then
    begin
    if listbox3.items.count>0 then
     for i:=1 to listbox3.items.count do
     begin
      j:=findsubstring(copy(listbox3.items[i-1],1,lencodes[0]));
      inc(winpastExtrasSelectionCount[kk]);
      winpastExtrasSelection[kk,winpastExtrasSelectionCount[kk]]:=j;
     end;
    end // end if
  else
   if (winView[wnPastExtras]<>0) then
    begin
    if listbox3.items.count>0 then
     for i:=1 to listbox3.items.count do
     begin
      j:=findtestring(copy(listbox3.items[i-1],1,lencodes[1]));
      inc(winpastExtrasSelectionCount[kk]);
      winpastExtrasSelection[kk,winpastExtrasSelectionCount[kk]]:=j;
     end;
    end; // end if .. end else
 if (winpastExtrasBrief2=2) and (winpastExtrasSelectionCount[kk]=0)
  and (winView[wnPastExtras]<>0)then
 begin
  if winView[wnPastExtras] = 6 then
    msg := 'No subjects selected'
  else
    msg:='No teachers selected';
  messagedlg(msg,mtError,[mbOK],0);
  exit;
 end;

 enddateOLD:=100*PEmonth2+PEday2;
 startdateOLD:=100*PEmonth1+PEday1;

 peday1:=strtointdef(edit1.text,1);
 pemonth1:=combobox3.itemindex+1; if pemonth1<1 then pemonth1:=1;
 peday2:=strtointdef(edit3.text,1);
 pemonth2:=combobox4.itemindex+1; if pemonth2<1 then pemonth2:=1;

 enddateNEW:=100*PEmonth2+PEday2;
 startdateNEW:=100*PEmonth1+PEday1;
 IF (((startdateNEW<startdateOLD) OR (enddateNEW>enddateOLD))
     or ((startdateNEW>startdateOLD) and (enddateNEW>maxEndDate))) THEN
  NeedPastExtrasINITflag:=true
 else
  NeedPastExtrasINITflag:=false;




 pedetail:=scrollbar1.position;
 pecover:=scrollbar2.position;

 close;
 if not(NeedPastExtrasINITflag) then PastExtrasWin.UpdateWin;
end;

procedure TViewPastExtrasDlg.BitBtn1Click(Sender: TObject);
begin
 if ListByGroup.ItemIndex = 6 then
   MoveOffList(tmpSubj,listbox3,label22)
 else
   MoveOffList(tmpsubg,listbox3,label22);
 updateSelection;
end;

procedure TViewPastExtrasDlg.BitBtn2Click(Sender: TObject);
begin
 if ListByGroup.ItemIndex = 6 then
   ClearList(tmpsubj,listbox3,label22)
 else
   ClearList(tmpsubg,listbox3,label22);
 updateSelection;
end;

procedure TViewPastExtrasDlg.BitBtn4Click(Sender: TObject);
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

     if ListByGroup.ItemIndex=6 then
       inc(tmpsubj[0])
     else
       inc(tmpsubg[0]);
     
     if ListByGroup.ItemIndex=3 then
     begin
      k:=findaddedstaff(copy(listbox2.items[i],1,ETlencodes));
      tmpsubg[tmpsubg[0]]:=Etpointer[k];
     end
     else if ListByGroup.ItemIndex=6 then
     begin
      k:=findSubstring(copy(listbox2.items[i],0,lencodes[0]));
      tmpsubj[tmpsubj[0]]:=k;
     end
     else
     begin
      k:=findtestring(copy(listbox2.items[i],1,lencodes[1]));
      tmpsubg[tmpsubg[0]]:=k;
     end;
    end;
  end;  {for i}
 end;
 label21.caption:=inttostr(listbox2.items.count);
 label22.caption:=inttostr(listbox3.items.count);
{ updateseldlgarray; }
 updateSelection;
end;

procedure TViewPastExtrasDlg.BitBtn5Click(Sender: TObject);
var
 i: integer;
begin
 listbox3.items:=listbox2.items;
 label21.caption:=inttostr(listbox2.items.count);
 label22.caption:=inttostr(listbox3.items.count);
 if ListByGroup.ItemIndex=3 then
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

procedure TViewPastExtrasDlg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TViewPastExtrasDlg.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
 allowNumericInputOnly(key);
end;

procedure TViewPastExtrasDlg.ListByGroupClick(Sender: TObject);
var
 i,j,k,m: integer;
 gotcode: tpTeData;
begin
 for i:=0 to nmbrTeachers do gotcode[i]:=0; k:=0;
 m:=ListByGroup.itemindex;
 case m of
  1: label19.caption:='Absent Teachers';
  2: label19.caption:='Cover Teachers';
  3: label19.caption:='Added Staff';
  4: label19.caption:='Lost Class Teachers';
  5: label19.caption:='Teachers';
  6: label19.Caption :='Subjects';
 end; {case}
 updateEnabled;
 case m of
  1,2,4,5: begin  {teachers}
       if not(HasTeList) then
        begin
         listbox2.clear;
         if codenum[1]>0 then
          for i:=1 to codenum[1] do
          begin
           j:=codepoint[i,1];
           listbox2.items.add(tecode[j,0]+'  '+tename[j,0]);
           gotcode[j]:=1;
          end;
         HasTeList:=true; HasEtList:=false;
        end;
        listbox3.clear;
       if winPastExtrasSelectionCount[m]>0 then
        for i:=1 to winPastExtrasSelectionCount[m] do
        begin
         j:=winPastExtrasSelection[m,i];
         if (j>0) and (j<=NumCodes[1]) then
          if (gotcode[j]=1) then
           begin
            listbox3.items.add(tecode[j,0]+'  '+tename[j,0]);
            inc(k); gotcode[j]:=2; tmpsubg[k]:=j;
           end;
        end;
       tmpsubg[0]:=k;
       label21.caption:=inttostr(listbox2.items.count);
       label22.caption:=inttostr(listbox3.items.count);
     end; {teachers}
  3: begin {added staff}
      if not(HasEtList) then
       begin
        listbox2.clear;
        if etnum1>0 then
         for i:=1 to etnum1 do
          begin
           j:=Etpointer[i];
           listbox2.items.add(etsub[j]+'  '+ETname[j]);
           gotcode[j]:=1;
          end; {for i}
        HasEtList:=true; HasTeList:=false;
       end; 
       listbox3.clear;
       if winPastExtrasSelectionCount[3]>0 then
        for i:=1 to winPastExtrasSelectionCount[3] do
        begin
         j:=winPastExtrasSelection[3,i];
         if (j>0) and (j<=ETnum) then
          if (gotcode[j]=1) then
           begin
            listbox3.items.add(etsub[j]+'  '+ETname[j]);
            inc(k); gotcode[j]:=2; tmpsubg[k]:=j;
           end;
        end;
       tmpsubg[0]:=k;
       label21.caption:=inttostr(listbox2.items.count);
       label22.caption:=inttostr(listbox3.items.count);
     end;
    6: begin {subjects}
      if not(HasEtList) then
       begin
        listbox2.clear;
        for i := 1 to nmbrSubjects do
        begin
          if Trim(subCode[i]) <> '' then
            listbox2.items.add(subCode[i]+'  '+subName[i]);
        end;
        HasEtList:=true; HasTeList:=false;
       end; 
       listbox3.clear;
       if winPastExtrasSelectionCount[3]>0 then
        for i:=1 to winPastExtrasSelectionCount[3] do
        begin
         j:=winPastExtrasSelection[3,i];
         if (j>0) and (j<=ETnum) then
          if (gotcode[j]=1) then
           begin
            listbox3.items.add(etsub[j]+'  '+ETname[j]);
            inc(k); gotcode[j]:=2; tmpsubg[k]:=j;
           end;
        end;
       tmpsubg[0]:=k;
       label21.caption:=inttostr(listbox2.items.count);
       label22.caption:=inttostr(listbox3.items.count);
     end;
 end; {case}
 RenameSelGroupLabels;
end;

procedure TViewPastExtrasDlg.RenameSelGroupLabels;
var
  i, selection: integer;
begin
  selection := ListByGroup.ItemIndex;
  if selection = 6 then
  begin
    SelGroup.Items.Strings[0] := 'All Subjects';
    SelGroup.Items.Strings[1] := 'Selected Subjects';
  end
  else
  begin
    SelGroup.Items.Strings[0] := 'All Teachers';
    SelGroup.Items.Strings[1] := 'Selected Teachers';
  end;
end;

procedure TViewPastExtrasDlg.SelGroupClick(Sender: TObject);
begin
 updateEnabled;
end;

procedure TViewPastExtrasDlg.UpBtnClick(Sender: TObject);
begin
 if ListByGroup.ItemIndex=6 then
   MoveUpList(tmpsubj,ListBox3)
 else
   MoveUpList(tmpsubg,ListBox3);
end;

procedure TViewPastExtrasDlg.DnBtnClick(Sender: TObject);
begin
 if ListByGroup.ItemIndex=6 then
   MoveDownList(tmpsubj,ListBox3)
 else
   MoveDownList(tmpsubg,ListBox3);
end;

end.
