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
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let 
    nixpkgsConfig = {
      config = {
        allowUnfree = true;
      };
    };
  in {
    # Lenovo-V330
    nixosConfigurations.V330 = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        systemName = "V330";
        inherit inputs;
      };
      modules = [
        ./V330
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
                  ./home/cli/core
                  ./home/gui/vscode
                  ./home/gui/discord
                  ./home/gui/chrome
                  ./home/window-managers/kde
                ];
              };
            };
          }
        )
      ];
    };

    # NCASE M1
    nixosConfigurations.NCASE = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        systemName = "NCASE";
        inherit inputs;
      };
      modules = [
        ./NCASE
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
                  ./home/cli/core
                  ./home/gui/vscode
                  ./home/gui/discord
                  ./home/gui/chrome
                  ./home/gui/pavucontrol
                  ./home/window-managers/kde
                ];
              };
            };
          }
        )
      ];
    };
  };
}
