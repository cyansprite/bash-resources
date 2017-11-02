SOURCE=${PWD}

# make sure we have nice font
cd "$SOURCE/fonts"
echo "========================================================================="
echo "Copying fonts to ~/.local/share/fonts/ "
echo "========================================================================="
if [ ! -d ~/.local/share/fonts ] ; then
    mkdir ~/.local/share/fonts
fi
cp * ~/.local/share/fonts
echo ""

# resources time
echo "========================================================================="
echo "Linking dotfiles to home "
echo "========================================================================="
cd "$SOURCE"
if [ ! -d ~/.config/i3 ] ; then
    mkdir ~/.config/i3
fi
ln -fv .bashrc ~/.bashrc
ln -fv .bash_aliases ~/.bash_aliases
ln -fv .dircolors ~/.dircolors
ln -fv .inputrc ~/.inputrc
ln -fv .gitconfig ~/.gitconfig
ln -fv .tmux.conf ~/.tmux.conf
ln -fv .Xdefaults ~/.Xdefaults
ln -fv .Xresources-demi ~/.Xresources-demi
ln -fv .Xresources-kitsune ~/.Xresources-kitsune
ln -fv .Xdefaults ~/.Xdefaults
ln -fv .i3status.conf ~/.i3status.conf
ln -fv .i3config ~/.config/i3/config
ln -fv .settings.ini /home/joj/.config/gtk-3.0/settings.ini
xrdb .Xresources-$(hostname)

echo ""

# make sure we neovim stuffs
echo "========================================================================="
echo "Linking nvim"
echo "========================================================================="
configdir=~/.config/nvim
localdir=~/.local/share/nvim

cd "$SOURCE/nvim-plugs"
ln -fv init.vim $configdir/
ln -fv plug.vim $configdir/
ln -fv default.vim ~/.local/share/nvim/plugged/LeaderF/autoload/leaderf/colorscheme/default.vim
echo ""

if [ ! -d ~/.fzf ] ; then
    # make sure we have fzf, yes to all options
    echo "========================================================================="
    echo "Installing fzf"
    echo "========================================================================="
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    yes | ~/.fzf/install
    echo ""
else
    echo "========================================================================="
    echo "FZF already installed."
    echo "========================================================================="
fi

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ] ; then
    echo "========================================================================="
    echo "Installing plug.vim"
    echo "========================================================================="
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo ""
else
    echo "========================================================================="
    echo "Plug already installed."
    echo "========================================================================="
fi

if hash nvim 2>/dev/null; then
    echo "========================================================================="
    echo "Neovim already installed."
    echo "========================================================================="
else
    dash $SOURCE/neovim.sh
    echo ""
fi

echo "========================================================================="
echo "Fin installing."
echo "========================================================================="
