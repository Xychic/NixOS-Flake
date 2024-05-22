{pkgs, ...}: {
  home.packages = with pkgs; [
    stdenv.cc.cc.lib
    (python312.withPackages (ps: with ps; [
    ]))
    mypy
  ];
}