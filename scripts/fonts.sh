install_fonts() {

print_section "Fuentes"

echo "🔤 Instalando fuentes..."

mkdir -p "$HOME/.local/share/fonts"

cp -r "$REPO_DIR/resources/fonts/." "$HOME/.local/share/fonts/"

echo "🔤 Actualizando caché de fuentes..."

fc-cache -f

echo "✅ Caché de fuentes actualizada"

}
