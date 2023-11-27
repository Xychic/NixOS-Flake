{
  description = "System configuration(s) for Jacob Turner";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpapers = {
      url = "github:Xychic/desktop-wallpapers";
      flake = false;
    };
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    grub2-themes,
    nix-index-database,
    ...
  }: let
    nixpkgsConfig = {
      config = {
        allowUnfree = true;
      };
    };
  in {
    # Lenovo-V330
    nixosConfigurations.v330 = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        systemName = "V330";
        inherit inputs;
      };
      modules = [
        ./v330
        home-manager.nixosModules.home-manager
        (
          {
            pkgs,
            home-manager,
            ...
          }: {
            home-manager = {
              extraSpecialArgs = specialArgs;
              users.jacob = {
                home.stateVersion = "21.11";
                nixpkgs = nixpkgsConfig;
                imports = [
                  ./home/window-managers/kde
                  ./home/cli/core
                  ./home/cli/mpd
                  ./home/gui/vscode
                  ./home/gui/discord
                  ./home/gui/chrome
                  ./home/gui/spotify
                  ./home/gui/onlyoffice
                ];
              };
            };
          }
        )
        grub2-themes.nixosModules.default
        nix-index-database.nixosModules.nix-index
        { 
          programs.nix-index-database.comma.enable = true;
          programs.nix-index = {
            enableBashIntegration = false;
            enableZshIntegration = false;
          };
        }
      ];
    };

    # NCASE M1
    nixosConfigurations.ncase = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        systemName = "NCASE";
        inherit inputs;
      };
      modules = [
        ./ncase
        home-manager.nixosModules.home-manager
        (
          {
            pkgs,
            home-manager,
            ...
          }: {
            home-manager = {
              extraSpecialArgs = specialArgs;
              users.jacob = {
                home.stateVersion = "21.11";
                nixpkgs = nixpkgsConfig;
                imports = [
                  ./home/window-managers/kde
                  ./home/cli/core
                  ./home/cli/mpd
                  ./home/cli/cuda
                  ./home/gui/core
                  ./home/gui/vscode
                  ./home/gui/discord
                  ./home/gui/chrome
                  ./home/gui/pavucontrol
                  ./home/gui/spotify
                  # ./home/gui/teams # removed as unmaintained by upstream
                  ./home/gui/onlyoffice
                ];
              };
            };
          }
        )
        grub2-themes.nixosModules.default
      ];
    };
  };
}
