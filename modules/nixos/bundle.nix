{
  imports = [
    # ./env.nix # Мб не надо, ибо редачу через home.nix?
    # ./filesystems.nix
    ./hardware.nix
    # ./hibernate.nix
    ./locale.nix
    ./network.nix
    ./sound.nix
    ./stylix.nix
    ./virtualisation.nix
    # ./vr.nix
    ./xserver.nix
  ];
}
