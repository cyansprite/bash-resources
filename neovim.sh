echo "========================================================================="
echo "Cloning Neovim"
echo "========================================================================="
echo ""
# TODO deps needed on my main
rm -rf ~/neovim
mkdir ~/neovim
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_INSTALL_PREFIX=~/neovim
make install
cd ../
rm -rf neovim
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
sudo -H pip3 install --upgrade pip
sudo -H pip3 install --upgrade setuptools
sudo -H pip3 install --upgrade pynvim

echo "========================================================================="
echo "Updating Alternatives"
echo "========================================================================="
echo ""
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
echo -ne 0 | sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
echo -ne 0 | sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
echo -ne 0 | sudo update-alternatives --config editor

echo ""
echo "========================================================================="
echo "Done"
echo "========================================================================="
