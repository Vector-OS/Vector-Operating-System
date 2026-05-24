# Vectos Live Build Workspace

This folder is the Debian live-build workspace for Vectos OS.

## Host requirements

Build this on Linux, not inside the kernel tree.
If you are using WSL, keep the workspace on the Linux filesystem such as `/home/<user>/vectos-live-build`; building from `/mnt/d` or other Windows-mounted paths will fail during debootstrap.

```sh
sudo apt update
sudo apt install live-build debootstrap squashfs-tools xorriso calamares
```

## Build flow

```sh
cd vectos-live-build
./build.sh
```

The output ISO is expected at `build/live-image-amd64.hybrid.iso`.

## What this workspace includes

- Default package selection
- Hostname and identity branding
- Calamares installer settings
- Shared dragon logo asset for wallpaper, login, and boot splash
- The same image is copied in as `vectos-logo.jpeg` during build
- A build script that wraps `lb build`
