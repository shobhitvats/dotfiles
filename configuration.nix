# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # firmware updater
  services.fwupd.enable = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

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

  # Storage Optimasation
  nix.optimise.automatic = true;
  # nix.optimise.dates = [ "03:45" ]; # Optional; allows customizing optimisation schedule

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shobhit = {
    isNormalUser = true;
    description = "shobhit";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes permanently
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Hyprland services
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Nemo file manager
    cinnamon.nemo


    # # For Hyperland

    # Simpler, Cpnfigured with json &css
    waybar

    # pure wayland
    dunst

    # add this
    libnotify

    # all are available in nixpkgs
    hyprpaper



    # gtk rofi
    wofi

    # # command line essentials
    git
    curl
    wget
    zip
    unzip
    tree
    fzf
    zoxide # cd alternative
    nixpkgs-fmt

    # system info
    neofetch
    pkgs.powertop
    cpufetch
    htop
    btop
    nvme-cli

    appimage-run
    desktop-file-utils

    # coding essentials
    devbox
    vscode
    github-desktop
    direnv
    nix-direnv

    # browser
    brave
    google-chrome

    # Entertainment
    spotify

    # Utility
    discord
    networkmanagerapplet
    inkscape-with-extensions
    linux-wifi-hotspot # hotspot
    # telegram-desktop
    kitty
    cli-visualizer # Music Visuallizer

    # - office tools
    libsForQt5.okular # pdf
    libreoffice # office
    marktext # markdown

    # - pictures
    loupe # viewer
    pinta # general purpose editor

    # - audio video
    mpv # light media player
    vlc # general purpose media player

    # - others
    riseup-vpn
    libsForQt5.kdeconnect-kde # wireless connection to other devices
  ];

  # Derenv Enable
  programs.direnv.enable = true;

  # Hyperland Desktop Env
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  fonts.packages = with pkgs ; [
    open-sans
    noto-fonts
    noto-fonts-color-emoji
    nerdfonts
  ];

  # Garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # IISER Lan Auto-login
  networking.networkmanager = {
    dispatcherScripts = [{
      source = pkgs.writeText "IISERlogin" ''
        #!/usr/bin/env ${pkgs.bash}/bin/bash

        if [[ "$2" == "up" ]]; then
          export HOME=/home/shobhit
          /home/shobhit/caa -d
          logger "Started IISER login daemon"
        fi

        if [[ "$2" == "down" ]]; then
          export HOME=/home/shobhit
          /home/shobhit/caa -s
          logger "Stopped IISER login daemon"
        fi
      '';
      type = "basic";
    }];
  };

  xdg.portal.enable = true; # only needed if you are not doing Gnome
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    # pkgs.xdg-desktop-portal-hyprland
  ];

  # Enabling Flatpack
  services.flatpak.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
