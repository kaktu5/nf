# based on https://github.com/gerg-l/nvim-flake/blob/50f4f389774779d14bc32a982352207ea113b840/packages/blink-cmp/package.nix
{
  lib,
  sources,
  rust-jemalloc-sys,
  rustPlatform,
  stdenv,
}: let
  inherit (lib.lists) optional;
  inherit (lib.strings) substring;
  inherit (rustPlatform) buildRustPackage;
  inherit (sources) blink-cmp;
  inherit (stdenv.hostPlatform) isAarch64;
in
  buildRustPackage {
    pname = "blink.cmp";
    version = substring 0 7 blink-cmp.revision;

    src = blink-cmp;
    cargoLock.lockFile = blink-cmp + /Cargo.lock;

    buildInputs = optional isAarch64 rust-jemalloc-sys;

    # tries to call git
    preBuild = "rm build.rs";

    postInstall = ''
      cp -r {lua,plugin} $out/
      mkdir -p $out/doc
      cp doc/*.txt $out/doc/
    '';

    # don't move /doc to $out/share
    forceShare = [];
  }
