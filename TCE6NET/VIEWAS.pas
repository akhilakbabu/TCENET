unit Viewas;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, ExtCtrls;

type
  Tviewaddedstaffdlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    SortGroup1: TRadioGroup;
    ViewGroup1: TRadioGroup;
    chkPriority: TCheckBox;
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  viewaddedstaffdlg: Tviewaddedstaffdlg;

implementation
uses tcommon,tcommon2,addstaff,{adstfsel,}tcommon3,tcommon4;
{$R *.DFM}

procedure Tviewaddedstaffdlg.OKBtnClick(Sender: TObject);
var
 oldcurcode1:                                    string;
 osel,nsel:                                     integer;
 need1:                                          bool;
begin
 assorttype:=sortgroup1.ItemIndex;
 if (chkPriority.checked) then begin
     assorttype := assorttype + 5;
 end;
 winView[wnAddedStaff]:=ViewGroup1.ItemIndex;

 need1:=false;
 osel:=0; nsel:=0;
 if wnFlag[wnAddedStaff] then
  if Addedstaffwin.selcode>0 then
  begin
      osel:=Addedstaffwin.selcode;
      oldcurcode1:=etsub[Etpointer[Addedstaffwin.selcode]];
      need1:=true;
  end;    

{ sortasCodes;  }
 etsort2;
 {restore selection if needed}
 if need1 then nsel:=findaddedstaff(oldcurcode1);
 {if need2 then nse2:=findaddedstaff(oldcurcode2);}

 if wnFlag[wnAddedStaff] then
  begin
   if nsel<>osel then Addedstaffwin.selcode:=nsel;
   AddedStaffWin.UpdateWin;
  end;
            
end;

procedure Tviewaddedstaffdlg.FormCreate(Sender: TObject);
begin
 ViewGroup1.ItemIndex:=winView[wnAddedStaff];
 if (assorttype>4) then begin
     assorttype := assorttype - 5;
     chkPriority.Checked := true;
 end else begin
     chkPriority.Checked := false;
 end;
 sortgroup1.ItemIndex:=assorttype;
end;

end.
