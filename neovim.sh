echo "========================================================================="
echo "Cloning Neovim"
echo "========================================================================="
echo ""
git clone https://github.com/neovim/neovim.git
cd neovim
mkdir .deps
cd .dep
cmake ../third-party
make
cd ..
mkdir build
cd build
cmake ..
make
sudo make install
cd ../../
rm -rf neovim

echo "========================================================================="
echo "Installing neovim, pythons, xsel, tmux"
echo "========================================================================="
echo ""
yes | sudo apt-get install python3-dev python3-pip
yes | sudo apt-get install xsel
yes | sudo apt-get install tmux

yes | sudo apt-get install libncurses5-dev
tar zxf global-6.5.7.tar.gz
rm -rf global-6.5.7.tar.gz
cd global-6.5.7
./configure
make
sudo make install
cd -
rm -rf global-6.5.7

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
