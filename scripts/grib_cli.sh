#!/bin/bash
if [ $# -lt 3 ]; then
	echo 1>&2 "Too few arguments. Usage: grib_cli.sh [band_number] [input_folder] [output_prefix]"
elif [ $# -gt 3 ]; then
	echo 1>&2 "Too many arguments. Usage: grib_cli.sh [band_number] [input_folder] [output_prefix]"
elif [ $# -eq 3 ]; then

if [ $1 -lt 1 ]; then
        echo 1>&2 "band number must be between 1 and 588"
elif [ $1 -gt 588 ]; then
	echo 1>&2 "band number must be between 1 and 588"
else

for i in $(ls $2); 
do 
  if [[ "$i" == *"pgrb2"* ]] && [[ "$i" != *".f000"* ]]; then 
  gdal_translate $2/$i -b $1 $3/${i:21:3}_tmp_${1}.grb2 && gdalwarp -s_srs "+proj=longlat +ellps=WGS84" -t_srs WGS84 -te -180 -90 180 90  $3/${i:21:3}_tmp_${1}.grb2 $3/${i:21:3}_resampled_${1}.grb2 -wo SOURCE_EXTRA=1000
  rm $3/${i:21:3}_tmp_${1}.grb2
  fi
done
fi
fi
