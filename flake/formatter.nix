{
  inputs,
  lib,
  pkgs,
}: let
  inherit (inputs.alejandra.overlays.default pkgs {}) alejandra;
  inherit (lib.attrsets) attrValues;
  inherit (pkgs) writeShellApplication;
in
  writeShellApplication {
    name = "nf-nix3-fmt-wrapper";

    runtimeInputs = attrValues {
      inherit alejandra;
      inherit (pkgs) fd mdformat stylua tombi;
    };

    runtimeEnv.RUST_LOG = "warn";

    text = ''
      fd "$@" -t f -e lua -X stylua
      fd "$@" -t f -e md -X mdformat
      fd "$@" -t f -e nix -E .tack/default.nix -X alejandra --quiet
      fd "$@" -t f -e toml -X tombi format
    '';
  }
