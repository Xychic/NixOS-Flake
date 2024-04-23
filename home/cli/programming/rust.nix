{pkgs, ...}: {
  nixpkgs.overlays = [
    (import "${
        fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/d596927635ddd8db224bbff6e4ccb08e42649eb5.tar.gz";
            sha256 = "sha256:1avngyggx53c1yh5bxyal4xzgv8xf52yk8dn19xwnvhjszxy5r9q";
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