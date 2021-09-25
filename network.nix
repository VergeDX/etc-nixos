{ ... }:
# https://userbase.kde.org/KDEConnect
# let kde-connect-port-range = { from = 1714; to = 1764; };
# in
{
  networking.hostName = "NixOS-Laptop"; # Define your hostname.
  networking.domain = "vanilla.local";

  networking.interfaces.enp3s0f1.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # https://wiki.archlinux.org/title/Systemd-resolved#mDNS
  services.resolved.extraConfig = "MulticastDNS=yes";
  systemd.network.networks."40-wlp0s20f3" = {
    networkConfig = { "MulticastDNS" = true; };
    linkConfig = { "Multicast" = "yes"; };
  };

  # Use networkd instead of buggy dhcpcd.
  networking.useNetworkd = true;
  networking.dhcpcd.enable = false;

  # Configure network proxy if necessary
  networking.proxy.default = "http://localhost:8889";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 8889 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];
  # networking.firewall.allowedTCPPortRanges = [ kde-connect-port-range ];
  # networking.firewall.allowedUDPPortRanges = [ kde-connect-port-range ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall.allowPing = false;
  networking.firewall.rejectPackets = true;
}
