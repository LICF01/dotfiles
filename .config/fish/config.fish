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
alias lzd='lazydocker'

function dotlg --description 'lazygit for the dotfiles repo'
    command lazygit --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME $argv
end

# Consolidate Noctalia settings into the dotfiles repo: exports the merged
# config to config.toml, empties the GUI override buffer (through its
# symlink), and commits everything under .config/noctalia.
function noctalia-sync --description 'Export Noctalia config into dotfiles and commit'
    set -l gflags --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME -C $HOME
    set -l target $HOME/.config/noctalia/config.toml
    set -l tmp (mktemp)

    # Export to a temp file first: a bare `>` would truncate config.toml
    # even when the export fails because the config is broken.
    if noctalia config export > $tmp
        mv $tmp $target
        chmod 644 $target # mktemp creates it 600
        truncate -s 0 $HOME/.local/state/noctalia/settings.toml # empties through the symlink, keeps the link
        command git $gflags add .config/noctalia
        if command git $gflags diff --cached --quiet -- .config/noctalia
            echo 'noctalia-sync: nothing to commit'
        else
            command git $gflags commit -m 'Update Noctalia config' -- .config/noctalia
        end
    else
        echo 'noctalia-sync: export failed, nothing changed' >&2
        rm -f $tmp
        return 1
    end
end

# ls replacement config
set -x EZA_WITH_DEFAULTS 'eza --color=always --icons=always --group-directories-first'
alias ls="$EZA_WITH_DEFAULTS"
alias l="$EZA_WITH_DEFAULTS -l"
alias la="$EZA_WITH_DEFAULTS -a"
alias lla="$EZA_WITH_DEFAULTS -la"
alias lt="$EZA_WITH_DEFAULTS -T"

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

set -x BAT_THEME "tokyonight_night"

# FZF config
set -x FZF_DEFAULT_OPTS " --height 50% --tmux center,80%,80% --layout=reverse --border --color=hl:#2dd4bf"
set -x FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
set -x FZF_CTRL_T_OPTS "--preview 'bat --color=always --style=numbers --line-range :500 {}'"
set -x FZF_ALT_C_OPTS "--preview '$EZA_WITH_DEFAULTS --tree {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments ($@) to fzf.
function _fzf_comprun
    set command $argv[1]
    set argv $argv[2..-1]
    switch $command
        case cd
            fzf --preview "$EZA_WITH_DEFAULTS --tree {} | head -200" $argv
        case export unset
            fzf --preview "eval 'echo \$'{}" $argv
        case ssh
            fzf --preview "dig {}" $argv
        case '*'
            fzf --preview "bat -n --color=always {}" $argv
    end
end

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# change directory after lazygit exits if the user has changed directories within lazygit
function lg
    set -g LAZYGIT_NEW_DIR_FILE (mktemp)
    command lazygit $argv

    if test -s $LAZYGIT_NEW_DIR_FILE
        set -f new_dir (cat $LAZYGIT_NEW_DIR_FILE)
        if test -n "$new_dir" -a "$new_dir" != (pwd)
            cd $new_dir
        end
    end

    rm -f $LAZYGIT_NEW_DIR_FILE
    set -e LAZYGIT_NEW_DIR_FILE
end
