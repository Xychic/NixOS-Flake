{pkgs, ...}: {
  home.packages = with pkgs; [
    fzf
    exa
    ncdu
    neofetch
    git
    wget
    firefox
  ];
}