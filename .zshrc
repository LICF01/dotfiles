## some env varables
export CAGO="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.node_modules_global/bin:/home/lucas/.cargo/bin:$PATH"

alias vim="nvim"
alias nv="$HOME/.local/bin/nv.sh"
alias neovide="$HOME/Apps/neovide/neovide"
alias dcrt="$HOME/work/Datacapture/dc-react"
alias dcdc="$HOME/work/Datacapture/dc-docker-config"


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk


# Pluggin list
# zinit light spaceship-prompt/spaceship-prompt

#auto-ls
zinit ice wait'0' lucid

zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions

# must be the last one
zinit load zsh-users/zsh-syntax-highlighting


alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/.git --work-tree=$HOME'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$PATH:/opt/mssql-tools/bin"

alias luamake=/home/lucas/lua-language-server/3rd/luamake/luamake



eval "$(starship init zsh)"
