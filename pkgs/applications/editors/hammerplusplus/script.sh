#!/usr/bin/env bash
set -e

OUT="@out@"
PATH="@path@:$PATH"
PKGBIN="$OUT/share/lib/hammerplusplus/hammerplusplus.exe"
ARCH="${WINEARCH:-@wineArch@}"

export WINEDEBUG="-all"

if [ ! -d "$WINEPREFIX" ]; then
    echo "Please set WINEPREFIX to an existing Source installation."
    exit
fi

if [ -z "$ARCH" ]; then
    echo "ARCH is not set. Cannot determine Wine architecture."
    exit 1
fi

if [ "$ARCH" = "win64" ]; then
    wine64 "$PKGBIN" "$@"
else
    wine "$PKGBIN" "$@"
fi
