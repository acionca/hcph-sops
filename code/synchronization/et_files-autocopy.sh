#!/bin/bash

# Specify the full path to the source directory in the line below (keep the last "/").
source_d=""

# Specify the fullpath to the first destination directory in the line below (keep the last "/").
dest_d=""

if [ "$source_d" = "" ]
then
    echo "Please, specify the directory to watch:"
    read source_d
fi

if [ "$dest_d" = "" ]
then
    echo "Please, specify the directory to copy to:"
    read dest_d
fi

echo "All incoming files to ${source_d} will be copied to ${dest_d}"

inotifywait -m -q -e close_write "$source_d" |

while read -r path action file
do
    echo "$file has been modified ! Copying changes ..."
    cp -- "$path$file" "$dest_d$file"
done
