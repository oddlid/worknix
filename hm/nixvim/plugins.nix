{ ... }:
{
  plugins = {
    diffview = {
      enable = true;
    };

    flash = {
      enable = true;
    };

    fugitive = {
      enable = true;
    };

    fzf-lua = {
      enable = true;
    };

    grug-far = {
      enable = true;
      settings = {
        debounceMs = 1000;
        engine = "ripgrep";
        engines = {
          ripgrep = {
            path = "rg";
            showReplaceDiff = true;
          };
        };
        maxSearchMatches = 2000;
        maxWorkers = 8;
        minSearchChars = 1;
        normalModeSearch = false;
      };
    };

    helm = {
      enable = true;
    };

    lsp-lines = {
      enable = true;
    };

    lsp-format = {
      enable = true;
    };

    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        # rust_analyzer = {
        #   enable = true;
        #   installRustc = false;
        #   installCargo = false;
        # };

        # superhtml = {
        #   enable = true;
        # };

        # sqls = {
        #   enable = true;
        # };

        # lua_ls = {
        #   enable = true;
        # };

        # nil_ls = {
        #   enable = true;
        # };

        # ts_ls = {
        #   enable = true;
        # };

        # marksman = {
        #   enable = true;
        # };

        # pyright = {
        #   enable = true;
        # };

        # gopls = {
        #   enable = true;
        # };

        # jsonls = {
        #   enable = true;
        # };

        # helm_ls = {
        #   enable = true;
        #   extraOptions = {
        #     settings = {
        #       "helm_ls" = {
        #         yamlls = {
        #           path = "${pkgs.yaml-language-server}/bin/yaml-language-server";
        #         };
        #       };
        #     };
        #   };
        # };
      };

      # yamlls = {
      #   enable = true;
      #   extraOptions = {
      #     settings = {
      #       yaml = {
      #         schemas = {
      #           kubernetes = "'*.yaml";
      #           "http://json.schemastore.org/github-workflow" = ".github/workflows/*";
      #           "http://json.schemastore.org/github-action" = ".github/action.{yml,yaml}";
      #           "http://json.schemastore.org/ansible-stable-2.9" = "roles/tasks/*.{yml,yaml}";
      #           "http://json.schemastore.org/kustomization" = "kustomization.{yml,yaml}";
      #           "http://json.schemastore.org/ansible-playbook" = "*play*.{yml,yaml}";
      #           "http://json.schemastore.org/chart" = "Chart.{yml,yaml}";
      #           "https://json.schemastore.org/dependabot-v2" = ".github/dependabot.{yml,yaml}";
      #           "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" =
      #             "*docker-compose*.{yml,yaml}";
      #           "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json" =
      #             "*flow*.{yml,yaml}";
      #         };
      #       };
      #     };
      #   };
      # };

    };

    # Should include all mini-* plugins?
    mini = {
      enable = true;
    };

    telescope = {
      enable = true;
    };

    ts-comments = {
      enable = true;
    };

    web-devicons = {
      enable = true;
    };

    which-key = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      settings = {
        delay = 200;
        expand = 1;
        notify = false;
        preset = "helix";
        # replace = {
        #   desc = [
        #     [
        #       "<space>"
        #       "SPACE"
        #     ]
        #     [
        #       "<leader>"
        #       "SPACE"
        #     ]
        #     [
        #       "<[cC][rR]>"
        #       "RETURN"
        #     ]
        #     [
        #       "<[tT][aA][bB]>"
        #       "TAB"
        #     ]
        #     [
        #       "<[bB][sS]>"
        #       "BACKSPACE"
        #     ]
        #   ];
        # };
        spec = [
          # General Mappings
          {
            __unkeyed-1 = "<leader>c";
            mode = [
              "n"
              "v"
            ];
            group = "Code";
          }

          {
            __unkeyed-1 = "<leader>f";
            mode = "n";
            group = "Find";
          }

          {
            __unkeyed-1 = "<leader>g";
            mode = [
              "n"
              "v"
            ];
            group = "Git";
          }

          {
            __unkeyed-1 = "<leader>q";
            mode = "n";
            group = "Quit/Session";
          }

          {
            __unkeyed-1 = "<leader>s";
            mode = "n";
            group = "Search";
          }

          {
            __unkeyed-1 = "<leader>u";
            mode = "n";
            group = "UI/UX";
          }

          {
            __unkeyed-1 = "<leader>w";
            mode = "n";
            group = "Windows";
          }

          {
            __unkeyed-1 = "<leader>b";
            mode = "n";
            group = "Buffers";
          }
        ];
        win = {
          border = "single";
        };
      };
    };

    yazi = {
      enable = true;
      autoLoad = true;
      lazyLoad = {
        settings = {
          cmd = [
            "Yazi"
          ];
        };
      };
      settings = {
        log_level = "debug";
        open_for_directories = true;
        enable_mouse_support = true;
        floating_window_scaling_factor = 1;
        yazi_floating_window_border = "rounded";
        yazi_floating_window_winblend = 20;
      };
    };

  };

}
