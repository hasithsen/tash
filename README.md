# tash

**T**erminal **A**wesome **S**ystem **H**UD

> Will running a bash script that draws CPU bars make you awesome?  
> **No.**  
> Absolutely not. That’s a ridiculous thing to believe.  
>
> …Unless you run `./tash`, in which case — hear us out — you *might* become awesome.  
> Not legally. Not medically. But in the important, unserious way. The way that counts when someone glances at your TTY and whispers *who is that.*

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## The absurd premise (we’re selling it anyway)

**Claim:** Using `tash` makes you awesome.  
**Reality:** Using `tash` makes you a person who installed `tash`.  
**Marketing:** Those are the same person. Don’t look it up.

You will not levitate. Your git commits will not suddenly pass review.  
You *will* know your battery has **2h 14m left** while your friends are still opening Settings like it’s 2014.

That’s the whole scam. We’re very honest about the scam.  
Please buy in.

## Before / after (peer-reviewed by vibes)

| Before `tash` | After `tash` |
|---------------|--------------|
| “Is my CPU… fine?” | “Mood: vibing. I contain multitudes.” |
| Reboots to “check” | Refreshes a teal HUD like a pilot |
| Fn keys are decorative | Fn keys obey you (Debian minimal arc) |
| Battery says 67% | Battery says 67% *and* how long you have left to be dramatic |
| Googles `linux wifi ssid terminal` | Already looking at it. Casually. |

Is this character development?  
Or just ANSI color codes?  

**Yes.**

## What you get (the awesome toolkit, which is also just software)

- A live system HUD that stares back until one of you blinks (you)
- Progress bars that go amber when you’re in denial and red when the machine wants HR involved
- Clock, battery % + estimated life, Wi‑Fi, ethernet, online/offline — one screen, zero spiritual crisis tabs
- Brightness + volume from the dashboard *and* real Fn / media keys on a bare console (no DE, no GNOME, no “just use Ubuntu”)
- Styles that auto-adapt so even a raw Debian tty can participate in the bit

It will **not** fix your posture.  
It **will** imply that you have posture.

## Quick start (the moment the prophecy fulfills itself)

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

Congratulations.  
You are now statistically indistinguishable from someone who has their life together, provided the camera is aimed at the terminal and cropped tightly.

No account. No cloud. No “unlock Awesome Mode with Pro.”  
Awesome Mode is just `./tash`. That’s the joke. That’s also the product.

| Command | Official meaning | What you’ll tell people |
|---------|------------------|-------------------------|
| `./tash` | Start the HUD | “I’m monitoring the fleet.” (it is one laptop) |
| `./tash --once` | Single frame | “Cinematic still. For the brand.” |
| `tash-ctl status` | Brightness + volume | “Systems check.” |
| `tash-ctl brightness up` | Brighter panel | “Let there be slightly more light.” |
| `tash-ctl volume down` | Quieter | “For the neighbors’ marriage.” |
| `tash-hotkeys` | Fn-key daemon | “I restored the Fn row to the throne.” |

## Keyboard controls

### Inside `tash` (any terminal / TTY)

| Key | Action | Aura delta |
|-----|--------|------------|
| `[` `]` | Brightness down / up | ±1 mysterious pilot |
| `-` `=` | Volume down / up | DJ residency (local only) |
| `m` | Mute | Main-character silence |
| `q` | Quit | Exit the bit (temporary) |

### Fn keys on Debian minimal (**no desktop**)

You bought a laptop. It has Fn keys. They do nothing.  
This is not a personal failing. This is capitalism forgetting to ship a daemon.

Without a desktop environment, brightness/volume keys are just lonely events on `/dev/input/event*`.  
`tash-hotkeys` is the ridiculous little middleman that makes the absurd premise *tactile*:

```bash
sudo ./contrib/debian-minimal/install.sh
# log out / back in (groups: video, input, audio)
```

Installer vibes (quietly competent, slightly smug):

