# Bash Scripts

Colección de scripts bash para facilitar tareas comunes.

## Scripts Principales

### renamefilewithdirectory.sh

Renombra archivos PDF concatenando el nombre de la carpeta padre al nombre del archivo. Si el nombre del archivo es un número, lo padded con ceros a la izquierda (ej: 1 → 001). También elimina comas del nombre.

**Uso:**
```bash
./renamefilewithdirectory.sh <ruta_carpeta>
```

### pdf_title_rename.sh

Renombra archivos PDF y actualiza sus metadatos (título) usando `exiftool`. Si el nombre del archivo es un número, lo padded a 3 dígitos.

**Uso:**
```bash
./pdf_title_rename.sh <ruta_carpeta>
```

**Dependencias:** `exiftool`

### renamefile.sh

Renombra un archivo reemplazando caracteres en el nombre. Por defecto reemplaza espacios con guiones bajos.

**Uso:**
```bash
./renamefile.sh <archivo> [caracter_a_reemplazar] [caracter_reemplazo]
```

**Ejemplos:**
```bash
./renamefile.sh "mi archivo.txt"           # "mi_archivo.txt"
./renamefile.sh "mi-archivo.txt" "_" "-"  # "mi_archivo.txt"
```

### pingall.sh

Hace ping a un rango de direcciones IP secuenciales.

**Uso:**
```bash
./pingall.sh <prefijo_ip> <inicio> <fin>
```

**Ejemplo:**
```bash
./pingall.sh 192.168.1 1 254  # Ping a 192.168.1.1 - 192.168.1.254
```

### checkBrokenLinks.sh

Verifica enlaces rotos desde una lista (`urls.lst`) y los elimina de un archivo de bookmarks (`bookmarks.html`). Genera una lista de enlaces rotos en `del.lst`.

**Dependencias:** `wget`

**Archivos requeridos:**
- `urls.lst` - Lista de URLs a verificar
- `bookmarks.html` - Archivo de bookmarks

### convert_cdr_png.sh

Convierte archivos CDR (CorelDRAW) a PNG usando Inkscape. Busca archivos en `/tmp/cdr_files/`.

**Dependencias:** `inkscape`

**Uso:**
```bash
# Mettre les fichiers .cdr dans /tmp/cdr_files/
./convert_cdr_png.sh
```

---

## Scripts add2calibre/

Colección de scripts para agregar cómics/libros a Calibre desde archivos RAR.

### add2calibre.sh

Extrae archivos RAR y los importa a Calibre con título y serie.

**Rutas configuradas:**
- Origen: `/mnt/libros/temp/`
- Destino extracción: `/mnt/libros/temp3/`

### NameWithNumber.sh

Similar a `add2calibre.sh` pero extrae el número de ejemplar del nombre del archivo y lo usa como series-index.

**Tags:** `Historietas, Classic Pdf`

### NameWithNumberAndDate.sh

Similar a `NameWithNumber.sh` pero también intenta extraer y procesar una fecha del nombre del archivo.

**Tags:** `Historietas, Retro Pdf`

### LosSupersabios.sh

Versión específica para la serie "Los Supersabios". Funcionalidad idéntica a `NameWithNumber.sh`.

### filenameIsNumber.sh

Usa el nombre del archivo directamente como series-index (cuando el nombre es numérico).

**Rutas:**
- Origen: `/mnt/libros/SubirCalibre/origen/`
- Destino: `/mnt/libros/SubirCalibre/destino/`

**Tags:** `Historietas, Retro Pdf`

---

## Scripts tools/

### gsync

Sincroniza repositorios Git entre WSL y Windows. Realiza un push desde WSL y luego un pull en el repositorio Windows correspondiente.

**Uso:**
```bash
gsync              # Auto-detectar proyecto desde git remote
gsync <proyecto>   # Especificar proyecto manualmente
```

**Proyectos configurados:**
- `Skoll`
- `FoxSync`
- `Skoll_Windows`
- `Transfer`

**Dependencias:** Git, PowerShell (Windows)

---

## Notas

- Algunos scripts requieren dependencias específicas (ver arriba)
- Los scripts de add2calibre asumen que Calibre está instalado y configurado
- Los scripts de sincronización WSL/Windows requieren acceso a PowerShell
