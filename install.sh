SOURCE=${PWD}

#make sure they have pathogen...
PATHOGEN=~/.config/nvim/autoload
if [ ! -d "$PATHOGEN" ] ; then
	echo "================================curling pathogen! "
	mkdir -p ~/.vim/autoload ~/.vim/bundle
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
else
	echo "================================Already have pathogen; if not delete autoload, and rerun this. "
fi

#make sure we have all the plugins we need!
declare -a GITURLS=(
 https://github.com/ctrlpvim/ctrlp.vim.git
 https://github.com/kien/rainbow_parentheses.vim.git
 https://github.com/godlygeek/tabular.git
 https://github.com/mbbill/undotree.git
 https://github.com/vim-airline/vim-airline.git
 https://github.com/bronson/vim-trailing-whitespace.git
 https://github.com/valloric/youcompleteme.git
 https://github.com/tpope/vim-fugitive.git
 https://github.com/Valloric/vim-operator-highlight.git
 https://github.com/xolox/vim-easytags.git
 https://github.com/xolox/vim-misc.git
 );

cd ~/.config/nvim/bundle/
for URL in ${GITURLS[@]}; do
    gitdir=$(basename "$URL")
    if [ ! -d $gitdir ] ; then
        echo "================================$gitdir Already exists! "
    else
        echo "================================$gitdir not found, going to clone! "
	#git clone "$URL"
    fi
done

#make sure we have nice font
cd "$SOURCE/fonts"
echo "================================Copying fonts to ~/.fonts/ "
if [ ! -d "~/.fonts"] ; then
    mkdir ~/.fonts
fi
cp --verbose * ~/.fonts

#/usr/share/nvim/runtime/colors
#make sure we neovim stuffs
echo "================================Linking nvim "
cd "$SOURCE/nvim-plugs"
ln -fv dark.vim ~/.config/nvim/bundle/vim-airline/autoload/airline/themes/
ln -fv init.vim ~/.config/nvim/
echo "================================Need password to access /usr/share/nvim/runtime/colors/ to put in snow.vim"
sudo ln -fv snow.vim /usr/share/nvim/runtime/colors/snow.vim

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
ln -fv snow.json ~/.config/terminix/

echo "================================Fin linking!
