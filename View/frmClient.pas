unit frmClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  classClient, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Generics.Collections, uEnums, classPhone;

type
  TfClient = class(TForm)
    cbActive: TCheckBox;
    edId: TEdit;
    cbType: TComboBox;
    lbId: TLabel;
    lbActive: TLabel;
    lbType: TLabel;
    lbNationalDocument: TLabel;
    lbStateDocument: TLabel;
    lbPhones: TLabel;
    edNewPhoneDDD: TEdit;
    edNewPhoneNumber: TEdit;
    btnAddPhoneNumber: TButton;
    btnRemovePhoneNumber: TButton;
    edPublicPlace: TEdit;
    edAddressNumber: TEdit;
    edZipCode: TEdit;
    edDistrict: TEdit;
    edCity: TEdit;
    lbAddress: TLabel;
    edNationalDocument: TEdit;
    edStateDocument: TEdit;
    edState: TEdit;
    edCountry: TEdit;
    edFullName: TEdit;
    lbFullName: TLabel;
    btnSave: TButton;
    grid: TStringGrid;
    btVoltar: TButton;
    btSearchZipCode: TButton;
    lbRegistrationDate: TLabel;
    edRegistrationDate: TEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddPhoneNumberClick(Sender: TObject);
    procedure btSearchZipCodeClick(Sender: TObject);
    procedure btnRemovePhoneNumberClick(Sender: TObject);
    procedure edZipCodeExit(Sender: TObject);
    procedure edNationalDocumentExit(Sender: TObject);
    procedure edStateDocumentExit(Sender: TObject);
  private
    cClient         : TClient;
    actState        : TClientAction;
    phoAddedPhones  : TList<TPhone>;
    phoRemovedPhones: TList<TPhone>;

    procedure CleanFields;
    procedure ReloadPhoneGrid;
    function  ObrigatoryFieldsAreEmpty: Boolean;
  public
    procedure New;
    procedure Edit(const pClient: TClient);
  end;

var
  fClient: TfClient;

implementation

uses
  FireDAC.Stan.Error,
  FireDAC.Stan.Param,
  frmDatabase,
  uFormat,
  uIIF,
  uViaCep,
  System.JSON;

{$R *.dfm}

{ TfClient }

procedure TfClient.btnAddPhoneNumberClick(Sender: TObject);
begin
  if edNewPhoneDDD.Text = '' then
  begin
    ShowMessage('Campo `DDD` não pode estar vázio.');
    Exit;
  end;

  if edNewPhoneNumber.Text = '' then
  begin
    ShowMessage('Campo `Número` não pode estar vázio.');
    Exit;
  end;

  cClient.Phones.Add(
    TPhone.Create(-1, edNewPhoneDDD.Text, edNewPhoneNumber.Text)
  );

  phoAddedPhones.Add(
    TPhone.Create(-1, edNewPhoneDDD.Text, edNewPhoneNumber.Text)
  );

  ReloadPhoneGrid;
  edNewPhoneDDD.Text    := '';
  edNewPhoneNumber.Text := '';
end;

procedure TfClient.btnRemovePhoneNumberClick(Sender: TObject);
begin
  if grid.RowCount < 2 then Exit;

  if (grid.Cells[0, grid.Row].ToInteger > 0) and Assigned(cClient.Phones) then
    cClient.Phones.Delete(grid.Row-1);

  phoRemovedPhones.Add(
    TPhone.Create(-1, grid.Cells[2, grid.Row], grid.Cells[3, grid.Row])
  );

  ReloadPhoneGrid;
end;

procedure TfClient.btnSaveClick(Sender: TObject);
var
  i, nClientId: Integer;
