unit Vwcoddlg;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls,TCEglobals;

type
  TViewCodeDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Sort: TRadioGroup;
    Show: TRadioGroup;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewCodeDialog: TViewCodeDialog;

implementation
uses tcommon,TeWnd;

{$R *.DFM}

procedure TViewCodeDialog.OKBtnClick(Sender: TObject);
var
 i:       integer;
 oldView,oldSort,oldSelect: smallint;
begin
 screen.cursor:=crHourglass;
 try     {ensure cursor restored}
  oldView:=winView[wnTecode];
  oldSort:=sorttype[1]; oldSelect:=0;
  winView[wnTecode]:=Show.ItemIndex;
  sortType[1]:=Sort.ItemIndex;
  if sorttype[1]<>oldSort then
   begin
    {ensure still pointing to correct code after sort order changed}
    if TeWindow.selCode>0 then oldSelect:=codepoint[TeWindow.selCode,1];
    sortcodes(1);
    {ensure still pointing to correct code after sort order changed}
    if TeWindow.selCode>0 then
     for i:=1 to codenum[1] do
      if ((codepoint[i,1])=(oldSelect)) then
      begin
       TeWindow.selCode:=i;
       break;
      end;
   end; {if sorttype[1]<>oldSort}
  if (oldView<>winView[wnTecode]) or (oldSort<>sorttype[1]) then
             TeWindow.UpdateWin;
 finally
  Screen.Cursor := crDefault;
 end; {try finally block}
 close;
end;

procedure TViewCodeDialog.CancelBtnClick(Sender: TObject);
begin
 close;
end;

procedure TViewCodeDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
end;

end.
