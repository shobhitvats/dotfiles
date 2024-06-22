{ config, pkgs, inputs, ... }:
{


  # Enable networking
  networking.networkmanager.enable = true;


  # firmware updater
  services.fwupd.enable = true;


  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # Configure keymap in X11


  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Webcam
  hardware.mwProCapture.enable = true;


  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };
  services.blueman.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;


  # Enable Flakes permanently
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Hyprland services
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;


  # Derenv Enable
  programs.direnv.enable = true;


  # Hyperland Desktop Env
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };


  # only needed if you are not doing Gnome
  xdg.portal.enable = true; 
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    # pkgs.xdg-desktop-portal-hyprland
  ];


  # Enabling Flatpack
  services.flatpak.enable = true;

  # Garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

}