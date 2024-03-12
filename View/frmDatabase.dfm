object fDatabase: TfDatabase
  Left = 0
  Top = 0
  Caption = 'Database'
  ClientHeight = 171
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object conDatabase: TFDConnection
    Params.Strings = (
      'Database=C:\BANCO DE DADOS\DB_TESTE_2.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 54
    Top = 30
  end
  object tbClients: TFDQuery
    Active = True
    AfterOpen = tbClientsAfterOpen
    Connection = conDatabase
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
    Left = 166
    Top = 30
    object tbClientsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tbClientsNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object tbClientsTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object tbClientsCPF_CNPJ: TStringField
      FieldName = 'CPF_CNPJ'
      Origin = 'CPF_CNPJ'
      Required = True
    end
    object tbClientsRG_IE: TStringField
      FieldName = 'RG_IE'
      Origin = 'RG_IE'
    end
    object tbClientsDATACADASTRO: TDateField
      FieldName = 'DATACADASTRO'
      Origin = 'DATACADASTRO'
    end
    object tbClientsATIVO: TSmallintField
      FieldName = 'ATIVO'
      Origin = 'ATIVO'
    end
  end
  object dtsClients: TDataSource
    DataSet = tbClients
    Left = 168
    Top = 96
  end
  object tbAddresses: TFDQuery
    Active = True
    IndexFieldNames = 'CLIENTEID'
    MasterSource = dtsClients
    MasterFields = 'ID'
    DetailFields = 'CLIENTEID'
    Connection = conDatabase
    SQL.Strings = (
      'SELECT * '
      'FROM ENDERECOS'
      'WHERE CLIENTEID = :ID')
    Left = 269
    Top = 33
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object tbAddressesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tbAddressesCLIENTEID: TIntegerField
      FieldName = 'CLIENTEID'
      Origin = 'CLIENTEID'
      Required = True
    end
    object tbAddressesLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Origin = 'LOGRADOURO'
      Required = True
      Size = 200
    end
    object tbAddressesNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Required = True
      Size = 10
    end
    object tbAddressesCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Required = True
      Size = 9
    end
    object tbAddressesBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Required = True
      Size = 100
    end
    object tbAddressesCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Required = True
      Size = 100
    end
    object tbAddressesESTADO: TStringField
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      Required = True
      Size = 100
    end
    object tbAddressesPAIS: TStringField
      FieldName = 'PAIS'
      Origin = 'PAIS'
      Required = True
      Size = 100
    end
  end
  object dtsAddresses: TDataSource
    DataSet = tbAddresses
    Left = 277
    Top = 96
  end
  object tbPhones: TFDQuery
    Active = True
    IndexFieldNames = 'CLIENTEID'
    MasterSource = dtsClients
    MasterFields = 'ID'
    DetailFields = 'CLIENTEID'
    Connection = conDatabase
    SQL.Strings = (
      'SELECT * '
      'FROM TELEFONES'
      'WHERE CLIENTEID = :ID;')
    Left = 381
    Top = 36
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object tbPhonesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tbPhonesCLIENTEID: TIntegerField
      FieldName = 'CLIENTEID'
      Origin = 'CLIENTEID'
      Required = True
    end
    object tbPhonesDDD: TStringField
      FieldName = 'DDD'
      Origin = 'DDD'
      Required = True
      Size = 2
    end
    object tbPhonesNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Required = True
    end
  end
  object dtsPhones: TDataSource
    DataSet = tbPhones
    Left = 381
    Top = 96
  end
end
