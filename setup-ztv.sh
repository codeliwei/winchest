#!/bin/sh -

ZTV_ROOT=$PWD

cd $HOME

if [ ! -d .oh-my-zsh ]; then
	git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh || exit
fi
cp $ZTV_ROOT/llseek.zsh-theme ./.oh-my-zsh/themes/
chsh -s `which zsh`

if [ -f .zshrc ]; then
	rm -i .zshrc
fi
cp $ZTV_ROOT/.zshrc .zshrc

if [ -f .tmux.conf ]; then
	rm -i .tmux.conf
fi
cp $ZTV_ROOT/.tmux.conf .tmux.conf

if [ -f .vimrc ]; then
	rm -i .vimrc
fi
cp $ZTV_ROOT/.vimrc .vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
