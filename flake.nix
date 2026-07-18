{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";

    mnw.url = "github:gerg-l/mnw";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    sources = import ./npins;

    lib = nixpkgs.lib // {mnw = inputs.mnw.lib;};

    inherit (lib.attrsets) mapAttrs zipAttrsWith;
    inherit (lib.lists) foldl';

    mapSystems = systems: f:
      systems
      |> map (s: f s |> mapAttrs (_: v: {${s} = v;}))
      |> zipAttrsWith (_: foldl' (a: b: a // b) {});
  in
    mapSystems ["aarch64-linux" "x86_64-linux"] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.default = import ./flake/devshell.nix {inherit lib pkgs;};

      formatter = import ./flake/formatter.nix {inherit lib pkgs;};

      packages = import ./flake/packages.nix {inherit inputs lib pkgs sources;};
    });
}
