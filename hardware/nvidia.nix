{ ... }:
{
  nixpkgs.config.allowUnfree = true;

  # https://nixos.wiki/wiki/Nvidia
  hardware.nvidia.prime.offload.enable = true;
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";

  # https://github.com/NixOS/nixpkgs/issues/98942
  services.xserver.videoDrivers = [ "modeset" "nvidia" ];
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.modesetting.enable = true;
}
