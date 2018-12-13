#!/bin/bash
GOOGLE_DRIVE_SETTINGS=~/.config/duplicity/credentials duplicity \
	remove-older-than 2M --force \
	gdocs://shaqman2004@gmail.com/linux-home-backup

GOOGLE_DRIVE_SETTINGS=~/.config/duplicity/credentials duplicity \
	--exclude-filelist ~/.config/duplicity/ignore \
	--no-encryption \
	--progress \
	--full-if-older-than 1M \
	$HOME gdocs://[account]/[path]
