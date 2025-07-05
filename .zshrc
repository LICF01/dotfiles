
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


# removes the zi alias so it doesn't conflict with zoxide
zinit ice atload'unalias zi'

### End of Zinit's installer chunk

#######################################################################
# Zinit Pluggin list

zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions

# must be the last one
zinit load zsh-users/zsh-syntax-highlighting




######################################################################
# Prompt
#
eval "$(starship init zsh)"

######################################################################
# Aliases
#
alias vim="nvim"
alias nv="$HOME/.local/bin/nv.sh" alias neovide="$HOME/Apps/neovide/neovide"
alias emacs="emacsclient -c -a 'emacs'"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME'
alias luamake=/home/lucas/lua-language-server/3rd/luamake/luamake
alias gpt="$HOME/apps/gpt-cli/gpt.py"
alias work="cd $HOME/work && tmuxp load ."

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'


 set -gx EDITOR nvim 

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


export PATH="$PATH:/opt/mssql-tools/bin"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export CAPACITOR_ANDROID_STUDIO_PATH=/snap/android-studio/current/bin/studio.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="/home/lucas/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# fzf
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type=d --strip-cwd-prefix --hidden --follow --exclude .git'


# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# fzf end


# Load Angular CLI autocompletion.
if command -v ng &> /dev/null; then
  source <(ng completion script)
fi

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Changes the working directory when yazi exits
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
	  builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}


eval "$(zoxide init zsh)"


# fnm
FNM_PATH="/home/lucas/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/lucas/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi


eval "$(fnm env --use-on-cd --shell zsh)"
