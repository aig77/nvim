{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    # Tools for developing this Neovim configuration
    lua
    stylua
    luacheck
  ];

  shellHook = ''
    echo "Neovim config development environment"
    echo "Use 'stylua .' to format and 'luacheck . --globals vim' to lint"
  '';
}
