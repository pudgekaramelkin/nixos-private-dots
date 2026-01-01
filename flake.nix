{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Вторая unstable ветка, которую я буду обновлять отдельно
    # Нужна если я не хочу обновлять систему, но хочу обновить конкретный софт
    # Просто задам этому софту репу pkgs2 и обновлю только её
    nixpkgs2.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = { # Удобно ставить некоторые игры
      url = "github:fufexan/nix-gaming"; 
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
      rocmSupport = true;
      permittedInsecurePackages = [
        "python-2.7.18.8"
        "electron-25.9.0"
      ];
    };
    pkgs = import nixpkgs {
      inherit system;
      inherit config;
    };
    pkgs2 = import inputs.nixpkgs2 {
      inherit system;
      inherit config;
    };
    spkgs = import inputs.nixpkgs-stable {
      inherit system;
      inherit config;
    };
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit spkgs; inherit pkgs2; inherit inputs; };
        inherit pkgs;
        inherit system;
        modules = [
          ./nixos/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
