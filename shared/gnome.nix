{ pkgs, ... }: {
  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gnome-connections
      # gnome-text-editor
      evince # document reader
      loupe
      snapshot # photo viewer
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gedit # text editor
      epiphany # web browser
      #baobab # disk usage
      geary # email reader
      gnome-characters
      tali # poker game
      totem # video player
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      rygel # UPnP AV MediaServer
      yelp # Help view
      simple-scan # document scanner
      # nautilus # file explorer
      gnome-contacts
      gnome-initial-setup
      gnome-music
      gnome-weather
      gnome-maps
      gnome-user-share
      gnome-remote-desktop
    ]);
    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
    ];
  };
}
