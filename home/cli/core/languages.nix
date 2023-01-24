{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup
    gcc
    glibc
    rust-analyzer
    cargo-generate
    python310
    gnumake
  ];
}
