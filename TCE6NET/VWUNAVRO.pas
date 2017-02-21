unit Vwunavro;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,TCEglobals;

type
  TviewUnavailRoomsdlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Show: TRadioGroup;
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

var
  viewUnavailRoomsdlg: TviewUnavailRoomsdlg;

implementation
uses tcommon,tcommon2,tcommon3,Unavalro;

{$R *.DFM}

procedure TviewUnavailRoomsdlg.OKBtnClick(Sender: TObject);
var
 oldView: smallint;
begin
 oldView:=winView[wnUnavailRooms];
 winView[wnUnavailRooms]:=Show.ItemIndex;
 if (oldView<>winView[wnUnavailRooms]) then
   begin
    dec(winView[wnUnavailRooms]);
    UnavailableRooms.ChangeView;
   end;
end;

procedure TviewUnavailRoomsdlg.FormCreate(Sender: TObject);
begin
 Show.ItemIndex:=winView[wnUnavailRooms];
end;

end.
