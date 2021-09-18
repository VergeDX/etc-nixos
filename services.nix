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
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDoNoi1kqpaEg9E5ZiHlvsWVq8FzQtkiLWMxr2FNUsmH/WXTVbDPoFh0lORdajAvMJ+9W9IvexA5wEoxJK11IoFGwB4u5DKtOMs2ViBMJHqh3dBGETM6mFgkFjH4lsXc8JX0xUhyDm1tvLmayvgTTdKHQQGhWDq12o6cdaLHOJfYJqc+MVX+nqB0qRCzGyE16y7gzSjR2gnduOJKdmC80X6zx1aOPdprjjINg05d5Da+0tSynNCHSXY/GRG9gRlpUoa+oNm2NGm00CLVk1kg+zJt9ITzHofGKp1VJCFSR0L0AlTUIrr8H/ZdGFopdSHE4roKioevt5UcW7ACcKp17fArFagVibeQp4RCEfjCfsEe7nPm6bwsLNPAR6ZKqRFepYiWmdG3eaTFYpvqbC8zSh/DS7+dKQI3rjpJ7g4ttIqQGPG1ZYNOknjHC96YPjr1XUBzIHiECapP7rmQgzpZQWC/DFTSWOJuzZ5OKcIeNt77AXyoTMBxeDTv7gJYv/I6lE= osu_Vanilla@126.com"
  ];
  services.fail2ban.enable = true;

  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L133
  services.fstrim.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-21.05";
}
