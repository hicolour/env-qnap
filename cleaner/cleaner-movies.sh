#!/bin/bash

in="/share/Download/transmission/completed" 
out="/share/Movies/movies-new"

FILE_TYPES="-name \"*.mkv\" -o -name \"*.avi\" "

#  for file in $(/opt/bin/find -L . \( ${FILE_TYPES} \))


search(){
  dir=$1
  type=$2
  echo "Find in "$dir  
  for file in $(find $dir -type f $type)
  do

    echo File: $file

  done
}
echo init
search $in $FILE_TYPES