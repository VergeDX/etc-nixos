{ pkgs, lib, config, ... }:
{
  # https://nixos.wiki/wiki/Flakes
  # https://discourse.nixos.org/t/using-experimental-nix-features-in-nixos-and-when-they-will-land-in-stable/7401/3
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
      "experimental-features = nix-command flakes";
  };

  # https://nixos.org/manual/nixpkgs/stable/#submitting-changes-tested-with-sandbox
  nix.useSandbox = true;
}
