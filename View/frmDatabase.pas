unit frmDatabase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TfDatabase = class(TForm)
    conDatabase: TFDConnection;
    tbClients: TFDQuery;
    tbClientsID: TIntegerField;
    tbClientsNOME: TStringField;
    tbClientsTIPO: TStringField;
    tbClientsCPF_CNPJ: TStringField;
    tbClientsRG_IE: TStringField;
    tbClientsDATACADASTRO: TDateField;
    tbClientsATIVO: TSmallintField;
    dtsClients: TDataSource;
    tbAddresses: TFDQuery;
    tbAddressesID: TIntegerField;
    tbAddressesCLIENTEID: TIntegerField;
    tbAddressesLOGRADOURO: TStringField;
    tbAddressesNUMERO: TStringField;
    tbAddressesCEP: TStringField;
    tbAddressesBAIRRO: TStringField;
    tbAddressesCIDADE: TStringField;
    tbAddressesESTADO: TStringField;
    tbAddressesPAIS: TStringField;
    dtsAddresses: TDataSource;
    tbPhones: TFDQuery;
    tbPhonesID: TIntegerField;
    tbPhonesCLIENTEID: TIntegerField;
    tbPhonesDDD: TStringField;
    tbPhonesNUMERO: TStringField;
    dtsPhones: TDataSource;
    procedure tbClientsAfterOpen(DataSet: TDataSet);
  private
    procedure ClientActiveOnGetText          (Sender: TField; var Text: string; DisplayText: Boolean);
    procedure ClientNationalDocumentOnGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure ClientStateDocumentOnGetText   (Sender: TField; var Text: string; DisplayText: Boolean);
    procedure ClientTypeOnGetText            (Sender: TField; var Text: string; DisplayText: Boolean);
    procedure ClientRegistrationDateOnGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  public
    { Public declarations }
  end;

var
  fDatabase: TfDatabase;

implementation

uses
  uFormat,
  uIIF,
  UEnums;

{$R *.dfm}

procedure TfDatabase.tbClientsAfterOpen(DataSet: TDataSet);
begin
  with fDatabase.dtsClients.DataSet do
  begin
    FieldByName('ATIVO').OnGetText        := ClientActiveOnGetText;
    FieldByName('TIPO').OnGetText         := ClientTypeOnGetText;
    FieldByName('CPF_CNPJ').OnGetText     := ClientNationalDocumentOnGetText;
    FieldByName('RG_IE').OnGetText        := ClientStateDocumentOnGetText;
    FieldByName('DATACADASTRO').OnGetText := ClientRegistrationDateOnGetText;

    fDatabase.dtsClients.DataSet.Refresh;
  end;
end;

procedure TfDatabase.ClientActiveOnGetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if fDatabase.tbClients.RecordCount < 1 then Exit;

  Text := IIF(Sender.AsInteger = 1, 'Sim', 'Não');
end;

procedure TfDatabase.ClientNationalDocumentOnGetText(Sender: TField; var Text: String; DisplayText: Boolean);
var
  strDocumentId : string;
  dnaDocumentName: TDocumentName;
begin
  if fDatabase.tbClients.RecordCount < 1 then Exit;

  strDocumentId   := Sender.AsString;
  dnaDocumentName := IIF(strDocumentId.Length > 11, dnaCNPJ, dnaCPF);

  Text := FormatDocument(dnaDocumentName, strDocumentId);
end;

procedure TfDatabase.ClientRegistrationDateOnGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if fDatabase.tbClients.RecordCount < 1 then Exit;

  Text := FormatDate(Sender.AsDateTime);
end;

procedure TfDatabase.ClientStateDocumentOnGetText(Sender: TField; var Text: String; DisplayText: Boolean);
var
  strDocumentId: string;
  isLegalPerson: Boolean;
begin
  if fDatabase.tbClients.RecordCount < 1 then Exit;

  strDocumentId := Sender.AsString;
  isLegalPerson := strDocumentId.Length > 9;
  Text := IIF(isLegalPerson, FormatIE(strDocumentId), FormatRG(strDocumentId));
end;

procedure TfDatabase.ClientTypeOnGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if fDatabase.tbClients.RecordCount < 1 then Exit;

  if Sender.AsString.IsEmpty then Exit;

  Text := IIF(Sender.AsString = 'F', 'Pessoa Física', 'Pessoa Jurídica');
end;

end.
