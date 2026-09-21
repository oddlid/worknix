{ ... }:
{
  programs = {
    less = {
      enable = true;
      envVariables = {
        LESS = "FRi"; # --quit-if-one-screen --RAW-CONTROL-CHARS --ignore-case
      };
    };

    nh = {
      enable = true;
      # Use either this or nix.gc.automatic, not both
      clean = {
        enable = false;
      };
      # flake = ""; # TODO: set when path decided
    };

    zsh = {
      enable = true;
    };

  };
}
