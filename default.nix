{
  lib,
  stdenvNoCC,
  texlive-combined,
  template,
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
    texlive-combined
  ];

  buildPhase = ''
    # Expose the template path to xelatex
    export TEXINPUTS=".:${template}:"
    (lualatex -interaction=nonstopmode cv.tex) \
        || (biber cv && lualatex -interaction=nonstopmode cv.tex || return 0)
  '';

  installPhase = ''
    mkdir -p $out
    cp cv.pdf $out/
  '';
}
