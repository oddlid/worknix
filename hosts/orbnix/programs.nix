{ ... }:
{
  programs = {
    less = {
      enable = true;
      envVariables = {
        LESS = "FRi"; # --quit-if-one-screen --RAW-CONTROL-CHARS --ignore-case
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = false;

    };

    nh = {
      enable = true;
      # Use either this or nix.gc.automatic, not both
      clean = {
        enable = false;
      };
      # flake = ""; # TODO: set when path decided
    };

    ssh = {
      extraConfig = ''
        Include /opt/orbstack-guest/etc/ssh_config
      '';
    };

    zsh = {
      enable = true;
    };

  };
}
