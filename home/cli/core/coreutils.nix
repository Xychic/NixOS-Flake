{pkgs, ...}: {
  home.packages = with pkgs; [
    exa
    ncdu
    neofetch
    wget
    firefox
  ];
}