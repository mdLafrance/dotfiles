{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  wrapped_spotify = pkgs.writeShellScriptBin "spotify" ''
    exec ${pkgs.spotify}/bin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu
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

  home.packages = with pkgs;
    [
      zsh
      python310
      nodejs_22
      nodePackages.typescript
      google-chrome
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
