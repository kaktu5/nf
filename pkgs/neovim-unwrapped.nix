{
  lib,
  pkgs,
  sources,
  neovim-dependencies,
  neovim-src,
  tree-sitter,
}: let
  inherit (sources) neovim-nightly-overlay;
in
  import (neovim-nightly-overlay + /flake/packages/neovim.nix) {inherit lib pkgs neovim-dependencies neovim-src tree-sitter;}
