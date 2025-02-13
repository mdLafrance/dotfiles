{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  wrapped_spotify = pkgs.writeShellScriptBin "spotify" ''
    exec ${pkgs.spotify}/bin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu
    '';
  wrapped_chrome = pkgs.writeShellScriptBin "google-chrome" ''
    exec ${pkgs.google-chrome}/bin/google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu
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
  };

  home.packages = with pkgs;
    [        
      code-cursor
      wayland-utils
      libxkbcommon
      glfw-wayland
      egl-wayland
      zenity
      zig_0_12
      unstable.neovim
      gitlab-runner
      google-cloud-sdk
      terraform-ls
      atk
      cairo
      librsvg
      libsoup_3
      sqlite
      glib 
      gtk3 
      libsoup
      webkitgtk_4_1
      wineWowPackages.stable
      winetricks
      swww
      zsh
      python310
      nodejs_22
      nodePackages.typescript
      wrapped_chrome
      starship
      waybar
      go
      mold
      clang-tools
      clang
      llvmPackages.libcxxStdenv
      cmake
      gnumake
      ninja
      ripgrep
      lua
      cargo
      lazygit
      rofi-wayland
      terraform
      (unstable.obsidian.override { commandLineArgs = [ "--disable-gpu" ]; })
      chromium
      neofetch
      discord
      wrapped_spotify
      pavucontrol
      pamixer
      awscli2
      rustc
      rustfmt
      rust-analyzer
      unityhub
      glfw-wayland
      stylua
      wezterm
      cmake-format
      pipx
      yarn
      libGLU
      glxinfo
      apitrace
      egl-wayland
      libglvnd
      mesa
      libGL
      vulkan-headers
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
      shaderc
      gdb
      deno
      flameshot
      go-task
      openssl
      pkg-config
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

    # Hyprland config
    ".config/hypr/hyprland.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/mdlafrance/dotfiles/hyprland/hyprland.conf;
    };
  };
}
