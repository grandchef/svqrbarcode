{

QuickReport Barcode Components
Version 1.03 (30/12/2002)
Copyright 2001 Stefano Vecchiato


This unit has two Barcode components for QuickReport.

SvQRBarcode     is a QuickReport component which print a barcode
                from the value of the Text property. You can set it
    in the BeforePrint Event.

SvQRDBBarcode   is a QuickReport data-aware component which print
                the barcode from the value of a DataField in a DataSet.

These components require the version 1.20 (or newer) of the freeware TAsBarcode
component by Andreas Schmidt and friends which can be found on the net at the link

http://members.tripod.de/AJSchmidt/index.html



Tested in Delphi 3, 5 and 6;

These components are published as freeware.

Installation notes:

  Close all open projects/files.
  Use File Open and select the appropriate dpk file.
  Compile and then install the package.

  In Delphi 5  you must, also, choose Environment Options on Tools menu,
  select Library and add

  $(DELPHI)\SOURCE\TOOLSAPI

  and the directory where you have installed SvQRBarcode

  to the library path string;

======================================================================================


Copyright notice:

These components are unrestricted freeware. They may be distributed, used and/or
modified without restrictions. Please note that although these components have
been tested and been found to work correctly, you use them entirely at your
own risk and I will not be held responsible for any errors or corrupted  files,
damaged databases or any other event that my be happen when you use these components.


Stefano Vecchiato
November 2000


e-mail: vecchstef@interfree.it


get latest version from

http://vecchstef.interfree.it/Delphi.htm


}


unit SvQrBarcode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ASBarcode, quickrpt, Qrctrls, DB;

type
  tBeforePrintEvent = procedure(Sender: TObject) of object;

type
  tAfterPrintEvent = procedure(Sender: TObject) of object;



type
  TSvQRCustomBarcode = class(TQRPrintable)
  private
    { Private declarations }
    FBarCode:     TASBarCode;
{    FText   : string;
    FModul  : integer;
    FRatio  : double;
    FTyp    : TBarcodeType;
    FCheckSum:boolean;
    FShowText:TBarcodeOption;
    FAngle  : double;
    FColor  : TColor;
    FColorBar:TColor;
    FCheckSumMethod : TCheckSumMethod;}
    fBeforePrint: tBeforePrintEvent;
    fAfterPrint:  tAfterPrintEvent;


    function GetBarcodeHeight: integer;
    procedure SetBarcodeHeight(const AHeight: integer);
    function GetBarcodeWidth: integer;
    procedure SetBarcodeWidth(const AWidth: integer);
    procedure SetModul(const v: integer);
    function GetModul: integer;
    procedure SetRatio(const aRatio: double);
    function GetRatio: double;
    procedure SetTyp(const aTyp: TBarcodeType);
    function GetTyp: TBarCodeType;
    procedure SetCheckSum(const aCheckSum: boolean);
    function GetCheckSum: boolean;
    procedure SetCheckSumMethod(const aCheckSumMethod: TCheckSumMethod);
    function GetCheckSumMethod: TCheckSumMethod;
    procedure SetAngle(const aAngle: double);
    function GetAngle: double;
    procedure SetShowText(const aShowText: TBarcodeOption);
    function GetShowText: TBarcodeOption;
    procedure SetColor(const aColor: TColor);
    function GetColor: TColor;
    procedure SetColorBar(const aColorBar: TColor);
    function GetColorBar: TColor;

  protected
    { Protected declarations }
    procedure SetText(const aText: string);
    function GetText: string;
    property Text: string Read GetText Write SetText;
  public
    { Public declarations }
    procedure Print(OfsX, OfsY: integer); override;
    procedure Paint; override;
    procedure Loaded; override;
    procedure Resize; override;
    constructor Create(aOwner: TComponent); override;
  published
    { Published declarations }
    { Width of the smallest line in a Barcode }
    property BarcodeHeight: integer Read GetBarcodeHeight Write SetBarcodeHeight;
    property BarcodeWidth: integer Read GetBarcodeWidth Write SetBarcodeWidth;
    property Modul: integer Read GetModul Write SetModul;
    property Ratio: double Read GetRatio Write SetRatio;
    property Typ: TBarcodeType Read GetTyp Write SetTyp default bcCodeEAN13;
    { build CheckSum ? }
    property Checksum: boolean Read GetCheckSum Write SetCheckSum default False;
    property CheckSumMethod: TCheckSumMethod Read GetCheckSumMethod Write SetCheckSumMethod default csmModulo10;

    { 0 - 360 degree }
    property Angle: double Read GetAngle Write SetAngle;
    property ShowText: TBarcodeOption Read GetShowText Write SetShowText default bcoNone;
    property Color: TColor Read GetColor Write SetColor default clWhite;
    property ColorBar: TColor Read GetColorBar Write SetColorBar default clBlack;
    property BeforePrint: tBeforePrintEvent Read fBeforePrint Write fBeforePrint;
    property AfterPrint: tAfterPrintEvent Read fAfterPrint Write fAfterPrint;

  end;


  TSvQRBarcode = class(TSvQRCustomBarcode)
  private
    { Private declarations }

  protected
    { Protected declarations }

  public
    { Public declarations }

  published
    { Published declarations }
    property Text: string Read GetText Write SetText;
  end;


  TSvQRDBBarcode = class(TSvQRCustomBarcode)
  private
    Field:      TField;
    FieldNo:    integer;
    CorrectField: boolean;
    DataSourceName: string;
    FDataSet:   TDataSet;
    FDataField: string;
    FPrefix: string;
    procedure SetDataSet(Value: TDataSet);
    procedure SetDataField(Value: string);
    procedure SetPrefix(const Value: string);

  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Prepare; override;
    procedure ReadValues(Reader: TReader); virtual;
    procedure UnPrepare; override;
    procedure WriteValues(Writer: TWriter); virtual;

  public
    procedure Print(OfsX, OfsY: integer); override;

  published
    property DataSet: TDataSet Read FDataSet Write SetDataSet;
    property DataField: string Read FDataField Write SetDataField;
    property Prefix : string read FPrefix write SetPrefix;
  end;



