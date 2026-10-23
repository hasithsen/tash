# tash

**T**erminal **A**wesome **S**ystem **H**UD

> You are alone on a Debian minimal install.  
> No wallpaper. No widgets. No little battery icon that lies to you.  
> Just a blinking cursor, and the quiet fear that something is On Fire.  
>
> Then you type `./tash`.  
> The screen clears. A teal wordmark appears. Your laptop confesses.  
> You exhale. You are — against all odds — **fine**. Maybe even *awesome*.

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## This is the feeling

Not productivity. Not “observability.”  
The feeling of knowing — *really knowing* — that your CPU is at 4% and your battery has **2h 14m left** and the Wi‑Fi is not, in fact, a rumor.

Your friends mash `top` like they’re defusing a bomb.  
You open `tash` like you’re checking the weather on a yacht.

- **Mood line** that roast-validates your life choices (`vibing` / `panicking quietly`)
- **Battery % + life remaining** — because a naked percentage is emotional neglect
- **Wi‑Fi, ethernet, clock, load, RAM, disk** — one frame, zero shame-Googling
- **Brightness + volume** from the HUD *and* real **Fn keys** on a bare console  
  (no desktop, no GNOME, no “have you tried installing a whole universe?”)
- Bars that go amber when you’re in denial and red when the silicon wants a lawyer

It will **not** text your ex.  
It **will** tell you your swap is crying in the corner.

## Quick start (inhale → exhale → awesome)

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

That’s it. No signup. No telemetry. No “join our Discord for metrics tips.”  
Just you, a HUD, and the soft hum of competence.

| You type | You become |
|----------|------------|
| `./tash` | Someone who *knows* |
| `./tash --once` | A film still. Iconic. |
| `tash-ctl status` | Briefly omniscient |
| `tash-ctl brightness up` | A small god of lumens |
| `tash-ctl volume down` | The reason the neighbors stayed |
| `tash-hotkeys` | Fn-key royalty |

## Keyboard controls

### Inside `tash` (any terminal / TTY)

| Key | Action | How it feels |
|-----|--------|--------------|
| `[` `]` | Brightness down / up | Adjusting the vibe dimmer |
| `-` `=` | Volume down / up | Conducting the beep orchestra |
| `m` | Mute | Instant main-character silence |
| `q` | Quit | Mic drop, but polite |

### Fn keys on Debian minimal (**no desktop**)

You pressed Fn+F5. Nothing happened.  
Your soul left your body for a moment.

That’s normal. Without a desktop environment there is no friendly daemon catching media keys. They show up as raw Linux input events on `/dev/input/event*`, lonely and unheard — until **`tash-hotkeys`** adopts them:

```bash
sudo ./contrib/debian-minimal/install.sh
# log out / back in (groups: video, input, audio)
# then press Fn+brightness like you mean it
```

What the installer does (the unsexy part of feeling powerful):

1. Installs `tash`, `tash-ctl`, `tash-hotkeys` → `/usr/local/bin`
2. Pulls in `alsa-utils` + `python3`
3. Drops a **udev rule** so `video` can write backlight brightness
4. Adds you to `video`, `input`, `audio`
5. Enables `tash-hotkeys.service` so Fn keys work on the raw TTY

Prove it. Feel it:

```bash
tash-ctl brightness up
tash-ctl volume toggle
sudo tash-hotkeys --list
tash-hotkeys --test          # mash the Fn row; watch destiny scroll by
```

If `--test` is silent, your firmware is doing improv. Run `sudo evtest`, find the device that actually flinches, and proceed as a person with lore.

## Manual controls (`tash-ctl`)

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

Backends, in priority order: **PipeWire** → **PulseAudio** → **ALSA**.  
First one to answer the phone gets to be in your montage.

## Debian minimal cheat sheet

For when you skipped the installer because you “like doing things the hard way” (we see you, we respect you, we are also tired):

```bash
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login, then:
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

Allergic to Python? `triggerhappy` still gets you to the same emotional beat:

```bash
sudo apt-get install -y triggerhappy
sudo cp contrib/debian-minimal/triggerhappy-tash.conf \
  /etc/triggerhappy/triggers.d/tash.conf
sudo systemctl enable --now triggerhappy
```

## Requirements (the tiny gate before the feeling)

- `bash` — judgmental, loyal
- Linux for brightness / Fn keys (macOS still gets the HUD; backlight hotkeys are a Linux subplot)
- A terminal. Style auto-adapts so the feeling survives ugly hardware:
  - **rich** — soft 256-color, calm chrome, cinematic bars
  - **minimal** — Debian tty / `TERM=linux`: bold 16-color, no vanishing gray, bars you can actually *see*
  - **ascii** — when UTF-8 ghosted you (`#` / `-`, still dramatic)
- Override: `TASH_STYLE=rich|minimal|ascii` or `TASH_BASIC_COLOR=1`
- Fn keys: read access to `/dev/input/event*` + `python3` (or triggerhappy)

### Console looks haunted?

Bright-black text on a Linux VGA console is a war crime against your eyeballs.  
`tash` notices `TERM=linux` and switches to **minimal** style automatically — bold cyan labels, white values, bars with contrast that slap.

```bash
TASH_STYLE=minimal ./tash   # “I can read again”
TASH_STYLE=ascii ./tash     # “burn it down, rebuild in hash marks”
```

## Mood guide (emotional support, but make it metrics)

| Mood | What’s happening | What you do |
|------|------------------|-------------|
| living its best life | CPU napping, RAM yoga | Screenshot. Frame it. Tell no one how rare this is. |
| vibing | Normal chaos | Stay mysterious. Sip something. |
| mildly concerned | Something’s cooking | Close the Electron app. You already know which one. |
| panicking quietly | The machine has filed a complaint | Tabs. RAM. Grass. Not necessarily in that order. |

## FAQ (feelings, annotated)

**Will `tash` make me awesome?**  
It will make you *look* awesome, which is 91% of the job. The other 9% is closing Chrome.

**I ran it and felt nothing.**  
Impossible. Check `mood`. If it says `vibing`, you felt something — you just called it “looking at a terminal.”

**Why don’t Fn keys work inside `tash` alone?**  
Because Fn keys don’t walk in through stdin like polite characters. They kick the door on evdev. `tash-hotkeys` is the bouncer who finally lets them in.

**Brightness: permission denied**  
You’re not in group `video`, or udev didn’t get the memo. Re-run the installer. Re-login. Awesome is 10% aura, 90% groups.

**Volume does nothing**  
`sudo apt-get install -y alsa-utils`, then `alsamixer`. HDMI-only machines will gaslight you. That’s not a you problem; that’s a port problem.

**Is this better than `htop`?**  
Different religion. `htop` counts processes. `tash` changes your backlight and judges your life. Both valid. Gym has more than one machine.

**Can this be in my rice screenshot?**  
Yes. Credit the teal. The teal has trust issues.

## License

MIT — go wild.  
If the mood says *panicking quietly* and the speakers agree, that’s between you and the hardware.

---

*Made for terminals. Judged by machines.*  
*You: slightly more awesome. Optional. Strongly encouraged. Felt in the chest.*
