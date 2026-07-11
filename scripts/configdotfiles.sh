config_dotfiles() {

print_section "Configuraciones"

echo "⚙️ Aplicando configuración de Fastfetch..."
echo "⚙️ IAplicando configuración de Kitty..."

# fastfetch (más robusto que glob)
mkdir -p "$HOME/.config/fastfetch"
cp -r "$REPO_DIR/config/fastfetch/." "$HOME/.config/fastfetch/"

# kitty (terminal mamalóna)
mkdir -p "$HOME/.config/kitty"
cp -r "$REPO_DIR/config/kitty/." "$HOME/.config/kitty/"

}
