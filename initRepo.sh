#!/bin/bash

# 1. Verificar GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "❌ Error: GitHub CLI (gh) no está instalado. Ejecuta 'gh auth login' primero."
    exit 1
fi

# 2. Validar argumentos
REPO_NAME=$1
if [ -z "$REPO_NAME" ]; then
    echo "❓ Uso: ../init_repo.sh nombre-del-repo"
    exit 1
fi

CURRENT_DIR=$(pwd)

# 3. Confirmación detallada
echo "------------------------------------------------"
echo "🔐 INICIALIZADOR DE REPOSITORIO PRIVADO"
echo "------------------------------------------------"
echo "📂 Carpeta local: $CURRENT_DIR"
echo "🌐 Nombre en GitHub: $REPO_NAME (PRIVATE)"
echo "------------------------------------------------"
read -p "¿Confirmas la creación y subida? (s/n): " CONFIRM

if [[ $CONFIRM != "s" && $CONFIRM != "S" ]]; then
    echo "🚫 Operación abortada."
    exit 1
fi

# 4. Crear .gitignore si no existe
if [ ! -f "$CURRENT_DIR/.gitignore" ]; then
    echo "📝 Generando .gitignore predeterminado..."
    cat <<EOF > .gitignore
__pycache__/
*.py[cod]
venv/
.env
.vscode/
node_modules/
dist/
.DS_Store
*.TMP
*.OUT
*Zone.Identifier
FEMA
codex.session
opencode.session
localData
# Ignorar archivos del storage pero mantener la carpeta
storage/*.md
!storage/.gitkeep
EOF
fi

# 5. Ejecución de Git
echo "⚙️  Inicializando Git y primer commit..."
git init
git add .
git commit -m "Initial commit: Estructura base privada"

# 6. Crear repo en GitHub como PRIVADO
echo "🌐 Creando repositorio remoto PRIVADO y haciendo push..."
# Cambiado --public por --private
gh repo create "$REPO_NAME" --private --source=. --remote=origin --push

echo "------------------------------------------------"
echo "✅ ¡Éxito! Tu repositorio privado está listo."
echo "🔗 URL: https://github.com/$(gh api user -q .login)/$REPO_NAME"
echo "------------------------------------------------"
