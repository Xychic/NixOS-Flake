{pkgs, ...} : {
  home.packages = with pkgs;[
    rustup
    glibc
    libgcc
  ];
}