{ config, pkgs, inputs, ... }:
{

  # IISER Lan Auto-login

  services.gnome.gnome-keyring.enable = true;

  # networking.networkmanager = {
  #   dispatcherScripts = [{
  #     source = pkgs.writeText "IISERlogin" ''
  #       #!/usr/bin/env ${pkgs.bash}/bin/bash

  #       if [[ "$2" == "up" ]]; then
  #         export HOME=/home/shobhit
  #         /home/shobhit/caa -d
  #         logger "Started IISER login daemon"
  #       fi

  #       if [[ "$2" == "down" ]]; then
  #         export HOME=/home/shobhit
  #         /home/shobhit/caa -s
  #         logger "Stopped IISER login daemon"
  #       fi
  #     '';
  #     type = "basic";
  #   }];
  # };

}