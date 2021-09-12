{ pkgs, ... }:
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.font = "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";

  # https://nixos.wiki/wiki/Linux_kernel
  # https://github.com/NixOS/nixpkgs/issues/129233
  # https://github.com/NixOS/nixpkgs/pull/128785#issuecomment-873219393
  boot.kernelPackages = pkgs.linuxPackages; # pkgs.linuxPackages_zen;

  # https://gist.github.com/manuelmazzuola/4ffa90f5f5d0ddacda96#file-configuration-nix-L22
  boot.kernel.sysctl = { "kernel.sysrq" = 1; };
  boot.kernelParams = [ "pcie_aspm.policy=performance" ];

  # https://github.com/slacka/WoeUSB/issues/299
  boot.supportedFilesystems = [ "ntfs" ];

  # https://gist.github.com/shamil/62935d9b456a6f9877b5
  # https://wiki.archlinux.org/title/Kernel_module_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
  boot.extraModprobeConfig = "options nbd max_part=8";
  # https://github.com/NixOS/nixpkgs/issues/20906
  boot.kernelModules = [ "nbd" ];
}
