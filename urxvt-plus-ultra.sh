echo "========================================================================="
echo "Installing personal fork of rxvt."
echo "========================================================================="
echo ""

yes | git clone https://github.com/cyansprite/urxvt-plus-ultra
cd urxvt-plus-ultra
dash configure --enable-everything --enable-256-color
make
sudo make install
cd -
rm -rf urxvt-plus-ultra/
