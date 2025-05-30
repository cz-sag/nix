 { config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    foot
    pavucontrol
    nautilus
  ];

  
  services.pulseaudio.enable = false; # Use Pipewire, the modern sound subsystem
  security.rtkit.enable = true; # Enable RealtimeKit for audio purposes
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Uncomment the following line if you want to use JACK applications
    # jack.enable = true;
  };

  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  security.pam.services.swaylock = {};
}
