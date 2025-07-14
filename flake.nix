{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python3 = pkgs.python3.override {
          packageOverrides = final: prev: {
            dotl-bud-lib = final.callPackage ./dotl-bud/package-lib.nix { };
          };
        };

        dotl-bud-bin = pkgs.callPackage ./dotl-bud/package-bin.nix {
          python3-bot-crossposter-env = python3.withPackages (ps: [
            ps.dotl-bud-lib
          ]);
        };
      in
      {
        packages = {
          inherit
            python3
            dotl-bud-bin
            ;
        };
        devShells.default = (import ./shell.nix) { inherit pkgs; };
      }
    );
}
