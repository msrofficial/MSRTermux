# MSRTermux

A minimal, clean Termux dotfiles setup for Android — no bloat, no unused features, just a focused terminal environment that works.

MSRTermux is a fork of [myTermux](https://github.com/xShin404/myTermux) by **xShin**, stripped down to the essentials and refined with a polished installer UI, a curated plugin set, and a single consistent visual theme.

---

## Credits

MSRTermux is built on the original work of **xShin** and the **myTermux** project.
Original repository: [https://github.com/xShin404/myTermux](https://github.com/xShin404/myTermux)

All core installer logic, helper scripts, and the animation system are derived from myTermux. This fork exists to provide a leaner, more focused configuration without altering the underlying architecture.

---

## What is Included

**Shell**
- ZSH with Oh My Zsh
- 8 prompt themes (see [Prompt Themes](#prompt-themes) below)
- `zsh-autosuggestions` — grey inline suggestions, right arrow to accept
- `zsh-syntax-highlighting` — green for valid commands, red for invalid
- `zsh-fzf-history-search` — up arrow opens fuzzy history search
- `zsh-autocomplete` — live history list on arrow keys, folder suggestions after `cd`

**File Management**
- `eza` — directory listing with icons (`ls`, `la`, `lt`, `lta` aliases)
- `bat` — syntax-highlighted file viewing (`cat` alias)
- `fzf` with `bat` preview (`preview` alias)
- Quick navigation aliases for common sdcard folders (`sd`, `dl`, `ds`, `ms`, `ss`)

**Editor**
- Neovim (bare install, no config bundled — bring your own)

**Theme Switcher**
- `chzsh` — switch ZSH prompt theme interactively
- `chcolor` — switch Termux color scheme interactively
- `chfont` — switch Termux font interactively

**Multiplexer**
- tmux with tmux-themepack

**Utilities**
- `gitssh` — generate SSH key and print public key for GitHub setup
- `ipconfig` — show network interface address and link information
- `macfinder` — look up vendor name from a MAC address
- `msrtermux` — CLI tool to manage MSRTermux (see below)

**Color Scheme**
- nekonako-djancoeg (default and only bundled scheme)

**Font**
- Fira Code Bold Nerd Font (default and only bundled font)

---

## What Changed from myTermux

| Removed | Reason |
|---|---|
| Music player stack (MPD, MPC, ncmpcpp) | Not part of a daily terminal workflow |
| System info displays (neofetch, rxfetch) | Removed for startup performance |
| Login screen | Unnecessary friction on every session |
| Visual toys (pipes, matrix rain, nyancat) | Pure bloat |
| Screenshot stack (awesomeshot, imagemagick) | Niche feature, heavy dependency |
| YouTube downloader wrapper (ytdl) | Outdated, not maintained |
| NvChad installer step | Forces a specific Neovim config on the user |
| Compiled binaries (ncmpcpp, nyancat) | Bundled pre-compiled binaries removed |
| repochecker.js + Node.js dependency | Unnecessary tooling |
| 7 extra fonts | Only Fira Code Bold Nerd Font kept |
| 22 extra color schemes | Only nekonako-djancoeg kept |
| lang-icons placeholder files | Empty files, no function |

---

## Requirements

- Termux (latest version from [F-Droid](https://f-droid.org/en/packages/com.termux/) recommended)
- [Termux:API](https://f-droid.org/en/packages/com.termux.api/) app installed alongside Termux
- Internet connection during installation

---

## Installation

```bash
git clone https://github.com/msrofficial/MSRTermux
cd MSRTermux
bash install.sh
```

The installer runs fully automatically — no confirmation prompts. Restart Termux after installation completes to apply all changes.

---

## Prompt Themes

Switch anytime with the `chzsh` command.

| Theme | Style |
|---|---|
| `ar-round` | Rounded corners with git branch info — **default** |
| `archcraft` | Three colored dots (traffic light), current directory |
| `simple` | Minimal folder icon with path |
| `rounded` | Two-line rounded corner prompt |
| `rounded-custom` | Compact rounded with git info |
| `la-round` | Rounded with git branch |
| `osx` | macOS Terminal style, two lines |
| `osx2` | macOS style without username |

---

## CLI Tool

The `msrtermux` command is available after installation.

```
msrtermux help        Show available commands
msrtermux uninstall   Remove MSRTermux completely and restore original Termux
```

---

## Uninstalling

Run the following from inside the MSRTermux directory:

```bash
bash uninstall.sh
```

Or if already installed, from anywhere in your terminal:

```bash
msrtermux uninstall
```

This removes all dotfiles, cloned repositories, installed packages, and restores the default bash shell.

---

## License

See the [LICENSE](./LICENSE) file. Original project licensed under the terms set by xShin / myTermux.
