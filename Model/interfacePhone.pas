unit interfacePhone;

interface

type
  IPhone = interface
    ['{DB21BDF3-3DC6-4C47-B5BF-AED3596D000C}']

    function getId      : Integer;
    function getClientId: Integer;
    function getDDD     : string;
    function getNumber  : string;

    property Id      : Integer read getId;
    property ClientId: Integer read getClientId;
    property DDD     : string  read getDDD;
    property Number  : string  read getNumber;
  end;

implementation

end.
