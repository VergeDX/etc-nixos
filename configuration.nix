{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./boot.nix
      ./network.nix
      ./i18n.nix
      ./xserver.nix
      ./services.nix
      ./virtualisation.nix
      ./programs.nix
      ./nix.nix
      ./mobile.nix
      ./audio.nix
      ./users.nix

      # Include the results of the hardware scan.
      ./hardware/hardware.nix
    ];

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ home-manager gjs git ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  # https://discourse.nixos.org/t/gdm-monitor-configuration/6356
  # https://github.com/NixOS/nixpkgs/pull/107850
  # https://discourse.nixos.org/t/in-configuration-nix-can-i-read-a-value-from-a-file/4809
  systemd.tmpfiles.rules =
    # https://github.com/jluttine/nixos-configuration/blob/master/common.nix
    let monitors_xml = builtins.readFile /home/vanilla/.config/monitors.xml; in
    [ "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" monitors_xml}" ];
}
