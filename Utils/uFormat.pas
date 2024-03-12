unit uFormat;

interface

uses
  uEnums;

function FormatCPF    (pValue: string)   : string;
function FormatCNPJ   (pValue: string)   : string;
function FormatRG     (pValue: string)   : string;
function FormatIE     (pValue: string)   : string;
function FormatZipCode(pValue: string)   : string;
function FormatDate   (pValue: TDateTime): string;

function RemoveNonNumericChars(pValue: string): string;

function FormatDocument(const pDocumentName: TDocumentName; const pValue: string): string;

implementation

uses
  System.SysUtils;

function formatDocument(const pDocumentName: TDocumentName;
  const pValue: String): string;
begin
  case pDocumentName of
    dnaCPF : Result := FormatCPF(pValue);
    dnaCNPJ: Result := FormatCNPJ(pValue);
    dnaRG  : Result := FormatRG(pValue);
    dnaIE  : Result := FormatRG(pValue);
    else
      Result := pValue;
  end;
end;

function FormatCPF(pValue: string): string;
begin
  pValue := StringReplace(pValue, '.', '', [rfReplaceAll]);
  pValue := StringReplace(pValue, '-', '', [rfReplaceAll]);

  if Length(pValue) >= 3 then
    Insert('.', pValue, 4);
  if Length(pValue) >= 7 then
    Insert('.', pValue, 8);
  if Length(pValue) >= 11 then
    Insert('-', pValue, 12);

  Result := pValue;
end;

function FormatCNPJ(pValue: string): string;
begin
  pValue := RemoveNonNumericChars(pValue);

  if Length(pValue) >= 2 then
    Insert('.', pValue, 3);
  if Length(pValue) >= 6 then
    Insert('.', pValue, 7);
  if Length(pValue) >= 10 then
    Insert('/', pValue, 11);
  if Length(pValue) >= 15 then
    Insert('-', pValue, 16);

  Result := pValue;
end;

function FormatIE(pValue: string): string;
begin
  pValue := RemoveNonNumericChars(pValue);

  if Length(pValue) >= 3 then
    Insert('.', pValue, 4);
  if Length(pValue) >= 7 then
    Insert('.', pValue, 8);
  if Length(pValue) >= 11 then
    Insert('.', pValue, 12);

  Result := pValue;
end;

function FormatRG(pValue: string): string;
begin
  pValue := RemoveNonNumericChars(pValue);

  if Length(pValue) >= 2 then
    Insert('.', pValue, 3);
  if Length(pValue) >= 6 then
    Insert('.', pValue, 7);
  if Length(pValue) >= 10 then
    Insert('-', pValue, 11);

  Result := pValue;
end;

function RemoveNonNumericChars(pValue: string): string;
begin
  pValue := StringReplace(pValue, '.', '', [rfReplaceAll]);
  pValue := StringReplace(pValue, '-', '', [rfReplaceAll]);
  pValue := StringReplace(pValue, '/', '', [rfReplaceAll]);
  Result := pValue;
end;

function FormatZipCode(pValue: string): string;
begin
  pValue := RemoveNonNumericChars(pValue);

  if Length(pValue) >= 5 then
    Insert('-', pValue, 6);

  Result := pValue;
end;

function FormatDate(pValue: TDateTime): string;
begin
  Result := FormatDatetime('dd/MM/YYYY', pValue);
end;

end.
