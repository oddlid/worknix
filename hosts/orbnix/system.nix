{
  primaryUser,
  system,
  hostname,
  ...
}:
{
  config,
  pkgs,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    # Include the default lxd configuration.
    "${modulesPath}/virtualisation/lxc-container.nix"
  ];

  documentation = {
    man.enable = true;
    doc.enable = true;
    info.enable = true;
  };

  environment = {
    etc = {
      "resolv.conf".source = "/opt/orbstack-guest/etc/resolv.conf";
    };
    shellInit = ''
      . /opt/orbstack-guest/etc/profile-early
      # add your customizations here
      . /opt/orbstack-guest/etc/profile-late
    '';

    # Most of these, i.e. LSPs, should preferably be added to a project flake,
    # but since I don't yet know how things will look, I'm adding it globally.
    systemPackages = with pkgs; [
      # alejandra
      # bash-language-server
      coreutils-full
      curl
      devenv
      # djlint
      # docker-compose-language-service
      # dockerfile-language-server
      duf
      dumbpipe
      dust
      # gci
      # ghostscript
      git
      # go-minimock
      # go-mockery
      # go_1_26
      # gofumpt
      # golangci-lint
      # golangci-lint-langserver
      # golines
      # gomarkdoc
      # gopls
      # gosec
      # gotools
      # helm-ls
      # imagemagick
      # lua-language-server
      # markdown-toc
      # markdownlint-cli
      # markdownlint-cli2
      # marksman
      mosh
      nh
      # nil
      # nix-output-monitor
      # nixd
      # nixfmt
      # nixpkgs-fmt
      nmap
      # perlnavigator
      # prettier
      # pyright
      # python3
      rage # file encryption
      rclone
      # ruff
      sendme
      # shellcheck
      # shfmt
      # sqlfluff
      # statix
      # stylua
      # taplo
      # tree-sitter
      # vimPlugins.neotest-golang
      # vscode-json-languageserver
      # vscode-langservers-extracted
      # vtsls
      # yaml-language-server
      # yamllint
      zsh
    ];
  };

  networking = {
    hostName = hostname;
    dhcpcd = {
      enable = false;
      extraConfig = ''
        noarp
        noipv6
      '';
    };
    resolvconf.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    settings = {
      # suggested here: https://github.com/nix-darwin/nix-darwin/issues/1081#issuecomment-3367128960
      always-allow-substitutes = true;
      builders-use-substitutes = true;
      auto-optimise-store = true;
      trusted-users = [
        primaryUser
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = [
        "https://cache.lix.systems"
        "https://cache.nixos.org/"
        "https://nvix.cachix.org"
      ];
      extra-trusted-public-keys = [
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nvix.cachix.org-1:qVYAfj2oiH0DF3pSs8OfPYI6B0mAZ+h5mMajN+EOL2E="
      ];

      extra-platforms = [
        "x86_64-linux"
        "i686-linux"
      ];
    };

    gc = {
      # Use either this or nh, not both
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

  };

  nixpkgs = {
    system = system;
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        inherit (final.lixPackageSets.stable)
          nixpkgs-review
          nix-eval-jobs
          nix-fast-build
          colmena
          ;
      })
    ];
  };

  security = {
    sudo.wheelNeedsPassword = false;
    pki.certificates = [
      # Copied from Orbstack. Might need updates over time
      ''
        -----BEGIN CERTIFICATE-----
        MIICDjCCAbOgAwIBAgIRALyVX2YRoExaRepoPEQh62kwCgYIKoZIzj0EAwIwZjEd
        MBsGA1UEChMUT3JiU3RhY2sgRGV2ZWxvcG1lbnQxHjAcBgNVBAsMFUNvbnRhaW5l
        cnMgJiBTZXJ2aWNlczElMCMGA1UEAxMcT3JiU3RhY2sgRGV2ZWxvcG1lbnQgUm9v
        dCBDQTAeFw0yNTA1MjMxMjIyMTdaFw0zNTA1MjMxMjIyMTdaMGYxHTAbBgNVBAoT
        FE9yYlN0YWNrIERldmVsb3BtZW50MR4wHAYDVQQLDBVDb250YWluZXJzICYgU2Vy
        dmljZXMxJTAjBgNVBAMTHE9yYlN0YWNrIERldmVsb3BtZW50IFJvb3QgQ0EwWTAT
        BgcqhkjOPQIBBggqhkjOPQMBBwNCAARopEu1zVvEDrqMc5aEksb7DkTSstXBJNsO
        00UwP/pCpaucpSZ3ZeZJZdv1lEwmAJnzRsgpS+LfV5Mw1SXxpGhTo0IwQDAOBgNV
        HQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU5vZUiQpUYrll
        SLCDmEnRzh3pooUwCgYIKoZIzj0EAwIDSQAwRgIhAKplaJv+3yE13fLAjX+dvx2S
        RFQzQqO3ln6EomOgLhQuAiEAkqtOmEJ0uMA2WiCqvLzlXemO3WQl+pMeALum4YAy
        Yx0=
        -----END CERTIFICATE-----

        -----BEGIN CERTIFICATE-----
        MIICDjCCAbOgAwIBAgIRALyVX2YRoExaRepoPEQh62kwCgYIKoZIzj0EAwIwZjEd
        MBsGA1UEChMUT3JiU3RhY2sgRGV2ZWxvcG1lbnQxHjAcBgNVBAsMFUNvbnRhaW5l
        cnMgJiBTZXJ2aWNlczElMCMGA1UEAxMcT3JiU3RhY2sgRGV2ZWxvcG1lbnQgUm9v
        dCBDQTAeFw0yNTA1MjMxMjIyMTdaFw0zNTA1MjMxMjIyMTdaMGYxHTAbBgNVBAoT
        FE9yYlN0YWNrIERldmVsb3BtZW50MR4wHAYDVQQLDBVDb250YWluZXJzICYgU2Vy
        dmljZXMxJTAjBgNVBAMTHE9yYlN0YWNrIERldmVsb3BtZW50IFJvb3QgQ0EwWTAT
        BgcqhkjOPQIBBggqhkjOPQMBBwNCAARopEu1zVvEDrqMc5aEksb7DkTSstXBJNsO
        00UwP/pCpaucpSZ3ZeZJZdv1lEwmAJnzRsgpS+LfV5Mw1SXxpGhTo0IwQDAOBgNV
        HQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU5vZUiQpUYrll
        SLCDmEnRzh3pooUwCgYIKoZIzj0EAwIDSQAwRgIhAKplaJv+3yE13fLAjX+dvx2S
        RFQzQqO3ln6EomOgLhQuAiEAkqtOmEJ0uMA2WiCqvLzlXemO3WQl+pMeALum4YAy
        Yx0=
        -----END CERTIFICATE-----
      ''
    ];
  };

  services = {
    openssh.enable = false;
    resolved.enable = false;
  };

  system = {
    stateVersion = "26.11";
  };

  systemd = {
    network = {
      enable = true;
      networks = {
        "50-eth0" = {
          matchConfig.Name = "eth0";
          networkConfig = {
            DHCP = "ipv4";
            IPv6AcceptRA = true;
          };
          linkConfig.RequiredForOnline = "routable";
        };
      };
    };

    services = {
      "systemd-oomd".serviceConfig.WatchdogSec = 0;
      "systemd-userdbd".serviceConfig.WatchdogSec = 0;
      "systemd-udevd".serviceConfig.WatchdogSec = 0;
      "systemd-timesyncd".serviceConfig.WatchdogSec = 0;
      "systemd-timedated".serviceConfig.WatchdogSec = 0;
      "systemd-portabled".serviceConfig.WatchdogSec = 0;
      "systemd-nspawn@".serviceConfig.WatchdogSec = 0;
      "systemd-machined".serviceConfig.WatchdogSec = 0;
      "systemd-localed".serviceConfig.WatchdogSec = 0;
      "systemd-logind".serviceConfig.WatchdogSec = 0;
      "systemd-journald@".serviceConfig.WatchdogSec = 0;
      "systemd-journald".serviceConfig.WatchdogSec = 0;
      "systemd-journal-remote".serviceConfig.WatchdogSec = 0;
      "systemd-journal-upload".serviceConfig.WatchdogSec = 0;
      "systemd-importd".serviceConfig.WatchdogSec = 0;
      "systemd-hostnamed".serviceConfig.WatchdogSec = 0;
      "systemd-homed".serviceConfig.WatchdogSec = 0;
      "systemd-networkd".serviceConfig.WatchdogSec = lib.mkIf config.systemd.network.enable 0;
    };
  };

  time = {
    timeZone = "Europe/Stockholm";
  };

  users = {
    mutableUsers = false;
    groups = {
      orbstack = {
        gid = 67278;
      };
    };
    users = {
      ${primaryUser} = {
        uid = 501;
        extraGroups = [
          "wheel"
          "orbstack"
          "audio"
        ];

        # simulate isNormalUser, but with an arbitrary UID
        isSystemUser = true;
        group = "users";
        createHome = true;
        home = "/home/${primaryUser}";
        homeMode = "700";
        shell = pkgs.zsh;
      };
    };
  };

}
