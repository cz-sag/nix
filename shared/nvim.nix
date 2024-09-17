{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        set number
        set relativenumber
        set list
        set tabstop=2
        set shiftwidth=2
        set smarttab
        set autoindent
        set expandtab

        set ruler
        set splitbelow
        set splitright

        luafile ${./nvim.lua}
      '';
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          vim-nix
          rainbow
          nvim-cmp # cmp base package
          cmp-buffer # buffer based completion
          cmp-nvim-lsp # lsp integration
          lspkind-nvim
          cmp-git

          markdown-preview-nvim # preview
        ];
      };
    };
  };
}
