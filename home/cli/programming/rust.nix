{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/94be183087845937b0fd77281c37d0796572b899.tar.gz";
            sha256 = "sha256:0w4cmfx22m8ggy6179g6ibrj4n6q54h9px3iabvj2ilaxwh10sij";
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