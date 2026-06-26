#!/bin/bash

set -e

echo "🚀 Instalando dotfiles..."

REPO_DIR="$HOME/gon-dotfiles"

# Clonar repo si no existe
if [ ! -d "$REPO_DIR" ]; then
    git clone git@github.com:GonSmrt/Gon-dotfiles.git "$REPO_DIR"
fi

cd "$REPO_DIR"

echo "📦 Instalando zsh config..."
ln -sf "$REPO_DIR/home/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$REPO_DIR/home/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

echo "📦 Instalando git config..."
ln -sf "$REPO_DIR/home/.gitconfig" "$HOME/.gitconfig"

echo "📦 Instalando fastfetch..."
mkdir -p "$HOME/.config/fastfetch"
ln -sf "$REPO_DIR/config/fastfetch"/* "$HOME/.config/fastfetch/"

echo "✅ Listo!"
