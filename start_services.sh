#!/bin/bash
set -e

if pgrep -x dbus-daemon > /dev/null || pgrep -x dbus-broker > /dev/null; then
    echo "[+] DBus already running"
else
    echo "[+] Starting DBus..."
    service dbus start || true
fi

if pgrep -x polkitd > /dev/null; then
    echo "[+] polkit already running"
else
    echo "[+] Starting polkit..."
    service polkit start || systemctl start polkit || true
fi

if pgrep -x pcscd > /dev/null; then
    echo "[+] pcscd already running"
else
    echo "[+] Starting pcscd..."
    service pcscd start || systemctl start pcscd || true
fi

echo "[+] Checking services..."
ps aux | grep -E "dbus|polkit|pcscd" || true


