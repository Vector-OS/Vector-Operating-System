# VectOS UI Pack

This folder contains the VectOS UI file pack: themes, XFCE panel config, dock settings, wallpapers, Plymouth theme, GRUB theme, Control Center app and AI widget stubs.

These files are a starting point — copy them into your live-build `config/includes.chroot` tree (or add a hook) to include them into the ISO. Example:

sudo cp -r vectos-ui /path/to/vectos-live-build/config/includes.chroot/usr/share/

Then update `update-grub`, `update-initramfs -u`, and ensure `plymouth` and `grub` packages are installed in the build chroot.

Files:
- themes/ - GTK theme
- xfce-panel/ - panel layout (rc.xml)
- dock/ - Plank settings
- wallpaper/ - wallpaper assets and list
- plymouth/ - plymouth theme files
- grub/ - grub theme files
- control-center/ - vectos-control-center app stub
- ai-widget/ - vectos-ai app stub

Adjust styles or assets, then include into the live image.
