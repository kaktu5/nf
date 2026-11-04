{
  inputs,
  lib,
  pkgs,
  blink-cmp,
  fd,
  neovim-unwrapped,
  ripgrep,
}: let
  inherit (lib.attrsets) filterAttrs listToAttrs mapAttrsToList;
  inherit (lib.fileset) toSource;
  inherit (lib.lists) singleton;
  inherit (lib.mnw) wrap;
  inherit (lib.strings) substring;
  inherit (lib.trivial) importTOML;
  inherit (pkgs.vimUtils) buildVimPlugin;

  mkPlugin = name: let
    meta = inputs._meta.${name};
    version = meta.version or (substring 0 7 meta.rev);
  in {
    name = meta.repo;
    value = buildVimPlugin {
      pname = name;
      inherit version;
      src = inputs.${name};
      doCheck = false;
    };
  };

  pluginsIn = group:
    inputs._meta
    |> filterAttrs (_: v: (v.group or null) == group)
    |> mapAttrsToList (name: _: mkPlugin name)
    |> listToAttrs;
in
  wrap pkgs {
    neovim = neovim-unwrapped;

    aliases = ["vi" "vim"];

    appName = "neovim";

    initLua = ''
      require("kkts");
      LZN = require("lz.n");
      LZN.load("lazy");
    '';

    plugins = {
      start = singleton (toSource {
        root = ../neovim;
        fileset = ../neovim;
      });
      opt = [blink-cmp];

      startAttrs =
        pluginsIn "start"
        // {
          inherit
            (pkgs.vimPlugins.nvim-treesitter-parsers)
            nix
            rust
            typst
            ;
        };
      optAttrs = pluginsIn "opt";
    };

    extraBinPath = [fd ripgrep];
  }
