echo "========================================================================="
echo "Cloning Neovim"
echo "========================================================================="
echo ""
sudo apt-get install cmake
sudo apt-get install libtool
sudo apt-get install libtool-bin
sudo apt-get install m4
sudo apt-get install automake
sudo apt-get install gettext
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
yes | sudo apt-get install python3-dev python3-pip
yes | sudo apt-get install xsel
yes | sudo apt-get install tmux
yes | sudo apt-get install libncurses5-dev

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
