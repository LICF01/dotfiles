#!/usr/bin/env bash
# Enable the Noctalia plugins listed in [plugins] enabled.
#
# Noctalia has to be running (this talks to it through `noctalia msg`), so run
# this from inside the niri session, after the first launch:
#   ~/.dotfiles/bootstrap/noctalia-plugins.sh
#
# Set DRY_RUN=1 to print what would be enabled without changing anything.
# Safe to re-run: plugins that are already enabled are skipped.
set -euo pipefail

# The tracked settings file holds [plugins] enabled. noctalia-sync keeps it in
# step with what is enabled on this machine.
SETTINGS="$HOME/.config/noctalia/gui/settings.toml"

run() {
  if [ -n "${DRY_RUN:-}" ]; then
    echo "would run: $*"
  else
    "$@"
  fi
}

if ! noctalia msg plugins list >/dev/null 2>&1; then
  echo "Noctalia is not running. Start the niri session first (niri-session)." >&2
  exit 1
fi

# Ids currently enabled, e.g. "noctalia/translator" (the list's last column is the state).
already=$(noctalia msg plugins list | awk '$NF == "enabled" { print $1 }')

# Ids from the enabled array: the quoted "author/name" strings between
# `[plugins]` and the closing `]`.
wanted=$(sed -n '/^\[plugins\]/,/^\]/p' "$SETTINGS" | grep -oE '"[^"]+/[^"]+"' | tr -d '"' || true)

if [ -z "$wanted" ]; then
  echo "No plugins listed in [plugins] enabled in $SETTINGS."
  exit 0
fi

while IFS= read -r id; do
  if grep -qxF "$id" <<<"$already"; then
    echo "already enabled: $id"
  else
    echo "enabling: $id"
    run noctalia msg plugins enable "$id"
  fi
done <<<"$wanted"

echo "Done. Check with: noctalia msg plugins list"
