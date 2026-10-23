# tash

**T**erminal **A**wesome **S**ystem **H**UD

> The dashboard your `htop` refuses to be seen with in public.  
> Now with brightness and volume, because Debian minimal laughed at your Fn keys.

`tash` stares at your CPU, memory, swap, disk, backlight, and speakers until one of you blinks. Spoiler: it's usually you.

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## What it does

- Live system dashboard in the terminal
- Progress bars that turn yellow when you're in denial, red when you're in trouble
- **Clock**, **battery** %, **Wi‑Fi** (SSID + signal), ethernet, and online/offline
- **Brightness + volume** controls (sysfs backlight + ALSA / Pulse / PipeWire)
- In-dashboard keys *and* real **Fn / media keys** on a bare console (no desktop)

It will **not** install GNOME for you. That would defeat the point.

## Quick start

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

| Command | Purpose |
|---------|---------|
| `./tash` | Live HUD |
| `./tash --once` | One frame, then existential silence |
| `./tash-ctl status` | Brightness + volume readout |
| `./tash-ctl brightness up` | Squint less |
| `./tash-ctl volume down` | Neighbors rejoice |
| `./tash-hotkeys` | Grab Fn keys system-wide (needs `input` group) |

## Keyboard controls

### Inside `tash` (any terminal / TTY)

| Key | Action |
|-----|--------|
| `[` `]` | Brightness down / up |
| `-` `=` | Volume down / up |
| `m` | Mute toggle |
| `q` | Quit |

### Fn keys on Debian minimal (**no desktop**)

Laptop Fn keys do **not** magically work without a DE. There is no `gsd-power` fairy. They emit Linux input events (`KEY_BRIGHTNESSUP`, `KEY_VOLUMEUP`, …) on `/dev/input/event*`, and something has to listen.

That something is `tash-hotkeys` (or triggerhappy):

```bash
sudo ./contrib/debian-minimal/install.sh
# log out / back in (groups: video, input, audio)
```

What the installer does:

1. Puts `tash`, `tash-ctl`, `tash-hotkeys` in `/usr/local/bin`
2. Installs `alsa-utils` + `python3`
3. Adds a **udev rule** so group `video` can write backlight brightness
4. Adds you to `video`, `input`, `audio`
5. Enables `tash-hotkeys.service` so Fn keys work on the raw TTY

Test the pipeline:

```bash
tash-ctl brightness up
tash-ctl volume toggle
sudo tash-hotkeys --list          # see event devices
tash-hotkeys --test               # mash Fn brightness/volume; watch events
```

If `--test` shows nothing when you press Fn keys, your firmware is being mysterious — try `sudo evtest` and note which device actually fires.

## Manual controls (`tash-ctl`)

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

Backends, in order: **PipeWire (`wpctl`)** → **PulseAudio (`pactl`)** → **ALSA (`amixer`)**.

## Debian minimal cheat sheet

```bash
# deps if you skip the installer
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login, then:
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

Optional alternative daemon (no Python):

```bash
sudo apt-get install -y triggerhappy
sudo cp contrib/debian-minimal/triggerhappy-tash.conf \
  /etc/triggerhappy/triggers.d/tash.conf
sudo systemctl enable --now triggerhappy
```

## Requirements

- `bash` (we're not picky, but we have standards)
- Linux for brightness / Fn keys (macOS HUD still works; backlight hotkeys are a Linux plotline)
- Unicode block characters (`█` / `░`)
- For Fn keys: read access to `/dev/input/event*` + `python3` (or triggerhappy)

## Mood guide

| Mood | Meaning |
|------|---------|
| living its best life | Under 20% CPU, chill RAM — rare, treasure it |
| vibing | Normal. Don't look too hard. |
| mildly concerned | Something is cooking. Possibly you. |
| panicking quietly | Close tabs. Or buy RAM. Or both. |

## FAQ

**Why don't Fn keys work inside the `tash` process alone?**  
Because they never arrive on stdin. They show up on evdev. `tash-hotkeys` is the missing middleman your DE used to be.

**Brightness says permission denied**  
You're not in group `video`, or the udev rule isn't loaded. Re-run the installer / re-login.

**Volume does nothing**  
`sudo apt-get install -y alsa-utils` and check `alsamixer`. HDMI-only machines are a special kind of betrayal.

**Is this better than `htop`?**  
No. It changes your backlight though, which `htop` still refuses to do out of principle.

## License

MIT — do whatever you want, just don't blame us when the mood says *panicking quietly* and the speakers agree.

---

*Made for terminals. Judged by machines. Fn keys finally invited to the party.*
