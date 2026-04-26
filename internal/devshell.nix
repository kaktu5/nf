{
  lib,
  pkgs,
}: let
  inherit (lib.attrsets) attrValues;
  inherit (pkgs) mkShellNoCC;

  selene' = (pkgs.selene.overrideAttrs (old: {
    cargoBuildFlags = old.cargoBuildFlags or [] ++ ["--features=lua52"];
  })).override {robloxSupport = false;};
in
  mkShellNoCC {
    name = "nf-devshell";
    packages = attrValues {
      # lua
      inherit selene';
      inherit (pkgs) lua-language-server stylua;

      # markdown
      inherit (pkgs) markdownlint-cli2 marksman mdformat;

      # nix
      inherit (pkgs) alejandra dix nixd npins;

      # toml
      inherit (pkgs) taplo tombi;
    };
  }
