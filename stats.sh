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
			echo  "Para visualizar la forma de uso utilice [-h]"
			;;
	esac
done

if [ ! -e $dataIn ]; then
	echo "Directorio $2 no existe"
	exit
fi


#problema1
execution(){
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
printf "%i : %.2f : %i : %i \n " $valorSum_pmm >> $tmpArch
printf " %i : %.2f : %i: %i \n"  $valorMem_pmm >> $tmpArch
rm -f $tmp1 $tmp2
}
#problema 2---------------------------------------------------------------------------------------------------------
summary(){
summary=(`find $dataIn -name '*.txt' -print | sort | grep summary | grep -v '._'`)

tmpEva="evacuation.txt"
tmp3="temporal.txt"
tmp4="temporal2.txt"
tmp5="temporal3.txt"
tmp6="temporal4.txt"
tmp7="temporal5.txt"
tmp8="temporal6.txt"
tmp9="temporal7.txt"
tmp10="temporal8.txt"
tmp11="temporal9.txt"
tmp12="temporal10.txt"
tmp13="temporal11.txt"
rm -f $tmpEva
rm -f $tmp3
rm -f $tmp4
rm -f $tmp5
rm -f $tmp6
rm -f $tmp7
rm -f $tmp8
rm -f $tmp9
rm -f $tmp10
rm -f $tmp11
rm -f $tmp12
rm -f $tmp13

for i in ${summary[*]};
do
        personasT=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{pSum=0}{pSum+=$8}END{print pSum}' )
        printf "$personasT \n" >> $tmp3
        personas_pmm=$(cat $tmp3 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp3<min){min=$tmp3};\
                                                                                                  if($tmp3>max){max=$tmp3};\
                                                                                                  total+=$tmp3; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')

	residentesT=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{rSum=0}{if($3==0)rSum+=$8}END{print rSum}' )
        printf "$residentesT \n" >> $tmp4
        residentes_pmm=$(cat $tmp4 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp4<min){min=$tmp4};\
                                                                                                  if($tmp4>max){max=$tmp4};\
                                                                                                  total+=$tmp4; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')

        visitantesT=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{vSum=0}{if($3==1)vSum+=$8}END{print vSum}' )
        printf "$visitantesT \n" >> $tmp5
        visitantes_pmm=$(cat $tmp5 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp5<min){min=$tmp5};\
                                                                                                  if($tmp5>max){max=$tmp5};\
                                                                                                  total+=$tmp5; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')

	residentesG0=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{rG0Sum=0}{if($3==0 && $4==0) rG0Sum+=$8}END{print rG0Sum}' )
        printf "$residentesG0 \n" >> $tmp6
        residentesG0_pmm=$(cat $tmp6 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp6<min){min=$tmp6};\
                                                                                                  if($tmp6>max){max=$tmp6};\
                                                                                                  total+=$tmp6; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')



	residentesG1=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{rG1Sum=0}{if($3==0 && $4==1) rG1Sum+=$8}END{print rG1Sum}' )
        printf "$residentesG1 \n" >> $tmp7
        residentesG1_pmm=$(cat $tmp7 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp7<min){min=$tmp7};\
                                                                                                  if($tmp7>max){max=$tmp7};\
                                                                                                  total+=$tmp7; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')
	residentesG2=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{rG2Sum=0}{if($3==0 && $4==2) rG2Sum+=$8}END{print rG2Sum}' )
        printf "$residentesG2 \n" >> $tmp8
        residentesG2_pmm=$(cat $tmp8 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp8<min){min=$tmp8};\
                                                                                                  if($tmp8>max){max=$tmp8};\
                                                                                                  total+=$tmp8; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')

	residentesG3=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{rG3Sum=0}{if($3==0 && $4==3) rG3Sum+=$8}END{print rG3Sum}' )
        printf "$residentesG3 \n" >> $tmp9
        residentesG3_pmm=$(cat $tmp9 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp9<min){min=$tmp9};\
                                                                                                  if($tmp9>max){max=$tmp9};\
                                                                                                  total+=$tmp9; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')

	visitantesG0=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{vG0Sum=0}{if($3==1 && $4==0) vG0Sum+=$8}END{print vG0Sum}' )
        printf "$visitantesG0 \n" >> $tmp10
        visitantesG0_pmm=$(cat $tmp10 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp10<min){min=$tmp10};\
                                                                                                  if($tmp10>max){max=$tmp10};\
                                                                                                  total+=$tmp10; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')


	visitantesG1=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{vG1Sum=0}{if($3==1 && $4==1) vG1Sum+=$8}END{print vG1Sum}' )
        printf "$visitantesG1 \n" >> $tmp11
        visitantesG1_pmm=$(cat $tmp11 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp11<min){min=$tmp11};\
                                                                                                  if($tmp11>max){max=$tmp11};\
                                                                                                  total+=$tmp11; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')
	visitantesG2=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{vG2Sum=0}{if($3==1 && $4==2) vG2Sum+=$8}END{print vG2Sum}' )
        printf "$visitantesG2 \n" >> $tmp12
        visitantesG2_pmm=$(cat $tmp12 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp12<min){min=$tmp12};\
                                                                                                  if($tmp12>max){max=$tmp12};\
                                                                                                  total+=$tmp12; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')
	visitantesG3=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{vG3Sum=0}{if($3==1 && $4==3) vG3Sum+=$8}END{print vG3Sum}' )
        printf "$visitantesG3 \n" >> $tmp13
        visitantesG3_pmm=$(cat $tmp13 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp13<min){min=$tmp13};\
                                                                                                  if($tmp13>max){max=$tmp13};\
                                                                                                  total+=$tmp13; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')
done
printf "alls : promedio : min : max \n" >> $tmpEva
printf "residents : promedio : min : max \n" >>$tmpEva
printf "visitorsI : promedio : min : max \n" >>$tmpEva
printf "residents-G0 : promedio : min : max \n" >> $tmpEva
printf "residents-G1 : promedio : min : max \n" >> $tmpEva
printf "residents-G2 : promedio : min : max \n" >> $tmpEva
printf "residents-G3 : promedio : min : max \n" >> $tmpEva
printf "visitorsI-G0 : promedio : min : max \n" >> $tmpEva
printf "visitorsI-G1 : promedio : min : max \n" >> $tmpEva
printf "visitorsI-G2 : promedio : min : max \n" >> $tmpEva
printf "visitorsI-G3 : promedio : min : max \n" >> $tmpEva
printf "%i : %.2f : %i : %i \n" $personas_pmm  >> $tmpEva
printf "%i : %.2f : %i : %i \n" $residentes_pmm >> $tmpEva
printf "%i : %.2f : %i : %i \n" $visitantes_pmm >> $tmpEva
printf "%i : %.2f : %i : %i \n" $residentesG0_pmm >> $tmpEva
printf "%i : %.2f : %i : %i \n" $residentesG1_pmm >> $tmpEva
printf "%i : %.2f : %i : %i \n" $residentesG2_pmm >> $tmpEva
printf "%i : %.2f : %i : %i \n" $residentesG3_pmm >> $tmpEva
printf "%i : %.2f : %i : %i \n" $visitantesG0_pmm >> $tmpEva
printf "%i : %.2f : %i : %i \n" $visitantesG1_pmm >> $tmpEva
printf "%i : %.2f : %i : %i \n" $visitantesG2_pmm >> $tmpEva
printf "%i : %.2f : %i : %i \n" $visitantesG3_pmm >> $tmpEva

rm -f $tmp3
rm -f $tmp4
rm -f $tmp5
rm -f $tmp6
rm -f $tmp7
rm -f $tmp8
rm -f $tmp9
rm -f $tmp10
rm -f $tmp11
rm -f $tmp12
rm -f $tmp13
}
#Problema 3--------------------------------------------------------------------------------------------------------------------------
usephone(){
usePhoneFiles=(`find $dataIn -name '*.txt' -print | sort | grep usePhone | grep -v '._'`)
tmpPhone="usePhone-stats.txt"
tmp14="temporal12"
rm -f $tmp14
rm -f $tmpPhone
for i in ${usePhoneFiles[*]};
	do

		tiempos=(`cat $i | tail -n+3 | cut -d ':' -f 3`)
		for i in ${tiempos[*]};
		do
			printf "%d:" $i >> $tmp14
		done
		printf "\n" >> $tmp14
	done

	totalFields=$(head -1 $tmp14 | sed 's/.$//' | tr ':' '\n'| wc -l)

	printf "#timestamp:promedio:min:max\n" >> $tmpPhone
	for i in $(seq 1 $totalFields); do
		out=$(cat $tmp14 | cut -d ':' -f $i |\
			awk 'BEGIN{ min=2**63-1; max=0}\
				{if($1<min){min=$1};if($1>max){max=$1};total+=$1; count+=1;}\
				END {print total/count":"max":"min}')
		printf "$i:$out\n" >> $tmpPhone
	done

	rm -f $tmp14

}

