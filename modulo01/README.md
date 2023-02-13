# MÓDULO 01

## EJERCICIO 01

### Crear un archivo bash 
Para crear un archivo de bash en Linux o MacOS, puedes utilizar el comando touch seguido del nombre del archivo que deseas crear y la extensión ".sh":

````bash
touch ejercicio01.sh
````
### Permisos bash
Una vez escritos los comandos debes darle permisos de ejecución al archivo con el siguiente comando:
````bash
chmod +x ejercicio01.sh
````

### Contenido

````bash
#!/bin/bash
# Este es un comentario
mkdir foo
cd foo
mkdir dummy empty
cd dummy
touch file1.txt file2.txt
echo "Me encanta la bash!!" >> file1.txt
````

### Ejecutar bash

Por último para ejecutar el script:

````bash
./ejercicio01.sh
````

## EJERCICIO 02

### Crear un archivo bash
Para crear un archivo de bash en Linux o MacOS, puedes utilizar el comando touch seguido del nombre del archivo que deseas crear y la extensión ".sh":

````bash
touch ejercicio02.sh
````
### Permisos bash
Una vez escritos los comandos debes darle permisos de ejecución al archivo con el siguiente comando:
````bash
chmod +x ejercicio02.sh
````

### Contenido

````bash
#!/bin/bash
# Este es un comentario
cd foo/dummy/
# Volcar el contenido de file1.txt a file2.txt
cat file1.txt > file2.txt
# Mover file2.txt a la carpeta empty
mv file2.txt ../empty/
````

### Ejecutar bash

Por último para ejecutar el script:

````bash
./ejercicio02.sh
````

## EJERCICIO 03
### Crear un archivo bash
Para crear un archivo de bash en Linux o MacOS, puedes utilizar el comando touch seguido del nombre del archivo que deseas crear y la extensión ".sh":

````bash
touch ejercicio03.sh
````
### Ingresar parametros
Para establecer el texto de file1.txt utilizando un parámetro al invocar un script de bash, puedes utilizar el comando echo para escribir el contenido del parámetro en el archivo file1.txt.

````bash
echo $1 > file1.txt
````
### Permisos bash
Una vez escritos los comandos debes darle permisos de ejecución al archivo con el siguiente comando:
````bash
chmod +x ejercicio03.sh
````

### Contenido
Para establecer un texto por defecto en caso de que el parámetro pasado al script sea un texto vacío, puedes utilizar una condicional if-else para verificar si el parámetro está vacío o no. Si está vacío, entonces utilizas el texto por defecto, de lo contrario, utilizas el texto del parámetro.
 if [ -z "$Variable" ] Esto devolverá true si la variable no está definida o es la cadena vacía ("").
````bash
#!/bin/bash
# Este es un comentario
# ejercicio 01
mkdir foo
cd foo
mkdir dummy empty
cd dummy
touch file1.txt file2.txt
# condicional if-else ejercicio 03
if [ -z "$1" ]; then
    echo "Que me gusta la bash!!!!" > file1.txt
else
    echo $1 > file1.txt
fi
# ejercicio 02
# Volcar el contenido de file1.txt a file2.txt
cat file1.txt > file2.txt
# Mover file2.txt a la carpeta empty
mv file2.txt ../empty/
````

### Ejecutar bash

1) para ejecutar el script con pamatros de entrada:

````bash
./ejercicio03.sh "Hola Mundo"
````

2) para ejecutar el script sin pamatros de entrada:
````bash
./ejercicio03.sh ""
````
igualmente:

````bash
./ejercicio03.sh
````

## EJERCICIO 04

### Crear un archivo bash
Para crear un archivo de bash en Linux o MacOS, puedes utilizar el comando touch seguido del nombre del archivo que deseas crear y la extensión ".sh":

````bash
touch ejercicio04.sh
````
### Permisos bash
Una vez escritos los comandos debes darle permisos de ejecución al archivo con el siguiente comando:
````bash
chmod +x ejercicio04.sh
````

