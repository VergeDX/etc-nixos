{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ./disks.nix
    ./cpu.nix
    ./bluetooth.nix
    ./nvidia.nix
    ./others.nix
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  # boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

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
}
