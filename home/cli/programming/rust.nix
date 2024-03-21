{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/0dd47e8403f6eb3311e47a6bc139be22206b1e38.tar.gz";
            sha256 = "sha256:1ypx465dgi7bm57kqkqnym49p5xyxs1bi3f7ap3lalaxlmv9912d";
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