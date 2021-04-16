for entry in "$1"/*
do
  time ./count-single-remote.sh $entry
done