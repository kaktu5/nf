{
  lib,
  blink-cmp,
  neovim-unwrapped,
  pkgs,
}: let
  inherit (lib.fileset) toSource;
  inherit (lib.lists) singleton;
  inherit (lib.mnw) npinsToPluginsAttrs wrap;
in
  wrap pkgs {
    neovim = neovim-unwrapped;

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
