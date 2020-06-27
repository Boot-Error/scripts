#!/bin/bash
WALLPAPERDIR="$HOME/Pictures/4chan_imgs/"

qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var allDesktops = desktops();

print (allDesktops);for (i=0;i<allDesktops.length;i++) {
d = allDesktops[i];d.wallpaperPlugin = "org.kde.slideshow";
d.currentConfigGroup = Array("Wallpaper", "org.kde.slideshow", "General");
d.writeConfig("SlidePaths", "'${WALLPAPERDIR}'")}'
