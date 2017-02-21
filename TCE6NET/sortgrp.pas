unit sortgrp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,TCEglobals;

type
  TSortGroupDlg = class(TForm)
    GroupBox1: TGroupBox;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Select: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure SelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SortGroupDlg: TSortGroupDlg;

implementation
uses tcommon,tcommon2,GroupSel;
{$R *.DFM}


procedure SortGroup(ascending: bool);
var
i,j,L,swaps:        smallint;
aStr,bStr:          string;
g1,g2:              smallint;
aDbl,bDbl:          double;
error:              integer;

  procedure SwapGroupStudent;
  var
   a:       smallint;
  begin
   a:=StudSort[j];
   StudSort[j]:=StudSort[L];
   StudSort[l]:=a;
   inc(swaps);
  end; {local proc}

begin
 if numstud<2 then exit;
 try
  screen.cursor:=crHourglass;
  for i:=1 to numstud do StudSort[i]:=i;
  for i:=1 to (numstud-1) do
  begin
   swaps:=0;
   for j:=1 to (numstud-1) do
   begin
    L:=j+1;
    g1:=StudSort[L];  g2:=StudSort[j];
    case groupSort of
    0: begin  {year}
        aStr:=uppercase(trim(inttostr(Stud[g1].TcYear)));
        bStr:=uppercase(trim(inttostr(Stud[g2].TcYear)));
       end;
    1: begin  {name}
        aStr:=uppercase(trim(Stud[g1].Stname)+trim(Stud[g1].first));
        bStr:=uppercase(trim(Stud[g2].Stname)+trim(Stud[g2].first));
       end;
    2: begin  {class}
        aStr:=uppercase(trim(ClassCode[Stud[g1].tcClass]));
        bStr:=uppercase(trim(ClassCode[Stud[g2].tcClass]));
       end;
    3: begin  {House}
        aStr:=uppercase(trim(HouseName[Stud[g1].House]));
        bStr:=uppercase(trim(HouseName[Stud[g2].House]));
       end;
    4: begin  {ID}
        aStr:=uppercase(trim(Stud[g1].ID));
        bStr:=uppercase(trim(Stud[g2].ID));
       end;
    6: begin   {tutor}
        aStr:=uppercase(trim(TeCode[Stud[g1].tutor,0]));
        bStr:=uppercase(trim(TeCode[Stud[g2].tutor,0]));
       end;
    7: begin   {room}
        aStr:=uppercase(trim(TeCode[Stud[g1].home,1]));
        bStr:=uppercase(trim(TeCode[Stud[g2].home,1]));
       end;
    end; {case}
    if groupsort=5 then
    begin
     val(Stud[g1].ID,aDbl,error);
     val(Stud[g2].ID,bDbl,error);
     if ascending then
     begin
      if aDbl<bDbl then SwapGroupStudent;
     end
     else
      begin
       if aDbl>bDbl then SwapGroupStudent;
      end;
    end
    else {not    groupsort=5}
     begin
      if ascending then
      begin
       if aStr<bStr then SwapGroupStudent;
      end
      else
       begin
        if aStr>bStr then SwapGroupStudent;
       end;
     end; {if groupsort=5}
     end; {for j}
     if swaps=0 then break;
    end; {for i}
   finally
    screen.cursor:=crDefault;
   end;

 REselectgroup;
 studentPointerSet;
 UpdateStudWins;
end;

procedure TSortGroupDlg.BitBtn1Click(Sender: TObject);
begin
 close;
end;

procedure TSortGroupDlg.SelectClick(Sender: TObject);
begin
 groupsort:=radiogroup1.itemindex;
 sortgroup((radiogroup2.itemindex=0));
 sortChangeFlag:=true;
end;

procedure TSortGroupDlg.FormCreate(Sender: TObject);
begin
 radiogroup1.ItemIndex:=GroupSort;
end;

end.
