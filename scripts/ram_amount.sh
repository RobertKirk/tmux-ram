#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_ram_amount() {
  ramused=0
  base=''
  humanRAM=''
  size=`echo $(($(raw_ram_total) - $(raw_ram_available)))`
  declare -a suffixes=('B' 'K' 'M' 'G' 'T')
  remainder=''
  index=1
  while [ $(($size/102)) -gt 1 ]; do
    remainder=`.$(( $size % 1024))`
    size=$(( $size / 1024 ))
    index=$(( $index + 1 ))
  done

  suffix=`${suffixes[$index]}`
  cut_remainder=`printf "%0.2f" $remainder | cut -c 2-`
  # echo "$size$cut_remainder$suffix"
  iostat -c 1 2 | sed '/^\s*$/d' | tail -n 1 | awk '{usage=100-$NF} END {printf("%5.1f%%", usage)}' | sed 's/,/./'
}

main() {
  print_ram_amount
}
main
