#!/usr/bin/bash
#coding: utf-8
echo -e '\033[36m''   ▄████  ██░ ██  ▒█████    ██████ ▄▄▄█████▓'
echo '  ██▒ ▀█▒▓██░ ██▒▒██▒  ██▒▒██    ▒ ▓  ██▒ ▓▒'
echo ' ▒██░▄▄▄░▒██▀▀██░▒██░  ██▒░ ▓██▄   ▒ ▓██░ ▒░'
echo ' ░▓█  ██▓░▓█ ░██ ▒██   ██░  ▒   ██▒░ ▓██▓ ░ '
echo ' ░▒▓███▀▒░▓█▒░██▓░ ████▓▒░▒██████▒▒  ▒██▒ ░ '
echo '  ░▒   ▒  ▒ ░░▒░▒░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░  ▒ ░░   '
echo '   ░   ░  ▒ ░▒░ ░  ░ ▒ ▒░ ░ ░▒  ░ ░    ░    '
echo ' ░ ░   ░  ░  ░░ ░░ ░ ░ ▒  ░  ░  ░    ░      '
echo -e '       ░  ░  ░  ░    ░ ░        ░      ''\033[0;0m\033[32m''v1.0 ''\033[0;0m'
echo -e '''\033[0;0m\033[32m''				By Scatolin. ''\033[0;0m'
echo ''
echo -e '\033[31m''[*] Requisitos: Privoxy e Tor instalados.'
echo -e '* apt-get install privoxy / tor *''\033[0;0m'
echo ''
echo -e '\033[36m''[*]''\033[0;0m Starting Ghostification...'
echo -e '\033[32m''[*]''\033[0;0m Configurando arquivos do Privoxy...'
cp config /etc/privoxy/
echo -e '\033[32m''[*]''\033[0;0m Subindo serviços...'
/etc/init.d/tor start && /etc/init.d/privoxy start
echo ''
echo -e '\033[32m''[*]''\033[0;0m Você deseja que o Privoxy inicialize junto com o Boot? (S / N)'
read resposta
if [ S = $resposta ]
then
    update-rc.d tor enable && update-rc.d privoxy enable & echo -e '\033[32m''[*]''\033[0;0m Configurando Privoxy para iniciar com Boot...'
else
    echo -e "\033[32m[*]\033[0;0m O Privoxy não será inicializado junto com o Boot."
fi
echo ''
echo -e '\033[32m''[*]''\033[0;0m Iniciando serviços...'
service tor start
service network-manager start
echo ''
echo 'Insira sua interface de rede:'
echo '* Descubra sua interface usando o comando ifconfig *'
read interface
echo -e '\033[32m''[*]''\033[0;0m Randomizando seu endereço MAC...'
ifconfig $interface down
macchanger -r $interface
ifconfig $interface up
echo ''
echo -e '\033[36m''[*]''\033[0;0m Ending Ghostification...'
echo ''
echo ''
cat proxy.txt
echo ''
echo ''
echo -e '\033[36m''[*]''\033[0;0m Após configurar o browser, acesse *check.torproject.org* para verificar se está usando a rede Tor corretamente.'
echo ''
echo '* Exemplo de uso: torify ssh 192.168.0.123 / torify nmap -sS -sV -O 127.0.0.1 *'