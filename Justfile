templates_dir := "./templates"
base_template := "./templates/devshell-base"

default:
    @just -l

new template_name:
    #!/usr/bin/env bash
    target="{{templates_dir}}/{{template_name}}"
    mkdir -p "$target"
    cp {{base_template}}/flake.nix $target/flake.nix
    cp {{base_template}}/.envrc $target/.envrc