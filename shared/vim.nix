(pkgs.neovim.override {
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;

  configure = {
    customRC = ''
      set relativenumber
      set list
      if &diff
        colorscheme blue
      endif
      syn on
      set tabstop=2
      set shiftwidth=2
      set sts=2
      set smarttab
      set expandtab
      set autoindent
      set hls
      set ruler
      set splitbelow
      set splitright
    '';
  };
  override = {}: {
    packages.nix.start = with pkgs.vimPlugins; [
      boole-nvim
      catppuccin-nvim
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      comment-nvim
      fidget-nvim
      flash-nvim
      friendly-snippets
      FTerm-nvim
      gitsigns-nvim
      indent-blankline-nvim
      lazygit-nvim
      lualine-nvim
      luasnip
      neodev-nvim
      neoscroll-nvim
      noice-nvim
      nui-nvim
      nvim-cmp
      nvim-colorizer-lua
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-ts-autotag
      nvim-ufo
      nvim-web-devicons
      #obsidian-nvim
      oil-nvim
      plenary-nvim
      promise-async
      rainbow-delimiters-nvim
      sort-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-symbols-nvim
      telescope-ui-select-nvim
      vim-illuminate
      which-key-nvim
    ];
  };
})
