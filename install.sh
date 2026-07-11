#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

source "$SCRIPT_DIR/scripts/system.sh"
detect_system

# ------------------------
# REPO
# ------------------------

source "$SCRIPT_DIR/scripts/repo.sh"
repo_setup

# ------------------------
# DEPENDENCIAS
# ------------------------

source "$SCRIPT_DIR/scripts/deps.sh"
install_deps

# ------------------------
# SHELL
# ------------------------

source "$SCRIPT_DIR/scripts/shell.sh"
install_shell

# ------------------------
# BACKUPS
# ------------------------

source "$SCRIPT_DIR/scripts/buckups.sh"
Create_backups

# ------------------------
# HOME  DOTFILES
# ------------------------

source "$SCRIPT_DIR/scripts/hdotfiles.sh"
install_hdotfiles

#-------------------------
# CONFIG DOTFILES
#-------------------------

source "$SCRIPT_DIR/scripts/configdotfiles.sh"
config_dotfiles

#-------------------------
# WALLPAPER
#-------------------------

source "$SCRIPT_DIR/scripts/wallpaper.sh"
install_wallpaper

#------------------------
# Fuentes
#-----------------------

source "$SCRIPT_DIR/scripts/fonts.sh"
install_fonts

#------------------------
# TEMAS E ICONOS
#------------------------

print_section "Temas e iconos"

echo "🎨 Instalando temas..."

mkdir -p "$HOME/.themes"

if [ -d "$HOME/.themes/Orchis-Dark" ]; then

    echo "✅ Orchis-Dark ya estaba instalado"

elif [ -d "$REPO_DIR/resources/themes/Orchis-Dark" ]; then
	cp -r "$REPO_DIR/resources/themes/Orchis-Dark" "$HOME/.themes/"
	echo "✅ Orchis-Dark instalado"

else
    echo "❌ Orchis-Dark no se encontró"

fi

echo "🖼️ Instalando iconos..."

mkdir -p "$HOME/.icons"

if [ -d "$HOME/.icons/Papirus-Dark" ]; then

    echo "Papirus-Dark ya estaba instalado"

elif [ -d "$REPO_DIR/resources/icons/Papirus-Dark" ]; then
    cp -r "$REPO_DIR/resources/icons/Papirus-Dark" "$HOME/.icons/"

    echo "✅ Papirus-Dark instalado"
else
    echo "❌ Papiirus-Dark no se encontró"

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
