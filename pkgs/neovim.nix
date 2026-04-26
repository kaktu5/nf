{
  inputs,
  lib,
  pkgs,
  stdenv,
}: let
  inherit (inputs.neovim-nightly-overlay.packages.${system}) neovim;
  inherit (lib.fileset) toSource;
  inherit (lib.lists) singleton;
  inherit (lib.mnw) npinsToPluginsAttrs wrap;
  inherit (stdenv.hostPlatform) system;
in
  wrap pkgs {
    inherit neovim;

    aliases = ["vi" "vim"];

    initLua = ''
      require("kkts");
      require("lz.n").load("lazy");
    '';

    plugins = {
      start = singleton (toSource {
        root = ../neovim;
        fileset = ../neovim;
      });

      startAttrs = npinsToPluginsAttrs pkgs ../npins/start.json;
      optAttrs = npinsToPluginsAttrs pkgs ../npins/opt.json;
    };
  }
