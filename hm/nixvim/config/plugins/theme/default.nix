{ pkgs, ... }:
let
  # This is the same theme I've been using for years with LazyVim
  nvim-solarized-lua = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-solarized-lua";
    src = pkgs.fetchFromGitHub {
      owner = "ishan9299";
      repo = "nvim-solarized-lua";
      rev = "d69a263c97cbc765ca442d682b3283aefd61d4ac";
      hash = "sha256-0NABkr2d86Uq3OU4lbn2dyjRbwE3+5euqh1CA+MwDtQ=";
    };
  };
in
{
  extraPlugins = [ nvim-solarized-lua ];
  # Seems that the name from the plugin above is just this:
  colorscheme = "solarized";

  colorschemes = {
    base16 = {
      enable = false;
      # This one has way too much red text in Go, so my eyes get tired.
      colorscheme = "solarized-dark";
    };

    # A bit too intense for my taste
    solarized-osaka = {
      enable = false;
      settings = {
        styles = {
          comments = {
            italic = true;
          };
          floats = "transparent";
          sidebars = "transparent";
          keywords = {
            italic = false;
          };
        };
        dim_inactive = true;
        transparent = true;
      };
    };

    # This is sort of nice, but I'm not sure I can get used to it.
    # Keeping it for playing around with.
    catppuccin = {
      enable = true;
      settings = {
        background = {
          light = "macchiato";
          dark = "mocha";
        };
        flavour = "mocha"; # “latte”, “mocha”, “frappe”, “macchiato”, “auto”
        transparent_background = false;
        integrations = {
          cmp = true;
          flash = true;
          fidget = true;
          gitsigns = true;
          indent_blankline.enabled = true;
          lsp_trouble = true;
          mini.enabled = true;
          neotree = true;
          noice = true;
          notify = true;
          telescope.enabled = true;
          treesitter = true;
          treesitter_context = true;
          which_key = true;
          native_lsp = {
            enabled = true;
            inlay_hints = {
              background = true;
            };
            virtual_text = {
              errors = [ "italic" ];
              hints = [ "italic" ];
              information = [ "italic" ];
              warnings = [ "italic" ];
              ok = [ "italic" ];
            };
            underlines = {
              errors = [ "underline" ];
              hints = [ "underline" ];
              information = [ "underline" ];
              warnings = [ "underline" ];
            };
          };
        };
      };
    };
  };
}
