unit classPhone;

interface

uses
  interfacePhone;

type TPhone = class(TInterfacedObject, IPhone)
  private
    FId         : Integer;
    FClientID   : Integer;
    FDDD        : string;
    FNumber     : string;

    function getId      : Integer;
    function getClientId: Integer;
    function getDDD     : string;
    function getNumber  : string;
  public
    constructor Create(const pId: Integer; const pClientId: Integer;
      const pDDD: string; const pNumber: string); overload;
    constructor Create(const pClientId: Integer; const pDDD: string;
      const pNumber: string); overload;
    destructor Destroy; override;

    function Clone: TPhone;

    property Id      : Integer read getId;
    property ClientId: Integer read getClientId;
    property DDD     : string  read getDDD;
    property Number  : string  read getNumber;
  end;

implementation

{ TPhone }

function TPhone.Clone: TPhone;
begin
  Result           := TPhone.Create;
  Result.FId       := FId;
  Result.FClientID := FClientID;
  Result.FDDD      := FDDD;
  Result.FNumber   := FNumber;
end;

constructor TPhone.Create(const pId: Integer; const pClientId: Integer;
  const pDDD: string; const pNumber: string);
begin
  FId         := pId;
  FClientId   := pClientId;
  FDDD        := pDDD;
  FNumber     := pNumber;
end;

constructor TPhone.Create(const pClientId: Integer; const pDDD: string;
  const pNumber: string);
begin
  FId       := -1;
  FClientID := pClientId;
  FDDD      := pDDD;
  FNumber   := pNumber;
end;

destructor TPhone.Destroy;
begin
  inherited;
end;

function TPhone.getClientId: Integer;
begin
  Result := FClientId;
end;

function TPhone.getDDD: string;
begin
  Result := FDDD;
end;

function TPhone.getId: Integer;
begin
  Result := FId;
end;

function TPhone.getNumber: string;
begin
  Result := FNumber;
end;

end.
