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
ln -fv cyansprite.vim ~/.config/nvim/colors

#resources time
echo "================================Linking bashrc,inputrc, and tmux to home "
cd "$SOURCE"
ln -fv .bashrc ~/.bashrc
ln -fv .bash_aliases ~/.bash_aliases
ln -fv .inputrc ~/.inputrc
ln -fv .tmux.conf ~/.tmux.conf

echo "================================And finally, tilix's json "
cd "$SOURCE/tilix"
if [ ! -d ~/.config/tilix/schemes ] ; then
    mkdir -p ~/.config/tilix/schemes
fi
ln -fv cyansprite.json ~/.config/tilix/schemes

cd "$SOURCE/vscode"
echo "================================Linking vscode things"
ln -fv settings.json /home/joj/.config/Code/User/settings.json
ln -fv keybindings.json /home/joj/.config/Code/User/keybindings.json

echo "================================Fin linking!"

echo "================================Installing FZF : "
if [ ! -d ~/.fzf ] ; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
else
    echo "FZF already exists!"
fi
