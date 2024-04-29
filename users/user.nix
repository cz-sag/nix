{ pkgs, ...}:
{
  users.users.user = {
    isNormalUser  = true;
    home  = "/home/user";
    description  = "Default user";
    extraGroups  = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys  = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJe8i35RxB4wAbD+eL/uLHM2JdGcPfk78rCxE1zuyYyn user@nixos" ];
    users.users.your-user.initialPassword = “test”;
  };
}
