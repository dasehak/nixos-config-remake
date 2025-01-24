_:

{
  networking = {
    nameservers = [
      "192.168.1.100"
      "192.168.1.1"
      "8.8.8.8"
    ];
    extraHosts =
      ''
        100.83.120.96 us.actual.battle.net
        100.83.120.96 eu.actual.battle.net
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

