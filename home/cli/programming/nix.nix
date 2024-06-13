{ pkgs, ... }:
{
  home.packages = with pkgs; [
    statix
    nixd
  ];
}