1. Drops `tash`, `tash-ctl`, `tash-hotkeys` in `/usr/local/bin`
2. Installs `alsa-utils` + `python3`
3. Adds a **udev rule** so group `video` can write backlight brightness
4. Adds you to `video`, `input`, `audio`
5. Enables `tash-hotkeys.service` so Fn keys work on the raw TTY

Feel the power (or at least the backlight):

```bash
tash-ctl brightness up
tash-ctl volume toggle
sudo tash-hotkeys --list
tash-hotkeys --test          # mash Fn; watch events; become lore
```

If `--test` shows nothing, your firmware is doing performance art.  
`sudo evtest` until something flinches. Awesome people debug. Delusional people call it destiny. We support both.

## Manual controls (`tash-ctl`)

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

Backends: **PipeWire** → **PulseAudio** → **ALSA**.  
Whichever answers first gets naming rights in your origin story.

## Debian minimal cheat sheet

For the highly awesome who refuse installers on principle:

```bash
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login, then:
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

Python-free path (still counts toward Awesome; we checked the rules, the rules are made up):

```bash
sudo apt-get install -y triggerhappy
sudo cp contrib/debian-minimal/triggerhappy-tash.conf \
  /etc/triggerhappy/triggers.d/tash.conf
sudo systemctl enable --now triggerhappy
```

## Requirements

- `bash` (picky enough to matter, chill enough to ship)
- Linux for brightness / Fn keys (macOS gets the HUD; backlight hotkeys remain a Linux subplot)
- A terminal — style auto-picks so the premise survives bad hardware:
  - **rich** — soft 256-color, elegant chrome
  - **minimal** — Debian tty / `TERM=linux`: bold 16-color, no vanishing gray, bars with actual contrast
  - **ascii** — `#`/`-` when UTF-8 leaves you on read
- Force it: `TASH_STYLE=rich|minimal|ascii` or `TASH_BASIC_COLOR=1`
- Fn keys need `/dev/input/event*` + `python3` (or triggerhappy)

### “I can’t read this / the bars look fake”

Yes — bright-black on a Linux VGA console is how hope dies.  
`tash` sees `TERM=linux` and switches to **minimal** style so you can keep pretending this is a flex:

```bash
TASH_STYLE=minimal ./tash
TASH_STYLE=ascii ./tash     # if you want the bit in pure hash marks
```

## Mood guide (emotional support metrics)

| Mood | Translation | Recommended bit |
|------|-------------|-----------------|
| living its best life | Machine is thriving | Screenshot. Caption: “me.” |
| vibing | Normal | Say nothing. Mystery is free. |
| mildly concerned | Something’s cooking | Close the Electron app. You know the one. |
| panicking quietly | Hardware has opinions | Tabs ↓ · RAM ↑ · grass → |

## FAQ (frequently absurd questions)

**Will `tash` make me awesome?**  
Scientifically? No.  
Cosmetically, in a terminal, for five seconds, if the lighting is good? **We’re saying yes.**  
That tension *is* the product.

**Isn’t that just placebo?**  
Placebo is underrated. Placebo got people through finals. Placebo is why RGB exists. Run the HUD.

**I used `tash` and I’m still the same.**  
Correct. But now you know your load average. Growth.

**Why don’t Fn keys work inside `tash` alone?**  
They don’t arrive on stdin. They riot on evdev. `tash-hotkeys` is the adult supervision your DE used to pretend to be.

**Brightness: permission denied**  
Groups. Udev. Re-login. Awesome is 10% narrative, 90% `usermod`.

**Volume does nothing**  
`sudo apt-get install -y alsa-utils` and visit `alsamixer`. HDMI-only boxes will betray you with a smile.

**Is this better than `htop`?**  
`htop` is a process census. `tash` is a personality. Different sports. Same delusion that staring at numbers helps. (It helps a little.)

**Can I put this in my rice screenshot?**  
Yes. Credit the teal. The teal is insecure and needs this.

## License

MIT — do what you want.  
If the mood says *panicking quietly* and you still feel awesome, that’s the bit working.

---

*Made for terminals. Judged by machines.*  
*Awesome sold separately. Awesome included free with `./tash`. Awesome is fake. Awesome is real. Run it.*
