{ config, pkgs, inputs, ... }:
{

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

    # brightness control
    brightnessctl

    # media player control
    playerctl


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
    resources
    pkgs.powertop
    cpufetch
    htop
    btop
    nvme-cli
    lshw-gui
    lshw

    appimage-run
    desktop-file-utils

  


    # Graphics

    pkgs.linuxKernel.packages.linux_zen.nvidia_x11_beta
    nvtopPackages.full


    # Games
    
    zeroad
    zeroadPackages.zeroad-unwrapped
    zeroadPackages.zeroad-data
    


    # coding essentials
    devbox
    vscode
    github-desktop
    direnv
    nix-direnv

    # Tools
    glaxnimate # kdenlive animation support dependency
    # kdePackages.kdenlive # Video Editor
    # davinci-resolve  # Video Editor - not working
    gimp # Photo Editor
    gimpPlugins.gap # gimp animation pakage
    blender 

    # browser
    brave
    google-chrome
    firefox

    # Entertainment
    spotify

    # Utility
    cloudflare-warp
    openvpn #vpn
    discord
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

    inputs.vignesh.packages."x86_64-linux".waybar-mediaplayer
    inputs.vignesh.packages."x86_64-linux".iiserpune-selenium-login

    # inputs.nixpkgs-master.packages."x86_64-linux".pakage-name

  ];

}