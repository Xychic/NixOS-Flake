{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/b6fc5035b28e36a98370d0eac44f4ef3fd323df6.tar.gz";
            sha256 = "sha256:0hzybd8fcfpr4fd62xl3kx144h2p2mh8kqva7nijxvmjl4zj71x5";
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
