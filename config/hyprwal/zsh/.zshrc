if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History
HISTSIZE=1000
HISTFILE=~/.local/state/history
SAVEHIST=100000
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Sources
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.config/zsh/.zsh-config/alias.zsh

#	Binds
bindkey '^H' backward-kill-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd 'l' forward-word
bindkey -M vicmd 'j' backward-word

# Plugins
source ~/.config/zsh/.zsh-config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/.zsh-config/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/.zsh-config/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.config/zsh/.zsh-config/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/.zsh-config/fastfetch.sh

# Pywal config
(cat ~/.cache/wal/sequences &)
cat ~/.cache/wal/sequences
source ~/.cache/wal/colors-tty.sh

# Start p10k
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Zoxide
eval "$(zoxide init zsh)"

# Exports
export PATH="$PATH:/home/bl00d/.local/bin"
export PATH=$PATH:/home/bl00d/.spicetify

setxkbmap br

# idk why but the terminal gives an error about xdotool everytime it's open, so this is a fix
clear;
