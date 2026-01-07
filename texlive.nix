# Minimal latex distribution to build my cv
# See: https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/texlive.section.md#users-guide-experimental-new-interface-sec-language-texlive-user-guide-experimental
{ texliveBasic, ... }:
texliveBasic.withPackages (
  ps: with ps; [
    moderncv # provides template
    pgf # provides tikz.sty
    bookmark # provides newer implementation for single-pass reference resolution
    luatex # luatex implementation for academicons

    xcharter # Charter font with LaTeX support
    xkeyval # xcharter dependency
    xstring # xcharter dependency
    fontaxes # xcharter dependency
  ]
)
