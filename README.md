# tash

**T**erminal **A**wesome **S**ystem **H**UD

> Using `tash` makes you awesome.  
> Your friends may not understand why.  
> That’s fine. Awesome rarely comes with a group chat.

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## Friends, briefly

You removed the desktop “for focus.” At 1 a.m. the fans staged a musical. You opened five terminals, asked the laptop five times if it was dying, and got five different shrugs.

A friend walked past, glanced at the blinking cursor, and said — like it was obvious — “Run `tash`.”

You did.

Teal. Bars. Mood: *mildly concerned*. One tab closed. Mood: *vibing*. Battery: **2h 14m left**. Fn keys, after a small install, remembered how to work.

Your friend nodded once — the nod of someone who has seen this movie — and left you with a quieter fan and a better posture.

You had not become famous.  
You had become **awesome**.

Later you will be the friend who walks past someone else’s cursor. That is how it spreads.

## What `tash` is

A live system HUD for people who would rather know than reboot.

- **Mood** — how the evening is going (`vibing` … `panicking quietly`)
- **Battery** — percent and time left (or to full)
- **Clock, Wi‑Fi, ethernet, online / offline**
- **CPU, memory, swap, disk** — honest bars
- **Brightness & volume** — in the HUD; on bare Debian, Fn keys via `tash-hotkeys`

People who use it refresh.  
People who don’t, reboot “just to see.”  
Guess which ones look awesome from the doorway.

## Quick start

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

| Command | For people who… |
|---------|-----------------|
| `./tash` | want the live HUD |
| `./tash --once` | want one frame to show a friend |
| `tash-ctl status` | want numbers without the drama |
| `tash-ctl brightness up` | are squinting |
| `tash-ctl volume down` | have neighbors |
| `tash-hotkeys` | miss their Fn keys |

## Keyboard

| Key | Action |
|-----|--------|
| `[` `]` | Brightness down / up |
| `-` `=` | Volume down / up |
| `m` | Mute |
| `q` | Quit (awesome remains) |

### Fn keys on Debian minimal (no desktop)

People without a desktop still have fingers. The keys show up on `/dev/input/event*` (on Dell Latitude, often **Dell WMI hotkeys**). `tash-hotkeys` listens.

```bash
sudo ./contrib/debian-minimal/install.sh
# log out / back in (or reboot)
```

Loads `dell_wmi`, keeps logind from eating brightness keys, installs udev rules, runs `tash-hotkeys.service`.

```bash
tash-ctl brightness up
sudo tash-hotkeys --list
sudo tash-hotkeys --test          # press Fn brightness / volume
```

**Dell Latitude 5480:** BIOS → Function Key Behavior, or **Fn+Esc**. Unknown `code=N` in `--test`?

```bash
sudo systemctl edit tash-hotkeys
# [Service]
# Environment=TASH_EXTRA_KEYS=N:brightness:up,M:brightness:down
sudo systemctl restart tash-hotkeys
```

## `tash-ctl`

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

**PipeWire** → **PulseAudio** → **ALSA**.

## Debian minimal (manual)

```bash
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

Or triggerhappy — see `contrib/debian-minimal/`.

## Requirements

- `bash`
- Linux for brightness / Fn (macOS: HUD works)
- Styles: **rich** · **minimal** (`TERM=linux`) · **ascii**  
  (`TASH_STYLE=minimal` if the console gets mysterious)
- Fn keys: `/dev/input/event*` + `python3` (or triggerhappy)

## Moods (for humans)

| Mood | What people do |
|------|----------------|
| living its best life | Screenshot. Soft smile. |
| vibing | Nothing. That’s the point. |
| mildly concerned | Close the guilty tab. |
| panicking quietly | Tabs down. Walk. Return awesome. |

## FAQ

**Can friends become awesome by using `tash`?**  
Yes. You did (or will). Then you tell the next person. Softly.

**Why don’t Fn keys work inside `tash` alone?**  
They never visit stdin. They hang out on evdev. Invite `tash-hotkeys`.

**Brightness denied?**  
Join `video`, reload udev, log in again. Awesome needs permissions sometimes.

**No volume?**  
`alsa-utils`, then `alsamixer`. Ask a friend if you must — better to become the friend who knows.

**Vs `htop`?**  
`htop` is a crowd scene. `tash` is the wide shot — battery, network, backlight, and you looking like you meant it.

## License

MIT. Share it with people. Especially the ones still rebooting.

---

*For terminals. For laptops. For people who type `./tash` and quietly level up.*
