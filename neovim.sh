echo "========================================================================="
echo "Cloning Neovim"
echo "========================================================================="
echo ""
yes | apt-get install cmake
yes | apt-get install libtool
yes | apt-get install libtool-bin
yes | apt-get install m4
yes | apt-get install automake
yes | apt-get install gettext
rm -rf ~/neovim
mkdir ~/neovim
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_INSTALL_PREFIX=~/neovim
make install
cd ../
rm -rf neovim
if [ ! -d ~/bin ] ; then
    mkdir ~/bin
fi
ln -fv ~/neovim/bin/nvim ~/bin/nvim

echo "========================================================================="
echo "Installing neovim, pythons, xsel, tmux"
echo "========================================================================="
echo ""
yes | apt-get install python3-dev python3-pip
yes | apt-get install xsel
yes | apt-get install tmux
yes | apt-get install libncurses5-dev

echo "========================================================================="
echo "Installing pip modules for neovim"
echo "========================================================================="
echo ""
pip3 install --upgrade --user pip
pip3 install --upgrade --user setuptools
pip3 install --upgrade --user pynvim

echo ""
echo "========================================================================="
echo "Done"
echo "========================================================================="
