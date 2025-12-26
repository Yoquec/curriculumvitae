{
  lib,
  stdenvNoCC,
  texlive,
  texlivePackages,
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
      # Add other files as needed (e.g., images, .cls files)
    ];
  };

  buildInputs = [
    texlive.combined.scheme-full
    texlivePackages.latexmk
  ];

  buildPhase = ''
    latexmk -pdf cv.tex
  '';

  installPhase = ''
    mkdir -p $out
    cp cv.pdf $out/
  '';
}
