SOURCE=${PWD}
#make sure we have nice font
cd "$SOURCE/fonts"
echo "================================Copying fonts to ~/.local/share/fonts/ "
if [ ! -d ~/.local/share/fonts ] ; then
    mkdir ~/.local/share/fonts
    cp * ~/.local/share/fonts
else
    echo "Fonts dir already exists!"
fi

#make sure we neovim stuffs
echo "================================Linking nvim "
cd "$SOURCE/nvim-plugs"
if [ ! -d ~/.config/nvim/colors ] ; then
    mkdir ~/.config/nvim/colors
fi
ln -fv init.vim ~/.config/nvim/
ln -fv init.vim ~/.vimrc
ln -fv cyansprite.vim ~/.config/nvim/colors
ln -fv cyanair.vim ~/.config/nvim/bundle/repos/github.com/vim-airline/vim-airline/autoload/airline/themes/
ln -fv cyanair.vim ~/.config/nvim/bundle/.cache/init.vim/.dein/autoload/airline/themes/

#resources time
echo "================================Linking bashrc,inputrc, and tmux to home "
cd "$SOURCE"
ln -fv .bashrc ~/.bashrc
ln -fv .bash_aliases ~/.bash_aliases
ln -fv .inputrc ~/.inputrc
ln -fv .tmux.conf ~/.tmux.conf
ln -fv .xbinkeysrc ~/.xbindkeysrc

echo "================================Linking wallpapers to Pictures "
cd "$SOURCE/ims"
ln -fv elemental.jpg ~/Pictures

echo "================================And finally, tilix's json "
cd "$SOURCE/tilix"
if [ ! -d ~/.config/tilix/schemes ] ; then
    mkdir -p ~/.config/tilix/schemes
fi
ln -fv cyansprite.json ~/.config/tilix/schemes

echo "================================Fin linking!"

if [ ! -d ~/.fzf ] ; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
else
    echo "FZF already exists!"
fi
