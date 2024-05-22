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
    pkg-config-unwrapped
    qemu
    cascadia-code
    unzip
    qmk
  ];
}
