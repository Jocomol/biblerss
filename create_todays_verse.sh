#!/bin/bash
today=$(date -u +%Y-%m-%d)
grep -hr $today bible-plans/* | while read -r p; do
    u=$(echo $p | sed 's/","/"_"/g')
    date=$(echo $u | cut -d "_" -f 1 | sed 's/"//g')
    verses=$(echo $u | cut -d "_" -f 2 | sed 's/"//g')
    OLDIFS=$IFS
    IFS=";"
    read -ra parts <<< "$verses"
    IFS=$OLDIFS
    for verse in "${parts[@]}"; do
	cverse=$(echo $verse | sed 's/,/:/g')
        versepath=$(echo $cverse | sed  's/ /_/g')
        hugo new $versepath.md
        echo \# $cverse >> content/$versepath.md
        echo $info  >> content/$versepath.md
        echo "- SOLI DEO GLORIA" >> content/$versepath.md
    done
done
