raw_ram_total() {
   echo $(grep -o -E "MemTotal:\s+[0-9]+" /proc/meminfo | grep -o -E "[0-9]+")
}

raw_ram_available() {
   echo $(grep -o -E "MemAvailable:\s+[0-9]+" /proc/meminfo | grep -o -E "[0-9]+")
}

get_ram_readable() {
  ramused=0
  base=''
  humanRAM=''
  ramused=$(echo $(($(raw_ram_total) - $(raw_ram_available))))
  declare -a suffixes=('B' 'K' 'M' 'G' 'T')
  size=$ramused
  remainder=""
  index=1
  while [ $(($size/102)) -gt 1 ]; do
    remainder=".$(( $size % 1024))"
    size=$(( size/1024 ))
    index=$(( index + 1 ))
  done

  suffix="${suffixes[$index]}"
  cut_remainder=$(printf "%0.2f" $remainder | cut -c 2-)
  echo "$size$cut_remainder$suffix"
}

main() {
  get_ram_readable
}

main

