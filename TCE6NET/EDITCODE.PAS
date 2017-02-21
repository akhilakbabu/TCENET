unit Editcode;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons;

type
  Teditcodedlg = class(TForm)
    okbtn: TBitBtn;
    cancelbtn: TBitBtn;
    helpbtn: TBitBtn;
    GroupBox1: TGroupBox;
    Codelabel: TLabel;
    Namelabel: TLabel;
    loadlabel: TLabel;
    Faculty1label: TLabel;
    faculty2label: TLabel;
    faculty3label: TLabel;
    codecountlabel: TLabel;
    codeEdit: TEdit;
    nameEdit: TEdit;
    loadEdit: TEdit;
    faculty1edit: TEdit;
    faculty2edit: TEdit;
    faculty3edit: TEdit;
    codecountedit: TEdit;
    procedure cancelbtnClick(Sender: TObject);
    procedure okbtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  editcodedlg: Teditcodedlg;

implementation

{$R *.DFM}

procedure Teditcodedlg.cancelbtnClick(Sender: TObject);
begin
 editcodedlg.hide;
end;

procedure Teditcodedlg.okbtnClick(Sender: TObject);
begin
 editcodedlg.hide;
end;

procedure Teditcodedlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=caFree;
end;

end.
