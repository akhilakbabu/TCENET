unit PrintPreviewForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, Preview, ActnList, ImgList, StdCtrls, Buttons,
  ExtCtrls,Printers,TCEglobals;

type
  TPrntPreviewForm = class(TForm)
    ToolBar1: TToolBar;
    PrintPreview: TPrintPreview;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ppActionList: TActionList;
    PreviewPrint: TAction;
    ImageList2: TImageList;
    PreviewSetupPage: TAction;
    ToolButton7: TToolButton;
    Label1: TLabel;
    PageEdit: TEdit;
    Label2: TLabel;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ComboBox1: TComboBox;
    ToolButton13: TToolButton;
    Button1: TButton;
    ToolButton14: TToolButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PrintPreviewChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PreviewSetupPageExecute(Sender: TObject);
    procedure PreviewPrintExecute(Sender: TObject);
    procedure PageEditKeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
  private
    FirstActivation: Boolean;
    procedure CreatePages;
    procedure SetPreviewDefaults;
  public
    { Public declarations }
  end;

var
  PrntPreviewForm: TPrntPreviewForm;

implementation
uses tcommon, Main;
{$R *.dfm}
const
 zoomrange: array[0..6] of integer = (25,50,75,100,150,200,300);

procedure SetZoomButtons;
begin
 with PrntPreviewForm do
  begin
   ToolButton12.Enabled := (PrintPreview.Zoom >25);
   ToolButton11.Enabled := (PrintPreview.Zoom <300);
  end;
end;

procedure TPrntPreviewForm.FormCreate(Sender: TObject);
begin
  ComboBox1.ItemIndex := 9;
  FirstActivation := True;
  PreviewOn:=True;
end;

procedure TPrntPreviewForm.FormActivate(Sender: TObject);
begin
  if FirstActivation then
  begin
    FirstActivation := False;
    Previewfont:=tfont.create;
    Previewfont.assign(tcfont);
    PrintPreview.canvas.Font.Assign(PreviewFont);
    Update;
    CreatePages;
  end;
end;

function SetPageSizes:boolean;
var
 mywidth,myheight: integer;
begin
 with PrntPreviewForm.PrintPreview do
  begin
   result:=false;
   if not PrinterInstalled then exit;
   if Orientation<>Printer.Orientation then result:=True;
   Orientation:=Printer.Orientation;
   if Units=TUnits(2) then
    begin
     myheight:=((Printer.PageHeight)*2540) div (PixelsPerInch.Y);
     mywidth:=((Printer.PageWidth)*2540) div (PixelsPerInch.Y);
     if (PaperHeight<>myheight) or (PaperWidth<>mywidth) then result:=true;
     PaperHeight:=myheight;
     PaperWidth:=mywidth;
    end;
   if Units=TUnits(1) then
    begin
     myheight:=((Printer.PageHeight)*254) div (PixelsPerInch.Y);
     mywidth:=((Printer.PageWidth)*254) div (PixelsPerInch.Y);
     if (PaperHeight<>myheight) or (PaperWidth<>mywidth) then result:=true;
     PaperHeight:=myheight;
     PaperWidth:=mywidth;
    end;
  end;
end;

procedure TPrntPreviewForm.SetPreviewDefaults;
begin
  with PrintPreview do
  begin
   PrintPreview.canvas.Font.Assign(PreviewFont);
   Units:=TUnits(1);
   if (PaperHeight<3276) and (PaperWidth<3276) then
    begin {set units to .01mm}
     Units:=TUnits(2);
     PreviewFont.Height:=-(tcfont.Size*2540)div 72;
     PrntHmargin:=integer(trunc(PrntLeftMargin*1000));
     PrntVmargin:=integer(trunc(PrntTopMargin*1000));
    end
   else
    begin {set units to .1mm}
     PreviewFont.Height:=-(tcfont.Size*254)div 72;
     PrntHmargin:=integer(trunc(PrntLeftMargin*100));
     PrntVmargin:=integer(trunc(PrntTopMargin*100));
    end;
   canvas.Font.Assign(PreviewFont);
   SetPageSizes;
  end;
end;

