repo_setup() {

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

}
