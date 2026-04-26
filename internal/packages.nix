{
  inputs,
  lib,
  pkgs,
  self,
}: let
  inherit (lib.customisation) callPackageWith;
  inherit (lib.filesystem) packagesFromDirectoryRecursive;
  inherit (lib.fixedPoints) fix;
in
  fix (final:
    packagesFromDirectoryRecursive {
      callPackage = callPackageWith (pkgs // final // {inherit inputs lib;});
      directory = self + /pkgs;
    })
