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
echo "Linking bashrc, inputrc, and tmux to home "
echo "========================================================================="
cd "$SOURCE"
ln -fv .bashrc ~/.bashrc
ln -fv .bash_aliases ~/.bash_aliases
ln -fv .inputrc ~/.inputrc
ln -fv .gitconfig ~/.gitconfig
ln -fv .tmux.conf ~/.tmux.conf
echo ""

# make sure we neovim stuffs
echo "========================================================================="
echo "Linking nvim"
echo "========================================================================="
configdir=~/.config/nvim
localdir=~/.local/share/nvim

if [ ! -d $configdir/colors ] ; then
    mkdir -p $configdir/colors
fi

cd "$SOURCE/nvim-plugs"
ln -fv init.vim $configdir/
ln -fv plug.vim $configdir/
ln -fv chill.vim $configdir/colors/
echo ""

if [ ! -d ~/.fzf ] ; then
    # make sure we have fzf, yes to all options
    echo "========================================================================="
    echo "Installing fzf"
    echo "========================================================================="
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    yes | ~/.fzf/install
    echo ""
fi

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ] ; then
    echo "========================================================================="
    echo "Installing plug.vim"
    echo "========================================================================="
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo ""
fi

if hash nvim 2>/dev/null; then
    echo "========================================================================="
    echo "Neovim already installed, run neovim.sh if you need python || xsel."
    echo "========================================================================="
else
    dash $SOURCE/neovim.sh
fi
echo ""

echo "========================================================================="
echo "Fin installing."
echo "========================================================================="
