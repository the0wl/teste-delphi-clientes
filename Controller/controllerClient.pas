unit controllerClient;

interface

uses
  Generics.Collections,
  classClient,
  classPhone,
  classAddress,
  frmDatabase,
  controllerDocument,
  controllerAddress,
  controllerPhone;

type
  TClientController = class
  private
    FClientModel               : TClient;
    FNationalDocumentController: TDocumentController;
    FStateDocumentController   : TDocumentController;
    FAddressController         : TAddressController;
    FPhoneController           : TPhoneController;

    procedure SetClientIdentifier;
    procedure SetClientFullName;
    procedure SetClientType;
    procedure SetClientStateDocument;
    procedure SetClientNationalDocument;
    procedure SetClientCreatedAt;
    procedure SetClientActive;
    procedure SetClientPhones;
    procedure SetClientAddress;

    function getNameFilter  (const pName: string)   : string;
    function getActiveFilter(const pActive: Boolean): string;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadClientFromDataset;
    procedure ApplyFiltersToDataset(const pName: string; const pActive: Boolean);

    procedure Delete;

    property Client: TClient read FClientModel;
  end;

implementation

uses
  System.SysUtils,
  uEnums,
  uIIF,
  FireDAC.Stan.Error,
  VCL.Dialogs;

{ TClientController }

procedure TClientController.LoadClientFromDataset;
begin
  SetClientIdentifier;
  SetClientFullName;
  SetClientType;
  SetClientStateDocument;
  SetClientNationalDocument;
  SetClientCreatedAt;
  SetClientActive;
  SetClientType;
  SetClientPhones;
  SetClientAddress;
end;

procedure TClientController.SetClientActive;
begin
  FClientModel.isActive := fDatabase.tbClients.FieldByName('ATIVO').AsInteger = 1;
end;

procedure TClientController.SetClientAddress;
begin
  FAddressController.LoadAddressFromDataset;
  FClientModel.Address := FAddressController.Address;
end;

procedure TClientController.SetClientCreatedAt;
begin
  fDatabase.tbClients.FieldByName('DATACADASTRO').AsDateTime;
end;

procedure TClientController.SetClientFullName;
begin
  FClientModel.FullName := fDatabase.tbClients.FieldByName('NOME').AsString;
end;

procedure TClientController.SetClientIdentifier;
begin
  FClientModel.Identifier := fDatabase.tbClients.FieldByName('ID').AsInteger;
end;

procedure TClientController.SetClientNationalDocument;
var
  pValue: string;
begin
  pValue := fDatabase.tbClients.FieldByName('CPF_CNPJ').AsString;
  FNationalDocumentController.LoadDocument(FClientModel.ClientType, dtpNational, pValue);
  FClientModel.NationalDocument := FNationalDocumentController.Document;
end;

procedure TClientController.SetClientPhones;
begin
  FPhoneController.LoadPhonesFromDataset;
  FClientModel.Phones := FPhoneController.Phones;
end;

procedure TClientController.SetClientStateDocument;
var
  pValue: string;
begin
  pValue := fDatabase.tbClients.FieldByName('RG_IE').AsString;
  FStateDocumentController.LoadDocument(FClientModel.ClientType, dtpState, pValue);
  FClientModel.StateDocument := FStateDocumentController.Document;
end;

procedure TClientController.SetClientType;
var
  ctpValue: TClientType;
begin
  ctpValue := IIF(
    fDatabase.dtsClients.DataSet.FieldByName('TIPO').AsString = 'F',
    ctpNaturalPerson,
    ctpLegalPerson
  );

  FClientModel.ClientType := ctpValue;
end;

procedure TClientController.ApplyFiltersToDataset(const pName: string;
  const pActive: Boolean);
var
  strFilter: String;
begin
  strFilter := getNameFilter(pName);
  strFilter := strFilter + IIF(strFilter <> '', ' AND ', '') + getActiveFilter(pActive);

  fDatabase.tbClients.Filtered := False;
  fDatabase.tbClients.Filter   := strFilter;
  fDatabase.tbClients.Filtered := True;

  fDatabase.dtsClients.DataSet.Refresh;
  fDatabase.dtsClients.DataSet.First;
end;

function TClientController.getNameFilter(const pName: string): string;
const
  pField = 'NOME';
begin
  Result := IIF(pName <> '', pField + ' LIKE ' + QuotedStr('%' + pName + '%'), '');
end;

function TClientController.getActiveFilter(const pActive: Boolean): string;
const
  pField = 'ATIVO';
begin
  Result := IIF(pActive, pField + ' = 1', '');
end;

constructor TClientController.Create;
begin
  FClientModel                := TClient.Create;
  FNationalDocumentController := TDocumentController.Create;
  FStateDocumentController    := TDocumentController.Create;
  FAddressController          := TAddressController.Create;
  FPhoneController            := TPhoneController.Create;
end;

procedure TClientController.Delete;
begin
  try
    fDatabase.dtsClients.DataSet.Delete;
  except
    on E: EFDDBEngineException do
    begin
      case E.Kind of
        ekObjNotExists: ShowMessage('Erro: O registro não existe mais.');
        else
          ShowMessage('Ocorreu um erro inesperado!');
      end;
    end;
  end;
end;

destructor TClientController.Destroy;
begin
  FNationalDocumentController.Free;
  FStateDocumentController.Free;
  FAddressController.Free;
  FPhoneController.Free;
  FClientModel.Free;
  inherited;
end;

end.
