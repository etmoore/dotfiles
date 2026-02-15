# How To Configure Remote Copy and Paste Over SSH

Uses [OSC 52](https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h3-Operating-System-Commands) terminal escape sequences to copy text from a remote machine to the local clipboard. No listeners, port forwarding, or LaunchAgents needed — the terminal emulator handles it natively.

Assumptions:
* Mac local running a terminal that supports OSC 52 (e.g. Ghostty, iTerm2, kitty)
* Linux remote with tmux

## Remote (Linux) Side

### `~/bin/pbcopy`
```sh
#!/bin/sh
# OSC 52 clipboard copy — sends text to the local clipboard via terminal
# escape sequence. Works with terminals that support OSC 52 (e.g. Ghostty).
# Requires tmux options: set-clipboard on, allow-passthrough on.

# Base64-encode stdin (OSC 52 payload must be base64-encoded)
data=$(base64 | tr -d '\n')

# When called from a subprocess without a controlling terminal (e.g. neovim),
# /dev/tty doesn't exist. Inside tmux, resolve the pane's actual PTY
# (e.g. /dev/pts/5) so the escape sequence reaches the terminal emulator.
tty=$(tmux display-message -p '#{pane_tty}' 2>/dev/null)

if [ -n "$tty" ]; then
    printf '\033]52;c;%s\a' "$data" > "$tty"
else
    # Fallback for non-tmux usage
    printf '\033]52;c;%s\a' "$data" > /dev/tty
fi
```

### `~/.tmux.conf`
```
# OSC 52 clipboard support
set -g set-clipboard on
set -g allow-passthrough on
```

### Neovim clipboard provider (`~/.vimrc` or equivalent)
```vim
if has('nvim')
    let g:clipboard = {
        \   'name': 'OSC52',
        \   'copy': {
        \      '+': 'pbcopy',
        \      '*': 'pbcopy',
        \    },
        \   'paste': {
        \      '+': 'pbpaste',
        \      '*': 'pbpaste',
        \   },
        \   'cache_enabled': 0,
        \ }
endif
```

## Local (Mac) Side

No configuration needed — OSC 52 support is built into Ghostty (and most modern terminals). Just make sure your terminal's OSC 52 clipboard access is enabled (it is by default in Ghostty).
