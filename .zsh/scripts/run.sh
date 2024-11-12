#!/bin/bash

rawInput=$(find ~/projects -type f -mmin -100 -exec ls -lt --time-style=+"%Y-%m-%d %T" {} + | sort -k6,7 | tail -n 1);
# find the last find saved file and saves that as raw path
# output comes something like this:- [-rw-r--r--. 1 samna samna 531 2023-12-19 00:06:16 /home/samna/projects/javascript/jsbasics/arrays.js]

path=$(echo "$rawInput" | awk '{print $8}')

extension="${path##*.}"

file="${path##*/}"

filename="${file%.*}"

case "$extension" in
    "py")
        python "$path"
        ;;
    "go")
        go run "$path"
        ;;
    "js" | "ts")
        bun run "$path"
        ;;
    "c" | "c++" | "cpp")
        g++ "$path" && ./a.out
        ;;
    "out" )
        ./a.out
        ;;
    "java")
        java "$path" 
        ;;
    "lua" )
        lua "$path"
        ;;
    "sh" )
        bash "$path"
        ;;
    "rs" )
        rustc "$path" && ./"$filename"
        ;;
    *)
        echo "Unsupported file type"
        echo  -e "\n$file"

        ;;
esac

echo  -e "\n--- ---"
echo  -e "\n$file "
