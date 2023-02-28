# -*- fill-column: 100; tab-width: 2 -*-

{
  description = "Haskell Tiny Game Jam";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      hPkgs = pkgs.haskell.packages.ghc926; # need to match Stackage LTS version

      myDevTools = [
        pkgs.zlib
        pkgs.libGL
        pkgs.libGLU
        pkgs.freeglut
        # GHC compiler in the desired version (will be available on PATH)
        # including popular libraries used by tiny games
        (hPkgs.ghcWithPackages(p: [p.random p.ansi-terminal-game p.gloss]))
        stack-wrapped
      ];

      # Wrap Stack to work with our Nix integration. We don't want to modify
      # stack.yaml so non-Nix users don't notice anything.
      # - no-nix: We don't want Stack's way of integrating Nix.
      # --system-ghc    # Use the existing GHC on PATH (will come from this Nix file)
      # --no-install-ghc  # Don't try to install GHC if no matching GHC found on PATH
      stack-wrapped = pkgs.symlinkJoin {
        name = "stack"; # will be available as the usual `stack` in terminal
        paths = [ pkgs.stack ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
        wrapProgram $out/bin/stack \
          --add-flags "\
            --no-nix \
            --system-ghc \
            --no-install-ghc \
          "
      '';
      };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = myDevTools;

        # Make external Nix c libraries like zlib known to GHC, like
        # pkgs.haskell.lib.buildStackProject does
        # https://github.com/NixOS/nixpkgs/blob/d64780ea0e22b5f61cd6012a456869c702a72f20/pkgs/development/haskell-modules/generic-stack-builder.nix#L38
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath myDevTools;
      };
    });
}
