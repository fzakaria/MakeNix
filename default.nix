let
  pkgs =
    import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/5ef6c425980847c78a80d759abc476e941a9bf42.tar.gz") {
    };
  fs = pkgs.lib.fileset;
in
  with pkgs;
    builtins.outputOf
    (stdenvNoCC.mkDerivation {
      name = "result.drv";
      outputHashMode = "text";
      outputHashAlgo = "sha256";
      requiredSystemFeatures = ["recursive-nix"];

      src = fs.toSource {
        root = ./.;
        fileset = fs.unions [
          (fs.fromSource (lib.sources.sourceByRegex ./src [ ".*\.c$" ]))
          (fs.fromSource (lib.sources.sourceByRegex ./src [ ".*\.h$" ]))
          ./parser
          ./Makefile
        ];
      };

      buildInputs = [nix go gcc];

      buildPhase = ''
        make deps
        
        go run parser/parser.go > derivation.nix
      '';

      installPhase = ''
        cp $(nix-instantiate derivation.nix --arg pkgs 'import ${pkgs.path} {}') $out
      '';
    }).outPath "out"
