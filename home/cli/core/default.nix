{pkgs, ...}: {
  imports =
    [
      ./zsh
      ./fzf.nix
      ./git.nix
      ./coreutils.nix
    ];
}