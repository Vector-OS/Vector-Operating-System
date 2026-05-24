# Vectos OS Bootable UI Guide

This repository currently holds the Linux kernel source tree used by Vectos OS. The installable live system, visual branding, and installer live in a separate Debian live-build workspace.

The workspace added in this repository is [vectos-live-build](vectos-live-build), which contains the starting package lists, identity files, and build wrapper.

## Quick Start

```text
Base system      Debian Live
Build tools      live-build, debootstrap, squashfs-tools, xorriso
Output ISO       live-image-amd64.hybrid.iso
USB writer       Rufus on Windows or dd on Linux
```

## Phase 1: Base system setup

1. Pick the base.
   - Recommended: Debian Live
   - Alternatives: Kali base or Ubuntu minimal
2. Install build tools on the host.

```sh
sudo apt update
sudo apt install live-build debootstrap squashfs-tools xorriso
```

3. Create a build workspace.

```sh
mkdir vectos-os
cd vectos-os
```

4. Initialize the live-build tree.

```sh
lb config
```

## Phase 2: Customize the OS

This is the UI layer for Vectos OS. It defines how the live system looks and feels before the user installs anything.

5. Add default packages in `config/package-lists/vectos.list.chroot`.

```text
git
nodejs
npm
python3
nmap
wireshark
steam
lutris
libreoffice
firefox
code
```

6. Set the hostname in `config/includes.chroot/etc/hostname`.

```text
vectos
```

7. Replace OS identity across the live image.
   - `/etc/os-release` should say VectOS OS
   - GRUB menu text should show VectOS OS
   - Login screen should use the VectOS logo
   - Desktop wallpaper should use Vectos branding
   - Boot splash should use a matching theme

8. Add the visible OS UI components.
   - Desktop wallpaper using the shared dragon logo
   - Lock screen art using the shared dragon logo
   - Login background using the shared dragon logo
   - Cursor and icon theme
   - Window theme and accent colors

9. Keep the interface simple and bootable.
   - One clean launcher row
   - Clear system branding
   - Installer entry point visible on first boot

## Phase 3: Calamares installer

10. Install Calamares on the build host or in the installer image, depending on your packaging model.

```sh
sudo apt install calamares
```

11. Add Vectos-specific modules.
   - Category selection: Gaming, Dev, Security
   - AI suggestion engine
   - Package installer module

12. Configure Calamares in `/etc/calamares/settings.conf` or the live-image equivalent.

```yaml
modules:
  - welcome
  - locale
  - keyboard
  - partition
  - users
  - vectos-select
  - vectos-ai
  - vectos-install
  - finished
```

## Phase 4: Build the ISO

13. Build the live image.

```sh
sudo lb build
```

14. Rename the output ISO if desired.

```sh
mv live-image-amd64.hybrid.iso vectos-os.iso
```

## Phase 5: Test in a VM

15. Boot the ISO in VirtualBox or VMware.
16. Verify the live desktop, installer flow, and package installation.
17. Fix issues from logs before shipping.
   - Missing package: update the package list
   - Installer error: inspect Calamares logs
   - Boot failure: check GRUB and image generation

## Phase 6: Make it bootable

18. Write the ISO to a USB drive on Linux.

```sh
sudo dd if=vectos-os.iso of=/dev/sdX bs=4M status=progress
```

19. Use Rufus on Windows.
20. Boot from the USB and confirm:
   - The live desktop loads
   - Calamares opens correctly
   - Branding shows Vectos OS everywhere
   - Package selection works

## Phase 7: Share the release

21. Publish the ISO.
   - GitHub Releases
   - Google Drive
   - Mega
   - Torrent for advanced distribution

## What the finished system includes

- Debian-based Linux kernel and userspace
- Calamares installer with Vectos modules
- AI-assisted package suggestions
- APT-based package selection
- Vectos branding across the live system
- A clear bootable UI from first boot to installation

## Next implementation step

Create a separate Debian live-build repository or top-level workspace for the live image, then link this kernel tree into that build as the kernel payload.

For this repository, the immediate build entrypoint is [vectos-live-build/build.sh](vectos-live-build/build.sh).

The generated ISO name is [vectos-live-build/build/vectos-os-amd64.hybrid.iso](vectos-live-build/build/vectos-os-amd64.hybrid.iso).
