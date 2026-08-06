<div align="center">

<h1>linux-soft-cleaner</h1>

<p><strong>A fast, safe, and minimal disk cleanup tool for Linux servers — written in Rust.</strong></p>

[![Crates.io](https://img.shields.io/crates/v/linux-soft-cleaner?style=flat-square&color=fc8d62)](https://crates.io/crates/linux-soft-cleaner)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](LICENSE)
[![Build](https://img.shields.io/github/actions/workflow/status/anilcan-kara/linux-soft-cleaner/release.yml?style=flat-square)](https://github.com/anilcan-kara/linux-soft-cleaner/actions)
[![GitHub Release](https://img.shields.io/github/v/release/anilcan-kara/linux-soft-cleaner?style=flat-square&color=8be04e)](https://github.com/anilcan-kara/linux-soft-cleaner/releases)

```bash
linux-soft-cleaner --dry-run --days 7
```

</div>

---

## What It Does

`linux-soft-cleaner` safely removes stale files that accumulate on Linux servers over time: temp files, old logs, package manager caches, and optionally Docker and npm artifacts.

It's designed for **server environments** where you want safe, predictable cleanup without the risk of a shell script going wrong.

---

## What Gets Cleaned

| Category | Path(s) | Condition |
|---|---|---|
| 🗂️ Temp files | `/tmp/*`, `/var/tmp/*` | Older than `--days` |
| 📋 System logs | `/var/log/**/*.log`, `*.log.*` | Older than `--days` |
| 📦 APT cache | `/var/cache/apt/archives/*.deb` | Always |
| 📦 YUM/DNF cache | `/var/cache/yum/`, `/var/cache/dnf/` | Always |
| 🐳 Docker system | Stopped containers, dangling images, unused volumes | `--docker` flag |
| 📦 NPM cache | `~/.npm/_cacache/` | `--npm` flag |

---

## Features

- 🛡️ **Safe by default** — preview every deletion before it happens with `--dry-run`
- ⏱️ **Age-based** — only removes files older than `--days` (default: 7 days)
- 🐳 **Docker aware** — optional Docker system prune with `--docker`
- 📦 **NPM cache** — optional npm cache clean with `--npm`
- 📊 **Space report** — shows total bytes freed after each run
- 🎨 **Colored output** — clear progress spinner and file-by-file reporting
- ⚡ **Fast** — parallel directory scanning, single static binary

---

## Usage

### Dry run — preview what would be deleted
```bash
linux-soft-cleaner --dry-run
```

### Clean files older than 7 days (default)
```bash
sudo linux-soft-cleaner
```

### Full cleanup: temp + logs + APT + Docker + NPM
```bash
sudo linux-soft-cleaner --docker --npm
```

---

## CLI Reference

```
linux-soft-cleaner [OPTIONS]

Options:
  -d, --dry-run          Preview changes — no files will be deleted
      --days <DAYS>      Age threshold in days [default: 7]
      --docker           Also prune Docker system (containers, images, volumes)
      --npm              Also clean global NPM cache
  -h, --help             Print help
  -V, --version          Print version
```

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). All PRs welcome.

---

## License

MIT © [Anilcan Kara](https://github.com/anilcan-kara)
