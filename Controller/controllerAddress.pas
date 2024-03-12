unit controllerAddress;

interface

uses
  classAddress;

type
  TAddressController = class
  private
    FAddressModel: TAddress;

    procedure SetAddressId;
    procedure SetAddressClientId;
    procedure SetAddressPublicPlace;
    procedure SetAddressAddressNumber;
    procedure SetAddressZipCode;
    procedure SetAddressDistrict;
    procedure SetAddressCity;
    procedure SetAddressState;
    procedure SetAddressCountry;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadAddressFromDataset;

    property Address: TAddress read FAddressModel;
  end;

implementation

uses
  frmDatabase;

{ TAddressController }

constructor TAddressController.Create;
begin
  inherited;
  FAddressModel := TAddress.Create;
end;

destructor TAddressController.Destroy;
begin
  FAddressModel.Free;
  inherited;
end;

procedure TAddressController.LoadAddressFromDataset;
begin
  SetAddressId;
  SetAddressClientId;
  SetAddressPublicPlace;
  SetAddressAddressNumber;
  SetAddressZipCode;
  SetAddressDistrict;
  SetAddressCity;
  SetAddressState;
  SetAddressCountry;
end;

procedure TAddressController.SetAddressAddressNumber;
begin
  FAddressModel.AddressNumber := fDatabase.dtsAddresses.DataSet.FieldByName('NUMERO').AsString;
end;

procedure TAddressController.SetAddressCity;
begin
  FAddressModel.City := fDatabase.dtsAddresses.DataSet.FieldByName('CIDADE').AsString;
end;

procedure TAddressController.SetAddressClientId;
begin
  FAddressModel.ClientId := fDatabase.dtsAddresses.DataSet.FieldByName('CLIENTEID').AsInteger;
end;

procedure TAddressController.SetAddressCountry;
begin
  FAddressModel.Country := fDatabase.dtsAddresses.DataSet.FieldByName('PAIS').AsString;
end;

procedure TAddressController.SetAddressDistrict;
begin
  FAddressModel.District := fDatabase.dtsAddresses.DataSet.FieldByName('BAIRRO').AsString;
end;

procedure TAddressController.SetAddressId;
begin
  FAddressModel.Id := fDatabase.dtsAddresses.DataSet.FieldByName('ID').AsInteger;
end;

procedure TAddressController.SetAddressPublicPlace;
begin
  FAddressModel.PublicPlace := fDatabase.dtsAddresses.DataSet.FieldByName('LOGRADOURO').AsString;
end;

procedure TAddressController.SetAddressState;
begin
  FAddressModel.State := fDatabase.dtsAddresses.DataSet.FieldByName('ESTADO').AsString;
end;

procedure TAddressController.SetAddressZipCode;
begin
  FAddressModel.ZipCode := fDatabase.dtsAddresses.DataSet.FieldByName('CEP').AsString;
end;

end.

