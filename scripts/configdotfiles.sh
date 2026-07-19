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

apply_nanorc() {

	echo "📝 Configurando nano..."

	if [ -f "$REPO_DIR/config/nano/nanorc" ]; then

	if [ -f /etc/nanorc ]; then
		sudo cp /etc/nanorc /etc/nanorc.backup
		echo "📦 Backup de /etc/nanorc creado"
else
		echo "📦 Backup de /etc/nanorc ya existe"

fi


		sudo cp "$REPO_DIR/config/nano/nanorc" /etc/nanorc
		echo "✅ Configuración de nano aplicada"
	else
		echo "❌ nanorc no encontrado en el repo"
	fi

}

apply_nanorc

}
