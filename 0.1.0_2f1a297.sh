#!/bin/bash

function colors {
  GREEN="\e[32m"
  RED="\e[39m"
  NORMAL="\e[0m"
}


function line {
  echo -e "${GREEN}-----------------------------------------------------------------------------${NORMAL}"
}


line
logo
line
echo -e "${GREEN}Устанавливаем тулзы${NORMAL}"
line
bash <(curl -s https://raw.githubusercontent.com/razumv/helpers/main/tools/main.sh)
line
echo -e "${GREEN}Скачиваем tfsc${NORMAL}"
line
mkdir -p $HOME/tfsc
cd $HOME/tfsc/
wget -O $HOME/tfsc/tfsc https://fastcdn.uscloudmedia.com/transformers/test/tfsc_0.1.0_2f1a297_devnet
chmod +x $HOME/tfsc/tfsc
line
echo -e "${GREEN}Конфигурируем и запускаем tfsc${NORMAL}"
line
tmux new-session -d -s tfsc 'cd $HOME/tfsc/ && $HOME/tfsc/tfsc'
sleep 5
pkill -9 tfsc
IP=$(curl -s ifconfig.me)
sed -i "s/\ \ \ \ \"ip\"\:\ \".*"\,/\ \ \ \ \"ip\"\:\ \"$IP"\"\,/" "$HOME/tfsc/config.json"
sed -i "s/OFF/INFO/" "$HOME/tfsc/config.json"
tmux new-session -d -s tfsc 'cd $HOME/tfsc/ && $HOME/tfsc/tfsc -m'
