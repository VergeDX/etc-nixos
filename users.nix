{ pkgs, ... }:
{
  users.users.vanilla.isNormalUser = true;
  users.users.vanilla.extraGroups = [ "wheel" "libvirtd" ];
  # https://nixos.wiki/wiki/Fish
  users.users.vanilla.shell = pkgs.fish;

  users.users.root.shell = pkgs.fish;
}
