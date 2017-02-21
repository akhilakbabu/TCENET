unit Viewasel;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,TCEglobals;

type
  Tviewaseldlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Sort: TRadioGroup;
    Show: TRadioGroup;
    chkPriority: TCheckBox;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  viewaseldlg: Tviewaseldlg;

implementation
uses tcommon,tcommon2,adstfsel,tcommon3,tcommon4;
{$R *.DFM}

procedure Tviewaseldlg.OKBtnClick(Sender: TObject);
var
 oldView,oldSort: smallint;
begin
 screen.cursor:=crHourglass;
 try     {ensure cursor restored}
  oldView:=winView[wnAddedSel];
  oldSort:=asSelsorttype;
  winView[wnAddedSel]:=Show.ItemIndex;
  asSelsorttype:=Sort.ItemIndex;
  if (chkPriority.Checked) then begin
      asSelSortType := asSelSortType + 5;
  end;
  if asSelsorttype<>oldSort then etsort3;
  if (oldView<>winView[wnAddedSel]) or (oldSort<>asSelsorttype) then
   begin
    dec(winView[wnAddedSel]);
    AddedStaffSelWin.ChangeView;
   end;
 finally
  Screen.Cursor := crDefault;
 end; {try finally block}
end;

end.
