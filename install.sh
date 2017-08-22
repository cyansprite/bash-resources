winorlin=$(uname -s)
echo "Environment :" $winorlin

SOURCE=${PWD}
echo "PWD:" $SOURCE

if [ $winorlin = "Linux" ]; then
    #make sure we have nice font
    cd "$SOURCE/fonts"
    echo "================================Copying fonts to ~/.local/share/fonts/ "
    if [ ! -d ~/.local/share/fonts ] ; then
        mkdir ~/.local/share/fonts
    fi
    cp * ~/.local/share/fonts

    #resources time
    echo "================================Linking bashrc,zshrc, inputrc, and tmux to home "
    cd "$SOURCE"
    ln -fv .bashrc ~/.bashrc
    ln -fv .zshrc ~/.zshrc
    ln -fv .inputrc ~/.inputrc
    ln -fv .tmux.conf ~/.tmux.conf
fi

#make sure we neovim stuffs
echo "================================Linking nvim "

configdir=""
localdir=""

if [ $winorlin = "Linux" ]; then
    configdir=~/.config/nvim
    localdir=~/.local/share/nvim
    echo $configdir
elif [ $winorlin = "Windows" ]; then
    configdir=~/AppData/Local/nvim
    localdir=~/AppData/Local/nvim-data
else
    echo "Something went wrong"
fi

if [ ! -d $configdir/colors ] ; then
    mkdir $configdir/colors
fi

cd "$SOURCE/nvim-plugs"
ln -fv init.vim $configdir/
ln -fv plug.vim $configdir/

echo "Fin installing."