procedure TPrntPreviewForm.CreatePages;
begin
  Caption := 'Creating pages...';
  Randomize;
  with PrintPreview do
  begin
   BeginDoc;
   SetPreviewDefaults;
   EndDoc;
   BeginDoc;
   SetPreviewDefaults;
   getPrntFontWidths(PrintPreview.Canvas);
   printOurWindowDetail(PreviewWin);
   EndDoc;
   PrintPreviewChange(self);
  end;
  { If there's any installed printer on the system, we permit printing. }
  ToolButton2.Enabled:=PrintPreview.PrinterInstalled;
  ToolButton1.Enabled:=PrintPreview.PrinterInstalled;
  ActiveControl := PrintPreview;
  Caption := setprintertitle(PreviewWin);
end;


procedure TPrntPreviewForm.PrintPreviewChange(Sender: TObject);
begin
 if PrintPreview.CurrentPage <> 0 then
  begin
    with PrintPreview do
     PageEdit.Text:=inttostr(CurrentPage);
     Label2.Caption := Format('of %d',[PrintPreview.TotalPages]);
     Label2.Update;
     ToolButton6.Enabled := (PrintPreview.CurrentPage > 1);
     ToolButton7.Enabled := (PrintPreview.CurrentPage > 1);
     ToolButton8.Enabled := (PrintPreview.CurrentPage < PrintPreview.TotalPages);
     ToolButton9.Enabled := (PrintPreview.CurrentPage < PrintPreview.TotalPages);
  end
  else
    PageEdit.Text:='';
end;

procedure TPrntPreviewForm.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0: PrintPreview.Zoom := 25;
    1: PrintPreview.Zoom := 50;
    2: PrintPreview.Zoom := 75;
    3: PrintPreview.Zoom := 100;
    4: PrintPreview.Zoom := 150;
    5: PrintPreview.Zoom := 200;
    6: PrintPreview.Zoom := 300;
    7: PrintPreview.ZoomState := zsZoomToWidth;
    8: PrintPreview.ZoomState := zsZoomToHeight;
    9: PrintPreview.ZoomState := zsZoomToFit;
  end;
  SetZoomButtons;
  ActiveControl := PrintPreview;
end;

procedure TPrntPreviewForm.ToolButton8Click(Sender: TObject);
begin
  if (PrintPreview.CurrentPage<PrintPreview.TotalPages) then
   begin
    PrintPreview.CurrentPage:=PrintPreview.CurrentPage+1;
    ActiveControl := PrintPreview;
   end;
end;

procedure TPrntPreviewForm.ToolButton9Click(Sender: TObject);
begin
 if PrintPreview.CurrentPage<PrintPreview.TotalPages then
   begin
    PrintPreview.CurrentPage:=PrintPreview.TotalPages;
    ActiveControl := PrintPreview;
   end;
end;

procedure TPrntPreviewForm.ToolButton7Click(Sender: TObject);
begin
  if PrintPreview.CurrentPage>1 then
   begin
    PrintPreview.CurrentPage:=PrintPreview.CurrentPage-1;
    ActiveControl := PrintPreview;
   end;
end;

procedure TPrntPreviewForm.ToolButton6Click(Sender: TObject);
begin
  if PrintPreview.CurrentPage>1 then
   begin
    PrintPreview.CurrentPage:=1;
    ActiveControl := PrintPreview;
   end;
end;

procedure TPrntPreviewForm.ToolButton11Click(Sender: TObject);
var
 i,oldZoom,oldindex: integer;
begin
 oldZoom:=PrintPreview.Zoom;
 oldIndex:=0;
 for i:=0 to 6 do if oldzoom>=zoomrange[i] then oldIndex:=i;
  if oldIndex<6 then
   begin
    combobox1.ItemIndex:=oldIndex+1;
    ComboBox1Change(Self);
   end;
end;

procedure TPrntPreviewForm.ToolButton12Click(Sender: TObject);
var
 i,oldZoom,oldindex: integer;
begin
 oldZoom:=PrintPreview.Zoom;
 oldIndex:=6;
 for i:=6 downto 0 do if oldzoom<=zoomrange[i] then oldIndex:=i;
  if oldIndex>0 then
   begin
    combobox1.ItemIndex:=oldIndex-1;
    ComboBox1Change(Self);
   end;
end;

procedure TPrntPreviewForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 PreviewOn:=false;
 PreviewFont.Free;
end;

procedure TPrntPreviewForm.PreviewSetupPageExecute(Sender: TObject);
begin
 if Mainform.PrintSetupDialog.execute then
  if SetPageSizes then CreatePages;
end;

procedure TPrntPreviewForm.PreviewPrintExecute(Sender: TObject);
begin
 printOurWindow(PreviewWin);
 ActiveControl := PrintPreview;
end;

procedure TPrntPreviewForm.PageEditKeyPress(Sender: TObject; var Key: Char);
var
 mypage: integer;
begin
 if key=chr(13) then
  begin
   mypage:=strtointdef(PageEdit.text,0);
   if (mypage>0) and (mypage<=PrintPreview.TotalPages)
     and (mypage<>PrintPreview.CurrentPage) then
       begin
        PrintPreview.CurrentPage:=mypage;
        ActiveControl := PrintPreview;
        pageEdit.SelectAll;
        PageEdit.SetFocus;
       end;
  end;
end;



procedure TPrntPreviewForm.Button2Click(Sender: TObject);
begin
Application.HelpCommand(HELP_CONTEXT,136);
end;

end.
