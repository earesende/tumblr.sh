#!/bin/bash

# Eduardo A. Resende
# Data de desenvolvimento 09/08/2014
# Data de Modificação 11/08/2014

PAGINA=$1
NUMEROPAGINA=$2
CRIARPASTA=$3
FORMATO=$4
PASTADESTINO=$5

function INFOHELP()
{
	echo " "
	echo " "
	echo "#  IMG Tumblr v0.1"
	echo "#  por Eduardo Resende"
	echo " "
	echo "#  Permissão de execução no arquivo"
	echo "#  chmod +x tumblr.sh"
	echo " "
	echo "#  ./tumblr.sh %1 %2 %3 %4 %5"
	echo "#               |  |  |  |  |"
	echo "#               |  |  |  |  Pasta de destino (. pasta local)"
	echo "#               |  |  |  Formato da imagem separado por vírgula (jpg,jpeg,gif,png)"
	echo "#               |  |  true / false - [true] Cria uma pasta a cada 30 páginas verificadas"
	echo "#               |  Quantidade de páginas (ex: 10) ou entre as páginas (ex: 5-10)"
	echo "#               URL do tumblr com http"
	echo " "
	echo " "

	exit
}

if [ "$PAGINA" == "help" ] || [ "$PAGINA" == "--help" ] ; then

	INFOHELP

else

	VERIFICAURL=$(echo $PAGINA | grep "http")

	if [ -z "$VERIFICAURL" ] ; then

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

			wget -nd -H -p -A $FORMATO -e robots=off $URLTRATADA/page/$i -P $PASTA

		done

	fi

fi