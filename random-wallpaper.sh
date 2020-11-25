#!/bin/bash
#Author: Dokthoror
#Version: 1.0
#Required: gnome environment
#Use: ./random-wallpaper.sh <pictures directory: required> <delay in seconds: optional>
#Repo: https://github.com/Dokthoror/Random-wallpapers


RANDOM_DIR='.random-wallpapers'     # Used to save pictures with custom names


if [[ $1 == '--help' || $1 == '-h' ]]     # Shows help
then
    echo '=== HELP ==='
    echo 'What is this command :'
    echo 'This command sets randomly your desktop wallpaper with picture from the directory you give in argument. You can change the delay of the wallpaper changement in argument too.'
    echo 'How to use it :'
    echo "$0 <pictures directory: required> <delay in seconds: optional>"
    exit 0
fi


# Sends error if a directory is not given
image_dir=${1:?'You must add a directory in first argument'}
[[ ! -d $image_dir ]] && echo 'You must add a directory in first argument' && exit 1

[[ $(echo $image_dir | grep '/$') ]] && image_dir=${image_dir::-1}  # Delete final slash of directory if there is one

# If delay not specified, sets it to 60 seconds
delay=${2:-60}


# Create custom directory for picture in the given directory
mkdir $image_dir/$RANDOM_DIR > /dev/null 2>&1
[[ $? != 0 && $? != 1 ]] && echo "Unable to create $image_dir/$RANDOM_DIR" && exit 2


# Process to count the number of pictures in the directory and copy them
count=0
for file in $(ls $image_dir)                                                    # For each file of the directory
do                                                                              #
	extension=$(echo $file | rev | cut -d '.' -f 1 | rev)                       #
    if [[ $extension == 'jpg' || $extension == 'jpeg' || $extension == 'png' ]] # tests if the extension of a file is an image or not
    then                                                                        #
        ((count++))                                                             # if it's a picture, add 1 to the count variable
	    cp "$image_dir/$file" "$image_dir/$RANDOM_DIR/$count.$extension"        # and copy the picture with the name '1.jpg' is the concerned picture is a jpg and the number one
    fi
done

[[ $count < 2 ]] && echo "Can't set random wallpapers with less than two pictures" && exit 3    # If there is less than two pictures, it's not random


while [[ true ]]
do
    image_number=$(($RANDOM % $count))
    [[ -f "$image_dir/$RANDOM_DIR/$image_number.jpg" ]] && image_background="$image_dir/$RANDOM_DIR/$image_number.jpg"      # Add jpg extension if the picture is a jpg
    [[ -f "$image_dir/$RANDOM_DIR/$image_number.jpeg" ]] && image_background="$image_dir/$RANDOM_DIR/$image_number.jpeg"    # Add jepg extension if the picture is a jpeg
    [[ -f "$image_dir/$RANDOM_DIR/$image_number.png" ]] && image_background="$image_dir/$RANDOM_DIR/$image_number.png"      # Add png extension if the picture is a png
    gsettings set org.gnome.desktop.background picture-uri "$image_background"                                              # Sets wallpaper
    echo "Set wallpaper to $image_background"
    sleep $delay
done


exit 0