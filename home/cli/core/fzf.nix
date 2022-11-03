{pkgs, ...}: {
  home.packages = with pkgs; [fzf];
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--preview='head -$LINES {}'"
    ];
  };
}
