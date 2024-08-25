{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (import "${
      fetchTarball {
        url = "https://github.com/nix-community/fenix/archive/71fe264f6e208831aa0e7e54ad557a283c375014.tar.gz";
        sha256 = "sha256:0qdc42alilvzm4i64fcrvsbb6q7fg1nrp02k1d909gj6k48baqf3";
      }
    }/overlay.nix")
  ];
  home.packages = with pkgs; [
    (fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly
    cargo-generate
  ];
}
