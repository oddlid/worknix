{
  system,
  primaryUser,
  ...
}: {
  config,
  pkgs,
  lib,
  # modulesPath,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      coreutils-full
      curl
      devenv
      duf
      dust
      git
      nh
      nmap
      zsh
    ];
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
        inherit
          (final.lixPackageSets.stable)
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
  };

  system = {
    stateVersion = "26.11";
  };

  time = {
    timeZone = "Europe/Stockholm";
  };
}
