{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/a0f0f781683e4e93b61beaf1dfee4dd34cf3a092.tar.gz";
            sha256 = "sha256:01n6ffh30bwfi86dim78mgigs46ljdbklll7dmys3xbr64p5js3q";
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