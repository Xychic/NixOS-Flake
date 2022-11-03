<<<<<<< HEAD
{pkgs, ...} : {
  home.packages = with pkgs;[
    rustup
    glibc
    libgcc
  ];
}
=======
{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup
    gcc
    glibc
    rust-analyzer
    python310
  ];
}
>>>>>>> master
