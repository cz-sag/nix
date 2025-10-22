{
  config,
  pkgs,
  lib,
  ...
}: {
  nix.settings = {experimental-features = "nix-command flakes";};

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;
  #services.xserver.excludePackages = [pkgs.xterm];

  # Configure keymap in X11
  #services.xserver = {
  #  xkb = {
  #    layout = "us";
  #    variant = "";
  #  };
  #};

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # enable userpace automout
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    git
    just
    cifs-utils
    coreutils-full
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = false;
    listenAddresses = [
      { addr = "127.0.0.1"; port = 22; }
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;   # Allow automatic reboots when needed.
    dates = "00:00";      # Build and symlink the new generation after 00:00.
    randomizedDelaySec = "120min"; # Randomize trigger delay to between 0 and 120 minutes
    flake = "github:cz-sag/nix";  # Build from a remote flake.
    operation = "boot"; # Activate the new generation on next reboot.
    persistent = true; # Store last trigger on disk, allows catching up on runs lost due to poweroff.

    # Schedule reboots between 2 AM and 6 AM.
    rebootWindow = {
      lower = "02:00";
      upper = "06:00";
    };
  };

  system.stateVersion = "25.05";
}
