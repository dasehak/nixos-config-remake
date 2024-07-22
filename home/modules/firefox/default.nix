{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.firefox;

  proxyIP = "127.0.0.1";
  httpPort = 2081;
  socksPort = 9050;
  DoHUrl = "https://dns.adguard-dns.com/dns-query";
in {
  options = {
    module.firefox.enable = mkEnableOption "Enables firefox";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.dasehak = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
          stylus
          firefox-color
          decentraleyes
          privacy-badger
          don-t-fuck-with-paste
          noscript
          libredirect
          clearurls
          canvasblocker
        ];
        settings = {
          browser = {
            contentblocking.category = "strict";
            safebrowsing = {
              downloads.enabled = false;
              malware.enabled = false;
              phishing.enabled = false;
            };
          };
          dom.security = {
            https_only_mode = true;
            https_only_mode_ever_enabled = true;
          };
          geo.enabled = false;
          media.navigator.enabled = false;
          network = {
            dns.disablePrefetch = true;
            predictor.enabled = false;
            prefetch-next = false;
            proxy = {
              backup = {
                ssl = proxyIP;
                ssl_port = httpPort;
              };
              http = proxyIP;
              http_port = httpPort;
              no_proxies_on = [
                ".gosuslugi.ru"
                ".ya.cc"
                ".yandex.ru"
                ".yandex.net"
                ".yastatic.net"
                "kinopoisk.ru"
                "yadi.sk"
                "192.168.1.0/24"
              ];
              share_proxy_settings = true;
              socks = proxyIP;
              socks_port = socksPort;
              ssl = proxyIP;
              ssl_port = httpPort;
              type = 1;
            };
            trr = {
              custom_uri = DoHUrl;
              mode = 3;
              uri = DoHUrl;
            };
          };
          privacy = {
            annotate_channels.strict_list.enabled = true;
            bounceTrackingProtection.hasMigratedUserActivationData = true;
            donottrackheader.enabled = true;
            fingerprintingProtection = true;
            firstparty.isolate = {
              block_post_message = true;
              use_site = true;
            };
            globalprivacycontrol = {
              enabled = true;
              was_ever_enabled = true;
            };
            query_stripping.enabled = true;
            resistFingerprinting = true;
            trackingprotection = {
              enabled = true;
              emailtracking.enabled = true;
              socialtracking.enabled = true;
            };
            userContext = {
              enabled = true;
              extension = "CanvasBlocker@kkapsner.de";
              ui.enabled = true;
            };
          };
          toolkit.telemetry = {
            cachedClientID = "c0ffeec0-ffee-c0ff-eec0-ffeec0ffeec0";
            reportingpolicy.firstRun = false;
          };
        };
      };
    };
  };
}

