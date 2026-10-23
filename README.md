# tash

**T**erminal **A**wesome **S**ystem **H**UD

> Using `tash` makes you awesome.  
> Not “slightly more productive.” Not “kind of neat.”  
> **Awesome.** Like you know a secret the Task Manager people don’t.  
> The secret is `./tash`. We put it in the name so you wouldn’t miss it.

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## A short history of how you got awesome

Once upon a tty, there was a laptop.

It was a proud Debian minimal laptop. No wallpaper. No widgets. No little battery icon doing interpretive dance in the corner. Just a blinking cursor and the fan doing a TED Talk about heat.

Its human — that’s you — had installed the OS “for focus.” Focus, it turned out, felt a lot like staring into the void while the void compiled `node_modules`.

You mashed Fn+brightness. Nothing.  
You mashed Fn+volume. Still nothing.  
You whispered *please* to `/sys`. `/sys` did not whisper back.

So you did what any reasonable person does at 1:14 a.m.: you opened twelve terminals, ran `top`, `htop`, `free -h`, `df -h`, `ip a`, and a Stack Overflow tab that began with “as of 2017…” You still didn’t know if the Wi‑Fi was up or if the laptop was simply vibing in airplane mode out of spite.

Then someone (a stranger, a friend, a raccoon with root — accounts differ) said: try `tash`.

You typed `./tash`.

The screen cleared. A teal wordmark arrived like it paid rent. Bars drew themselves. The mood said *mildly concerned*. You closed one Electron app — you knew which traitor — and the mood flipped to *vibing*. Battery: **81%** · **2h 14m left**. Wi‑Fi: actually connected. Fn keys, after `tash-hotkeys`, finally clocked in like employees who had been on lunch since 2019.

You sat back.

You were not richer. You were not taller.  
You were **awesome**.

The laptop hummed, slightly less judgmental.  
The cursor blinked, proudly.  
And somewhere, a person still double-clicking Task Manager felt a sudden urge to learn bash and could not explain why.

## Using `tash` makes you awesome

That story is also the product description. We checked.

`tash` is a live system HUD — what your laptop would mutter if `free -h` had charisma and a sense of timing.

After one run you’ll casually know:

- your **mood** (bash, but make it judgmental)
- **battery % + time left / to full** — because “67%” alone is a cliffhanger with no finale
- **Wi‑Fi, ethernet, clock, load** — one glance, zero tabs titled `how to see ssid linux please`
- **CPU / RAM / swap / disk**, color-coded for denial → oh no
- **brightness + volume** without leaving the HUD; on Debian minimal, with **Fn keys that actually show up to work**

Your friends reboot “just to see.”  
You refresh like someone who trusts the instruments.  
That’s not a habit. That’s a glow-up. That’s awesome.

Will `tash` fix your sleep schedule? No.  
Will it narrate your swap’s slow death in Unicode? Yes.  
Awesome people can handle a little honesty.

## Quick start

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

Cursor blinks. Screen clears. Wordmark lands.  
Somewhere, a Windows user opens Resource Monitor and feels judged from another continent.

| You type | You become |
|----------|------------|
| `./tash` | Awesome (ongoing) |
| `./tash --once` | Awesome (limited theatrical release) |
| `tash-ctl status` | Briefly omniscient |
| `tash-ctl brightness up` | A minor sun god |
| `tash-ctl volume down` | Why the lease got renewed |
| `tash-hotkeys` | Rightful monarch of the Fn row |

## Keyboard controls

### Inside `tash` (any terminal / TTY)

| Key | Action | Aura event |
|-----|--------|------------|
| `[` `]` | Brightness down / up | Adjust the vibe dimmer |
| `-` `=` | Volume down / up | DJ set for system beeps |
| `m` | Mute | The room goes main-character |
| `q` | Quit | Exit stage left, still awesome |

### Fn keys on Debian minimal (**no desktop**)

You mash Fn+brightness. The universe declines.  
This is not a skill issue. This is a missing middleman issue.

Without a DE, media keys are just lonely riots on `/dev/input/event*`. Nobody is home. The backlight weeps in sysfs.  
Then you install **`tash-hotkeys`**, and suddenly you are the kind of awesome that works on a laptop that has never once met GNOME:

```bash
sudo ./contrib/debian-minimal/install.sh
# log out / back in (groups: video, input, audio)
# return as someone Fn keys fear and respect
```

Installer chores (the montage before the cape):

