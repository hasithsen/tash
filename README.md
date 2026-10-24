# tash

**T**erminal **A**wesome **S**ystem **H**UD

![tash screenshot](media/tash.png)

> Using `tash` makes you awesome.  
> Not because the bars are teal — though they are — but because you finally know what your laptop is doing.  
> Clarity looks like confidence. Confidence looks like awesome.  
> Start with `./tash`.

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## The idea

A bare laptop. Debian minimal. No desktop, no battery icon, Fn keys that do nothing — and you, opening five terminals to ask the same question five ways.

Then you run `tash`.

One screen. Mood, battery life, network, load, memory. Brightness and volume when you need them. On a console without a DE, Fn keys that actually work.

You refresh instead of rebooting.  
You look like you know.  
You *do* know. That is the awesome.

## What it shows

- **Mood** — a short read on the machine (`vibing` … `panicking quietly`)
- **Battery** — percent and time left (or time to full)
- **Clock, Wi‑Fi, ethernet, online / offline**
- **CPU, memory, swap, disk** — clear bars, honest colors
- **Brightness and volume** — keys in the HUD; Fn keys on bare Debian via `tash-hotkeys`

## Quick start

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

| Command | Purpose |
|---------|---------|
| `./tash` | Live HUD |
| `./tash --once` | Single frame |
| `tash-ctl status` | Brightness and volume |
| `tash-ctl brightness up` | Brighter |
| `tash-ctl volume down` | Quieter |
| `tash-hotkeys` | System-wide Fn keys |

## Keyboard

| Key | Action |
|-----|--------|
| `[` `]` | Brightness down / up |
| `-` `=` | Volume down / up |
| `m` | Mute |
| `q` | Quit |

### Fn keys on Debian minimal (no desktop)

Without a desktop, media keys only appear as events on `/dev/input/event*`. Something has to listen — that is `tash-hotkeys`:

```bash
sudo ./contrib/debian-minimal/install.sh
# log out and back in (groups: video, input, audio)
```

This installs the tools, `alsa-utils`, `python3`, a backlight udev rule, group membership, and `tash-hotkeys.service`.

```bash
tash-ctl brightness up
tash-hotkeys --test
```

If `--test` shows nothing, use `sudo evtest` to find which device fires.

## `tash-ctl`

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

Backends: **PipeWire** → **PulseAudio** → **ALSA**.

## Debian minimal (manual)

```bash
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

Or use triggerhappy instead of Python — see `contrib/debian-minimal/`.

## Requirements

- `bash`
- Linux for brightness and Fn keys (macOS: HUD works; backlight hotkeys are Linux-only)
- Auto style: **rich** · **minimal** (`TERM=linux`) · **ascii**  
  Override: `TASH_STYLE=minimal` or `TASH_BASIC_COLOR=1`
- Fn keys: `/dev/input/event*` and `python3` (or triggerhappy)

## Moods

| Mood | Meaning |
|------|---------|
| living its best life | Quiet machine — enjoy it |
| vibing | Normal |
| mildly concerned | Something is busy |
| panicking quietly | Ease the load |

## FAQ

**Does using `tash` make you awesome?**  
Yes. Knowing your machine is half the look; the teal is the other half.

**Why don’t Fn keys work inside `tash` alone?**  
They arrive on evdev, not stdin. Run `tash-hotkeys`.

**Brightness: permission denied?**  
Join group `video`, reload udev, log in again.

**No sound change?**  
Install `alsa-utils` and check `alsamixer`.

**Compared to `htop`?**  
`htop` lists processes. `tash` is the overview — battery, network, backlight, and the quiet sense that you have it in hand.

## License

MIT. Use it. Share it. Stay awesome.

---

*For terminals. For laptops. For people who run `./tash`.*
