{
  flake,
  inputs,
  lib,
  pkgs,
  stdenv,
}: let
  inherit (flake.packages.${system}) blink-cmp;
  inherit (inputs.neovim-nightly-overlay.packages.${system}) neovim;
  inherit (lib.fileset) toSource;
  inherit (lib.lists) singleton;
  inherit (lib.mnw) npinsToPluginsAttrs wrap;
  inherit (stdenv.hostPlatform) system;
in
  wrap pkgs {
    inherit neovim;

    aliases = ["vi" "vim"];

    appName = "neovim";

    initLua = ''
      require("kkts");
      require("lz.n").load("lazy");
    '';

    plugins = {
      start = singleton (toSource {
        root = ../neovim;
        fileset = ../neovim;
      });
      opt = [blink-cmp];

      startAttrs = npinsToPluginsAttrs pkgs ../npins/start.json;
      optAttrs = npinsToPluginsAttrs pkgs ../npins/opt.json;
    };
  }
