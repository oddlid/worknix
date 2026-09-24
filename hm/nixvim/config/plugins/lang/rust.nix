{
  # lsp.servers = {
  #   # rust_analyser = {
  #   #   enable = true;
  #   #   config = {
  #   #     settings = {
  #   #       rust-analyzer = {
  #   #         check = {
  #   #           command = "clippy";
  #   #         };
  #   #       };
  #   #     };
  #   #   };
  #   # };
  # };

  plugins = {
    # Needs more config, doesn't work with just this.
    # Gives error on startup.
    # cmp-clippy = {
    #   enable = true;
    # };

    rustaceanvim = {
      enable = true;
      settings = {
        server = {
          cmd = [
            "rustup"
            "run"
            "nightly"
            "rust-analyzer"
          ];
          default_settings = {
            rust-analyzer = {
              check = {
                command = "clippy";
              };
              inlayHints = {
                lifetimeElisionHints = {
                  enable = "always";
                };
              };
            };
          };
          standalone = false;
        };
        tools = {
          enable_clippy = true;
        };
      };

    };
    # lsp = {
    #   servers = {
    #     # rust_analyzer = {
    #     #   enable = true;
    #     # };
    #   };
    # };
  };
}
