#!/bin/bash

read -p "Win or Linux? [win/linux]" sysname

if [ "$sysname" = "linux" ]; then
	ln -s ./.emacs.d/ ~/.config/emacs
elif [ "$sysname" = "win" ]; then
	cp ./.emacs.d/ ~/
else
	echo "Do Nothing."
fi
