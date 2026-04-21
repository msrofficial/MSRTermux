# Changelog

All notable changes to MSRTermux are documented in this file.

Version codes follow **MAJOR.MINOR.PATCH** format:
- **MAJOR** — complete overhaul or breaking structural change
- **MINOR** — new feature or significant improvement
- **PATCH** — bug fix or small tweak

---

## [v2.5.2] - 2026-04-21 — Alignment & Color Fix

### Fixed
- **`helper/package.sh`**, **`helper/dotfiles.sh`**, **`helper/clone.sh`**, **`helper/themes.sh`**, **`helper/finish.sh`** — Box alignment corrected across all installer sections. Added `│` prefix to every item row and blank `│` padding lines after the header and before `└──`. Previously items were indented without `│`, breaking the visual box structure.
- **`.scripts/zsh/changetheme.sh`**, **`.scripts/colorscheme/colors.sh`**, **`.scripts/fonts/fonts.sh`** — Same box alignment fix applied. Banner repositioned above the box so `┌─` title is always the first box element.
- **All list rows** — `No.` column now uses `%-4s` fixed width so numbers and names align cleanly.

### Changed
- **Primary text color** changed from `\e[97m` (bright white) to `\e[96m` (cyan) for item names across all sections. Gives the UI a distinct, vivid appearance that contrasts well against the nekonako-djancoeg dark background without clashing with theme colors.

---

## [v2.5.1] - 2026-04-21 — Bug Fix

### Fixed
- **`.scripts/zsh/changetheme.sh`** — `sed` regex for reading the current ZSH theme was double-escaped during the v2.5.0 UI rewrite, causing `GET_ZSH_THEME_USED` to return empty. Restored the correct single-escape form: `sed 's/.\{10\}  /'`.

### Changed
- **`uninstall.sh`** — Removed all emoji characters from output messages for consistency with the rest of the codebase.

---

## [v2.5.0] - 2026-04-21 — UI Overhaul

### Changed
- **`helper/banner.sh`** — `Termux` word added inline after the MSR block-letter ASCII art on the first row. Tagline changed to `Your Termux, beautifully configured.` Info box redesigned using `┌─ / └─` style with `·` as separator and brighter value colors.
- **`helper/package.sh`** — Section headers now use `┌─ Title / └──` box style. Item names use bright white (`\e[97m`), values use light gray (`\e[37m`). Dark gray color usage removed.
- **`helper/dotfiles.sh`** — Same `┌─ / └──` box style applied. Items use `│` prefix consistently.
- **`helper/clone.sh`** — Same box style. Repository names in bright white, sizes in light gray.
- **`helper/themes.sh`** — Same box style. Theme names in bright white.
- **`helper/finish.sh`** — Completion screen redesigned with a `┌─ Done` box. Clean two-line hint block inside.
- **`.scripts/zsh/changetheme.sh`** — Banner unified with main MSR ASCII style. Theme list redesigned with numbered rows and `● active` indicator for the current theme. Input prompt simplified.
- **`.scripts/colorscheme/colors.sh`** — Same banner and list style. `● active` indicator for the current color scheme.
- **`.scripts/fonts/fonts.sh`** — Same banner and list style. `● active` indicator for the current font.
- All scripts — Unnecessary inline comments removed throughout.
- Color palette standardized: bright white (`\e[97m`) for primary text, light gray (`\e[37m`) for secondary values, dark gray (`\e[90m`) for structural box elements only. Blue (`\e[94m`) reserved for the GitHub handle in the banner only.

---

## [v2.4.0] - 2026-04-21 — Extra Keys & Auto Install

### Changed
- **`.termux/termux.properties`** — Extra key rows redesigned for maximum daily usability.
  - Row 1: `DRAWER`, `ESC`, `CTRL`, `ALT`, `HOME`, `UP`, `END`, `-`
  - Row 2: `{}`, `()`, `[]`, `$`, `LEFT`, `DOWN`, `RIGHT`, `/`
  - `DRAWER` opens the Termux session side panel for switching and creating sessions.
  - Added `-` (hyphen/dash) — essential for command flags and was previously unreachable without the symbol layer.
  - Added `/` (forward slash) — critical for paths and regex.
  - Removed `F1`, `TAB`, `DELETE`, and `BACKSLASH` from the visible rows.
