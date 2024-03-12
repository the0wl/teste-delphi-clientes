unit uViaCep;

interface

uses
  System.JSON;

type
  TViaCep = class
  public
    class function SearchZipCode(const pZipCode: string): TJSONObject;
  end;

implementation

uses
  IdHTTP, SysUtils, IdSSLOpenSSL;

class function TViaCep.SearchZipCode(const pZipCode: string): TJSONObject;
var
  IdHTTP       : TIdHTTP;
  SSLIOHandler : TIdSSLIOHandlerSocketOpenSSL;
  strViaCEPData: string;
begin
  IdHTTP       := TIdHTTP.Create(nil);
  SSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    try
      IdHTTP.IOHandler := SSLIOHandler;
      SSLIOHandler.SSLOptions.Method := sslvTLSv1_2;

      strViaCEPData := IdHTTP.Get('https://viacep.com.br/ws/' + pZipCode + '/json/');
      Result := TJSONObject.ParseJSONValue(strViaCEPData) as TJSONObject
    except
      raise Exception.Create(
        Format('Erro ao buscar CEP (%s). Poss�veis motivos:' + #13#10 +
               ' - A conex�o com o servi�o ViaCEP est� sendo bloqueada' + #13#10 +
               ' - O servi�o (https://viacep.com.br/) est� fora do ar',
               [pZipCode])
      );
    end;
  finally
    IdHTTP.Free;
  end;
end;

end.

