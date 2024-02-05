## Config files shared across environments
> For me, when I forget where stuff goes

Config files are linked from wherever this repo lives, to their expected locations.  
To automatically scan for required software, and generate symlinks for configs, run
```bash
./setup
```


### Required programs

| Name | Download | Test with | Config | Used for |
|---|---|---|---|---|
| Kitty | `curl -L https://sw.kovidgoyal.net/kitty/installer.sh \| sh /dev/stdin` | | Link kitty folder to `~/.config/kitty` | Terminal
| Neovim | https://neovim.io/ | `nvim --version` | Link nvim folder to `~/.config/nvim` | Text editor |
| Ripgrep | `sudo apt-get install ripgrep` | | | Fuzzy finding in nvim |
| lazygit | `curl -sS https://starship.rs/install.sh \| sh` | `lazygit --version` | | Curses git interface |
| Zsh  | `sudo apt-get install zsh`.  Enable with `chsh -s $(which zsh)`  | `zsh --version` | Copy `zsh/custom` somewhere and source it in zshrc | Shell |
| ohmyzsh | `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` | | | Shell |
| Starship | `curl -sS https://starship.rs/install.sh \| sh` | `which starship` | Copy config file to `~/.config/starship.toml` | Shell |

