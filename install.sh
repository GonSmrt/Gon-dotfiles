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

if [ -f /etc/os-release ]; then
  # shellcheck source=/etc/os-release 
 . /etc/os-release
    OS=$ID
else
    echo "❌ Sistema no soportado"
    exit 1
fi

case "$OS" in
    ubuntu|linuxmint|debian)
     PKG_MANAGER="apt"
        ;;
    arch|cachyos)
     PKG_MANAGER="pacman"
        ;;
    *)
     PKG_MANAGER="desconocido"
        ;;
esac

ARCH=$(uname -m)

echo "🧠 Sistema detectado: $PRETTY_NAME"
echo "📦 Gestor de paquetes: $PKG_MANAGER"
echo "💻 Arquitectura: $ARCH"

# ------------------------
# REPO
# ------------------------

print_section "Repositorio"

REPO_DIR="$HOME/gon-dotfiles"

if [ -d "$REPO_DIR/.git" ]; then
    echo "📦 Repo existente → actualizando"
    git -C "$REPO_DIR" pull
else
    echo "📥 Clonando repo"
    git clone https://github.com/GonSmrt/Gon-dotfiles.git "$REPO_DIR"
fi

cd "$REPO_DIR"

# ------------------------
# DEPENDENCIAS
# ------------------------

print_section "Instalando dependencias"

install_deps_ubuntu() {
    echo "📦 Instalando dependencias (apt)..."

    sudo apt update

    sudo apt install -y \
        zsh \
        git \
        fastfetch \
        btop \
        cava \
        curl \
        wget \
        unzip \
        fontconfig
}

install_deps_arch() {
    echo "📦 Instalando dependencias (pacman)..."

    sudo pacman -Syu --needed \
        zsh \
        git \
        fastfetch \
        btop \
        cava \
        curl \
        wget \
        unzip \
        fontconfig
}


case "$OS" in
    ubuntu|linuxmint|debian)
        install_deps_ubuntu
        ;;
 
    arch|cachyos)
       install_deps_arch
        ;;

   *)
       echo "⚠️ Sistema no soportado para instalación automática de deps"
        ;;
esac

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


# ------------------------
# FINAL
# ------------------------

print_section "Finalizando"

echo "✅ Instalación completada"
echo "💡 Ejecuta: exec zsh"
