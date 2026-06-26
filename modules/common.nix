{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  host = {
    network-diag.enable = true;
    type.server.enable = true;
  };

  environment.systemPackages = with pkgs; [
    smartmontools
  ];

  users.users =
    let
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKblv2UFBk7X45rlrdbmhMzyrfK7FDnlnT932lXu6TqV root@amsterdam"
      ];
    in
    {
      root.openssh.authorizedKeys.keys = keys;
    };

  host.home-manager.config = {
    imports = [
      inputs.homelab.homeManagerModules.default
    ];
    home = {
      packages = with pkgs; [
      ];
    };
  };
}
