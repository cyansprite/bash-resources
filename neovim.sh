echo "========================================================================="
echo "Adding PPA"
echo "========================================================================="

yes | sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update

echo "========================================================================="
echo "Installing neovim, pythons, and xsel"
echo "========================================================================="
yes | sudo apt-get install neovim
yes | sudo apt-get install python-dev python-pip python3-dev python3-pip
yes | sudo apt-get install xsel

echo "========================================================================="
echo "Installing pip modules for neovim"
echo "========================================================================="
sudo -H pip install --upgrade pip
sudo -H pip3 install --upgrade pip
sudo -H pip install setuptools
sudo -H pip3 install setuptools
sudo -H pip install neovim
sudo -H pip3 install neovim
