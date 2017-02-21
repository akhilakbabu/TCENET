unit Viewabte;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,TCEglobals;

type
  TViewAbTeDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Sort: TRadioGroup;
    Show: TRadioGroup;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewAbTeDlg: TViewAbTeDlg;

implementation
uses tcommon,tcommon2,tcommon3, Abtes;
{$R *.DFM}

procedure TViewAbTeDlg.OKBtnClick(Sender: TObject);
var
 oldView,oldSort: smallint;
begin
 screen.cursor:=crHourglass;
 try     {ensure cursor restored}
  oldView:=winView[wnAbsentTe];
  oldSort:=absorttype;
  winView[wnAbsentTe]:=Show.ItemIndex;
  absorttype:=Sort.ItemIndex;
  if absorttype<>oldSort then sortabcodes;
  if (oldView<>winView[wnAbsentTe]) or (oldSort<>absorttype) then
   begin
    dec(winView[wnAbsentTe]);
    AbsentTe.ChangeView;
   end;
 finally
  Screen.Cursor := crDefault;
 end; {try finally block}
end;

end.
