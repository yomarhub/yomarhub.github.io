
if [[ $# -eq 0 ]] ; then
    echo 'No arguments provided'
    $0 -h
    exit 1
elif [[ $1 == "-h" || $1 == "--help" ]] ; then
    echo "Usage: $0 FILE_TO_APPEND IFRAME_STRING..."
    echo
    echo "This script prints its arguments."
    echo
    echo "Example:"
    echo "  $0 \"file.yml\" "\''<iframe width="1840" height="1035" src="https://www.youtube.com/embed/g0zMk5Uw-XU?list=PLOGTuf9Pxm6546DE5511DL_Qg1JDJe3iV" title="articy:draft Importer for Unreal - Tutorial Lesson 3" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'\'
    exit 0
elif [[ $1 == "-v" || $1 == "--version" ]] ; then
    echo "$0 version 1.0.0"
    exit 0
elif [[ $# -lt 2 ]] ; then
    echo 'At least two arguments are required'
    $0 -h
    exit 1
fi

script=$(cat <<-END
let arg = process.argv.slice(2);

if (arg.length > 0) {
    arg = arg.join(' ');
    let r = arg.match(/src=(?<src>".+?") title=(?<title>".+?")/)?.groups;
    console.log(\`\n- src: \${r.src}\n  title: \${r.title}\`);
}
END
)

# echo
# echo "$script"
# echo
# node test.js ${@:2} | tee -a $1
node -e "$script" ${@:2} | tee -a $1