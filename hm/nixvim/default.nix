{ ... }:
{
  imports = [
    ./config
    # ./colorschemes.nix
    # ./deps.nix
    # ./keymaps.nix
    # ./lsp.nix
    # ./plugins.nix
  ];

  viAlias = true;
  vimAlias = true;
  withNodeJs = true;
  withPerl = true;
  withPython3 = true;

  # TODO: As I've mostly just blindly copied settings from the LazyVim site, I need to go over and compare to my
  # local settings, and probably adjust some stuff that is not relevant in this setup.
  # globals = {
  #   mapleader = " ";
  #   maplocalleader = "\\";
  #   autoformat = true;
  #   snacks_animate = false;
  #   trouble_lualine = true;
  #   markdown_recommended_style = 0;
  # };

  # opts = {
  #   autowrite = true;
  #   clipboard = "unnamedplus"; # TODO: change, if needed, to get OSC 52 and tmux working
  #   completeopt = "menu,menuone,noselect";
  #   conceallevel = 2;
  #   confirm = true;
  #   cursorline = true;
  #   expandtab = true;
  #   # fillchars ...
  #   foldlevel = 99;
  #   foldmethod = "indent";
  #   foldtext = "";
  #   # formatexpr = "v:lua.LazyVim.format.formatexpr()";
  #   formatoptions = "jcroqlnt";
  #   grepformat = "%f:%l:%c:%m";
  #   grepprg = "rg --vimgrep";
  #   ignorecase = true;
  #   inccommand = "nosplit";
  #   jumpoptions = "view";
  #   laststatus = 3;
  #   linebreak = true;
  #   list = false;
  #   mouse = "a";
  #   number = true;
  #   pumblend = 10;
  #   pumheight = 10;
  #   relativenumber = true;
  #   ruler = false;
  #   scrolloff = 4;
  #   # sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
  #   shiftround = true;
  #   shiftwidth = 2;
  #   # shortmess:append({ W = true, I = true, c = true, C = true })
  #   showmode = true; # disable with statusline
  #   sidescrolloff = 8;
  #   signcolumn = "yes";
  #   smartcase = true;
  #   smartindent = true;
  #   smoothscroll = true;
  #   # spelllang = { "en" }
  #   splitbelow = true;
  #   splitkeep = "screen";
  #   splitright = true;
  #   # statuscolumn = [[%!v:lua.LazyVim.statuscolumn()]]
  #   tabstop = 2;
  #   termguicolors = true;
  #   timeoutlen = 300;
  #   undofile = true;
  #   undolevels = 10000;
  #   updatetime = 200;
  #   virtualedit = "block";
  #   wildmode = "longest:full,full";
  #   winminwidth = 5;
  #   wrap = false;
  # };

}
