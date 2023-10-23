{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/main.tar.gz";
            sha256 = "17xvh61ma222i9za7zwn8xhydrq2wkhkv1qf0ss2hcw0hj1q1ajz";
        }
    }/overlay.nix")
  ];
  home.packages = with pkgs; [
    (fenix.complete.withComponents [
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