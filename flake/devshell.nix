{
  inputs,
  lib,
  pkgs,
  system,
}: let
  inherit (inputs.tack.packages.${system}) tack;
  inherit (lib.attrsets) attrValues;
  inherit (pkgs) mkShellNoCC;

  selene' = (pkgs.selene.overrideAttrs (old: {
    cargoBuildFlags = old.cargoBuildFlags or [] ++ ["--features=lua52"];
  })).override {robloxSupport = false;};
in
  mkShellNoCC {
    name = "nf-devshell";

    env.TACK_NIX_CONF_TOKENS = "1";

    packages = attrValues {
      # lua
      inherit selene';
      inherit (pkgs) lua-language-server stylua;

      # markdown
      inherit (pkgs) markdownlint-cli2 marksman mdformat;

      # nix
      inherit tack;
      inherit (pkgs) alejandra dix nixd;

      # toml
      inherit (pkgs) taplo tombi;
    };
  }
