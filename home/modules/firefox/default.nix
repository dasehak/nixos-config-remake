{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.firefox;

  proxyIP = "127.0.0.1";
  httpPort = "2081";
  socksPort = "9050";
  DoHUrl = "https://dns.adguard-dns.com/dns-query";
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
  noProxyOn = [
    ".gosuslugi.ru"
    ".ya.cc"
    ".yandex.ru"
    ".yandex.net"
    ".yastatic.net"
    "kinopoisk.ru"
    "yadi.sk"
    "di.sk"
    "192.168.1.0/24"
  ];
in {
  options = {
    module.firefox.enable = mkEnableOption "Enables firefox";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      policies = {
        BlockAboutConfig = true;
        BlockAboutProfiles = true;
        BlockAboutSupport = true;
        Cookies = {
          Behavior = "reject-tracker-and-partition-foreign";
        };
        DisableBuiltinPDFViewer = true;
        DisableFeedbackCommands = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisableFormHistory = true;
        DisablePasswordReveal = true;
        DisablePocket = true;
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DNSOverHTTPS = {
          Enabled = true;
          ProviderURL = DoHUrl;
          Fallback = false;
          Locked = true;
        };
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
        };
        FirefoxSuggest = {
          WebSuggestions = false;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
          Locked = true;
        };
        FirefoxHome = {
          Search = true;
          TopSites = true;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponsoredPocket = false;
          Snippets = false;
          Locked = true;
        };
        HardwareAcceleration = true;
        HttpsOnlyMode = "force_enabled";
        NetworkPrediction = false;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
        PostQuantumKeyAgreementEnabled = true;
        Preferences = {
          browser = {
            contentblocking.category = {
              Value = "strict";
              Status = "locked";
            };
            safebrowsing = {
              downloads.enabled = {
                Value = false;
                Status = "locked";
              };
              malware.enabled = {
                Value = false;
                Status = "locked";
              };
              phishing.enabled = {
                Value = false;
                Status = "locked";
              };
            };
          };
          geo.enabled = {
            Value = false;
            Status = "locked";
          };
          media.navigator.enabled = {
            Value = false;
            Status = "locked";
          };
          network = {
            predictor.enabled = {
              Value = false;
              Status = "locked";
            };
            prefetch-next = {
              Value = false;
              Status = "locked";
            };
          };
          privacy = {
            annotate_channels.strict_list.enabled = {
              Value = true;
              Status = "locked";
            };
            bounceTrackingProtection.hasMigratedUserActivationData = {
              Value = true;
              Status = "locked";
            };
            donottrackheader.enabled = {
              Value = true;
              Status = "locked";
            };
            fingerprintingProtection = {
              Value = true;
              Status = "locked";
            };
            firstparty.isolate = {
              block_post_message = {
                Value = true;
                Status = "locked";
              };
              use_site = {
                Value = true;
                Status = "locked";
              };
            };
            globalprivacycontrol = {
              enabled = {
                Value = true;
                Status = "locked";
              };
              was_ever_enabled = {
                Value = true;
                Status = "locked";
              };
            };
            query_stripping.enabled = {
              Value = true;
              Status = "locked";
            };
            resistFingerprinting = {
              Value = true;
              Status = "locked";
            };
          };
        };
        Proxy = {
          Mode = "manual";
          Locked = true;
          HTTPProxy = "${proxyIP}:${httpPort}";
          UseHTTPProxyForAllProtocols = true;
          SOCKSProxy = "${proxyIP}:${socksPort}";
          SOCKSVersion = 5;
          Passthrough = noProxyOn;
          UseProxyForDNS = true;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = true;
          MoreFromMozilla = true;
          Locked = true;
        };
        DefaultDownloadDirectory = "\${home}/downloads";
      };
      profiles.dasehak = {
        extensions = extensions;
        search = {
          default = "4get.ducks.party";
          engines = {
            "4get.ducks.party" = {
              urls = [{ template = "https://4get.ducks.party/web?s={searchTerms}"; }];
              iconUpdateURL = "https://4get.ducks.party/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
            };
          };
          force = true;
        };
      };
    };
  };
}

