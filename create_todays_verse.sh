today=$(date -u +%Y-%m-%d)
grep -hr $today plans/* | while read -r p; do
    date=$(echo $p | cut -d "," -f 1 | sed 's/"//g')
    verses=$(echo $p | cut -d "," -f 2 | sed 's/"//g')
    info=$(echo $p | cut -d "," -f 3 | sed 's/"//g')
    OLDIFS=$IFS
    IFS=";"
    read -ra parts <<< "$verses"
    IFS=$OLDIFS
    for verse in "${parts[@]}"; do
        versepath=$(echo $verse | sed  's/ //'| sed  's/ /_/g')
        hugo new $versepath.md
        echo \# $verse >> content/$versepath.md
	echo $info  >> content/$versepath.md
	echo "- SOLI DEO GLORIA" >> content/$versepath.md
    done
done
