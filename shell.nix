{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    # Tools for developing this Neovim configuration
    lua
    stylua
  ];

  shellHook = ''
    echo "Neovim config development environment"
  '';
}
