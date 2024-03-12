unit classClient;

interface

uses
  Generics.Collections,
  interfaceClient,
  uEnums,
  classDocument,
  classPhone,
  classAddress;

type
  TClient = class(TInterfacedObject, IClient)
  private
    FIdentifier      : Integer;
    FFullName        : String;
    FClientType      : TClientType;
    FStateDocument   : TDocument;
    FNationalDocument: TDocument;
    FCreatedAt       : TDateTime;
    FActive          : Boolean;
    FPhones          : TList<TPhone>;
    FAddress         : TAddress;

    procedure SetIdentifier      (const pValue: Integer);
    procedure SetFullName        (const pValue: string);
    procedure SetClientType      (const pValue: TClientType);
    procedure SetStateDocument   (const pValue: TDocument);
    procedure SetNationalDocument(const pValue: TDocument);
    procedure SetCreatedAt       (const pValue: TDateTime);
    procedure SetActive          (const pValue: Boolean);
    procedure SetPhones          (const pValue: TList<TPhone>);
    procedure SetAddress         (const pValue: TAddress);

    function GetIdentifier      : Integer;
    function GetFullName        : String;
    function GetClientType      : TClientType;
    function GetStateDocument   : TDocument;
    function GetNationalDocument: TDocument;
    function GetCreatedAt       : TDateTime;
    function GetActive          : Boolean;
    function GetPhones          : TList<TPhone>;
    function GetAddress         : TAddress;
  public
    constructor Create;
    destructor Destroy; override;

    function Clone: TClient;

    property Identifier      : Integer       read GetIdentifier       write SetIdentifier;
    property FullName        : String        read GetFullName         write SetFullName;
    property ClientType      : TClientType   read GetClientType       write SetClientType;
    property StateDocument   : TDocument     read GetStateDocument    write SetStateDocument;
    property NationalDocument: TDocument     read GetNationalDocument write SetNationalDocument;
    property CreatedAt       : TDateTime     read GetCreatedAt        write SetCreatedAt;
    property isActive        : Boolean       read GetActive           write SetActive;
    property Phones          : TList<TPhone> read GetPhones           write SetPhones;
    property Address         : TAddress      read GetAddress          write SetAddress;
  end;

implementation

uses
  SysUtils,
  DateUtils;

{ TClient }

function TClient.Clone: TClient;
var
  phoItem: TPhone;
begin
  Result                   := TClient.Create;
  Result.FIdentifier       := FIdentifier;
  Result.FFullName         := FFullName;
  Result.FClientType       := FClientType;
  Result.FStateDocument    := TDocument(FStateDocument.Clone);
  Result.FNationalDocument := TDocument(FNationalDocument.Clone);
  Result.FCreatedAt        := FCreatedAt;
  Result.FActive           := FActive;
  Result.FPhones           := TList<TPhone>.Create;

  for phoItem in FPhones do
    Result.FPhones.Add(phoItem.Clone);

  Result.FAddress := TAddress(FAddress.Clone);
end;

constructor TClient.Create;
begin
  inherited;

  FIdentifier       := -1;
  FFullName         := '';
  FClientType       := ctpNaturalPerson;
  FStateDocument    := TDocument.Create;
  FNationalDocument := TDocument.Create;
  FCreatedAt        := Now;
  FActive           := True;
  FPhones           := TList<TPhone>.Create;
  FAddress          := TAddress.Create;
end;

destructor TClient.Destroy;
var
  i: Integer;
begin
  if Assigned(FStateDocument) then FStateDocument.Free;
  if Assigned(FNationalDocument) then FNationalDocument.Free;

  if Assigned(FPhones) then
  begin
    for i := 0 to FPhones.Count - 1 do
    begin
      TObject(FPhones[i]).Free;
    end;

    FPhones.Free;
  end;

  inherited;
end;

function TClient.getFullName: String;
begin
  Result := FFullName;
end;

function TClient.getIdentifier: Integer;
begin
  Result := FIdentifier;
end;

function TClient.getNationalDocument: TDocument;
begin
  Result := FNationalDocument;
end;

function TClient.getPhones: TList<TPhone>;
begin
  Result := FPhones;
end;

function TClient.getStateDocument: TDocument;
begin
  Result := FStateDocument;
end;

procedure TClient.SetActive(const pValue: Boolean);
begin
  FActive := pValue;
end;

procedure TClient.SetAddress(const pValue: TAddress);
begin
  FAddress := pValue;
end;

procedure TClient.SetClientType(const pValue: TClientType);
begin
  FClientType := pValue;
end;

procedure TClient.SetCreatedAt(const pValue: TDateTime);
begin
  FCreatedAt := pValue;
end;

procedure TClient.SetFullName(const pValue: string);
begin
  FFullName := pValue;
end;

procedure TClient.SetIdentifier(const pValue: Integer);
begin
  FIdentifier := pValue;
end;

procedure TClient.SetNationalDocument(const pValue: TDocument);
begin
  FNationalDocument := pValue;
end;

procedure TClient.SetPhones(const pValue: TList<TPhone>);
var
  phoItem: TPhone;
begin
  FPhones := TList<TPhone>.Create;

  for phoItem in pValue do
    FPhones.Add(phoItem.Clone);
end;

procedure TClient.SetStateDocument(const pValue: TDocument);
begin
  FStateDocument := pValue;
end;

function TClient.getActive: Boolean;
begin
  Result := FActive;
end;

function TClient.getAddress: TAddress;
begin
  Result := FAddress;
end;

function TClient.getClientType: TClientType;
begin
  Result := FClientType;
end;

function TClient.getCreatedAt: TDateTime;
begin
  Result := FCreatedAt;
end;

end.
