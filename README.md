# tash

**T**erminal **A**wesome **S**ystem **H**UD

> Using `tash` makes you awesome.  
> Not louder. Not busier. Simply clearer — the sort of clear that looks, from the next table, like poise.  
> The method is undignified in its honesty: you type `./tash`.  
> We put it in the name so destiny wouldn’t have to shout.

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## The story

You bought a laptop and removed the desktop “for purity.”

What remained was Debian minimal: one cursor, one fan with a singing career, and a small ache where the battery icon used to smile. You told people you were “closer to the metal.” The metal, for its part, maintained a dignified silence.

Late one night the fans climbed toward takeoff. Chrome? A compile? Divine intervention with a sense of humor? You pressed Fn+brightness. Nothing happened, which felt personal. You pressed Fn+volume. The speakers stayed modern art — handsome, quiet, committed to the bit.

So you opened terminals the way kinder people open biscuits. `top`. `htop`. `free -h`. `ip a`. A tutorial that began with the dangerous word “simply” and had last been loved by the internet in another decade. You still could not tell if the Wi‑Fi was connected or merely rehearsing the idea of connection.

Then a voice — friend, stranger, or raccoon with suspiciously good `sudo` form — suggested, as if it were obvious: try `tash`.

You typed `./tash` carefully, the way one types when the room might be watching.

The screen cleared with the relief of a tablecloth snapped straight. Teal settled in. Bars drew themselves as if they’d been practicing. Mood: *mildly concerned*. You closed the Electron window you’d been calling “just one more tab.” Mood: *vibing*. Battery: **81%** · **2h 14m left**. Wi‑Fi: yes — actually yes. And when `tash-hotkeys` arrived, the Fn row came home from a very long lunch, the kind that began when the desktop packed its bags.

You sat back.

You had not learned French. You had not fixed your sleep. You had not become wise in any way a résumé would notice.  
You had become **awesome**: that soft, ridiculous clarity of knowing how your laptop is doing — and dimming it without leaving the story.

The fan found a lower note. The cursor blinked, almost fond.  
Somewhere, a Task Manager click went astray, and its human smiled for no reason they could name.

## What `tash` is

A live system HUD: the conversation your laptop would have if `free -h` had better manners and arrived on time for tea.

Using it makes you awesome. Less a slogan than a gentle side effect — like standing up straighter after the room is finally tidy.

At a glance you receive:

- **Mood** — a courteous verdict on the evening (`living its best life` → `panicking quietly`)
- **Battery** — the percentage *and* how long the plot still has (`2h 14m left`, or time to full)
- **Clock, Wi‑Fi, ethernet, online/offline** — one composition; no scavenger hunt in the sock drawer of `/proc`
- **CPU, memory, swap, disk** — bars that warm from calm to “perhaps that tab has had enough”
- **Brightness and volume** from the HUD; on a bare Debian laptop, real **Fn keys** once `tash-hotkeys` sets the table

Friends reboot “just to see.”  
You refresh, like someone who trusts the instruments and also owns a kettle.  
Same laptop. Softly different posture.

## Quick start

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

The cursor yields. The wordmark arrives. Awesome begins with alarming politeness.

| Command | What unfolds |
|---------|----------------|
| `./tash` | The live HUD — full series, no ads |
| `./tash --once` | One frame; suitable for framing if the mood is kind |
| `tash-ctl status` | Brightness and volume, spoken softly |
| `tash-ctl brightness up` | A little more light, please |
| `tash-ctl volume down` | A little more peace for the neighbors |
| `tash-hotkeys` | The Fn row, invited back to the party |

## Keyboard controls

### Inside `tash`

| Key | Action | In the room |
|-----|--------|-------------|
| `[` `]` | Brightness down / up | Adjust the lamp, not the soul |
| `-` `=` | Volume down / up | Conduct the beep orchestra, gently |
| `m` | Mute | Sudden, elegant silence |
| `q` | Quit | Leave; remain awesome in the corridor |

### Fn keys on Debian minimal (no desktop)

Laptop Fn keys do not conjure a desktop out of longing. Without one, they arrive as shy events on `/dev/input/event*` and wait for someone civilised to take their coats.

That someone is `tash-hotkeys` (or triggerhappy) — how the backlight finds its way home:

