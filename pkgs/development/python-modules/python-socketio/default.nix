{ lib
, aiohttp
, bidict
, buildPythonPackage
, fetchFromGitHub
, mock
, msgpack
, pytestCheckHook
, python-engineio
, pythonOlder
, requests
, websocket-client
}:

buildPythonPackage rec {
  pname = "python-socketio";
  version = "5.4.1";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "miguelgrinberg";
    repo = "python-socketio";
    rev = "v${version}";
    sha256 = "sha256-qmC7AL2ZNB0D5p3c8ozacNMKc2COzYzPJfz6KXwWsd0=";
  };

  propagatedBuildInputs = [
    aiohttp
    bidict
    python-engineio
    requests
    websocket-client
  ];

  checkInputs = [
    mock
    msgpack
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "socketio"
  ];

  meta = with lib; {
    description = "Python Socket.IO server and client";
    longDescription = ''
      Socket.IO is a lightweight transport protocol that enables real-time
      bidirectional event-based communication between clients and a server.
    '';
    homepage = "https://github.com/miguelgrinberg/python-socketio/";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ mic92 ];
  };
}
