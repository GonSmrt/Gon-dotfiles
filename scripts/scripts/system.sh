detect_system() {

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
DESKTOP="${XDG_CURRENT_DESKTOP:-Desconocido}"


echo "🧠 Sistema detectado: $PRETTY_NAME"
echo "📦 Gestor de paquetes: $PKG_MANAGER"
echo "💻 Arquitectura: $ARCH"
echo "🖥️ Escritorio: $DESKTOP"


}
