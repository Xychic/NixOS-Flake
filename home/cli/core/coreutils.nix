{pkgs, ...}: {
  home.packages = with pkgs; [
    exa
    ncdu_2
    neofetch
    wget
    xclip
    openssl
    btop
    neovim
  ];
}
