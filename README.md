# tash

**T**erminal **A**wesome **S**ystem **H**UD

> Somewhere, right now, a person is typing `htop` with two fingers like they’re defusing a bomb.  
> Somewhere else, a person runs `./tash`, watches the teal land, murmurs *vibing*, and dims the backlight with an Fn key on a Debian box that has never known GNOME.  
>
> Only one of these people is awesome.  
> We are not subtle about which one.

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## The pitch (said with a straight face)

`tash` is a live system HUD for people who want their laptop to confess.

Not a lifestyle. Not a morning routine.  
Just a terminal full of bars, a mood that roast-validates you, and the quiet confidence of knowing your battery has **2h 14m left** while everyone else is still opening Settings.

Run it once and you join the set of humans who:

- check **mood** the way normals check the weather  
- treat **Wi‑Fi / ethernet / clock / load** as one glance, not a scavenger hunt  
- read **battery life**, not just a lonely percentage doing improv  
- turn the panel up and the speakers down without leaving the HUD — and on bare metal Debian, with **actual Fn keys**  
- notice when the bars go amber (denial) or red (the silicon has retained counsel)

Your friends reboot “just to see.”  
You refresh. That’s the whole personality upgrade.

It will not fix your sleep schedule.  
It will tell you your swap is crying. Awesome people prefer the truth.

## Quick start

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

Cursor blinks. Screen clears. Teal wordmark.  
You now know things. This is widely considered a symptom of being awesome.

| Command | What happens |
|---------|----------------|
| `./tash` | Live HUD. Full awesome. |
| `./tash --once` | One frame. Pure cinema. |
| `tash-ctl status` | Brightness + volume readout |
| `tash-ctl brightness up` | Squint less |
| `tash-ctl volume down` | Neighbors keep their lease |
| `tash-hotkeys` | Fn keys report for duty |

## Keyboard controls

### Inside `tash` (any terminal / TTY)

| Key | Action |
|-----|--------|
| `[` `]` | Brightness down / up |
| `-` `=` | Volume down / up |
| `m` | Mute toggle |
| `q` | Quit (walk away still awesome) |

### Fn keys on Debian minimal (**no desktop**)

Laptop Fn keys do not magically work without a DE. There is no `gsd-power` fairy. They emit Linux input events on `/dev/input/event*`, and something has to listen.

That something is `tash-hotkeys` (or triggerhappy) — how awesome people get their backlight back:

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
sudo tash-hotkeys --list
tash-hotkeys --test          # mash Fn brightness/volume; watch events
```

If `--test` shows nothing, your firmware is being mysterious — try `sudo evtest` and note which device actually fires. Awesome people debug. Legends call it character development.

## Manual controls (`tash-ctl`)

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

Backends, in order: **PipeWire (`wpctl`)** → **PulseAudio (`pactl`)** → **ALSA (`amixer`)**.  
Whichever answers first gets a quiet nod of respect.

## Debian minimal cheat sheet

```bash
# deps if you skip the installer
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login, then:
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

Optional daemon without Python:

```bash
sudo apt-get install -y triggerhappy
sudo cp contrib/debian-minimal/triggerhappy-tash.conf \
  /etc/triggerhappy/triggers.d/tash.conf
sudo systemctl enable --now triggerhappy
```

## Requirements

- `bash` (we’re not picky, but we have standards)
- Linux for brightness / Fn keys (macOS HUD still works; backlight hotkeys are a Linux subplot)
- A terminal — style auto-adapts so awesome survives ugly hardware:
  - **rich** — soft 256-color, calm chrome, `█`/`░` bars
  - **minimal** — Debian tty / `TERM=linux`: bold 16-color, no vanishing gray, bars you can actually see
  - **ascii** — `#`/`-` if UTF-8 ghosted you
- Override: `TASH_STYLE=rich|minimal|ascii` or `TASH_BASIC_COLOR=1`
- For Fn keys: read access to `/dev/input/event*` + `python3` (or triggerhappy)

### Hard to read on the raw console?

Bright-black text on a Linux VGA console is how hope dies.  
`tash` notices `TERM=linux` and switches to **minimal** style — bold cyan labels, white values, high-contrast bars.

```bash
TASH_STYLE=minimal ./tash
TASH_STYLE=ascii ./tash
```

## Mood guide

| Mood | Meaning | Next move |
|------|---------|-----------|
| living its best life | Under 20% CPU, chill RAM | Screenshot it. Rare art. |
| vibing | Normal | Stay mysterious. |
| mildly concerned | Something is cooking | Close that Electron app. You know the one. |
| panicking quietly | The machine has opinions | Close tabs. Buy RAM. Touch grass optional. |

## FAQ

**Does using `tash` make you awesome?**  
Yes. Next question.

**Why don’t Fn keys work inside the `tash` process alone?**  
They never arrive on stdin. They show up on evdev. `tash-hotkeys` is the missing middleman your DE used to be.

**Brightness says permission denied**  
You’re not in group `video`, or the udev rule isn’t loaded. Re-run the installer / re-login. Awesome is 10% aura, 90% udev.

**Volume does nothing**  
`sudo apt-get install -y alsa-utils` and check `alsamixer`. HDMI-only machines are a special kind of betrayal.

**Is this better than `htop`?**  
Different sport. `htop` counts processes. `tash` changes your backlight and tells you how the night is going.

**Can this be in my rice screenshot?**  
Yes. Credit the teal. The teal worked hard.

## License

MIT — do whatever you want, just don’t blame us when the mood says *panicking quietly* and the speakers agree.

---

*Made for terminals. Judged by machines. Used by the awesome — which is to say, by people who ran `./tash`.*
