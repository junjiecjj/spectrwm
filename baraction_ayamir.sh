#! /usr/bin/env bash
#########################################################################
# File Name: baraction_ayamir.sh
# Author:陈俊杰
# mail: 2716705056@qq.com
# Created Time: 2022年05月31日 星期二 20时20分44秒

# 此程序的功能是：
#########################################################################


# baraction.sh for spectrwm status bar

## DISK
hdd() {
  # hdd="$(df -h | awk 'NR==4{print $3, $5}')"
  # hdd=`df -h | awk 'NR==4{print $3, $5}')`
  hdd=`df -h | awk '/home/ {print $3, $2}'`
  echo -e "/home: $hdd"
}

hdd1() {
  # hdd="$(df -h | awk 'NR==4{print $3, $5}')"
  hdd=`df -h | awk 'NR==4{print $3, $2}'`
  # hdd=`df -h | awk '/home/ {print $3, $2}'`
  echo -e "/: $hdd"
}


## RAM
mem() {
  # mem=`free | awk '/Mem/ {printf "%dM / %dM\n", $3 / 1024.0, $2 / 1024.0 }'`
  # mem=`free | awk 'NR==2{printf "%dM / %dM\n", $3 / 1024.0, $2 / 1024.0 }'`
  mem=`free | awk 'NR==2{printf "%.2fG/%.2fG\n", $3/1024.0/1024.0, $2/1024.0/1024.0 }'`
  echo -e "RAM: $mem"
}
## CPU
cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "CPU: $cpu%"
}

## VOLUME
vol() {
    vol=`amixer get Master | awk -F'[][]' 'END{ print $2" "$4 }' | sed 's/on://g'`
    echo -e "VOL: $vol"
}

brt() {
	bright=`brightnessctl | awk '/brightness.+/ {print $4}' | tr -d '()'`
	echo -e "BRT: $bright"
}

bat() {
	power=$(cat /sys/class/power_supply/BAT0/capacity)
    status=$(cat /sys/class/power_supply/BAT0/status)
    if [ "$status" == "Charging" ]; then
        echo -e "BAT:$power%"
    elif [ "$status" == "Discharging" ]; then
        echo -e "BAT:$power%"
    elif [ "$status" == "Full" ]; then
        echo -e "BAT:FULL"
    fi
}

SLEEP_SEC=0.2
#loops forever outputting a line every SLEEP_SEC secs

# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the
# echo output too long to display correctly.
while :; do
    # echo "+@fg=3; +@fn=0;$(cpu) | +@fg=4; +@fn=0;$(mem) | +@fg=2; +@fn=0;$(hdd) | +@fg=8; +@fn=0;$(bat) | +@fg=5; +@fn=0;$(brt) | +@fg=7; +@fn=0;$(vol)"
    echo "[$(cpu) | $(mem) | $(hdd1)|$(hdd) | $(bat) | $(brt) | $(vol)]"
	sleep $SLEEP_SEC
done
