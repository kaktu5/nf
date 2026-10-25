{
  outputs = {self, ...} @ args: let
    inputs = (import ./.tack) {overrides = args.tackOverrides or {};};

    inherit (lib.fixedPoints) fix;

    mnw = fix <| import "${inputs.mnw}/outputs.nix";
    lib = inputs.nixpkgs.lib // {mnw = mnw.lib;};

    inherit (lib.attrsets) mapAttrs zipAttrsWith;
    inherit (lib.lists) foldl';

    mapSystems = systems: f:
      systems
      |> map (s: f s |> mapAttrs (_: v: {${s} = v;}))
      |> zipAttrsWith (_: foldl' (a: b: a // b) {});
  in
    mapSystems ["aarch64-linux" "x86_64-linux"] (system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      devShells.default = import ./flake/devshell.nix {inherit inputs lib pkgs system;};

      formatter = import ./flake/formatter.nix {inherit lib pkgs;};

      packages = import ./flake/packages.nix {inherit inputs lib pkgs;};
    });
}
