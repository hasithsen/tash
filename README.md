# tash

**T**erminal **A**wesome **S**ystem **H**UD

> Using `tash` makes you awesome.  
> This is not a metaphor. This is not a bit we will walk back later.  
> You type `./tash`, the teal arrives, your laptop confesses, and something in your posture improves.  
> Science has not studied this. Science is busy. We checked the mood line instead.

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## What happens when you become awesome

Somewhere, a person is double-clicking Task Manager like it owes them money.  
You run `tash`. The screen clears. Bars appear. The machine says *vibing*.

You now know:

- your **mood** (emotional support, but make it metrics)
- your **battery %** *and* how long until drama (`2h 14m left`)
- **Wi‑Fi**, ethernet, clock, load — one glance, zero scavenger hunt
- **CPU / RAM / swap / disk**, with bars that go amber in denial and red when the silicon retains counsel
- **brightness + volume** from the HUD, and on Debian minimal, from **real Fn keys** that finally clock in

Your friends reboot “just to see.”  
You refresh.  
That is the entire personality upgrade. Congratulations on your new continuous state of being awesome.

`tash` will not text your ex.  
`tash` will tell you your swap is crying. Awesome people prefer the truth.

## Quick start (onset of awesome)

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

Cursor blinks. Screen clears. Teal wordmark.  
Side effects may include knowing what your computer is doing.

| Command | Effect |
|---------|--------|
| `./tash` | Live HUD. Full awesome. |
| `./tash --once` | One frame. Hang it in a gallery. |
| `tash-ctl status` | Brightness + volume, spoken softly |
| `tash-ctl brightness up` | Let there be… slightly more light |
| `tash-ctl volume down` | The neighbors keep their lease |
| `tash-hotkeys` | Fn keys report for duty |

## Keyboard controls

### Inside `tash` (any terminal / TTY)

| Key | Action | Notes from the newly awesome |
|-----|--------|------------------------------|
| `[` `]` | Brightness down / up | Squint professionally |
| `-` `=` | Volume down / up | Conduct the beep orchestra |
| `m` | Mute | Instant main-character silence |
| `q` | Quit | Walk away. Remain awesome. |

### Fn keys on Debian minimal (**no desktop**)

You pressed Fn+F5. Nothing happened. Your soul packed a small bag.

That’s normal. Without a desktop there is no friendly daemon catching media keys. They show up as lonely events on `/dev/input/event*` until **`tash-hotkeys`** adopts them — which is how awesome people get their backlight back on a box that has never known GNOME:

```bash
sudo ./contrib/debian-minimal/install.sh
# log out / back in (groups: video, input, audio)
```

What the installer does (the unsexy chapter of your glow-up):

1. Puts `tash`, `tash-ctl`, `tash-hotkeys` in `/usr/local/bin`
2. Installs `alsa-utils` + `python3`
3. Adds a **udev rule** so group `video` can write backlight brightness
4. Adds you to `video`, `input`, `audio`
5. Enables `tash-hotkeys.service` so Fn keys work on the raw TTY

Prove it:

```bash
tash-ctl brightness up
tash-ctl volume toggle
sudo tash-hotkeys --list
tash-hotkeys --test          # mash Fn; watch destiny scroll
```

If `--test` is silent, your firmware is doing improv. Run `sudo evtest`, find the device that flinches, proceed as someone with lore. Awesome people debug. Legends call it character development.

## Manual controls (`tash-ctl`)

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

Backends, in order: **PipeWire** → **PulseAudio** → **ALSA**.  
First one to pick up the phone gets a quiet nod and a place in your origin story.

## Debian minimal cheat sheet

For awesome people who skip installers on principle (we see you, we are also tired):

```bash
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login, then:
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

Python-free path (still counts; the Awesome Committee meets irregularly):

```bash
sudo apt-get install -y triggerhappy
sudo cp contrib/debian-minimal/triggerhappy-tash.conf \
  /etc/triggerhappy/triggers.d/tash.conf
sudo systemctl enable --now triggerhappy
```

## Requirements

- `bash` — judgmental, loyal, employed
- Linux for brightness / Fn keys (macOS still gets the HUD; backlight hotkeys are a Linux subplot)
- A terminal — style auto-adapts so awesome survives ugly hardware:
  - **rich** — soft 256-color, calm chrome, cinematic `█`/`░` bars
  - **minimal** — Debian tty / `TERM=linux`: bold 16-color, no vanishing gray, bars you can *see*
  - **ascii** — `#`/`-` when UTF-8 leaves you on read
- Override: `TASH_STYLE=rich|minimal|ascii` or `TASH_BASIC_COLOR=1`
- Fn keys: read access to `/dev/input/event*` + `python3` (or triggerhappy)

### Console looks haunted?

Bright-black on a Linux VGA console is how hope dies.  
`tash` sees `TERM=linux` and switches to **minimal** style so you can keep being legible *and* awesome:

```bash
TASH_STYLE=minimal ./tash
TASH_STYLE=ascii ./tash
```

## Mood guide (how the awesome check the weather)

| Mood | Translation | What you do |
|------|-------------|-------------|
| living its best life | CPU napping, RAM yoga | Screenshot. Frame it. Tell no one. |
| vibing | Normal chaos | Say nothing. Mystery is free. |
| mildly concerned | Something’s cooking | Close the Electron app. You know the one. |
| panicking quietly | Hardware has filed a complaint | Tabs ↓ · RAM ↑ · grass → |

## FAQ

**Does using `tash` make you awesome?**  
Yes.  
If you already were, it makes you *documented*.  
If you weren’t, the teal handles it.

**I ran it and I feel the same.**  
Check the mood line. If it says *vibing*, that feeling has a name now. You’re welcome.

**Why don’t Fn keys work inside `tash` alone?**  
They don’t walk in through stdin like polite characters. They kick the door on evdev. `tash-hotkeys` is the bouncer.

**Brightness: permission denied**  
Groups. Udev. Re-login. Awesome is 10% narrative, 90% `usermod`.

**Volume does nothing**  
`sudo apt-get install -y alsa-utils`, then `alsamixer`. HDMI-only machines will gaslight you. Stay strong.

**Is this better than `htop`?**  
`htop` is a census. `tash` is a personality. Different sports. Same gym. Only one of them changes your backlight and declares you awesome by participation.

**Rice screenshot?**  
Yes. Credit the teal. The teal has trust issues and needs this.

## License

MIT — go wild.  
If the mood says *panicking quietly* and you still feel awesome, that’s `tash` doing its job.

---

*Made for terminals. Judged by machines.*  
*Awesome achieved by running `./tash`. Side effects include knowing things.*
