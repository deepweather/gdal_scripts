if [ $# -lt 3 ]; then
	echo 1>&2 "Too few arguments. Usage: grib_cli.sh [band_number] [input_folder] [output_prefix]"
elif [ $# -gt 3 ]; then
	echo 1>&2 "Too many arguments. Usage: grib_cli.sh [band_number] [input_folder] [output_prefix]"
elif [ $# -eq 3 ]; then

echo $1

if [ $1 -lt 1 ]; then
        echo 1>&2 "band number must be between 1 and 588"
elif [ $1 -gt 588 ]; then
	echo 1>&2 "band number must be between 1 and 588"
else

for i in $(ls -d $2); 
do 
  if [[ "$i" == *"pgrb2"* ]]; then 
  gdal_translate $i -b $1 ${i:end:-24}${i:22:2}_tmp.grib2 && gdalwarp -s_srs "+proj=longlat +ellps=WGS84" -t_srs WGS84 -te -180 -90 180 90  ${i:end:-24}${i:22:2}_tmp.grib2 ${i:end:-24}${i:22:2}_resampled.grib2 -wo SOURCE_EXTRA=1000
  rm ${i:end:-24}${i:22:2}_tmp.grib2
  fi
done
fi
fi
