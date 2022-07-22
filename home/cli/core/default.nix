{pkgs, ...}: {
  imports =
    [
      ./zsh
      ./coreutils.nix
    ];
}