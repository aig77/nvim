{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";
  };

  outputs = inputs @ {
    flake-parts,
    devenv,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [devenv.flakeModule];
      systems = ["x86_64-linux" "aarch64-darwin"];

      perSystem = {pkgs, ...}: {
        devenv.shells.default = {
          languages = {
            lua.enable = true;

            nix = {
              enable = true;
              lsp.package = pkgs.nixd;
            };
          };

          git-hooks.hooks = {
            alejandra.enable = true;
            statix.enable = true;
            stylua.enable = true;
            luacheck = {
              enable = true;
              args = ["init.lua" "./lua" "--globals" "vim"];
            };
          };
        };
      };
    };
}
