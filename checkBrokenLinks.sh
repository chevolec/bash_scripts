#!/bin/bash

SORTED_LIST=./urls.lst
BOOKMARKS=./bookmarks.html
toDEL=./del.lst
> $toDEL

while read XX
do
    log=$(wget --tries=1 -T 5 --spider -nv $XX 2>&1)
    if [[ $(echo $log | grep -c "broken link") -gt 0 ]]; then
        echo "$log"
        echo "$XX" >> $toDEL
        # sed -n "s|$XX|&|p" $BOOKMARKS
        sed -i "s|^.*$XX.*$||g" $BOOKMARKS
    fi
done < $SORTED_LIST
