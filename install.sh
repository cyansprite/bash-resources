#make sure they have pathogen...
PATHOGEN=~/.vim/autoload
if [ ! -d "$PATHOGEN" ] ; then
	echo "curling pathogen!"
	mkdir -p ~/.vim/autoload ~/.vim/bundle 
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	echo "fin curling pathogen"
else
	echo "Already have pathogen; if not delete autotload, and rerun this."
fi

#make sure we have all the plugins we need!
declare -a GITURLS=(
 https://github.com/ctrlpvim/ctrlp.vim.git
 https://github.com/scrooloose/nerdtree
 https://github.com/kien/rainbow_parentheses.vim
 https://github.com/godlygeek/tabular
 https://github.com/mbbill/undotree
 https://github.com/vim-airline/vim-airline
 https://github.com/vim-airline/vim-airline-themes.git
 git://github.com/tpope/vim-dispatch.git
 https://github.com/bronson/vim-trailing-whitespace
 https://github.com/edkolev/promptline.vim.git 
 https://github.com/vim-syntastic/syntastic.git
 https://github.com/valloric/youcompleteme
 );

INDEX=0
cd ~/.vim/bundle/
for URL in ${GITURLS[@]}; do
	git clone "$URL"
done

echo "All repos done!"

#make sure we have our resource files
declare -a RSFILES=(.vimrc .bashrc);
echo "Copying .vimrc and .bashrc to Home folder!"
for RS in ${RSFILES[@]} ; do
	cp --verbose -i $RS ~/$RS
done
echo "finished with resource files!!"

#make sure we have our bin files
declare -a BINFILES=(.xclip.sh);
echo "Copying bin files to ~/bin!"
for RS in ${BINFILES[@]} ; do
	cp --verbose -i $RS ~/bin/$RS
done
echo "fin with bin!!"

if [ ! -f ~/bin/vcprompt ]; then
echo "pulling vcprompt for .bashrc!"
       	curl -sL https://github.com/djl/vcprompt/raw/master/bin/vcprompt > ~/bin/vcprompt
	chmod 755 ~/bin/vcprompt
echo "done pulling vcprompt and making it executable!"
else
	echo "Vcprompt already exists!"
fi
