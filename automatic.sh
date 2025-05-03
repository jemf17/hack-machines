#!/bin/bash

# Función de ayuda
mostrar_ayuda() {
    echo "Uso: $0 [OPCIÓN] <nombre>"
    echo "Opciones:"
    echo "  -h          Mostrar ayuda"
    echo "  -m <nombre> Crear máquina HTB (Active)"
    echo "  -r <nombre> Crear máquina HTB (Retired)"
    echo "  -t <nombre> Crear room THM (Beginner-Paths)"
    echo "  -c <nombre> Crear cheatsheet"
    echo "  -T <nombre> Crear herramienta en Tools/"
    echo ""
    echo "Ejemplos:"
    echo "  $0 -m Spectral"
    echo "  $0 -t OhS"
    exit 1
}

# Función para crear directorios
crear_estructura() {
    local plataforma="$1"
    local path="$2"
    local nombre="$3"

    echo "Creando $plataforma/$path/$nombre..."
    mkdir -p "$plataforma/$path/$nombre" || { echo "❌ Error al crear directorio"; exit 1; }
    cd "$plataforma/$path/$nombre" || exit
    touch Writeup.md Notes.md
    mkdir -p Screenshots Scripts
    echo "✅ Estructura creada en: $(pwd)"
}

# Procesar opciones
while getopts ":hm:r:t:c:T:" opt; do
    case $opt in
        h) mostrar_ayuda ;;
        m) crear_estructura "HTB" "Active" "$OPTARG" ;;
        r) crear_estructura "HTB" "Retired" "$OPTARG" ;;
        t) crear_estructura "THM" "Beginner-Paths" "$OPTARG" ;;
        c) 
            mkdir -p Cheatsheets
            touch "Cheatsheets/$OPTARG.md"
            echo "📝 Cheatsheet creada: Cheatsheets/$OPTARG.md"
            ;;
        T) 
            mkdir -p Tools
            touch "Tools/$OPTARG.sh"
            chmod +x "Tools/$OPTARG.sh"
            echo "🛠️ Herramienta creada: Tools/$OPTARG.sh"
            ;;
        \?) echo "❌ Opción inválida: -$OPTARG" >&2; mostrar_ayuda ;;
        :) echo "❌ Falta argumento para -$OPTARG" >&2; mostrar_ayuda ;;
    esac
done

# Validar si no se pasaron opciones
if [ $OPTIND -eq 1 ]; then
    echo "❌ Error: No se especificó ninguna opción."
    mostrar_ayuda
fi