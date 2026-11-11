sort_size() {


for file in *.txt
do 
    if [ -f "$file" ]; then
        size=$(wc -c < "$file")
        echo $size $file
    fi
done | sort -n
}

sort_size
