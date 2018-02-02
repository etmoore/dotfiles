# Configuring Remote Copy and Paste Over SSH

source for most of these instructions: https://gist.github.com/burke/5960455

Assumptions:  
* Mac local, Linux remote

Note:  
* On dev35, I'm using ports 2235 (copy) and 2236 (paste) to avoid potential conflicts on
  shared dev boxes.

## Local (OS X) Side

#### `~/Library/LaunchAgents/pbcopy.plist`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Label</key>
<string>localhost.pbcopy</string>
<key>ProgramArguments</key>
<array>
<string>/usr/bin/pbcopy</string>
</array>
<key>inetdCompatibility</key>
<dict>
<key>Wait</key>
<false/>
</dict>
<key>Sockets</key>
<dict>
<key>Listeners</key>
<dict>
<key>SockServiceName</key>
<string>2224</string>
<key>SockNodeName</key>
<string>127.0.0.1</string>
</dict>
</dict>
</dict>
</plist>
```

#### `~/Library/LaunchAgents/pbpaste.plist`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Label</key>
<string>localhost.pbpaste</string>
<key>ProgramArguments</key>
<array>
<string>/usr/bin/pbpaste</string>
</array>
<key>inetdCompatibility</key>
<dict>
<key>Wait</key>
<false/>
</dict>
<key>Sockets</key>
<dict>
<key>Listeners</key>
<dict>
<key>SockServiceName</key>
<string>2225</string>
<key>SockNodeName</key>
<string>127.0.0.1</string>
</dict>
</dict>
</dict>
</plist>
```

#### `~/.ssh/config`
```
Host myhost
HostName 192.168.1.123
User myname
RemoteForward 2224 127.0.0.1:2224
RemoteForward 2225 127.0.0.1:2225
```

**After adding the PLists above, you'll have to run:**

```bash
launchctl load ~/Library/LaunchAgents/pbcopy.plist
launchctl load ~/Library/LaunchAgents/pbpaste.plist
```

## Remote (Linux) Side
#### `~/bin/pbpaste`
```bash
#!/bin/sh
nc localhost 2225
```

#### `~/bin/pbcopy`
```bash
#!/bin/sh
cat | nc -q1 localhost 2224
```

#### `~/.vimrc`
```
" Clipboard Configuration
if has('nvim')
    let g:clipboard = {
        \   'name': 'SSH_from_macOS',
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

## For TMUX (>2.4) and iTerm2 (>3.0)
settings -> general -> "Applications in terminal may access keyboard"
