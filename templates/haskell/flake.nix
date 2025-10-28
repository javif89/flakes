{
  description = "DevShell flake for my application";

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
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            haskellPackages.ghc
            haskell-language-server
            haskellPackages.cabal-install
            just
          ];

          shellHook = ''
            echo "Devshell started successfully"
          '';
        };
      }
    );
}