### Contenido
En este script se utiliza el comando grep con las opciones -m 1 y -n para limitar la búsqueda a solo la primera ocurrencia de la palabra y mostrar el número de línea donde se encuentra la palabra buscada respectivamente. Luego se utiliza awk para imprimir solo el numero de linea.
````bash
#!/bin/bash
# Este es un comentario
URL="https://www.icpna.edu.pe/"
touch file3.txt
# Descargar contenido de la página web a un archivo
curl -s $URL > file3.txt
# el comando grep con las opciones -m 1 y -n para limitar la búsqueda a solo la primera ocurrencia de la palabra y mostrar el número de línea donde se encuentra la palabra buscada respectivamente. Luego se utiliza awk para imprimir solo el numero de linea.
result1=$(grep -m 1 -n $1 file3.txt | awk '{print $1}' )

# Cantidad de veces que aparece el archivo
result2=$(grep -ci $1 file3.txt)

if [ -z "$result1" ]; then
    echo "No se ha encontrado la palabra $1"
else
    echo "La palabra $1 aparece $result2 veces."
    echo "Aparece por primera vez en la línea $result1"
fi
````

### Ejecutar bash

1) para ejecutar el script con pamatros de entrada:

````bash
./ejercicio04.sh google
````

2) para ejecutar el script sin pamatros de entrada:
````bash
./ejercicio04.sh ""
````
igualmente:

````bash
./ejercicio04.sh
````


## EJERCICIO 05

### Crear un archivo bash
Para crear un archivo de bash en Linux o MacOS, puedes utilizar el comando touch seguido del nombre del archivo que deseas crear y la extensión ".sh":

````bash
touch ejercicio05.sh
````
### Permisos bash
Una vez escritos los comandos debes darle permisos de ejecución al archivo con el siguiente comando:
````bash
chmod +x ejercicio05.sh
````

### Contenido

Se verificar que se tenga solo dos parametros de entrada con la condicional if el cual valida lo requerido

````bash
#!/bin/bash
# Este es un comentario

if [ $# -ne 2 ]; then
  echo "Se necesitan únicamente dos parámetros para ejecutar este script"
  exit 1
fi


touch file3.txt
# Descargar contenido de la página web a un archivo
curl -s $2 > file3.txt

# el comando grep con las opciones -m 1 y -n para limitar la búsqueda a solo la primera ocurrencia de la palabra y mostrar el número de línea donde se encuentra la palabra buscada respectivamente. Luego se utiliza awk para imprimir solo el numero de linea.
result1=$(grep -m 1 -n $1 file3.txt | awk -F: '{print $1}' )
# Cantidad de veces que aparece el archivo
result2=$(grep -ci $1 file3.txt)

if [ -z "$result1" ]; then
    echo "No se ha encontrado la palabra $1"
else
    if [ $result2 -eq 1 ]; then
          echo "La palabra $1 aparece $result2 vez."
          echo "Aparece únicamente en la línea $result1"
          exit 1
    fi
          echo "La palabra $1 aparece $result2 veces."
          echo "Aparece por primera vez en la línea $result1"
fi
````

### Ejecutar bash

##### Primer caso
1) para ejecutar el script con pamatros de entrada:

````bash
./ejercicio05.sh window https://www.disneyplus.com/
````

2) si ejecutamos sin los dos paramtros o mas, nos devolvera el siguiente error en consola "Se necesitan únicamente dos parámetros para ejecutar este script"
````bash
./ejercicio05.sh window https://www.disneyplus.com/  patatas
````
igualmente:

````bash
./ejercicio05.sh  https://www.disneyplus.com/  
````


##### Segundo caso

````bash
./ejercicio05.sh Pragma https://www.disneyplus.com/
````
Si la palabra solo aparece una vez devolverá el siguiente texto:
````bash
La palabra Pragma aparece 1 veces.
Aparece por primera vez en la línea 23
````