1. Ships `tash`, `tash-ctl`, `tash-hotkeys` → `/usr/local/bin`
2. Fetches `alsa-utils` + `python3`
3. Plants a **udev rule** so `video` can poke the backlight
4. Adds you to `video`, `input`, `audio`
5. Enables `tash-hotkeys.service` on the raw TTY

Feel something:

```bash
tash-ctl brightness up
tash-ctl volume toggle
sudo tash-hotkeys --list
tash-hotkeys --test          # mash Fn until destiny acknowledges you
```

Silence on `--test`? Firmware is doing improv night.  
`sudo evtest` until a device flinches. Awesome people debug. Mythic people name the flinching device after themselves.

## Manual controls (`tash-ctl`)

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

Backends fight for your affection, in order: **PipeWire** → **PulseAudio** → **ALSA**.  
Winner gets custody of your beeps and a line in the autobiography.

## Debian minimal cheat sheet

For the awesome who do chores manually because trust is earned:

```bash
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login, then:
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

Allergic to Python? `triggerhappy` still gets you into the Awesome Club. The door policy is mostly vibes:

```bash
sudo apt-get install -y triggerhappy
sudo cp contrib/debian-minimal/triggerhappy-tash.conf \
  /etc/triggerhappy/triggers.d/tash.conf
sudo systemctl enable --now triggerhappy
```

## Requirements (the tiny velvet rope)

- `bash` — employed, slightly judgmental
- Linux for brightness / Fn keys (macOS gets the HUD; backlight hotkeys remain a Linux plot twist)
- A terminal — style auto-picks so awesome doesn’t die on bad hardware:
  - **rich** — soft 256-color, calm chrome, `█`/`░` doing jazz hands
  - **minimal** — Debian tty / `TERM=linux`: bold 16-color, no disappearing gray, bars with spine
  - **ascii** — `#`/`-` when Unicode files a restraining order
- Force it: `TASH_STYLE=rich|minimal|ascii` or `TASH_BASIC_COLOR=1`
- Fn keys need `/dev/input/event*` + `python3` (or triggerhappy)

### Why does my console look like a ghost wrote it?

Because bright-black on VGA is a war crime against eyeballs.  
`tash` spots `TERM=linux` and flips to **minimal** style — readable, bold, still very much the outfit of someone awesome:

```bash
TASH_STYLE=minimal ./tash   # “I can see my destiny again”
TASH_STYLE=ascii ./tash     # destiny, but in hash marks
```

## Mood guide (emotional support for the newly awesome)

| Mood | What’s going on | Correct response |
|------|-----------------|------------------|
| living its best life | The machine is thriving without you | Screenshot. Frame it. Lie and say it’s always like this. |
| vibing | Baseline chaos | Nod once. Never explain. |
| mildly concerned | Something is sautéing itself | Close the Electron app. You already know which traitor. |
| panicking quietly | Silicon has opened a ticket | Tabs ↓ · RAM ↑ · grass → · snacks ↔ |

## FAQ (asked by people mid-glow-up)

**Does using `tash` make you awesome?**  
Yes.  
Full stop.  
If your friends disagree, open `tash` on their machine. Watch them change.

**I ran it and I still feel normal.**  
Impossible. Check `mood`. If it says *vibing*, that *is* the feeling. You’ve just never had a label for your own chill.

**Why don’t Fn keys work inside `tash` alone?**  
Fn keys don’t RSVP to stdin. They crash the afterparty on evdev. `tash-hotkeys` takes attendance.

**Brightness: permission denied**  
You’re not in `video`, or udev ghosted you. Re-install, re-login. Awesome is 10% cape, 90% group membership.

**Volume does nothing**  
`sudo apt-get install -y alsa-utils` and make eye contact with `alsamixer`. HDMI-only machines will betray you while smiling. Stay awesome anyway.

**Is this better than `htop`?**  
`htop` counts processes like a census bureau.  
`tash` changes your backlight, estimates your battery’s remaining will to live, and declares you awesome for showing up.  
Different sports. Same gym. Only one has a teal era.

**Can I put this in my rice screenshot?**  
Yes. Credit the teal. The teal is insecure, powerful, and keeping score.

## License

MIT — do what you want.  
If the mood says *panicking quietly* and you still feel awesome, that’s not a bug. That’s the product working.

---

*Made for terminals. Judged by machines.*  
*Awesome unlocked by `./tash`. If you don’t feel it after one refresh, run it again — harder, with feeling.*
