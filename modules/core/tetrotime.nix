
{ lib, pkgs, ... }:

let
  tetrotime-unwrapped = pkgs.rustPlatform.buildRustPackage {
    pname = "tetrotime";
    version = "1.0.2";

    src = pkgs.fetchurl {
      name = "tetrotime-1.0.2.tar.gz";
      url = "https://static.crates.io/crates/tetrotime/tetrotime-1.0.2.crate";
      hash = "sha256-vVfgdE4iMHXoDmX9X1pii1J3YPG4e0Mt3eLFdI7GBVY=";
    };

    postPatch = ''
      cp ${./Cargo.lock} Cargo.lock
    '';

    cargoLock = {
      lockFile = ./Cargo.lock;
    };

    meta = {
      description = "A tetromino-based terminal clock, stopwatch and timer";
      homepage = "https://github.com/jakobwesthoff/tetrotime";
      license = lib.licenses.mit;
      mainProgram = "tetrotime";
      platforms = lib.platforms.linux;
    };
  };

  tetrotime = pkgs.writeShellScriptBin "tetrotime" ''
    ${tetrotime-unwrapped}/bin/tetrotime "$@"
    status=$?
    printf '\033[<u'
    exit "$status"
  '';
in
{
  environment.systemPackages = [
    tetrotime
  ];
}

