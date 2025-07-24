{
  lib,
  stdenvNoCC,
}:
let
  fs = lib.fileset;
  sourceFiles = fs.intersection (fs.unions [
    ./src/dotl_bud/db
    ./src/dotl_bud/filter
    ./src/dotl_bud/perms
    ./src/dotl_bud/help
  ]) (fs.fileFilter (file: !(file.hasExt "py")) ./.);
in
stdenvNoCC.mkDerivation {
  pname = "dotl-bud-db";
  version = "0.0.1";

  src = fs.toSource {
    root = ./.;
    fileset = sourceFiles;
  };

  postInstall = ''
    mkdir -p $out
    cp -R ./src/dotl_bud/* $out
  '';
}
