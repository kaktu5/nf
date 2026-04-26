{
  lib,
  pkgs,
}: let
  inherit (lib.attrsets) attrValues;
  inherit (pkgs) writeShellApplication;
in
  writeShellApplication {
    name = "nf-nix3-fmt-wrapper";
    runtimeInputs = attrValues {
      inherit (pkgs) alejandra fd mdformat stylua;
    };
    text = ''
      fd "$@" -t f -e lua -X stylua '{}'
      fd "$@" -t f -e md -X mdformat '{}'
      fd "$@" -t f -e nix -E npins/ -X alejandra --quiet '{}'
    '';
  }
