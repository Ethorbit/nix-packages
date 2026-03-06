#!/usr/bin/env bash
set -e

OUT="@out@"
PATH="@path@:$PATH"
PKGBIN="$OUT/share/lib/hammerplusplus/hammerplusplus.exe"

export WINEDEBUG="-all"

if [ ! -d "$WINEPREFIX" ]; then
    echo "Please set WINEPREFIX to an existing Source installation."
    exit
fi

wine "$PKGBIN" "$@"
