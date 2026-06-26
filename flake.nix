{
  inputs = {
    homelab.url = "git+ssh://git@github.com/GrimOutlook/nix-homelab";

    nix-config = {
      url = "github:GrimOutlook/nix-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, ... }:
    {
      nixosModules.default = ./modules/default.nix;
    };
}
