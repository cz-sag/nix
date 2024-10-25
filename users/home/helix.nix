{ pkgs, ... }:{
  
  programs.helix = {
    enable = true;
    settings = {
      theme = "onedarker";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
    languages = {
      language-server = {
        "vscode-json-language-server" = {
          command = "vscode-json-languageserver";
        };
      };
    };
  };
  home.packages = (with pkgs; [
      clang-tools
      lldb
      yaml-language-server
    ]) ++ (with pkgs.nodePackages; [
      bash-language-server
      vscode-json-languageserver
    ]) ++ (with pkgs.python312Packages; [
      python-lsp-server
    ]);
}
