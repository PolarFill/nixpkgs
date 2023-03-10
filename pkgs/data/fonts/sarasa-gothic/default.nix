{ lib, stdenvNoCC, fetchurl, p7zip }:

stdenvNoCC.mkDerivation rec {
  pname = "sarasa-gothic";
  version = "0.40.2";

  src = fetchurl {
    # Use the 'ttc' files here for a smaller closure size.
    # (Using 'ttf' files gives a closure size about 15x larger, as of November 2021.)
    url = "https://github.com/be5invis/Sarasa-Gothic/releases/download/v${version}/sarasa-gothic-ttc-${version}.7z";
    hash = "sha256-ZarDttwwZzBb0+iBipVHZGLf1K3lQ7xvjMR6jE3hmh8=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [ p7zip ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp *.ttc $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = "A CJK programming font based on Iosevka and Source Han Sans";
    homepage = "https://github.com/be5invis/Sarasa-Gothic";
    license = licenses.ofl;
    maintainers = [ maintainers.ChengCat ];
    platforms = platforms.all;
  };
}
