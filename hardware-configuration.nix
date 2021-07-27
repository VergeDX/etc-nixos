# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "uas" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/3ef5d334-fb60-4a97-ac20-06d1c676dee7";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/4807-1DBA";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/058c4cb2-5cef-479b-912f-5c9f80858893"; }];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.enableAllFirmware = true;

  # https://raspberrypi.stackexchange.com/questions/40839/sap-error-on-bluetooth-service-status
  # https://github.com/NixOS/nixpkgs/issues/63703
  systemd.services.bluetooth.serviceConfig.ExecStart = [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd --noplugin=sap"
  ];

  nixpkgs.config.allowUnfree = true;
  # https://nixos.wiki/wiki/Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime.offload.enable = true;
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";

  # https://github.com/NixOS/nixpkgs/issues/25957
  hardware.opengl.driSupport32Bit = true;
  # https://nixos.wiki/wiki/Steam
  hardware.steam-hardware.enable = true;

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages =
    let vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    in with pkgs; [ intel-media-driver vaapiIntel vaapiVdpau libvdpau-va-gl ];
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel ];

  # https://www.howtogeek.com/323390/how-to-fix-windows-and-linux-showing-different-times-when-dual-booting/
  services.localtime.enable = true;
}
