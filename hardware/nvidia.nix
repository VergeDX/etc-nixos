{ config, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L104
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
  hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.nvidiaSettings = false;

  hardware.nvidia.prime.sync.enable = true;
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";

  # hardware.nvidia.powerManagement.enable = true;
  # hardware.nvidia.powerManagement.finegrained = true;

  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L160
  services.xserver.videoDrivers = [ "nvidia" ];

  # @NickCao & @lilydjwg: X server start too fast to load nvidia driver.
  boot.initrd.enable = true;
  boot.initrd.kernelModules = [ "nvidia" ];
}
