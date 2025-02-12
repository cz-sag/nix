{ lib, pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
#    setSocketVariable = true;
  };
  environment.systemPackages = [
    pkgs.gitlab-ci-local
    pkgs.qemu_full  
  ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  users.groups.libvirtd.members = ["user"];
  virtualisation.spiceUSBRedirection.enable = true;
}
