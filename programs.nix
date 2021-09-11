{ ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  programs.thefuck.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/132389
  # https://github.com/NixOS/nixpkgs/pull/132522
  programs.neovim.enable = true;
  programs.neovim.viAlias = true;

  # Required by https://github.com/blackjackshellac/eclipse
  programs.gpaste.enable = true;
}
