_:

{
  networking = {
    nameservers = [
      "192.168.1.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
    extraHosts =
      ''
        127.0.0.1 account.jetbrains.com
      '';

    firewall = {
      enable = true;
      allowedTCPPorts = [
        5446 # X-Ray MPE
      ];
      allowedUDPPorts = [
        5446 # X-Ray MPE
      ];
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
    };
  };
}

