---
title: Configuration
description: How to customize Hyprland config, Quickshell settings, and fork-specific features
---

## Configuration layers

This fork has three layers of configuration:

1. **Upstream defaults** — `dots/.config/hypr/hyprland/` and `dots/.config/quickshell/ii/` (may be overwritten on update)
2. **Custom Hyprland config** — `dots/.config/hypr/custom/` (safe from upstream updates)
3. **Runtime settings** — `~/.config/quickshell/ii/config.json` (modified via Settings app or manually)

Always make your changes in the **custom** layer or via **runtime settings** to survive updates.

## Hyprland configuration (Lua)

Since the upstream Lua migration (PR #3269), all Hyprland config uses `.lua` files with the `hl.*` API.

### Custom config files

Located in `dots/.config/hypr/custom/` (live at `~/.config/hypr/custom/`):

| File | Purpose |
|------|---------|
| `keybinds.lua` | Your custom keybindings |
| `execs.lua` | Autostart applications |
| `env.lua` | Environment variables |
| `general.lua` | General Hyprland settings |
| `rules.lua` | Window and workspace rules |
| `variables.lua` | Custom variables |

### Lua API reference

```lua
-- Keybinds
hl.bind("SUPER", "W", hl.dsp.global("quickshell:panelFamilyCycle"),
  {description = "Cycle panel family"})
hl.bind("SUPER", "B", hl.dsp.exec_cmd("firefox"),
  {description = "Browser"})

-- Autostart (exec-once equivalent)
hl.on("hyprland.start", function()
    hl.exec_cmd("nohup ollama serve > /dev/null 2>&1 &")
end)

-- Run on every reload (exec equivalent)
hl.exec_cmd("some-command")

-- Environment variables
hl.env("EDITOR", "nvim")

-- Config sections
hl.config({
    general = { border_size = 2 },
    decoration = { rounding = 12 }
})

-- Window rules
hl.window_rule({
    rule = "opacity 0.89 override 0.89 override",
    match = "class:.*"
})

-- Monitor config
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "1"
})
```

### Example: adding a keybind

Edit `~/.config/hypr/custom/keybinds.lua`:
```lua
hl.bind("SUPER + SHIFT", "F", hl.dsp.exec_cmd("firefox --private-window"),
  {description = "Private browser"})
```

## Quickshell / Shell settings

### Settings app

Open with `Super + I` or:
```bash
qs -p ~/.config/quickshell/ii/settings.qml
```

Configurable options include:
- Bar appearance (position, style, widgets, screen list)
- Colors and transparency
- Font settings
- AI model configuration
- Widget settings

### Manual config editing

The Quickshell config lives at `~/.config/quickshell/ii/config.json`. Key sections:

```json
{
  "panelFamily": "ii",
  "bar": {
    "position": "top",
    "screenList": []
  },
  "ai": {
    "model": "gemini",
    "provider": "ollama"
  }
}
```

:::caution
Edit `config.json` while Quickshell is **not** running, or use the Settings app which handles persistence correctly. Direct edits while running may be overwritten.
:::

## Custom additions (dots/custom/)

The `dots/custom/` directory contains shell scripts that run during `./setup install`:

| File | Function | Purpose |
|------|----------|---------|
| `packages.sh` | `custom_packages()` | Extra packages to install |
| `files.sh` | `custom_files()` | Extra files to copy to \$HOME |
| `commands.sh` | `custom_commands()` | Arbitrary shell commands |
| `misc.sh` | `custom_misc()` | Symlinks, env vars, etc. |

### Adding packages

Edit `dots/custom/packages.sh`:
```bash
custom_packages() {
    firefox
    vlc
    obs-studio
}
```

### Copying config files

1. Place files in `dots/custom/files/.config/...`
2. Edit `dots/custom/files.sh`:
```bash
custom_files() {
    rsync_dir "dots/custom/files" "$HOME"
}
```

## AI prompt customization

AI assistant prompts are in `dots/.config/quickshell/ii/defaults/ai/prompts/`:

| Prompt | Personality |
|--------|------------|
| `ii-Default.md` | Helpful assistant with casual tone |
| `ii-Imouto.md` | Japanese imouto personality |
| `nyarch-Acchan.md` | Nyarch Linux personality |
| `w-FourPointedSparkle.md` | Waffle panel personality |
| `NoPrompt.md` | Raw model behavior |

Available template variables: `{DISTRO}`, `{DE}`, `{DATETIME}`, `{WINDOWCLASS}`.

## Color scheme

Colors are auto-generated from your wallpaper using matugen (Material Design 3):

```bash
# Regenerate colors manually
~/.config/quickshell/ii/scripts/colors/switchwall.sh /path/to/wallpaper
```

The color system uses 5 elevation layers (0–4) with transparency auto-calculated from wallpaper vibrancy. Override in `Appearance.qml` for development.

## Miscellaneous

### Cloudflare WARP

WARP can help bypass ISP restrictions and provide faster internet. A toggle button is available in the right sidebar.

**Setup:**

1. Install the package:
   ```bash
   yay -S cloudflare-warp-bin
   ```
2. Enable and start the service:
   ```bash
   sudo systemctl enable warp-svc
   sudo systemctl start warp-svc
   ```
3. Register your device:
   ```bash
   warp-cli registration new
   # Accept the ToS when prompted
   ```
4. Test the connection:
   ```bash
   warp-cli connect
   warp-cli disconnect
   # Both should output "Success"
   ```
5. Verify the sidebar toggle works:
   ```bash
   warp-cli status
   # Shows "Connected" or "Disconnected"
   ```

You can verify externally at [1.1.1.1 Connection Information](https://1.1.1.1/help).

**Optional:** Configure the operating mode:
```bash
warp-cli mode warp+dot  # WARP tunnel + DNS-over-TLS
# See: warp-cli mode --help
```

### UI scaling

#### Scale everything (monitors)

Edit `~/.config/hypr/custom/general.lua` following the [Hyprland Monitors guide](https://wiki.hypr.land/Configuring/Basics/Monitors/), or use `nwg-look` (install separately) for a GUI.

#### Scale the shell only

Two methods:

**Method 1: Quickshell pragma** (shell-only, not update-friendly)

Edit `~/.config/quickshell/ii/shell.qml` and uncomment/adjust:
```
//@ pragma Env QT_SCALE_FACTOR=1
```
Restart Quickshell with `Ctrl + Super + R`.

**Method 2: Hyprland env var** (affects all Qt apps, update-friendly)

Edit `~/.config/hypr/custom/env.lua`:
```lua
hl.env("QT_SCALE_FACTOR", "1.5")
```
Requires re-login to apply.

:::tip
Use Method 1 first to find your preferred scale factor, then apply it via Method 2 to avoid re-logging multiple times.
:::

### Font size

#### GTK apps

Use `gnome-tweaks` for a GUI, or:
```bash
# Syntax
gsettings set org.gnome.desktop.interface font-name 'FONT_NAME FONT_SIZE'

# Default for these dotfiles
gsettings set org.gnome.desktop.interface font-name 'Rubik 11'
```

#### Qt apps

Use the KDE System Settings app to customize fonts.

### Screen lock & timeout

#### Timeout configuration

Edit `~/.config/hypr/hypridle.conf` to adjust idle timeouts. See the [Hyprland hypridle docs](https://wiki.hypr.land/Hypr-Ecosystem/hypridle/) for reference.

#### Using an alternative lock screen

Example with `swaylock` (see [Arch Wiki: Session lock](https://wiki.archlinux.org/title/Session_lock)):

1. Edit `~/.config/hypr/hypridle.conf`:
   ```conf
   $lock_cmd = swaylock
   ```
2. Restart hypridle:
   ```bash
   pkill hypridle; hypridle & disown
   ```

Now `loginctl lock-session` will use your chosen lock screen.

### VSCode color theming

Colors from your wallpaper can be applied to VSCode:

1. Install the [Material Code](https://marketplace.visualstudio.com/items?itemName=rakib13332.material-code) extension
2. Select a wallpaper — colors are applied automatically
3. Optional: Change the `material-code.syntaxTheme` setting
4. Run the command `Material Code: Apply styles` to inject rounded corners

:::note
If VSCode reports a "corrupt installation", safely select "Don't show again". The color script lives at `dots/.config/quickshell/ii/scripts/colors/code/material-code-set-color.sh`.
:::
