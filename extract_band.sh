#!/bin/bash
if [ $# -lt 1 ]; then
	echo 1>&2 "$0: use band number"
elif [ $# -gt 1 ]; then
	echo 1>&2 "$0: Too many arguments."
elif [ $# -eq 1 ]; then

echo $1

if [ $1 -lt 1 ]; then
        echo 1>&2 "band number must be between 1 and 588"
elif [ $1 -gt 588 ]; then
	echo 1>&2 "band number must be between 1 and 588"
else

for i in $(ls); 
do 
  if [[ "$i" == *"pgrb2"* ]]; then 
  gdal_translate $i -b $1 ${i:22:2}_tmp.tif && gdalwarp -s_srs "+proj=longlat +ellps=WGS84" -t_srs WGS84 -te -180 -90 180 90  ${i:22:2}_tmp.tif ${i:22:2}_tmp_resampled.tif -wo SOURCE_EXTRA=1000
  fi
done
fi
fi
