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

#-----------------------------------
# INSTALACIÓN DE RECURSOS VISUALES
#-----------------------------------

source "$SCRIPT_DIR/scripts/resources.sh"
resources_install

#-------------------------
# Autoinstalador
#-------------------------

print_section "Personalización del escritorio"

echo "🖥️ Aplicando configuración para: $DESKTOP"


apply_desktop_config() {

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

	apply_kde_lookandfeel() {
		CURRENT_THEME=$(kreadconfig6 --file plasmarc --group Theme --key name)

	if [ "$CURRENT_THEME" != "Otto" ]; then
		plasma-apply-lookandfeel --apply Otto
		echo "✅ Look & Feel Otto aplicado"
	else
		echo "✅ Otto ya estaba aplicado"
	fi

}

	apply_kde_colors() {
		CURRENT_COLOR=$(kreadconfig6 --file kdeglobals --group General --key ColorScheme)

	if [ "$CURRENT_COLOR" != "Otto" ]; then
		plasma-apply-colorscheme Otto
		plasma-apply-colorscheme -a "#3DAEE9"
		echo "✅ Esquema de colores Otto aplicado"
	else
		echo "✅ Otto ya estaba aplicado"

	fi

}

	apply_kde_icons() {
		CURRENT_ICON=$(kreadconfig6 --file kdeglobals --group Icons --key Theme)

	if [ "$CURRENT_ICON" != "Papirus-Dark" ]; then
		kwriteconfig6 --file kdeglobals --group Icons --key Theme Papirus-Dark
		echo "✅ Iconos Papirus-Dark aplicados"
	else
		echo "✅ Papirus-Dark ya estaba aplicado"
	fi

}

	apply_kde_cursor() {
		CURRENT_CURSOR=$(kreadconfig6 --file kcminputrc --group Mouse --key cursorTheme)

	if [ "$CURRENT_CURSOR" != "oxy-neon" ]; then
		plasma-apply-cursortheme oxy-neon
		echo "✅ Cursor oxy-neon aplicado"
	else
		echo "✅ oxy-neon ya estaba aplicado"
	fi

}

        apply_kde() {

                apply_kde_lookandfeel
                apply_kde_colors
                apply_kde_icons
                apply_kde_cursor

}

apply_kde

	;;

	    Hyprland)

	    echo "🚧 Soporte para Hyprland pendiente."


	;;

	*)

	    echo "⚠️ Escritorio '$DESKTOP' no soportado todavía."

	    ;;


    esac
}

apply_desktop_config

# ------------------------
# FINAL
# ------------------------

print_section "Finalizando"

echo "✅ Instalación completada"
echo "💡 Ejecuta: exec zsh"
