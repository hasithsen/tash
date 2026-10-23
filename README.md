# tash

**T**erminal **A**wesome **S**ystem **H**UD

> Using `tash` makes you awesome.  
> Not louder. Not busier. Simply… clearer.  
> The kind of clear that looks, from across a café, like you know what you’re doing.  
> (You typed `./tash`. That’s the whole trick. We named it helpfully.)

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## The story

There was a laptop.

Debian minimal. No wallpaper, no widgets, no cheerful battery pill in the corner — only a cursor, blinking with the patience of something that had already forgiven you once today. You had installed it for focus. Focus, you discovered, sounded a lot like a fan explaining thermodynamics at length.

You pressed Fn and asked for light. The laptop declined, politely, by doing nothing.  
You asked for quieter speakers. Same answer, same silence.  
Somewhere under `/sys`, the backlight waited like an unanswered letter.

So you did the dignified thing. You opened more terminals. `top`. `htop`. `free -h`. `ip a`. A browser tab from 2017 that began, with tragic confidence, “simply run…” You still could not tell whether the Wi‑Fi was up or merely resting its eyes.

Then — from a friend, a stranger, or a raccoon who knew `sudo` — came three letters and a habit: try `tash`.

You typed `./tash`.

The screen drew a breath. A teal wordmark settled as if it belonged there. Bars arrived without apology. The mood read *mildly concerned*; you closed one Electron window you had been pretending not to see; the mood became *vibing*. Battery: **81%**, **2h 14m left**. The network was, in fact, connected. Later, with `tash-hotkeys`, the Fn row returned from whatever sabbatical it had been on since the desktop went away.

You sat back.

Nothing mystical had occurred. You were not richer, not taller, not suddenly fluent in French.  
You were, however, **awesome** — which is what we call a person who knows how their laptop is doing and can dim the screen without leaving the story.

The fan softened. The cursor kept blinking, a little prouder.  
Across town, someone double-clicked Task Manager and felt, without knowing why, that they were late to something.

## What `tash` is

A live system HUD: the conversation your laptop would have if `free -h` had better manners and a sense of timing.

Using it makes you awesome. That is not a slogan so much as a side effect.

You get, at a glance:

- **Mood** — a short verdict on the night (`living its best life` → `panicking quietly`)
- **Battery** — percentage *and* time left, or time to full
- **Clock, Wi‑Fi, ethernet, online/offline** — one composition, no scavenger hunt
- **CPU, memory, swap, disk** — bars that warm from calm to “perhaps close a tab”
- **Brightness and volume** in the HUD; on a bare Debian laptop, real **Fn keys** via `tash-hotkeys`

Friends reboot “just to see.”  
You refresh.  
Same machine. Different posture.

## Quick start

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

The cursor yields. The wordmark arrives. Awesome begins on the next line.

| Command | Meaning |
|---------|---------|
| `./tash` | Live HUD |
| `./tash --once` | A single frame — keep it if it’s art |
| `tash-ctl status` | Brightness and volume, quietly |
| `tash-ctl brightness up` | A little more light |
| `tash-ctl volume down` | A little more peace |
| `tash-hotkeys` | Fn keys, restored to usefulness |

## Keyboard controls

### Inside `tash`

| Key | Action |
|-----|--------|
| `[` `]` | Brightness down / up |
| `-` `=` | Volume down / up |
| `m` | Mute |
| `q` | Quit (awesome persists) |

### Fn keys on Debian minimal (no desktop)

Laptop Fn keys do not invent a desktop for you. Without one, they arrive as input events on `/dev/input/event*` and wait for someone civilised to listen.

That someone is `tash-hotkeys` (or triggerhappy):

```bash
sudo ./contrib/debian-minimal/install.sh
# log out / back in (groups: video, input, audio)
```

The installer:

1. Places `tash`, `tash-ctl`, `tash-hotkeys` in `/usr/local/bin`
2. Installs `alsa-utils` and `python3`
3. Adds a **udev rule** so group `video` can write backlight brightness
4. Adds you to `video`, `input`, and `audio`
5. Enables `tash-hotkeys.service` on the raw TTY

Confirm the quiet miracle:

```bash
tash-ctl brightness up
tash-ctl volume toggle
sudo tash-hotkeys --list
tash-hotkeys --test
```

If `--test` stays silent, the firmware is being coy — `sudo evtest` will show which device still remembers how to flinch. Awesome people look. Then they fix it.

## Manual controls (`tash-ctl`)

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

Backends, in order: **PipeWire** → **PulseAudio** → **ALSA**.  
First to answer keeps the beeps.

## Debian minimal cheat sheet

```bash
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login, then:
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

Prefer no Python? `triggerhappy` walks the same path:

```bash
sudo apt-get install -y triggerhappy
sudo cp contrib/debian-minimal/triggerhappy-tash.conf \
  /etc/triggerhappy/triggers.d/tash.conf
sudo systemctl enable --now triggerhappy
```

## Requirements

- `bash`
- Linux for brightness and Fn keys (macOS still gets the HUD; backlight hotkeys remain a Linux chapter)
- A terminal — style chooses itself so elegance survives rough hardware:
  - **rich** — soft 256-color, calm chrome, `█` / `░` bars
  - **minimal** — Debian tty / `TERM=linux`: bold 16-color, no vanishing gray
  - **ascii** — `#` / `-` when Unicode is away
- Override with `TASH_STYLE=rich|minimal|ascii` or `TASH_BASIC_COLOR=1`
- Fn keys: access to `/dev/input/event*` plus `python3` (or triggerhappy)

### Hard to read on the console?

Bright-black on a VGA console fades into the night.  
`tash` notices `TERM=linux` and switches to **minimal** — clear labels, honest bars, still teal enough to mean it:

```bash
TASH_STYLE=minimal ./tash
TASH_STYLE=ascii ./tash
```

## Mood guide

| Mood | Meaning | You |
|------|---------|-----|
| living its best life | The laptop is unbothered | Screenshot. Rare weather. |
| vibing | Ordinary weather | A small nod. No speech. |
| mildly concerned | Something is warm | Close the obvious tab. |
| panicking quietly | Something is loud | Tabs down. RAM up. Air, optional. |

## FAQ

**Does using `tash` make you awesome?**  
Yes. Next question is optional.

**I feel the same.**  
Read the mood line. If it says *vibing*, that feeling finally has a name.

**Why don’t Fn keys work inside `tash` alone?**  
They never arrive on stdin. They wait on evdev. `tash-hotkeys` opens the door.

**Brightness: permission denied**  
Group `video`, or udev. Re-run the installer; log in again. Awesome is partly narrative, mostly permissions.

**Volume does nothing**  
`sudo apt-get install -y alsa-utils`, then `alsamixer`. HDMI-only laptops will smile while betraying you.

**Better than `htop`?**  
Different instruments. `htop` counts. `tash` composes — backlight, battery life, a little judgment, and the side effect called awesome.

**Rice screenshot?**  
Yes. Credit the teal. It has taste and a long memory.

## License

MIT — use it kindly.  
If the mood says *panicking quietly* and you still feel awesome, the HUD is doing its job.

---

*Made for terminals. Judged by machines.*  
*Awesome, quietly, after `./tash`.*
