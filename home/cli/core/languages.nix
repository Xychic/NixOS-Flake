{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup
    gcc
    glibc
    rust-analyzer
    python310
  ];
}
