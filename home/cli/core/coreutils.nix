{pkgs, ...}: {
  home.packages = with pkgs; [
    exa
    ncdu
    neofetch
    git
    wget
    firefox
  ];
}