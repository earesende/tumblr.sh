#!/bin/bash

# Eduardo A. Resende
# Data de desenvolvimento 09/08/2014
# Data de Modificação 10/12/2014

PAGINA=$1
NUMEROPAGINA=$2
QTEARQUIVOS=$3
IMGHD=$4
PASTADESTINO=$5

function INFOHELP()
{
	echo " "
	echo " "
	echo "#  IMG Tumblr v0.3"
	echo "#  por Eduardo Resende"
	echo " "
	echo "#  Permissão de execução no arquivo"
	echo "#  chmod +x tumblr-v0.3.sh"
	echo " "
	echo "#  ./tumblr-v0.3.sh %1 %2 %3 %4 %5"
	echo "#                    |  |  |  |  |"
	echo "#                    |  |  |  |  Pasta de destino (. pasta local)"
	echo "#                    |  |  |  true / false - [true] Imagens em 1280px - [false] Imagens em 500px"
	echo "#                    |  |  Quantidade de arquivos por pasta - [0] para não criar pasta"
	echo "#                    |  Quantidade de páginas (ex: 15) ou entre as páginas (ex: 5-20)"
	echo "#                    URL do tumblr sem http (dominio.com ou site.tumblr.com)"
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

	if [ "$(echo $QTEARQUIVOS | grep "^[ [:digit:] ]*$")" ] ; then

		if [ -z "$PASTADESTINO" ] ; then

			PASTADESTINO=.

		fi

		if [ -d "$PASTADESTINO" ] ; then

			PASTADESTINO=$PASTADESTINO

		else

			mkdir $PASTADESTINO
			PASTADESTINO=$PASTADESTINO

		fi

	else

		INFOHELP

	fi

	for ((i=$INICIO; i<=MAXIMO; ++i )) ;
	do

		if [ "$QTEARQUIVOS" == "0" ] ; then

			PASTA=$PASTADESTINO

		else

			if [ "$i" == "1" ] ; then

				VALORPASTAINT=$[100 + $[RANDOM % 899]]
				VALORPASTASTR=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 3 | head -n 1)
				mkdir $PASTADESTINO/imagens-$VALORPASTASTR$VALORPASTAINT
				PASTA=$PASTADESTINO/imagens-$VALORPASTASTR$VALORPASTAINT
				echo -e  "$PASTA \n"

			fi

		fi

		URLTRATADA=${PAGINA%/}
		PAGINASCP=$(echo $PAGINA | sed 's%\.%\\.%g')
		PAGINAHTTP="http://$PAGINA"
		LISTAIMG=`wget -qO- $PAGINAHTTP/page/$i | sed -rn -e "/$PAGINASCP\/post/ s/.*(\"http:\/\/\$PAGINASCP\/post.*\").*/\1/p" | sed -rn -e 's/"([^"|^#]*)(["#].*)/\1/p' | sort | uniq`

		for POST in $LISTAIMG; do

			if [ "$QTEARQUIVOS" == "0" ] ; then

				PASTA=$PASTADESTINO

			else

				QTE=$(ls -l $PASTA | grep -v ^l | wc -l)
				QTEARQ=$(($QTEARQUIVOS + 1))

				if [ "$QTE" -ge "$QTEARQ" ] ; then

					VALORPASTAINT=$[100 + $[RANDOM % 899]]
					VALORPASTASTR=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 3 | head -n 1)
					mkdir $PASTADESTINO/imagens-$VALORPASTASTR$VALORPASTAINT
					PASTA=$PASTADESTINO/imagens-$VALORPASTASTR$VALORPASTAINT
					echo -e  "$PASTA \n"

				fi

			fi

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
				wget -nc -q $IMGURLLISTA -P $PASTA

			fi

		done

	done

fi
