{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ./disks.nix
    ./cpu.nix
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  # boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

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
  hardware.nvidia.prime.offload.enable = true;
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";
  # https://github.com/NixOS/nixpkgs/issues/98942
  services.xserver.videoDrivers = [ "modeset" "nvidia" ];
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.modesetting.enable = true;

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

  # https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows
  time.hardwareClockInLocalTime = true;

  # https://github.com/NixOS/nixpkgs/issues/101281
  hardware.xpadneo.enable = true;
  services.hardware.xow.enable = true;

  # https://nixos.wiki/wiki/Yubikey
  security.pam.yubico.enable = true;
  # security.pam.yubico.debug = true;
  security.pam.yubico.mode = "challenge-response";
  security.pam.yubico.control = "required";

  # https://nixos.wiki/wiki/Yubikey
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
}
