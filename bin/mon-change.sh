#!/bin/sh

case ${MONS_NUMBER} in
	"1")
		mons -o
		echo "Xft.dpi: 235" | xrdb -merge
		i3-msg restart
		echo "st" > /home/sawyer/bin/term
		;;
	"2")	
		mons -s
		echo "Xft.dpi: 165" | xrdb -merge
		i3-msg restart
		echo "st-small" > /home/sawyer/bin/term
		;;
	*)
		;;
esac
