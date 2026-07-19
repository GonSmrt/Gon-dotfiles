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

source "$SCRIPT_DIR/scripts/desktop.sh"
apply_desktop

# ------------------------
# FINAL
# ------------------------

print_section "Finalizando"

echo "✅ Instalación completada"
echo "💡 Ejecuta: exec zsh"
