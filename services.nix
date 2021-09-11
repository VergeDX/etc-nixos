{ ... }:
{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # https://nixos.wiki/wiki/Printing
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.ports = [ 622 ];
}
