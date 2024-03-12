unit frmSearchClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.DBGrids, Vcl.Mask,
  Data.DB, Generics.Collections, classPhone, classAddress, controllerClient;

type
  TfSearchClient = class(TForm)
    edNameFilter  : TEdit;
    cbActiveFilter: TCheckBox;
    btnFilter     : TButton;
    gridClients   : TDBGrid;
    btnEdit       : TButton;
    btnNew        : TButton;
    btnReload     : TButton;
    btDelete      : TButton;

    procedure btnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnReloadClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FClientController: TClientController;

    procedure ConfigureGridColumns;
  public
    { Public declarations }
  end;

var
  fSearchClient: TfSearchClient;

implementation

uses
  System.UITypes,
  FireDAC.Stan.Error,
  uViaCep,
  classDocument,
  uEnums,
  uIIF,
  uFormat,
  frmDatabase,
  frmClient,
  frmDialog;

{$R *.dfm}

procedure TfSearchClient.btnFilterClick(Sender: TObject);
begin
  edNameFilter.Text            := '';
  cbActiveFilter.Checked       := False;
  fDatabase.tbClients.Filtered := False;
  fDatabase.dtsClients.DataSet.Refresh;
end;

procedure TfSearchClient.btnNewClick(Sender: TObject);
begin
  fClient.New;
  fClient.ShowModal;
end;

procedure TfSearchClient.btnReloadClick(Sender: TObject);
begin
  FClientController.ApplyFiltersToDataset(edNameFilter.Text, cbActiveFilter.Checked);
end;

procedure TfSearchClient.btDeleteClick(Sender: TObject);
begin
  if fDatabase.tbClients.RecordCount < 1 then Exit;

  if fDialog.ShowModal = mrYes then
    FClientController.Delete
  else
    ShowMessage('Operação cancelada!');
end;

procedure TfSearchClient.btnEditClick(Sender: TObject);
begin
  if fDatabase.tbClients.RecordCount < 1 then Exit;
  FClientController.LoadClientFromDataset;
  fClient.Edit(FClientController.Client);
  fClient.ShowModal;
end;

procedure TfSearchClient.FormCreate(Sender: TObject);
begin
  inherited;
  FClientController := TClientController.Create;
end;

procedure TfSearchClient.FormDestroy(Sender: TObject);
begin
  FClientController.Free;
  inherited;
end;

procedure TfSearchClient.FormShow(Sender: TObject);
begin
  ConfigureGridColumns;
end;

procedure TfSearchClient.ConfigureGridColumns;
begin
  gridClients.Columns.Items[0].Width := 50;
  gridClients.Columns.Items[1].Width := 280;
  gridClients.Columns.Items[2].Width := 90;
  gridClients.Columns.Items[3].Width := 110;
  gridClients.Columns.Items[4].Width := 100;
  gridClients.Columns.Items[5].Width := 100;
  gridClients.Columns.Items[6].Width := 40;
end;

end.
