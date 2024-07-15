{ config, pkgs, ... }:

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
      google-chrome
      starship
      waybar
      go
      mold
      gcc
      cmake
      ripgrep
      lua
      cargo
      lazygit
      rofi-wayland
      terraform
      obsidian
      chromium
      neofetch
    ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    envExtra = ''
      source ~/dotfiles/zsh/.aliases;
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
