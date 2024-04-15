{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./user.nix
    disko.nixosModules.disko
    ./disko-config.nix
    {
      _module.args.disks = [ "/dev/nvme0n1" ];
    }
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1p1";
  boot.loader.grub.useOSProber = true;

  services.postgresql.enable = true;

  networking.hostName = "goofy_liskov"; # Define your hostname.

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
