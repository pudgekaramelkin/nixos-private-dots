{ pkgs, pkgs2, spkgs, inputs, ... }:

let
  username = "pudgekaramelka";
in {
  imports = [
    /etc/nixos/hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../modules/nixos/bundle.nix
    ./packages.nix
  ];

  # Если какие-то сервисы кладут систему при ребилде,
  # то их ребут при ребилде можно выключить таким конфигом:
  # systemd.services = {
  #   "accounts-daemon".restartIfChanged = false;
  #   "home-manager-buliway".restartIfChanged = false;
  # };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Ядро линуха, ласт версия
    # kernelParams = [ # https://nixos.wiki/wiki/AMD_GPU#Dual_Monitors
    #   "video=1920x1080"
    # ];

    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev"; # nodev позволяет не устанавливать grub в конкретное место, но видеть его ui
      };
      efi.canTouchEfiVariables = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;

    users.${username} = {
      isNormalUser = true;
      description = username;
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" "storage" "docker" "video" ];
      # packages = with pkgs; [
      #   clang-tools
      # ];
    };
  };

  home-manager = {
    # also pass inputs to home-manager modules
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit spkgs; inherit pkgs2; inherit inputs; };
    users.${username} = ./home.nix;
  };

  security.polkit = { # Всплывающее меню для ввода пароля
    enable = true;
  };

  # flatpak fix: systemctl --user import-environment PATH
  # systemctl --user restart xdg-desktop-portal xdg-desktop-portal-gtk

  # rollback: systemctl --user unset-environment PATH

  # check: systemctl --user show-environment | grep PATH

  # default: PATH=/nix/store/3abwqv1a1bdycmgaydzfw3a0qzxwk8am-systemd-256.8/bin/

  # test:
  # flatpak run --command=sh com.github.tchx84.Flatseal
  # xdg-open https://example.com

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = [ "gtk" "*" ];
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    # Кеш, чтоб не компилить некоторый софт
    # Если начинает компилить, то удалить пакет и применить только с этой настройкой
    # Потом добавить пакет обратно
    # substituters = [
    #   "https://cache.garnix.io"
    # ];
    # trusted-public-keys = [
    #   "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" # https://github.com/mrshmllow/affinity-nix
    # ];
  };

  system.stateVersion = "24.05"; # Don't change it

}
