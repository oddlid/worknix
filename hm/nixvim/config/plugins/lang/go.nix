{
  lsp.servers = {
    gopls = {
      enable = true;
      config = {
        settings = {
          gopls = {
            gofumpt = true;
          };
        };
      };
    };
    golangci_lint_ls = {
      enable = true;
    };
  };

  plugins = {
    lsp = {
      servers = {
        gopls = {
          enable = true;
        };
        golangci_lint_ls = {
          enable = true;
        };
      };
    };

    neotest = {
      enable = true;
      adapters = {
        golang = {
          enable = true;
        };
      };
    };
  };
}
