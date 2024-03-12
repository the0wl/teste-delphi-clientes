object fClient: TfClient
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Manuten'#231#227'o de clientes'
  ClientHeight = 482
  ClientWidth = 628
  Color = clBtnFace
  Constraints.MaxHeight = 520
  Constraints.MaxWidth = 640
  Constraints.MinHeight = 520
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object lbId: TLabel
    Left = 87
    Top = 28
    Width = 13
    Height = 15
    Caption = 'Id:'
  end
  object lbActive: TLabel
    Left = 69
    Top = 57
    Width = 31
    Height = 15
    Caption = 'Ativo:'
  end
  object lbType: TLabel
    Left = 74
    Top = 119
    Width = 26
    Height = 15
    Caption = 'Tipo:'
  end
  object lbNationalDocument: TLabel
    Left = 38
    Top = 152
    Width = 62
    Height = 15
    Caption = 'CPF / CNPJ:'
  end
  object lbStateDocument: TLabel
    Left = 62
    Top = 185
    Width = 38
    Height = 15
    Caption = 'RG / IE:'
  end
  object lbPhones: TLabel
    Left = 48
    Top = 249
    Width = 52
    Height = 15
    Alignment = taRightJustify
    Caption = 'Telefones:'
  end
  object lbAddress: TLabel
    Left = 48
    Top = 387
    Width = 52
    Height = 15
    Alignment = taRightJustify
    Caption = 'Endere'#231'o:'
  end
  object lbFullName: TLabel
    Left = 64
    Top = 86
    Width = 36
    Height = 15
    Caption = 'Nome:'
  end
  object lbRegistrationDate: TLabel
    Left = 17
    Top = 216
    Width = 83
    Height = 15
    Caption = 'Cadastrado em:'
  end
  object cbActive: TCheckBox
    Left = 106
    Top = 57
    Width = 17
    Height = 17
    TabOrder = 0
  end
  object edId: TEdit
    Left = 106
    Top = 24
    Width = 121
    Height = 23
    Enabled = False
    ReadOnly = True
    TabOrder = 1
    Text = '0'
  end
  object cbType: TComboBox
    Left = 106
    Top = 116
    Width = 145
    Height = 23
    TabOrder = 2
    TextHint = 'Escolher'
    Items.Strings = (
      'Pessoa F'#237'sica'
      'Pessoa Jur'#237'dica')
  end
  object edNewPhoneDDD: TEdit
    Left = 257
    Top = 347
    Width = 49
    Height = 23
    NumbersOnly = True
    TabOrder = 3
    TextHint = 'DDD'
  end
  object edNewPhoneNumber: TEdit
    Left = 312
    Top = 347
    Width = 130
    Height = 23
    NumbersOnly = True
    TabOrder = 4
    TextHint = 'N'#250'mero'
  end
  object btnAddPhoneNumber: TButton
    Left = 452
    Top = 347
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 5
    OnClick = btnAddPhoneNumberClick
  end
  object btnRemovePhoneNumber: TButton
    Left = 534
    Top = 346
    Width = 75
    Height = 25
    Caption = 'Remover'
    TabOrder = 6
    OnClick = btnRemovePhoneNumberClick
  end
  object edPublicPlace: TEdit
    Left = 225
    Top = 384
    Width = 303
    Height = 23
    TabOrder = 7
    TextHint = 'Logradouro'
  end
  object edAddressNumber: TEdit
    Left = 534
    Top = 384
    Width = 75
    Height = 23
    TabOrder = 8
    TextHint = 'N'#250'mero'
  end
  object edZipCode: TEdit
    Left = 106
    Top = 384
    Width = 73
    Height = 23
    TabOrder = 9
    TextHint = 'CEP'
    OnExit = edZipCodeExit
  end
  object edDistrict: TEdit
    Left = 106
    Top = 413
    Width = 239
    Height = 23
    TabOrder = 10
    TextHint = 'Bairro'
  end
  object edCity: TEdit
    Left = 351
    Top = 413
    Width = 258
    Height = 23
    TabOrder = 11
    TextHint = 'Cidade'
  end
  object edNationalDocument: TEdit
    Left = 106
    Top = 149
    Width = 145
    Height = 23
    NumbersOnly = True
    TabOrder = 12
    OnExit = edNationalDocumentExit
  end
  object edStateDocument: TEdit
    Left = 106
    Top = 182
    Width = 145
    Height = 23
    NumbersOnly = True
    TabOrder = 13
    OnExit = edStateDocumentExit
  end
  object edState: TEdit
    Left = 106
    Top = 442
    Width = 239
    Height = 23
    TabOrder = 14
    TextHint = 'Estado'
  end
  object edCountry: TEdit
    Left = 351
    Top = 442
    Width = 258
    Height = 23
    TabOrder = 15
    TextHint = 'Pa'#237's'
  end
  object edFullName: TEdit
    Left = 106
    Top = 83
    Width = 145
    Height = 23
    TabOrder = 16
    TextHint = 'Nome'
  end
  object btnSave: TButton
    Left = 475
    Top = 12
    Width = 64
    Height = 48
    Caption = 'Gravar'
    TabOrder = 17
    OnClick = btnSaveClick
  end
  object grid: TStringGrid
    Left = 106
    Top = 247
    Width = 503
    Height = 94
    ColCount = 4
    FixedCols = 0
    RowCount = 2
    TabOrder = 18
  end
  object btVoltar: TButton
    Left = 545
    Top = 12
    Width = 64
    Height = 48
    Caption = 'Voltar'
    TabOrder = 19
    OnClick = btVoltarClick
  end
  object btSearchZipCode: TButton
    Left = 176
    Top = 383
    Width = 43
    Height = 25
    Caption = 'Buscar'
    TabOrder = 20
    OnClick = btSearchZipCodeClick
  end
  object edRegistrationDate: TEdit
    Left = 106
    Top = 214
    Width = 145
    Height = 23
    Enabled = False
    ReadOnly = True
    TabOrder = 21
  end
end
