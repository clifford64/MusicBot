<a href="https://arif-banai.github.io/MusicBot/"><img src="website/docs/assets/images/og-card.png" alt="JMusicBot: the music bot you run yourself, with an example now-playing panel"></a>

# JMusicBot

A Discord music bot you run yourself. This is a fork of [jagrosh's JMusicBot](https://github.com/jagrosh/MusicBot),
kept working and updated.

> Fork of [arif-banai/MusicBot](https://github.com/arif-banai/MusicBot) (itself a fork of
> [Jagrosh/JMusicBot](https://github.com/Jagrosh/JMusicBot)). Maintained by clifford64.

[![Release](https://img.shields.io/github/release/clifford64/MusicBot.svg)](https://github.com/clifford64/MusicBot/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/clifford64/MusicBot/total.svg)](https://github.com/clifford64/MusicBot/releases/latest)
[![Discord](https://discordapp.com/api/guilds/1453856673004392634/widget.png?v=1)](https://discord.gg/cyyUxNmmx6)
[![Build and Test](https://github.com/clifford64/MusicBot/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/clifford64/MusicBot/actions/workflows/build-and-test.yml)

- Plays YouTube, SoundCloud, internet radio and your own files, with no API keys
- Slash commands that suggest songs as you type
- A now-playing panel with buttons for pause, skip, volume and more
- Queue, history and saved playlists
- An optional [yt-dlp library](https://arif-banai.github.io/MusicBot/features/ytdlp-library/) for songs that won't stream

## Get started

Follow the [setup guide](https://arif-banai.github.io/MusicBot/setup/), or
[run it with Docker](https://arif-banai.github.io/MusicBot/setup/docker/).

## Documentation

[Commands](https://arif-banai.github.io/MusicBot/reference/commands/) ·
[config.txt](https://arif-banai.github.io/MusicBot/reference/config/) ·
[Troubleshooting](https://arif-banai.github.io/MusicBot/help/troubleshooting/) ·
[Coming from JMusicBot](https://arif-banai.github.io/MusicBot/migrating/) ·
[All docs](https://arif-banai.github.io/MusicBot/)

## Docker

The image is `ghcr.io/clifford64/musicbot` (tags: `latest`, and versions such as `0.8.1`).
[Published images](https://github.com/clifford64/MusicBot/pkgs/container/musicbot).

Unlike the upstream image, the container starts as root, fixes ownership of the mounted `/musicbot`
directory itself, and then drops to UID/GID `10001:10001` before starting the bot — so you do **not**
need to pre-`chown` the folder. You can change the fallback with the `MUSICBOT_UID` / `MUSICBOT_GID`
environment variables, or run as your own user with `-u "$(id -u):$(id -g)"` (the folder just needs to
be writable by that user). The bot never runs as root either way. See
[docker-compose.example.yml](docker-compose.example.yml) for a ready-to-edit compose file.

```bash
mkdir -p ~/jmusicbot && \
docker run --rm -it --name jmusicbot \
  -v ~/jmusicbot:/musicbot \
  ghcr.io/clifford64/musicbot:latest
```

## Help and contributing

Ask questions in [Discussions](https://github.com/clifford64/MusicBot/discussions) or on
[Discord](https://discord.gg/cyyUxNmmx6), and report bugs in [Issues](https://github.com/clifford64/MusicBot/issues).
Branch naming and the release flow are in [DEVELOPMENT_WORKFLOW.md](docs/DEVELOPMENT_WORKFLOW.md).

This bot is built on [JDA](https://github.com/DV8FromTheWorld/JDA),
[lavaplayer](https://github.com/lavalink-devs/lavaplayer) and
[youtube-source](https://github.com/lavalink-devs/youtube-source). If you like it, give them a star too.

## License

[Apache 2.0](LICENSE)
