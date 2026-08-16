{
  lib,
  pkgs,
  sources,
}: let
  inherit (lib.trivial) importJSON;
  inherit (sources) neovim-nightly-overlay;

  packages = "${neovim-nightly-overlay}/flake/packages";

  neovim-dependencies = import "${packages}/neovim-dependencies.nix" {inherit lib pkgs neovim-src;};
  neovim-src = fetchTree (importJSON "${neovim-nightly-overlay}/flake.lock").nodes.neovim-src.locked;
  tree-sitter = import "${packages}/tree-sitter.nix" {inherit lib pkgs neovim-dependencies;};
in
  import "${packages}/neovim.nix" {inherit lib pkgs neovim-dependencies neovim-src tree-sitter;}
