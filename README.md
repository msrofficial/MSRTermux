# MSRTermux

A minimal, clean Termux dotfiles setup for Android. MSRTermux is a fork of [myTermux](https://github.com/xShin404/myTermux) by xShin, stripped down to the essentials — no bloat, no unused features, just a focused terminal environment that works.

---

## Credits

MSRTermux is based on the original work of **xShin** and the **myTermux** project.
Original repository: https://github.com/xShin404/myTermux

All core installer logic, helper scripts, and animation system are derived from myTermux. This fork exists solely to provide a leaner configuration without modifying the underlying architecture.

---

## What Changed from myTermux

- Single color theme (nekonako-djancoeg) instead of 23
- Single font (Fira Code Bold Nerd Font) instead of 8
- Default ZSH prompt set to archcraft theme; ma theme removed
- Music player stack removed (MPD, MPC, ncmpcpp)
- System info display removed (neofetch, rxfetch, disk, battery scripts)
- Login screen removed
- Visual toys removed (pipes, matrix rain, nyancat, etc.)
- Compiled binaries removed (optional/compile/bin)
- NvChad setup step removed from installer
- Alert notification no longer requires a bundled image
- lang-icons empty placeholder files removed
- repochecker.js and Node.js dependency removed

---

## What is Included

**Shell**
- ZSH with oh-my-zsh
- Prompt themes: archcraft, simple, rounded, rounded-custom, ar-round, la-round, osx, osx2
- Plugin: zsh-autosuggestions (grey inline suggestions, right arrow to accept)
- Plugin: zsh-syntax-highlighting (green for valid commands, red for invalid)
- Plugin: zsh-fzf-history-search (up arrow opens fuzzy history search)
- Plugin: zsh-autocomplete (tab dropdown completion)

**File Management**
- eza for directory listing with icons (ls, la, lt, lta aliases)
- bat for syntax-highlighted file viewing (cat alias)
- fzf with bat preview (preview alias)
- Quick navigation aliases for common sdcard folders

**Screenshot**
- awesomeshot via ImageMagick for styled terminal screenshots

**Editor**
- Neovim (bare install, no config bundled)

**Theme Switcher**
- chzsh to switch ZSH prompt theme interactively

**Multiplexer**
- tmux with tmux-themepack

---

## Requirements

- Termux (latest version from F-Droid recommended)
- Termux:API app installed alongside Termux
- Minimum terminal size: 101 columns x 39 rows (zoom out if installer complains)
- Internet connection during install

---

## Installation

```bash
git clone https://github.com/msrofficial/MSRTermux
cd MSRTermux
bash install.sh
```

Restart Termux after installation completes.

---

## Prompt Themes

Switch anytime with the `chzsh` command.

| Theme | Style |
|---|---|
| archcraft | Three colored dots (traffic light style), current directory |
| simple | Folder icon with path |
| rounded | Two-line rounded corner prompt |
| ar-round | Rounded with username |
| la-round | Rounded with git branch |
| osx | macOS terminal style, two lines |
| osx2 | macOS style without username |
| rounded-custom | Compact rounded with git info |

Default is **archcraft**.

---

## License

See LICENSE file. Original project licensed under the terms set by xShin/myTermux.
