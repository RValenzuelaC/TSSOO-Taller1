## TSSOO-taller1
##### Raúl  Ignacio Valenzuela Cinto - Raul.valenzuela@alumnos.uv.cl

###  1. Diseño de la solución  
El diseño de este taller se basa en la creación de un script que cumpla con la ejecución de los 3 problemas, como se muestra en la Figura. 
![img1](http://imgfz.com/i/QVx7OUK.png) 
 
Como se puede notar en el diagrama que se ejecutan tres problemas, primeramente se debe validar si los parametros ingresados este correctamente, además de verificar si el directorio existe. Luego de esto se empezará con el problema 1 que consta de calcular el tiempo total de simulación (timeExecMakeAgents + timeExecCal + timeExecSim) con su estructura de promedio:minimo:maximo además de la memoria total utilizada(maxMemory + agentsMem) con la estructura promedio:minimo:maximo, al haber realizado todos los calculos estos quedarán guardados en un archivo txt llamado “Metrics.txt” cumpliendo con el primer problema.

Para el problema 2 y 3 se procederá de la misma manera, tomando los datos correspondientes, analizandolos y calcular las caracteristicas corresponedientes, terminando con guardar los datos en sus respectivos archivos txt.
 
###   2. Estructura del código 
#### 2.1 Parte de verificación de datos  
Primero que nada se verificarán los datos ingresados como parametros, si estos cumplen la forma de uso se guardarán en una variable "dataIn"  para poder ser analizadas proximamente, en cambio si los parametros ingresados estaban erroneos o simplemente no existian, este madaría la forma de uso como mensaje para entender la forma correcta de utilización. 
#### 2.2 Problema 1
Luego de verificar si los datos estaban correctos o incorrectos se pasará al problema 1 buscando los archivos correspondientes con el comando `find` dentro del directorio ingresado, con el nombre de "executionSummary", por lo que la ruta de este archivo se asignará a una variable para proximamente recorrer esta y buscar los datos solicitados.  

```
executionSummary=(`find $dataIn -name '*.txt' -print | sort | grep executionSummary | grep -v '._'`)`
```
Al haber encontrado el archivo solicitado, se procede a calcular la suma de tiempo y la memoria total utilizada, para esto se creo un bucle que recorriera los datos almacenados en `executionSummary`, para asignarla a una variable de la suma total `valorSum`
y otra donde se encuentre la memoria total utilizada `valorMem`, estas serán almacenadas en variables temporales `tmp1` `tmp2` para poder recorrerlas próximamente y completar lo siguiente del problema, que consiste en obtener el promedio, el mínimo y máximo de este.
Para la obtención del promedio, el minimo y el maximo de ambos casos se usaron otras variables `valorSum_pmm` y `valorMem_pmm` que contendrá los valores de lo antes mencionado. 
```
valorSum_pmm=$(cat $tmp1 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp1<min){min=$tmp1};\
                                                                                                  if($tmp1>max){max=$tmp1};\
                                                                                                  total+=$tmp1; count+=1;\
                                                                                            } \
                                                                                            
                                                                                                 END { print total, total/count, min, max}')
```
```
valorMem_pmm=$(cat $tmp2 | awk 'BEGIN{ min=2**63-1; max=0}{if($tmp2<min){min=$tmp2};\
                                                                                                  if($tmp2>max){max=$tmp2};\
                                                                                                  total+=$tmp2; count+=1;\
                                                                                           } \
                                                                                                 END{print total, total/count, min, max}')
```
El comando `cat` se utilizó principalmente para concatenar los datos del archivo leído para que luego el comando `awk` procese los datos respectivos al calculo de promedio, mínimo y máximo.  
Una vez concluido esta parte, los datos obtenidos se guardaran en un archivo llamado `metrics.txt`

#### 2.3 Problema 2
Para este problema igual que el anterior al haber encontrado el archivo correspondiente, se creo un bucle para recorrer el contenido del archivo, en el caso de este problema se calculará la suma total de tipo de personas simuladas, además de su respectivo promedio, mínimo y máximo. 
Para la primera parte de este problema si utilizará una variable temporal `tmp3` en la cual se guardarán los datos para luego recorrer esta y obtener el total de personas, además del promedio, mínimo y máximo.
Esto se puede ver en el siguiente fragmento de codigo:
```
personasT=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{pSum=0}{pSum+=$8}END{print pSum}' )
        printf "$personasT \n" >> $tmp3
        personas_pmm=$(cat $tmp3 | awk 'BEGIN{ min=2**63-1; max=0}{ if($tmp3<min){min=$tmp3};\
                                                                                                  if($tmp3>max){max=$tmp3};\
                                                                                                  total+=$tmp3; count+=1;\
                                                                                            } \
                                                                                                 END { print total, total/count, min, max}')
```
Al igual que el problema 1 el comando `cat` se utilizó para concatenar los datos pero en cambio se utilizó el comando `tail` para obtener el los datos que estuvieran debajo de la cabezerá, y en el comando `awk` procesará los datos respectivos al calculo además de usar `-F ':' `  para tomar el octavo numero que este separado por ":".

En este problema, que requiere obtener el dato de cada tipo de persona, se hará el mismo pasó anterior cambiando el parametro por el consecuente al tipo de persona solicitada.
Ya obteniendo el resultado, este se guardará en un archivo llamado `evacuation.txt`