```bash
sudo ./contrib/debian-minimal/install.sh
# log out / back in (groups: video, input, audio)
# return as someone the Fn row is pleased to see
```

What the installer does (the unglamorous kindness):

1. Places `tash`, `tash-ctl`, and `tash-hotkeys` in `/usr/local/bin`
2. Installs `alsa-utils` and `python3`
3. Adds a **udev rule** so group `video` may write backlight brightness
4. Adds you to `video`, `input`, and `audio`
5. Enables `tash-hotkeys.service` on the raw TTY

Confirm the quiet miracle:

```bash
tash-ctl brightness up
tash-ctl volume toggle
sudo tash-hotkeys --list
tash-hotkeys --test
```

If `--test` stays silent, the firmware is being coy. `sudo evtest` will show which device still remembers how to flinch. Awesome people look. Then they fix it — with tea, if available.

## Manual controls (`tash-ctl`)

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

Backends, in polite order: **PipeWire** → **PulseAudio** → **ALSA**.  
First to answer keeps custody of the beeps and a fond footnote in your evening.

## Debian minimal cheat sheet

For those who prefer to set the table themselves:

```bash
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login, then:
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

Prefer no Python? `triggerhappy` walks the same garden path:

```bash
sudo apt-get install -y triggerhappy
sudo cp contrib/debian-minimal/triggerhappy-tash.conf \
  /etc/triggerhappy/triggers.d/tash.conf
sudo systemctl enable --now triggerhappy
```

## Requirements

- `bash` — loyal, lightly judgmental, excellent with bars
- Linux for brightness and Fn keys (macOS still receives the HUD; backlight hotkeys remain a Linux subplot with good lighting)
- A terminal — style chooses itself so elegance survives rough evenings:
  - **rich** — soft 256-color, calm chrome, `█` / `░` bars practicing their scales
  - **minimal** — Debian tty / `TERM=linux`: bold 16-color, no vanishing gray, bars with posture
  - **ascii** — `#` / `-` when Unicode is away on holiday
- Override with `TASH_STYLE=rich|minimal|ascii` or `TASH_BASIC_COLOR=1`
- Fn keys: access to `/dev/input/event*` plus `python3` (or triggerhappy)

### Hard to read on the console?

Bright-black on a VGA console fades into the curtains.  
`tash` notices `TERM=linux` and slips into **minimal** — clear labels, honest bars, still teal enough to mean it:

```bash
TASH_STYLE=minimal ./tash   # legibility, with feeling
TASH_STYLE=ascii ./tash     # the same evening, in hash marks
```

## Mood guide

| Mood | Meaning | A sensible response |
|------|---------|---------------------|
| living its best life | The laptop is unbothered | Screenshot. Rare weather. Frame optional, taste recommended. |
| vibing | Ordinary weather | A small nod. No speech required. |
| mildly concerned | Something is warm | Close the obvious tab. You already know which. |
| panicking quietly | Something is loud | Tabs down. RAM up. Fresh air, if the evening allows. |

## FAQ

**Does using `tash` make you awesome?**  
Yes.  
The follow-up question may wait until after the mood line.

**I feel the same.**  
Glance at `mood`. If it says *vibing*, that feeling has simply acquired a name — and excellent kerning.

**Why don’t Fn keys work inside `tash` alone?**  
They never arrive on stdin; they wait in the lobby on evdev. `tash-hotkeys` holds the door and takes their coats.

**Brightness: permission denied**  
Group `video`, or udev has not yet heard the news. Re-run the installer; log in again. Awesome is partly narrative, mostly permissions — a classic pairing.

**Volume does nothing**  
`sudo apt-get install -y alsa-utils`, then make kind eye contact with `alsamixer`. HDMI-only laptops will smile while changing the subject.

**Better than `htop`?**  
Different instruments in the same house. `htop` counts the guests. `tash` dims the lamps, checks the battery’s remaining evening, and leaves you quietly awesome on the sofa.

**Rice screenshot?**  
Please do. Credit the teal. It has taste, patience, and a surprisingly long memory for kindness.

## License

MIT — use it kindly, share it freely.  
If the mood says *panicking quietly* and you still feel awesome, the HUD is doing exactly what it came for.

---

*Made for terminals. Judged by machines.*  
*Awesome, quietly, after `./tash` — biscuits optional, teal mandatory.*
