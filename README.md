# Nix Flake Templates

This project contains my templates for different types of projects.

Included so far:

- `devshell-base`: Just an empty devshell to avoid having to type boilerplate
- `rust`: Base template for any rust project
- `cargo-workspace`: New workspace for a rust project
- `haskell`: Basic haskell project 
- `zensical`: New documentation site using the zensical static site generator.

## Usage

`nix flake init -t github:javif89/flakes#[template name]`