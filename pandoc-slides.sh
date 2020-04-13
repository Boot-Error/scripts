#!/bin/bash

if [[ -z $1 ]]; then
	echo "Usage: $0 <file.md>"
	exit 1
fi

OUTPUT="$(dirname $1)/$(basename $1 .md)"

echo $1
echo $2

if [ $2 == "pdf" ]; then

	echo "Generating pdf output!"

	/usr/bin/pandoc "$1" -s -o "$OUTPUT.pdf" \
		-t beamer \
		--slide-level 2 \
		--lua-filter ~/Scripts/pandoc/diagram-generator.lua \
		--mathjax

else

	/usr/bin/pandoc "$1" -s -o "$OUTPUT.html" \
		-t revealjs \
		-V theme=black \
		-V revealjs-url=https://revealjs.com \
		--slide-level 2 \
		--lua-filter ~/Scripts/pandoc/diagram-generator.lua \
		--mathjax

fi
