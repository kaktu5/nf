{
  lib,
  pkgs,
  sources,
  neovim-dependencies,
  ...
}: let
  inherit (sources) neovim-nightly-overlay;
in
  import (neovim-nightly-overlay + /flake/packages/tree-sitter.nix) {inherit lib pkgs neovim-dependencies;}
