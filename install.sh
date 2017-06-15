SOURCE=${PWD}
#make sure we have nice font
cd "$SOURCE/fonts"
echo "================================Copying fonts to ~/.local/share/fonts/ "
if [ ! -d ~/.local/share/fonts ] ; then
    mkdir ~/.local/share/fonts
fi
cp * ~/.local/share/fonts

#make sure we neovim stuffs
echo "================================Linking nvim "
if [ ! -d ~/.config/nvim/colors ] ; then
    mkdir ~/.config/nvim/colors
fi
cd "$SOURCE/nvim-plugs"
ln -fv init.vim ~/.config/nvim/
ln -fv plug.vim ~/.config/nvim/
ln -fv Chill.vim ~/.config/nvim/colors/
ln -fv air.vim ~/.local/share/nvim/plugged/vim-airline-themes/autoload/airline/themes/base16_twilight.vim

#resources time
echo "================================Linking bashrc,inputrc, and tmux to home "
cd "$SOURCE"
ln -fv .bashrc ~/.bashrc
#ln -fv .bash_aliases ~/.bash_aliases
ln -fv .inputrc ~/.inputrc
ln -fv .tmux.conf ~/.tmux.conf

echo "================================Installing FZF : "
if [ ! -d ~/.fzf ] ; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi
echo "================================Finished FzF"

echo "Fin installing."
