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