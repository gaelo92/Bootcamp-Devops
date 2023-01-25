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
