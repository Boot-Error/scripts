#!/bin/bash

BOARD=$1

OUTDIR=~/Pictures/4chan_imgs

DOWNLOADER=wget
DOWNLOADER_OPTS=-O

JSON_DATA=curl $API_URL
API_URL=https://a.4cdn.org
IMG_URL=https://i.4cdn.org

function get_all_threads() {

	THREAD_IDS=`curl -s $API_URL/$BOARD/threads.json | jq -r '.[].threads[].no'`

}

function get_images_from_thread() {
	
	THREAD_ID=$1
	IMAGES=`curl -s $API_URL/$BOARD/thread/$THREAD_ID.json | jq -r '(.posts[].tim | tostring)+.posts[].ext'`
}

function download_images() {
	
	for img in $IMAGES; do

		FILENAME=$BOARD_$img
		URL=$IMG_URL/$BOARD/$FILENAME
		$DOWNLOADER $DOWNLOADER_OPTS $OUTDIR/$FILENAME $URL 
		
		echo "Image $URL downloaded.."

	done
}

function save_urls() {

	for img in $IMAGES; do
		URL=$IMG_URL/$BOARD/$img
		echo $URL >> $OUTDIR/urls.txt

	done

}

echo "Fetching threads from $BOARD"
get_all_threads

echo "Fetching images from threads in $BOARD"
for thread in $THREAD_IDS; do
	get_images_from_thread $thread
	echo "Downloading images from thread $thread in $BOARD"
	save_urls
done

aria2c -x 5 -i $OUTDIR/urls.txt

