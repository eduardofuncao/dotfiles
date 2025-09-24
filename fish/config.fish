set -x fish_greeting ""
set -x EDITOR nvim
set -x PAGER bat

fish_vi_key_bindings

zoxide init fish | source
starship init fish | source
