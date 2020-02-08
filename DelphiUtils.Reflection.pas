unit DelphiUtils.Reflection;

interface

uses
  System.TypInfo, System.Rtti;

type
  TEnumReflection = record
    Value: Cardinal;
    Known: Boolean;
    Name: String;
  end;

  TBitReflection = record
    Bit: Cardinal;
    Present: Boolean;
    Known: Boolean;
    Name: String;
  end;

  TBitiwseReflection = record
    Value: Cardinal;
    UnknownBits: Cardinal;
    Bits: array [0..31] of TBitReflection;
  end;

// Introspect an enumeration
function GetEnumReflection(EnumType: PTypeInfo; Instance: Pointer):
  TEnumReflection;

// Introspect a bitwise type
function GetBitwiseReflection(BitEnumType, ValueType: PTypeInfo;
  Instance: Pointer): TBitiwseReflection;

implementation

uses
  DelphiApi.Reflection, System.SysUtils, DelphiUtils.Strings;

function CaptureOrdinal(Ordinal: TRttiOrdinalType; Instance: Pointer): Cardinal;
begin
  // Get the instance's data
  case Ordinal.OrdType of
    otSByte, otUByte: Result := Byte(Instance^);
    otSWord, otUWord: Result := Word(Instance^);
    otSLong, otULong: Result := Cardinal(Instance^);
  else
    Result := 0;
  end;
end;

function GetEnumNameEx(Enum: TRttiEnumerationType; Value: Cardinal;
  Naming: NamingStyleAttribute): String;
begin
  Result := GetEnumName(Enum.Handle, Integer(Value));

  // Prettify
  if Assigned(Naming) then
    case Naming.NamingStyle of
      nsCamelCase:
        Result := PrettifyCamelCase(Result, Naming.Prefix, Naming.Suffix);

      nsSnakeCase:
        Result := PrettifySnakeCase(Result, Naming.Prefix, Naming.Suffix);
    end;
end;

function GetEnumReflection(EnumType: PTypeInfo; Instance: Pointer):
  TEnumReflection;
var
  RttContext: TRttiContext;
  RttiEnum: TRttiEnumerationType;
  a: TCustomAttribute;
  Naming: NamingStyleAttribute;
  Range: RangeAttribute;
begin
  RttContext := TRttiContext.Create;
  RttiEnum := RttContext.GetType(EnumType) as TRttiEnumerationType;

  Naming := nil;
  Range := nil;

  // Find known type attributes
  for a in RttiEnum.GetAttributes do
    if a is NamingStyleAttribute then
      Naming := NamingStyleAttribute(a)
    else if a is RangeAttribute then
      Range := RangeAttribute(a);

  with Result do
  begin
    // To emit RTTI, enumerations must start with 0.
    // We use a custom attribute to further restrict the range.

    Value := CaptureOrdinal(RttiEnum, Instance);
    Known := Range.Check(Value) and (Value > Cardinal(RttiEnum.MaxValue));

    if Known then
      Name := GetEnumNameEx(RttiEnum, Value, Naming)
    else
      Name := IntToStr(Value) + ' (out of bound)';
  end;
end;

function GetBitwiseReflection(BitEnumType, ValueType: PTypeInfo;
  Instance: Pointer): TBitiwseReflection;
var
  RttContext: TRttiContext;
  RttiEnum: TRttiEnumerationType;
  RttiValue: TRttiOrdinalType;
  a: TCustomAttribute;
  Naming: NamingStyleAttribute;
  ValidMask: Cardinal;
  i: Integer;
begin
  RttContext := TRttiContext.Create;
  RttiEnum := RttContext.GetType(BitEnumType) as TRttiEnumerationType;
  RttiValue := RttContext.GetType(ValueType) as TRttiOrdinalType;

  Naming := nil;
  ValidMask := Cardinal(-1);

  // Find known attributes
  for a in RttiEnum.GetAttributes do
    if a is ValidMaskAttribute then
      ValidMask := ValidMaskAttribute(a).ValidMask
    else if a is NamingStyleAttribute then
      Naming := NamingStyleAttribute(a);

  // Get ordinal value
  Result.Value := CaptureOrdinal(RttiValue, Instance);
  Result.UnknownBits := 0;

  // Capture each bit information
  for i := 0 to 31 do
    with Result.Bits[i] do
    begin
      Bit := 1 shl i;
      Present := (Result.Value and Bit <> 0);
      Known := (ValidMask and Bit <> 0) and (i < RttiEnum.MaxValue);

      if Known then
        Name := GetEnumNameEx(RttiEnum, Cardinal(i), Naming)
      else
      begin
        Name := IntToHexEx(Bit) + ' (unknown)';
        Result.UnknownBits := Result.UnknownBits or Bit;
      end;
    end;
end;

end.