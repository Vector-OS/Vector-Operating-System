#!/usr/bin/env python3
"""
VectOS Control Center - GTK3 stub
"""
import gi
import subprocess
import shutil
import os

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class ControlCenter(Gtk.Window):
    def __init__(self):
        super().__init__(title="VectOS Control Center")
        self.set_default_size(700, 460)
        self.set_border_width(12)

        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=12)
        self.add(box)

        title = Gtk.Label(label="⚡ VECTOS CONTROL CENTER")
        title.set_name('cc-title')
        box.pack_start(title, False, False, 0)

        btn_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        box.pack_start(btn_box, False, False, 0)

        btn1 = Gtk.Button(label="System Info")
        btn1.connect("clicked", self.sys_info)
        btn_box.pack_start(btn1, False, False, 0)

        btn2 = Gtk.Button(label="Update System")
        btn2.connect("clicked", self.update_system)
        btn_box.pack_start(btn2, False, False, 0)

        btn3 = Gtk.Button(label="Open AI Assistant")
        btn3.connect("clicked", self.open_ai)
        btn_box.pack_start(btn3, False, False, 0)

        self.show_all()

    def sys_info(self, widget):
        # Open a terminal running neofetch if available
        term = shutil.which('x-terminal-emulator') or shutil.which('xterm') or shutil.which('gnome-terminal')
        if term:
            subprocess.Popen([term, '-e', 'neofetch || echo VectOS Control Center'])

    def update_system(self, widget):
        # Run apt update in a terminal
        term = shutil.which('x-terminal-emulator') or shutil.which('xterm') or shutil.which('gnome-terminal')
        if term:
            subprocess.Popen([term, '-e', 'bash -c "sudo apt update && sudo apt upgrade -y; echo; read -p \"Press Enter to close\""'])

    def open_ai(self, widget):
        ai = shutil.which('vectos-ai')
        if ai:
            subprocess.Popen([ai])

def main():
    win = ControlCenter()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == '__main__':
    main()
