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
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    grub2-themes,
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
        ./devices/v330
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
                ];
              };
            };
          }
        )
        grub2-themes.nixosModules.default
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
        ./devices/ncase
        ./modules/vm
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
                  ./home/gui/core
                  ./home/gui/vscode
                  ./home/gui/discord
                  ./home/gui/chrome
                  ./home/gui/pavucontrol
                  ./home/gui/spotify
                  ./home/gui/teams
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
