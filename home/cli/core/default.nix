{pkgs, ...}: {
  imports =
    [
      ./zsh
      ./fzf.nix
      ./coreutils.nix
    ];
}
