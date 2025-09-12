{ config, pkgs, inputs, ... }:

let
  dotfiles = pkgs.fetchFromGitHub {
    owner = "eduardofuncao";
    repo = "dotfiles";
    rev = "main";
    sha256 = "0llp8zh2sydgv01xkvgqvv53jkmhc0wcvbdrk9pbidxlbgcwjvaq";
  };
in
{

  imports = [
    ./work.nix
  ];
  # =========================================================================
  # HOME MANAGER CONFIGURATION
  # =========================================================================
  
  home.username = "eduardo";
  home.homeDirectory = "/home/eduardo";
  home.stateVersion = "25.05";
  
  programs.home-manager.enable = true;

  # =========================================================================
  # XDG CONFIGURATION
  # =========================================================================
  
  xdg.enable = true;

  # =========================================================================
  # DOTFILES MANAGEMENT
  # =========================================================================
  
  home.file = {
    # Terminal and shell configurations
    ".tmux.conf" = {
      source = "${dotfiles}/tmux.conf";
    };
    
    # Desktop environment configurations
    ".config/hypr" = {
      source = "${dotfiles}/hypr";
      recursive = true;
    };
    ".config/waybar" = {
      source = "${dotfiles}/waybar";
      recursive = true;
    };
    
    # Terminal emulator
    ".config/kitty" = {
      source = "${dotfiles}/kitty";
      recursive = true;
    };
    
    # Editor configuration
    ".config/nvim" = {
      source = "${dotfiles}/nvim";
      recursive = true;
    };
    
    # Tools and utilities
    ".config/ripgrep" = {
      source = "${dotfiles}/ripgrep";
      recursive = true;
    };
    ".config/scripts" = {
      source = "${dotfiles}/scripts";
      recursive = true;
    };
    
    # Media and appearance
    ".config/background" = {
      source = "${dotfiles}/background";
      recursive = true;
    };
  };

  # =========================================================================
  # SHELL CONFIGURATION
  # =========================================================================
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "colored-man-pages"
        "history-substring-search"
        "extract"
        "web-search"
        # "vi-mode"
      ];
    };
    
    initContent = ''
      # User configuration
      export FUNCNEST=100
      export EDITOR=nvim
      export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
      export PATH=$PATH:$HOME/go/bin:$HOME/.local/share/bob/nvim-bin:$HOME/.config/scripts

      # dstask aliases
      alias task=dstask
      alias t=dstask
      
      tasktohml() {
          dstask start $1
          dstask modify $1 -dev +hml +waiting P3
          dstask stop $1
      }
      
      tasktoprod() {
          dstask start $1
          dstask modify $1 -hml +prod +waiting P3
          dstask stop $1
      }

      cdin() {
        read -r dir
        [[ -n "$dir" ]] && cd "$dir"
      }

      # Initialize starship and zoxide
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh)"
      
      # dstask completion
      if command -v task >/dev/null 2>&1; then
        source <(task bash-completion)
      fi
    '';
  };

  # Terminal prompt
  programs.starship = {
    enable = true;
  };

  # Directory navigation
  programs.zoxide = {
    enable = true;
  };

  # =========================================================================
  # VERSION CONTROL
  # =========================================================================
  
  programs.git = {
    enable = true;
    userName = "Eduardo Função";
    userEmail = "eduardofuncao@hotmail.com";
    extraConfig = {
      core.editor = "nvim";
    };
  };

  # =========================================================================
  # THEMING AND APPEARANCE
  # =========================================================================
  
  # GTK theme configuration
  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };
    
    cursorTheme = {
      name = "breeze_cursors";
      package = pkgs.kdePackages.breeze;
      size = 24;
    };
    
    font = {
      name = "Noto Sans";
      size = 11;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Qt configuration to match GTK theme
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze-dark";
  };

  # Configure cursor theme for Wayland
  home.pointerCursor = {
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # =========================================================================
  # FONTS
  # =========================================================================
  
  fonts.fontconfig.enable = true;

  # =========================================================================
  # PACKAGES
  # =========================================================================
  
  home.packages = with pkgs; [
    kdePackages.breeze-gtk kdePackages.breeze-icons kdePackages.breeze
    noto-fonts noto-fonts-cjk-sans noto-fonts-emoji
    
    zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-you-should-use
    dstask tldr fastfetch ncdu

    obs-studio bruno ferdium thunderbird
    inputs.zen-browser.packages.${system}.default
  ];

  # =========================================================================
  # ENVIRONMENT VARIABLES
  # =========================================================================
  
  home.sessionVariables = {
    GTK_THEME = "Breeze-Dark";
    XCURSOR_THEME = "breeze_cursors";
    XCURSOR_SIZE = "24";
    EDITOR = "nvim";
    FUNCNEST = "100";
    RIPGREP_CONFIG_PATH = "$HOME/.config/ripgrep/ripgreprc";
  };
}
