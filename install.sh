#make sure they have pathogen...
PATHOGEN=~/.vim/autoload
if [ ! -d "$PATHOGEN" ] ; then
	echo -d $PATHOGEN
	echo "curling pathogen!"
	mkdir -p ~/.vim/autoload ~/.vim/bundle 
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	echo "fin curling pathogen"
else
	echo "Already have pathogen; if not delete autotload, and rerun this."
fi

#make sure we have all the plugins we need!
declare -a GITFOLDERS=(~/.vim/bundle/indentline
 ~/.vim/bundle/tabular
 ~/.vim/bundle/vim-dispatch
 ~/.vim/bundle/vim-airline-themes
 ~/.vim/bundle/nerdtree
 ~/.vim/bundle/vim-trailing-whitespace
 ~/.vim/bundle/vim-airline
 ~/.vim/bundle/rainbow_parentheses.vim
 ~/.vim/bundle/undotree);

declare -a GITURLS=(https://github.com/yggdroot/indentline
 https://github.com/scrooloose/nerdtree
 https://github.com/kien/rainbow_parentheses.vim
 https://github.com/godlygeek/tabular
 https://github.com/mbbill/undotree
 https://github.com/vim-airline/vim-airline
 https://github.com/vim-airline/vim-airline-themes.git
 git://github.com/tpope/vim-dispatch.git
 https://github.com/bronson/vim-trailing-whitespace);

INDEX=0
for FOLDER in ${GITFOLDERS[@]}; do
	if [ ! -d "$FOLDER" ]; then
		URL=${GITURLS[INDEX]}
		git clone "$URL" "$FOLDER"
		((INDEX++))
		echo $FOLDER and $URL 
	else
		echo $FOLDER is already downloaded!
	fi
done

echo "All repos done! Accept with y - enter"

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

echo "pulling vcprompt for .bashrc!"
if [ ! -f ~/bin/vcprompt ]; then
       	curl -sL https://github.com/djl/vcprompt/raw/master/bin/vcprompt > ~/bin/vcprompt
	chmod 755 ~/bin/vcprompt
else
	echo "Vcprompt already exists!"
fi
echo "done pulling vcprompt and making it executable!"
