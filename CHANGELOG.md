# Changelog

All notable changes to MSRTermux will be documented in this file.

---

## [v2.3.1] - 2026-04-18

### Fixed
- `screen.sh` — Completely removed the `COLUMNS/LINES` check. It will now install on any terminal without checking the screen size.
- `switchcase.sh` — Escape codes were not rendering in `read -p` (it was showing `\e[90m[Y/n]\e[0m` literally). Replaced it with `printf`.

### Changed
- **`banner.sh`** — Added an info box below the MSR ASCII: Author, GitHub, Version.
- **`animation.sh`** — Replaced the colored dot animation with a clean braille spinner (`⣾⣽⣻⢿⡿⣟⣯⣷`). Results are now shown with ✓/✗.

---

## [v2.3.0] - 2026-04-18

### Changed — Full UI Redesign
- **`banner.sh`** — New MSR ASCII art (WiFuX-style gradient color), plain text `Termux` below it, and a compact version/author line.
- **`package.sh`** — Replaced the old heavy box UI with a clean column table. Removed the `bc` dependency (the `bc: command not found` error will no longer appear).
- **`dotfiles.sh`** — Compact table UI. Fixed the timestamp bug (`date` is now called only once).
- **`clone.sh`** — Clean minimal repo list UI.
- **`themes.sh`** — Compact theme list UI.
- **`finish.sh`** — Nice completion message, added an `msrtermux help` hint.
- **`switchcase.sh`** — Minimal `› Action? [Y/n]` prompt.
- **`stat.sh`** — `✓ / ! / ✗` icon-based output, removed the old bracket style.

### Removed
- `export COLUMNS LINES` — Removed from `.autostart`. ZSH handles this natively, so manual exporting is no longer needed.

---

## [v2.2.0] - 2026-04-18

### Added
- `zsh-autocomplete` plugin — Shows history list using the up/down arrows, displays folder suggestions after `cd`.
- Added `zsh-autocomplete` to the repo clone list (`helper/clone.sh`).
- Added up/down arrow keybindings (`\e[A` / `\e[B`) in `.zshrc`.
- `msrtermux` command — Running `msrtermux uninstall` from the terminal will completely uninstall MSRTermux.
- Added `chmod +x` for `msrtermux` in `utility.sh`.
- Added `.tmux-themepack` and `.local/bin/msrtermux` to `uninstall.sh`.

---

## [v2.1.0] - 2026-04-18

### Fixed
- `chzsh` (changetheme.sh) permission denied error — `chmod +x` now applied to all scripts during install via `utility.sh`
- Execute permissions also fixed for: `colorscheme/colors.sh`, `fonts/fonts.sh`, `gitssh`, `ipconfig`, `macfinder`

### Added
- `uninstall.sh` — fully removes all MSRTermux dotfiles, scripts, installed packages, and restores default bash shell. Run with: `bash uninstall.sh`

---

## [v2.0.0] - 2026-04-18

### Removed
- `awesomeshot` package removed from install list — screenshot tool was unnecessary and added extra weight
- `imagemagick` package removed from install list — was only used as a dependency for awesomeshot
- `alias awesomeconf` removed from `.aliases` — pointed to awesomeshot config, no longer needed
- `alias listfont` removed from `.aliases` — used imagemagick's `magick convert`, no longer relevant
- `.local/bin/ytdl` script removed — YouTube downloader (youtube-dl wrapper) was outdated and unnecessary

### Changed
- Default ZSH theme set to `ar-round` — `.zshrc` already had it, `used.log` updated to match