{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwarden
    firefox
  ];
}
