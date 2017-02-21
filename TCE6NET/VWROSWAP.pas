unit Vwroswap;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,TCEglobals;

type
  TviewRoomSwapsdlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Show: TRadioGroup;
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

var
  viewRoomSwapsdlg: TviewRoomSwapsdlg;

implementation
uses tcommon,tcommon2,tcommon3, Roomswap;

{$R *.DFM}

procedure TviewRoomSwapsdlg.OKBtnClick(Sender: TObject);
var
 oldView: smallint;
begin
 oldView:=winView[wnRoomSwap];
 winView[wnRoomSwap]:=Show.ItemIndex;
 if (oldView<>winView[wnRoomSwap]) then
   begin
    dec(winView[wnRoomSwap]);
    RoomSwaps.ChangeView;
   end;
end;

procedure TviewRoomSwapsdlg.FormCreate(Sender: TObject);
begin
 Show.ItemIndex:=winView[wnRoomSwap];
end;

end.
