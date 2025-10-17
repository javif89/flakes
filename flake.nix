{
  description = "My personal Nix flake templates";

  outputs =
    { self }:
    {
      templates = {
        devshell-base = {
          path = ./templates/devshell-base;
          description = "A flake with an empty devshell";
        };
      };
    };
}
