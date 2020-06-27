#!/bin/bash
forma_de_uso(){
        echo -e "Uso: $0 -d <archivo_datos> [-h]\n -d: directorio donde están los datos a procesar.\n -h: muestra este mensaje y termina."
        exit 1
}

if [ $# = 0 ]; then
        forma_de_uso

fi

while getopts "d:h" opcion; do
	case "$opcion" in
		d)
			dataIn=$OPTARG
			;;
		h)
			forma_de_uso
			;;
		*)
			echo "Para vizualizar la forma de uso utilice [-h]"
			;;
	esac
done

if [ ! -e $dataIn ]; then
	echo "Directorio $2 no existe"
	exit
fi


#problema1
executionSummary=(`find $dataIn -name '*.txt' -print | sort | grep executionSummary | grep -v '._'`)

tmpArch="metrics.txt"
tmp1="SimTime.txt"
tmp2="MemUsed.txt"
rm -f $tmpVar
rm -f $tmp1
rm -f $tmp2

for i in ${executionSummary[*]};
do
	valorSum=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{timesum=0}{timesum=$6+$7+$8}END{ print timesum }' )
	printf "$valorSum \n"  >> $tmp1
	valorSum_pmm=$(cat $tmp1 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp1<min){min=$tmp1};\
                                                                                                  if($tmp1>max){max=$tmp1};\
                                                                                                  total+=$tmp1; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')

	valorMem=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{sumMem=0}{sumMem=$10;} END{print sumMem}')
	printf "$valorMem \n" >> $tmp2
	valorMem_pmm=$(cat $tmp2 | awk 'BEGIN{ min=2**63-1; max=0}{if($tmp2<min){min=$tmp2};\
												  if($tmp2>max){max=$tmp2};\
												  total+=$tmp2; count+=1;\
									                   } \
												 END{print total, total/count, min, max}')
done
printf "tsimTotal : promedio : min : max \n">>$tmpArch
printf " memUsed: promedio : min : max \n" >> $tmpArch
printf "%i : %i : %i : %i \n " $valorSum_pmm >> $tmpArch
printf " %i : %.2f : %i: %i \n"  $valorMem_pmm >> $tmpArch
rm -f $tmp1 $tmp2


