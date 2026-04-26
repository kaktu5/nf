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
      # nix
      inherit (pkgs) alejandra dix nixd npins;
    };
  }
