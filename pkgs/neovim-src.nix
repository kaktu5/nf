{
  lib,
  sources,
}: let
  inherit (lib.trivial) importJSON;
  inherit (sources) neovim-nightly-overlay;
in
  fetchTree (importJSON (neovim-nightly-overlay + /flake.lock)).nodes.neovim-src.locked