implementation


function TSvQRCustomBarcode.GetBarcodeHeight: integer;
begin
  Result := FBarcode.Height;
end;

procedure TSvQRCustomBarcode.SetBarcodeHeight(const AHeight: integer);
begin
  FBarcode.Height := AHeight;
  Invalidate;
end;

function TSvQRCustomBarcode.GetBarcodeWidth: integer;
begin
  Result := FBarcode.Width;
end;

procedure TSvQRCustomBarcode.SetBarcodeWidth(const AWidth: integer);
begin
  FBarcode.Width := AWidth;
  Invalidate;
end;

procedure TSvQRCustomBarcode.SetText(const aText: string);
begin
  FBarcode.Text := aText;
  Invalidate;
end;

function TSvQRCustomBarcode.GetText: string;
begin
  Result := FBarcode.Text;
end;

{ set Modul Width  }
procedure TSvQRCustomBarcode.SetModul(const v: integer);
begin
  FBarcode.Modul := v;
end;

function TSvQRCustomBarcode.GetModul: integer;
begin
  Result := FBarcode.Modul;
end;

procedure TSvQRCustomBarcode.SetRatio(const aRatio: double);
begin
  FBarcode.Ratio := aRatio;
  Invalidate;
end;

function TSvQRCustomBarcode.GetRatio: double;
begin
  Result := FBarcode.Ratio;
end;

procedure TSvQRCustomBarcode.SetTyp(const aTyp: TBarcodeType);
begin
  FBarcode.Typ := aTyp;
  Invalidate;
end;

function TSvQRCustomBarcode.GetTyp: TBarcodeType;
begin
  Result := FBarcode.Typ;
end;

procedure TSvQRCustomBarcode.SetCheckSum(const aCheckSum: boolean);
begin
  FBarcode.CheckSum := aCheckSum;
  Invalidate;
end;

function TSvQRCustomBarcode.GetCheckSum: boolean;
begin
  Result := FBarcode.CheckSum;
end;

procedure TSvQRCustomBarcode.SetCheckSumMethod(const aCheckSumMethod: TCheckSumMethod);
begin
  FBarcode.CheckSumMethod := aCheckSumMethod;
  Invalidate;
end;

function TSvQRCustomBarcode.GetCheckSumMethod: TCheckSumMethod;
begin
  Result := FBarcode.CheckSumMethod;
end;


procedure TSvQRCustomBarcode.SetAngle(const aAngle: double);
begin
  FBarcode.Angle := aAngle;
  Invalidate;
end;

function TSvQRCustomBarcode.GetAngle: double;
begin
  Result := FBarcode.Angle;
end;

procedure TSvQRCustomBarcode.SetShowText(const aShowText: TBarcodeOption);
begin
  FBarcode.ShowText := aShowText;
  Invalidate;
end;

function TSvQRCustomBarcode.GetShowText: TBarcodeOption;
begin
  Result := FBarcode.ShowText;
end;

procedure TSvQRCustomBarcode.SetColor(const aColor: TColor);
begin
  FBarcode.Color := aColor;
  Invalidate;
end;

function TSvQRCustomBarcode.GetColor: TColor;
begin
  Result := FBarcode.Color;
end;

procedure TSvQRCustomBarcode.SetColorBar(const aColorBar: TColor);
begin
  FBarcode.ColorBar := aColorBar;
  Invalidate;
