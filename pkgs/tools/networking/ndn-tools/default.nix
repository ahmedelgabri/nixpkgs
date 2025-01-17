{ lib
, stdenv
, boost
, fetchFromGitHub
, libpcap
, ndn-cxx
, openssl
, pkg-config
, sphinx
, wafHook
}:

stdenv.mkDerivation rec {
  pname = "ndn-tools";
  version = "0.7.1";

  src = fetchFromGitHub {
    owner = "named-data";
    repo = pname;
    rev = "ndn-tools-${version}";
    sha256 = "1q2d0v8srqjbvigr570qw6ia0d9f88aj26ccyxkzjjwwqdx3y4fy";
  };

  nativeBuildInputs = [ pkg-config sphinx wafHook ];
  buildInputs = [ libpcap ndn-cxx openssl ];

  wafConfigureFlags = [
    "--boost-includes=${boost.dev}/include"
    "--boost-libs=${boost.out}/lib"
    "--with-tests"
  ];

  doCheck = true;
  checkPhase = ''
    build/unit-tests
  '';

  meta = with lib; {
    homepage = "https://named-data.net/";
    description = "Named Data Neworking (NDN) Essential Tools";
    license = licenses.gpl3Plus;
    platforms = platforms.unix;
    maintainers = with maintainers; [ bertof ];
  };
}
