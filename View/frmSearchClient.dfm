object fSearchClient: TfSearchClient
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pesquisar por clientes'
  ClientHeight = 484
  ClientWidth = 862
  Color = clBtnFace
  Constraints.MaxHeight = 522
  Constraints.MaxWidth = 874
  Constraints.MinHeight = 522
  Constraints.MinWidth = 874
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object edNameFilter: TEdit
    Left = 19
    Top = 88
    Width = 502
    Height = 23
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = 'Filtrar por nome'
  end
  object cbActiveFilter: TCheckBox
    Left = 539
    Top = 91
    Width = 145
    Height = 17
    Caption = 'Somente clientes ativos'
    TabOrder = 1
  end
  object btnFilter: TButton
    Left = 699
    Top = 87
    Width = 145
    Height = 25
    Caption = 'Limpar filtros'
    TabOrder = 2
    OnClick = btnFilterClick
  end
  object gridClients: TDBGrid
    Left = 19
    Top = 128
    Width = 825
    Height = 337
    DataSource = fDatabase.dtsClients
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object btnEdit: TButton
    Left = 640
    Top = 16
    Width = 64
    Height = 48
    Caption = 'Editar'
    TabOrder = 4
    OnClick = btnEditClick
  end
  object btnNew: TButton
    Left = 710
    Top = 16
    Width = 64
    Height = 48
    Caption = 'Novo'
    TabOrder = 5
    OnClick = btnNewClick
  end
  object btnReload: TButton
    Left = 780
    Top = 16
    Width = 64
    Height = 48
    Caption = 'Atualizar'
    TabOrder = 6
    OnClick = btnReloadClick
  end
  object btDelete: TButton
    Left = 570
    Top = 16
    Width = 64
    Height = 48
    Caption = 'Excluir'
    TabOrder = 7
    OnClick = btDeleteClick
  end
end
