{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/c8943ea9e98d41325ff57d4ec14736d330b321b2.tar.gz";
            sha256 = "sha256:1r4q73ydlnqxa1pgw7n7ml6d7pzaiw3mksiy95bfjzghjxa0z8cp";
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