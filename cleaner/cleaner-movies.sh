#!/bin/bash

dir_in=$1
out=$2

FILE_TYPES="-name *.mkv -o -name *.avi"


#find $dir_in  -name "*.mkv" -exec echo {}


grep="/opt/bin/grep"
sed="/opt/bin/sed"

#!/bin/bash
#shopt -s globstar
shopt -s nullglob
for file in $dir_in/**/*.{mkv,mp4,avi}
do
        echo "------------------"
        echo "$file"

        dirname=$(dirname "$file")
        filename=$(basename "$file")
        extension="${filename##*.}"
        filenamei2="${filename%.*}"

        date=$(echo $filename | $grep -Eo '(19|20)[0-9][0-9]')

        titledate=$(echo $filename | $grep -Eo '(([a-zA-Z]*)\.*)*((19|20)[0-9][0-9])')

        title=$(echo $titledate | $grep -Eo '(([a-zA-Z]*)\.*)*')

        echo "file: $filename"
        echo "ext: $extension"
        echo "dirname: $dirname"

        echo "date: $date"
        echo "titledate: $titledate"
        echo "title: $title"

        if [ -n "$date" ] && [ -n "$title" ];
        then
                echo "date!"
                ptitle=$(echo $title | sed 's/\.$//' | sed 's/ /*/g')
                echo $ptitle

                echo "Creating dir: $out/$date-$ptitle"
                mkdir $out/$date-$ptitle

                echo "Moving file: $file"
                mv "$file" $out/$date-$ptitle/

                if [[ $dir_in == *"$dirname"* ]]; then
                        echo "Removing file: $file"
                        rm "$file"
                else
                        echo "Removing dir: $dirname"
                        rm -rf "$dirname"
                fi

        fi

done
