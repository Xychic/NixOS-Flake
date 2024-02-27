{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    glibc
    python310
    python310Packages.pip
    python310Packages.jupyter
    python310Packages.notebook
    mypy
    gnumake
    gdb
    statix
    nixd
    go
    nasm
  ];
}
