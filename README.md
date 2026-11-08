Maintained by [Ankara Yazılım](https://github.com/Ankara-Software) | [Project page](https://ankarayazilim.org/acik-kaynak/linux-soft-cleaner)

**Status: beta.** It builds and runs, but the project has no automated tests yet. Only `--dry-run` was exercised on macOS; the Linux package-manager and log paths were not run on a Linux host.

# Linux Soft Cleaner

<p align="center">
  <img src="assets/banner.png" alt="Linux Soft Cleaner Banner" width="100%">
</p>

A small disk cleanup tool for Linux servers, written in Rust.

## Türkçe

Linux sunucularda disk alanı açmak için yazılmış küçük bir komut satırı aracıdır. `/tmp` içindeki eski dosyaları, paket yöneticisi önbelleklerini (APT, DNF, YUM, Pacman) ve `/var/log` altındaki döndürülmüş log arşivlerini temizler. İsteğe bağlı olarak Docker ve NPM önbelleğini de temizleyebilir. Hiçbir şeyi silmeden önce `--dry-run` ile ne silineceğini görebilirsiniz. Proje beta aşamasındadır: derlenir ve çalışır, ancak otomatik testleri henüz yoktur.

## Features

- **Dry-run mode** — `--dry-run` / `-n` lists what would be deleted and the estimated space, without deleting anything.
- **Single binary** — a compiled Rust program, no runtime to install.
- **Scans**:
  - `/tmp` files older than the age threshold (`--days`, default 7).
  - Package manager caches: APT (`.deb`), DNF and YUM (`.rpm`), Pacman (`.pkg.tar.zst`, `.pkg.tar.xz`).
  - Rotated log files under `/var/log` older than the age threshold.
  - Docker: with `--docker` it runs `docker system prune -a --volumes -f`. In dry-run mode it only prints that command.
  - NPM: with `--npm` it removes the files under `~/.npm/_cacache`.

Run it with `--dry-run` first. Without it, matching files are deleted, and `--docker` removes unused images, containers and volumes.

---

## Installation

### From source (Rust toolchain required)
```bash
cargo install --git https://github.com/Ankara-Software/linux-soft-cleaner
```

### Install script (Linux and macOS)
Downloads the latest release binary for your platform into `/usr/local/bin`, or `~/.local/bin` if that is not writable:
```bash
curl -fsSL https://raw.githubusercontent.com/Ankara-Software/linux-soft-cleaner/master/install.sh | sh
```

### Release binaries
Download the binary for your platform from the [latest release](https://github.com/Ankara-Software/linux-soft-cleaner/releases/latest): `linux-soft-cleaner-linux-x64`, `linux-soft-cleaner-linux-arm64`, `linux-soft-cleaner-darwin-x64`, `linux-soft-cleaner-darwin-arm64`.

The package is not published on crates.io or npm. The `bin/cli.js` wrapper in this repository downloads the release binary and is not available through `npx` yet.

---

## Usage

```bash
# Preview what would be cleaned
linux-soft-cleaner --dry-run

# Run the cleanup (usually needs root for /var/cache and /var/log)
sudo linux-soft-cleaner

# Use a 30 day threshold and include Docker and NPM caches
sudo linux-soft-cleaner --days 30 --docker --npm
```

## Command Line Options

```
Usage: linux-soft-cleaner [OPTIONS]

Options:
  -n, --dry-run      Run in dry-run mode (preview changes, no files will be deleted)
  -d, --days <DAYS>  Threshold in days for temporary files and logs [default: 7]
      --docker       Also clean Docker system caches (containers, images, volumes)
      --npm          Also clean global NPM cache
  -h, --help         Print help
  -V, --version      Print version
```

## Development

```bash
cargo build
cargo test
```

See [CONTRIBUTING.md](CONTRIBUTING.md), [SECURITY.md](SECURITY.md) and [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## License

MIT. Copyright (c) 2026 Anılcan Kara and Ankara Yazılım contributors.
