{
  lib,
  pkgs,
}: let
  inherit (lib.attrsets) attrValues;
  inherit (pkgs) mkShellNoCC;
in
  mkShellNoCC {
    name = "nf-devshell";
    packages = attrValues {
      # lua
      inherit (pkgs) lua-language-server selene stylua;

      # markdown
      inherit (pkgs) markdownlint-cli2 marksman mdformat;

      # nix
      inherit (pkgs) alejandra dix nixd npins;

      # toml
      inherit (pkgs) taplo tombi;
    };
  }
