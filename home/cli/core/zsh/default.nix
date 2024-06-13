{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    plugins = (import ./plugins.nix) pkgs;
    shellAliases = import ./aliases.nix;

    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = false;
      save = 15000;
      share = true;
    };
    envExtra = "
      source ~/.config/zsh/plugins/zsh-git-prompt/git-prompt.zsh
      export EDITOR=nvim;
    ";
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };
}
