{ pkgs, ... }:
{
  users.users.vanilla = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ]; # Enable ‘sudo’ for the user.

    # https://nixos.wiki/wiki/Fish
    shell = pkgs.fish;
  };

  users.users.root.shell = pkgs.fish;
}
