{
  primaryUser,
  ...
}:
let
  swe = "sv_SE.UTF-8";
in
{
  imports = [
    ./programs
  ];

  home = {
    stateVersion = "26.11";

    language = {
      address = swe;
      base = swe;
      collate = swe;
      ctype = swe;
      measurement = swe;
      messages = swe;
      monetary = swe;
      name = swe;
      numeric = swe;
      paper = swe;
      telephone = swe;
      time = swe;
    };

    sessionVariables = {
      # LESS = "FRi"; # --quit-if-one-screen --RAW-CONTROL-CHARS --ignore-case
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      MANPAGER = "nvim +Man!";
      REPORTTIME = "5";
      TIMEFMT = "%U user, %S system, %P cpu, %*Es total";
    };

    shell = {
      enableBashIntegration = true;
      enableShellIntegration = true;
      enableZshIntegration = true;
    };

    shellAliases = {
      _tm = "tmux -u2 attach-session || tmux -u2";
      _ts = "date -Iseconds | cut -d + -f1 | sed 's/T/_/;s/://g'";
    };

    username = primaryUser;
  };

}
