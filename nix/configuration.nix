{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "nvidia-drm.fbdev=1"
  ];

  networking.hostName = "ADAM";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Display
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;
  };

  xdg.portal.enable = true;

  services.displayManager.autoLogin = {
    enable = false;
    user = "mdlafrance";
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    SSH_ASKPASS = "${pkgs.lxqt.lxqt-openssh-askpass}/bin/lxqt-openssh-askpass";
  };

  # Hardware
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      forceFullCompositionPipeline = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    pulseaudio = {
      enable = false;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  virtualisation.docker.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.mdlafrance = {
    isNormalUser = true;
    description = "mdlafrance";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    kitty
    git
    firefox
    brave
    zsh
    unzip
    xclip
    wget
    lxqt.lxqt-openssh-askpass
    home-manager
    wayland-scanner
    pkg-config
    wayland-utils
    libxkbcommon
    glfw-wayland
    egl-wayland
    blueman
  ];

  programs.nix-ld.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  fonts.packages = with pkgs; [
    nerdfonts
    jetbrains-mono
  ];

  programs.ssh = {
    enableAskPassword = true;
    askPassword = "${pkgs.lxqt.lxqt-openssh-askpass}/bin/lxqt-openssh-askpass";
  };

  system.stateVersion = "24.05";
}
