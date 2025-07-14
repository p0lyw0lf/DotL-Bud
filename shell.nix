{ pkgs }:
pkgs.mkShell {
  packages = (
    with pkgs;
    [
      (python3.withPackages (
        ps: with ps; [
          # For pyright language server
          autopep8
          # For building packages
          build
        ]
      ))

      # The python environments themselves are managed with hatch
      hatch
      pyright
    ]
  );
}