begin
  if ObrigatoryFieldsAreEmpty then Exit;

  try
    fDatabase.conDatabase.StartTransaction;

    with fDatabase.tbClients do
    begin
      Active := True;

      if actState = actInsert then
      begin
        Append;
        FieldByName('DATACADASTRO').AsDateTime := Now;
      end
      else
      begin
        Edit;
      end;

      FieldByName('NOME').AsString     := edFullName.Text;
      FieldByName('TIPO').AsString     := IIF(cbType.Text = 'Pessoa Física', 'F', 'J');
      FieldByName('CPF_CNPJ').AsString := RemoveNonNumericChars(edNationalDocument.Text);
      FieldByName('RG_IE').AsString    := RemoveNonNumericChars(edStateDocument.Text);
      FieldByName('ATIVO').AsInteger   := IIF(cbActive.Checked, '1', '0');

      Post;
      nClientId := FieldByName('ID').AsInteger;
    end;

    if actState = actInsert then
    begin
      if cClient.Phones.Count > 0 then
      begin
        with fDatabase.tbPhones do
        begin
          Active := True;

          for i := 0 to cClient.Phones.Count-1 do
          begin
            Append;

            FieldByName('CLIENTEID').AsInteger := nClientId;
            FieldByName('DDD').AsString        := cClient.Phones[i].DDD;
            FieldByName('NUMERO').AsString     := cClient.Phones[i].Number;

            Post;
          end;
        end;
      end
    end
    else
    begin
      if phoAddedPhones.Count > 0 then
      begin
        with fDatabase.tbPhones do
        begin
          Active := True;

          for i := 0 to phoAddedPhones.Count-1 do
          begin
            Append;

            FieldByName('CLIENTEID').AsInteger := nClientId;
            FieldByName('DDD').AsString        := phoAddedPhones[i].DDD;
            FieldByName('NUMERO').AsString     := phoAddedPhones[i].Number;

            Post;
          end;
        end;
      end;

      if phoRemovedPhones.Count > 0 then
      begin
        with fDatabase.tbPhones do
        begin
          Active := True;

          for i := 0 to phoRemovedPhones.Count-1 do
          begin
            Filtered := False;
            Filter := Format(
              'DDD = %s AND NUMERO = %s',
              [QuotedStr(phoRemovedPhones[i].DDD),
               QuotedStr(phoRemovedPhones[i].Number)]
            );
            Filtered := True;

            while not Eof do
            begin
              Delete;
              Next;
            end;

            Filtered := False;
          end;
        end;
      end;
    end;

    with fDatabase.tbAddresses do
    begin
      Active := True;

      if actState = actInsert then
        Insert
      else
        Edit;

      FieldByName('CLIENTEID').AsInteger := nClientId;
      FieldByName('LOGRADOURO').AsString := edPublicPlace.Text;
      FieldByName('NUMERO').AsString     := edAddressNumber.Text;
      FieldByName('CEP').AsString        := RemoveNonNumericChars(edZipCode.Text);
      FieldByName('BAIRRO').AsString     := edDistrict.Text;
      FieldByName('CIDADE').AsString     := edCity.Text;
      FieldByName('ESTADO').AsString     := edState.Text;
      FieldByName('PAIS').AsString       := edCountry.Text;

      Post;
    end;

    fDatabase.conDatabase.Commit;
    edRegistrationDate.Text := FormatDate(Now);

    if actState = actInsert then
      actState := actUpdate;
  except
    on E: EFDDBEngineException do
    begin
      fDatabase.tbClients.Cancel;
      fDatabase.conDatabase.Rollback;

      case E.Kind of
        ekOther: ;
        ekNoDataFound: ;
        ekTooManyRows: ;
        ekRecordLocked: ;
        ekUKViolated: ShowMessage('Já existe outro registro com o mesmo CPF/CNPJ.');
        ekFKViolated: ;
        ekObjNotExists: ;
        ekUserPwdInvalid: ;
        ekUserPwdExpired: ;
        ekUserPwdWillExpire: ;
        ekCmdAborted: ;
        ekServerGone: ;
        ekServerOutput: ;
        ekArrExecMalfunc: ;
        ekInvalidParams: ;
      else
        ShowMessage('Ocorreu um erro inesperado!');
      end;
    end;
  end;
end;

procedure TfClient.Edit(const pClient: TClient);
begin
  CleanFields;
  cClient := TClient(pClient.Clone);

  with cClient do
  begin
    edId.Text               := Identifier.ToString;
    edFullName.Text         := FullName;
    edNationalDocument.Text := NationalDocument.FormatedIdentifier;
    edStateDocument.Text    := StateDocument.FormatedIdentifier;
    edRegistrationDate.Text := FormatDate(CreatedAt);

    cbActive.Checked        := isActive;

    case ClientType of
      ctpNaturalPerson: cbType.Text := 'Pessoa Física';
      ctpLegalPerson  : cbType.Text := 'Pessoa Jurídica';
      else
        cbType.Text := 'Pessoa Física';
    end;

    ReloadPhoneGrid;

    edZipCode.Text       := Address.ZipCode;
    edPublicPlace.Text   := Address.PublicPlace;
    edAddressNumber.Text := Address.AddressNumber;
    edDistrict.Text      := Address.District;
    edCity.Text          := Address.City;
    edState.Text         := Address.State;
    edCountry.Text       := Address.Country;
  end;

  actState     := actUpdate;
  lbId.Visible := True;
  edId.Visible := True;
end;

procedure TfClient.edNationalDocumentExit(Sender: TObject);
var
  dnaDocumentName: TDocumentName;
begin
  dnaDocumentName         := IIF(cbType.Text = 'Pessoa Jurídica', dnaCNPJ, dnaCPF);
  edNationalDocument.Text := FormatDocument(dnaDocumentName, edNationalDocument.Text);
end;

procedure TfClient.edStateDocumentExit(Sender: TObject);
var
  dnaDocumentName: TDocumentName;
