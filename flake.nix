{
  inputs = {
    homelab.url = "git+ssh://git@github.com/GrimOutlook/nix-homelab";

    nix-config = {
      url = "github:GrimOutlook/nix-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs =
    { self, ... }:
    {
      nixosModules = {
        common = ./modules/common.nix;
        hardware = ./modules/hardware.nix;
        disko-layout = ./modules/disko-layout.nix;
      };
    };
}
