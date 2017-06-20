winorlin=$(uname -s)

SOURCE=${PWD}

if [ $winorlin == "Linux" ]; then
    #make sure we have nice font
    cd "$SOURCE/fonts"
    echo "================================Copying fonts to ~/.local/share/fonts/ "
    if [ ! -d ~/.local/share/fonts ] ; then
        mkdir ~/.local/share/fonts
    fi
    cp * ~/.local/share/fonts

    #resources time
    echo "================================Linking bashrc,inputrc, and tmux to home "
    cd "$SOURCE"
    ln -fv .bashrc ~/.bashrc
    #ln -fv .bash_aliases ~/.bash_aliases
    ln -fv .inputrc ~/.inputrc
    ln -fv .tmux.conf ~/.tmux.conf
fi

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
=======
configdir=""
localdir=""

if [ $winorlin == "Linux" ]; then
    configdir=~/.config/nvim
    localdir=~/.local/share/nvim
    echo $configdir
elif [ $winorlin == "Windows" ]; then
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
ln -fv Chill.vim $configdir/colors/
ln -fv ~=+.config=+nvim=+init.vim= $localdir/view/
ln -fv ~=+.config=+nvim=+plug.vim= $localdir/view/

echo "Fin installing."
