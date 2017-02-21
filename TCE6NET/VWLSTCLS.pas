unit Vwlstcls;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,TCEglobals;

type
  Tviewlostclasses = class(TForm)
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
  viewlostclasses: Tviewlostclasses;

implementation
uses tcommon,tcommon2,tcommon3, Lostclss;
{$R *.DFM}

procedure Tviewlostclasses.OKBtnClick(Sender: TObject);
var
 oldView,oldSort: smallint;
begin
 screen.cursor:=crHourglass;
 try     {ensure cursor restored}
  oldView:=winView[wnLostClass];
  oldSort:=lcsorttype;
  winView[wnLostClass]:=Show.ItemIndex;
  lcsorttype:=Sort.ItemIndex;
  if lcsorttype<>oldSort then sortlccodes;
  if (oldView<>winView[wnLostClass]) or (oldSort<>lcsorttype) then
   begin
    dec(winView[wnLostClass]);
    LostClasseswin.ChangeView;
   end;
 finally
  Screen.Cursor := crDefault;
 end; {try finally block}
end;

end.
