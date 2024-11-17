{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.security.secure-dns;
in {
  options = {
    module.security.secure-dns.enable = mkEnableOption "Enables DNS-Over-TLS";
  };

  config = mkIf cfg.enable {
    networking = {
      nameservers = [ "127.0.0.1" ];
      networkmanager.dns = "none";
    };

    services.dnscrypt-proxy2 = {
      enable = true;
      settings = {
        lb_strategy = "p3";
        require_dnssec = true;
        http3 = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        server_names = [
          "mullvad-doh" # Public non-filtering, non-logging (audited), DNSSEC-capable, DNS-over-HTTPS resolver hosted by VPN provider Mullvad Anycast IPv4/IPv6 with servers in SE, DE, UK, US, AU and SG
          "techsaviours.org-dnscrypt" # No filter | No logs | DNSSEC | Nuremberg, Germany (netcup) | Maintained by https://techsaviours.org/
          "nextdns" # DNSSEC, Anycast, Non-logging, NoFilters
          "nextdns-ultralow" # NextDNS is a cloud-based private DNS service that gives you full control over what is allowed and what is blocked on the Internet.
          "scaleway-ams"
          "cs-czech"
          "cs-hungary"
          "cs-bulgaria"
          "cs-poland"
          "dnscry.pt-chisinau-ipv4" # DNSCry.pt Chișinău - no filter, no logs, DNSSEC support (IPv4 server)
          "dnscry.pt-warsaw-ipv4"
          "dnscry.pt-vienna-ipv4"
          "dct-at1"
          "controld-unfiltered"
        ];
      };
    };
    systemd.services.dnscrypt-proxy2.serviceConfig.StateDirectory = "dnscrypt-proxy";
  };
}
