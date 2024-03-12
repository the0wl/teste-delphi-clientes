unit uIIF;

interface

function IIF(pCondition: Boolean; pValue1, pValue2: variant): variant;

implementation

function iif(pCondition: Boolean; pValue1, pValue2: variant): variant;
begin
  if (pCondition) then
    Result := pValue1
  else
    Result := pValue2;
end;

end.
