Create_backups() {

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

}