begin
  dnaDocumentName      := IIF(cbType.Text = 'Pessoa Jurídica', dnaIE, dnaRG);
  edStateDocument.Text := FormatDocument(dnaDocumentName, edStateDocument.Text);
end;

procedure TfClient.edZipCodeExit(Sender: TObject);
begin
  edZipCode.Text := FormatZipCode(edZipCode.Text);
end;

procedure TfClient.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  if Assigned(cClient) then
  begin
    cClient.Free;
    cClient := nil;
  end;

  if Assigned(phoAddedPhones) then
  begin
    for i := 0 to phoAddedPhones.Count - 1 do
      TObject(phoAddedPhones[i]).Free;

    phoAddedPhones.Free;
    phoAddedPhones := nil;
  end;

  if Assigned(phoRemovedPhones) then
  begin
    for i := 0 to phoRemovedPhones.Count - 1 do
      TObject(phoRemovedPhones[i]).Free;

    phoRemovedPhones.Free;
    phoRemovedPhones := nil;
  end;
end;

procedure TfClient.FormCreate(Sender: TObject);
begin
  grid.Cells[0, 0] := 'Id';
  grid.Cells[1, 0] := 'ClienteId';
  grid.Cells[2, 0] := 'DDD';
  grid.Cells[3, 0] := 'Número';

  grid.ColWidths[0] := 0;
  grid.ColWidths[1] := 0;
  grid.ColWidths[2] := 50;
  grid.ColWidths[3] := 200;

  CleanFields;
end;

procedure TfClient.New;
begin
  CleanFields;
  actState     := actInsert;
  lbId.Visible := False;
  edId.Visible := False;
  cbType.Text  := 'Pessoa Física';

  cClient := TClient.Create;
end;

procedure TfClient.btVoltarClick(Sender: TObject);
begin
  ModalResult := mrNo;
end;

procedure TfClient.btSearchZipCodeClick(Sender: TObject);
var
  strZipCode: string;
  jsonObject: TJSONObject;
  bError    : Boolean;
begin
  strZipCode := RemoveNonNumericChars(edZipCode.Text);

  if strZipCode = '' then
  begin
    ShowMessage('Preencha o campo do CEP.');
    Exit;
  end;

  try
    jsonObject := TViaCep.SearchZipCode(strZipCode);

    if Assigned(jsonObject) then
    begin
      jsonObject.TryGetValue<Boolean>('erro', bError);

      if bError then
      begin
        ShowMessage('Não foi possível localizar o CEP.');
        Exit;
      end;

      with jsonObject do
      begin
        edZipCode.Text     := GetValue('cep').Value;
        edPublicPlace.Text := GetValue('logradouro').Value + ' ' + GetValue('complemento').Value;
        edDistrict.Text    := GetValue('bairro').Value;
        edCity.Text        := GetValue('localidade').Value;
        edState.Text       := GetValue('uf').Value;
        edCountry.Text     := 'Brasil';
      end;
    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfClient.CleanFields;
begin
  ReloadPhoneGrid;
  phoAddedPhones          := TList<TPhone>.Create;
  phoRemovedPhones        := TList<TPhone>.Create;
  edId.Text               := '0';
  edRegistrationDate.Text := '';
  edFullName.Text         := '';
  edNationalDocument.Text := '';
  edStateDocument.Text    := '';
  cbType.Text             := '';
  cbActive.Checked        := True;
  edNewPhoneDDD.Text      := '';
  edNewPhoneNumber.Text   := '';
  edZipCode.Text          := '';
  edPublicPlace.Text      := '';
  edAddressNumber.Text    := '';
  edDistrict.Text         := '';
  edCity.Text             := '';
  edState.Text            := '';
  edCountry.Text          := '';
end;

procedure TfClient.ReloadPhoneGrid;
var
  i: Integer;
begin
  grid.RowCount := 2;

  if not Assigned(cClient) then Exit;

  with cClient do
  begin
    for i := 0 to Phones.Count-1 do
    begin
      grid.RowCount      := i+2;
      grid.Cells[0, i+1] := Phones[i].Id.ToString;
      grid.Cells[1, i+1] := Phones[i].ClientId.ToString;
      grid.Cells[2, i+1] := Phones[i].DDD;
      grid.Cells[3, i+1] := Phones[i].Number;
    end;
  end;
end;

function TfClient.ObrigatoryFieldsAreEmpty: Boolean;
begin
  Result := True;

  if edFullName.Text = '' then 
  begin
    ShowMessage('O campo `Nome` não está preenchido!');
    Exit;
  end
  else if cbType.Text = '' then
  begin
    ShowMessage('O campo `Tipo` não está preenchido!');
    Exit;
  end
  else if edNationalDocument.Text = '' then
  begin
    ShowMessage('O campo `CPF / CNPJ` não está preenchido!');
    Exit;
  end;

  Result := False;
end;

end.
