#! /usr/bin/env bash
#########################################################################
# File Name: baraction_rayes.sh
# Author:陈俊杰
# mail: 2716705056@qq.com
# Created Time: 2022年05月31日 星期二 16时15分16秒

# 此程序的功能是：

# https://github.com/rayes0/dotfiles/blob/main/bin/spectrwm/baraction.sh
#########################################################################


# baraction.sh script for spectrwm status bar

while true
do
  # CPU
  cpu() {
	  mpstat 2 1 | awk 'END{print 100-$NF"%"}'
  }

  # BATTERY
  bat="$(cat /sys/class/power_supply/BAT0/capacity)%"
  bat_state="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | tr -d "[:space:]" | cut -c 7-)"
  if [ "$bat_state" = "charging" ]; then
	  bat="$bat ($bat_state)"
  fi

  # VOLUME
  vol() {
	  pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/%//g'
  }
 # if (( 0 <= $(vol) < 30 )); then
 #         voli="🔈"
 # elif (( 30 <= $(vol) < 60 )); then
 #         voli="🔉"
 # elif (( 60 <= $(vol) < 100 )); then
 #         voli="🔊"
 # fi

  # CAFFEINE
  if pgrep "xautolock" >/dev/null 2>&1; then
	  caf=""
  else
	  caf="☕"
  fi

  echo "vol: $(vol)% | cpu: $(cpu) | bat: $bat $caf"
  sleep 1.5
done
