#!/bin/bash

FORCE="$1"
SYNTAX="$2"
EXTENSION="$3"
OUTPUTDIR="$4"
INPUT="$5"
CSSFILE="$6"

FILENAME="$(basename $INPUT .$EXTENSION)"
TOC="--toc"
TITLEMETA="-M title=$FILENAME"

if [[ $FILENAME == "index" ]]; then
	TOC=''
	TITLEMETA=''
fi

/usr/bin/pandoc "$INPUT" -o "$OUTPUTDIR/$FILENAME.html" \
	$TOC \
	$TITLEMETA \
	--mathjax \
	--include-in-header ~/Documents/notes.css \
	--lua-filter ~/dotfiles/scripts/pandoc/diagram-generator.lua \
	--lua-filter ~/dotfiles/scripts/pandoc/link_update.lua 
