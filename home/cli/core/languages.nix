{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    glibc
    python310
    mypy
    gnumake
    gdb
    statix
    nixd
  ];
}
