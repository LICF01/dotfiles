# Dotfiles

Personal dotfiles for **Arch Linux** and **CachyOS**: a **niri + Noctalia** Wayland
desktop, fish/zsh shells, tmux, kitty/ghostty, and editor/CLI tool configs.

Everything is managed as a Git repository at `~/.dotfiles` whose work tree is your
home directory, so tracked files are written straight into `$HOME` (no symlinks, no
stow). The clone at `~/.dotfiles` is a regular checkout, so the `.gitignore` entry
hides it from `$HOME`'s status.

> **KDE Plasma is recommended, not required.** It gives you a Plasma fallback session,
> the Dolphin file manager (`Mod+Shift+E`), and the services `.config/niri/startup.kdl`
> launches (`kded6`, `kdeconnectd`, kwallet unlock). niri and Noctalia run without it,
> but those startup services won't. Step 3 covers it.

---

## Quick install

On a fresh CachyOS (or Arch with `git` installed):

```bash
git clone https://github.com/LICF01/dotfiles.git ~/.dotfiles
~/.dotfiles/bootstrap/install.sh
```

The script deploys the dotfiles (backing up any file that differs from the repo),
installs the packages in `bootstrap/packages.txt`, asks about KDE, the Noctalia plugin
dependencies, tpack (the tmux plugin manager) and the optional AUR package, sets up fish,
fisher and the Noctalia settings link, and tells you how to start the session. It is safe
to re-run.

After the first session launch, run `~/.dotfiles/bootstrap/noctalia-plugins.sh` to
enable your Noctalia plugins (step 13).

The numbered steps below do the same things by hand and explain each one. Use them
if you want to know what the script changes, or if you are on plain Arch.

---

## What's in here

