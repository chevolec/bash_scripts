#!/bin/bash

# Ruta de la carpeta que contiene los archivos rar
CARPETA_ORIGEN="/mnt/libros/temp2"

# Ruta de la biblioteca Calibre
CARPETA_CALIBRE="/mnt/libros/books/CalibreLibrary/metadata.db"

# Cambia al directorio de la carpeta de origen
cd "$CARPETA_ORIGEN" || exit

# Itera sobre todos los archivos rar en la carpeta
for archivo_rar in *.rar; do
    # Extrae el nombre de la serie de la carpeta interna del archivo rar
    nombre_serie=$(unrar lb "$archivo_rar" | head -n 1)
    echo "$archivo_rar"
    echo $nombre_serie
    
    # Itera sobre los archivos dentro del rar
    unrar e "$archivo_rar" "$nombre_serie"/*.rar
    for libro in "$nombre_serie"/*.rar; do
        # Extrae el número del ejemplar del nombre del archivo
        numero_ejemplar=$(echo "$libro" | grep -oP '\d+(?=.rar)')
        
        # Construye el título del libro concatenando nombre de la serie y número del ejemplar
        titulo_libro="${nombre_serie}_Ejemplar_${numero_ejemplar}"
        
        # Agrega el libro a la biblioteca de Calibre
        calibredb add --library-path="$CARPETA_CALIBRE" "$libro" --title="$titulo_libro" --series="$nombre_serie"
        
        # Elimina el archivo extraído
        rm "$libro"
    done
done

