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
        {
          packages.default = pkgs.callPackage ./default.nix {
            inherit (inputs) moderncv;
          };

          devShells.default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              texlive.combined.scheme-full
              texlab
            ];
          };
        };
    };
}
