#!/bin/bash

BOARD=$1

API_URL=https://a.4cdn.org/$BOARD/thread/$THREAD_ID.json

function get_all_urls() {

	JSON_DATA=curl $API_URL

}
