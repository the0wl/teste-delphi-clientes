unit controllerPhone;

interface

uses
  Generics.Collections,
  classPhone;

type
  TPhoneController = class
  private
    FModelPhone: TList<TPhone>;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadPhonesFromDataset;

    property Phones: TList<TPhone> read FModelPhone;
  end;

implementation

uses
  frmDatabase;

{ TPhoneController }

procedure TPhoneController.LoadPhonesFromDataset;
var
  nId      : Integer;
  nClientId: Integer;
  strDDD   : string;
  strNumber: string;
begin
  FModelPhone.Clear;

  with fDatabase.dtsPhones.DataSet do
  begin
    First;

    while not Eof do
    begin
      nId       := FieldByName('ID').AsInteger;
      nClientId := FieldByName('CLIENTEID').AsInteger;
      strDDD    := FieldByName('DDD').AsString;
      strNumber := FieldByName('NUMERO').AsString;

      FModelPhone.Add(TPhone.Create(nId, nClientId, strDDD, strNumber));

      Next;
    end;
  end;
end;

constructor TPhoneController.Create;
begin
  inherited;

  FModelPhone := TList<TPhone>.Create;
end;

destructor TPhoneController.Destroy;
var
  i: Integer;
begin
  for i := 0 to FModelPhone.Count - 1 do
    TObject(FModelPhone[i]).Free;

  FModelPhone.Free;
  FModelPhone := nil;

  inherited;
end;

end.

