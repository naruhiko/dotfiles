#!/bin/sh

set -ue
cd


echo -e "\n
             .__  .__    ____   ____.___   _____    \n
  ____  __ __|  | |  |   \   \ /   /|   | /     \   \n
 /    \|  |  \  | |  |    \   Y   / |   |/  \ /  \  \n
|   |  \  |  /  |_|  |__   \     /  |   /    Y    \ \n
|___|  /____/|____/____/    \___/   |___\____|__  / \n
     \/                                         \/  \n "

echo " ------------ Homebrew ------------"
read -p "Install Homebrew ? (y/n)" Answer < /dev/tty
case ${Answer} in
  y|Y) 

    echo "Start Install Homebrew..."
    apt install build-essential curl file

    git clone https://github.com/Homebrew/brew ~/linuxbrew/.linuxbrew/Homebrew
    mkdir ~/linuxbrew/.linuxbrew/bin
    ln -s ~/linuxbrew/.linuxbrew/Homebrew/bin/brew ~/linuxbrew/.linuxbrew/bin
    eval $(~/linuxbrew/.linuxbrew/bin/brew shellenv)

    echo "Homebrew Installed" ;;

  n|N)
    echo "Skipped" ;;

esac

echo "------------ zsh ------------"
read -p "Change the Shell into zsh ? (y/n)" Answer < /dev/tty
case ${Answer} in
  y|Y)
    brew install zsh zsh-syntax-highlighting
    echo ${__pass} | sudo -S -- sh -c 'echo '/usr/local/bin/zsh' >> /etc/shells' 
    chsh -s /usr/local/bin/zsh 
    FILE="${HOME}/.bash_profile"

        if [[ -e ${FILE} ]]; then
          source ${FILE} >> ~/.zshrc
        elif [[ ! -e ${FILE} ]]; then
          touch ${FILE}
        fi

    source ~/.zshrc

    ;;

  n|N)
    echo "Skipped" ;;
esac


echo "---------- nvim & tmux ----------"
echo "processing..."
mkdir .config/nvim
brew install nvim tmux python
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.config/nvim/dein
echo "finished"

echo "---------- zprezto ----------"
echo "processing..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}" done

echo "finished"

echo "---------- cloning naruhiko mods. ----------"
sudo ln -s ~/dotfiles/.config/nvim/dein.toml ~/.config/nvim/dein.toml
sudo ln -s ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
sudo ln -s ~/dotfiles/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
sudo ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
sudo ln -sf ~/dotfiles/.zpreztorc ~/.zpreztorc
sudo ln -sf ~/dotfiles/.zprofile ~/.zprofile
sudo ln -sf ~/dotfiles/.zshenv ~/.zshenv
sudo ln -sf ~/dotfiles/.zshrc ~/.zshrc
echo "FINISHED!"
