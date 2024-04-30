{ pkgs, ... }:
{
  services.udev.extraRules = ''
    #
    # Copyright 2011,2015 Ettus Research LLC
    # Copyright 2018 Ettus Research, a National Instruments Company
    #
    # SPDX-License-Identifier: GPL-3.0-or-later
    #

    #USRP1
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="fffe", ATTRS{idProduct}=="0002", MODE:="0666"

    #B100
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2500", ATTRS{idProduct}=="0002", MODE:="0666"

    #B200
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2500", ATTRS{idProduct}=="0020", MODE:="0666"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2500", ATTRS{idProduct}=="0021", MODE:="0666"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2500", ATTRS{idProduct}=="0022", MODE:="0666"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3923", ATTRS{idProduct}=="7813", MODE:="0666"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3923", ATTRS{idProduct}=="7814", MODE:="0666"
  '';
  environment.systemPackages = with pkgs; [
    git
    uhd
    gnuradio
    python311Packages.matplotlib
    python311Packages.numpy
  ];
}