if status is-interactive
    # Commands to run in interactive sessions can go here
and not set -q TMUX
  tmux new-session -A -s main
end

# Removes the greeting message
set -U fish_greeting ""

 set -gx EDITOR nvim 

# Intialize the starship promptt
starship init fish | source

zoxide init fish | source

fzf --fish | source

# Set the keybindings to use vim mode
function fish_user_key_bindings
    fish_vi_key_bindings --no-erase insert
end


alias vim="nvim"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME"
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias lzd='lazydocker'

# Android Development config
set -x ANDROID_HOME $HOME/Android/Sdk
set -x PATH $PATH $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools

# Brew config
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)

# Keeps the current working directory in sync with yazi when using the `y` command
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# FZF config
set -x FZF_DEFAULT_OPTS " --height 50% --tmux center,50% --layout=default --border --color=hl:#2dd4bf"
set -x FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_ALT_C_COMMAND 'fd --type=d --strip-cwd-prefix --hidden --follow --exclude .git'

# pnpm
set -gx PNPM_HOME "/home/lucas/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
