{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "goofy-liskov";

  boot.initrd.availableKernelModules = ["ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  environment.systemPackages = with pkgs; [
    ansible
    (pkgs.python312.withPackages (ps: [ps.ansible ps.pip ps.proxmoxer ps.requests]))
  ];
}
