{
  lib,
  buildPythonPackage,

  # Build system
  hatchling,

  # Third-party dependencies
  discordpy,
  feedparser,
}:
let
  fs = lib.fileset;
  sourceFiles = fs.unions [
    ./pyproject.toml
    ./src/dotl_bud
  ];
in
buildPythonPackage {
  pname = "dotl-bud-lib";
  version = "0.0.1";
  pyproject = true;

  src = fs.toSource {
    root = ./.;
    fileset = sourceFiles;
  };

  build-system = [ hatchling ];

  dependencies = [
    discordpy
    feedparser
  ];
}
