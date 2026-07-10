#!/bin/bash
set -euo pipefail

print_section() {
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "▶ $1"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

print_banner() {
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🚀 Instalador Gon dotfiles"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo
}

print_banner

# ------------------------
# DETECCIÓN DEL SISTEMA
# ------------------------

source scripts/system.sh
detect_system

# ------------------------
# REPO
# ------------------------

source scripts/repo.sh
repo_setup

# ------------------------
# DEPENDENCIAS
# ------------------------

source scripts/deps.sh
install_deps

# ------------------------
# SHELL
# ------------------------

source scripts/shell.sh
install_shell

# ------------------------
# BACKUPS
# ------------------------

print_section "Creando backups"

backup_file() {

    # Si ya es un symlink, no hacemos backup
    if [ -L "$1" ]; then
	echo "✅ Ya es un symlink: $1"
	return
    fi

    if [ -e "$1" ]; then
        echo "💾 Backup: $1"
        mv "$1" "$1.backup.$(date +%s)"
    fi
}

backup_file "$HOME/.zshrc"
backup_file "$HOME/.p10k.zsh"
backup_file "$HOME/.gitconfig"


# ------------------------
# HOME  DOTFILES
# ------------------------

print_section "Instalando home dotfiles"

echo "🔗 Aplicando dotfiles..."

ln -sf "$REPO_DIR/home/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$REPO_DIR/home/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$REPO_DIR/home/.gitconfig" "$HOME/.gitconfig"

#-------------------------
# CONFIG DOTFILES
#-------------------------

print_section "Configuraciones"

echo "⚙️ Instalando Fastfetch..."
echo "⚙️ Instalando Kitty..."

# fastfetch (más robusto que glob)
mkdir -p "$HOME/.config/fastfetch"
cp -r "$REPO_DIR/config/fastfetch/." "$HOME/.config/fastfetch/"

# kitty (terminal mamalóna)
mkdir -p "$HOME/.config/kitty"
cp -r "$REPO_DIR/config/kitty/." "$HOME/.config/kitty/"


#-------------------------
# WALLPAPER
#-------------------------

print_section "Wallpaper"

echo "🖼️ Copiando wallpapers..."

mkdir -p "$HOME/Pictures/Wallpapers"
cp -r "$REPO_DIR/resources/wallpapers/." "$HOME/Pictures/Wallpapers/"


#------------------------
# Fuentes
#-----------------------

print_section "Fuentes"

echo "🔤 Instalando fuentes..."

mkdir -p "$HOME/.local/share/fonts"

cp -r "$REPO_DIR/resources/fonts/." "$HOME/.local/share/fonts/"

echo "🔤 Actualizando caché de fuentes..."

fc-cache -f

echo "✅ Caché de fuentes actualizada"

#------------------------
# TEMAS E ICONOS
#------------------------

print_section "Temas e iconos"

echo "🎨 Instalando temas..."

mkdir -p "$HOME/.themes"

if [ -d "$REPO_DIR/resources/themes/Orchis-Dark" ]; then
    cp -r "$REPO_DIR/resources/themes/Orchis-Dark" "$HOME/.themes/"

    echo "✅ Orchis-Dark instalado"
else
    echo "✅ Orchis-Dark ya estaba instalado"

fi

echo "🖼️ Instalando iconos..."

mkdir -p "$HOME/.icons"

if [ -d "$REPO_DIR/resources/icons/Papirus-Dark" ]; then
    cp -r "$REPO_DIR/resources/icons/Papirus-Dark" "$HOME/.icons/"

    echo "✅ Papirus-Dark instalado"
else
    echo "✅ Papirus-Dark ya estaba instalado"

fi


#-------------------------
# Autoinstalador
#-------------------------

print_section "Personalización del escritorio"

echo "🖥️ Aplicando configuración para: $DESKTOP"


apply_desktop_theme() {

	case "$DESKTOP" in

	    Cinnamon|X-Cinnamon)

		CURRENT_THEME=$(gsettings get org.cinnamon.desktop.interface gtk-theme | tr -d "'")

		if [ "$CURRENT_THEME" != "Orchis-Dark" ]; then
	    	    gsettings set org.cinnamon.desktop.interface gtk-theme "Orchis-Dark"
	    	    echo "✅ Tema Orchis-Dark aplicado"
		else
	    	    echo "✅ Orchis-Dark ya estaba aplicado"
		fi

		CURRENT_ICON=$(gsettings get org.cinnamon.desktop.interface icon-theme | tr -d "'")

		if [ "$CURRENT_ICON" != "Papirus-Dark" ]; then
	    	    gsettings set org.cinnamon.desktop.interface icon-theme "Papirus-Dark"
		    echo "✅ Iconos Papirus-Dark aplicados"
		else
		    echo "✅ Papirus-Dark ya estaba aplicado"
		fi


	;;

	    KDE)

	    echo "🚧 Soporte para KDE pendiente."


	;;

	    Hyprland)

	    echo "🚧 Soporte para Hyprland pendiente."


	;;

	*)

	    echo "⚠️ Escritorio '$DESKTOP' no soportado todavía."

	    ;;


    esac
}

apply_desktop_theme

# ------------------------
# FINAL
# ------------------------

print_section "Finalizando"

echo "✅ Instalación completada"
echo "💡 Ejecuta: exec zsh"
