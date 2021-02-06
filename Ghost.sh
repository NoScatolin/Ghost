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

echo -e '       ░  ░  ░  ░    ░ ░        ░      '

echo ''



echo -e '\e[36m[+] Efetuando instalação das dependências... \e[39m'



apt install tor macchanger secure-delete curl tor privoxy -y



git clone https://github.com/BlackArch/torctl

cd torctl

mv service/* /etc/systemd/sytem/

mv bash-completion/torctl /usr/share/bash-completion/completions/torctl 

sed -i 's/start_service iptables//' torctl 

sed -i 's/TOR_UID="tor"/TOR_UID="debian-tor"/' torctl 

mv torctl /usr/bin/torctl 

cd .. && rm -rf torctl/ 

cd Ghost



clear

echo -e '\033[36m''   ▄████  ██░ ██  ▒█████    ██████ ▄▄▄█████▓'

echo '  ██▒ ▀█▒▓██░ ██▒▒██▒  ██▒▒██    ▒ ▓  ██▒ ▓▒'

echo ' ▒██░▄▄▄░▒██▀▀██░▒██░  ██▒░ ▓██▄   ▒ ▓██░ ▒░'

echo ' ░▓█  ██▓░▓█ ░██ ▒██   ██░  ▒   ██▒░ ▓██▓ ░ '

echo ' ░▒▓███▀▒░▓█▒░██▓░ ████▓▒░▒██████▒▒  ▒██▒ ░ '

echo '  ░▒   ▒  ▒ ░░▒░▒░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░  ▒ ░░   '

echo '   ░   ░  ▒ ░▒░ ░  ░ ▒ ▒░ ░ ░▒  ░ ░    ░    '

echo ' ░ ░   ░  ░  ░░ ░░ ░ ░ ▒  ░  ░  ░    ░      '

echo -e '       ░  ░  ░  ░    ░ ░        ░      '

echo ''



echo ''

echo -e '\033[36m''[*]''\033[0;0m Starting Ghostification...'

echo -e '\033[32m''[*]''\033[0;0m Configurando arquivos do Privoxy...'

cp config /etc/privoxy/

echo -e '\033[32m''[*]''\033[0;0m Subindo serviços...'

/etc/init.d/tor start && /etc/init.d/privoxy start

echo ''

echo -e '\033[32m''[*]''\033[0;0m Você deseja que o Privoxy inicialize junto com o Boot? (s / n)'

read resposta

if [ s = $resposta ]

then

    update-rc.d tor enable && update-rc.d privoxy enable & echo -e '\033[32m''[*]''\033[0;0m Configurando Privoxy para iniciar com Boot...'

else

    echo -e "\033[32m[*]\033[0;0m O Privoxy não será inicializado junto com o Boot."

fi

echo ''

echo -e '\033[32m''[*]''\033[0;0m Iniciando serviços...'

service tor start

service networking start

echo ''

echo -e '\033[36m''[*]''\033[0;0m Ending Ghostification...'

echo ''

echo ''

cat proxy.txt

echo ''

echo ''



echo ''

echo -e '\033[36m''[*]''\033[0;0m Após configurar o browser, acesse *check.torproject.org* para verificar se está usando a rede Tor corretamente.'

echo ''

torip=$(torctl ip | grep "remote ip" | cut -d ':' -f2)

echo -e '\033[36m''[*]''\033[0;0m Endereço IP remoto(TorCTL):' $torip

echo ''

echo '* Exemplo de uso: torify ssh 192.168.0.123 / torify nmap -sS -sV -O 127.0.0.1 *'
