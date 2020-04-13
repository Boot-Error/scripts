#!/bin/bash

BOARD=$1
THREAD_ID=$2

API_URL=https://a.4cdn.org/$BOARD/thread/$THREAD_ID.json

function get_all_urls() {

	JSON_DATA=curl -s $API_URL

}
