{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/4b07da0f91ea99f263f47165a11a48678c9e0dc3.tar.gz";
            sha256 = "sha256:13rmlpf7igvilg1xx1jrrcvjvviabbgjlby4g9dvvxx8fr3xwz9i";
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