end;

function TSvQRCustomBarcode.GetColorBar: TColor;
begin
  Result := FBarcode.ColorBar;
end;


procedure TSvQRCustomBarcode.print(OfsX, OfsY: integer);

//12-May-2009, Christopher Chase > Added Old width Hight, to fix issue in Printing Lots of barcodes on custom quickreport
var
  OldHeight: integer;
  OldWidth:  integer;
begin
  if assigned(fBeforeprint) then
    fBeforePrint(self);
  OldHeight := FBarcode.Height;
  OldWidth  := FBarcode.Width;

  FBarcode.Top    := ParentReport.QRPrinter.YPos(OfsY + Size.Top);
  FBarcode.Left   := ParentReport.QRPrinter.XPos(OfsX + Size.Left);
  FBarcode.Height := ParentReport.QRPrinter.YPos(OfsY + Size.Top + Size.Height) - ParentReport.QRPrinter.YPos(OfsY + Size.Top);
  FBarcode.Width  := ParentReport.QRPrinter.YPos(OfsY + Size.Left + Size.Width) - ParentReport.QRPrinter.YPos(OfsY + Size.Left);

  if Text <> '' then
    FBarcode.DrawBarcode(ParentReport.QRPrinter.Canvas);

  FBarcode.Height := OldHeight;
  FBarcode.Width  := OldWidth;

  if assigned(fAfterprint) then
    fAfterPrint(self);
end;

procedure TSvQRCustomBarcode.paint;
begin

{   if FShowText in [bcoTyp, bcoBoth]
   then
     FBarcode.Height:=Height+Round(Font.Height*2.5);}

  FBarcode.Top  := 0;
{   if FShowText in [bcoTyp, bcoBoth]
   then
     FBarcode.Top:=Round(Font.Height*2.5);}
  FBarcode.Left := 0;

  FBarcode.DrawBarcode(Canvas);

  Width  := FBarcode.CanvasWidth;
  Height := FBarcode.CanvasHeight;
end;


procedure TSvQRCustomBarcode.loaded;
begin
  inherited loaded;
end;

procedure TSvQRCustomBarcode.Resize;
begin
  inherited Resize;
  if (Angle = 0){ or (Angle = 180)} then
    FBarcode.Height := Height;
end;


constructor TSvQRCustomBarcode.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FBarcode := TASBarcode.Create(self);
  Height   := 50;
end;



procedure TSvQRDBBarcode.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('DataSource', ReadValues, WriteValues, False);
  inherited DefineProperties(Filer);
end;

procedure TSvQRDBBarcode.SetDataSet(Value: TDataSet);
begin
  FDataSet := Value;
  if Value <> nil then
    Value.FreeNotification(self);
end;

procedure TSvQRDBBarcode.SetDataField(Value: string);
begin
  FDataField := Value;
end;

procedure TSvQRDBBarcode.Prepare;
begin
  inherited Prepare;
  if Assigned(FDataSet) then
    begin
    Field := FDataSet.FindField(FDataField);
    if (Field <> nil) then
      begin
      FieldNo      := Field.Index;
      CorrectField := True;
      end
    else
      begin
      Field := nil;
      CorrectField := False;
      end;
    end
  else
    begin
    Field := nil;
    CorrectField := False;
    end;
end;

procedure TSvQRDBBarcode.Unprepare;
begin
  Field := nil;
  inherited Unprepare;
  if DataField <> '' then
    SetDataField(DataField) { Reset component caption }
  else
    SetDataField(Name);
end;

procedure TSvQRDBBarcode.ReadValues(Reader: TReader);
begin
  DataSourceName := Reader.ReadIdent;
end;

procedure TSvQRDBBarcode.WriteValues(Writer: TWriter);
begin
end;

procedure TSvQRDBBarcode.Print(OfsX, OfsY: integer);

 Function StringAnd(ands,s1 : string):string;
 var
   I : Integer;
  begin
    result := '';
    while Length(ands) > Length(s1) do
     s1 := '0' + s1;

     for I := 0 to length(ands) do
      if not sametext(ands[i],'0') then
       result := result + ands[i] else
       result := result + s1[i];
  end;

 begin
  if CorrectField then
    begin
    if FDataSet.DefaultFields then
      Field := FDataSet.Fields[FieldNo];
    end
  else
    Field := nil;

  if assigned(Field) then
   begin
     if (Prefix <> '') and (Field.AsString <> '') then
    Text := StringAnd(Prefix,Field.AsString)
     else
    Text := Field.AsString;
   end;

  inherited Print(OfsX, OfsY);
end;


procedure TSvQRDBBarcode.SetPrefix(const Value: string);
begin
  FPrefix := Value;
end;

end.
