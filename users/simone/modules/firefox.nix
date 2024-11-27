{ lib, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        search = {
          order = [ "Google" ];
          engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }];
              icon =
                "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "NixOS Wiki" = {
              urls = [{
                template = "https://nixos.wiki/index.php?search={searchTerms}";
              }];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };
            "Bing".metaData.hidden = true;
            "Google".metaData.alias =
              "@g"; # builtin engines only support specifying one additional alias
          };
        };
        settings = {
          "browser.startup.homepage" = "about:home";

          # Disable irritating first-run stuff
          "browser.disableResetPrompt" = true;
          "browser.download.panel.shown" = true;
          "browser.feeds.showFirstRunUI" = false;
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          "browser.rights.3.shown" = true;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.uitour.enabled" = false;
          "startup.homepage_override_url" = "";
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.bookmarks.addedImportButton" = true;

          # Don't ask for download dir
          "browser.download.useDownloadDir" = false;

          # Disable crappy home activity stream page
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" =
            false;
          "browser.newtabpage.blocked" = lib.genAttrs [
            # Youtube
            "26UbzFJ7qT9/4DhodHKA1Q=="
            # Facebook
            "4gPpjkxgZzXPVtuEoAL9Ig=="
            # Wikipedia
            "eV8/WsSLxHadrTL1gAxhug=="
            # Reddit
            "gLv0ja2RYVgxKdp0I5qwvA=="
            # Amazon
            "K00ILysCaEq8+bEqV/3nuw=="
            # Twitter
            "T9nJot5PurhJSy8n038xGA=="
          ] (_: 1);

          # Disable some telemetry
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.sessions.current.clean" = true;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;

          # Disable fx accounts
          "identity.fxaccounts.enabled" = false;
          # Disable "save password" prompt
          "signon.rememberSignons" = false;
          # Harden
          "privacy.trackingprotection.enabled" = true;
          "dom.security.https_only_mode" = true;
          # Layout
          "browser.uiCustomization.state" = builtins.toJSON {
            currentVersion = 20;
            newElementCount = 5;
            dirtyAreaCache = [
              "nav-bar"
              "PersonalToolbar"
              "toolbar-menubar"
              "TabsToolbar"
              "widget-overflow-fixed-list"
            ];
            placements = {
              PersonalToolbar = [ "personal-bookmarks" ];
              TabsToolbar =
                [ "tabbrowser-tabs" "new-tab-button" "alltabs-button" ];
              nav-bar = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "urlbar-container"
                "downloads-button"
                "ublock0_raymondhill_net-browser-action"
                "_testpilot-containers-browser-action"
                "reset-pbm-toolbar-button"
                "unified-extensions-button"
              ];
              toolbar-menubar = [ "menubar-items" ];
              unified-extensions-area = [ ];
              widget-overflow-fixed-list = [ ];
            };
            seen = [
              "save-to-pocket-button"
              "developer-button"
              "ublock0_raymondhill_net-browser-action"
              "_testpilot-containers-browser-action"
            ];
          };
        };
        userChrome = ''
          html {
            --custom-bg: #f5f5f5;
          }

          body {
            background: var(--custom-bg) !important;
          }

          html:not([privatebrowsingmode="temporary"]) #navigator-toolbox {
            padding-top: 3px;
            padding-bottom: 4px;
            background: var(--custom-bg) !important;
            border-bottom: 0 !important;
          }

          #nav-bar {
            background: var(--custom-bg) !important;
            display: flex;
            justify-content: center;
            align-items: center;
            width: calc(100% - 20px);
          }

          /* Ensure icons are centered within the nav-bar */
          #nav-bar > .nav-bar-inner {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
          }

          html:not([privatebrowsingmode="temporary"]) #sidebar-box {
            background: var(--custom-bg) !important;
          }

          html:not([privatebrowsingmode="temporary"]) #sidebar-splitter {
            border: none !important;
            background: transparent !important;
            width: 1px !important;
          }

          html:not([privatebrowsingmode="temporary"]) #TabsToolbar {
            visibility: collapse !important;
          }

          #TabsToolbar {
            background: var(--custom-bg) !important;
          }

          html:not([privatebrowsingmode="temporary"]) .titlebar-buttonbox-container {
            position: absolute;
            right: 0;
            top: 9px;
            display: flex;
            justify-content: center;
            width: 110px !important;
          }

          .titlebar-button {
            width: 36px !important;
          }

          html:not([privatebrowsingmode="temporary"]) #sidebar-header {
            display: none;
          }

          #identity-icon-label {
            display: none;
          }

          #urlbar {
            left: 50% !important;
            transform: translateX(-50%);
            max-width: 960px !important;
          }

          #urlbar:not([breakout-extend]) #urlbar-background {
            background: none !important;
            background-color: transparent !important;
          }

          html:not([privatebrowsingmode="temporary"]) #sidebar-box {
            --uc-sidebar-width: 60px;
            --uc-sidebar-hover-width: 360px;
            position: relative;
            min-width: var(--uc-sidebar-width) !important;
            width: var(--uc-sidebar-width) !important;
            max-width: var(--uc-sidebar-width) !important;
            z-index: 1;
          }

          html:not([privatebrowsingmode="temporary"]) #main-window[sizemode="fullscreen"] #sidebar-box {
            --uc-sidebar-width: 1px;
          }

          html:not([privatebrowsingmode="temporary"]) #sidebar-splitter {
            display: none;
          }

          html:not([privatebrowsingmode="temporary"]) #sidebar {
            min-width: var(--uc-sidebar-width) !important;
          }

          html:not([privatebrowsingmode="temporary"]) #sidebar-box:hover > #sidebar {
            min-width: var(--uc-sidebar-hover-width) !important;
          }

          html:not([privatebrowsingmode="temporary"]) .sidebar-panel {
            background-color: transparent !important;
            color: var(--newtab-text-primary-color) !important;
          }

        '';
      };
    };
  };

}

