resources_install() {

install_common_resources() {

echo "🎨 Instalando temas..."

mkdir -p "$HOME/.themes"

if [ -d "$HOME/.themes/Orchis-Dark" ]; then

    echo "✅ Orchis-Dark ya estaba instalado"

elif [ -d "$REPO_DIR/resources/themes/Orchis-Dark" ]; then
	cp -a "$REPO_DIR/resources/themes/Orchis-Dark" "$HOME/.themes/"
	echo "✅ Orchis-Dark instalado"

else
    echo "❌ Orchis-Dark no se encontró"

fi

echo "🖼️ Instalando iconos..."

mkdir -p "$HOME/.icons"

if [ -d "$HOME/.icons/Papirus-Dark" ]; then

    echo "Papirus-Dark ya estaba instalado"

elif [ -d "$REPO_DIR/resources/icons/Papirus-Dark" ]; then
    cp -a "$REPO_DIR/resources/icons/Papirus-Dark" "$HOME/.icons/"

    echo "✅ Papirus-Dark instalado"
else
    echo "❌ Papirus-Dark no se encontró"

fi

}

install_otto() {


mkdir -p "$HOME/.local/share/plasma/look-and-feel"

if [ -d "$HOME/.local/share/plasma/look-and-feel/Otto" ]; then
        echo "✅ Otto ya estaba instalado"

elif [ -d "$REPO_DIR/resources/look-and-feel/Otto" ]; then

        cp -a "$REPO_DIR/resources/look-and-feel/Otto" "$HOME/.local/share/plasma/look-and-feel/"
        echo "✅ Otto instalado"

else
        echo "❌ Otto no encontrado"

fi

}

install_oxygen_neon() {

command -v git >/dev/null || {
        echo "❌ Git no está instalado."
        return 1
}

if [ -d "$HOME/.local/share/icons/oxy-neon" ]; then
        echo "🖱️ Oxygen Neon ya está instalado."
        return
fi

local TMP
TMP=$(mktemp -d)

trap 'rm -rf "$TMP"' RETURN

echo "🖱️ Descargando Oxygen Neon..."


if ! git clone \
        --depth 1 \
        https://github.com/mesonjod/linux-oxygen-neon-cursors.git \
        "$TMP/oxygen"; then
	
	echo "❌ No se pudo descargar Oxygen Neon."
	return 1
fi

if [ ! -d "$TMP/oxygen/index.theme" ]; then
	echo "❌ El cursor no se encontró en el repositorio."
	return 1
fi

echo "🖱️ Instalando Oxygen Neon..."

mkdir -p "$HOME/.local/share/icons"

if cp -a \
        "$TMP/oxygen" \
        "$HOME/.local/share/icons/"; then
	echo "✅ Cursor instalado."

else

	echo "❌ Error instalando el cursor."
	return 1

fi
}

install_kde_resources() {

	echo "⚙️ Recursos de KDE"

	install_otto
	install_oxygen_neon


}
install_hyprland_resources() {

	echo "🚧 Pendiente"

}


install_resources() {

install_common_resources

case "$DESKTOP" in

	*KDE*)
	    install_kde_resources
	    ;;

	*Hyprland*)
	    install_hyprland_resources
	    ;;

	esac

}


print_section "Instalación de recursos visuales"
install_resources

}
