{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    glibc
    gnumake
    gdb
    libgcc.lib
  ];
}
