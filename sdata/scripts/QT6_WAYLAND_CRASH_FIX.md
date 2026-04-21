# Qt6 Wayland xdg_popup Crash Fix

## Problem

qt6-wayland 6.11.0 has a regression causing **SEGV crashes** in quickshell when:
- Applications minimize to system tray (e.g., Vesktop)
- System tray popup menus are triggered
- The crash occurs in `libQt6WaylandClient.so.6` at `surfaceRole<xdg_popup>`

## Stack Trace Signature

```
Signal: 11 (SEGV)
Stack trace:
#0 _ZN7QStringaSERKS_ (libQt6Core.so.6)
#1 _ZNK16QNativeInterface7Private14QWaylandWindow11surfaceRoleI9xdg_popupEEPT_v
#2 _ZN15ProxyWindowBase9onExposedEv
... Qt6WaylandClient code ...
```

## Root Cause

Qt6 Wayland 6.11.0 introduced a bug where xdg_popup surface handling causes a dangling
QString pointer during window expose events. This was fixed in Qt 6.11.1+.

## Solutions

### Option 1: Permanent Downgrade (Recommended)

Run the fix script:

```bash
# From repo root:
./sdata/scripts/fix-qt6-wayland-crash.sh --fix-all

# Or manually:
sudo sed -i 's/^#IgnorePkg   =/IgnorePkg   =\nqt6-wayland/' /etc/pacman.conf
sudo pacman -U /var/cache/pacman/pkg/qt6-wayland-6.10.2-1-x86_64.pkg.tar.zst --noconfirm
```

### Option 2: Temporary Workaround

Disable system tray menus in quickshell config:

```qml
// ~/.config/quickshell/ii/modules/common/Config.qml
tray: JsonObject {
    property bool showMenu: false  // Disables right-click menus
}
```

### Option 3: Wait for Fix

Upgrade to Qt 6.11.1+ when available:

```bash
# Remove hold, upgrade, test
sudo sed -i '/^qt6-wayland$/d' /etc/pacman.conf
sudo pacman -S qt6-wayland
```

## Checking Status

```bash
./sdata/scripts/fix-qt6-wayland-crash.sh --status
```

## Files Modified by Fix

1. `/etc/pacman.conf` - Added `qt6-wayland` to `IgnorePkg`
2. System package: `qt6-wayland` downgraded to 6.10.2-1

## When to Apply

- **Immediately after**: Installing or updating to qt6-wayland 6.11.0
- **On system update**: If quickshell crashes after `pacman -Syu`
- **New install**: Before running `./setup install`

## Related Issues

- Vesktop minimize-to-tray triggers crash
- Any app that creates tray popups (network, clipboard, etc.)
- Not configuration-related - pure Qt6 Wayland bug

## See Also

- Qt Bug Reports: https://bugreports.qt.io
- Arch Linux Archive: https://archive.archlinux.org/packages/q/qt6-wayland/
- CLAUDE.md "Troubleshooting" section
