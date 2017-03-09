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
https://github.com/ctrlpvim/ctrlp.vim
https://github.com/kien/rainbow_parentheses.vim
https://github.com/godlygeek/tabular
https://github.com/mbbill/undotree
https://github.com/vim-airline/vim-airline
https://github.com/bronson/vim-trailing-whitespace
https://github.com/valloric/youcompleteme
https://github.com/tpope/vim-fugitive
#https://github.com/xolox/vim-easytags
https://github.com/xolox/vim-misc
https://github.com/guns/xterm-color-table.vim.git
https://github.com/majutsushi/tagbar
git://github.com/airblade/vim-gitgutter.git
https://github.com/tomtom/tcomment_vim
https://github.com/dyng/ctrlsf.vim
https://github.com/jiangmiao/auto-pairs
git://github.com/roman/golden-ratio.git
https://github.com/junegunn/goyo.vim
https://github.com/blueyed/vim-diminactive
https://github.com/myusuf3/numbers.vim.git
https://github.com/ryanoasis/vim-devicons
https://github.com/mhinz/vim-startify
https://github.com/scrooloose/nerdtree.git
https://github.com/tiagofumo/vim-nerdtree-syntax-highlight.git
https://github.com/Xuyuanp/nerdtree-git-plugin.git
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
echo "================================Copying fonts to ~/.fonts/ "
if [ ! -d ~/.local/share/fonts ] ; then
    mkdir ~/.local/share/fonts
fi
cp --verbose * ~/.local/share/fonts
#/usr/share/nvim/runtime/colors
#make sure we neovim stuffs
echo "================================Linking nvim "
cd "$SOURCE/nvim-plugs"
ln -fv dark.vim ~/.config/nvim/bundle/vim-airline/autoload/airline/themes/
ln -fv init.vim ~/.config/nvim/
echo "================================Need password to access /usr/share/nvim/runtime/colors/ to put in snow.vim and .adb in /bin/"
sudo ln -fv snow.vim /usr/share/nvim/runtime/colors/snow.vim

#resources time
echo "================================Linking bashrc and inputrc to home "
cd "$SOURCE"
ln -fv .bashrc ~/.bashrc
ln -fv .inputrc ~/.inputrc
ln -fv .tmux.conf ~/.tmux.conf
sudo ln -fv .adb /bin/adb.txt

echo "================================Linking wallpapers to Pictures "
cd "$SOURCE/ims"
ln -fv elemental.jpg ~/Pictures

echo "================================And finally, terminix's json "
cd "$SOURCE/terminalix"
ln -fv snow.json ~/.config/terminix/schemes

echo "================================Fin linking!"
