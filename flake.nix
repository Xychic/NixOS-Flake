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
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }:
    {
      # Lenovo-V330
      nixosConfigurations.V330 = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          systemName = "V330";
          inherit inputs;
        };
      modules = [
        ./V330/configuration.nix
      ];
      };
    };
}
