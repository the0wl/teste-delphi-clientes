unit controllerDocument;

interface

uses
  classDocument,
  uEnums;

type
  TDocumentController = class
  private
    FDocumentModel: TDocument;

    function GetDocumentModel: TDocument;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadDocument(const pClientType: TClientType;
      const pState: TDocumentType; const pDocumentId: string);

    property Document: TDocument read GetDocumentModel;
  end;

implementation

{ TDocumentController }

constructor TDocumentController.Create;
begin
  inherited;
  FDocumentModel := TDocument.Create;
end;

destructor TDocumentController.Destroy;
begin
  FDocumentModel.Free;
  inherited;
end;

function TDocumentController.GetDocumentModel: TDocument;
begin
  Result := TDocument(FDocumentModel.Clone);
end;

procedure TDocumentController.LoadDocument(const pClientType: TClientType;
  const pState: TDocumentType; const pDocumentId: string);
begin
  FDocumentModel.DType      := pState;
  FDocumentModel.ClientType := pClientType;
  FDocumentModel.Identifier := pDocumentId;
end;

end.
