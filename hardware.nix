{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  # boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/4ff541a0-7952-4ede-a20b-6cecba4f16eb";
      fsType = "btrfs";

      # https://btrfs.wiki.kernel.org/index.php/Compression
      # https://wiki.archlinux.org/title/Btrfs_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E5%8E%8B%E7%BC%A9
      # https://btrfs.wiki.kernel.org/index.php/FAQ#Performance_vs_Correctness
      options = [ "compress-force=zstd" "noatime" ];
    };

  fileSystems."/boot" = { device = "/dev/disk/by-uuid/F934-BA50"; fsType = "vfat"; };
  swapDevices = [{ device = "/dev/disk/by-uuid/1b07ef58-fa1b-4e5e-a394-7a07a9229f07"; }];

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

  # https://discourse.nixos.org/t/update-microcode-microcodeintel-not-working/10856
  hardware.cpu.amd.updateMicrocode = true;
  hardware.cpu.intel.updateMicrocode = true;

  # https://mnguyen.io/blog/running-nixos-in-production/
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr";
}