| Path | Purpose |
|------|---------|
| `.config/niri/` | niri compositor config (`config.kdl` + `startup.kdl`, `binds.kdl`, `outputs.kdl`, `inputs.kdl`, `window-rules.kdl`, `layout.kdl`, `noctalia.kdl`) |
| `.config/noctalia/` | Noctalia shell config (`config.toml`, which holds the enabled plugin list), GUI settings buffer (`gui/settings.toml`, kept empty by `noctalia-sync`), colorschemes. Plugin code is not tracked; Noctalia installs it. |
| `.config/environment.d/` | Qt/KDE environment variables (read before niri starts) |
| `.config/xdg-desktop-portal/` | Portal selection for niri (gnome default, KDE file chooser) |
| `.config/fish/` | fish config, `fish_plugins` (fisher), `conf.d` snippets |
| `.zshrc` | zsh config (zinit, fzf, starship, zoxide, fnm) |
| `.tmux.conf` | tmux config (plugins via [tpack](https://github.com/tmuxpack/tpack)) |
| `.config/kitty/`, `.config/ghostty/` | terminals |
| `.config/btop/`, `.config/yazi/`, `.config/lazygit/` | TUI apps (Tokyo Night themes) |
| `.claude/themes/` | Claude Code Tokyo Night theme |
| `.config/fzf/themes/` | fzf Tokyo Night colors, sourced by fish and zsh |
| `.config/zed/`, `.config/Code/`, `.ideavimrc` | editors/IDEs |
| `.local/share/color-schemes/`, `.local/share/konsole/` | KDE color schemes + konsole profile |
| `bootstrap/` | `install.sh` and the package lists it installs from |

---

## Keybinds

`Mod` is the Super key (niri's default; nothing in this repo overrides it). The full
list is in `.config/niri/binds.kdl`, and `Mod+Shift+/` shows it in niri.

### Apps and shell

| Bind | Action |
|------|--------|
| `Mod+Space` | Noctalia launcher |
| `Mod+C` / `Mod+Shift+C` | Clipboard history / control center |
| `Mod+Shift+S` | Noctalia settings |
| `Super+Return` | Terminal (kitty) |
| `Mod+Shift+E` | Dolphin (GUI file manager) |
| `Mod+E` | yazi (terminal file manager) |
| `Mod+A` / `Mod+B` / `Mod+N` | Audio (wiremix) / Bluetooth (bluetui) / Network (impala) |
| `Mod+T` / `Mod+D` / `Mod+M` | btop / lazydocker / vi-mongo |

### niri window manager

| Bind | Action |
|------|--------|
| `Mod+O` | Overview |
| `Mod+Q` | Close window |
| `Mod+H/J/K/L` (or arrows) | Focus column / window |
| `Mod+Ctrl+H/J/K/L` | Move column / window |
| `Mod+Shift+H/J/K/L` | Focus monitor |
| `Mod+Shift+Ctrl+H/J/K/L` | Move column to monitor |
| `Mod+U` / `Mod+I` (or `Mod+Page_Down/Up`) | Focus workspace down / up |
| `Mod+1` … `Mod+9` | Focus workspace N |
| `Mod+Shift+1` … `Mod+Shift+9` | Move column to workspace N |
| `Mod+F` / `Mod+Shift+F` | Maximize column / fullscreen |
| `Mod+R` | Cycle preset column width |
| `Mod+V` / `Mod+W` | Toggle floating / tabbed column |
| `Print` / `Ctrl+Print` / `Alt+Print` | niri screenshot: region / screen / window |
| `Mod+Shift+Escape` | Quit niri |

---

## Requirements

- Arch Linux or CachyOS (x86_64)
- `git`
- KDE Plasma installed (recommended; see the note at the top)
- `paru`, for the AUR packages in step 9: `tpack-bin` (tmux plugins) and the optional
  `vi-mongo`. CachyOS ships paru; on plain Arch, build it from the AUR.

---

## Install (manual steps)

Each step is its own command, and the order matters: later steps read files created
by earlier ones. The quick install above runs all of them.

- **0 → 1** first: `git` is needed to clone, and step 1 supplies every config the
  rest of the steps read.
- **2 → 8** can be reordered or skipped. They only install packages (all names
  verified against the Arch/CachyOS repos). Re-running any of them is safe thanks
  to `--needed`. `bootstrap/packages.txt` holds the same packages as steps 2, 4–7.
- **8** (plugin dependencies) and **9** (one AUR package) are optional.
- **10 → 11 → 12 → 13** must stay in that order: bootstrap the shells, wire up
  Noctalia *before* its first launch, start the session, then enable the plugins.

### 0. Prerequisites

```bash
sudo pacman -S --needed git base-devel
```

<details>
<summary>Arch only: install an AUR helper (skip on CachyOS)</summary>

```bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
(cd /tmp/paru && makepkg -si)
```
</details>

### 1. Deploy the dotfiles

```bash
git clone https://github.com/LICF01/dotfiles.git ~/.dotfiles
git -C ~/.dotfiles config status.showUntrackedFiles no
git --git-dir="$HOME/.dotfiles/.git" --work-tree="$HOME" checkout -f
```

> ⚠️ **This overwrites tracked files in `$HOME`**: notably `~/.zshrc`,
> `~/.tmux.conf`, `~/.ideavimrc` and everything under `~/.config/` that the repo
> tracks (fish, niri, noctalia, kitty, …). The manual `checkout -f` does not back
> anything up. Run `git -C ~/.dotfiles ls-files` first to see the full list, and copy
> anything you want to keep. `bootstrap/install.sh` does this backup for you.

What the three commands do:

1. clone the repo into `~/.dotfiles`
2. hide `$HOME`'s untracked files from `dotfiles status` (your Downloads, caches,
   etc. would otherwise always show up)
3. write every tracked file from the index into your home directory

From now on use the `dotfiles` alias (defined in `.zshrc` and `config.fish`). It
points Git at `~/.dotfiles/.git` with `$HOME` as the work tree:

```bash
dotfiles status
dotfiles add .config/niri/binds.kdl
dotfiles commit -m "Move window keybind"
dotfiles push
```

### 2. Session: niri + Noctalia + portals

```bash
sudo pacman -S --needed niri xwayland-satellite noctalia \
  xdg-desktop-portal-gnome xdg-desktop-portal-kde
```

- `niri` / `noctalia`: compositor and desktop shell
- `xwayland-satellite`: XWayland support, spawned at startup
- `xdg-desktop-portal-gnome`: required by `.config/xdg-desktop-portal/niri-portals.conf`
  (`default=gnome`); the KDE portal is used for file choosers

### 3. KDE integration (recommended)

```bash
sudo pacman -S --needed dolphin kded kservice kwallet kwallet-pam \
  polkit-kde-agent plasma-integration kdeconnect qt6-wayland qt6ct xdg-user-dirs
```

Why it's worth installing even though niri doesn't need it:

- A Plasma session is a fallback if niri breaks, and Dolphin is the GUI file manager.
- These packages satisfy `.config/niri/startup.kdl`:

| Package | Provides |
|---------|----------|
| `kwallet-pam` | `/usr/lib/pam_kwallet_init` (unlock kwallet at login) |
| `kded` | `kded6` |
| `kservice` | `kbuildsycoca6` (fixes Dolphin's default-app menu) |
| `kdeconnect` | `kdeconnectd` |
| `plasma-integration` | `QT_QPA_PLATFORMTHEME=kde` (from `.config/environment.d/`) |

`--needed` makes this a no-op for anything already installed.

### 4. Terminal + font

```bash
sudo pacman -S --needed kitty ghostty ttf-jetbrains-mono-nerd
```

Every config in this repo uses **JetBrainsMono NFM** (Nerd Font Mono). Without it
the bar, prompt and icons render as boxes.

### 5. Shells and CLI tools

```bash
sudo pacman -S --needed fish zsh starship tmux fnm pnpm
sudo pacman -S --needed fzf fd bat eza lsd zoxide ripgrep jq \
  lazygit lazydocker btop yazi neovim
```

> `fnm` is required for a quiet shell: `.config/fish/conf.d/fnm.fish` runs
> `fnm env` on every start-up and prints an error when it's missing. Same for
> `rustup` + `.config/fish/conf.d/rustup.fish`. See
> [Optional extras](#optional-extras).

### 6. Keybind helpers

```bash
sudo pacman -S --needed wl-clipboard cliphist playerctl libnotify \
  grim slurp brightnessctl wlr-randr
```

Used by the niri keybinds and startup hooks: clipboard history
(`wl-paste --watch cliphist store`), media keys (`playerctl`), notifications,
area screenshots and brightness/volume control (`noctalia msg brightness-up` etc.).

### 7. TUI apps bound in niri

```bash
sudo pacman -S --needed wiremix bluetui impala
```

`Mod+A` audio (wiremix), `Mod+B` bluetooth (bluetui), `Mod+N` network (impala).
(`btop`, `yazi`, `lazydocker` are already in step 5 and bound to `Mod+T`, `Mod+E`,
`Mod+D`.)

### 8. Noctalia plugin dependencies (optional)

```bash
sudo pacman -S --needed hyprpicker slurp tesseract tesseract-data-eng imagemagick \
  zbar curl jq ffmpeg bc translate-shell wf-recorder gpu-screen-recorder calibre
```

Same list as `bootstrap/plugins.txt`. The plugins that need them are enabled in step 13:

| Plugin | Needs | Notes |
|--------|-------|-------|
| `oldirtty/color_picker` | `hyprpicker` | Color picker. hyprpicker is a generic Wayland tool; check it works on niri. |
| `alexander/screen-toolkit` | `slurp hyprpicker tesseract tesseract-data-eng imagemagick zbar curl jq ffmpeg bc` + a recorder | OCR, QR, palette, screenshots, recording. Recorders: `gpu-screen-recorder` (fullscreen), `wf-recorder` (fallback). `wl-screenrec` is AUR-only and optional. |
| `noctalia/screen_recorder` | `gpu-screen-recorder` | Recording |
| `congluantran/calibre` | `calibre` | `/cb` in the launcher |
| `noctalia/translator`, `noctalia/wallhaven`, `yuuto/calculator`, `vinioli/currency-exchange` | nothing | Network only |

Noctalia 5 fetches plugins from its built-in sources (`official` and `community`).
They are not part of this repo. Noctalia does not install a plugin's system
dependencies, so this step does. `translate-shell` only adds OCR translation.
`mpv` (playback) and `wl-screenrec` (AUR, preferred region recorder) are optional and
not installed here.

### 9. AUR packages

```bash
paru -S --needed tpack-bin   # tmux plugin manager (needed)
paru -S --needed vi-mongo    # optional: the Mod+M MongoDB TUI bind
```

`tpack-bin` is what manages the tmux plugins in `.tmux.conf`. `vi-mongo` is optional.

### 10. Shell bootstrap

Run **after** step 1 (it installs the plugins listed in the repo's config files):

```bash
chsh -s /usr/bin/fish
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
fish -c 'fisher update'
tpack install
```

- The first `fisher` line installs fisher itself. `fish_plugins` does not list it,
  so `fisher update` alone fails on a fresh machine.
- `fisher update` then reads `.config/fish/fish_plugins` and installs the listed
  plugins (`patrickf1/fzf.fish`).
- `tpack install` installs the tmux plugins declared in `.tmux.conf`. If it can't run
  outside tmux, start tmux and press `prefix + I` (`Ctrl-S` then `I`). `prefix + T`
  opens the tpack TUI for updates and removals. Plugins live under
  `~/.local/share/tmux/plugins`.
- zsh needs nothing: **zinit installs itself** the first time you launch zsh.

### 11. Noctalia first-run wiring

**Do this before the first `noctalia` launch**, otherwise Noctalia creates a real
settings file at `~/.local/state/noctalia/settings.toml` instead of the symlink the
repo tracks:

```bash
mkdir -p ~/.local/state/noctalia
ln -sf ~/.config/noctalia/gui/settings.toml ~/.local/state/noctalia/settings.toml
mkdir -p ~/Pictures/wallpapers
```

`.config/noctalia/config.toml` points the wallpaper at
`~/Pictures/wallpapers/...`. Copy your own images there (see
[Personalization](#personalization--gotchas) if the paths don't match your user).

### 12. Start the session

```bash
niri-session
```

From a TTY, or pick **niri** in your display manager if you use one. The first
launch starts Noctalia, xwayland-satellite, the clipboard watcher and the KDE
services from `.config/niri/startup.kdl`.

### 13. Enable the Noctalia plugins

Run this inside the session, because it talks to the running Noctalia:

```bash
~/.dotfiles/bootstrap/noctalia-plugins.sh
```

It reads `[plugins] enabled` from `.config/noctalia/config.toml` and enables
each plugin that isn't already on. Use `DRY_RUN=1` in front of it to preview the
changes. Check the result with `noctalia msg plugins list`.

---

## Verify

- [ ] `Mod+Space` opens the Noctalia launcher; the bar renders with correct icons
      (font installed in step 4)
- [ ] `noctalia msg panel-toggle launcher` works from a terminal
- [ ] `niri msg outputs` prints your monitors → fix names in `.config/niri/outputs.kdl`
- [ ] `Super+Return` opens kitty with the right font and theme
- [ ] `Mod+Shift+E` opens Dolphin; a file dialog (Dolphin, browser) opens through the KDE portal
- [ ] `tpack --version` prints a version; inside tmux, `Ctrl-S` then `I` installs the plugins, and the status bar appears
- [ ] `fish -c 'fisher update'` reports the plugins as installed
- [ ] `noctalia msg plugins list` shows every plugin in the Credits table as `enabled`
- [ ] `command -v hyprpicker tesseract gpu-screen-recorder` each print a path
- [ ] `dotfiles status` shows a clean tree

---

## Day to day

| Task | Command |
|------|---------|
| Check what changed in `$HOME` | `dotfiles status` |
| Commit a config change | `dotfiles add <path> && dotfiles commit -m "..."` |
| Same, for the repo itself | `dotlg` (lazygit pointed at `~/.dotfiles/.git`) |
| Push / pull | `dotfiles push` / `dotfiles pull` |
| Export Noctalia settings into the repo | `noctalia-sync` (fish function) |

`noctalia-sync` runs `noctalia config export` into `.config/noctalia/config.toml`,
empties the GUI settings buffer (which lives behind the symlink from step 11) and
commits `.config/noctalia`.

---

## Optional extras

Nothing below is required for the desktop or shells to work.

**Editors / IDEs**

```bash
sudo pacman -S --needed code zed
```
`.config/Code/User/{settings,keybindings}.json`, `.config/zed/` and `.ideavimrc`
are picked up automatically.

**Browsers**: `.config/brave-flags.conf` and `.config/chromium-flags.conf` apply to
`brave` / `chromium`:

```bash
sudo pacman -S --needed chromium   # in extra (both distros)
sudo pacman -S --needed brave-bin  # CachyOS repo; on Arch: paru -S brave-bin (AUR)
```

**Toolchains**

```bash
sudo pacman -S --needed rustup
```

- `rustup` is optional. `.config/fish/conf.d/rustup.fish` sources `~/.cargo/env.fish`
  only when that file exists, so nothing breaks without rustup.
- Node: use `fnm` from step 5. It is the only Node manager this setup configures.
- Homebrew: `.zshrc` and `config.fish` evaluate
  `/home/linuxbrew/.linuxbrew/bin/brew shellenv` only when brew is installed. Without
  brew, the lines are skipped silently.

---

## Running in a VM

niri needs a hardware-accelerated OpenGL renderer. A VM with a plain software or
paravirtual display gives it none. You'll see `software EGL renderers are skipped` and
`no allocator available for device` in the niri log, and the session stays black with
only the cursor moving. The shell (Noctalia) never appears because niri can't draw
frames.

In virt-manager, for a VM that should run niri:

- **Video**: model `Virtio`, tick **3D acceleration**.
- **Display Spice**: listen type **None**, tick **OpenGL**.
- The host needs a GPU with working OpenGL. Some NVIDIA hosts report a blank display
  with 3D acceleration; AMD and Intel hosts are reported to work.

If you can't get acceleration, test the setup nested inside a Plasma session instead:
niri then runs as a window. In nested mode niri uses **Alt** as `Mod`, not Super.

Background: [niri discussion #2570](https://github.com/YaLTeR/niri/discussions/2570).

---

## Personalization & gotchas

- **Username.** The shell configs use `$HOME`, so they work for any user. One file
  still hardcodes a path: `.config/noctalia/config.toml` has wallpaper paths under
  `/home/lucas/Pictures/wallpapers/`. TOML strings don't expand `$HOME`, so edit
  them by hand if your username differs:
  ```bash
  grep -n '/home/' ~/.config/noctalia/config.toml
  ```
- **Monitor-specific config.** `.config/niri/outputs.kdl` is written for particular
  display models, Noctalia's lock-screen widgets are pinned to `HDMI-A-1` / `eDP-1`,
  and `.tmux.conf` watches battery `BAT1`. Re-run `niri msg outputs` and adjust.
- **`~/.local/bin` must be on PATH.** `.zshrc` adds it explicitly; fish does so
  automatically when the directory exists.
- **`.gitignore` only ignores `.dotfiles`.** The clone lives inside `$HOME`, so this
  entry keeps it out of `dotfiles status`. Everything else untracked in `$HOME` is
  hidden by `status.showUntrackedFiles no` (step 1).
- **Plugin settings can hold secrets.** `[plugin_settings]` in the GUI settings file
  is tracked and exported by `noctalia-sync`. It can include API keys (Wallhaven,
  DeepL, the screen-toolkit upload keys). Keep keys out of the settings, or don't
  push the repo publicly.
- **Re-running step 1** (`checkout -f`) is the fastest way to reset tracked files
  back to the committed state. It never deletes untracked files.

---

## Credits

The plugins in step 13 come from Noctalia's sources and are not vendored here. Each
plugin's author is the part of its id before the slash:

| Plugin id | Source |
|-----------|--------|
| `oldirtty/color_picker` | community |
| `alexander/screen-toolkit` | community |
| `yuuto/calculator` | community |
| `congluantran/calibre` | community |
| `vinioli/currency-exchange` | community |
| `noctalia/screen_recorder` | official (Noctalia Team) |
| `noctalia/translator` | official (Noctalia Team) |
| `noctalia/wallhaven` | official (Noctalia Team) |
| `egno/vial_keymap` | community |
| `ayagmar/obs-control` | community |

The Tokyo Night themes for btop, yazi, fzf and Claude Code are taken from
[folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim).

The personal configs in this repo have no license. Add one before reusing them
outside your own machines.

---

## Tested on

- CachyOS, kernel `7.2.9-2-cachyos`
- niri `26.04-1.1`, Noctalia `5.2.1-1.1`
- Checked 2026-10-11. niri and Noctalia move fast, so re-check the keybinds and the
  Noctalia config after upgrading.
