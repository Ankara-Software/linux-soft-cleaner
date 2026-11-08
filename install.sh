#!/bin/sh
set -e

REPO="Ankara-Software/linux-soft-cleaner"
NAME="linux-soft-cleaner"

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$OS" in
  linux) OS_KEY="linux" ;;
  darwin) OS_KEY="darwin" ;;
  *)
    echo "Error: Unsupported operating system: $OS"
    exit 1
    ;;
esac

case "$ARCH" in
  x86_64|amd64) ARCH_KEY="x64" ;;
  aarch64|arm64) ARCH_KEY="arm64" ;;
  *)
    echo "Error: Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

URL="https://github.com/$REPO/releases/latest/download/$NAME-$OS_KEY-$ARCH_KEY"
TEMP_DIR=$(mktemp -d)
echo "Downloading $URL"
curl -fL "$URL" -o "$TEMP_DIR/$NAME"

INSTALL_DIR="/usr/local/bin"
if [ ! -w "$INSTALL_DIR" ]; then
  INSTALL_DIR="$HOME/.local/bin"
  mkdir -p "$INSTALL_DIR"
fi

mv "$TEMP_DIR/$NAME" "$INSTALL_DIR/$NAME"
chmod +x "$INSTALL_DIR/$NAME"
rm -rf "$TEMP_DIR"

echo "Installed $NAME to $INSTALL_DIR/$NAME"
if [ "$INSTALL_DIR" = "$HOME/.local/bin" ]; then
  echo "Make sure $HOME/.local/bin is in your PATH."
fi
