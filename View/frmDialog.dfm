object fDialog: TfDialog
  Left = 0
  Top = 0
  Caption = 'Confirma'#231#227'o'
  ClientHeight = 102
  ClientWidth = 523
  Color = clBtnFace
  Constraints.MaxHeight = 140
  Constraints.MaxWidth = 535
  Constraints.MinHeight = 140
  Constraints.MinWidth = 535
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 397
    Height = 15
    Caption = 
      'Tem certeza que deseja prosseguir com a opera'#231#227'o de exclus'#227'o do ' +
      'registro?'
  end
  object btAccept: TButton
    Left = 240
    Top = 56
    Width = 130
    Height = 25
    Caption = 'Sim, quero excluir'
    TabOrder = 0
    OnClick = btAcceptClick
  end
  object btDecline: TButton
    Left = 376
    Top = 56
    Width = 130
    Height = 25
    Caption = 'N'#227'o, cancelar'
    TabOrder = 1
    OnClick = btDeclineClick
  end
end
