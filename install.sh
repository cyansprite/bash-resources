SOURCE=${PWD}

#make sure they have pathogen...
PATHOGEN=~/.config/nvim/autoload
if [ ! -d "$PATHOGEN" ] ; then
    echo "================================curling pathogen! "
    mkdir -p ~/.config/nvim/autoload ~/.config/nvim/bundle
    curl -LSso ~/.config/nvim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
else
    echo "================================Already have pathogen; if not delete autoload, and rerun this. "
fi

#make sure we have all the plugins we need!
declare -a GITURLS=(
    https://github.com/eugen0329/vim-esearch.git
    https://github.com/godlygeek/tabular
    https://github.com/bronson/vim-trailing-whitespace
    https://github.com/valloric/youcompleteme
    https://github.com/tpope/vim-fugitive
    https://github.com/ryanoasis/vim-devicons
    https://github.com/dietsche/vim-lastplace
    https://github.com/gelguy/cmd2.vim
    https://github.com/xolox/vim-misc
    https://github.com/xolox/vim-notes
    https://github.com/ctrlpvim/ctrlp.vim
    https://github.com/jsfaint/gen_tags.vim.git
    https://github.com/scrooloose/nerdtree
    https://github.com/tacahiroy/ctrlp-funky
    https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
    https://github.com/Shougo/deoplete.nvim
    https://github.com/Shougo/neco-vim
);

cd ~/.config/nvim/bundle/
for URL in ${GITURLS[@]}; do
    gitdir=$(basename "$URL")
    if [ -d $gitdir ] ; then
        echo "================================$gitdir Already exists! "
    else
        echo "================================$gitdir not found, going to clone! "
        git clone "$URL"
    fi
done

#make sure we have nice font
cd "$SOURCE/fonts"
echo "================================Copying fonts to ~/.local/share/fonts/ "
if [ ! -d ~/.local/share/fonts ] ; then
    mkdir ~/.local/share/fonts
    cp * ~/.local/share/fonts
else
    echo "Fonts dir already exists!"
fi

#/usr/share/nvim/runtime/colors
#make sure we neovim stuffs
echo "================================Linking nvim "
cd "$SOURCE/nvim-plugs"
if [ ! -d ~/.config/nvim/colors ] ; then
    mkdir ~/.config/nvim/colors
fi
if [ ! -d ~/.config/nvim/after/syntax ] ; then
    mkdir -p ~/.config/nvim/after/syntax
fi
if [ ! -d ~/.local/share/fonts ] ; then
    mkdir ~/.local/share/fonts
    cp * ~/.local/share/fonts
fi
ln -fv init.vim ~/.config/nvim/
ln -fv init.vim ~/.vimrc
ln -fv cyansprite.vim ~/.config/nvim/colors

#resources time
echo "================================Linking bashrc and inputrc to home "
cd "$SOURCE"
ln -fv .bashrc ~/.bashrc
ln -fv .inputrc ~/.inputrc
ln -fv .tmux.conf ~/.tmux.conf

echo "================================Linking wallpapers to Pictures "
cd "$SOURCE/ims"
ln -fv elemental.jpg ~/Pictures

echo "================================And finally, terminix's json "
cd "$SOURCE/terminalix"
ln -fv snow.json ~/.config/terminix/schemes
ln -fv shadow.json ~/.config/terminix/schemes

echo "================================Fin linking!"
