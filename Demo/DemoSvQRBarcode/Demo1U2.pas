unit Demo1U2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, SvQrBarcode;

type
  TQR1 = class(TQuickRep)
    Table1: TTable;
    Table1IND_CODE: TSmallintField;
    Table1IND_NAME: TStringField;
    Table1LONG_NAME: TStringField;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    SvQRBarcode1: TSvQRBarcode;
    procedure SvQRBarcode1BeforePrint(sender: TObject);
  private

  public

  end;

var
  QR1: TQR1;

implementation

{$R *.DFM}




procedure TQR1.SvQRBarcode1BeforePrint(sender: TObject);
begin
SvQRBarcode1.Text:=Table1IND_CODE.AsString;
end;

end.
