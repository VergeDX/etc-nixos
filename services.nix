{ ... }:
{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # https://nixos.wiki/wiki/Printing
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  # https://nixos.org/manual/nixos/stable/#sec-user-management
  users.users.vanilla.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDznbCE8+ynCIeU8BNR7kmMEIHlstvfM9zDS6k0H4ALmzgLmOs05W+fDPZ7srxDk8K1hOx9312aNa40j1/PyuV+PeJ9PaodMeyCeq/OL10wZSpGGY4DbMcPuYSUmpiqr9cr1LGPkPLdzIn3iXZgPnlXKwfXo5QghqiZWE+A166bpyzSjs9YGVKkkMNuXIej8FVD5nc7Q6Z2ufCFnG3cJ8J222+qNnZEwOy5iTrk+xukuX/KFxve3ZHlfnT2/2MnMlgIKmptPWO/rpusIXEXwBdVFWBBGqE9xYkI7InN2fwcZACp8W5myPLtawN+kH/7qnBSaQokxpO44qYbFiRqD88cDIlM75YCH+BFFeomJ4uxzxcvfsOsg/aLE5iA5ptR9tHYAOQt9gRCK7ZOCWDtnBt0roOLi8N6N2WDYlPlySkHKhAQThQV0/0qBR5BBu+E1HWd9s09jJtPa30jZCMd7+GLQ9yLvwZHjXEh6alF89E+zAwY9awuWzqevMoPHtX261s= neko@hydev.org"
  ];
  services.fail2ban.enable = true;

  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L133
  services.fstrim.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-21.05";
}
