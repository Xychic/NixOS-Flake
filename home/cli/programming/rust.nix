{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/1df7cd8d759674ac69bdb67e0d55446c2394da68.tar.gz";
            sha256 = "sha256:0n2kikjd5jiskx13b96911l91l0319d6vbn0hn9cpfwz7n616pdq";
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
