unit SvQrBarcodeReg;

{$I SvQrBarcode.inc}

interface
uses Classes, DesignIntf, DesignEditors;

  type
    {Object Inspector - generic editor for data field names}
    TcFieldsEditor = class(TStringProperty)
  public
     function GetAttributes: TPropertyAttributes; override;
     procedure GetValues(proc: TGetStrProc); override;
  end;

procedure Register;

implementation
uses DB, SvQrBarcode;
{$R *.dcr}


function TcFieldsEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paAutoUpdate, paValueList, paReadOnly, paSortList];
end;

procedure TcFieldsEditor.GetValues(proc: TGetStrProc);
var
  ThisComponent: TSvQRDBBarcode;
  Counter: Integer;
begin
  {Provide list of fields to Object Inspector...}
  ThisComponent := TSvQRDBBarcode(GetComponent(0));
  with ThisComponent do
  try
    if DataSet <> nil
    then
	{List every field in the selected DataSet}
	for Counter := 0 to DataSet.FieldCount-1 do
{	  if DataSet.Fields[Counter].DataType in [ftString, ftSmallint, ftInteger, ftWord]
        then}
	    proc(DataSet.Fields[Counter].FieldName);
  except
      {Raise exception}
{$ifdef WIN32}
{    DatabaseError(SDatabaseNameMissing);}
    DatabaseError('Database Alias Missing');
{$else}
    DatabaseError('Database Alias Missing');
{$endif}
  end;
end;




procedure Register;
begin
  RegisterComponents('QReport', [TSvQRBarcode, TSvQRDBBarcode]);
  RegisterPropertyEditor(TypeInfo(String), TSvQRDBBarcode,
			 'DataField', TcFieldsEditor);
end;

end.
