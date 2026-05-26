---
title: Usage
description: Daily usage guide — keybinds, panel families, sidebars, and fork-specific features
---

## Keybinds

### Shell controls

| Keybind | Action |
|---------|--------|
| `Super` (tap) | Toggle app launcher / search |
| `Super + Tab` | Window overview with drag-and-drop |
| `Super + A` | Toggle left sidebar (AI chat, utilities) |
| `Super + N` | Toggle right sidebar (notifications, calendar) |
| `Super + V` | Clipboard history |
| `Super + .` | Emoji picker |
| `Super + Slash` | Cheatsheet (shows all keybinds) |
| `Super + K` | On-screen keyboard |
| `Super + M` | Media controls |
| `Super + G` | Widget overlay |
| `Super + J` | Toggle bar |
| `Ctrl + Super + P` | Cycle panel family (ii ↔ waffle) |

### Fork-specific keybinds

| Keybind | Action |
|---------|--------|
| `Super + W` | Cycle panel family |
| `Super + B` | Launch browser (tries Chrome, Zen, Firefox, Brave, etc.) |
| `Super + Space` | Launch Ollama Claude |
| `Ctrl + Super + S` | Toggle special workspace (scratchpad) |
| `Ctrl + Super + Slash` | Edit shell config (`config.json`) |
| `Ctrl + Super + Alt + Slash` | Edit custom keybinds (`keybinds.lua`) |
| `Fn + Q` (`XF86Launch4`) | Cycle power profile |

### Window management

| Keybind | Action |
|---------|--------|
| `Super + Q` | Close window |
| `Super + D` | Maximize |
| `Super + F` | Fullscreen |
| `Super + Alt + Space` | Toggle floating |
| `Super + P` | Pin window |
| `Super + Arrow keys` | Focus in direction |
| `Super + Shift + Arrow keys` | Move window in direction |
| `Super + 1-9` | Switch to workspace |
| `Super + Alt + 1-9` | Send window to workspace |
| `Super + S` | Toggle scratchpad |
| `Super + L` | Lock screen |

### Utilities

| Keybind | Action |
|---------|--------|
| `Super + Shift + S` | Region screenshot |
| `Super + Shift + A` | Google Lens (screen search) |
| `Super + Shift + X` | OCR to clipboard |
| `Super + Shift + C` | Color picker |
| `Super + Shift + R` | Record screen region |
| `Print` | Screenshot to clipboard |

## Panel families

The shell includes two panel families that can be cycled with `Ctrl + Super + P` or `Super + W`:

### ii (default)
The illogical-impulse style with a top bar, left/right sidebars, overview, and floating overlays.

### waffle
A Windows 11-inspired layout with a bottom taskbar, start menu, and action center. Currently a work-in-progress.

You can also switch via IPC:
```bash
qs -c ii ipc call panelFamily cycle
```

## System Settings

Launch the unified settings app:
```bash
# Full system settings (KDE/GNOME-style)
qs -p ~/.config/quickshell/ii/SystemSettings.qml

# Or use the keybind:
# Super + I
```

This app includes pages for Display, Audio, Network, Bluetooth, Keyboard, Mouse, Power, Date & Time, and Users — plus the original shell configurator tabs (Wallpaper Slideshow, YT Downloader, Quick Tools).

## Power profiles

Cycle with `Fn + Q` or via IPC:

```bash
# Cycle through profiles
qs ipc call powerProfile cycle

# Set directly
qs ipc call powerProfile set balanced
qs ipc call powerProfile set performance
qs ipc call powerProfile set power-saver
```

Requires `power-profiles-daemon` to be enabled.

## Wallpaper management

- `Ctrl + Super + T` — open wallpaper selector
- `Ctrl + Super + Alt + T` — random wallpaper

The Wallpaper Slideshow module can auto-rotate wallpapers on a timer. Configure it in Settings → Wallpaper Slideshow.

## AI integration

### Ollama
The fork auto-starts `ollama serve` on login. The AI chat sidebar (`Super + A`) connects to your local Ollama instance.

### Quick launch
`Super + Space` launches Ollama Claude with the minimax model.

## Left sidebar

