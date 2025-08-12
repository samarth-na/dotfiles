function findpath --description 'find the last saved file in ~/projects and run it '
    
    set path = fd --type f -0 . ~/projects | xargs -0 stat --format='%Y %n' 2>/dev/null | awk -v threshold=$(date +%s --date="10 minutes ago") '$1 > threshold {print $2; exit}'
    
    echo $path
end 

