{
  description = "My personal Nix flake templates";

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
            just
          ];

          shellHook = ''
            echo "Devshell started successfully"
          '';
        };
      }
    )
    // {
      templates = {
        devshell-base = {
          path = ./templates/devshell-base;
          description = "A flake with an empty devshell";
        };
        rust = {
          path = ./templates/rust;
          description = "A base template for any rust project";
        };
        cargo-workspace = {
          path = ./templates/cargo-workspace;
          description = "A base template for a new cargo workspace project";
        };
        haskell = {
          path = ./templates/haskell;
          description = "A base template with the haskell toolchain and just";
        };
        zensical = {
          path = ./templates/zensical;
          description = "A base template for a documentation site using zensical";
        };
        nuxt-starter = {
          path = ./templates/nuxt-starter;
          description = "Nuxt app starter with auth set up";
        };
        php = {
          path = ./templates/php;
          description = "Basic php flake";
        };
      };
    };
}
