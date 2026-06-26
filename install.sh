#!/bin/bash
set -e

echo "🚀 Instalando dotfiles v3..."

# ------------------------
# DETECCIÓN DEL SISTEMA
# ------------------------

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "❌ Sistema no soportado"
    exit 1
fi

echo "🧠 Sistema detectado: $OS"

# ------------------------
# REPO
# ------------------------

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

case "$OS" in
    ubuntu|linuxmint|debian)
        install_deps_ubuntu
        ;;
    *)
        echo "⚠️ Sistema no soportado para instalación automática de deps"
        ;;
esac

# ------------------------
# BACKUPS
# ------------------------

backup_file() {
    if [ -e "$1" ]; then
        echo "💾 Backup: $1"
        mv "$1" "$1.backup.$(date +%s)"
    fi
}

backup_file "$HOME/.zshrc"
backup_file "$HOME/.p10k.zsh"
backup_file "$HOME/.gitconfig"

# ------------------------
# DOTFILES
# ------------------------

echo "🔗 Aplicando dotfiles..."

ln -sf "$REPO_DIR/home/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$REPO_DIR/home/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$REPO_DIR/home/.gitconfig" "$HOME/.gitconfig"

# fastfetch (más robusto que glob)
mkdir -p "$HOME/.config/fastfetch"
cp -r "$REPO_DIR/config/fastfetch/." "$HOME/.config/fastfetch/"

# ------------------------
# FINAL
# ------------------------

echo "✅ Instalación completada"
echo "💡 Ejecuta: exec zsh"
