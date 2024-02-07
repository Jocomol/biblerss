today=$(date -u +%Y-%m-%d)
grep -hr $today plans/* | while read -r p; do
    date=$(echo $p | cut -d "," -f 1 | sed 's/"//g')
    verses=$(echo $p | cut -d "," -f 2 | sed 's/"//g')
    echo $verses
    while read -r verse
    do
        echo $verse
        versepath=$(echo $verse | sed  's/ /_/g')
        hugo new $date-$versepath.md
        echo $verse >> content/$date-$versepath.md
    done < <(echo $verses | cut -f1 -d ";")
done
