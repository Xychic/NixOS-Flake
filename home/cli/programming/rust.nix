{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (import "${
      fetchTarball {
        url = "https://github.com/nix-community/fenix/archive/286f371b3cfeaa5c856c8e6dfb893018e86cc947.tar.gz";
        sha256 = "sha256:1pgvh49dayr11ysfhjd987wdavcvhlgb3jghbf2ydw773r55r8sm";
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
