{ ... }:
# https://userbase.kde.org/KDEConnect
let kde-connect-port-range = { from = 1714; to = 1764; };
in
{
  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.wireless.interfaces = [ "wlp0s20f3" ];
  # https://github.com/NixOS/nixpkgs/issues/110736
  networking.wireless.userControlled.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp3s0f1.useDHCP = true;
  # networking.interfaces.wlp0s20f0u2u1u2.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Use networkd instead of buggy dhcpcd.
  networking.useNetworkd = true;
  networking.dhcpcd.enable = false;

  # Configure network proxy if necessary
  networking.proxy.default = "http://localhost:8889";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 25565 ]; # 8889 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.allowedTCPPortRanges = [ kde-connect-port-range ];
  networking.firewall.allowedUDPPortRanges = [ kde-connect-port-range ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall.allowPing = false;
  networking.firewall.rejectPackets = true;
  services.fail2ban.enable = true;
}
