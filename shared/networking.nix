{ lib, ... }:
{
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Enable networking
  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;

  networking.extraHosts =
  ''
    10.1.106.3 gitlab.udev.local
  '';
}