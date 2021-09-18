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
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDoNoi1kqpaEg9E5ZiHlvsWVq8FzQtkiLWMxr2FNUsmH/WXTVbDPoFh0lORdajAvMJ+9W9IvexA5wEoxJK11IoFGwB4u5DKtOMs2ViBMJHqh3dBGETM6mFgkFjH4lsXc8JX0xUhyDm1tvLmayvgTTdKHQQGhWDq12o6cdaLHOJfYJqc+MVX+nqB0qRCzGyE16y7gzSjR2gnduOJKdmC80X6zx1aOPdprjjINg05d5Da+0tSynNCHSXY/GRG9gRlpUoa+oNm2NGm00CLVk1kg+zJt9ITzHofGKp1VJCFSR0L0AlTUIrr8H/ZdGFopdSHE4roKioevt5UcW7ACcKp17fArFagVibeQp4RCEfjCfsEe7nPm6bwsLNPAR6ZKqRFepYiWmdG3eaTFYpvqbC8zSh/DS7+dKQI3rjpJ7g4ttIqQGPG1ZYNOknjHC96YPjr1XUBzIHiECapP7rmQgzpZQWC/DFTSWOJuzZ5OKcIeNt77AXyoTMBxeDTv7gJYv/I6lE= osu_Vanilla@126.com"
    ];
  };

  users.users.root.shell = pkgs.fish;
}
