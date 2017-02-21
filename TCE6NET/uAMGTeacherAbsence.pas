unit uAMGTeacherAbsence;

interface

uses
  Contnrs;

type
  TAMGTeacherAbsence = class
  private
    FTeacherID: Integer;
    FAbsence: string;
    FAbsenceDate: TDateTime;
    FAbsenceReasonID: Integer;
    FTeacherCode: string;
    FAbsenceReasonCode: string;
    FTeacherName: string;
  public
    property TeacherID: Integer read FTeacherID write FTeacherID;
    property TeacherCode: string read FTeacherCode write FTeacherCode;
    property TeacherName: string read FTeacherName write FTeacherName;  //Move to Teacher object once created
    property AbsenceDate: TDateTime read FAbsenceDate write FAbsenceDate;
    property Absence: string read FAbsence write FAbsence;
    property AbsenceReasonID: Integer read FAbsenceReasonID write FAbsenceReasonID;
    property AbsenceReasonCode: string read FAbsenceReasonCode write FAbsenceReasonCode;
  end;

  TAMGTeacherAbsences = class(TObjectList)
  public
    function RefreshFromFile: Boolean;
    function SaveToFile: Boolean;
    function GetAnsenceIndex(const pTeacherCode: string; pDate: TDateTime): Integer;
  end;

var
  TeacherAbsences: TAMGTeacherAbsences;

implementation

uses
  Classes, SysUtils, DCPrijndael, DCPSha1, uAMGConst, uAMGCommon, DateUtils;

{ TAMGTecaherAbsences }

function TAMGTeacherAbsences.GetAnsenceIndex(const pTeacherCode: string; pDate: TDateTime): Integer;
var
  i: Integer;
begin
 Result := -1;
  for i := 0 to Self.Count - 1 do
  begin
    if (TAMGTeacherAbsence(Self.Items[i]).FTeacherCode = Trim(pTeacherCode)) and
       (TAMGTeacherAbsence(Self.Items[i]).FAbsenceDate = DateOf(pDate)) then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TAMGTeacherAbsences.RefreshFromFile: Boolean;
//Teacher Addresses only at this stage, the rest of the details need also to be done here
var
  lTempList: TStringList;
  Cipher: TDCP_Rijndael;
  i: Integer;
  lCode: string;
  lTeacherAbsence: TAMGTeacherAbsence;
begin
  Result := False;
  Self.Clear;
  if FileExists(AMG_TE_ABSENCE_HISTORY_FILE) then
  begin
    lTempList := TStringList.Create;
    Cipher:= TDCP_Rijndael.Create(nil);
    try
      lTempList.LoadFromFile(AMG_TE_ABSENCE_HISTORY_FILE);
      //decrypt string
      Cipher.InitStr(KeyStrRt,TDCP_sha1);   // initialize the cipher with a hash of the passphrase
      lTempList.Text := Cipher.DecryptString(lTempList.Text);
      Cipher.Burn;
      //Retrieve strings
      for i := 0 to lTempList.Count - 1 do
      begin
        lTeacherAbsence := TAMGTeacherAbsence.Create;
        lTeacherAbsence.FTeacherCode := Trim(GetSubStr(lTempList.Strings[i], 1, '|'));
        lTeacherAbsence.FTeacherName := GetSubStr(lTempList.Strings[i], 2, '|');
        lTeacherAbsence.FAbsenceDate := StrToDateTime(GetSubStr(lTempList.Strings[i], 3, '|'));
        lTeacherAbsence.FAbsence := GetSubStr(lTempList.Strings[i], 4, '|');
        lTeacherAbsence.FAbsenceReasonCode := GetSubStr(lTempList.Strings[i], 5, '|');
        Self.Add(lTeacherAbsence);
      end;
    finally
      if Assigned(lTempList) then
        FreeAndNil(lTempList);
      if Assigned(Cipher) then
        FreeAndNil(Cipher);
    end;
  end;
  Result := True;
end;

function TAMGTeacherAbsences.SaveToFile: Boolean;
var
  lTempList: TStringList;
  Cipher: TDCP_Rijndael;
  i: Integer;
  lTeacherAbsence: TAMGTeacherAbsence;
begin
  lTempList := TStringList.Create;
  Cipher := TDCP_Rijndael.Create(nil);
  try
    for i := 0 to Self.Count -1 do
    begin
      lTeacherAbsence := TAMGTeacherAbsence(Self.Items[i]);
      lTempList.Add(lTeacherAbsence.FTeacherCode + '|' +
                    lTeacherAbsence.FTeacherName + '|' +
                    DateTimeToStr(lTeacherAbsence.FAbsenceDate) + '|' +
                    lTeacherAbsence.FAbsence + '|' +
                    lTeacherAbsence.AbsenceReasonCode);
    end;
    {encrypt}
    Cipher.InitStr(KeyStrRt, TDCP_sha1);         // initialize the cipher with a hash of the passphrase
    lTempList.Text := Cipher.EncryptString(lTempList.Text);
    Cipher.Burn;
    lTempList.SaveToFile(AMG_TE_ABSENCE_HISTORY_FILE);
  finally
    if Assigned(Cipher) then
      FreeAndNil(Cipher);
    if Assigned(lTempList) then
      FreeAndNil(lTempList);
  end;
end;

end.
