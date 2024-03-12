unit classAddress;

interface

uses
  interfaceAddress;

type TAddress = class(TInterfacedObject, IAddress)
  private
    FId           : Integer;
    FClientID     : Integer;
    FPublicPlace  : string;
    FAddressNumber: string;
    FZipCode      : string;
    FDistrict     : string;
    FCity         : string;
    FState        : string;
    FCountry      : string;

    procedure SetId           (const pValue: Integer);
    procedure SetClientId     (const pValue: Integer);
    procedure SetPublicPlace  (const pValue: string);
    procedure SetAddressNumber(const pValue: string);
    procedure SetZipCode      (const pValue: string);
    procedure SetDistrict     (const pValue: string);
    procedure SetCity         (const pValue: string);
    procedure SetState        (const pValue: string);
    procedure SetCountry      (const pValue: string);

    function GetId           : Integer;
    function GetClientId     : Integer;
    function GetPublicPlace  : string;
    function GetAddressNumber: string;
    function GetZipCode      : string;
    function GetDistrict     : string;
    function GetCity         : string;
    function GetState        : string;
    function GetCountry      : string;
  public
    constructor Create; overload;
    constructor Create(const pClientId: Integer; pZipCode: string); overload;

    function Clone: TAddress;

    property Id           : Integer read GetId            write SetId;
    property ClientId     : Integer read GetClientId      write SetClientId;
    property PublicPlace  : string  read GetPublicPlace   write SetPublicPlace;
    property AddressNumber: string  read GetAddressNumber write SetAddressNumber;
    property ZipCode      : string  read GetZipCode       write SetZipCode;
    property District     : string  read GetDistrict      write SetDistrict;
    property City         : string  read GetCity          write SetCity;
    property State        : string  read GetState         write SetState;
    property Country      : string  read GetCountry       write SetCountry;
  end;

implementation

{ TAddress }

function TAddress.Clone: TAddress;
begin
  Result                := TAddress.Create;
  Result.FId            := FId;
  Result.FClientID      := FClientID;
  Result.FPublicPlace   := FPublicPlace;
  Result.FAddressNumber := FAddressNumber;
  Result.FZipCode       := FZipCode;
  Result.FDistrict      := FDistrict;
  Result.FCity          := FCity;
  Result.FState         := FState;
  Result.FCountry       := FCountry;
end;

constructor TAddress.Create(const pClientId: Integer; pZipCode: string);
begin
  FId            := -1;
  FClientId      := pClientId;
end;

constructor TAddress.Create;
begin
  inherited;
end;

function TAddress.getAddressNumber: string;
begin
  Result := FAddressNumber;
end;

function TAddress.getCity: string;
begin
  Result := FCity;
end;

function TAddress.getCountry: string;
begin
  Result := FCountry;
end;

function TAddress.getDistrict: string;
begin
  Result := FDistrict;
end;

function TAddress.getPublicPlace: string;
begin
  Result := FPublicPlace;
end;

function TAddress.getState: string;
begin
  Result := FState;
end;

function TAddress.getZipCode: string;
begin
  Result := FZipCode;
end;

procedure TAddress.SetAddressNumber(const pValue: string);
begin
  FAddressNumber := pValue;
end;

procedure TAddress.SetCity(const pValue: string);
begin
  FCity := pValue;
end;

procedure TAddress.SetClientId(const pValue: Integer);
begin
  FClientId := pValue;
end;

procedure TAddress.SetCountry(const pValue: string);
begin
  FCountry := pValue;
end;

procedure TAddress.SetDistrict(const pValue: string);
begin
  FDistrict := pValue;
end;

procedure TAddress.SetId(const pValue: Integer);
begin
  FId := pValue;
end;

procedure TAddress.SetPublicPlace(const pValue: string);
begin
  FPublicPlace := pValue;
end;

procedure TAddress.SetState(const pValue: string);
begin
  FState := pValue;
end;

procedure TAddress.SetZipCode(const pValue: string);
begin
  FZipCode := pValue;
end;

function TAddress.getId: Integer;
begin
  Result := FId;
end;

function TAddress.getClientId: Integer;
begin
  Result := FClientId;
end;

end.
