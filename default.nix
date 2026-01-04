{
  lib,
  just,
  stdenvNoCC,
  texlive-combined,
}:

let
  fs = lib.fileset;
in
stdenvNoCC.mkDerivation {
  pname = "curriculumvitae";
  version = "0.1.0";

  src = fs.toSource {
    root = ./.;
    fileset = fs.unions [
      ./cv.tex
      ./justfile
    ];
  };

  buildInputs = [
    just
    texlive-combined
  ];

  buildPhase = ''
    just build
  '';

  installPhase = ''
    just install $out
  '';
}
