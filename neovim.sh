echo "========================================================================="
echo "Adding PPA"
echo "========================================================================="
echo ""

yes | sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update

echo "========================================================================="
echo "Installing neovim, pythons, xsel and xvkbd"
echo "========================================================================="
echo ""
yes | sudo apt-get install neovim
yes | sudo apt-get install python-dev python-pip python3-dev python3-pip
yes | sudo apt-get install xsel
yes | sudo apt-get install xvkbd
yes | sudo apt-get install exuberant-ctags

echo "========================================================================="
echo "Installing pip modules for neovim"
echo "========================================================================="
echo ""
sudo -H pip install --upgrade pip
sudo -H pip3 install --upgrade pip
sudo -H pip install setuptools
sudo -H pip3 install setuptools
sudo -H pip install neovim
sudo -H pip3 install neovim
