unit uJSONHelper;

interface

uses
  System.JSON;

type
  TJSONHelper = class helper for TJSONObject
    function GetString(const Key: string) : string;
    function GetInteger(const Key: string): Integer;
    function GetFloat(const Key: string)  : Double;
    function GetBoolean(const Key: string): Boolean;
  end;

implementation

uses
  SysUtils;

function TJSONHelper.GetString(const Key: string): string;
begin
  Result := GetValue(Key).Value;
end;

function TJSONHelper.GetInteger(const Key: string): Integer;
begin
  Result := StrToIntDef(GetValue(Key).Value, 0);
end;

function TJSONHelper.GetFloat(const Key: string): Double;
begin
  Result := StrToFloatDef(GetValue(Key).Value, 0);
end;

function TJSONHelper.GetBoolean(const Key: string): Boolean;
begin
  Result := StrToBoolDef(GetValue(Key).Value, False);
end;

end.

