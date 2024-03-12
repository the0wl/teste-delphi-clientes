unit interfaceClient;

interface

uses
  Generics.Collections,
  uEnums,
  classDocument,
  classPhone,
  classAddress;

type
  IClient = interface
    ['{4D3E96C5-474D-4887-AA83-03D44D28C208}']

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

    property Identifier      : Integer       read GetIdentifier;
    property FullName        : String        read GetFullName;
    property ClientType      : TClientType   read GetClientType;
    property StateDocument   : TDocument     read GetStateDocument;
    property NationalDocument: TDocument     read GetNationalDocument;
    property CreatedAt       : TDateTime     read GetCreatedAt;
    property isActive        : Boolean       read GetActive;
    property Phones          : TList<TPhone> read GetPhones;
    property Address         : TAddress      read GetAddress;
  end;

implementation

end.
