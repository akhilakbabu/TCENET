unit Vwusers;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons;

type
  TviewUsersDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    ShowGroup: TGroupBox;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  viewUsersDlg: TviewUsersDlg;

implementation                 
uses tceload,tcommon,tcommon2,tcommon3,tceglobals,tcommon5;
{$R *.DFM}

procedure TviewUsersDlg.FormCreate(Sender: TObject);
begin
 case winShowUsersBrief of
  0: radiobutton4.checked:=true;
  1: radiobutton5.checked:=true;
{  2: radiobutton1.checked:=true;}
 end;
end;

procedure TviewUsersDlg.OKBtnClick(Sender: TObject);
begin
 if radiobutton4.checked then winShowUsersBrief:=0;
 if radiobutton5.checked then winShowUsersBrief:=1;
{ if radiobutton1.checked then winShowUsersBrief:=2; }
 updateShowUsersWindow;
end;

end.
