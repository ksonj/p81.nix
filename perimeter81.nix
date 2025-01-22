{ stdenv, dpkg, writeText }:
stdenv.mkDerivation rec {
  pname = "perimeter81";
  version = "10.0.1.885";
  src = builtins.fetchurl {
    url =
    "https://static.perimeter81.com/agents/linux/Perimeter81_${version}.deb";
    sha256 = "sha256:128wx6bnxc48vwfp0spqnjbaa3zaj2szdwdl1zif2r8y7p80khgv";
  };

  nativeBuildInputs = [ dpkg ];

  unpackPhase = ''
    runHook preUnpack

    dpkg-deb -x $src .

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    cp -R "opt" "$out"
    cp -R "usr/share" "$out/share"
    chmod -R g-w "$out"

    # Desktop file
    mkdir -p "$out/share/applications"

    runHook postInstall
  '';
 
}
