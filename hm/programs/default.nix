{
  pkgs,
  lib,
  inputs,
  system,
  ...
}:
let
  nvix = inputs.nvix.packages.${system}.core;
in
{
  home.packages = with pkgs; [
    (nvix.extend {
      config = {
        vimAlias = true;
        nvix.transparent = true;

        # This tip I got on matrix works in tandem with the overlay for this system, to avoid mermaid-cli pulling in
        # chromium, which again pulls in shitloads of deps I have no use for.
        _module.args.pkgs = lib.mkForce pkgs;

        lsp.servers = {
          gopls = {
            enable = true;
            config.settings.gopls.gofumpt = true;
          };
          golangci_lint_ls.enable = true;
        };

        plugins = {
          chatgpt.enable = lib.mkForce false;
          copilot-lua.enable = lib.mkForce false;
          cord.enable = lib.mkForce false;
          firenvim.enable = lib.mkForce false;
          leetcode.enable = lib.mkForce false;
          neoscroll.enable = lib.mkForce false;
          kulala.enable = lib.mkForce false;
          typst-preview.enable = lib.mkForce false;

          gitsigns.settings.current_line_blame = lib.mkForce false;

          lsp.servers = {
            gopls.enable = true;
            golangci_lint_ls.enable = true;
            hls.enable = lib.mkForce false;
            tinymist.enable = lib.mkForce false;
          };

          snacks = {
            settings = {
              animate.enable = lib.mkForce false;
              indent = {
                only_scope = true;
                only_current = true;
              };
              picker.layout.preset = lib.mkForce "telescope";
            };
          };
        };

      };
    })

    # Golang tools
    gci
    go-minimock
    go-mockery
    go_1_26
    gofumpt
    golangci-lint
    golangci-lint-langserver
    golines
    gomarkdoc
    gopls
    gosec
    gotools
  ];

  programs = {
    bash = {
      enable = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "Solarized (dark)";
      };
    };

    difftastic = {
      enable = true;
      git = {
        enable = true;
        mode = "external";
      };
      options = {
        sort-paths = true;
        tab-width = 2;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      colors = "auto";
      enableBashIntegration = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };

    fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git/"
        "*.bak"
      ];
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      changeDirWidget = {
        command = "fd --type d --strip-cwd-prefix --hidden -E .git -E .direnv";
        options = [
          "--preview 'eza --tree --color=always {} | head -200'"
        ];
      };
      # Taken from the Solarized example here: https://github.com/junegunn/fzf/wiki/Color-schemes
      # In tmux, terminal must be tmux-256color, and the term overrides must also be set as below for it to work properly
      colors = {
        "bg+" = "#073642";
        bg = "#002b36";
        spinner = "#719e07";
        hl = "#586e75";
        fg = "#839496";
        header = "#586e75";
        info = "#cb4b16";
        pointer = "#719e07";
        marker = "#719e07";
        "fg+" = "#839496";
        prompt = "#719e07";
        "hl+" = "#719e07";
      };
      defaultCommand = "fd --type f --strip-cwd-prefix --hidden -E .git -E .direnv";
      # defaultOptions = [
      #   "--preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi'"
      # ];
      fileWidget = {
        command = "fd --type f --strip-cwd-prefix --hidden -E .git -E .direnv";
        options = [
          "--preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi'"
        ];
      };
      tmux = {
        enableShellIntegration = true;
      };
    };

    gh = {
      enable = true;
      settings = {
        aliases = { };
        editor = "nvim";
      };
    };

    git = {
      enable = true;
      settings = {
        alias = {
          st = "status";
          ls-untracked = "!git ls-files --others --exclude-standard";
          pushall = "!git remote | xargs -L1 git push --all";
          pushreview = "push origin HEAD:refs/for/master";
          pushdraft = "push origin HEAD:refs/drafts/master";
          count-lines = "! git log --author=\"$1\" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf \"added lines: %s, removed lines: %s, total lines: %s\\n\", add, subs, loc }' #";
        };
        merge = {
          conflictStyle = "diff3";
        };
        pull = {
          rebase = true;
        };
        user = {
          name = "git@oddware.net"; # TODO: change to match workplace
          email = "Odd E. Ebbesen";
        };
      };
      signing = {
        format = "ssh";
        key = "~/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
      lfs.enable = true;
    };

    gpg = {
      enable = true;
    };

    helix = {
      enable = true;
      settings = {
        theme = "solarized_dark";
        editor = {
          line-number = "relative";
          atomic-save = false;
          trim-final-newlines = true;
          trim-trailing-whitespace = true;
          clipboard-provider = "termcode";
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          indent-guides = {
            render = true;
          };
        };
      };
      languages = {
        language = [
          {
            name = "rust";
            file-types = [ "rs" ];
            auto-format = true;
            formatter = {
              command = "rustfmt";
            };
            roots = [
              "Cargo.toml"
              "Cargo.lock"
            ];
            language-servers = [ "rust-analyzer" ];
          }
          {
            name = "nix";
            formatter = {
              command = "alejandra";
            };
          }
          {
            name = "python";
            auto-format = true;
            language-servers = [ "ruff" ];
          }
          {
            name = "toml";
            roots = [ "." ];
            language-servers = [ "taplo" ];
          }
        ];
        language-server = {
          rust-analyzer = {
            command = "rust-analyzer";
            config = {
              check = {
                command = "clippy";
              };
              cargo = {
                features = "all";
              };
            };
          };
          ruff = {
            command = "ruff";
            args = [ "server" ];
          };
        };
      };
    };

    htop = {
      enable = true;
      settings = { };
    };

    jq = {
      enable = true;
    };

    k9s = {
      enable = true;
    };

    lazygit = {
      enable = true;
      # settings = { };
    };

    less = {
      enable = true;
    };

    lesspipe = {
      enable = true;
    };

    mergiraf = {
      enable = true;
      enableGitIntegration = true;
    };

    # neovim = {
    #   defaultEditor = true;
    #   viAlias = true;
    #   vimAlias = true;
    #   vimdiffAlias = true;
    #   # I might like to change these, so specified as a reminder
    #   withNodeJs = true;
    #   withPerl = true;
    #   withPython3 = true;
    #   withRuby = false;
    #   waylandSupport = false;
    # };

    # nixvim = {
    #   imports = [ ./nixvim.nix ];
    # };

    nix-your-shell = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

    tmux = {
      enable = true;
      clock24 = true;
      escapeTime = 40;
      focusEvents = true;
      historyLimit = 5000;
      mouse = true;
      newSession = true;
      prefix = "C-x";
      sensibleOnTop = false; # see: https://github.com/nix-community/home-manager/issues/5952
      # shell = "${pkgs.zsh}/bin/zsh"; # the shell option in extraConfig seems to work better
      terminal = "tmux-256color"; # This makes the fzf colorscheme work properly

      plugins = with pkgs.tmuxPlugins; [
        continuum
        logging
        pain-control
        resurrect
        tmux-fzf
        {
          plugin = power-theme;
          extraConfig = ''
            set -g @tmux_power_theme 'moon'
            set -g @tmux_power_prefix_highlight_pos 'LR'
          '';
        }
        prefix-highlight
        yank
      ];

      extraConfig = ''
        # See: https://github.com/tmux/tmux/wiki/Clipboard#quick-summary
        set -s set-clipboard on
        # Ms modifies OSC 52 clipboard handling to work with mosh, see
        # https://gist.github.com/yudai/95b20e3da66df1b066531997f982b57b
        set -ag terminal-overrides ",xterm*:Ms=\\E]52;c%p1%.0s;%p2%s\\7"
        set -ag terminal-overrides ",tmux*:Ms=\\E]52;c%p1%.0s;%p2%s\\7"

        bind-key x send-prefix
        bind-key C-x last-window
        bind 'v' copy-mode
        set-window-option -g mode-keys vi
        set -g default-command "$SHELL"
        set -g default-shell "$SHELL"
        set -ag terminal-overrides ',xterm-256color:Tc'
        set -as terminal-overrides ',xterm*:sitm=\E[3m'
        # allow for navigating between words with option
        set-window-option -g xterm-keys on
        # Allow the arrow key to be used immediately after changing windows
        set -g repeat-time 0
        # Set window notifications
        set -g monitor-activity on
        set -g visual-activity on
        # Status update interval
        set -g status-interval 1
        set -g renumber-windows on    # renumber windows when a window is closed

        # recommendations for vim-tpipeline
        # set -g status-style bg=default
        # set -g status-left-length 90
        # set -g status-right-length 90
        # set -g status-justify centre
        # set -g status-right '#{prefix_highlight}#(hostname) | %Y-%m-%d %H:%M'
        # set-window-option -g window-status-separator " "
        # set-window-option -g window-status-current-format "#[fg=colour66]#W"
        # set-window-option -g window-status-format "#W"
      '';
    };

    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      plugins = with pkgs.yaziPlugins; {
        inherit chmod;
        inherit git;
        inherit lazygit;
        inherit rsync;
      };
      shellWrapperName = "y";
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autosuggestion = {
        enable = true;
        strategy = [
          "history"
        ];
      };
      history = {
        append = false;
        expireDuplicatesFirst = true;
        extended = true;
        save = 100000;
        saveNoDups = true;
        share = true;
      };
      historySubstringSearch = {
        enable = true;
      };
      initContent = ''
        source ${pkgs.fzf-git-sh}/share/fzf-git-sh/fzf-git.sh
      '';
      localVariables = { };
      oh-my-zsh = {
        enable = true;
        extraConfig = ''
          zstyle :omz:plugins:ssh-agent identities id_rsa id_ed25519
        '';
        plugins = [
          "alias-finder"
          "aliases"
          "dircycle"
          "docker"
          "encode64"
          "extract"
          "fzf"
          "git"
          "golang"
          "helm"
          "isodate"
          "nmap"
          "rsync"
          "safe-paste"
          "systemadmin"
          "tmux"
          "transfer"
          "universalarchive"
          "urltools"
        ];
        theme = "crcandy";
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "brackets"
        ];
        patterns = { };
        styles = { };
      };
      siteFunctions = {
        list_nix_pkg = ''
          ${pkgs.fd}/bin/fd . $(nix build nixpkgs#$1 --print-out-paths --no-link)
        '';
      };
    };

  };
}
