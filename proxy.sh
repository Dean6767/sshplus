#!/bin/bash

     apt update -y
	 cd /root
	 echo "Instalando Proxy"
	 curl -L https://mirrors.host900.com/https://raw.githubusercontent.com/snail007/goproxy/master/install_auto.sh | bash
	 echo "Iniciando Proxy na porta 80"
	 proxy http -t tcp -p "0.0.0.0:80" --daemon
	 echo "PROXY HTTP RODANDO!"
