{pkgs, ...}: {
  home.packages = with pkgs; [
    eza
    ncdu_2
    neofetch
    wget
    xclip
    openssl
    btop
    neovim
  ];
}
