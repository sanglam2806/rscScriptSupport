#!/bin/bash

echo "Hello word!"

# Search_file=$(find ./ -type f -exec grep -h "AAAAA" {txt} \;)
search_txt=$(find ../../1 -name 'test.txt' -exec grep -h "AAAAA" {} \;)

echo -n "Enter creation date = "
read creationDate
test_array=(1 2 3 4)
test_array+=(5)
echo "${test_array[@]}"
echo ${creationDate}

while read p; do
    find ../../1 -regex '^.*'"${creationDate}"'.log*$' -exec grep -h ${p} {} \;
done < ../../data.txt

echo "${search_txt}"