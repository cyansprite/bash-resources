echo "========================================================================="
echo "Cloning Neovim"
echo "========================================================================="
echo ""
yes | lxk-apt install cmake
yes | lxk-apt install libtool
yes | lxk-apt install libtool-bin
yes | lxk-apt install m4
yes | lxk-apt install automake
yes | lxk-apt install gettext
rm -rf ~/neovim
mkdir ~/neovim
git clone https://github.com/neovim/neovim.git --depth 1
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
yes | lxk-apt install python3-dev python3-pip
yes | lxk-apt install xsel
yes | lxk-apt install tmux
yes | lxk-apt install libncurses5-dev

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
