program TesteDelphi;

uses
  Vcl.Forms,
  frmSearchClient in 'View\frmSearchClient.pas' {fSearchClient},
  classClient in 'Model\classClient.pas',
  interfaceClient in 'Model\interfaceClient.pas',
  classDocument in 'Model\classDocument.pas',
  uEnums in 'Utils\uEnums.pas',
  interfaceDocument in 'Model\interfaceDocument.pas',
  interfacePhone in 'Model\interfacePhone.pas',
  classPhone in 'Model\classPhone.pas',
  interfaceAddress in 'Model\interfaceAddress.pas',
  classAddress in 'Model\classAddress.pas',
  uViaCep in 'Utils\uViaCep.pas',
  uJSONHelper in 'Utils\uJSONHelper.pas',
  uFormat in 'Utils\uFormat.pas',
  frmDatabase in 'View\frmDatabase.pas' {fDatabase},
  frmClient in 'View\frmClient.pas' {fClient},
  frmDialog in 'View\frmDialog.pas' {fDialog},
  uIIF in 'Utils\uIIF.pas',
  controllerClient in 'Controller\controllerClient.pas',
  controllerDocument in 'Controller\controllerDocument.pas',
  controllerAddress in 'Controller\controllerAddress.pas',
  controllerPhone in 'Controller\controllerPhone.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfSearchClient, fSearchClient);
  Application.CreateForm(TfDatabase, fDatabase);
  Application.CreateForm(TfClient, fClient);
  Application.CreateForm(TfDialog, fDialog);
  Application.Run;
end.
