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

      # Include the results of the hardware scan.
      ./hardware.nix
    ];

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # https://nixos.wiki/wiki/PipeWire
  # https://blog.ryey.icu/zhs/replace-pulseaudio-with-pipewire.html
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # https://nixos.wiki/wiki/Android
  programs.adb.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];
  users.users.vanilla = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "adbusers" ]; # Enable ‘sudo’ for the user.

    # https://nixos.wiki/wiki/Fish
    shell = pkgs.fish;

    # https://nixos.org/manual/nixos/stable/#sec-user-management
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDznbCE8+ynCIeU8BNR7kmMEIHlstvfM9zDS6k0H4ALmzgLmOs05W+fDPZ7srxDk8K1hOx9312aNa40j1/PyuV+PeJ9PaodMeyCeq/OL10wZSpGGY4DbMcPuYSUmpiqr9cr1LGPkPLdzIn3iXZgPnlXKwfXo5QghqiZWE+A166bpyzSjs9YGVKkkMNuXIej8FVD5nc7Q6Z2ufCFnG3cJ8J222+qNnZEwOy5iTrk+xukuX/KFxve3ZHlfnT2/2MnMlgIKmptPWO/rpusIXEXwBdVFWBBGqE9xYkI7InN2fwcZACp8W5myPLtawN+kH/7qnBSaQokxpO44qYbFiRqD88cDIlM75YCH+BFFeomJ4uxzxcvfsOsg/aLE5iA5ptR9tHYAOQt9gRCK7ZOCWDtnBt0roOLi8N6N2WDYlPlySkHKhAQThQV0/0qBR5BBu+E1HWd9s09jJtPa30jZCMd7+GLQ9yLvwZHjXEh6alF89E+zAwY9awuWzqevMoPHtX261s= neko@hydev.org"
    ];
  };

  # https://nixos.wiki/wiki/IOS
  services.usbmuxd.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ home-manager gjs libimobiledevice ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  # https://nixos.wiki/wiki/Flakes
  # https://discourse.nixos.org/t/using-experimental-nix-features-in-nixos-and-when-they-will-land-in-stable/7401/3
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
      "experimental-features = nix-command flakes";
  };

  # https://discourse.nixos.org/t/gdm-monitor-configuration/6356
  # https://github.com/NixOS/nixpkgs/pull/107850
  # https://discourse.nixos.org/t/in-configuration-nix-can-i-read-a-value-from-a-file/4809
  systemd.tmpfiles.rules =
    let
      # https://github.com/jluttine/nixos-configuration/blob/master/common.nix
      monitors_xml = builtins.readFile /home/vanilla/.config/monitors.xml; in
    [ "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" monitors_xml}" ];

  # https://nixos.org/manual/nixpkgs/stable/#submitting-changes-tested-with-sandbox
  nix.useSandbox = true;
}
