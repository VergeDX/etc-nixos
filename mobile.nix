{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Android
  programs.adb.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];
  users.users.vanilla.extraGroups = [ "adbusers" ];

  # https://nixos.wiki/wiki/IOS
  services.usbmuxd.enable = true;
  environment.systemPackages = [ pkgs.libimobiledevice ];
}