- **`install.sh`** — Removed all Y/n confirmation prompts. Installation now runs fully automatically from start to finish without any user interaction required.
- **`helper/switchcase.sh`** — `switchCase` function removed from the installer flow entirely.

---

## [v2.3.1] - 2026-04-18 — Screen Check & Prompt Fix

### Fixed
- **`.scripts/library/screen.sh`** — Completely removed the `COLUMNS/LINES` screen size check. Installation now proceeds on any terminal size without prompting the user to zoom out.
- **`.scripts/library/switchcase.sh`** — Escape codes were rendering as literal text in `read -p` prompts (e.g. `\e[90m[Y/n]\e[0m`). Fixed by replacing `read -p` with `printf` followed by `read`.

### Changed
- **`helper/banner.sh`** — Added an info box below the MSR ASCII art displaying Author, GitHub handle, and Version.
- **`helper/animation.sh`** — Replaced the colored dot spinner with a clean braille spinner (`⣾⣽⣻⢿⡿⣟⣯⣷`). Status output now uses `✓` (green) for success and `✗` (red) for failure.

---

## [v2.3.0] - 2026-04-18 — Full UI Redesign

### Changed
- **`helper/banner.sh`** — New MSR block-letter ASCII art with WiFuX-style gradient coloring (green → cyan → blue). Plain `Termux Dotfiles` label below.
- **`helper/package.sh`** — Replaced the original heavy box UI with a clean column table showing Name, Version, Download Size, and Installed Size. Removed `bc` dependency entirely (no more `bc: command not found` error on Termux).
- **`helper/dotfiles.sh`** — Compact table UI. Fixed timestamp bug — `date` is now called only once per backup operation instead of twice, preventing mismatched backup filenames.
- **`helper/clone.sh`** — Minimal repository list UI showing repo name and size in MB.
- **`helper/themes.sh`** — Compact theme list with file size column.
- **`helper/finish.sh`** — Clean completion message with `msrtermux help` hint, Termux notification, and toast popup.
- **`helper/switchcase.sh`** — Simplified to a minimal `› Action? [Y/n]` prompt style.
- **`helper/stat.sh`** — Switched to icon-based output: `✓` success, `!` warning, `✗` error. Removed old bracket-style formatting.

### Removed
- **`export COLUMNS LINES`** — Removed from `.autostart`. ZSH handles terminal dimensions natively; this line was causing a screen-size prompt on startup in some Termux configurations.

---

## [v2.2.0] - 2026-04-18 — Autocomplete & CLI Tool

### Added
- **`zsh-autocomplete` plugin** — Displays a live history list on up/down arrow keys and shows folder suggestions after `cd`.
- **`helper/clone.sh`** — `zsh-autocomplete` added to the repository clone list.
- **`.zshrc`** — Up/down arrow key bindings (`\e[A` / `\e[B`) added for zsh-autocomplete history navigation.
- **`msrtermux` CLI command** — A dedicated command-line tool installed to `~/.local/bin/msrtermux`. Currently supports `msrtermux uninstall` to fully remove MSRTermux, and `msrtermux help` for usage info.
- **`helper/utility.sh`** — Added `chmod +x` for the `msrtermux` binary.
- **`uninstall.sh`** — Added `.tmux-themepack` and `.local/bin/msrtermux` to the list of files removed on uninstall.

---

## [v2.1.0] - 2026-04-18 — Permissions & Uninstaller

### Fixed
- **`.scripts/zsh/changetheme.sh`** — Permission denied error when running `chzsh`. Fixed by applying `chmod +x` to all scripts during install via `helper/utility.sh`. Same fix applied to: `colorscheme/colors.sh`, `fonts/fonts.sh`, `gitssh`, `ipconfig`, `macfinder`.

### Added
- **`uninstall.sh`** — New uninstall script. Fully removes all MSRTermux dotfiles, cloned repositories, installed packages, and restores the default bash shell. Run with `bash uninstall.sh`.

---

## [v2.0.0] - 2026-04-18 — Initial Fork (Bloat Removal)

