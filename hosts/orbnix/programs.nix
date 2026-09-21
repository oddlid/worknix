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
