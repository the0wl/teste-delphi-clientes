unit classDocument;

interface

uses interfaceDocument, uEnums;

type
  TDocument = class(TInterfacedObject, IDocument)
  private
    FType              : TDocumentType;
    FIdentifier        : string;
    FClientType        : TClientType;
    FDocumentName      : TDocumentName;
    FFormatedIdentifier: string;

    procedure SetType              (const pValue: TDocumentType);
    procedure SetIdentifier        (const pValue: string);
    procedure SetClientType        (const pValue: TClientType);
    procedure SetDocumentName      (const pValue: TDocumentName);
    procedure SetFormatedIdentifier;

    function GetType              : TDocumentType;
    function GetIdentifier        : string;
    function GetClientType        : TClientType;
    function GetFormatedIdentifier: string;
    function GetDocumentName      : TDocumentName;

    function GetLegalPersonDocumentName  : TDocumentName;
    function GetNaturalPersonDocumentName: TDocumentName;
  public
    function Clone: TDocument;

    property DType             : TDocumentType read GetType               write SetType;
    property Identifier        : string        read GetIdentifier         write SetIdentifier;
    property ClientType        : TClientType   read GetClientType         write SetClientType;
    property DocumentName      : TDocumentName read GetDocumentName       write SetDocumentName;
    property FormatedIdentifier: string        read GetFormatedIdentifier;
  end;

implementation

uses
  System.SysUtils, uFormat;

{ TDocument }

function TDocument.Clone: TDocument;
begin
  Result                     := TDocument.Create;
  Result.FType               := FType;
  Result.FIdentifier         := FIdentifier;
  Result.FClientType         := FClientType;
  Result.FDocumentName       := FDocumentName;
  Result.FFormatedIdentifier := FFormatedIdentifier;
end;

function TDocument.GetClientType: TClientType;
begin
  Result := FClientType;
end;

function TDocument.GetDocumentName: TDocumentName;
begin
  Result := FDocumentName;
end;

function TDocument.GetFormatedIdentifier: String;
begin
  Result := FFormatedIdentifier;
end;

function TDocument.GetIdentifier: String;
begin
  Result := FIdentifier;
end;

function TDocument.GetLegalPersonDocumentName: TDocumentName;
begin
  case FType of
    dtpState   : Result := dnaIE;
    dtpNational: Result := dnaCNPJ;
  else
    raise Exception.Create('Document error: Unknown legal person document.');
  end;
end;

function TDocument.GetNaturalPersonDocumentName: TDocumentName;
begin
  case FType of
    dtpState   : Result := dnaRG;
    dtpNational: Result := dnaCPF;
  else
    raise Exception.Create('Document error: Unknown natural person document.');
  end;
end;

function TDocument.GetType: TDocumentType;
begin
  Result := FType;
end;

procedure TDocument.SetClientType(const pValue: TClientType);
begin
  FClientType := pValue;
end;

procedure TDocument.SetDocumentName;
begin
  case FClientType of
    ctpLegalPerson  : FDocumentName := getLegalPersonDocumentName;
    ctpNaturalPerson: FDocumentName := getNaturalPersonDocumentName;
  else
    raise Exception.Create('Document error: Unknown document.');
  end;
end;

procedure TDocument.SetFormatedIdentifier;
begin
  FFormatedIdentifier := FormatDocument(FDocumentName, FIdentifier);
end;

procedure TDocument.SetIdentifier(const pValue: string);
begin
  FIdentifier := pValue;
  setFormatedIdentifier;
end;

procedure TDocument.SetType(const pValue: TDocumentType);
begin
  FType := pValue;
end;

end.
