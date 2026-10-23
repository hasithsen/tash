#!/usr/bin/env bash
# Install tash + Fn-key hotkeys on Debian minimal (no desktop environment).
# Dell Latitude 5480 and similar: loads dell_wmi, fixes logind brightness grab.
# Run as root:  sudo ./contrib/debian-minimal/install.sh

set -euo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Run as root: sudo $0" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
TARGET_USER="${SUDO_USER:-${USER}}"

echo "==> installing packages (alsa + python3 for evdev hotkeys)"
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y --no-install-recommends alsa-utils python3

if apt-cache show triggerhappy >/dev/null 2>&1; then
  apt-get install -y --no-install-recommends triggerhappy || true
fi

echo "==> installing binaries to /usr/local/bin"
install -m 0755 "$REPO_DIR/tash" /usr/local/bin/tash
install -m 0755 "$REPO_DIR/tash-ctl" /usr/local/bin/tash-ctl
install -m 0755 "$REPO_DIR/tash-hotkeys" /usr/local/bin/tash-hotkeys

echo "==> udev: backlight (video group) + Dell WMI input"
install -m 0644 "$SCRIPT_DIR/99-tash-backlight.rules" /etc/udev/rules.d/99-tash-backlight.rules
install -m 0644 "$SCRIPT_DIR/61-tash-input.rules" /etc/udev/rules.d/61-tash-input.rules
udevadm control --reload-rules
udevadm trigger --subsystem-match=backlight 2>/dev/null || true
udevadm trigger --subsystem-match=input 2>/dev/null || true

echo "==> Dell modules (Latitude Fn keys / WMI hotkeys)"
install -d -m 0755 /etc/modules-load.d
install -m 0644 "$SCRIPT_DIR/tash-dell.conf" /etc/modules-load.d/tash-dell.conf
modprobe dell_wmi 2>/dev/null || true
modprobe dell_laptop 2>/dev/null || true

echo "==> logind: do not swallow brightness keys on a bare TTY"
install -d -m 0755 /etc/systemd/logind.conf.d
install -m 0644 "$SCRIPT_DIR/logind-tash.conf" /etc/systemd/logind.conf.d/tash.conf
systemctl restart systemd-logind.service 2>/dev/null || true

echo "==> groups: video, input, audio for $TARGET_USER"
usermod -aG video,input,audio "$TARGET_USER"

echo "==> systemd service for Fn keys"
install -d -m 0755 /etc/systemd/system
install -m 0644 "$SCRIPT_DIR/tash-hotkeys.service" /etc/systemd/system/tash-hotkeys.service
systemctl daemon-reload
systemctl enable --now tash-hotkeys.service

if [[ -d /etc/triggerhappy/triggers.d ]] && [[ -f "$SCRIPT_DIR/triggerhappy-tash.conf" ]]; then
  echo "==> triggerhappy config (optional)"
  install -m 0644 "$SCRIPT_DIR/triggerhappy-tash.conf" /etc/triggerhappy/triggers.d/tash.conf
  systemctl enable --now triggerhappy.service 2>/dev/null || true
fi

if command -v amixer >/dev/null 2>&1; then
  amixer -q sset Master 50% unmute 2>/dev/null || true
  amixer -q sset PCM 50% unmute 2>/dev/null || true
fi

cat <<EOF

Done — Fn keys wired for bare Debian (incl. Dell Latitude).

  sudo systemctl status tash-hotkeys
  tash-ctl brightness up          # works without Fn?
  sudo tash-hotkeys --test        # press Fn+F5/F6 / volume; note codes

Latitude 5480 BIOS:
  System Configuration → Function Key Behavior
  Try "Function Key" vs "Multimedia Key", or toggle Fn-lock (Fn+Esc).

If --test shows a code that is not brightness/volume yet:
  sudo systemctl edit tash-hotkeys
  # [Service]
  # Environment=TASH_EXTRA_KEYS=CODE:brightness:up,CODE2:brightness:down
  sudo systemctl restart tash-hotkeys

Log out/in (or reboot) so group membership applies to your TTY.

EOF
