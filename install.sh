SOURCE=${PWD}

#make sure we have dein



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

#resources time
echo "================================Linking bashrc,inputrc, and tmux to home "
cd "$SOURCE"
ln -fv .bashrc ~/.bashrc
ln -fv .inputrc ~/.inputrc
ln -fv .tmux.conf ~/.tmux.conf

echo "================================Linking wallpapers to Pictures "
cd "$SOURCE/ims"
ln -fv elemental.jpg ~/Pictures

echo "================================And finally, tilix's json "
cd "$SOURCE/tilix"
#ln -fv snow.json ~/.config/tilix/schemes
#ln -fv shadow.json ~/.config/tilix/schemes

echo "================================Fin linking!"

if [ ! -d ~/.local/share/fonts ] ; then
    mkdir ~/.local/share/fonts
    cp * ~/.local/share/fonts
else
    echo "Fonts dir already exists!"
fi