This is the initial fork from [myTermux](https://github.com/xShin404/myTermux) by xShin. The goal was to strip myTermux down to a lean, functional setup by removing everything that is not essential to daily terminal use.

### Removed
- **`awesomeshot`** — Screenshot tool removed from the install package list. Unnecessary weight for a terminal-focused setup.
- **`imagemagick`** — Removed from packages; was only a dependency for awesomeshot.
- **`alias awesomeconf`** — Removed from `.aliases`. Pointed to the awesomeshot config file which no longer exists.
- **`alias listfont`** — Removed from `.aliases`. Used `magick convert`, no longer relevant without imagemagick.
- **`.local/bin/ytdl`** — YouTube downloader wrapper removed. Outdated `youtube-dl` syntax and not part of the core terminal workflow.
- **Music player stack** — `mpd`, `mpc`, `ncmpcpp` removed from package list. All related aliases, configs, and notify scripts removed.
- **System info displays** — `neofetch` removed from packages and `.aliases`. `rxfetch` binary removed from `.local/bin`. `fetch.sh` (battery/storage scripts) removed. `.config/neofetch` removed.
- **Login screen** — `.scripts/system/login.sh` and all related aliases removed.
- **Visual toys** — `.scripts/toys/` directory and all toy aliases removed from `.aliases`.
- **Compiled binaries** — `optional/compile/` directory removed (pre-compiled `ncmpcpp`, `nyancat`).
- **NvChad setup** — `helper/nvchad.sh` removed. NvChad clone step removed from installer. `optional/neovim-settings/` removed.
- **`repochecker.js`** — Node.js GitHub repo checker removed along with `install.sh` Node dependency setup and `alias repocek`.
- **Extra fonts** — Reduced from 8 font files to 1 (Fira Code Bold Nerd Font). All JetBrains Mono and MesloLGS variants removed.
- **Extra color schemes** — Reduced from 23 color scheme files to 1 (nekonako-djancoeg).
- **`lang-icons` placeholder files** — Empty placeholder files in `.lang-icons/` removed.
- **`fix/mpd/`** — MPD fix folder removed along with the music stack.
- **`alert/images/finish.png`** — Bundled notification image removed. Termux notification now runs without an image path.
- **`zsh-autocomplete`** — Initially excluded due to a 4–5 second ZSH startup delay.
- **`NvChad/starter`** clone entry removed from `helper/clone.sh`.
- **`tmux-themepack`** from `helper/clone.sh` — Still cloned during install but removed from package list bloat notes.

### Changed
- **Default ZSH theme** set to `ar-round`. `.zshrc` and `used.log` are now in sync on fresh install.
- **Color schemes** reduced to nekonako-djancoeg only as the default and only bundled scheme.
- **Fonts** reduced to Fira Code Bold Nerd Font only.
- **Package list** reduced from 18 packages to 11: `bat`, `curl`, `clang`, `eza`, `fzf`, `git`, `neovim`, `openssh`, `termux-api`, `tmux`, `zsh`.
- **`helper/clone.sh`** — NvChad and tmux-themepack (optional) entries replaced with lean plugin-only list: oh-my-zsh, zsh-syntax-highlighting, zsh-autosuggestions, zsh-fzf-history-search.
- **`helper/utility.sh`** — Removed `chsh -s zsh` call using the old path. Now uses `command -v zsh` for the correct Termux-compatible shell path.
- **`.autostart`** — Removed `rxfetch`, `export COLUMNS LINES`, and all commented-out tmux/login/SSH agent blocks. Cursor underline style (`\e[4 q`) retained.
- **`.aliases`** — All music, neofetch, rxfetch, toys, awesomeshot, nvim config, mpd/ncmpcpp config, ytdl, repocek, and neoscript aliases removed. Core navigation, eza, bat, fzf, git, tmux, and Termux:API aliases retained.
- **`install.sh`** — Removed `NvChad` and `utility` call from main function. Installer now runs: packages → dotfiles → repositories → zsh themes.
- **Project name** changed from `myTermux` to `MSRTermux`.
- **Banner** updated to reflect MSRTermux authorship.
- **Version** reset to `2.0.0` to mark the start of the MSRTermux fork.
