#!/usr/bin/env bash
set -euo pipefail

# Require root privileges for live-build operations
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Re-run with: sudo ./build.sh"
  exit 1
fi

if ! command -v lb >/dev/null 2>&1; then
  echo "live-build is required. Install it with: sudo apt install live-build debootstrap squashfs-tools xorriso"
  exit 1
fi

if grep -qi microsoft /proc/version 2>/dev/null && pwd -P | grep -Eq '^/mnt/[a-z]/'; then
  echo "This workspace is on a Windows-mounted filesystem. live-build and debootstrap fail there because Debian packages contain case-colliding paths."
  echo "Copy vectos-live-build to the WSL Linux filesystem (for example /home/$USER/vectos-live-build) and run ./build.sh from that copy."
  exit 1
fi

if [ ! -d config ]; then
  if [ -x ./auto/config ]; then
    ./auto/config
  else
    echo "Missing config/. Run this from the vectos-live-build workspace."
    exit 1
  fi
fi

chmod +x ./auto/config 2>/dev/null || true
chmod +x ./config/hooks/live/*.hook.chroot 2>/dev/null || true
chmod +x ./config/includes.chroot/usr/local/bin/vectos-ai 2>/dev/null || true
chmod +x ./config/includes.chroot/usr/local/bin/vectos-welcome 2>/dev/null || true

mkdir -p ./config/includes.chroot/usr/share/backgrounds/vectos
mkdir -p ./config/includes.chroot/usr/share/plymouth/themes/vectos

if [ -f "../public/image/logo/Vector OS new Logo.jpeg" ]; then
  cp "../public/image/logo/Vector OS new Logo.jpeg" ./config/includes.chroot/usr/share/backgrounds/vectos/vectos-logo.jpeg
  cp "../public/image/logo/Vector OS new Logo.jpeg" ./config/includes.chroot/usr/share/plymouth/themes/vectos/vectos-logo.jpeg
fi

# Start from a clean live-build state to avoid stale config / recursive auto-config behavior.
lb clean --purge

AUTO_CONFIG_DISABLED=""
if [ -x ./auto/config ]; then
  AUTO_CONFIG_DISABLED="./auto/config.disabled"
  mv ./auto/config "${AUTO_CONFIG_DISABLED}"
  trap 'mv -f "${AUTO_CONFIG_DISABLED}" ./auto/config 2>/dev/null || true' EXIT
fi

lb build

if [ -n "${AUTO_CONFIG_DISABLED}" ] && [ -e "${AUTO_CONFIG_DISABLED}" ]; then
  mv -f "${AUTO_CONFIG_DISABLED}" ./auto/config
fi

trap - EXIT

if [ -f build/live-image-amd64.hybrid.iso ]; then
  cp build/live-image-amd64.hybrid.iso build/vectos-os-amd64.hybrid.iso
fi
