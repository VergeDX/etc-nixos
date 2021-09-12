{ pkgs, ... }:
{
  users.users.vanilla = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ]; # Enable ‘sudo’ for the user.

    # https://nixos.wiki/wiki/Fish
    shell = pkgs.fish;

    # https://nixos.org/manual/nixos/stable/#sec-user-management
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDznbCE8+ynCIeU8BNR7kmMEIHlstvfM9zDS6k0H4ALmzgLmOs05W+fDPZ7srxDk8K1hOx9312aNa40j1/PyuV+PeJ9PaodMeyCeq/OL10wZSpGGY4DbMcPuYSUmpiqr9cr1LGPkPLdzIn3iXZgPnlXKwfXo5QghqiZWE+A166bpyzSjs9YGVKkkMNuXIej8FVD5nc7Q6Z2ufCFnG3cJ8J222+qNnZEwOy5iTrk+xukuX/KFxve3ZHlfnT2/2MnMlgIKmptPWO/rpusIXEXwBdVFWBBGqE9xYkI7InN2fwcZACp8W5myPLtawN+kH/7qnBSaQokxpO44qYbFiRqD88cDIlM75YCH+BFFeomJ4uxzxcvfsOsg/aLE5iA5ptR9tHYAOQt9gRCK7ZOCWDtnBt0roOLi8N6N2WDYlPlySkHKhAQThQV0/0qBR5BBu+E1HWd9s09jJtPa30jZCMd7+GLQ9yLvwZHjXEh6alF89E+zAwY9awuWzqevMoPHtX261s= neko@hydev.org"
    ];
  };

  users.users.root.shell = pkgs.fish;
}
