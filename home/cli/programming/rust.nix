{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/6f702a6dc8db259225a2f34510c077fe33c1f52e.tar.gz";
            sha256 = "sha256:1171m1ipp2i9y5zpqgkms65hqnb22sdj6v156435b4pwfxcx9174";
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