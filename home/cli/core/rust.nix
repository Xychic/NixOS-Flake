{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/846fc5ddb810c36411de6587384bef86c2db5127.tar.gz";
            sha256 = "sha256:0ys4h8fbbk8wg2ylqh5y6ld53x2wkmx5rclczanzlafvcfzh5jgp";
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