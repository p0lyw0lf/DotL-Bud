{
  lib,
  stdenvNoCC,

  python3,
}:
let
  python3-dotl-bud-env = python3.withPackages (ps: [ ps.dotl-bud-lib ]);
in
stdenvNoCC.mkDerivation {
  pname = "dotl-bud-bin";
  version = "0.0.1";

  buildInputs = [
    python3-dotl-bud-env
  ];

  src = ./bin;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cat <<EOF > $out/bin/dotl-bud
    #!/usr/bin/env bash
    "${lib.getExe python3-dotl-bud-env}" -m dotl_bud "\$@"
    EOF
    chmod +x $out/bin/dotl-bud

    runHook postInstall
  '';

  meta = {
    mainProgram = "dotl-bud";
  };
}
