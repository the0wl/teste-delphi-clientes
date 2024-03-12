unit interfaceAddress;

interface

type IAddress = interface
  ['{0866C18F-FCA4-4DA8-A239-6BF41A56A10D}']

  function getId           : Integer;
  function getClientId     : Integer;
  function getPublicPlace  : string;
  function getAddressNumber: string;
  function getZipCode      : string;
  function getDistrict     : string;
  function getCity         : string;
  function getState        : string;
  function getCountry      : string;

  property Id           : Integer read getId;
  property ClientId     : Integer read getClientId;
  property PublicPlace  : string  read getPublicPlace;
  property AddressNumber: string  read getAddressNumber;
  property ZipCode      : string  read getZipCode;
  property District     : string  read getDistrict;
  property City         : string  read getCity;
  property State        : string  read getState;
  property Country      : string  read getCountry;
end;

implementation

end.
