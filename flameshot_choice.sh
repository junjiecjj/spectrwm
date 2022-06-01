#! /usr/bin/env bash
#########################################################################
# File Name: flameshot_choice.sh
# Author:陈俊杰
# mail: 2716705056@qq.com
# Created Time: 2022年05月19日 星期四 14时12分55秒

# 此程序的功能是：
#########################################################################



flameshot gui -p  $(xdg-user-dir PICTURES) -d 2000

exec notify-send '火焰截图 延时2s 自己选择截图区域 保存在~/图片'
