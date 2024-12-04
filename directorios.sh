#!/bin/bash

mostrar_menu() {
    echo "Seleccione una operación:"
    echo "1. Crear un nuevo archivo"
    echo "2. Eliminar un archivo"
    echo "3. Copiar un archivo"
    echo "4. Salir"
}

listar_archivos() {
    echo "Archivos en el directorio $DIRECTORIO:"
    ls -lh "$DIRECTORIO" | awk '{print $9 ": " $5}' 
}


validar_archivo() {
    if [ ! -e "$DIRECTORIO/$1" ]; then
        echo "El archivo '$1' no existe en el directorio '$DIRECTORIO'."
        return 1
    fi
    return 0
}


crear_archivo() {
    read -p "Ingrese el nombre del nuevo archivo: " nombre_archivo
    touch "$DIRECTORIO/$nombre_archivo"
    echo "Archivo '$nombre_archivo' creado."
}


eliminar_archivo() {
    read -p "Ingrese el nombre del archivo a eliminar: " nombre_archivo
    if validar_archivo "$nombre_archivo"; then
        rm "$DIRECTORIO/$nombre_archivo"
        echo "Archivo '$nombre_archivo' eliminado."
    fi
}


copiar_archivo() {
    read -p "Ingrese el nombre del archivo a copiar: " nombre_archivo
    if validar_archivo "$nombre_archivo"; then
        read -p "Ingrese el nombre del nuevo archivo: " nuevo_nombre
        cp "$DIRECTORIO/$nombre_archivo" "$DIRECTORIO/$nuevo_nombre"
        echo "Archivo '$nombre_archivo' copiado como '$nuevo_nombre'."
    fi
}


read -p "Ingrese el directorio que desea utilizar: " DIRECTORIO


if [ ! -d "$DIRECTORIO" ]; then
    echo "El directorio no existe. Saliendo..."
    exit 1
fi


listar_archivos


while true; do
    mostrar_menu
    read -p "Seleccione una opción: " opcion

    case $opcion in
        1) crear_archivo ;;
        2) eliminar_archivo ;;
        3) copiar_archivo ;;
        4) echo "Saliendo..."; exit 0 ;;
        *) echo "Opción no válida. Intente nuevamente." ;;
    esac


    listar_archivos
done
