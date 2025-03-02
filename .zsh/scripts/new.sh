# Get the most recently modified file within the last 100 minutes
rawInput=$(stat --format="%n" -- "$(find ~/projects -type f -mmin -100 -print0 | xargs -0 stat --printf='%Y\t%n\n' | sort -n | tail -n1 | cut -f2-)")

fd --type f -0 . ~/projects | xargs -0 stat --format='%Y %n' 2>/dev/null | awk -v threshold=$(date +%s --date="10 minutes ago") '$1 > threshold {print $2; exit}'

# Extract file path, extension, and filename using parameter expansion
path="$rawInput"
file="${path##*/}"
extension="${file##*.}"
filename="${file%.*}"

# Execute the file based on its extension
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
    "c" | "cpp")
        g++ "$path" -o "${filename}.out" && ./"${filename}.out"
        ;;
    "out")
        ./"$path"
        ;;
    "java")
        javac "$path" && java "${filename}"
        ;;
    "lua")
        lua "$path"
        ;;
    "sh")
        bash "$path"
        ;;
    "rs")
        rustc "$path" -o "${filename}.out" && ./"${filename}.out"
        ;;
    *)
        echo "Unsupported file type: $file"
        ;;
esac

echo -e "\n--- ---"
echo -e "\n$file"
