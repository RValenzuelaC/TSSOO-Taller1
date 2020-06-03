#!/bin/bash
forma_uso(){
        echo "Uso: $0 -d <archivo_datos> [-h]"
        exit 1
}

if [ $# != "-d" ]; then
        forma_uso

fi

while getopts "d:h" opcion; do
	case "$opcion" in
		d)
			dataIn=$OPTARG
			;;
		h)
			forma_uso
			;;
		*)
			forma_uso
			;;
	esac
done




