# put this script into a folder with images
# and when you run it, it will return random
# image (actually, random file from that folder
# that is not directory or this script)

cd `dirname $0`

TOTAL=`ls | wc -l`

THIS=`basename "$0"`
FILE="$THIS"
# get name of random file, but only if it is normal
# file different from this script (suppose there are
# only images in the directory)
while [ "$FILE" = "$THIS" -o ! -f "$FILE" ]; do
	NUM=$[($RANDOM % $TOTAL) + 1]
	FILE="`ls | head -n $NUM | tail -n 1`"
done

# make the path absolute
readlink -f "$FILE"
