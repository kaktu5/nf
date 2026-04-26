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
      inherit (pkgs) alejandra deno fd;
    };
    text = ''
      fd "$@" -t f -e md -X deno fmt '{}'
      fd "$@" -t f -e nix -X alejandra --quiet '{}'
    '';
  }
