#!/usr/bin/env bash
# Bootstrap a fresh Arch / CachyOS install for this dotfiles setup.
#
# Run it from the clone (README step 1):
#   git clone https://github.com/LICF01/dotfiles.git ~/.dotfiles
#   ~/.dotfiles/bootstrap/install.sh
#
# Safe to re-run: packages use --needed, symlinks use -f, and the deploy step
# only backs up files that differ from the repo.
set -euo pipefail

DOT="$HOME/.dotfiles"
BOOT="$DOT/bootstrap"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
GIT=(git --git-dir="$DOT/.git" --work-tree="$HOME")

# ask "question" [y|n] -> success on yes. The second argument is the default.
ask() {
  local reply
  read -rp "$1 " reply
  case "${reply:-${2:-n}}" in
    [Yy]*) return 0 ;;
    *) return 1 ;;
  esac
}

# Package list without comments and blank lines.
read_list() {
  grep -vE '^\s*(#|$)' "$1"
}

preflight() {
  if [ ! -d "$DOT/.git" ]; then
    echo "Clone the repo to ~/.dotfiles first (README step 1)." >&2
    exit 1
  fi
  if [ "$(id -u)" -eq 0 ]; then
    echo "Run as your normal user, not root (sudo is called where needed)." >&2
    exit 1
  fi
  if ! command -v pacman >/dev/null; then
    echo "pacman not found: this script only supports Arch and CachyOS." >&2
    exit 1
  fi
}

# Check out the repo into $HOME. Existing files that differ from the repo are
# moved to $BACKUP first, so nothing is lost silently.
deploy() {
  echo "==> Deploying dotfiles into $HOME"
  "${GIT[@]}" config status.showUntrackedFiles no
  cd "$HOME"

  local f target moved=0
  while IFS= read -r f; do
    target="$HOME/$f"
    if [ -e "$target" ] || [ -L "$target" ]; then
      if ! git --git-dir="$DOT/.git" show "HEAD:$f" | cmp -s - "$target"; then
        mkdir -p "$BACKUP/$(dirname "$f")"
        mv "$target" "$BACKUP/$f"
        moved=$((moved + 1))
      fi
    fi
  done < <("${GIT[@]}" ls-files)

  "${GIT[@]}" checkout -f

  if [ "$moved" -gt 0 ]; then
    echo "    backed up $moved file(s) to $BACKUP"
  fi
}

install_packages() {
  echo "==> Installing core packages"
  local pkgs kde
  mapfile -t pkgs < <(read_list "$BOOT/packages.txt")
  sudo pacman -S --needed "${pkgs[@]}"

  if ask "Install KDE Plasma integration (Dolphin, kwallet, KDE services)? [Y/n]" y; then
    echo "==> Installing KDE integration"
    mapfile -t kde < <(read_list "$BOOT/kde.txt")
    sudo pacman -S --needed "${kde[@]}"
  fi
}

install_plugin_deps() {
  if ask "Install Noctalia plugin dependencies (hyprpicker, calibre, OCR, recording)? [Y/n]" y; then
    echo "==> Installing Noctalia plugin dependencies"
    local plug
    mapfile -t plug < <(read_list "$BOOT/plugins.txt")
    sudo pacman -S --needed "${plug[@]}"
  fi
}

install_aur() {
  if ! command -v paru >/dev/null; then
    echo "==> paru not found: skipping optional AUR package (vi-mongo, Mod+M)"
    return
  fi
  if ask "Install optional AUR package vi-mongo (Mod+M)? [y/N]" n; then
    paru -S --needed vi-mongo
  fi
}

setup_shells() {
  echo "==> Setting up shells and plugins"
  if [ "$(basename "$SHELL")" != fish ]; then
    chsh -s /usr/bin/fish
  fi

  # fisher is not in fish_plugins, so install it before running `fisher update`.
  fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
  fish -c 'fisher update'

  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  fi
  echo "    zinit installs itself on first zsh launch."
  echo "    In tmux, press Ctrl-S then I to install the plugins."
}

setup_noctalia() {
  echo "==> Wiring Noctalia settings (before its first launch)"
  local ns="$HOME/.local/state/noctalia/settings.toml"
  mkdir -p "$HOME/.local/state/noctalia" "$HOME/Pictures/wallpapers"

  # If Noctalia already created a real settings file, keep it as .bak.
  if [ -e "$ns" ] && [ ! -L "$ns" ]; then
    mv "$ns" "$ns.bak"
    echo "    existing settings moved to $ns.bak"
  fi
  ln -sfn "$HOME/.config/noctalia/gui/settings.toml" "$ns"
  echo "    copy your wallpapers into ~/Pictures/wallpapers"
}

main() {
  preflight
  deploy
  install_packages
  install_plugin_deps
  install_aur
  setup_shells
  setup_noctalia

  echo
  echo "Done. Start the session from a TTY with: niri-session"
  echo "Inside the session, enable the Noctalia plugins with:"
  echo "  ~/.dotfiles/bootstrap/noctalia-plugins.sh"
  echo "Then work through the Verify checklist in README.md."
}

main "$@"
