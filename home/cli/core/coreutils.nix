{pkgs, ...}: {
  home.packages = with pkgs; [
    exa
    ncdu_2
    neofetch
    wget
    xclip
    comma
    openssl
    btop
  ];
}
