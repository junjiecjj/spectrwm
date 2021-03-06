#! /usr/bin/env bash
#########################################################################
# File Name: baraction_bazeeel.sh
# Author:陈俊杰
# mail: 2716705056@qq.com
# Created Time: 2022年05月31日 星期二 16时31分37秒

# 此程序的功能是：
#########################################################################
#!/usr/bin/env sh
trap 'update' 5

mpd(){
  song="$(mpc current)"
  status="$(mpc status | grep paused | awk '{print $2}')"
  echo -e "Music:$song"
}

dte(){
  dte="$(date +"%Y.%m.%d")"
  echo -e " $dte"
}

dte2(){
  dte2="$(date +"%H:%M")"
  echo -e "$dte2"
}

mem(){
  mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "Mem:$mem"
}

vol(){
  vol=$(amixer get Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "MM" } else { print $2 }}' | head -n 1)
  echo -e "Vol:$vol%"

}

cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.2
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "CPU:$cpu%"
}

temp(){
  #temp="$(sensors | awk '/^Tdie:/ {print $2}')"
  temp="$(sensors | awk '/Core 0/ {print $3}')"
  echo -e "Temp:$temp"
}

wtr(){
  weat=$(curl 'wttr.in?format=%c')
  weat1=$(curl 'wttr.in?format=%t')
  weat2=$(curl 'wttr.in?format=%p')
  echo -e "Wea:$weat$weat1"
}

#bat(){
 # bat="$(acpi -b | awk  '{print $0}')"
  #bat=$(acpi -b | cut -d " " -f4 | sed 's/%//' | sed 's/,//' | sed 's/ //g')
  #echo -e "+@fn=2;🔋+@fn=0; $bat"



SLEEP_SEC=0.5

while :; do

  #echo "+@fg=2; $(mpd) +@bg=0; | $(cpu)  | $(temp) |  $(mem)  | $(dte)  | $(vol)"
  echo "$(mpd)  $(cpu)  $(mem)  $(vol)  $(dte)  $(dte2)"

  sleep $SLEEP_SEC
done
