{ config, pkgs, inputs, ... }:

let
dotfiles = pkgs.fetchFromGitHub {
	owner = "eduardofuncao";
	repo = "dotfiles";
	rev = "main";
	sha256 = "0znbamn1cg7mpv2xf58az5cyf1ylf73fz17ixn63kwwkxlyxcnwi";
};
in
{
  home.username = "eduardo";
  home.homeDirectory = "/home/eduardo";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.file = {
    ".config/kitty" = {
      source = "${dotfiles}/kitty";
      recursive = true;
    };
    ".config/nvim" = {
      source = "${dotfiles}/nvim";
      recursive = true;
    };
    ".config/hypr" = {
      source = "${dotfiles}/hypr";
      recursive = true;
    };
    ".config/waybar" = {
      source = "${dotfiles}/waybar";
      recursive = true;
    };
    ".config/ripgrep" = {
      source = "${dotfiles}/ripgrep";
      recursive = true;
    };
    ".config/background" = {
      source = "${dotfiles}/background";
      recursive = true;
    };
    ".config/scripts" = {
      source = "${dotfiles}/scripts";
      recursive = true;
    };
    ".tmux.conf" = {
      source = "${dotfiles}/tmux.conf";
    };
  };

  # Zsh configuration with Oh My Zsh
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

      # Initialize starship and zoxide
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh)"
      
      # dstask completion
      if command -v task >/dev/null 2>&1; then
        source <(task bash-completion)
      fi
    '';
  };

  # Starship prompt configuration
  programs.starship = {
    enable = true;
  };

  # Zoxide configuration
  programs.zoxide = {
    enable = true;
  };

  # Theme
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
    style.name = "breeze";
  };

  # Configure cursor theme for Wayland
  home.pointerCursor = {
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  
  programs.git = {
    enable = true;
    userName = "Eduardo Função";
    userEmail = "eduardofuncao@hotmail.com";
    extraConfig = {
      core.editor = "nvim";
    };
  };
  
  # Additional packages for theming and functionality
  home.packages = with pkgs; [
    kdePackages.breeze-gtk kdePackages.breeze-icons kdePackages.breeze
    noto-fonts noto-fonts-cjk-sans noto-fonts-emoji
    
    zsh-autosuggestions zsh-completions zsh-syntax-highlighting
    dstask tldr fastfetch

    obs-studio docker bruno
    inputs.zen-browser.packages.${system}.default
  ];

  # Environment variables
  home.sessionVariables = {
    GTK_THEME = "Breeze-Dark";
    XCURSOR_THEME = "breeze_cursors";
    XCURSOR_SIZE = "24";
    EDITOR = "nvim";
    FUNCNEST = "100";
    RIPGREP_CONFIG_PATH = "$HOME/.config/ripgrep/ripgreprc";
  };

  # Configure fonts system-wide (excluding terminal)
  fonts.fontconfig.enable = true;

  # XDG configuration for proper application behavior
  xdg.enable = true;
}
