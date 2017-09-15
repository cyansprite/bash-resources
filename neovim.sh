echo "========================================================================="
echo "Adding PPA"
echo "========================================================================="
echo ""

echo -ne '\n' | sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update

echo "========================================================================="
echo "Installing neovim, pythons, xsel, xvkbd, ctags, rxvt, and tmux"
echo "========================================================================="
echo ""
yes | sudo apt-get install neovim
yes | sudo apt-get install python-dev python-pip python3-dev python3-pip
yes | sudo apt-get install xsel
yes | sudo apt-get install xvkbd
yes | sudo apt-get install exuberant-ctags
yes | sudo apt-get install rxvt-unicode-256color
yes | sudo apt-get install tmux

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
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
echo -ne 0 | sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
echo -ne 0 | sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
echo -ne 0 | sudo update-alternatives --config editor
