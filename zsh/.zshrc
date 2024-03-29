#!/bin/sh
export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP


# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# proxy settings
#export host_ip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
#export host_ip=127.0.0.1
#port=20171
#proxy_env="http://${host_ip}:${port}"
#alias proxy='export all_proxy=${proxy_env} http_proxy=${proxy_env} https_proxy=${proxy_env};echo "proxy set"'
#alias unproxy='unset all_proxy http_proxy https_proxy;echo "proxy unset"'
#alias g_proxy='git config --global http.proxy "${proxy_env}"; git config --global https.proxy "${proxy_env}";echo "git config proxy set."'
#alias g_unproxy='git config --global --unset http.proxy;git config --global --unset https.proxy;echo "git config proxy unset."'
#alias d_proxy='echo "Host ip=${host_ip}\nall_proxy=${all_proxy}\nhttp_proxy=${http_proxy}\nhttps_proxy=${https_proxy}"'

# Enable proxy by default
# export all_proxy=${proxy_env} http_proxy=${proxy_env} https_proxy=${proxy_env}
# git config --global http.proxy "${proxy_env}"
# git config --global https.proxy "${proxy_env}"

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "skywind3000/z.lua"
# zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

# z.lua config
export _ZL_MATCH_MODE=1
alias zc='z -c'      # match sub-dir only
alias zz='z -i'      # use interactive choosing mode
alias zf='z -I'      # use fzf to choose from multipule results
alias zb='z -b'      # back to parent directory
alias zh='z -I -t .' # search from command history

# Key-bindings
bindkey -s '^o' 'ranger^M'
bindkey -s '^f' 'zi^M'
bindkey -s '^s' 'ncdu^M'
# bindkey -s '^n' 'nvim $(fzf)^M'
# bindkey -s '^v' 'nvim\n'
bindkey -s '^z' 'zi^M'
bindkey '^[[P' delete-char
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
bindkey -r "^u"
bindkey -r "^d"

# FZF 
# TODO update for mac
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"
# export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
compinit

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line

# TODO Remove these
# setxkbmap -option caps:escape
# xset r rate 210 40

# Speedy keys
# xset r rate 210 40

# Environment variables set everywhere
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"

# For QT Themes
export QT_QPA_PLATFORMTHEME=qt5ct

# remap caps to escape
# setxkbmap -option caps:escape
# swap escape and caps
# setxkbmap -option caps:swapescape

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
fi

eval $(thefuck --alias)

# For Ruby gem path
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
