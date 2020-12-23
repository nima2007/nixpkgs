{ stdenv
, fetchFromGitHub
, pkgconfig
, meson
, ninja
, zstd
, curl
, argp-standalone
}:

stdenv.mkDerivation rec {
  pname = "zchunk";
  version = "1.1.8";

  outputs = [ "out" "lib" "dev" ];

  src = fetchFromGitHub {
    owner = "zchunk";
    repo = pname;
    rev = version;
    sha256 = "0q1jafxh5nqgn2w5ciljkh8h46xma0qia8a5rj9m0pxixcacqj6q";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
  ];

  buildInputs = [
    zstd
    curl
  ] ++ stdenv.lib.optional stdenv.isDarwin argp-standalone;

  patches = [ ./darwin.patch ];

  meta = with stdenv.lib; {
    description = "File format designed for highly efficient deltas while maintaining good compression";
    homepage = "https://github.com/zchunk/zchunk";
    license = licenses.bsd2;
    maintainers = with maintainers; [];
    platforms = platforms.unix;
  };
}
