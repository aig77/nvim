{pkgs ? import <nixpkgs> {}}: let
  pre-commit-hooks = import (
    builtins.fetchTarball
    "https://github.com/cachix/pre-commit-hooks.nix/tarball/master"
  );

  pre-commit-check = pre-commit-hooks.run {
    src = ./.;
    hooks = {
      stylua.enable = true;
      luacheck = {
        enable = true;
        args = ["init.lua" "./lua" "--globals" "vim"];
      };
    };
  };
in
  pkgs.mkShell {
    inherit (pre-commit-check) shellHook;
    packages = with pkgs; [lua git];
  }