Open with `Super + A`. Detach into a floating window with `Super + Alt + A`.

### AI chat

- Type `/model` to select a model. Locally installed Ollama models are detected automatically.
- Type `/key` for instructions on getting an API key for online models (Gemini, etc.)
- Gemini models with tools enabled can edit your shell config. For example, tell it "hide app icons on my workspaces" and it will modify the config directly.
- Markdown rendering and LaTeX math support are built in.

### Translator

Uses the `trans` command-line tool (from `translate-shell` package). Type text to translate between languages.

### Anime boorus

- Type `/mode` to see available image providers
- Type one or more tags to search. Suggestions appear as you type.
- Type a number to navigate pages of results

### Tab completion

In the Intelligence and Anime tabs, when suggestions appear above the typing area, use up/down arrow keys to select, then hit `Tab` to confirm.

## Screen translation

Translates on-screen content using Google Cloud Vision and Translation APIs.

**Keybind:** `Super + Shift + T`

### Prerequisites

- A Google Account
- A credit/debit card on file (Google requirement to prevent fraud — you won't be charged unless you activate a full account)

### Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com/) and create or select a project (can be the same project as your Gemini API key)
2. Enable these APIs:
   - [Cloud Vision API](https://console.cloud.google.com/marketplace/product/google/vision.googleapis.com)
   - [Cloud Translation API](https://console.cloud.google.com/marketplace/product/google/translate.googleapis.com)
3. From the left menu, go to **Billing** → Link a billing account
4. Go to **IAM & Admin** → **Service Accounts** → Create service account:
   - Step 1: Enter any name
   - Step 2: Add roles: `Service Usage Consumer` and `Cloud Translation API User` → Continue
   - Step 3: Press Done
5. Click the 3-dots menu on your service account → **Manage keys**
6. Click **Add key** → **Create new key** → Select JSON → **Create** (downloads a JSON file)
7. Open the screen translator with `Super + Shift + T`:
   - Click the **Key input** button at the bottom
   - Paste the JSON file contents → press Enter
8. Delete the downloaded JSON file (it's now stored securely in the keyring)

:::note
To view the stored key later, inspect the `illogical-impulse Safe Storage` keyring entry.
:::

## Workspace groups

If 10 workspaces aren't enough, you can use workspace groups. Over-scroll the workspace widget on the bar to switch to a new group (group 1 = workspaces 1-10, group 2 = 11-20, etc.).

### Navigation

Keybinds and shell widgets work seamlessly within the active group:

| Keybind | Action |
|---------|--------|
| `Super + 2` | Goes to workspace 12 if you're in group 2 (workspaces 11-20) |
| `Super + Alt + 3` | Moves window to workspace 23 if you're in group 3 |

To jump between groups, add these keybinds to `~/.config/hypr/custom/keybinds.lua`:

```lua
hl.bind("SUPER + ALT", "Z", hl.dsp.focus({ workspace = "r-10" }))
hl.bind("SUPER + ALT", "X", hl.dsp.focus({ workspace = "r+10" }))
```

:::tip
Use `~/.config/hypr/hyprland/scripts/workspace_action.sh` instead of `hyprctl dispatch` for workspace navigation — it automatically detects the current group and dispatches to the correct workspace.
:::

### Multi-monitor setup

To bind workspace groups to specific monitors:

```lua
-- In ~/.config/hypr/custom/general.lua

-- Bind workspaces 1-10 (group 1) to primary monitor
for i = 1, 10 do
  hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1", default = true })
end

-- Bind workspaces 11-20 (group 2) to secondary monitor
for i = 11, 20 do
  hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1", default = true })
end
```

Get your monitor names with `hyprctl monitors | grep Monitor`.

On startup, move the secondary monitor's starting workspace into the second group: `Super + 0`, then `Ctrl + Super + Right`.

:::note
Workspace groups are not natively supported by Hyprland — this config achieves it by tinkering with Hyprland dispatchers and the shell config.
:::

## Clipboard & emoji

- `Super + V` opens clipboard history (powered by `cliphist`)
- `Super + .` opens the emoji picker with fuzzy search
- Both work with Quickshell's native UI when available, falling back to `fuzzel` otherwise
