#!/usr/bin/env bash
# Fix for qt6-wayland 6.11.0 xdg_popup SEGV crash
# This crash affects quickshell when tray icons (like Vesktop) trigger popup menus
#
# Error signature:
#   Signal: 11 (SEGV)
#   Stack trace shows: surfaceRole<xdg_popup> in libQt6WaylandClient.so.6
#
# Applies to: qt6-wayland 6.11.0 (regression), fixed in Qt 6.11.1+

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_qt6_wayland_version() {
    local current_version
    current_version=$(pacman -Q qt6-wayland 2>/dev/null | awk '{print $2}' || echo "not installed")
    echo "$current_version"
}

is_buggy_version() {
    local version="$1"
    # Check if version is 6.11.0 (the buggy one)
    [[ "$version" == "6.11.0-"* ]]
}

apply_fix() {
    info "Checking qt6-wayland version..."
    
    local current_version
    current_version=$(check_qt6_wayland_version)
    
    if [ "$current_version" = "not installed" ]; then
        error "qt6-wayland not installed"
        exit 1
    fi
    
    info "Current version: $current_version"
    
    if ! is_buggy_version "$current_version"; then
        info "qt6-wayland is not the buggy 6.11.0 version. No fix needed."
        exit 0
    fi
    
    warn "Detected buggy qt6-wayland 6.11.0!"
    info "Applying downgrade to 6.10.2..."
    
    # Check if cached package exists
    local cached_pkg="/var/cache/pacman/pkg/qt6-wayland-6.10.2-1-x86_64.pkg.tar.zst"
    
    if [ -f "$cached_pkg" ]; then
        info "Found cached package: $cached_pkg"
        sudo pacman -U "$cached_pkg" --noconfirm
    else
        warn "No cached package found. Downloading from Arch Linux Archive..."
        local url="https://archive.archlinux.org/packages/q/qt6-wayland/qt6-wayland-6.10.2-1-x86_64.pkg.tar.zst"
        
        if command -v curl &>/dev/null; then
            curl -L "$url" -o /tmp/qt6-wayland-6.10.2-1-x86_64.pkg.tar.zst
            sudo pacman -U /tmp/qt6-wayland-6.10.2-1-x86_64.pkg.tar.zst --noconfirm
            rm -f /tmp/qt6-wayland-6.10.2-1-x86_64.pkg.tar.zst
        else
            error "curl not found. Please install curl or download manually:"
            error "$url"
            exit 1
        fi
    fi
    
    info "Downgrade complete!"
}

prevent_upgrade() {
    info "Configuring pacman to hold qt6-wayland version..."
    
    if grep -q "^IgnorePkg.*qt6-wayland" /etc/pacman.conf 2>/dev/null; then
        info "qt6-wayland is already in IgnorePkg"
        return
    fi
    
    warn "Need to modify /etc/pacman.conf to prevent accidental upgrades"
    warn "This will add 'qt6-wayland' to IgnorePkg"
    
    if [ -w /etc/pacman.conf ]; then
        sudo sed -i 's/^#IgnorePkg   =/IgnorePkg   =\nqt6-wayland/' /etc/pacman.conf
        info "Added qt6-wayland to IgnorePkg"
    else
        error "Cannot modify /etc/pacman.conf automatically"
        info "Please run manually:"
        echo "  sudo sed -i 's/^#IgnorePkg   =/IgnorePkg   =\\nqt6-wayland/' /etc/pacman.conf"
    fi
}

show_status() {
    info "Current status:"
    echo ""
    echo "qt6-wayland version: $(check_qt6_wayland_version)"
    echo ""
    
    if grep -q "^IgnorePkg.*qt6-wayland" /etc/pacman.conf 2>/dev/null; then
        echo "Pacman hold: ENABLED (qt6-wayland in IgnorePkg)"
    else
        echo "Pacman hold: NOT ENABLED"
        warn "Run with --prevent-upgrade to add to IgnorePkg"
    fi
    echo ""
    
    if [ -f "/var/cache/pacman/pkg/qt6-wayland-6.10.2-1-x86_64.pkg.tar.zst" ]; then
        echo "Cached package: AVAILABLE"
    else
        echo "Cached package: NOT AVAILABLE"
    fi
}

show_help() {
    cat << 'EOF'
Usage: fix-qt6-wayland-crash.sh [OPTION]

Fix qt6-wayland 6.11.0 xdg_popup SEGV crash that affects quickshell tray menus.

Options:
  --apply           Apply the downgrade fix
  --prevent-upgrade Add qt6-wayland to pacman IgnorePkg
  --status          Show current version and hold status
  --fix-all         Apply fix AND prevent future upgrades (recommended)
  -h, --help        Show this help message

This script:
1. Downgrades qt6-wayland from buggy 6.11.0 to stable 6.10.2
2. Configures pacman to hold the package (prevents accidental upgrades)

The crash manifests as:
  - quickshell SEGV when minimizing apps to system tray (e.g., Vesktop)
  - Stack trace shows _ZN7QStringaSERKS_ in libQt6WaylandClient.so.6

EOF
}

case "${1:-}" in
    --apply)
        apply_fix
        ;;
    --prevent-upgrade)
        prevent_upgrade
        ;;
    --status)
        show_status
        ;;
    --fix-all)
        apply_fix
        prevent_upgrade
        info "All fixes applied!"
        ;;
    -h|--help|"")
        show_help
        ;;
    *)
        error "Unknown option: $1"
        show_help
        exit 1
        ;;
esac
