unit frmDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfDialog = class(TForm)
    Label1: TLabel;
    btAccept: TButton;
    btDecline: TButton;
    procedure btAcceptClick(Sender: TObject);
    procedure btDeclineClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDialog: TfDialog;

implementation

{$R *.dfm}

procedure TfDialog.btAcceptClick(Sender: TObject);
begin
  ModalResult := mrYes;
end;

procedure TfDialog.btDeclineClick(Sender: TObject);
begin
  ModalResult := mrNo;
end;

end.
