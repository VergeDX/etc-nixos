{ ... }:
# https://userbase.kde.org/KDEConnect
# let kde-connect-port-range = { from = 1714; to = 1764; };
# in
{
  networking.hostName = "NixOS-Laptop"; # Define your hostname.
  networking.domain = "vanilla.local";

  networking.interfaces.enp3s0f1.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  # https://wiki.archlinux.org/title/Systemd-networkd_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#[Network]_%E5%B0%8F%E8%8A%82
  systemd.network.networks."40-wlp0s20f3".networkConfig = {
    "MulticastDNS" = true;
  };

  # Use networkd instead of buggy dhcpcd.
  networking.useNetworkd = true;
  networking.dhcpcd.enable = false;

  # Configure network proxy if necessary
  networking.proxy.default = "http://localhost:8889";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 8889 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.allowedTCPPortRanges = [ kde-connect-port-range ];
  # networking.firewall.allowedUDPPortRanges = [ kde-connect-port-range ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall.allowPing = false;
  networking.firewall.rejectPackets = true;
}
