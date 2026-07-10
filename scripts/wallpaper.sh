install_wallpaper() {

print_section "Wallpaper"

echo "🖼️ Copiando wallpapers..."

mkdir -p "$HOME/Pictures/Wallpapers"
cp -r "$REPO_DIR/resources/wallpapers/." "$HOME/Pictures/Wallpapers/"

}
