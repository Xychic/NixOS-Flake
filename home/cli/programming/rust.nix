{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (import "${
      fetchTarball {
        url = "https://github.com/nix-community/fenix/archive/0774f58cf1025bbb713971deecc7f07c856be6ed.tar.gz";
        sha256 = "sha256:1zfbldcdvmzcqp68hb98sjq788i4ih9y42k952kkb5jki5ym3kpf";
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
