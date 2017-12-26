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
cp -v .bashrc ~/.bashrc
cp -v .bash_aliases ~/.bash_aliases
cp -v .dircolors ~/.dircolors
cp -v .inputrc ~/.inputrc
cp -v .gitconfig ~/.gitconfig
cp -v .tmux.conf ~/.tmux.conf
cp -v .Xdefaults ~/.Xdefaults
cp -v .Xresources-demi ~/.Xresources-demi
cp -v .Xresources-kitsune ~/.Xresources-kitsune
cp -v .Xdefaults ~/.Xdefaults

echo ""

# make sure we neovim stuffs
echo "========================================================================="
echo "Linking nvim"
echo "========================================================================="
configdir=~/.config/nvim
localdir=~/.local/share/nvim

cd "$SOURCE/nvim-plugs"
cp -v init.vim $configdir/
cp -v plug.vim $configdir/
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
