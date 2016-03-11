#!/bin/sh -

ZTV_ROOT=$PWD

cd $HOME

sudo apt-get install zsh tmux vim -y

if [ ! -d .oh-my-zsh ]; then
	git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh || exit
fi
cp $ZTV_ROOT/llseek.zsh-theme ./.oh-my-zsh/themes/

hostname_dfl=`cat /etc/hostname`
echo -n "Enter your hostname(default '$hostname_dfl'): "
read hostname
if [ -z $hostname ]; then
	hostname=$hostname_dfl
fi
sed -i "s/127.0.0.1/$hostname/g" ./.oh-my-zsh/themes/llseek.zsh-theme

echo "Enter your sudo passwd to chsh: "
chsh -s `which zsh`

if [ -f .zshrc ]; then
	rm -i .zshrc
fi
cp $ZTV_ROOT/.zshrc .zshrc

if [ -f .tmux.conf ]; then
	rm -i .tmux.conf
fi
ln -s $ZTV_ROOT/.tmux.conf

if [ -f .vimrc ]; then
	rm -i .vimrc
fi
ln -s $ZTV_ROOT/.vimrc

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall
