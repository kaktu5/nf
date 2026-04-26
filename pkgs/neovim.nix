{
  inputs,
  lib,
  pkgs,
  stdenv,
}: let
  inherit (inputs.neovim-nightly-overlay.packages.${system}) neovim;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.fileset) toSource;
  inherit (lib.lists) singleton;
  inherit (lib.mnw) wrap;
  inherit (stdenv.hostPlatform) system;

  npinsToPlugins = input: let
    fetchPin = _: pin: pin {inherit pkgs;};
    npins' = import ../npins {inherit input;};
  in
    mapAttrs fetchPin npins';
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

      startAttrs = npinsToPlugins ../npins/start.json;
      optAttrs = npinsToPlugins ../npins/opt.json;
    };
  }
