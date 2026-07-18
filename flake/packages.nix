{
  inputs,
  lib,
  pkgs,
  self,
  sources,
}: let
  inherit (lib.customisation) callPackageWith;
  inherit (lib.filesystem) packagesFromDirectoryRecursive;
  inherit (lib.fixedPoints) fix;

  flake = self;
in
  fix (final:
    packagesFromDirectoryRecursive {
      callPackage = callPackageWith (pkgs // final // {inherit flake inputs lib sources;});
      directory = self + /pkgs;
    })
