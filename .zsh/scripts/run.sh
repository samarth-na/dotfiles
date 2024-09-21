#!/bin/bash

#-----...read the comments if you want to understand what is going on...-----

#
rawInput=$(find ~/projects -type f -mmin -100 -exec ls -lt --time-style=+"%Y-%m-%d %T" {} + | sort -k6,7 | tail -n 1);
# find the last find saved file and saves that as raw input
# output comes something like this:- [-rw-r--r--. 1 samna samna 531 2023-12-19 00:06:16 /home/samna/projects/javascript/jsbasics/arrays.js]
#
time=$(date +"%Y-%m-%d %T")
# current time
#
#
input=$(echo "$rawInput" | awk '{print $8}')
inputwithoutextension="${input%.*}"
# takes that raw input and extract path 
# looks like this:-[/home/samna/projects/javascript/jsbasics/arrays.js]  
#
#
extension="${input##*.}"
#this extracts the extention of file :- [js]
#
file="${input##*/}"
#this extracts the name of file :- [arrays.js]
#
filename="${file%.*}"
#an switch statement for choosing the language and running the respective command
#


case "$extension" in
    "py")
        python $input
        ;;
    "go")
        go run $input
        ;;
    "js" | "ts")
        bun run $input
        ;;
    "c" | "c++" | "cpp")
        g++ $input && ./a.out
        ;;
    "out" )
        ./a.out
        ;;
    "java")
        java $input 
        ;;
    "lua" )
        lua $input
        ;;
    "sh" )
        bash $input
        ;;
    "rs" )
        rustc $input && ./$filename
        ;;
    *)
        echo "Unsupported file type"
        echo  -e "\n$file"

        ;;
esac

echo  -e "\n--- ---"
echo  -e "\n$file "
