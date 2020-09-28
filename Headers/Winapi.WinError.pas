unit Winapi.WinError;

{$MINENUMSIZE 4}

interface

const
  ERROR_SUCCESS = 0;
  ERROR_ACCESS_DENIED = 5;
  ERROR_BAD_LENGTH = 24;
  ERROR_INVALID_PARAMETER = 87;
  ERROR_CALL_NOT_IMPLEMENTED = 120;
  ERROR_INSUFFICIENT_BUFFER = 122;
  ERROR_ALREADY_EXISTS = 183;
  ERROR_MORE_DATA = 234;
  WAIT_TIMEOUT = 258;
  ERROR_MR_MID_NOT_FOUND = 317;
  ERROR_CANT_ENABLE_DENY_ONLY = 629;
  ERROR_NO_TOKEN = 1008;
  ERROR_IMPLEMENTATION_LIMIT = 1292;
  ERROR_NOT_ALL_ASSIGNED = 1300;
  ERROR_INVALID_OWNER = 1307;
  ERROR_INVALID_PRIMARY_GROUP = 1308;
  ERROR_CANT_DISABLE_MANDATORY = 1310;
  ERROR_PRIVILEGE_NOT_HELD = 1314;
  ERROR_BAD_IMPERSONATION_LEVEL = 1346;

  DISP_E_EXCEPTION = HRESULT($80020009);

function Succeeded(Status: HRESULT): LongBool; inline;
function HRESULT_CODE(hr: HRESULT): Cardinal; inline;

implementation

function Succeeded(Status: HRESULT): LongBool;
begin
  Result := Status and HRESULT($80000000) = 0;
end;

function HRESULT_CODE(hr: HRESULT): Cardinal;
begin
  Result := hr and $FFFF;
end;

end.
