#!/bin/bash
set -e

echo "[+] Showing DBus..."
service dbus status || true

echo "[+] Showing polkit..."
service polkit status || systemctl status polkit || true

echo "[+] Showing pcscd..."
service pcscd status || systemctl status pcscd || true

echo "[+] Checking services..."
ps aux | grep -E "dbus|polkit|pcscd" || true

