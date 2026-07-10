install_hdotfiles() {

print_section "Instalando home dotfiles"

echo "🔗 Aplicando dotfiles..."

ln -sf "$REPO_DIR/home/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$REPO_DIR/home/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$REPO_DIR/home/.gitconfig" "$HOME/.gitconfig"

}
