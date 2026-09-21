{ primaryUser, sys, ... }:
{ pkgs, ... }:
{
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
      ];
      extra-trusted-public-keys = [
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
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
    system = sys;
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

  # Set by orbstack. Just keeping for reference.
  # system = {
  #   stateVersion = "26.11";
  # };
  #
  # time = {
  #   timeZone = "Europe/Stockholm";
  # };

}
