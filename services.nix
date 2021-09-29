{ pkgs, lib, config, ... }:
{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  # https://nixos.org/manual/nixos/stable/#sec-user-management
  users.users.vanilla.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDrr1hJLnVmUFa9CNFAGZTvYZbO9E4zw2LeQUOQaUa7UuQx/Y629OHwkH8mG34Usj32wqb8slqDJvJeOdRlPFSNs56bE0CAef0+ecI3YiVOW83YbLY4Tm4zi2FLew8Qh9SaU2aJDLhUUCit8mcndJ0x8SesPyjUPoLkas5ebCNhwxt4FMwUYxahbGRqqrkhKGuODNNNg02GmqtCrWVU9oqGrL9Qgbw0SEGKjBvixFMcAcx7ihj1cswJDlh7L87RGLCFgwptetjGTUTfZTKR8kSPnet3lcK9EtV0fQ1B/M6h3mOE8EWRm2VIVusIlZ2Pr6MEunlFkqvWNAb/LKTNdGLu3yvI+gP51TVDhG2chNgFQuETXOiIQdFcpOMiRCs0O5iJJV3G4dshKM9ZqE/Ju1N9siY2W3suUj6P2KcvikGqs1KRSp8seXoSilo0o5pwVIXSNYWOUaf17vbKvYqrcgtRwjyK3pab6fVa+paz3YLF19Rq1l3duEXcTSxroBGQ5+25wwgDUe2NuUzokg64q+eje/DSBqmHpDP4pipRZ58zv0NGhErnnPGXwSdLjtS8IO/3FToa5VWSxxWc2CAnBMYPo1gr2a3B1mnO8opXgrsV+nUaYGLA4+Ubv+KUBtyaBrjw2XI/C4qvv3pYU/5cElhHebL8uEYxRd/JOKFRKMQ2xw== cardno:000616155718"
  ];

  services.fail2ban.enable = true;
  services.fail2ban.bantime-increment.enable = true;

  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L133
  services.fstrim.enable = true;

  services.influxdb2.enable = true;
  services.telegraf.enable = true;
  services.telegraf.environmentFiles = [
    /run/secrets/INFLUX_TOKEN.env
    /run/secrets/config.env
  ];

  systemd.services."telegraf".serviceConfig = {
    ExecStart = lib.mkForce "${config.services.telegraf.package}/bin/telegraf --config $config";
  };

  environment.systemPackages = with pkgs; [ xmonad-with-packages xterm ];
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "xmonad";
}
