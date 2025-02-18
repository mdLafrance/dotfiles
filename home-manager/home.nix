{ config, pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> { config = { allowUnfree = true; }; };
  wrapped_spotify = pkgs.writeShellScriptBin "spotify" ''
    exec ${pkgs.spotify}/bin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu
    '';
  wrapped_chrome = pkgs.writeShellScriptBin "google-chrome" ''
    exec ${pkgs.google-chrome}/bin/google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland --force-device-scale-factor=1 --disable-features=WaylandFractionalScaleV1
    '';
in
{
  home = {
    stateVersion = "24.05";
    username = "mdlafrance";
    homeDirectory = "/home/mdlafrance";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.sessionVariables = {
    OPENSSL_DIR = "${pkgs.openssl.dev}";
    OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
    OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
    PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";
    LD_LIBRARY_PATH = "/run/current-system/sw/lib";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
  };

  home.packages = with pkgs;
    [        
      unstable.neovim
      swww
      wrapped_chrome
      ripgrep
      lazygit
      starship
      waybar
      rofi-wayland
      neofetch
      pavucontrol
      pamixer
      (unstable.obsidian.override { commandLineArgs = [ "--disable-gpu --no-sandbox --ozone-platform=wayland --ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations" ]; })
      go
      python310
      cargo
      rustfmt
      rust-analyzer
      btop
      lua
      stylua
      gcc
      pkg-config
      nodejs
      deno
      nodePackages.typescript
      zsh
      wrapped_spotify
      pipx
      code-cursor
      wlsunset
      # terraform-ls
      # zig_0_12
      # mold
      # terraform
      # chromium
      # discord
      # awscli2
      # unityhub
      # yarn
      # go-task
      # openssl
    ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    envExtra = ''
      source ~/dotfiles/zsh/.aliases;
      export LD_LIBRARY_PATH=${pkgs.wayland}/lib:${pkgs.egl-wayland}/lib:/run/opengl-driver/lib:${pkgs.libglvnd}/lib:/run/opengl-driver-32/lib:$LD_LIBRARY_PATH
      eval $(starship init zsh);
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Link dotfiles
  home.file = {
    # Neovim config
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/mdlafrance/dotfiles/nvim;
    };

    # Starship config
    ".config/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/mdlafrance/dotfiles/starship/blue.toml;
    };

    # Kitty config
    ".config/kitty/kitty.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/mdlafrance/dotfiles/kitty/kitty.conf;
    };

    # Waybar config
    ".config/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/mdlafrance/dotfiles/waybar;
    };

    # # Hyprland config
    # ".config/hypr/hyprland.conf" = {
    #   source = config.lib.file.mkOutOfStoreSymlink /home/mdlafrance/dotfiles/hyprland/hyprland.conf;
    # };
  };
}
