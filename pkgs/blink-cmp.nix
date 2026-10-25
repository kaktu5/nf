# based on https://github.com/gerg-l/nvim-flake/blob/50f4f389774779d14bc32a982352207ea113b840/packages/blink-cmp/package.nix
{
  inputs,
  lib,
  rust-jemalloc-sys,
  rustPlatform,
  stdenv,
}: let
  inherit (inputs) blink-cmp;
  inherit (inputs._meta.blink-cmp) rev;
  inherit (lib.lists) optional;
  inherit (lib.strings) substring;
  inherit (rustPlatform) buildRustPackage;
  inherit (stdenv.hostPlatform) isAarch64;
in
  buildRustPackage (finalAttrs: {
    pname = "blink.cmp";
    version = substring 0 7 rev;

    src = blink-cmp;
    cargoLock.lockFile = "${finalAttrs.src}/Cargo.lock";

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
  })
