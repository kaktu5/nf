{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    mnw.url = "github:gerg-l/mnw";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
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
      devShells.default = import ./internal/devshell.nix {inherit lib pkgs;};

      formatter = import ./internal/formatter.nix {inherit lib pkgs;};

      packages = import ./internal/packages.nix {inherit inputs lib pkgs self;};
    });
}
