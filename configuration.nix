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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # firmware updater
  services.fwupd.enable = true;

  # Use latest kernel
  #  boot.kernelPackages = pkgs.linuxPackages_latest;



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
  services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Webcam
  hardware.mwProCapture.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  services.blueman.enable = true;

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  # Storage Optimasation
  nix.optimise.automatic = true;
  # nix.optimise.dates = [ "03:45" ]; # Optional; allows customizing optimisation schedule

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shobhit = {
    isNormalUser = true;
    description = "shobhit";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate

      #  thunderbird
    ];
  };

  #  Allow broken packages
  nixpkgs.config.allowBroken = true;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Permitted insecure Pakages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "electron-19.1.9"
  ];

  # Steam
  # programs.steam.enable = true;
  # pkgs.steamPackages.steam-fhsenv-without-steam


  # Enable Flakes permanently
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # # For Hyperland

    # Simpler, Cpnfigured with json &css
    pkgs.waybar

    #  You can make your own crazy bar with Elkowar's widgets
    # It has it's own markup language
    pkgs.eww

    # 
    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
    #also work on X
    pkgs.dunst 
    # pure wayland
    pkgs.dunst
    # add this
    libnotify
    # all are available in nixpkgs
    hyprpaper
    swaybg
    wpaperd
    mpvpaper
     swww  # <-- we'll use this one
    #  Up-Launcher
    # most popular
    rofi-wayland
    # gtk rofi
    wofi
    # hyperland wiki also suggests
    bemenu
    fuzzel
    tofi

# For nix

    # # command line essentials
    nixFlakes
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
    pkgs.discord
    pkgs.networkmanagerapplet
    pkgs.inkscape-with-extensions
    linux-wifi-hotspot # hotspot
    telegram-desktop
    kitty
    pkgs.libsForQt5.booth
    pkgs.latte-dock
    pkgs.cli-visualizer # Music Visuallizer
    pkgs.etcher

    # - office tools
    libsForQt5.okular # pdf
    libreoffice # office
    marktext # markdown
    obsidian # markdown note taking

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
  programs.hyprland ={
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  fonts.packages = with pkgs; [
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

  # Enabling Flatpack
  xdg.portal.enable = true; # only needed if you are not doing Gnome
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-kde];
  services.flatpak.enable = true;

  # # Using bindfs to create FHS font & icon directory
  # system.fsPackages = [ pkgs.bindfs ];
  # fileSystems =
  #   let
  #     mkRoSymBind = path: {
  #       device = path;
  #       fsType = "fuse.bindfs";
  #       options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
  #     };
  #     aggregatedIcons = pkgs.buildEnv {
  #       name = "system-icons";
  #       paths = with pkgs; [
  #         yaru-theme
  #       ];
  #       pathsToLink = [ "/share/icons" ];
  #     };
  #     aggregatedFonts = pkgs.buildEnv {
  #       name = "system-fonts";
  #       paths = config.fonts.packages;
  #       pathsToLink = [ "/share/fonts" ];
  #     };
  #   in
  #   {
  #     # Create an FHS mount to support flatpak host icons/fonts
  #     "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
  #     "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
  #   };
  # fonts.fontDir.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
