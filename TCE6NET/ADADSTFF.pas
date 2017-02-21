unit Adadstff;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,TCEglobals, ComCtrls, GlobalToTcAndTcextra;

type
  TAddAddedStaff = class(TForm)
    GroupBox1: TGroupBox;
    btnClose: TBitBtn;
    update: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    edtAddedStaffCode: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    cboFaculty: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cboFaculty2: TComboBox;
    cboFaculty3: TComboBox;
    cboFaculty4: TComboBox;
    Memo1: TMemo;
    Label8: TLabel;
    edtPhone: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    chkSun: TCheckBox;
    chkSat: TCheckBox;
    chkFri: TCheckBox;
    chkThu: TCheckBox;
    chkWed: TCheckBox;
    chkTue: TCheckBox;
    chkMon: TCheckBox;
    Label17: TLabel;
    edtPriority: TEdit;
    UpDown1: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure CreateAddedeStaff(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    NeedUpdate: Boolean;
    function IsValid(const pAddedStaffNo: Integer): Boolean;
  end;

var
  AddAddedStaff: TAddAddedStaff;

implementation

uses
  tcommon, tcommon2, addstaff, tcommon3, tcommon4, uAMGConst;

{$R *.DFM}

procedure TAddAddedStaff.FormCreate(Sender: TObject);
var
  i: Integer;
begin
 TopCentre(Self);
 edtAddedStaffCode.Text := ''; edit2.Text := ''; memo1.Text := '';
 edtAddedStaffCode.MaxLength := ETLencodes;
 edit2.MaxLength := szTeName;
 //edit3.MaxLength := szEcomment;

 cboFaculty.Clear;
 cboFaculty2.Clear;
 cboFaculty3.Clear;
 cboFaculty4.Clear;
 cboFaculty.Items.Add('All faculties');
 cboFaculty2.Items.Add('All faculties');
 cboFaculty3.Items.Add('All faculties');
 cboFaculty4.Items.Add('All faculties');
 cboFaculty.Items.Add('None');
 cboFaculty2.Items.Add('None');
 cboFaculty3.Items.Add('None');
 cboFaculty4.Items.Add('None');
 if facnum>0 then
  for i:=1 to facnum do begin
   cboFaculty.Items.Add(facname[i]);
   cboFaculty2.Items.Add(facname[i]);
   cboFaculty3.Items.Add(facname[i]);
   cboFaculty4.Items.Add(facname[i]);
  end;
 cboFaculty.ItemIndex := 0;
 cboFaculty2.ItemIndex := 0;
 cboFaculty3.ItemIndex := 0;
 cboFaculty4.ItemIndex := 0;
 edtPhone.Text := '';
 chkMon.Checked := false;
 chkTue.Checked := false;
 chkWed.Checked := false;
 chkThu.Checked := false;
 chkFri.Checked := false;
 chkSat.Checked := false;
 chkSun.Checked := false;
 edtPriority.Text := '1';
 label6.Caption := IntToStr(ETnum1);
 NeedUpdate := False;
end;

function TAddAddedStaff.IsValid(const pAddedStaffNo: Integer): Boolean;
var
  msg: string;
  lStr: string;
begin
  Result := True;
  lStr := Copy(Trim(edtAddedStaffCode.Text), 1, 2);
  if pAddedStaffNo > 0 then
  begin
    msg := 'This code is already in use by ' + ETname[pAddedStaffNo]+endline + 'Please try another code.';
    MessageDlg(msg, mtError, [mbOK], 0);
    if edtAddedStaffCode.Enabled and edtAddedStaffCode.Visible then
    begin
      edtAddedStaffCode.SelectAll;
      edtAddedStaffCode.SetFocus;
    end;
    Result := False;
  end
  else if FindTutor2(Trim(edtAddedStaffCode.Text)) > 0 then
  begin
    msg := Format(AMG_STAFF_MEMBER_ALREADY_EXISTS_MSG, [edtAddedStaffCode.Text]) ;
    MessageDlg(msg, mtError, [mbOK], 0);
    if edtAddedStaffCode.Enabled and edtAddedStaffCode.Visible then
    begin
      edtAddedStaffCode.SelectAll;
      edtAddedStaffCode.SetFocus;
    end;
    Result := False;
  end
  else if lStr = '00' then
  begin
     msg := '00 codes used for deletions' + endline;
     msg := msg + 'Please try another code.';
     MessageDlg(msg, mtError, [mbOK],0);
    if edtAddedStaffCode.Enabled and edtAddedStaffCode.Visible then
    begin
       edtAddedStaffCode.SelectAll;
       edtAddedStaffCode.SetFocus;
    end;
     Result := False;
  end
  else if Trim(edtAddedStaffCode.Text) = '' then
  begin
    msg := 'No code entered.';
    MessageDlg(msg,mtError, [mbOK],0);
    if edtAddedStaffCode.Enabled and edtAddedStaffCode.Visible then
    begin
      edtAddedStaffCode.SelectAll;
      edtAddedStaffCode.SetFocus;
    end;
    Result := False;
  end;
end;

procedure TAddAddedStaff.CreateAddedeStaff(Sender: TObject);
var
  msg,b: string;
  i,j: Integer;
begin
  i:=etpointer[findaddedstaff(edtAddedStaffCode.Text)];
  if IsValid(i) then
  begin
    i:=Etnum+1;
    for j:=1 to ETnum do
    begin
     b:=copy(Trim(etsub[j]),1,2);
     if b='00' then
     begin
      i:=j; break;
     end;
    end; {for j}
    if i>nmbrAddedTeachers then
    begin
     msg:='Maximum number of added teachers is '+inttostr(nmbrAddedTeachers)+endline;
     msg:=msg+'There is no room to add another teacher at this time.';
     messagedlg(msg,mtError,[mbOK],0);
     exit;
    end;

    if i=Etnum+1 then
     begin Etnum:=i; SetLength(ETmail,ETnum+1); end;
    etsub[i]:=uppercase(Trim(edtAddedStaffCode.Text)); ETname[i]:=Trim(edit2.text);
    ETmail[i]:='';
    Etcomment[i]:=Trim(memo1.text);
    ETfaculty[i]:=findfac(cboFaculty.Text);
    if (ETfaculty[i]=-1) or (cboFaculty.ItemIndex = 1) then ETfaculty[i]:=0;
    if ((cboFaculty.ItemIndex = 0) or
       (uppercase(Trim(cboFaculty.Text))='*') or
       (uppercase(Trim(cboFaculty.Text))='ALL FACULTIES')) then
         ETfaculty[i]:=-1;
    ETfaculty2[i]:=findfac(cboFaculty2.Text);
    if (ETfaculty2[i]=-1) or (cboFaculty2.ItemIndex = 1) then ETfaculty2[i]:=0;
    if ((cboFaculty2.ItemIndex = 0) or
       (uppercase(Trim(cboFaculty2.Text))='*') or
       (uppercase(Trim(cboFaculty2.Text))='ALL FACULTIES')) then
         ETfaculty2[i]:=-1;
    ETfaculty3[i]:=findfac(cboFaculty3.Text);
    if (ETfaculty3[i]=-1) or (cboFaculty3.ItemIndex = 1) then ETfaculty3[i]:=0;
    if ((cboFaculty3.ItemIndex = 0) or
       (uppercase(Trim(cboFaculty3.Text))='*') or
       (uppercase(Trim(cboFaculty3.Text))='ALL FACULTIES')) then
         ETfaculty3[i]:=-1;
    ETfaculty4[i]:=findfac(cboFaculty4.Text);
    if (ETfaculty4[i]=-1) or (cboFaculty4.ItemIndex = 1) then ETfaculty4[i]:=0;
    if ((cboFaculty4.ItemIndex = 0) or
       (uppercase(Trim(cboFaculty4.Text))='*') or
       (uppercase(Trim(cboFaculty4.Text))='ALL FACULTIES')) then
         ETfaculty4[i]:=-1;

     // #173
     ETPhone[i] := edtPhone.Text;
     try
       ETPriority[i] := strtoint(edtPriority.Text);
     except
       ETPriority[i] := 1;
     end;
     if (chkMon.Checked) then begin
       ETMon[i] := 1;
     end else begin
       ETMon[i] := 0;
     end;
     if (chkTue.Checked) then begin
       ETTue[i] := 1;
     end else begin
       ETTue[i] := 0;
     end;
     if (chkWed.Checked) then begin
       ETWed[i] := 1;
     end else begin
       ETWed[i] := 0;
     end;
     if (chkThu.Checked) then begin
       ETThu[i] := 1;
     end else begin
       ETThu[i] := 0;
     end;
     if (chkFri.Checked) then begin
       ETFri[i] := 1;
     end else begin
       ETFri[i] := 0;
     end;
     if (chkSat.Checked) then begin
       ETSat[i] := 1;
     end else begin
       ETSat[i] := 0;
     end;
     if (chkSun.Checked) then begin
       ETSun[i] := 1;
     end else begin
       ETSun[i] := 0;
     end;

    Ettaught[i]:=0;
     etsort2;   etsort3;   updateTelink;
    label6.caption:=inttostr(ETnum1);
    getAddedStaffFontWidths;
    UpdateExtrasWins;

    edtAddedStaffCode.Text := ''; edit2.Text := ''; memo1.Text := ''; edtAddedStaffCode.SetFocus;
    cboFaculty.ItemIndex := 0;
    cboFaculty2.ItemIndex := 0;
    cboFaculty3.ItemIndex := 0;
    cboFaculty4.ItemIndex := 0;
    edtPhone.Text := '';
    chkMon.Checked := false;
    chkTue.Checked := false;
    chkWed.Checked := false;
    chkThu.Checked := false;
    chkFri.Checked := false;
    chkSat.Checked := false;
    chkSun.Checked := false;
    edtPriority.Text := '1';
    NeedUpdate := True;
  end;
end;

procedure TAddAddedStaff.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if needupdate then etout;
end;

end.
