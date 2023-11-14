#!/bin/bash

# Ruta de la carpeta que contiene los archivos rar
ruta_carpeta="/mnt/libros/SubirCalibre/origen/"

# Cambiar al directorio que contiene los archivos rar
cd "$ruta_carpeta"

# Iterar sobre los archivos rar en la carpeta
for archivo_rar in *.rar; do
    # Obtener el nombre de la serie (nombre de la carpeta sin espacios)
    nombre_serie=$(unrar lb "$archivo_rar" | head -n 1 | sed 's/\/.*//g')
    nombre_archivo=$(unrar lb "$archivo_rar" | head -n 1 | sed 's/\// - /g' )

    # Crear la carpeta para extraer los archivos rar
    carpeta_destino="/mnt/libros/SubirCalibre/destino/$nombre_serie"
    mkdir -p "$carpeta_destino"

    # Extraer los archivos rar
    unrar e -o+ "$archivo_rar" "$carpeta_destino"

    # Iterar sobre los archivos extraídos
    for archivo_libro in "$carpeta_destino"/*; do
        # Obtener el número del ejemplar (nombre del archivo sin extensión)
        numero_ejemplar=$(basename "$archivo_libro" | cut -f1 -d'.')
        # Crear el título del libro concatenando el nombre de la serie y el número del ejemplar
        titulo_libro="${nombre_serie} ${numero_ejemplar}"
        
        echo $titulo_libro
        # Agregar el libro a Calibre
        #calibredb add --title "$titulo_libro" --authors "Nombre del Autor" "$archivo_libro"
        calibredb add --title "$titulo_libro" --series "$nombre_serie" --series-index "${numero_ejemplar}" --tag "Historietas, Retro Pdf"  "$archivo_libro"
    done
done

