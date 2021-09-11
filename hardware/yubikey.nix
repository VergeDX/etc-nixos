{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Yubikey
  security.pam.yubico.enable = true;
  # security.pam.yubico.debug = true;
  security.pam.yubico.mode = "challenge-response";
  security.pam.yubico.control = "required";

  # https://nixos.wiki/wiki/Yubikey
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
}