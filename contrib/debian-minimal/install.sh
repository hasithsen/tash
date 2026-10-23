#!/usr/bin/env bash
# Install tash + Fn-key hotkeys on Debian minimal (no desktop environment).
# Run as root:  sudo ./contrib/debian-minimal/install.sh

set -euo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Run as root: sudo $0" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
TARGET_USER="${SUDO_USER:-${USER}}"
TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"

echo "==> installing packages (alsa + python3 for evdev hotkeys)"
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y --no-install-recommends alsa-utils python3

# Optional: triggerhappy as an alternative daemon (lightweight C)
if apt-cache show triggerhappy >/dev/null 2>&1; then
  apt-get install -y --no-install-recommends triggerhappy || true
fi

echo "==> installing binaries to /usr/local/bin"
install -m 0755 "$REPO_DIR/tash" /usr/local/bin/tash
install -m 0755 "$REPO_DIR/tash-ctl" /usr/local/bin/tash-ctl
install -m 0755 "$REPO_DIR/tash-hotkeys" /usr/local/bin/tash-hotkeys

echo "==> udev rule: allow 'video' group to set backlight"
install -m 0644 "$SCRIPT_DIR/99-tash-backlight.rules" /etc/udev/rules.d/99-tash-backlight.rules
udevadm control --reload-rules
udevadm trigger --subsystem-match=backlight 2>/dev/null || true

echo "==> adding $TARGET_USER to groups: video, input, audio"
usermod -aG video,input,audio "$TARGET_USER"

echo "==> systemd user service for Fn keys (lingering enabled)"
install -d -m 0755 /etc/systemd/system
install -m 0644 "$SCRIPT_DIR/tash-hotkeys.service" /etc/systemd/system/tash-hotkeys.service
# System service runs as the installing user so it works on TTY login without DE
sed -i "s/@USER@/$TARGET_USER/g" /etc/systemd/system/tash-hotkeys.service
systemctl daemon-reload
systemctl enable --now tash-hotkeys.service

if [[ -d /etc/triggerhappy/triggers.d ]] && [[ -f "$SCRIPT_DIR/triggerhappy-tash.conf" ]]; then
  echo "==> also installing triggerhappy config (optional parallel path)"
  install -m 0644 "$SCRIPT_DIR/triggerhappy-tash.conf" /etc/triggerhappy/triggers.d/tash.conf
  systemctl enable --now triggerhappy.service 2>/dev/null || true
fi

# Unmute + set a sane default if ALSA is present
if command -v amixer >/dev/null 2>&1; then
  amixer -q sset Master 50% unmute 2>/dev/null || true
  amixer -q sset PCM 50% unmute 2>/dev/null || true
fi

cat <<EOF

Done.

  Fn brightness / volume keys → tash-hotkeys.service → tash-ctl
  Dashboard                   → tash
  Manual control              → tash-ctl status|brightness|volume

IMPORTANT: log out and back in (or reboot) so group membership
(video, input, audio) applies to your TTY session.

Test without Fn keys:
  tash-ctl brightness up
  tash-ctl volume down
  tash-hotkeys --test    # press Fn brightness/volume, watch events

EOF
