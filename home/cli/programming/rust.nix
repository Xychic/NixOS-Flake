{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/12222a90a7e02443f822e679055858d786e7324f.tar.gz";
            sha256 = "sha256:1l818fc5x296hlma8zb5g1n2xwx0k6fxnk7x8dzbgk6px0d9bx9h";
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