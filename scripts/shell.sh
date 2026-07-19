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

install_zsh_plugins() {

	echo "🔌 Instalando plugins de ZSH..."

	local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

	# zsh-autosuggestions

	if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then

		echo "✅ zsh-autosuggestions ya instalado"
	else
		git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

		echo "✅ zsh-autosuggestions instalado"

	fi

	# zsh-syntax-highlighting

	if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then

		echo "✅ zsh-syntax-highlighting ya instalado"
	else
		git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

		echo "✅ zsh-syntax-highlighting instalado"
	fi

}

install_oh_my_zsh
install_powerlevel10k
install_zsh_plugins
}
