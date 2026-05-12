#!/bin/bash

#Actualizar sistema
echo -e "\e[1;30;47m->Actualizando el sistema<-\e[0m"
sudo pacman -Syu --noconfirm

Instalacion de paquetes basicos
echo -e "\e[1;30;47mInstalacion de paquetes basicos...\e[0m"
sudo pacman -S --noconfirm \
	firefox \
	pavucontrol \
	pipewire \
	pipewire-audio \
	pipewire-alsa \
	pipewire-pulse \
	wireplumber \
	neovim \
	git \
	xorg \
	base-devel \
	brightnessctl \
	redshift \
	lsd \
	gparted \
	gpick \
	qbittorrent \
	bluez \
	bluez-utils \
	blueman \
	rofi \
	zsh \
	zip \
	unzip \
	kitty \
	bat \
	firejail \
	firetools \
	feh \
	tlp \
	imagemagick \
	lightdm-gtk-greeter-settings \
	plank \
	btop

echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[0m"
set -e
#Creacion de variables
TMP_DIR="/tmp/nerd-fonts"
FONT_DIR="$HOME/.local/share/fonts/nerd-fonts"

#Creacion de directorios
mkdir -p "$TMP_DIR"
mkdir -p "$FONT_DIR"

#Urls de descargas
URL_3270="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/3270.zip"
URL_JETBRAINS="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"

echo "==> Descargando 3270 Nerd Font..."
curl -L -o "$TMP_DIR/3270.zip" "$URL_3270"

echo "==> Descargando JetBrains Mono Nerd Font..."
curl -L -o "$TMP_DIR/JetBrainsMono.zip" "$URL_JETBRAINS"

echo "Descomprimiendo 3270..."
unzip -o "$TMP_DIR/3270.zip" -d "$TMP_DIR/3270"

echo "Descomprimiendo JetBrains Mono..."
unzip -o "$TMP_DIR/JetBrainsMono.zip" -d "$TMP_DIR/JetBrainsMono"

echo "Copiando fuentes 3270..."
cp "$TMP_DIR/3270/"*.ttf "$FONT_DIR"

echo "Copiando fuentes JetBrains Mono..."
cp "$TMP_DIR/JetBrainsMono/"*.ttf "$FONT_DIR"

echo "Actualizando caché de fuentes..."
fc-cache -fv

echo "Limpiando archivos temporales..."
rm -rf "$TMP_DIR"

echo "¡Fuentes Nerd Fonts 3270 y JetBrains Mono instaladas correctamente!"



echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[0m"
echo -e "\e[1;30;47m->Cambiando la configuracion de kitty...<-\e[0m"
mkdir -p ~/.config/kitty
mv kitty.conf ~/.config/kitty/

echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[0m"
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[0m"
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[0m"
#Instalcion de yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

#Instalacion de paquetes yay
echo -e "\e[1;30;47mInstalacion de paquetes de AUR...\e[0m"
yay -S --noconfirm \
	brave-bin \
	spotify \
	visual-studio-code-bin \
	optimus-manager

echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[0m"

#Levantar servicios bluetooth
echo -e "\e[1;30;47mHabilitando servicio bluetooth\e[0m"
sudo systemctl enable bluetooth.service
echo -e "\e[1;30;47mIniciando servicio bluetooth\e[0m"
sudo systemctl start bluetooth.service
echo -e "\e[1;30;47mVerificando status bluetooth\e[0m"
systemctl status bluetooth.service --no-pager 

echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[0m"


#Seleccionara zsh como shell
echo -e "\e[1;30;47mCambiando de Shell\e[0m"
sudo chsh -s /usr/bin/zsh
#Instalando oh my zsh
echo -e "\e[1;30;47mInstalando oh-my-zsh\e[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo -e "\e[1;30;47mClonando algunos pluggins\e[0m"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[0m"



# Instalar los paquetes necesarios para VirtualBox
echo -e "\e[1;30;47mInstalando Virtualbox y dependencias...\e[0m"

sudo pacman -S --noconfirm virtualbox virtualbox-host-modules-arch \
	linux-headers

echo -e "\e[1;30;47mCargando los modulos del kernel\e[0m"
sudo modprobe vboxdrv


echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[0m"
echo -e "\e[1;30;47mCambiando el tema de ZSH\e[0m"



echo -e "\e[1;35mInstalacion completada con exito\e[0m"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="obraun"/' ~/.zshrc
echo -e "\e[1;30;47mInsertanod pluggins...\e[0m"
sed -i 's/plugins=(git)/plugins=(git\n zsh-autosuggestions\n zsh-syntax-highlighting)/' ~/.zshrc
echo -e "\e[1;30;47Asignando alias...m\e[0m"
echo 'alias ls="lsd"' >> ~/.zshrc
echo 'alias upd="sudo pacman -Syu --noconfirm"' >> ~/.zshrc

echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[0m"

echo -e "\e[1;30;47mMoviendo archivos .rasi a la carpeta de temas rofi\e[0m"
sudo mv spotlightdark.rasi personalizado.rasi /usr/share/rofi/themes

echo -e "\e[1;30;47mCreando directorio...\e[0m"
mkdir ~/.config/rofi

echo -e "\e[1;30;47mConfigurando rofi...\e[0m"
mv config.rasi ~/.config/rofi


echo -e "\e[1;30;47mConfigurando Optimus Manager...\e[0m"
echo -e "\e[1;30;47mHabilitando servicio de Optimus Manager...\e[0m"
sudo systemctl enable optimus-manager.service
echo -e "\e[1;30;47mIniciando servicio de Optimus Manager...\e[0m"
sudo systemctl start optimus-manager.service


echo -e "\e[1;30;47mHabilitando servicios para audio...\e[0m"
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse wireplumber

echo -e "\e[1;30;47mAgregando tema de plank...\e[0m"
unzip arian-plank-theme-light.zip
sudo mv /Arian\ Theme\ Light /usr/share/plank/themes/

echo "DESCOMPRIMIENDO ARCHIVOS"
tar -xvf macOS.tar.xz

echo "BORRANDO ARCHIVOS"
rm -rf LICENSE macOS.tar.xz

echo "MOVIENDO ARCHIVOS"
sudo mv macOS* /usr/share/icons/

echo -e "\e[1;30;47mBorrando configuracion antigua de plank...\e[0m"
sudo rm -rf ~/.config/plank/*
echo -e "\e[1;30;47mCambiando dock de plank...\e[0m"
sudo mv dock1 ~/.config/plank/
