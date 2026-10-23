# tash

**T**erminal **A**wesome **S**ystem **H**UD

> Using `tash` makes you awesome.  
> Not busier. Not louder. Just… in on it.  
> The whole method is `./tash`. We named it that on purpose.

```
  ████████╗ █████╗ ███████╗██╗  ██╗
  ╚══██╔══╝██╔══██╗██╔════╝██║  ██║
     ██║   ███████║███████╗███████║
     ██║   ██╔══██║╚════██║██╔══██║
     ██║   ██║  ██║███████║██║  ██║
     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

## The story

You stripped the desktop off your laptop “for purity.”

Debian minimal. One cursor. One fan auditioning for a musical. No battery icon — just faith and `cat`.

Fans hit takeoff. Chrome? Compile? Divine intervention with jokes? You hit Fn+brightness. Nothing. Fn+volume. Still nothing. The keys had retired.

So you opened more terminals. `top`. `htop`. `free -h`. A guide that started with “simply” and hadn’t been simply since another decade. Wi‑Fi: connected, or method acting?

Someone said: try `tash`.  
(Friend. Stranger. Raccoon with `sudo`. Unclear.)

You ran `./tash`.

Teal. Bars. Mood: *mildly concerned*. One Electron tab closed. Mood: *vibing*. Battery **81%** · **2h 14m left**. Wi‑Fi: real. `tash-hotkeys` brought the Fn row back from lunch (started when GNOME left).

You hadn’t learned French.  
You had become **awesome**.

## What you get

A live HUD. Your laptop, finally talking sense.

- **Mood** — `vibing` through `panicking quietly`
- **Battery** — % plus time left / to full
- **Clock, Wi‑Fi, ethernet, online/offline**
- **CPU, RAM, swap, disk** — bars that blush when things heat up
- **Brightness + volume** in-app; **Fn keys** on bare Debian via `tash-hotkeys`

Friends reboot “just to see.”  
You refresh. That’s the glow-up.

## Quick start

```bash
chmod +x tash tash-ctl tash-hotkeys
./tash
```

| Command | Result |
|---------|--------|
| `./tash` | Live HUD. Awesome onset. |
| `./tash --once` | One frame. |
| `tash-ctl status` | Brightness + volume |
| `tash-ctl brightness up` | More light |
| `tash-ctl volume down` | More peace |
| `tash-hotkeys` | Fn keys, employed again |

## Keys

| Key | Action |
|-----|--------|
| `[` `]` | Brightness ↓ / ↑ |
| `-` `=` | Volume ↓ / ↑ |
| `m` | Mute |
| `q` | Quit (awesome stays) |

### Fn keys (Debian minimal, no desktop)

Fn keys don’t magic a DE into existence. They show up on `/dev/input/event*` and wait.

```bash
sudo ./contrib/debian-minimal/install.sh
# re-login (groups: video, input, audio)
```

Installs binaries, `alsa-utils`, `python3`, backlight udev rule, groups, and `tash-hotkeys.service`.

```bash
tash-ctl brightness up
tash-hotkeys --test
```

No events? `sudo evtest` — find what flinches.

## `tash-ctl`

```bash
tash-ctl brightness get|up|down|set 40
tash-ctl volume     get|up|down|set 30|mute|unmute|toggle
tash-ctl status
```

**PipeWire** → **PulseAudio** → **ALSA**.

## Manual Debian bits

```bash
sudo apt-get install -y alsa-utils python3
sudo usermod -aG video,input,audio "$USER"
# re-login
sudo cp contrib/debian-minimal/99-tash-backlight.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger -s backlight
```

No Python? `triggerhappy` + `contrib/debian-minimal/triggerhappy-tash.conf`.

## Requirements

- `bash`
- Linux for brightness / Fn (macOS: HUD only)
- Style auto-picks: **rich** · **minimal** (`TERM=linux`) · **ascii**
- Force: `TASH_STYLE=minimal` or `ascii`
- Fn: `/dev/input/event*` + `python3` (or triggerhappy)

## Moods

| Mood | Move |
|------|------|
| living its best life | Screenshot it |
| vibing | Say nothing |
| mildly concerned | Close that tab |
| panicking quietly | Tabs ↓ · RAM ↑ |

## FAQ

**Does `tash` make you awesome?**  
Yes.

**Still feel normal?**  
Check `mood`. *Vibing* is the feeling. You’re welcome.

**Fn keys dead inside `tash`?**  
They use evdev, not stdin. Run `tash-hotkeys`.

**Brightness denied?**  
Join `video`, reload udev, re-login.

**No volume?**  
`alsa-utils` + `alsamixer`. HDMI will gaslight you.

**Vs `htop`?**  
`htop` counts. `tash` dims the lights and calls you awesome.

## License

MIT.  
Mood says *panicking quietly* and you still feel awesome? Working as intended.

---

*Terminals. Machines. `./tash`. Awesome.*
