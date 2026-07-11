install_deps() {

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
        fontconfig \
	
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

}
