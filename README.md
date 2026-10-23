# tash

**T**erminal **A**wesome **S**ystem **H**UD

> You don't need a standing desk, a mechanical keyboard with a lore, or a second monitor that plays lo-fi rain.  
> You need a dashboard that looks you in the eye and says: *you're doing great, sweetie* — or, more often, *buy RAM*.

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## Why you will become slightly more awesome

People who run `tash` are not better humans. They just *look* like they know what their laptop is doing.

- Your friends open Activity Monitor. You open a teal wordmark and whisper **mood: vibing**.
- Battery % *and* estimated life — because “81%” without “2h left” is just vibes with a number.
- Wi‑Fi, ethernet, clock, load, memory — one screen, zero browser tabs titled `how to check cpu usage linux`.
- Brightness and volume from the HUD **and** real Fn keys on Debian minimal (no desktop, no mercy, no GNOME).
- Progress bars that turn amber when you're in denial and rose when the machine is filing a complaint.

Install it. Run it. Become the person who types `./tash` instead of rebooting “just to see.”

It will **not** fix your sleep schedule. It *will* tell you your swap is sad.

## Quick start (the awesome part)

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

That is the whole ritual. No account. No cloud. No “sync your metrics with our lifestyle brand.”

| Command | What a cooler you would say |
|---------|-----------------------------|
| `./tash` | “I'm observing the machine.” |
| `./tash --once` | “One frame. Pure cinema.” |
| `tash-ctl status` | “Brightness check. Volume check. Ego check.” |
| `tash-ctl brightness up` | “Let there be… slightly more light.” |
| `tash-ctl volume down` | “The neighbors can keep their lease.” |
| `tash-hotkeys` | “Fn keys, you work for *me* now.” |

## Keyboard controls

### Inside `tash` (any terminal / TTY)

| Key | Action | Aura boost |
|-----|--------|------------|
| `[` `]` | Brightness down / up | Squint professionally |
| `-` `=` | Volume down / up | DJ, but for system beeps |
| `m` | Mute toggle | Instant main-character silence |
| `q` | Quit | Walk away. Leave them wanting more. |

### Fn keys on Debian minimal (**no desktop**)

Laptop Fn keys do **not** magically work without a DE. There is no `gsd-power` fairy. They emit Linux input events (`KEY_BRIGHTNESSUP`, `KEY_VOLUMEUP`, …) on `/dev/input/event*`, and something has to listen.

That something is `tash-hotkeys` (or triggerhappy) — the missing middleman between your fingertips and greatness:

```bash
sudo ./contrib/debian-minimal/install.sh
# log out / back in (groups: video, input, audio)
```

What the installer does (quietly competent, like you after coffee):

1. Puts `tash`, `tash-ctl`, `tash-hotkeys` in `/usr/local/bin`
2. Installs `alsa-utils` + `python3`
3. Adds a **udev rule** so group `video` can write backlight brightness
4. Adds you to `video`, `input`, `audio`
5. Enables `tash-hotkeys.service` so Fn keys work on the raw TTY

Test the pipeline (feel the power):

```bash
tash-ctl brightness up
tash-ctl volume toggle
sudo tash-hotkeys --list          # see event devices
tash-hotkeys --test               # mash Fn brightness/volume; watch events
```

If `--test` shows nothing when you press Fn keys, your firmware is being mysterious — try `sudo evtest` and note which device actually fires. Awesome people debug; legends file it under “character development.”

## Manual controls (`tash-ctl`)

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

Backends, in order: **PipeWire (`wpctl`)** → **PulseAudio (`pactl`)** → **ALSA (`amixer`)**.  
Whichever shows up first gets to be part of your origin story.

## Debian minimal cheat sheet

```bash
# deps if you skip the installer
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login, then:
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

Optional alternative daemon (no Python — still awesome, just differently haunted):

```bash
sudo apt-get install -y triggerhappy
sudo cp contrib/debian-minimal/triggerhappy-tash.conf \
  /etc/triggerhappy/triggers.d/tash.conf
sudo systemctl enable --now triggerhappy
```

## Requirements

- `bash` (we're not picky, but we have standards)
- Linux for brightness / Fn keys (macOS HUD still works; backlight hotkeys are a Linux plotline)
- A terminal. That's it. Style auto-adapts:
  - **rich** (modern emulators): soft 256-color + `█`/`░` bars
  - **minimal** (`TERM=linux` / Debian tty): 16-color ANSI + high-contrast bars
  - **ascii**: `#`/`-` if UTF-8 is missing
- Override with `TASH_STYLE=rich|minimal|ascii` or `TASH_BASIC_COLOR=1`
- For Fn keys: read access to `/dev/input/event*` + `python3` (or triggerhappy)

### Bars look wrong on the raw console?

Debian minimal's Linux console often ignores 256-color codes. Older `━`/`─` bars then looked “flat.” Current `tash` auto-switches to **minimal** style on `TERM=linux`. Force it anytime:

```bash
TASH_STYLE=minimal ./tash
# or pure ASCII:
TASH_STYLE=ascii ./tash
```

## Mood guide (know thyself)

| Mood | Meaning | Your next move |
|------|---------|----------------|
| living its best life | Under 20% CPU, chill RAM | Screenshot it. This is rare art. |
| vibing | Normal load | Keep being mysterious. |
| mildly concerned | Something is cooking | Close that Electron app. You know the one. |
| panicking quietly | The machine has opinions | Close tabs. Buy RAM. Or both. Touch grass optional. |

## FAQ (frequently awesome questions)

**Will `tash` make me awesome?**  
Correlation is not causation, but have you *seen* those hairline section rules? Start the HUD. Fake it until the mood says *vibing*.

**Why don't Fn keys work inside the `tash` process alone?**  
Because they never arrive on stdin. They show up on evdev. `tash-hotkeys` is the missing middleman your DE used to be.

**Brightness says permission denied**  
You're not in group `video`, or the udev rule isn't loaded. Re-run the installer / re-login. Awesome is 10% aura, 90% udev.

**Volume does nothing**  
`sudo apt-get install -y alsa-utils` and check `alsamixer`. HDMI-only machines are a special kind of betrayal.

**Is this better than `htop`?**  
No. It changes your backlight though, which `htop` still refuses to do out of principle. Different sport. Same gym.

**Can I put this on my rice screenshot?**  
Yes. Please credit the teal. The teal worked hard.

## License

MIT — do whatever you want, just don't blame us when the mood says *panicking quietly* and the speakers agree.

---

*Made for terminals. Judged by machines. You, slightly more awesome, optional but encouraged.*
