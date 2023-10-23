{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    glibc
    python310
    gnumake
    gdb
  ];
}
