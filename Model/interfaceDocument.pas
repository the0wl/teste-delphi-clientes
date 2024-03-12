unit interfaceDocument;

interface

uses uEnums;

type
  IDocument = interface
    ['{0B5205CB-342A-4038-81FC-A258FF12CC93}']

    function getIdentifier        : string;
    function getFormatedIdentifier: string;
    function getDocumentName      : TDocumentName;

    property Identifier        : string        read getIdentifier;
    property FormatedIdentifier: string        read getFormatedIdentifier;
    property DocumentName      : TDocumentName read getDocumentName;
  end;

implementation

end.
