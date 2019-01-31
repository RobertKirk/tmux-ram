get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value="$(tmux show-option -gqv "$option")"
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

# is second float bigger?
fcomp() {
  awk -v n1=$1 -v n2=$2 'BEGIN {if (n1<n2) exit 0; exit 1}'
}

raw_ram_total() {
  echo $(grep -o -E "MemTotal:\s+[0-9]+" /proc/meminfo | grep -o -E "[0-9]+")
}

raw_ram_available() {
  echo $(grep -o -E "MemAvailable:\s+[0-9]+" /proc/meminfo | grep -o -E "[0-9]+")
}

ram_percentage() {
  local ramused=$(echo $(($(raw_ram_total) - $(raw_ram_available))))
  echo $(($ramused * 100 / $raw_ram_total))
}

ram_load_status() {
  local percentage=$(echo $(ram_percentage))
  if fcomp 80 $percentage; then
    echo "high"
  elif fcomp 30 $percentage && fcomp $percentage 80; then 
    echo "medium"
  else
    echo "low"
  fi
}
