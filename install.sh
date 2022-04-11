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
ln -fv .bashrc ~/.bashrc
ln -fv .Xdefaults ~/.Xdefaults
ln -fv .bash_aliases ~/.bash_aliases
ln -fv .dircolors ~/.dircolors
ln -fv .inputrc ~/.inputrc
ln -fv .gitconfig ~/.gitconfig
ln -fv .tmux.conf ~/.tmux.conf
if [ ! -d ~/.tmux/plugins/tpm ] ; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
ln -fv .Xdefaults ~/.Xdefaults
ln -fv .Xresources-demi ~/.Xresources-demi
ln -fv .Xresources-kitsune ~/.Xresources-kitsune
ln -fv .Xdefaults ~/.Xdefaults

echo ""

# make sure we neovim stuffs
echo "========================================================================="
echo "Linking nvim"
echo "========================================================================="

if [ ! -d ~/.config/nvim ] ; then
    mkdir -p ~/.config/nvim
fi

cd "$SOURCE/nvim-plugs"
ln -fv init.vim ~/.config/nvim/
ln -fv plug.vim ~/.config/nvim/
ln -fv plug.vim ~/.config/nvim/
ln -fv coc-settings.json ~/.config/nvim/coc-settings.json

echo ""

echo "========================================================================="
echo "Installing fzf"
echo "========================================================================="
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
echo ""

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ] ; then
    echo "========================================================================="
    echo "Installing plug.vim"
    echo "========================================================================="
    if hash curl 2>/dev/null; then
        echo "========================================================================="
        echo "Curl already installed."
        echo "========================================================================="
    else
        yes | sudo apt-get install curl
        echo ""
    fi
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo ""
else
    echo "========================================================================="
    echo "Plug already installed."
    echo "========================================================================="
fi

# for fzf preview
if hash tree 2>/dev/null; then
    echo "========================================================================="
    echo "Tree already installed."
    echo "========================================================================="
else
    yes | sudo apt-get install tree
fi
if hash bat 2>/dev/null; then
    echo "========================================================================="
    echo "Bat already installed."
    echo "========================================================================="
else
    yes | sudo apt-get install bat
    ln -s /usr/bin/batcat ~/bin/bat
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
