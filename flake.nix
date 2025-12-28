{
  description = "A Nix-flake-based LaTeX development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    moderncv = {
      url = "github:moderncv/moderncv";
      flake = false;
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = (import inputs.systems);
      perSystem =
        { pkgs, self', ... }:
        let
          # See: https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/texlive.section.md#users-guide-experimental-new-interface-sec-language-texlive-user-guide-experimental
          texlive-combined = pkgs.texliveBasic.withPackages (
            ps: with ps; [
              pgf # provides tikz.sty
              xcolor
              cm-super
              arydshln
              multirow
              microtype
              fontawesome5
            ]
          );
        in
        {
          packages.default = pkgs.callPackage ./default.nix {
            inherit texlive-combined;
            inherit (inputs) moderncv;
          };

          devShells.default = pkgs.mkShellNoCC {
            TEXINPUTS = ".:${inputs.moderncv}:";
            packages = [
              texlive-combined
              pkgs.texlab
            ];
          };
        };
    };
}
