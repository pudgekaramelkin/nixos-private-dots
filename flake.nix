{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Unstable ветка, которую я буду обновлять отдельно
    # Нужна если я не хочу обновлять систему, но хочу обновить конкретный софт
    # Просто задам этому софту репу pkgs2 и обновлю только её
    nixpkgs2.url = "github:nixos/nixpkgs/nixos-unstable";

    # libsForQt5.kimageformats has been removed, as KDE Frameworks 5 has reached end of life
    # Ненавижу когда мне указывают и за меня решают что есть "end of life", а что есть рабочий софт
    # Qt5 работает, программы на нём работают, многие из них не будут обновляться до qt6
    # Кто дал им право удалять кучу работающих программ из репозитория
    # и помечать их как неработающее легаси?
    # Эта репа фиксит идиотский поступок по лишению людей кучи важных программ.
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Всему что ниже надо включить кеш в конце файла configuration.nix

    # Аналог фотошопа, запуск через wine
    # affinity-nix.url = "github:mrshmllow/affinity-nix";

    # Удобная установка некоторых игр
    # nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux"; # Не понимаю зачем, если это в hardware.nix указывается
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
