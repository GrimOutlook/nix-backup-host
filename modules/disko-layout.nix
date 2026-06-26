{ config, lib, ... }:
{
  options.backup.diskDevice = lib.mkOption {
    type = lib.types.str;
    description = "Block device path for the main backup disk.";
  };

  config.disko.devices = {
    disk.main = {
      device = config.backup.diskDevice;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            priority = 1;
            name = "ESP";
            size = "500M";
            type = "EF00";
            label = "NIXBOOT";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          root = {
            size = "100%";
            label = "NIXROOT";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/rootfs" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                    "relatime"
                  ];
                };
                "/home" = {
                  mountOptions = [
                    "compress=zstd"
                    "relatime"
                  ];
                  mountpoint = "/home";
                };
                "/nix" = {
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                  mountpoint = "/nix";
                };
                "/vault" = {
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                  mountpoint = "/vault";
                };
              };
            };
          };
        };
      };
    };
  };
}
