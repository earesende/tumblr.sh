#!/bin/bash

# Eduardo A. Resende
# Data de desenvolvimento 09/08/2014
# Data de Modificação 05/12/2014

PAGINA=$1
NUMEROPAGINA=$2
CRIARPASTA=$3
IMGHD=$4
PASTADESTINO=$5

function INFOHELP()
{
	echo " "
	echo " "
	echo "#  IMG Tumblr v0.2"
	echo "#  por Eduardo Resende"
	echo " "
	echo "#  Permissão de execução no arquivo"
	echo "#  chmod +x tumblr.sh"
	echo " "
	echo "#  ./tumblr.sh %1 %2 %3 %4 %5"
	echo "#               |  |  |  |  |"
	echo "#               |  |  |  |  Pasta de destino (. pasta local)"
	echo "#               |  |  |  true / false - [true] Imagens em 1280px - [false] Imagens em 500px"
	echo "#               |  |  true / false - [true] Cria uma pasta a cada 30 páginas verificadas"
	echo "#               |  Quantidade de páginas (ex: 10) ou entre as páginas (ex: 5-10)"
	echo "#               URL do tumblr sem http (dominio.com ou site.tumblr.com)"
	echo " "
	echo " "

	exit
}

if [ "$PAGINA" == "help" ] || [ "$PAGINA" == "--help" ] ; then

	INFOHELP

else

	NPAGINA=$(echo $NUMEROPAGINA | grep "-")

	if [ -z "$NPAGINA" ] ; then

		INICIO=1
		MAXIMO=$NUMEROPAGINA

	else

		PINICIO=$(echo $NUMEROPAGINA | cut -d "-" -f1)
		PMAXIMO=$(echo $NUMEROPAGINA | cut -d "-" -f2)

		INICIO=$PINICIO
		MAXIMO=$PMAXIMO

	fi

	if [ -z "$PASTADESTINO" ] ; then

		PASTADESTINO=.

	fi

	if [ -d "$PASTADESTINO" ] ; then

		PASTADESTINO=$PASTADESTINO

	else

		mkdir $PASTADESTINO
		PASTADESTINO=$PASTADESTINO

	fi

	for ((i=$INICIO; i<=MAXIMO; ++i )) ;
	do

		if [ "$CRIARPASTA" == "true" ] || [ "$CRIARPASTA" == "TRUE" ] ; then

			if [ "$i" == "1" ] ; then

				mkdir $PASTADESTINO/imagens-0$INICIO
				GUARDANUMERO=$i
				PASTA=$PASTADESTINO/imagens-0$INICIO

			fi

			ATUAL=$(($i%30))

			if [ "$ATUAL" == "0" ] ; then

				GUARDANUMERO=$(($GUARDANUMERO+1))
				GUARDANUMEROATUAL=$GUARDANUMERO

				if [ "$GUARDANUMERO" -lt "10" ] ; then

					GUARDANUMERO=0$GUARDANUMERO

				fi

				mkdir $PASTADESTINO/imagens-$GUARDANUMERO
				PASTA=$PASTADESTINO/imagens-$GUARDANUMERO
				GUARDANUMERO=$GUARDANUMEROATUAL

			fi

		elif [ "$CRIARPASTA" == "false" ] || [ "$CRIARPASTA" == "FALSE" ] ; then

			PASTA=$PASTADESTINO

		else

			INFOHELP

		fi

		URLTRATADA=${PAGINA%/}
		PAGINASCP=$(echo $PAGINA | sed 's%\.%\\.%g')
		PAGINAHTTP="http://$PAGINA"
		LISTAIMG=`wget -qO- $PAGINAHTTP/page/$i | sed -rn -e "/$PAGINASCP\/post/ s/.*(\"http:\/\/\$PAGINASCP\/post.*\").*/\1/p" | sed -rn -e 's/"([^"|^#]*)(["#].*)/\1/p' | sort | uniq`

		for POST in $LISTAIMG; do

			if [ "$IMGHD" == "true" ] ; then

				IMGURLLISTA=`wget -qO- $POST | sed -rn -e '/="http:\/\/.*media\.tumblr\.com\/.*\/tumblr_([^<]+)._1280.(jpg|jpeg|png)"/ s/.*("http:\/\/.*media\.tumblr\.com\/.*\/tumblr_([^<]+)._1280.(jpg|jpeg|png)").*/\1/p' | sed -rn -e 's/"([^"|^#]*)(["#].*)/\1/p' | sort | uniq`
				RESOLUCAO="1280px"

			else

				IMGURLLISTA=`wget -qO- $POST | sed -rn -e '/="http:\/\/.*media\.tumblr\.com\/.*\/tumblr_([^<]+)._500.(jpg|jpeg|png)"/ s/.*("http:\/\/.*media\.tumblr\.com\/.*\/tumblr_([^<]+)._500.(jpg|jpeg|png)").*/\1/p' | sed -rn -e 's/"([^"|^#]*)(["#].*)/\1/p' | sort | uniq`
				RESOLUCAO="500px"

			fi


			if [ -z "$IMGURLLISTA" ] ; then

				echo -e "Imagem não encontrada ou menor que $RESOLUCAO. \n"

			else

				echo -e "$IMGURLLISTA \n"
				wget -q $IMGURLLISTA -P $PASTA

			fi

		done

	done

fi
