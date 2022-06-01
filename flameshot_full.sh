#! /usr/bin/env bash
#########################################################################
# File Name: flameshot_full.sh
# Author:陈俊杰
# mail: 2716705056@qq.com
# Created Time: 2022年05月19日 星期四 14时13分38秒

# 此程序的功能是：
#########################################################################



flameshot full -c -p  $(xdg-user-dir PICTURES)  -d 2000


exec notify-send '火焰截图 捕获全屏（无GUI）并保存到剪贴板和路径~/图片 延迟2秒'
