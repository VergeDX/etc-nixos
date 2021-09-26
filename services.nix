{ ... }:
{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  # https://nixos.org/manual/nixos/stable/#sec-user-management
  users.users.vanilla.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINlS5xCmnWS2vMoP2ESJ4navm2CzhgbolMKhqJGxbwa/ osu_Vanilla@126.com" ];

  services.fail2ban.enable = true;
  services.fail2ban.bantime-increment.enable = true;

  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L133
  services.fstrim.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-21.05";
}
