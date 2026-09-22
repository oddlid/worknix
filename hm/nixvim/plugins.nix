{ ... }:
{
  plugins = {
    diffview = {
      enable = true;
    };

    fugitive = {
      enable = true;
    };

    fzf-lua = {
      enable = true;
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

    web-devicons = {
      enable = true;
    };

    which-key = {
      enable = true;
    };

    yazi = {
      enable = true;
      autoLoad = true;
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
