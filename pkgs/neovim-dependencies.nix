{
  lib,
  pkgs,
  sources,
  neovim-src,
}: let
  inherit (sources) neovim-nightly-overlay;
in
  import (neovim-nightly-overlay + /flake/packages/neovim-dependencies.nix) {inherit lib pkgs neovim-src;}
