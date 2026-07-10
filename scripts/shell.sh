install_shell() {

print_section "Shell"

install_oh_my_zsh() {

	if [ -d "$HOME/.oh-my-zsh" ]; then
	    echo "✅ Oh My Zsh ya estaba instalado"
	else
	    echo "🐚 Instalando Oh My Zsh..."
	    git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"

	    echo "✅ Oh My Zsh instalado"
	fi
}


install_powerlevel10k() {

	if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
	    echo "✅ Powerlevel10k ya estaba instalado"
	else
	    echo "🎨 Instalando Powerlevel10k..."
	    git clone https://github.com/romkatv/powerlevel10k.git  "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
	    echo "✅ Powerlevel10k instalado"
	fi
}

install_oh_my_zsh
install_powerlevel10k

}
