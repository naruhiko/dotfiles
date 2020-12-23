#!/bin/bash

set -ue
cd

echo -e "\n
             .__  .__    ____   ____.___   _____    
  ____  __ __|  | |  |   \   \ /   /|   | /     \   
 /    \|  |  \  | |  |    \   Y   / |   |/  \ /  \  
|   |  \  |  /  |_|  |__   \     /  |   /    Y    \ 
|___|  /____/|____/____/    \___/   |___\____|__  / 
     \/                                         \/  "

echo " ------------ Homebrew ------------"
read -p "Install Homebrew ? (y/n)" Answer < /dev/tty
case ${Answer} in
  y|Y)
    if [[ -d ~/linuxbrew ]]
    then
      echo "Already exist"
    else
      echo "Start Install Homebrew..."
      apt install build-essential curl file
      git clone https://github.com/Homebrew/brew ~/linuxbrew/.linuxbrew/Homebrew
      mkdir ~/linuxbrew/.linuxbrew/bin
      ln -sf ~/linuxbrew/.linuxbrew/Homebrew/bin/brew ~/linuxbrew/.linuxbrew/bin
      eval $(~/linuxbrew/.linuxbrew/bin/brew shellenv)
      echo "Homebrew Installed" 
    fi ;;
  n|N)
    echo "Skipped" ;;
esac

echo "------------ zsh ------------"
read -p "Change the Shell into zsh ? (y/n)" Answer < /dev/tty
case ${Answer} in
  y|Y)
    if [[ -d ~/linuxbrew/.linuxbrew/bin/zsh ]]
    then
      echo "Already exist"
    else
      echo 'Defaults env_keep += "PATH"' >> /etc/sudoers
      sed -i -e "s/Defaults secure_path/\#Defaults secure_path/g" /etc/sudoers
      brew install zsh zsh-syntax-highlighting
      echo '/root/linuxbrew/.linuxbrew/bin/zsh' >> /etc/shells 
    fi
    chsh -s /root/linuxbrew/.linuxbrew/bin/zsh
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
if [[ -d .config ]]
then
  echo "Already exist config file"
else
  mkdir .config
  cd .config
  mkdir nvim
fi
cd
brew install nvim tmux python
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.config/nvim/dein
echo "finished"

echo "---------- zprezto ----------"
echo "processing..."
if [[ -d /root/.zprezto ]]
then
  echo "Skipped cloning zpezto"
else
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi
echo "finished"

echo "---------- cloning naruhiko mods. ----------"
 ln -s ~/dotfiles/.config/nvim/dein.toml ~/.config/nvim/dein.toml
 ln -s ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
 ln -s ~/dotfiles/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
 ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
 ln -sf ~/dotfiles/.zpreztorc ~/.zpreztorc
 ln -sf ~/dotfiles/.zprofile ~/.zprofile
 ln -sf ~/dotfiles/.zshenv ~/.zshenv
 ln -sf ~/dotfiles/.zshrc ~/.zshrc
 echo 'source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"' >> .zshrc
echo "FINISHED!"
/root/linuxbrew/.linuxbrew/bin/zsh
