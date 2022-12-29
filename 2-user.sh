#!/usr/bin/env bash
#-------------------------------------------------------------------------
#   █████╗ ██████╗  ██████╗██╗  ██╗████████╗██╗████████╗██╗   ██╗███████╗
#  ██╔══██╗██╔══██╗██╔════╝██║  ██║╚══██╔══╝██║╚══██╔══╝██║   ██║██╔════╝
#  ███████║██████╔╝██║     ███████║   ██║   ██║   ██║   ██║   ██║███████╗
#  ██╔══██║██╔══██╗██║     ██╔══██║   ██║   ██║   ██║   ██║   ██║╚════██║
#  ██║  ██║██║  ██║╚██████╗██║  ██║   ██║   ██║   ██║   ╚██████╔╝███████║
#  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝   ╚═╝    ╚═════╝ ╚══════╝
#-------------------------------------------------------------------------

echo -e "\nINSTALLING AUR SOFTWARE\n"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.

echo "CLONING: YAY"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd ~
touch "$HOME/.cache/zshhistory"
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
cp "$HOME/lambda-zsh-theme/cdimascio-lambda.zsh-theme" $ZSH_CUSTOM/themes
git clone git@github.com:fearlessspider/dotfiles.git
ln -s "$HOME/dotfiles/.zshrc" $HOME/.zshrc
ln -s "$HOME/dotfiles/.p10k.zsh" $HOME/.p10k.zsh

PKGS=(
'autojump'
'awesome-terminal-fonts'
'firefox-bin' # Brave Browser
'dxvk-bin' # DXVK DirectX to Vulcan
'lightly-git'
'lightlyshaders-git'
'nerd-fonts-fira-code'
'nordic-darker-standard-buttons-theme'
'nordic-darker-theme'
'nordic-kde-git'
'nordic-theme'
'noto-fonts-emoji'
'papirus-icon-theme'
'plasma-pa'
'ocs-url' # install packages from websites
'sddm-nordic-theme-git'
'snapper-gui-git'
'ttf-droid'
'ttf-hack'
'ttf-meslo' # Nerdfont package
'ttf-roboto'
'zoom' # video conferences
'snap-pac'
'fuse'
'glib2' # JetBrains Toolbox depedency
'libxslt'
'libxss'
'xcb-util-keysyms'
'xdg-utils'
'nss'
'dbeaver' # Database client
'postgresql'
'docker'
'nvm'
'obs-studio'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

export PATH=$PATH:~/.local/bin
cp -r $HOME/ArchTitus/dotfiles/* $HOME/.config/
pip install konsave
konsave -i $HOME/ArchTitus/kde.knsv
sleep 1
konsave -a kde

# Databases
sudo -iu postgres
initdb -D /var/lib/postgres/data
exit

# Docker
sudo usermod -aG docker $USER

# NVM
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc

echo -e "\nDone!\n"
exit
