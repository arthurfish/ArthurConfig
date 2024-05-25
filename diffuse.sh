#!/bin/bash

read -p "Win or Linux? [win/linux]" sysname

if [ "$sysname" = "linux" ]; then
	cp -rf ./.emacs.d/ ~/.config/emacs
elif [ "$sysname" = "win" ]; then
	cp ./.emacs.d/ ~/
else
	echo "Do Nothing."
fi
