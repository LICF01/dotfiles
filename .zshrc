
setopt autocd

#######################################################################
# Zinit's Installer
#
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

#######################################################################
# Zinit Pluggin list
#
# zinit light spaceship-prompt/spaceship-prompt

#auto-ls
zinit ice wait'0' lucid

zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions

# must be the last one
zinit load zsh-users/zsh-syntax-highlighting


######################################################################
# Propmt
#
eval "$(starship init zsh)"

######################################################################
# Aliases
#
alias vim="nvim"
alias nv="$HOME/.local/bin/nv.sh"
alias neovide="$HOME/Apps/neovide/neovide"
alias emacs="emacsclient -c -a 'emacs'"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME'
alias luamake=/home/lucas/lua-language-server/3rd/luamake/luamake


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$PATH:/opt/mssql-tools/bin"



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
