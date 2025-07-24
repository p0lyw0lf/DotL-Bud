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
        pkgs = nixpkgs.legacyPackages.${system}.extend (
          final: prev: {
            python3 = prev.python3.override {
              packageOverrides = final: prev: {
                dotl-bud-lib = final.callPackage ./dotl-bud/package-lib.nix { };
              };
            };
          }
        );

        dotl-bud-bin = pkgs.callPackage ./dotl-bud/package-bin.nix { };
        dotl-bud-db = pkgs.callPackage ./dotl-bud/package-db.nix { };
      in
      {
        packages = {
          inherit dotl-bud-bin dotl-bud-db;
          inherit (pkgs) python3;
        };
        devShells.default = pkgs.callPackage ./shell.nix { };
      }
    );
}
