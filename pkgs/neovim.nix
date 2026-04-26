{
  inputs,
  lib,
  pkgs,
  stdenv,
}: let
  inherit (inputs.neovim-nightly-overlay.packages.${system}) neovim;
  inherit (lib.mnw) wrap;
  inherit (stdenv.hostPlatform) system;
in
  wrap pkgs {
    inherit neovim;

    initLua = ''
      print("Hello, World!");
    '';
  }
