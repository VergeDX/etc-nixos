# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  # https://userbase.kde.org/KDEConnect
  kde-connect-port-range = { from = 1714; to = 1764; };
  qemu-efi-aarch64 = pkgs.callPackage ./qemu-efi-aarch64.nix { };
  hack-regular-ttf = "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.font = hack-regular-ttf;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

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
  # networking.proxy.default = "http://user:password@proxy:port/";
  networking.proxy.default = "http://localhost:8889";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # https://nixos.wiki/wiki/Printing
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # Enable sound.
  # sound.enable = true;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  programs.thefuck.enable = true;

  users.users.vanilla = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ]; # Enable ‘sudo’ for the user.

    # https://nixos.wiki/wiki/Fish
    shell = pkgs.fish;

    # https://nixos.org/manual/nixos/stable/#sec-user-management
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfhqiK98OeYViT/jajm6o3GiC28vFiMgcYkpx2pbd6MbSkz+GNCpSKtD8T0nDxHFtVLKp7/iZztrVnh2s+yf3lwxmjH3U4Oepu41FzrIqQkUrog+yBWcpZXoFILqfdurLmibpdoV4J9NYJB7ARzQaeVXmMufs8f4dLfJvbV5y+rBIQPIKFdr41yGFvmbmQL0RR/uaVwwh22WYigbC8myuqkXAYEL+u6TbH2/5PzcNB8THnBni9w1CtS0mzu26oK5iYx2gUbt+x65OalRyzc/Nouwak1WHzbIE6YbHbFdQbbaWz4Jl7Im9WE7/xHPJJwPT07hfwwLTdfe0lqiujmLpJBZmahTolNiu4v2O3rw1zqdnuX39h9PMcqeBC1D1ahVk9HynJYDsb36mGttDmfseUDItQaB9qGNYteYk7ib9VB4wrxSBCMMUPli7V02UIJRRPOY4ZQoVa/j+88d1lMtx8f0iO2j3nsR3pZdYsUpCsMA7RkE+UF8qd4vFCvV3xOxs= neko@hydev.org"
    ];
  };

  # https://nixos.wiki/wiki/IOS
  services.usbmuxd.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ home-manager gjs libimobiledevice ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.ports = [ 622 ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 25565 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.allowedTCPPortRanges = [ kde-connect-port-range ];
  networking.firewall.allowedUDPPortRanges = [ kde-connect-port-range ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  # https://nixos.wiki/wiki/Flakes
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = "experimental-features = nix-command flakes";

  # https://nixos.wiki/wiki/Linux_kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
  # https://gist.github.com/manuelmazzuola/4ffa90f5f5d0ddacda96#file-configuration-nix-L22
  boot.kernel.sysctl = { "kernel.sysrq" = 1; };

  # i18n.inputMethod.enabled = "ibus";
  # i18n.inputMethod.ibus.engines = [ pkgs.ibus-engines.rime ];
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = [ pkgs.fcitx5-chinese-addons ];

  # https://nixos.wiki/wiki/Podman
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # https://nixos.wiki/wiki/Virt-manager
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemuOvmf = false;
  virtualisation.libvirtd.qemuVerbatimConfig = ''
    nvram = [ "${qemu-efi-aarch64.out}/usr/share/AAVMF/AAVMF_CODE.fd:${qemu-efi-aarch64.out}/usr/share/AAVMF/AAVMF_VARS.fd" ]
  '';

  programs.neovim.enable = true;
  programs.neovim.viAlias = true;

  # https://discourse.nixos.org/t/gdm-monitor-configuration/6356
  # https://github.com/NixOS/nixpkgs/pull/107850
  # https://discourse.nixos.org/t/in-configuration-nix-can-i-read-a-value-from-a-file/4809
  systemd.tmpfiles.rules =
    let
      # https://github.com/jluttine/nixos-configuration/blob/master/common.nix
      monitors_xml = builtins.readFile /home/vanilla/.config/monitors.xml; in
    [ "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" monitors_xml}" ];

  # Required by https://github.com/blackjackshellac/eclipse
  programs.gpaste.enable = true;

  # https://nixos.org/manual/nixpkgs/stable/#submitting-changes-tested-with-sandbox
  nix.useSandbox = true;

  # https://github.com/slacka/WoeUSB/issues/299
  boot.supportedFilesystems = [ "ntfs" ];

  boot.plymouth.enable = true;
  boot.plymouth.theme = "details";
  boot.plymouth.themePackages = [ pkgs.libsForQt5.breeze-plymouth ];
  boot.plymouth.font = hack-regular-ttf;
}
