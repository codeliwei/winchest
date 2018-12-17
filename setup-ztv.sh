#!/usr/bin/env bash

ZTV_ROOT=$PWD

if [ `uname -s` == 'Darwin' ]; then
  PKG_INSTALL='brew -y install'
elif [[ $(cat /etc/os-release) =~ "SUSE" ]]; then
  PKG_INSTALL='sudo zypper --non-interactive install'
else
  PKG_INSTALL='sudo apt -y install'
fi

git config user.email "yxj@gmail.com"
git config user.name "Xiaojie Yuan"
git config core.editor vim
git config push.default simple

cd $HOME

$PKG_INSTALL git                \
             zsh                \
             tmux               \
             vim                \
             ctags              \
             global

if [ ! -d .oh-my-zsh ]; then
	git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh || exit
fi

cp $ZTV_ROOT/llseek.zsh-theme ./.oh-my-zsh/themes/

echo "Enter your sudo passwd to chsh: "
chsh -s `which zsh`

for f in .zshrc .tmux.conf .vimrc; do
  mv $f $f.old
  ln -s $ZTV_ROOT/$f
done

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

echo '    StrictHostKeyChecking no' | sudo tee -a /etc/ssh/ssh_config
echo '    UserKnownHostsFile /dev/null' | sudo tee -a /etc/ssh/ssh_config
